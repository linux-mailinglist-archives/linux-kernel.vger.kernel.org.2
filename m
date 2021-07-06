Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24A3BDFB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 01:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhGFXTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 19:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhGFXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 19:19:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FB5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 16:16:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso466716pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 16:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vhWcX4wZI8Gd9j2rinjQwhp8HvDxjLKtRKdl01al6B4=;
        b=qA3fpEsAe6jsvhZqMAy6cwl8yXzdWfXG00y18wEaoGed37IU/nSfIFlFZLqJ+/lVHW
         mi8cOgkmwjFMQMYZ174Wqm+ZObPLCa7TZadgFajCo+wukrWzsWmRSiOQs7+sOtOjGzCK
         oTPhS5XuCMSwsSjJNI0wLlaZHxqserpJlr1ywLWTf9+B6EYGmwMZ/9oyDCYKSLd+wYFv
         37T/s1Kz9X5nVDp1MncjRkNMgW1lHoPZA2Tnc7HLhFE8xFJmS3gehdrBXMG4hup/4aIw
         LC+VBRzu32Ox/V2hhCnsFFaRGNVgb35g9NVckInof+vYLHfMpI98JywoK0zdTIMCnfPH
         NM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vhWcX4wZI8Gd9j2rinjQwhp8HvDxjLKtRKdl01al6B4=;
        b=Jixsm3N2nUSyOdBRIvI8p9n9TU12rW8ExjMroVm9QoogAS/Qv4q0xh+oxRuMSuM7AS
         Ax1qPtO9rro5fx09y7MjPpR31wxbcpFYdbaZfRlcefcitBYkRYNvxlDGcQKAaUNGzm60
         jcpoqDEe6D+qm52bAfgAv2DJy3aMpbuXMJ9OymlpFUs/aBa8zjsB+1BpcXEm8oi9pEu7
         2GN+ABhcFFXI4jilezXmezyQOnDl239WqxUdS/CwfvVWnTzvp1XwHz9Er7zbegqCHZYd
         O/jLWZwussr0cJDNYw3MjvGMSnESxIG5Ytz8rpqxBBfA5fTfEceEXs8GTkqhZXhhGjLp
         q+Cw==
X-Gm-Message-State: AOAM53358i5Y6UHiKyX9qkzAp/ceJnB4mH8wXaudSUlj8kCPpSs8gSQk
        kCo4El+FORZSdW8ICLhb0lJ0AA==
X-Google-Smtp-Source: ABdhPJw+S8scqaWlE3MYzQi76RwysDGhn8KLP6B59eb0mJaDLXFWOIh5UV7dvcXMehttPkOYFKPZ6A==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr5449215pjj.19.1625613416939;
        Tue, 06 Jul 2021 16:16:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w123sm18350483pff.152.2021.07.06.16.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 16:16:56 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:16:56 -0700 (PDT)
X-Google-Original-Date: Tue, 06 Jul 2021 16:16:35 PDT (-0700)
Subject:     Re: [PATCH v2] dt-bindings: riscv: add starfive jh7100 bindings
In-Reply-To: <20210625071240.577796-1-drew@beagleboard.org>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        michael.zhu@starfivetech.com, geert@linux-m68k.org,
        tekkamanninja@gmail.com, kernel@esmil.dk,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, drew@beagleboard.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     drew@beagleboard.org
Message-ID: <mhng-7fbbd583-fe4e-4f11-a028-3df3eca4ab41@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 00:12:42 PDT (-0700), drew@beagleboard.org wrote:
> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> BeagleV Starlight JH7100 board [2].
>
> [1] https://github.com/starfive-tech/beaglev_doc
> [2] https://github.com/beagleboard/beaglev-starlight
>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> v2 changes:
> - removed "items:" entry that only had "const: starfive,jh7100"
> - correct typo in Description:
>
> Results of running checks:
>
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>   DTEX    Documentation/devicetree/bindings/riscv/starfive.example.dts
>   DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>   DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>   CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>
> The dts file is from vendor repo and is being cleaned up right now in
> preperation for submitting to the mailing list:
> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
>
>  .../devicetree/bindings/riscv/starfive.yaml   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
>
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> new file mode 100644
> index 000000000000..68954d0a7108
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/starfive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive SoC-based boards
> +
> +maintainers:
> +  - Michael Zhu <michael.zhu@starfivetech.com>
> +  - Drew Fustini <drew@beagleboard.org>
> +
> +description:
> +  StarFive SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: beagle,beaglev-starlight-jh7100
> +          - const: starfive,jh7100

The SiFive boards have

    oneOf:
      - items:
          - enum:
              - sifive,hifive-unleashed-a00
          - const: sifive,fu540-c000
          - const: sifive,fu540

IIUC there's no practical difference between a single-option enum and 
the const, but it does bring up the board version number.  Is there any 
revision number on the beaglev boards?

> +
> +additionalProperties: true
> +
> +...

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

as I'm assuming this is targeted towards the DT tree.  Thanks!
