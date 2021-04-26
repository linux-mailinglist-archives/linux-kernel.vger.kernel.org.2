Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5636BA22
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhDZTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbhDZTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:39:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FB5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:38:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb73s-000Mp5-Ue; Mon, 26 Apr 2021 21:38:29 +0200
Message-ID: <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Harald Arnesen <harald@skogtun.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Apr 2021 21:38:28 +0200
In-Reply-To: <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
         <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 19:29 +0000, Harald Arnesen wrote:
> > Which implies that it's likely something fairly specific to  your
> > setup (either the config or the hardware - or possibly Void Linux
> > doing something other distros don't).
> 
> Init system is runit, not systemd? Could that affect something?

Unlikely.

> > Mind also attaching a dmesg of an affected kernel (or with the revert
> > in place, I guess - it shouldn't matter until the reboot ;)
> 
> dmesg from 5.12 without the revert is attached.

That's it? There it just hangs? Not even printing something about tasks
getting stuck? Did you let it sit for a couple of (2-3) minutes to see
the task stuck warnings?

What's weird though is that this is evidently with mac80211 - so
certainly all the patches I just sent out will do nothing for you, and
something else is strange, because mac80211 I've definitely not just
reviewed but also tested these code paths many times.

Hmm. But yeah, either way, a lockdep report or stack dump will surely
help. Perhaps something in the ath* driver you're using that I missed.

> > There's a lockdep assertion there, but you don't seem to have lockdep
> > enabled. So it be interesting to see what happens if you
> > 
> >  (a) enable lockdep
> 
> Will report when I have tried it.

Thanks.

johannes

