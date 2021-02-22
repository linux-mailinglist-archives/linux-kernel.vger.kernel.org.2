Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD4321317
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBVJ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhBVJ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:27:46 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9317C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:27:05 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id w1so10170940ilm.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQLZEj9iN7V7Wa6Bf/Y6KrV0f8vrXo1b1Pd+1jqrTTY=;
        b=m9IJv5LUsBLiek3p4/0pXkCoDxek1CFJEIhFiAs9dS4NrAyPYJDpWdoZ8v73t06+u3
         Sj7KqGl8uu10Gl/C+inuFrTi0XWVzNTovOUG0gZRxiaqLiwjTn/qSJl/lRWq18ggfyQe
         piZONMWqCkfHQOEG/tLO9mH/tL+n2o3kmoyLmdnBGUSL9drUtHTC438bAYt35/eSP5NA
         lMpI5eH4hiAR8CZ0qsAk0LTwRgXUQxok2hMxWv7rKM8WqxWD83g73roCDx07/iygGXQq
         S+o2ain0CMtQXNrj7IjEfuyqiIcXFYyKO7GvxaRYnfYHkNGk4wDD0BDuIxymwom7HS4i
         8lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQLZEj9iN7V7Wa6Bf/Y6KrV0f8vrXo1b1Pd+1jqrTTY=;
        b=NarJq0J9UftE6hCsQJxP6uL2ZGyKUIY1Ug8HcD+2gi226I+xqLJB1uvsbHgelLXAtk
         02tGLn17W46/NWS2cp2Ui1xnY0BTSDGBBaelZ9FF4RwUCQsCKIccdI/yfPqtam9MS/Eu
         DWK2G6CzBhdI1Wjm6wLD4junxQTJQPGpz9q43OXkcY1tbkKe+mtU6x46vFV7Uv43OG3F
         dxtYb9Nt9Xujq1sUWVgJmdqQuAxi0QRY3YUKu7QvWYU/oYRVIeDnszm/WqvgrSJcWKKH
         3+HGd1S+tcb0V9WJZf6pQFiT5vEDR2WYzjW3MhOLDcEb0j+ATZJfiV+hp880CERb5lUh
         Rvaw==
X-Gm-Message-State: AOAM531wv/sGPzyPlBElgfyqvl4niZUDcT8LePTTge2n2ITkakry5zPP
        zl4s2XbMePeIzoqLgJgYq1XiW8p4muCkBOYV7gbe1Q==
X-Google-Smtp-Source: ABdhPJzs2A/nEMFlFND/SeVe0D5DWStliCbQoJqwBN9p7Oh1CHppoRpTveljZF82RVoV9hd+QrKyEkDwDVqGpAf5PxQ=
X-Received: by 2002:a05:6e02:1b0c:: with SMTP id i12mr14452264ilv.200.1613986024863;
 Mon, 22 Feb 2021 01:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20210218122546.3546582-1-gmouse@google.com> <CADKL2t6P4gaSUZEFgk7y+TNBRw0Lhf8mXTxzLdbe3FhGs0WH+w@mail.gmail.com>
 <CAP6Zq1jf4-XAhLQxqNx3LM7-YzDr8zaVPb-jznn8o=frxTotdQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1jf4-XAhLQxqNx3LM7-YzDr8zaVPb-jznn8o=frxTotdQ@mail.gmail.com>
From:   Anton Kachalov <gmouse@google.com>
Date:   Mon, 22 Feb 2021 10:26:53 +0100
Message-ID: <CADVsX89F6Tc0Zk6uB3CKRK0F8j_E+sVGHVb9FMAkHDQqJ+KBAQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton: Fix flash layout
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tom.

Yes, I'm using it for testing on real hardware.

BTW. Recent u-boot doesn't work with SD cards. The card doesn't
detect. The last working version was this one:

https://github.com/Nuvoton-Israel/nuvoton-info/tree/master/npcm7xx-poleg/evaluation-board/sw_deliverables/npcm7xx_v2.3

However, u-boot from igps repo:

https://github.com/Nuvoton-Israel/igps/tree/master/ImageGeneration/versions

Has issues too. It doesn't allow me to read more than 4k bytes once at
a time. Thus, to flash the stuff I have manually read chunks from the
SD-card: fat load doesn't work at all and I write that data in raw
partition.

On Sun, 21 Feb 2021 at 17:40, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Benjamin and Anton,
>
> Sorry for the late reply,
>
> The EVB FIU0-CS0 partitioning is used for testing the EVB and this is why it is different than the OpenBMC flash layout.
>
>
>
> Are you using the NPCM7XX EVB for OpenBMC? if yes we can consider to modify the flash partition to OpenBMC use.
>
>
> On Thu, 18 Feb 2021 at 19:11, Benjamin Fair <benjaminfair@google.com> wrote:
>>
>> On Thu, 18 Feb 2021 at 04:42, <gmouse@google.com> wrote:
>> >
>> > From: "Anton D. Kachalov" <gmouse@google.com>
>> >
>> > This change satisfy OpenBMC requirements for flash layout.
>> >
>> > Signed-off-by: Anton D. Kachalov <gmouse@google.com>
>> > ---
>> >  arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 28 +++++++----------------
>> >  1 file changed, 8 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>> > index bd1eb6ee380f..741c1fee8552 100644
>> > --- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>> > +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>> > @@ -182,8 +182,8 @@ bbuboot2@80000 {
>> >                                 reg = <0x0080000 0x80000>;
>> >                                 read-only;
>> >                                 };
>> > -                       envparam@100000 {
>> > -                               label = "env-param";
>> > +                       ubootenv@100000 {
>> > +                               label = "u-boot-env";
>> >                                 reg = <0x0100000 0x40000>;
>> >                                 read-only;
>> >                                 };
>> > @@ -195,25 +195,13 @@ kernel@200000 {
>> >                                 label = "kernel";
>> >                                 reg = <0x0200000 0x400000>;
>> >                                 };
>> > -                       rootfs@600000 {
>> > -                               label = "rootfs";
>> > -                               reg = <0x0600000 0x700000>;
>> > +                       rofs@780000 {
>> > +                               label = "rofs";
>> > +                               reg = <0x0780000 0x1680000>;
>> >                                 };
>> > -                       spare1@D00000 {
>> > -                               label = "spare1";
>> > -                               reg = <0x0D00000 0x200000>;
>> > -                               };
>> > -                       spare2@0F00000 {
>> > -                               label = "spare2";
>> > -                               reg = <0x0F00000 0x200000>;
>> > -                               };
>> > -                       spare3@1100000 {
>> > -                               label = "spare3";
>> > -                               reg = <0x1100000 0x200000>;
>> > -                               };
>> > -                       spare4@1300000 {
>> > -                               label = "spare4";
>> > -                               reg = <0x1300000 0x0>;
>> > +                       rwfs@1e00000 {
>> > +                               label = "rwfs";
>> > +                               reg = <0x1e00000 0x200000>;
>> >                         };
>>
>> I recommend just including the openbmc-flash-layout.dtsi file here
>> instead since that contains the common flash layout for most OpenBMC
>> systems.
>>
> Good solution,
> Do you mean nuvoton-openbmc-flash-layout?
>>
>> >                 };
>> >         };
>> > --
>> > 2.30.0.478.g8a0d178c01-goog
>> >
>
>
> Thanks,
>
> Tomer
