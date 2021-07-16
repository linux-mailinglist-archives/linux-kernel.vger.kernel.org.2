Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F93CB0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 04:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhGPCUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 22:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhGPCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 22:20:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A9C06175F;
        Thu, 15 Jul 2021 19:17:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t186so12369553ybf.2;
        Thu, 15 Jul 2021 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzFD8deSpIF82vtstmuO6VWbyrhuzFl/J29D7XRCMAk=;
        b=inc9V1KH8aEiyfn31KxXZl4ez7Qdr+jj6KJIPVaOqVKu4uiT9U7eC3Yy+injev8tM7
         FaX8kyWazkj8Ro/dyDeX6q47FXgmJhGF0/jQRgnPMnJ1hUfcTCDMrUxTNEvIIK/YbOH3
         eCK7/fmYI2xK8jrd4a4HZKuUnUOyN9F/AV+cP0TcaOeO4tPYZFNexHIpPL3z9tWUrNq2
         INyqwHKBrfEEXzxzxHfMoLdWhqllPfHHZ/6qnBMzELpHC0Pckb5hnL0tR7K3NCHDkYC2
         Ru5idEiV8elJZW2yS+s/LZVGUL4ZsyWdUsFRolDnUqEb/jfk0SAZnhfQ9uhuhT6b4rEX
         L9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzFD8deSpIF82vtstmuO6VWbyrhuzFl/J29D7XRCMAk=;
        b=r3IIm/270pS9ncRfNDTTxqvX+8R+dK8EUAtrpR+lQA3W3dgdpldbw7traC25INdubt
         nPdmLh8j0tkPv84naPQOdAzvb8eSHL6dOaHe3Fm2JZWs+MPgarkG2j4dfV774gDlo31w
         lvQufcC+zejacLS0QfHoIJIle5a1u/dXsHXWXhipZncGjwuyYhYttMH5E+K3SajgIIXi
         UkRV/CTJX9ceC4IeAGyhQNgM7yaRK0/M0hXzqOVmu57Fm+UlH2TKHiuPOjU1H4YxGnxM
         7mjeJ32k65JLGvHQAjj97M+LXWvIU55xU7sG1fPPQAGMGOfzIFkkPiitgxh68GevfuM1
         IyxA==
X-Gm-Message-State: AOAM530NrA+jKPzAHY9MA+WrCRDNTEbdHomPWZjC7d1Dt8afWJf7NcnI
        QP3xIEgO7mmSt7IIccIDGs+oIGYvh2gMataHGrI=
X-Google-Smtp-Source: ABdhPJxadUYKFD/WgWos+BbybLpBn6YAco20OzKvWAAdIxTADz9WxT/jOGGdBqKi4VcbDJMEtzxT5158wfVWDyMpo3c=
X-Received: by 2002:a25:cf0f:: with SMTP id f15mr9430531ybg.229.1626401855030;
 Thu, 15 Jul 2021 19:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210713063018.3000459-1-drew@beagleboard.org>
In-Reply-To: <20210713063018.3000459-1-drew@beagleboard.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 16 Jul 2021 10:17:23 +0800
Message-ID: <CAEUhbmUg0DX__jSzjm1X_eCiHnkjHVXeq7CYLbW4xpydPS1G3g@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Wei Fu <tekkamanninja@gmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 2:34 PM Drew Fustini <drew@beagleboard.org> wrote:
>
> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> BeagleV Starlight JH7100 board [2].
>
> [1] https://github.com/starfive-tech/beaglev_doc
> [2] https://github.com/beagleboard/beaglev-starlight
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v4 changes:
> - removed JH7100 SoC revision number after discussion with Geert
>
> v3 changes:
> - added revision number for the board and soc after question from Palmer
>
> v2 changes:
> - removed "items:" entry that only had "const: starfive,jh7100"
> - correct typo in Description:
>
> Results of running checks:
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>     CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>     DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
>     SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>     DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>     CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
>     DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>     SYNC    include/config/auto.conf.cmd
>     UPD     include/config/kernel.release
>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dtb
>     DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>     DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>     DTC     arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>     CHECK   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml
>     CHECK   arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dt.yaml
>     CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>
> The dts file is from vendor repo and is being cleaned up right now in
> preperation for submitting to the mailing list:
> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
>
>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
