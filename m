Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473563A6CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhFNRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhFNRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:05:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:03:49 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lspzw-0089t0-Fc; Mon, 14 Jun 2021 17:03:40 +0000
Date:   Mon, 14 Jun 2021 17:03:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jhih Ming Huang <fbihjmeric@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
Message-ID: <YMeL7PjstV601pbN@zeniv-ca.linux.org.uk>
References: <20210613122858.1433252-1-fbihjmeric@gmail.com>
 <YMX7SRSPgvMA/Pw1@kroah.com>
 <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
 <YMdkN9cft6KHcFn3@zeniv-ca.linux.org.uk>
 <CAKgboZ9P2afm7-eOE3COrKVDkFZ_g288KfJAyQiwzC6fN75VmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgboZ9P2afm7-eOE3COrKVDkFZ_g288KfJAyQiwzC6fN75VmA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:27:03PM +0800, Jhih Ming Huang wrote:

> Thanks for your explanation.
> 
> To clarify, even though it might be false positives in some senses,
> following "hold the variable native-endian and check the conversion
> done correctly"
> is much easier than the other way. And it's exactly the current implementation.
> 
> So it's better to keep the current implementation and ignore the
> warnings, right?

Umm...  If that's the case, the warnings should go away if you use
cpu_to_le32() for conversions from native to l-e and le32_to_cpu()
for conversions from l-e to native.

IOW, the choice between those should annotate what's going on.

In your case doing
	*((u32 *)crc) = le32_to_cpu((__force __le32)~crc32_le(~0, payload, length - 4));
is wrong - you have
crc32_le(...) native-endian
~crc32_le(...) - ditto
le32_to_cpu(~crc32_le(...)) - byteswapped native-endian on b-e, unchanged on
l-e.  So result will be little-endian representation of ~crc32(...) in all
cases.  IOW, it's cpu_to_le32(~crc32_le(...)), misannotated as native-endian
instead of little-endian it actually is.

Then you store that value (actually __le32) into *(u32 *)crc.  Seeing that
crc is u8[4] there, that *(u32 *) is misleading - you are actually storing
__le32 there (and, AFAICS, doing noting with the result).  The same story
in rtw_tkip_decrypt(), only there you do use the result later.

So just make it __le32 crc and
	crc = cpu_to_le32(~crc32_le(~0, payload, length - 4));
with
			if (crc[3] != payload[length - 1] || crc[2] != payload[length - 2] ||
			    crc[1] != payload[length - 3] || crc[0] != payload[length - 4])
turned into
			if (memcmp(&crc, payload + length - 4, 4) != 0)
(or (crc != get_unaligned((__le32 *)(payload + length - 4))),
for that matter, to document what's going on and let the damn thing
pick the optimal implementation for given architecture).

Incidentally, your secmicgetuint32() is simply get_unaligned_le32()
and secmicputuint32() - put_unaligned_le32().  No need to reinvent
that wheel...

