Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6941CB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbhI2Rh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244721AbhI2Rh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:37:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE7C61425;
        Wed, 29 Sep 2021 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632936975;
        bh=j1CsznRTMXpjsShtriwNxPC6pmRqXDzujQrZsSfAeM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=raZU/HDY5k5IUjQfPl0oibiW+mRVehapURJDZjKDx73YawoM+fgRBSrK1uAYWxJ0i
         IAHX2BVJNrOeGd/X91LQcf/E0c2CrL5URKptUUZivm/TLAA4xCR7lTCVSsPUfzL57D
         RsVF89GQfHzg5rB7/XQPF7jrxKIs690Jj5mMhERivRxVhYuLEl3qQhqelHLtZAYkdW
         Rtuecv3oR1Y53pRMEmTpf+8XvQxVgbngc23NtWv06Fw/B7XppGiyo7reG4wE75BC46
         siMxvMJFdUl9fefBXwEK9THRNemZiGHGMEyrv6EuJ0a1xRH9z/YBVR5Si4wC0IHvDe
         oyRbpTmbIMc1A==
Date:   Wed, 29 Sep 2021 19:36:11 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\@kvack.org" <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <20210929173611.fo5traia77o63gpw@example.org>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133>
 <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133>
 <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 01:40:48PM +0000, Jordan Glover wrote:
> On Thursday, September 16th, 2021 at 5:30 PM, <ebiederm@xmission.com> wrote:
> 
> > Jordan Glover Golden_Miller83@protonmail.ch writes:
> >
> > > On Wednesday, September 15th, 2021 at 10:42 PM, Jordan Glover Golden_Miller83@protonmail.ch wrote:
> > >
> > > > I had about 2 containerized (flatpak/bubblewrap) apps (browser + music player) running . I quickly closed them with intent to shutdown the system but instead get the freeze and had to use magic sysrq to reboot. System logs end with what I posted and before there is nothing suspicious.
> > > >
> > > > Maybe it's some random fluke. I'll reply if I hit it again.
> > >
> > > Heh, it jut happened again. This time closing firefox alone had such
> > > effect:
> >
> > Ok. It looks like he have a couple of folks seeing issues here.
> > I thought we had all of the issues sorted out for the release of v5.14,
> > but it looks like there is still some little bug left.
> >
> > If Alex doesn't beat me to it I will see if I can come up with a
> > debugging patch to make it easy to help track down where the reference
> > count is going wrong. It will be a little bit as my brain is mush at
> > the moment.
> >
> > Eric
> 
> As the issue persist in 5.14.7 I would be very interested in such patch.
> 
> For now the thing is mostly reproducible when I close several tabs in ff then
> close the browser in short period of time. When I close tabs then wait out
> a bit then close the browser it doesn't happen so I guess some interrupted
> cleanup triggers it.

I'm still investigating, but I would like to rule out one option.
Could you check out the patch?

diff --git a/kernel/ucount.c b/kernel/ucount.c
index bb51849e6375..f23f906f4f62 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -201,11 +201,14 @@ void put_ucounts(struct ucounts *ucounts)
 {
        unsigned long flags;

-       if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
+       spin_lock_irqsave(&ucounts_lock, flags);
+       if (atomic_dec_and_test(&ucounts->count)) {
                hlist_del_init(&ucounts->node);
                spin_unlock_irqrestore(&ucounts_lock, flags);
                kfree(ucounts);
+               return;
        }
+       spin_unlock_irqrestore(&ucounts_lock, flags);
 }

 static inline bool atomic_long_inc_below(atomic_long_t *v, int u)

-- 
Rgrds, legion

