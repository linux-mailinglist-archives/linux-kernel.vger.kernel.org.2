Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9CB311CED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBFLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:38:07 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44927 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhBFLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:38:02 -0500
Received: by mail-wr1-f44.google.com with SMTP id d16so10713977wro.11;
        Sat, 06 Feb 2021 03:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/IgcD1aj1Di/vgTAXi7obMa2KXOHpd/HyAcFAFEWn9A=;
        b=HsPO32NUuEFbSXCU9w58p/O5+eJpySmRcLL+E/MQE/05+eia4k3/hCnV+1LoNB1E/z
         XNOKpGqjhsVhl0jvUTvJdZV1jZcVdGKPgjjmmPlrqEabnZ5YloncIii5QyqquT0dr/x7
         PR4Ac5AjnZMLk7bw8FMUwDktGb78qpBjy7M23xmfwFPKDdbud/PDARtlbgndk3X8jwFj
         4AlLyTVfIMUFe0vfR3k7pFmhHxe3X+psc8bGef526dxoSCe+YlYCsPprlYSE2HL0RtqJ
         D1wQ6ro572SDAI8oX71beVxwlj3Lgf+hny+l5FNPvHMOwdow5zdW4pLfK1iI6fqtIZHD
         Wxeg==
X-Gm-Message-State: AOAM531IzOjxzAXLg45utFMUbMnJhDBmLrb5cyJ6bXKt0157jSQHZ0oe
        Oc3RQTvaVLVi8miwWi28u54=
X-Google-Smtp-Source: ABdhPJxHCsluCPhcOMGhkbrvWoUD40EhEKFLTpsMW+TwMh4I029Wb4GHYWyZHNC9Iv0warwgq+dqaA==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr2146776wrv.158.1612611439574;
        Sat, 06 Feb 2021 03:37:19 -0800 (PST)
Received: from kozik-lap (194-95-143-94.dyn.cable.fcom.ch. [94.143.95.194])
        by smtp.googlemail.com with ESMTPSA id b138sm10962806wmb.35.2021.02.06.03.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 03:37:18 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:37:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Message-ID: <20210206113716.75zh7dq4cabgf367@kozik-lap>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205234734.3397-4-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:47:22PM -0600, Li Yang wrote:
> Convert the txt binding to yaml format and add description.  Also
> updated the recommended node name to ifc-bus to align with the
> simple-bus node name requirements.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
>  .../bindings/memory-controllers/fsl/ifc.yaml  | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> deleted file mode 100644
> index 89427b018ba7..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> +++ /dev/null
> @@ -1,82 +0,0 @@
> -Integrated Flash Controller
> -
> -Properties:
> -- name : Should be ifc
> -- compatible : should contain "fsl,ifc". The version of the integrated
> -               flash controller can be found in the IFC_REV register at
> -               offset zero.
> -
> -- #address-cells : Should be either two or three.  The first cell is the
> -                   chipselect number, and the remaining cells are the
> -                   offset into the chipselect.
> -- #size-cells : Either one or two, depending on how large each chipselect
> -                can be.
> -- reg : Offset and length of the register set for the device
> -- interrupts: IFC may have one or two interrupts.  If two interrupt
> -              specifiers are present, the first is the "common"
> -              interrupt (CM_EVTER_STAT), and the second is the NAND
> -              interrupt (NAND_EVTER_STAT).  If there is only one,
> -              that interrupt reports both types of event.
> -
> -- little-endian : If this property is absent, the big-endian mode will
> -                  be in use as default for registers.
> -
> -- ranges : Each range corresponds to a single chipselect, and covers
> -           the entire access window as configured.
> -
> -Child device nodes describe the devices connected to IFC such as NOR (e.g.
> -cfi-flash) and NAND (fsl,ifc-nand). There might be board specific devices
> -like FPGAs, CPLDs, etc.
> -
> -Example:
> -
> -	ifc@ffe1e000 {
> -		compatible = "fsl,ifc", "simple-bus";
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		reg = <0x0 0xffe1e000 0 0x2000>;
> -		interrupts = <16 2 19 2>;
> -		little-endian;
> -
> -		/* NOR, NAND Flashes and CPLD on board */
> -		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
> -			  0x1 0x0 0x0 0xffa00000 0x00010000
> -			  0x3 0x0 0x0 0xffb00000 0x00020000>;
> -
> -		flash@0,0 {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "cfi-flash";
> -			reg = <0x0 0x0 0x2000000>;
> -			bank-width = <2>;
> -			device-width = <1>;
> -
> -			partition@0 {
> -				/* 32MB for user data */
> -				reg = <0x0 0x02000000>;
> -				label = "NOR Data";
> -			};
> -		};
> -
> -		flash@1,0 {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "fsl,ifc-nand";
> -			reg = <0x1 0x0 0x10000>;
> -
> -			partition@0 {
> -				/* This location must not be altered  */
> -				/* 1MB for u-boot Bootloader Image */
> -				reg = <0x0 0x00100000>;
> -				label = "NAND U-Boot Image";
> -				read-only;
> -			};
> -		};
> -
> -		cpld@3,0 {
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			compatible = "fsl,p1010rdb-cpld";
> -			reg = <0x3 0x0 0x000001f>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> new file mode 100644
> index 000000000000..d37cae66b027
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/fsl/ifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FSL/NXP Integrated Flash Controller
> +
> +maintainers:
> +  - Li Yang <leoyang.li@nxp.com>
> +
> +description: |
> +  NXP's integrated flash controller (IFC) is an advanced version of the
> +  enhanced local bus controller which includes similar programming and signal
> +  interfaces with an extended feature set. The IFC provides access to multiple
> +  external memory types, such as NAND flash (SLC and MLC), NOR flash, EPROM,
> +  SRAM and other memories where address and data are shared on a bus.
> +
> +allOf:
> +  - $ref: /schemas/simple-bus.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^ifc-bus@[0-9a-f]+$"

Just "bus". The node name should be generic, represent generic class of
a device. The class is a bus.

> +
> +  compatible:
> +    contains:
> +      const: fsl,ifc

I think you should list all compatibles, to be specific. "contains"
allow adding any arbitrary compatible.

> +
> +  "#address-cells":
> +    enum: [2, 3]
> +    description: |
> +      Should be either two or three.  The first cell is the chipselect
> +      number, and the remaining cells are the offset into the chipselect.
> +
> +  "#size-cells":
> +    enum: [1, 2]
> +    description: |
> +      Either one or two, depending on how large each chipselect can be.
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +        Offset and length of the register set for the device.

Wrong indentation.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      IFC may have one or two interrupts.  If two interrupt specifiers are
> +      present, the first is the "common" interrupt (CM_EVTER_STAT), and the
> +      second is the NAND interrupt (NAND_EVTER_STAT).  If there is only one,
> +      that interrupt reports both types of event.
> +
> +  little-endian:
> +    description: |
> +      If this property is absent, the big-endian mode will be in use as default
> +      for registers.

type: boolean

> +
> +  ranges:
> +    description: |
> +      Each range corresponds to a single chipselect, and covers the entire
> +      access window as configured.
> +
> +patternProperties:

Wrong indentation.

Best regards,
Krzysztof
