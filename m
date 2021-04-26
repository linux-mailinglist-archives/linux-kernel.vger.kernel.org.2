Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0748036BA98
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbhDZUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbhDZUMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:12:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:11:48 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb7a6-000NRt-8D; Mon, 26 Apr 2021 22:11:46 +0200
Message-ID: <bca302812cece1972bed7efe34a9d554b9e912ed.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Harald Arnesen <harald@skogtun.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Apr 2021 22:11:45 +0200
In-Reply-To: <CAHk-=wiwByiEUuO-NN=xHb4sxwCmP=tjB_vUHEebj8+-JGu8zg@mail.gmail.com> (sfid-20210426_215145_178898_2C6EEF9D)
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
         <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
         <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
         <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com>
         <2cafd6d0c6378b36644d04fe263a53a866354574.camel@sipsolutions.net>
         <CAHk-=wiwByiEUuO-NN=xHb4sxwCmP=tjB_vUHEebj8+-JGu8zg@mail.gmail.com>
         (sfid-20210426_215145_178898_2C6EEF9D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-26 at 12:51 -0700, Linus Torvalds wrote:
> On Mon, Apr 26, 2021 at 12:46 PM Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > 
> > Right. Maybe if it's modules, could try to remove them rather than
> > reboot?
> 
> Yes, doing an 'rmmod ath9k'  (or whatever that module is called)
> sounds like a good idea, it might trigger the same lockup.
> 
> In fact, that might be the reason Harald sees this - maybe Void Linux
> tries to unload modules before rebooting, and other distros don't?

Seems odd if they would, but maybe?

I guess we're well into speculation here now - Harald, even taking a
picture of a stack dump will help, I'll likely only need an indication
where it's actually locking up, unless it's actually in
cfg80211_destroy_iface_wk() itself, but I can't see how that'd be
possible.

Looks like with mac80211 this really should just go down into
ieee80211_if_remove() and that looks OK.

And it's coming from a work struct, so I thought maybe some flushing
happened in a bad context, but that's only in wiphy_unregister(),
without the lock(s) held around it, as it should be. I figured then
maybe wiphy_unregister() could be called in a bad context, but then that
would've deadlocked itself earlier, unrelated to the destroy_iface_wk().


Oh, I have another idea - maybe void linux is using iwd instead of
wpa_supplicant, and that insists on doing the netlink owner stuff so
everything is deleted in case it crashes. But I've been looking at the
code pretty much assuming that we get actual calls down, so ...


Dunno. I don't see anything obvious right now, any additional
information (stack dump, or lockdep report) would be great.

johannes

