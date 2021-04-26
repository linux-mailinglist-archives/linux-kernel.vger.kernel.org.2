Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E0736BAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbhDZU1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhDZU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:27:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AACC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:26:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb7oe-000NkK-0C; Mon, 26 Apr 2021 22:26:48 +0200
Message-ID: <a847f3e65eaccf529a0e8b20a1284d73a671dae9.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Harald Arnesen <harald@skogtun.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Apr 2021 22:26:47 +0200
In-Reply-To: <28e21004-13ff-9d5f-0c5d-4c1e79cf628a@skogtun.org>
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
         <28e21004-13ff-9d5f-0c5d-4c1e79cf628a@skogtun.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 22:10 +0200, Harald Arnesen wrote:
> Linus Torvalds [26.04.2021 20:59]:
> 
> > There's a lockdep assertion there, but you don't seem to have lockdep
> > enabled. So it be interesting to see what happens if you
> > 
> >  (a) enable lockdep
> 
> At the risk of sounding stupid: where is this config option?

CONFIG_PROVE_LOCKING

I have no idea *where* it is either (in menuconfig or so), so if you're
in menuconfig, just hit / and enter PROVE_LOCKING. It'll come up with a
list of entries (probably only one) labeled (1), (2), ... Hit the number
key with the right number and menuconfig will take you there.

If you can't enable it, then you need DEBUG_KERNEL first.

But if you can e.g. switch to a VT (ctrl-alt-fn) and get a stackdump
shown on the screen while it hangs while shutting down (need to wait 2-3
minutes I guess), that's probably enough.

johannes

