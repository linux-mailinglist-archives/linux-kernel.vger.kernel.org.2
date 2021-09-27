Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8877C419E63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhI0ShZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:37:25 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:35460 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhI0ShY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:37:24 -0400
Received: by mail-oi1-f182.google.com with SMTP id n64so7492660oih.2;
        Mon, 27 Sep 2021 11:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyHDuZNWsD1CiOsJyVBNocG00emCbcuWh07//nyOEl8=;
        b=OulOjNttfru0uJ1cDU37f4O7WCNIRmbrgy7sngqW3wqsTVuoNRcdb7sOFhqAYyXJCm
         pbQJdRwr84irlXNinghodAGb/Xoy3aggveqc25dtpYQ68YZIycWP8//1VbXxD8AAliaj
         0gsiOe7cbI228zIndMs4Ai7fXhN9qYNnwrbhl0emHD0uDHOgLQyTSuBiAljtErvetOdO
         l/iBHqoADhoKkb4qo6H/DHhIWDTYwJ547l2mM/OjiINdl0pVGsuBAI80p9ggwiGjrYy4
         6pO32o5SSHHamm1FXFOSGewMpZA1F9ydJKBqgAMC4EuKP+bN0YLCjEwNV+Dp98Kb+akZ
         ldJQ==
X-Gm-Message-State: AOAM533hk0sa4MpfaqhLAa+RGMe/jRfe1KN+0HmuFCfJSuN4fCRwiZbn
        95v0Ebq0en2r1sVf6pXLiwUqzhw6+g==
X-Google-Smtp-Source: ABdhPJyXxFw/Q7Ln2aqNgAls3SlgUyI0tOzRHi/35jPGg3w2WwFgVWlOuAm4XishHIHnuQmpHWeRXw==
X-Received: by 2002:a05:6808:1906:: with SMTP id bf6mr428876oib.130.1632767746269;
        Mon, 27 Sep 2021 11:35:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z83sm4229706oiz.41.2021.09.27.11.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:35:45 -0700 (PDT)
Received: (nullmailer pid 3608435 invoked by uid 1000);
        Mon, 27 Sep 2021 18:35:44 -0000
Date:   Mon, 27 Sep 2021 13:35:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     monstr@monstr.eu, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, git@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: zynqmp: Add support for Xilinx Kria SOM board
Message-ID: <YVIPAGckmsYmrVv1@robh.at.kernel.org>
References: <1ba32590670434b650bacf6410a65579dd30b38b.1632294439.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba32590670434b650bacf6410a65579dd30b38b.1632294439.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 09:07:32 +0200, Michal Simek wrote:
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
> When SOM boots out of QSPI it uses limited number of peripherals defined by
> the specification and present in sm(k)-k26 dtses.
> Then a carrier card (CC) detection is happening and DT overlay is applied
> to brings new functionality. That's why DT overlays are used. The name is
> composed together with SOM name and CC name that's why DT overlays with
> these names are generated to make sure they can be used together.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v5:
> - Extend commit message.
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

Reviewed-by: Rob Herring <robh@kernel.org>
