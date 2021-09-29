Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA90941CE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbhI2Vk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:40:57 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:54028 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbhI2Vkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:40:53 -0400
Date:   Wed, 29 Sep 2021 21:39:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1632951548;
        bh=duxvwEonJV5YH8ELj8pJraEhvFw6SsRoN7ixGjyQf98=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=CuZxNca6xwHMoL5SlccHTzsDCFpIYs0b9U5cuWgpV24XiphzEuSrfi7/7m25G2aw2
         FYk30e3ZbKshhnY/wsQCj2pjZPtgJw3CcWWPBu4v0hqk0PuGL3AQmkBmyzkJKviBNr
         b77joSpce32h6UcPgcDlMfKEBhYh7myQcC1q1trg=
To:     Alexey Gladkov <legion@kernel.org>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\\\@kvack.org" <linux-mm@kvack.org>,
        "containers\\\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
In-Reply-To: <20210929173611.fo5traia77o63gpw@example.org>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch> <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch> <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch> <20210929173611.fo5traia77o63gpw@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 29th, 2021 at 5:36 PM, Alexey Gladkov <legion@kerne=
l.org> wrote:

> On Tue, Sep 28, 2021 at 01:40:48PM +0000, Jordan Glover wrote:
>
> > On Thursday, September 16th, 2021 at 5:30 PM, ebiederm@xmission.com wro=
te:
> >
> > > Jordan Glover Golden_Miller83@protonmail.ch writes:
> > >
> > > > On Wednesday, September 15th, 2021 at 10:42 PM, Jordan Glover Golde=
n_Miller83@protonmail.ch wrote:
> > > >
> > > > > I had about 2 containerized (flatpak/bubblewrap) apps (browser + =
music player) running . I quickly closed them with intent to shutdown the s=
ystem but instead get the freeze and had to use magic sysrq to reboot. Syst=
em logs end with what I posted and before there is nothing suspicious.
> > > > >
> > > > > Maybe it's some random fluke. I'll reply if I hit it again.
> > > >
> > > > Heh, it jut happened again. This time closing firefox alone had suc=
h
> > > >
> > > > effect:
> > >
> > > Ok. It looks like he have a couple of folks seeing issues here.
> > >
> > > I thought we had all of the issues sorted out for the release of v5.1=
4,
> > >
> > > but it looks like there is still some little bug left.
> > >
> > > If Alex doesn't beat me to it I will see if I can come up with a
> > >
> > > debugging patch to make it easy to help track down where the referenc=
e
> > >
> > > count is going wrong. It will be a little bit as my brain is mush at
> > >
> > > the moment.
> > >
> > > Eric
> >
> > As the issue persist in 5.14.7 I would be very interested in such patch=
.
> >
> > For now the thing is mostly reproducible when I close several tabs in f=
f then
> >
> > close the browser in short period of time. When I close tabs then wait =
out
> >
> > a bit then close the browser it doesn't happen so I guess some interrup=
ted
> >
> > cleanup triggers it.
>
> I'm still investigating, but I would like to rule out one option.
>
> Could you check out the patch?


Thx, I added it to my kernel and will report in few days.
Does this patch try to fix the issue or make it easier to track?

Jordan

> diff --git a/kernel/ucount.c b/kernel/ucount.c
>
> index bb51849e6375..f23f906f4f62 100644
>
> --- a/kernel/ucount.c
>
> +++ b/kernel/ucount.c
>
> @@ -201,11 +201,14 @@ void put_ucounts(struct ucounts *ucounts)
>
> {
>
> unsigned long flags;
>
> -         if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock,=
 flags)) {
>
>
>
> -         spin_lock_irqsave(&ucounts_lock, flags);
>
>
> -         if (atomic_dec_and_test(&ucounts->count)) {
>
>                   hlist_del_init(&ucounts->node);
>
>                   spin_unlock_irqrestore(&ucounts_lock, flags);
>                   kfree(ucounts);
>
>
> -                 return;
>           }
>
>
> -         spin_unlock_irqrestore(&ucounts_lock, flags);
>
>
>
> }
>
> static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
>
> ---------------------------------------------------------------------
>
> Rgrds, legion
