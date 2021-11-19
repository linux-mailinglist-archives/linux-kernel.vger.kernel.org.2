Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6054574DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhKSRBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:01:33 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43574 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhKSRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:01:32 -0500
Received: by mail-oi1-f174.google.com with SMTP id o4so22898507oia.10;
        Fri, 19 Nov 2021 08:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0/NOpM1se8iPUSGGqq1mJ9QuXVx1LyhbZAK+OdBfRc4=;
        b=G0jexsU4QUnX3QJKfXz/ztnd24BzhgfGUe3r/3ae+w+kWtx9OpOd3XJeIV0e0DLTCQ
         H6+jlVN7zebv940d2XsTfoQ2NB7eGQJAWOQRq7Aboj3xQvB3JY6KQjQQ1GMSuPE1GMC2
         A7Bc9yxjBPUSEyPsWkbnffR4uiMuYT4HgUvI6qxsRQbzn8WIxDI0yXPHBM/ZI2kkhuo3
         6xUW+VnQ/+ldr9AGxh/s1vjLFEQCd7KJ1sK0rTSP/geMqkPmtv57YYBUpWe8hwMito7N
         AixRcroouOMbpoQ5XFDHHmpx9b8TJwJ/cXDaEjvKi5wr8s1viAFiiZpgdCalq74AoAaN
         VziQ==
X-Gm-Message-State: AOAM530Q2N5lG/LDQTMjI44NFJh/Mlgzs+oAi+izxuTeU0m3Ylv43CVf
        0zp+6qZrigSrd3LYfuYNDA==
X-Google-Smtp-Source: ABdhPJxWL5ONrp7p34ohpvA1UkYOCUtg+R+iQzMItICEDQnLrCQYbQ4qprfFuDuwnV7G2+NBN/H8vQ==
X-Received: by 2002:aca:1b15:: with SMTP id b21mr1086768oib.64.1637341110042;
        Fri, 19 Nov 2021 08:58:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm63803oij.54.2021.11.19.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:58:26 -0800 (PST)
Received: (nullmailer pid 4078690 invoked by uid 1000);
        Fri, 19 Nov 2021 16:58:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     git@xilinx.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
In-Reply-To: <1637329568-31756-1-git-send-email-manish.narani@xilinx.com>
References: <1637329568-31756-1-git-send-email-manish.narani@xilinx.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3-xilinx: Convert USB DWC3 bindings
Date:   Fri, 19 Nov 2021 10:58:22 -0600
Message-Id: <1637341102.285159.4078689.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 19:16:08 +0530, Manish Narani wrote:
> Convert USB DWC3 bindings to DT schema format using json-schema.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.txt        |  56 ----------
>  .../devicetree/bindings/usb/dwc3-xilinx.yaml       | 119 +++++++++++++++++++++
>  2 files changed, 119 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1557119


usb@ff9d0000: 'phy-names', 'phys' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml

usb@ff9d0000: usb@fe200000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml

usb@ff9e0000: 'phy-names', 'phys' do not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml

usb@ff9e0000: usb@fe300000:interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dt.yaml
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dt.yaml

