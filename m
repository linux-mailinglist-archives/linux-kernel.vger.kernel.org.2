Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4E3CA3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhGORPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:15:21 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34425 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhGORPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:15:20 -0400
Received: by mail-io1-f41.google.com with SMTP id g22so7335499iom.1;
        Thu, 15 Jul 2021 10:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVELhrfvc5pcUyULq5NUcKRjoYbdkpGVUx8160StOzw=;
        b=ih/ZTP3Zms9kScoGPZZYh8zMOwamwPTbfXTI/Rx3NwS4fDn/biDTWBQhQIz5Ro9U6M
         Xl6I3jTCL+yfzgjsY/BpTVmxb439WiJMKk7JG0sL4sqrXPK5yP3ZDTMmBCypdzo21L8a
         jdYPiRIHg94+8bDzhjoMsNViV2m59ydUHQ0P/Dt8s83ScugtWSKYR9cEFn9ZjoYfG11C
         9OxbwQQYMjAMrmq3cSUoF8gz1t+5e/EDBLo2PkZ19gw1yhPRdpAhBhtNgNpWQngQ1r2Y
         cZb5Jh3ZOZsUyfRMABxZzMXn7u9KafcOVZUw3/2RrWF53Xc31qzm/GUwYnJyM1HzGNU5
         dKOg==
X-Gm-Message-State: AOAM530F8C1+cW1yC9NoTr8wLo6fcmi7oh0yglJ+TCR6dMTSh3c61UGr
        v8Hn1trYB4zoZTYhg0oQjQ==
X-Google-Smtp-Source: ABdhPJykBLYjZ4cF9fSKxRji2zzMcU72ZD0DLVzS2AetdFvKiBYglthqS6FNSvaFO9Ofu8kggqzB8A==
X-Received: by 2002:a5e:a609:: with SMTP id q9mr3804801ioi.57.1626369145685;
        Thu, 15 Jul 2021 10:12:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i14sm3047235ilu.71.2021.07.15.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:12:24 -0700 (PDT)
Received: (nullmailer pid 1260573 invoked by uid 1000);
        Thu, 15 Jul 2021 17:12:20 -0000
Date:   Thu, 15 Jul 2021 11:12:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org, Jack Zhu <jack.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        devicetree@vger.kernel.org, Wei Fu <tekkamanninja@gmail.com>
Subject: Re: [PATCH v4] dt-bindings: riscv: add starfive jh7100 bindings
Message-ID: <20210715171220.GA1259840@robh.at.kernel.org>
References: <20210713063018.3000459-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713063018.3000459-1-drew@beagleboard.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 23:30:18 -0700, Drew Fustini wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>

(I'm expecting the RiscV maintainers to take this.)
