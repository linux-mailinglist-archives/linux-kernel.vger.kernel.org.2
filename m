Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F63E09AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhHDUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbhHDUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 16:54:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167F5C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:54:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso4789508wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTlzgcaP7CJ5Drm1mPHCLgsz9Hlf36Or5slblqneVQM=;
        b=c6BgCdohRV0iWQqB58O5ALsq1I8vbunpNRAQDwOWwmENdtxXYrWH0J/NxQh6iEBnih
         FMaeXBSly9wJj7YxMacQWOGfK6z5Zp3Un1wmTpyL0Toq2FRSPO6EZSvAOcBlBVRF2VVK
         hhXk3mJX3uKYdV7Msd4L0C3DKjmGfoDICnhpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTlzgcaP7CJ5Drm1mPHCLgsz9Hlf36Or5slblqneVQM=;
        b=qpqs1aj8aHRcCKVrNltLNFYUt5jPKnQWnFSbj63ILg9TNRmSDQu1p2seO6wFM8JDOn
         yesrGxEDEK2A1BzDPKFs/K8+cBFb1hEEmIPFshoFxoTSsBywBQ/cSTL1y2rjHl4UgE4m
         PKu5xcIIG2ui04TiThdQXUrPgRvfJKcV4U2QM6pxE7JUgo8v1wzl9qRoKV9iKdO8dYHF
         a4BtJlnwJz9HWMGbuVQ6dgcnjVXcDwEdnwM9+2WQ8ooPT9A5xFF7fNe5Q7hn/H0p4J4r
         EnuVzYcoc1kdxtHXQ4pAlYghiEQBRUvo6k77250e2mVbZLWwvrvf6QmwX1xmGvEvE+fO
         hXfg==
X-Gm-Message-State: AOAM533hWobh4MjRPBF9Ngns5tDd/wKq2a0dvrKSvuOBG0YIws1qAhDE
        JW9QWe98gtTvoblFQc/FI1U8x4NODxDSUmxWHUL5
X-Google-Smtp-Source: ABdhPJzFcX4DJR524QVh9tXD3+bk4SgtYMhEgErLPZNSn3oe5dfHlCAkP0/FSmqZixbsxDX/qk8QR3fTG7jVJ8Qr3ds=
X-Received: by 2002:a1c:413:: with SMTP id 19mr1327972wme.74.1628110467680;
 Wed, 04 Aug 2021 13:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmUg0DX__jSzjm1X_eCiHnkjHVXeq7CYLbW4xpydPS1G3g@mail.gmail.com>
 <mhng-a2fd6094-0ae8-4f7b-9dee-fd71b85b29f1@palmerdabbelt-glaptop>
In-Reply-To: <mhng-a2fd6094-0ae8-4f7b-9dee-fd71b85b29f1@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 4 Aug 2021 13:54:16 -0700
Message-ID: <CAOnJCUL9uU5G1LOgfYPz9Ny77yFYaP5sgtdxG3_w=Zcsi+f96Q@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Bin Meng <bmeng.cn@gmail.com>, Drew Fustini <drew@beagleboard.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, Wei Fu <tekkamanninja@gmail.com>,
        jack.zhu@starfivetech.com, leyfoon.tan@starfivetech.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Emil Renner Berhing <kernel@esmil.dk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 1:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 15 Jul 2021 19:17:23 PDT (-0700), bmeng.cn@gmail.com wrote:
> > On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
> >>
> >> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> >> BeagleV Starlight JH7100 board [2].
> >>
> >> [1] https://github.com/starfive-tech/beaglev_doc
> >> [2] https://github.com/beagleboard/beaglev-starlight
> >>
> >> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> >> ---
> >> v4 changes:
> >> - removed JH7100 SoC revision number after discussion with Geert
> >>
> >> v3 changes:
> >> - added revision number for the board and soc after question from Palmer
> >>
> >> v2 changes:
> >> - removed "items:" entry that only had "const: starfive,jh7100"
> >> - correct typo in Description:
> >>
> >> Results of running checks:
> >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
> >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> >>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> >>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
> >>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> >>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> >>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> >>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
> >>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
> >>     SYNC    include/config/auto.conf.cmd
> >>     UPD     include/config/kernel.release
> >>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
> >>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> >>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> >>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
> >>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
> >>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> >>
> >> The dts file is from vendor repo and is being cleaned up right now in
> >> preperation for submitting to the mailing list:
> >> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> >>
> >>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> >>
> >
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>
> Thanks.  This is on for-next, as Rob suggested taking it via the RISC-V
> tree.
>
Given that beagleV starlight mass production is cancelled [1], are we
still upstreaming the support for this ?

[1] https://www.cnx-software.com/2021/07/31/beaglev-starlight-sbc-wont-be-mass-manufactured-redesigned-beaglev-risc-v-sbc-expected-in-q1-2022/
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
