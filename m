Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9966D41B105
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhI1Nme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:42:34 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:35151 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI1Nmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:42:33 -0400
Date:   Tue, 28 Sep 2021 13:40:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1632836451;
        bh=goGNKPNGpmWN8xZiI0ePSv9y7ZFexCM2xLmGM1nxKSo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kkfouFtRMK3aepi1qqNdSoc/a4kHsRDzBVqc9ihvD94R7RCZ+osnCZg7wGaYEvvuW
         ORn3wFkg6v73WaZBVs53kK46hVjYo/ddzcLZWxVkLIs0F4BKTMZ8C9avhtUyuWkBo9
         oy52UHmUbliMKMtgqb8jCoqa20XdtsAXujDRXAOU=
To:     ebiederm@xmission.com
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\@kvack.org" <linux-mm@kvack.org>,
        "legion\\@kernel.org" <legion@kernel.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
In-Reply-To: <878rzw77i3.fsf@disp2133>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch> <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch> <878rzw77i3.fsf@disp2133>
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

On Thursday, September 16th, 2021 at 5:30 PM, <ebiederm@xmission.com> wrote=
:

> Jordan Glover Golden_Miller83@protonmail.ch writes:
>
> > On Wednesday, September 15th, 2021 at 10:42 PM, Jordan Glover Golden_Mi=
ller83@protonmail.ch wrote:
> >
> > > I had about 2 containerized (flatpak/bubblewrap) apps (browser + musi=
c player) running . I quickly closed them with intent to shutdown the syste=
m but instead get the freeze and had to use magic sysrq to reboot. System l=
ogs end with what I posted and before there is nothing suspicious.
> > >
> > > Maybe it's some random fluke. I'll reply if I hit it again.
> >
> > Heh, it jut happened again. This time closing firefox alone had such
> > effect:
>
> Ok. It looks like he have a couple of folks seeing issues here.
> I thought we had all of the issues sorted out for the release of v5.14,
> but it looks like there is still some little bug left.
>
> If Alex doesn't beat me to it I will see if I can come up with a
> debugging patch to make it easy to help track down where the reference
> count is going wrong. It will be a little bit as my brain is mush at
> the moment.
>
> Eric

As the issue persist in 5.14.7 I would be very interested in such patch.

For now the thing is mostly reproducible when I close several tabs in ff th=
en
close the browser in short period of time. When I close tabs then wait out
a bit then close the browser it doesn't happen so I guess some interrupted
cleanup triggers it.

Jordan
