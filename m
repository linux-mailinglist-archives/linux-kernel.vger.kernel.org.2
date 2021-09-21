Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715D413C76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhIUVcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:32:00 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36448 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhIUVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:31:53 -0400
Received: by mail-oi1-f182.google.com with SMTP id y201so1258123oie.3;
        Tue, 21 Sep 2021 14:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qOUqyvLIqpAcRVLX2RVvyvruhXG3SDZlFXYRj/WyI+A=;
        b=h74xsFjTl9M2p83G46LPcHNQfnlFnHOGIgevwJa/71dEdRnzGaWr+f3QtzKINDqC9b
         G+vY2OLKWET4eNYvY/jm0JzNTJ4rHgIbJFZyPFgIRZPhzFFYAt/H5mpSRuWYqq5oyBO0
         qszt5haO1Ls6YqzsHxCctjelzLY91V/tjVUBv/3oZtnpGxXYlNWh4rsqGQuLcuJcLsLE
         ESS6lUYkizzvE8SUQcqBN5733J1Bj4BkuG9C8irakjy3EfCWp7cUm8u2TmMpyjiqT1EL
         6Mmzoz3QI6XCHO5T3VTH2EPP0FZdZTT1j7jMjafsfR9+IQNVnY7Yu9/R15RWhfMs548R
         zbow==
X-Gm-Message-State: AOAM533FOMpRJDZAHogjnfYNnKD9N2Jyk0GzTQcKovxfpc3nIpMYC5ta
        WVnrTRbj+N3s/Bg6ZKiCzQ==
X-Google-Smtp-Source: ABdhPJx6mPka25mxnHJIqTy73LHD/zGaxTKelTzEk9vwTLT4TPPlzOHlBDhTD1mDL3ETYJK8xfsxPQ==
X-Received: by 2002:aca:ba44:: with SMTP id k65mr5445250oif.131.1632259824589;
        Tue, 21 Sep 2021 14:30:24 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id 14sm43086otl.50.2021.09.21.14.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:30:24 -0700 (PDT)
Received: (nullmailer pid 3356286 invoked by uid 1000);
        Tue, 21 Sep 2021 21:30:22 -0000
Date:   Tue, 21 Sep 2021 16:30:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: zynqmp: Add support for Xilinx Kria SOM board
Message-ID: <YUpO7j1kDJ2kmvsW@robh.at.kernel.org>
References: <ed0e6aa670ac59eabbabe7552883416248ad6c89.1631697878.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0e6aa670ac59eabbabe7552883416248ad6c89.1631697878.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:24:58AM +0200, Michal Simek wrote:
> There are couple of revisions of SOMs (k26) and associated carrier cards
> (kv260).
> SOM itself has two major versions:
> sm-k26 - SOM with EMMC
> smk-k26 - SOM without EMMC used on starter kit with preprogrammed firmware
> in QSPI.
> 
> SOMs are describing only devices available on the SOM or connections which
> are described in specification (for example UART, fwuen).
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v4:
> - Remove ina260 and usb5744 nodes
> - Remove compatible string from overlays
> 
> Changes in v3:
> - Fix led node name
> - Fix compatible string for xlnx,zynqmp-sk-kv260-revA/Y/Z
> - Fix headers alignment
> - Move USB3 PHY properties from DWC3 node to USB node - reported by Manish
>   Narani
> - Change dtb names generated with dtbo
> - Fix emmc comment style
> 
> Changes in v2:
> - Use sugar syntax - reported by Geert
> - Update copyright years
> - Fix SD3.0 comment alignment
> - Remove one newline from Makefile
> 
> https://www.xilinx.com/products/som/kria.html
> Based on
> https://lore.kernel.org/r/cover.1628244703.git.michal.simek@xilinx.com
> 
> ---
>  .../devicetree/bindings/arm/xilinx.yaml       |  16 +
>  arch/arm64/boot/dts/xilinx/Makefile           |  13 +
>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 315 ++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 298 +++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 ++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++
>  6 files changed, 952 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> index a0b1ae6e3e71..4dc0e0195974 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -116,6 +116,22 @@ properties:
>            - const: xlnx,zynqmp-zcu111
>            - const: xlnx,zynqmp
>  
> +      - description: Xilinx Kria SOMs
> +        items:
> +          - const: xlnx,zynqmp-sm-k26-rev1
> +          - const: xlnx,zynqmp-sm-k26-revB
> +          - const: xlnx,zynqmp-sm-k26-revA
> +          - const: xlnx,zynqmp-sm-k26
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx Kria SOMs (starter)
> +        items:
> +          - const: xlnx,zynqmp-smk-k26-rev1
> +          - const: xlnx,zynqmp-smk-k26-revB
> +          - const: xlnx,zynqmp-smk-k26-revA
> +          - const: xlnx,zynqmp-smk-k26
> +          - const: xlnx,zynqmp
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 083ed52337fd..4e159540d031 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -17,3 +17,16 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> +
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
> +
> +sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> +smk-k26-revA-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +smk-k26-revA-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo

I assume there is some value in these being overlays? I probably asked 
that already too, but don't remember. Please explain in the commit 
message so we capture that.

> +
> +dtb-$(CONFIG_ARCH_ZYNQMP) += sm-k26-revA-sck-kv-g-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += sm-k26-revA-sck-kv-g-revB.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += smk-k26-revA-sm-k26-revA-sck-kv-g-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += smk-k26-revA-sm-k26-revA-sck-kv-g-revB.dtb
