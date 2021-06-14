Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF913A68C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhFNOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbhFNOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:16:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:14:43 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsnLz-0086xp-Gz; Mon, 14 Jun 2021 14:14:15 +0000
Date:   Mon, 14 Jun 2021 14:14:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jhih Ming Huang <fbihjmeric@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, maqianga@uniontech.com,
        marcocesati@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
Message-ID: <YMdkN9cft6KHcFn3@zeniv-ca.linux.org.uk>
References: <20210613122858.1433252-1-fbihjmeric@gmail.com>
 <YMX7SRSPgvMA/Pw1@kroah.com>
 <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgboZ8QUQpiinL0xCxUmcp6nEVU20jXkDXbrK_QisUMiLEo1A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 12:40:27AM +0800, Jhih Ming Huang wrote:
> On Sun, Jun 13, 2021 at 8:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 13, 2021 at 08:28:58PM +0800, Jhih-Ming Huang wrote:
> > > This patch fixes the sparse warning of fix cast to restricted __le32.
> > >
> > > Last month, there was a change for replacing private CRC-32 routines with
> > > in-kernel ones.
> > > In that patch, we replaced getcrc32 with crc32_le in calling le32_to_cpu.
> > > le32_to_cpu accepts __le32 type as arg, but crc32_le returns unsigned int.
> > > That how it introduced the sparse warning.
> >
> > As crc32_le returns a u32 which is in native-endian format, how can you
> > cast it to le32?  Why do you cast it to le32?  Isn't that going to be
> > incorrect for big endian systems?
> >
> > thanks,
> >
> > greg k-h
> 
> Thanks for the fast reply.
> Yes, you are right. I did not notice that le32_to_cpu already handles
> both of the cases.
> 
> So it seems the warning from sparse is false positives, am I right?

In a sense that on all architectures we would be ever likely to support
le32_to_cpu and cpu_to_le32 do the same bit-shuffling - yes.  In a sense
of having those used correctly it's not a false positive, though - it's
much easier to follow "this variable always hold native-endian, this -
little-endian" and watch for conversions done correctly than to count
the byteswaps and try to prove that it's either even for all execution
histories or odd for all execution histories.

IOW, there's a good reason for keeping separate cpu_to_le32 and le32_to_cpu
and not mixing them with each other - it's easier to prove correctness that
way *and* easier to look for endianness bugs.
