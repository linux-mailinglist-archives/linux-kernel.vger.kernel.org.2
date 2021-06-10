Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A73A25B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFJHpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:45:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:42:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e2so3514744ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nD/SNC6NVCs/sWxmCQJefiLLvu6EadAnjK1Wh6Svdms=;
        b=BPJgUprMaQzUOjfyybkxPPBz6BC0wmzbTOwr/H9vYqYqL5vLOpO0bMiIqNkvq53uiP
         CBig3fu4Q6VN77iusct5xiYtxK7H6Rk9OqQStXuH1njulronMIXAXwZoBf5f3RUVtfmY
         0mGIvcFVylEq7ucX3m/hFEVyOJB3Cm8U4KHYV1/JRlejKLUPKzKw1voIyylmAajC3BzP
         FGTb59Lsj0wsfm7FzofPcIimK88VSDL0BSrY7QNybxJL2J7uRKLu4rDxFLuGe5rqsPR0
         swlZOKI0K3u+mmwtcdT3OJmey4tk5wIQEq9FKspruMXW439KGSz4mOKT6Dfh0F6zEceN
         24JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nD/SNC6NVCs/sWxmCQJefiLLvu6EadAnjK1Wh6Svdms=;
        b=VndG/GHpBQ9L29wZChaTNbO9JRORm621XJlyJ2I8defZ2ApwSqkps6dmHy0txylqig
         bJfo/MK47SL6T+i/BtUYAEntPIuXLY80tC8iLH7AFPUrh7w4GAhBEIc1SGIbkiYDe8XM
         EORoo51JeB+Kuyn12bnmqSxpGXQdSzVzSVmfXBtSvAO00u2VNPb3/U56EoyvTYpGJC4T
         G+Oi+hb2aB1u0Q2FJvX6QH/0kvhdHtEaW+BPjz2v/vaoUaL2bjXHxVzTrjrtG1PqqfL9
         EG+dkfjveL3EkxaiHEYJKxSqGt6D338raCu7eBGUHL2HeLlQhliY9+057Vf4EJp3JPpr
         XtEg==
X-Gm-Message-State: AOAM532GhCm+S9Gnxn9zNrMdMabtI9HBiABEgYLQHmRx+SP6CYBnt/WW
        26nS6oJdwc8vtJOVgVfRk805v3XNY1Ma2IatuTca2eqbijq3AA==
X-Google-Smtp-Source: ABdhPJyXhabeLAQSzXLdpxot6oEBf9s+Ejiy3KIKqyPwPONWBBchwfH6Rkn4jWOTNlrhnx7hSeTEShA7rBzG8f91NBg=
X-Received: by 2002:a2e:2f03:: with SMTP id v3mr1150527ljv.168.1623310970633;
 Thu, 10 Jun 2021 00:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <1620716925-4329-1-git-send-email-bnf20061983@gmail.com>
 <aac6c6a3-6666-075a-6901-7e3c3b2ae01d@linaro.org> <1623120924545.61863@unisoc.com>
 <cde99078-c13d-4454-cdcb-990239571ecc@linaro.org>
In-Reply-To: <cde99078-c13d-4454-cdcb-990239571ecc@linaro.org>
From:   NFBAI <bnf20061983@gmail.com>
Date:   Thu, 10 Jun 2021 15:41:45 +0800
Message-ID: <CAH2vER-LiXzHXpaXT6W=LEPd9gKaPMPnJ5Wt_-Gk1dM5Q6Sdrg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_clocksource=2Fdrivers=2Fsprd=3A_Remove?=
        =?UTF-8?Q?_the_dependency_between_sprd_timer_and_SPRD_arch?=
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     =?UTF-8?B?5p+P5bm056aPIChOaWFuZnUgQmFpKQ==?= 
        <nianfu.bai@unisoc.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg55Ge5bOwIChSdWlmZW5nIFpoYW5nLzEwMDQwKQ==?= 
        <Ruifeng.Zhang1@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=88=
8=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=888:08=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> Nianfu,
>
> On 08/06/2021 04:55, =E6=9F=8F=E5=B9=B4=E7=A6=8F (Nianfu Bai) wrote:
> > On 11/05/2021 09:08, Nianfu Bai wrote:
> >> From: Nianfu Bai <nianfu.bai@unisoc.com>
> >>
> >> Tick broadcast installed by insmod cannot switch to oneshot mode corre=
ctly
> >> caused by linux timer framework, need to build in kernel image.
> >
> > What timer is compiled as a module?
> >> We want to compile sprd timer  as a module.
> >
> > Why the timer framework does not allow to switch to it ?
> >> Pls refer to the patch description deblow:
> > https://lore.kernel.org/lkml/161860007587.29796.7100262021118685563.tip=
-bot2@tip-bot2/
>
> Thanks for the pointer I understand the bug.
>
> However the description does not refer to this fix. It tells the timer
> is a module and then tells it depends on the sprd arch.
>
> What are the connection between all these points?
As https://lore.kernel.org/lkml/161860007587.29796.7100262021118685563.tip-=
bot2@tip-bot2/
description, sprd timer can not build as a module, we have to build
sprd timer in kernel image, but the sprd timer is depend on sprd arch,
we do not want to enable sprd arch config when build sprd timer in
kernel image, so we need to remove the dependency between sprd timer
and sprd arch.


>
> On the other side, the email format is not text, replies are not
> correctly put inline, it is hard to follow the discussion.
>
> Please, take the time to read the documentation about submitting patches
> [1] and then provide a clear Changelog, no need to refer the timer is
> loaded after because it is a module, the Kconfig says the opposite.
>
> Thanks
>
>   -- Daniel
>
> [1] Documentation/process/*
>
> >> SPRD_TIMER
> >> has been selected by SPRD arch, we have to enable SPRD arch when we bu=
ild
> >> sprd timer in kernel image, this action conflicts with general kernel =
image,
> >
> > Why this is conflicting with general kernel image?
> >
> >> so we need to remove the dependency between sprd timer and SPRD arch.
> >
> > Can you rephrase the changelog, I'm not getting the point.
> >
> >> Signed-off-by: Nianfu Bai <nianfu.bai@unisoc.com>
> >> Signed-off-by: Ruifeng Zhang <ruifeng.zhang1@unisoc.com>
> >> ---
> >>  drivers/clocksource/Kconfig | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >> index 39aa21d..04b333c 100644
> >> --- a/drivers/clocksource/Kconfig
> >> +++ b/drivers/clocksource/Kconfig
> >> @@ -447,10 +447,8 @@ config MTK_TIMER
> >>         Support for Mediatek timer driver.
> >>
> >>  config SPRD_TIMER
> >> -     bool "Spreadtrum timer driver" if EXPERT
> >> +     bool "Spreadtrum timer driver" if COMPILE_TEST
> >>       depends on HAS_IOMEM
> >> -     depends on (ARCH_SPRD || COMPILE_TEST)
> >> -     default ARCH_SPRD
> >>       select TIMER_OF
> >>       help
> >>         Enables support for the Spreadtrum timer driver.
> >>
> >
> >
> > --
> > <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for =
ARM SoCs
> >
> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > <http://twitter.com/#!/linaroorg> Twitter |
> > <http://www.linaro.org/linaro-blog/> Blog
> > ________________________________
> >  This email (including its attachments) is intended only for the person=
 or entity to which it is addressed and may contain information that is pri=
vileged, confidential or otherwise protected from disclosure. Unauthorized =
use, dissemination, distribution or copying of this email or the informatio=
n herein or taking any action in reliance on the contents of this email or =
the information herein, by anyone other than the intended recipient, or an =
employee or agent responsible for delivering the message to the intended re=
cipient, is strictly prohibited. If you are not the intended recipient, ple=
ase do not read, copy, use or disclose any part of this e-mail to others. P=
lease notify the sender immediately and permanently delete this e-mail and =
any attachments if you received it in error. Internet communications cannot=
 be guaranteed to be timely, secure, error-free or virus-free. The sender d=
oes not accept liability for any errors or omissions.
> > =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=
=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=
=E5=BE=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=
=BB=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=
=87=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=
=E9=9D=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=
=BC=A0=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=
=E8=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=
=8B=BF=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=
=94=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=
=BB=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=
=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=
=B0=B8=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=
=8A=E6=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=
=E5=A4=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=
=91=8A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=
=9D=E8=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=
=E3=80=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=
=AF=92=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=
=99=E6=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
