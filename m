Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF040CFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhIOWqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:46:11 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:58439 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhIOWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:43:45 -0400
Date:   Wed, 15 Sep 2021 22:42:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1631745741;
        bh=pAmIuVPKbq7xlzn31sYFI/isG8w/U8GGJ4v5onsDWC0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DLhldFRJ8CsC+qiaP/levzeqkXdIldnUige1c/rUeEs+mbNAD7D2usbL/xdw7Vmav
         OfWiLThJheIqdmVNyjS21r+Wj6MtQzoEUd0JmWBrInbQvnk1K3L3evHzSI9vcTC6Om
         VixLfArB7cNLJBWylpcE7lSqXoQNZOKPtT+qkzIM=
To:     ebiederm@xmission.com
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\@kvack.org" <linux-mm@kvack.org>,
        "legion\\@kernel.org" <legion@kernel.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
In-Reply-To: <87ee9pa6xw.fsf@disp2133>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <87ee9pa6xw.fsf@disp2133>
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

On Wednesday, September 15th, 2021 at 9:02 PM, <ebiederm@xmission.com> wrot=
e:

> Jordan Glover Golden_Miller83@protonmail.ch writes:
>
> > Hi, recently I hit system freeze after I was closing few containerized =
apps on my system. As for now it occurred only once on linux 5.14.3. I thin=
k it maybe be related to "Count rlimits in each user namespace" patchset me=
rged during 5.14 window
> >
> > https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c4284771.16=
19094428.git.legion@kernel.org/T/#u
>
> So that warning comes from:
>
> void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
>
> {
>
> struct ucounts *iter;
>
> for (iter =3D ucounts; iter; iter =3D iter->ns->ucounts) {
>
>     =09long dec =3D atomic_long_dec_if_positive(&iter->ucount[type]);
>
>     =09WARN_ON_ONCE(dec < 0);
>     }
>     put_ucounts(ucounts);
>
>
> }
>
> Which certainly looks like a reference count bug. It could also be a
>
> memory stomp somewhere close.
>
> Do you have any idea what else was going on? This location is the
>
> symptom but not the actual cause.
>
> Eric

I had about 2 containerized (flatpak/bubblewrap) apps (browser + music play=
er) running . I quickly closed them with intent to shutdown the system but =
instead get the freeze and had to use magic sysrq to reboot. System logs en=
d with what I posted and before there is nothing suspicious.

Maybe it's some random fluke. I'll reply if I hit it again.

Jordan
