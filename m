Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1132E321408
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBVKWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhBVKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:22:30 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F8C061574;
        Mon, 22 Feb 2021 02:21:49 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c8so56323138ljd.12;
        Mon, 22 Feb 2021 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6ozJjneRabHXv2bJQnWDUhKBZTUbxonhN/ndy66ScQ=;
        b=m+tnZAIMAohvoUNMEHfgprl8itqN+gc/cVZzermBq/PG/4fJW2AowK93jm5xJO8X2H
         jVLLMFpBO1zKDUe1e1cRWlCr1Ojv+yDbc6AwOinwpSc8qdTQyOZk4j7HWju6rSkTD3sr
         a/06PwQWJHTrtUILTfVoMYp7OVSCxLkdpLjI+1NirpEUa3gC1HMfnxky8QwmgXh99kSl
         1msRyhgS3WUUf5iRmHrlResp/VK/nst+BUMSOxXGlFMF2CFj8IeIRm0V/2GupJjMqqwt
         FTywReA7ItnA1GjPi35eZv+6ePI8dcgZGDUFyW3xZ7LIYYsBXznJE86uCYI33SpHKFzj
         FcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6ozJjneRabHXv2bJQnWDUhKBZTUbxonhN/ndy66ScQ=;
        b=Lr7lnoHANErClxow0iDpMdCZ37FmZLqWG1ii7skKrs7Ve2CVmlpjv3G9hDsiQDfAPQ
         QpMAdgxgPp6q6JFMK4scZMSooFX/1TLxkHPaE0N6xobDFSnqW6RT3PIHTnceFEMwfX97
         STSq085zl3glo2ZGUji+iteEFc1Xk5YjGoK2D3LrYVJ20cEW5HtTfUXPAXgdbWZARy+P
         9Z9djKLxQdj2040ubqPZfgtqRjbFglk9LqMir/S6uzi16ZGIqdfm5ExrZFrY8xy5/trg
         1ONnDVREY8+dkjCGoViwgcDO/eixOPMCy44gjeAjM6KUgDzx6FxF8oOSx3d0kioZEc8F
         b2sw==
X-Gm-Message-State: AOAM533kYBU5Hzl/8Hhzydr1pC6CWju6CRscI+MCI4cQXXuBxONlpbZQ
        KvePKrq/YkvljrFlnr4GyXOkk7cxwhQwivc/aQ==
X-Google-Smtp-Source: ABdhPJzsEEWoLbBg5I0ftLDK0NHbzwQj/KQ0OcV4niW5UWFXWW4CI7QgmovSbKlfYZntoJvksNQz52A6rERxlvHd8C8=
X-Received: by 2002:a2e:95ce:: with SMTP id y14mr9431022ljh.80.1613989308331;
 Mon, 22 Feb 2021 02:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20210218122546.3546582-1-gmouse@google.com> <CADKL2t6P4gaSUZEFgk7y+TNBRw0Lhf8mXTxzLdbe3FhGs0WH+w@mail.gmail.com>
 <CAP6Zq1jf4-XAhLQxqNx3LM7-YzDr8zaVPb-jznn8o=frxTotdQ@mail.gmail.com> <CADVsX89F6Tc0Zk6uB3CKRK0F8j_E+sVGHVb9FMAkHDQqJ+KBAQ@mail.gmail.com>
In-Reply-To: <CADVsX89F6Tc0Zk6uB3CKRK0F8j_E+sVGHVb9FMAkHDQqJ+KBAQ@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 22 Feb 2021 12:21:24 +0200
Message-ID: <CAKKbWA7WL80C9h9xPcBNAHn-1=NBK9dh2Nqa1hO21hbdLEUbTw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton: Fix flash layout
To:     Anton Kachalov <gmouse@google.com>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ofer.eilon@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ofer,

Can you check why u-boot doesn't work with SD cards?

On Mon, Feb 22, 2021 at 11:27 AM Anton Kachalov <gmouse@google.com> wrote:
>
> Hi, Tom.
>
> Yes, I'm using it for testing on real hardware.
>
> BTW. Recent u-boot doesn't work with SD cards. The card doesn't
> detect. The last working version was this one:
>
> https://github.com/Nuvoton-Israel/nuvoton-info/tree/master/npcm7xx-poleg/evaluation-board/sw_deliverables/npcm7xx_v2.3
>
> However, u-boot from igps repo:
>
> https://github.com/Nuvoton-Israel/igps/tree/master/ImageGeneration/versions
>
> Has issues too. It doesn't allow me to read more than 4k bytes once at
> a time. Thus, to flash the stuff I have manually read chunks from the
> SD-card: fat load doesn't work at all and I write that data in raw
> partition.
>
> On Sun, 21 Feb 2021 at 17:40, Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Hi Benjamin and Anton,
> >
> > Sorry for the late reply,
> >
> > The EVB FIU0-CS0 partitioning is used for testing the EVB and this is why it is different than the OpenBMC flash layout.
> >
> >
> >
> > Are you using the NPCM7XX EVB for OpenBMC? if yes we can consider to modify the flash partition to OpenBMC use.
> >
> >
> > On Thu, 18 Feb 2021 at 19:11, Benjamin Fair <benjaminfair@google.com> wrote:
> >>
> >> On Thu, 18 Feb 2021 at 04:42, <gmouse@google.com> wrote:
> >> >
> >> > From: "Anton D. Kachalov" <gmouse@google.com>
> >> >
> >> > This change satisfy OpenBMC requirements for flash layout.
> >> >
> >> > Signed-off-by: Anton D. Kachalov <gmouse@google.com>
> >> > ---
> >> >  arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 28 +++++++----------------
> >> >  1 file changed, 8 insertions(+), 20 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> >> > index bd1eb6ee380f..741c1fee8552 100644
> >> > --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> >> > +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> >> > @@ -182,8 +182,8 @@ bbuboot2@80000 {
> >> >                                 reg = <0x0080000 0x80000>;
> >> >                                 read-only;
> >> >                                 };
> >> > -                       envparam@100000 {
> >> > -                               label = "env-param";
> >> > +                       ubootenv@100000 {
> >> > +                               label = "u-boot-env";
> >> >                                 reg = <0x0100000 0x40000>;
> >> >                                 read-only;
> >> >                                 };
> >> > @@ -195,25 +195,13 @@ kernel@200000 {
> >> >                                 label = "kernel";
> >> >                                 reg = <0x0200000 0x400000>;
> >> >                                 };
> >> > -                       rootfs@600000 {
> >> > -                               label = "rootfs";
> >> > -                               reg = <0x0600000 0x700000>;
> >> > +                       rofs@780000 {
> >> > +                               label = "rofs";
> >> > +                               reg = <0x0780000 0x1680000>;
> >> >                                 };
> >> > -                       spare1@D00000 {
> >> > -                               label = "spare1";
> >> > -                               reg = <0x0D00000 0x200000>;
> >> > -                               };
> >> > -                       spare2@0F00000 {
> >> > -                               label = "spare2";
> >> > -                               reg = <0x0F00000 0x200000>;
> >> > -                               };
> >> > -                       spare3@1100000 {
> >> > -                               label = "spare3";
> >> > -                               reg = <0x1100000 0x200000>;
> >> > -                               };
> >> > -                       spare4@1300000 {
> >> > -                               label = "spare4";
> >> > -                               reg = <0x1300000 0x0>;
> >> > +                       rwfs@1e00000 {
> >> > +                               label = "rwfs";
> >> > +                               reg = <0x1e00000 0x200000>;
> >> >                         };
> >>
> >> I recommend just including the openbmc-flash-layout.dtsi file here
> >> instead since that contains the common flash layout for most OpenBMC
> >> systems.
> >>
> > Good solution,
> > Do you mean nuvoton-openbmc-flash-layout?
> >>
> >> >                 };
> >> >         };
> >> > --
> >> > 2.30.0.478.g8a0d178c01-goog
> >> >
> >
> >
> > Thanks,
> >
> > Tomer



-- 
Regards,
Avi
