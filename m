Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEBF41EA44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 11:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353310AbhJAKB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 06:01:28 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48248
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353241AbhJAKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:01:26 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D456B402CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633082381;
        bh=XvBtYpd6FqXvAho3dxZm+PpxswCp7x5pHh71VzW8gVQ=;
        h=To:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pvIfmLzT/YsNK8zT0Cc0O1PucDTSf6GsP0f3oJEDOQnLijhWgUshcnsXkY72EwQge
         gYU2HD9AGRdaW4g8ZNloSS4xQ8uhLpehNSCT2dFrDBuxrJarJVW709F9Dbqqczctif
         f8m9RbpOEupxzGRFTQIiYgFbUn2YHO4bd/3VoSdopRW4cArcr5LU9w6sY07xzSqRfY
         YO8ek6ngdyu6x2GzVOZmsSqnejOEpizv8/QA10SW5dBl7CPKYdFDVW3PAZ7/DnLdW+
         /6gYua8IKdcqPCvQ5LxhuQygkpa3iAC4MUIgyE27KAPA7Lc5cZcswC1h0CCECv6I6U
         RjAIPRjlKFEZQ==
Received: by mail-lf1-f71.google.com with SMTP id r14-20020ac25c0e000000b003fc149ed50eso8475386lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 02:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvBtYpd6FqXvAho3dxZm+PpxswCp7x5pHh71VzW8gVQ=;
        b=pBJNaex3CQgKsIPedDUKyVEnZEVX7bcT/Fd/Y4kXuqOM+26OlMy6ckDsc2dVWON42g
         QzToOGxEiDpGGLVxw5LF9JUTCUqXyhHuXUrY8UXZBXAYjtXhNeBYvAi92ieeRwRwb0UZ
         sYuTaTU/Gqv2FwHO0Up1NPd4kvkNlQarcIlO39KPYDMvYnmktnUuuHBlgeCSVdZ+yzU8
         37Yc0PRAszq4j2cwrCzbrw/jDteGfyrR26R0DFoHnguKa20UX6e8qLTE8oOQckxz3lYl
         YkIqI7uoG3VyrUf5usJ/W+tuZwv6umkx9g/ozSZosWdCKUjmmi1rhc4Kb9SeFWE1EYgE
         NAoA==
X-Gm-Message-State: AOAM5318cojFVLSCAGSbzdhJbmRclI2JshNziQlJoY2V/y/75MCoNw4s
        MYczWqz8P3H7YHib7Llp2pDfVSI8R4AR8I5wd/ushhCCR74ii9loUyKuAv0NlKYcnpViQTIqsrc
        R+Pr0t0wlsyXkp+q0oCtZ0jIyZPTVbGw4l//eBwyV4A==
X-Received: by 2002:a05:6512:3a83:: with SMTP id q3mr4490904lfu.115.1633082381016;
        Fri, 01 Oct 2021 02:59:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE4xVtYRkN3ExixwoIin7RBkVLFi0ZIpX7EdzRx7TRZxY0JsIDH34WfjoPl+fR5DKnh4nqdA==
X-Received: by 2002:a05:6512:3a83:: with SMTP id q3mr4490886lfu.115.1633082380803;
        Fri, 01 Oct 2021 02:59:40 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id i8sm682004lfb.227.2021.10.01.02.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 02:59:40 -0700 (PDT)
To:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211001000924.15421-1-leoyang.li@nxp.com>
 <20211001000924.15421-2-leoyang.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml
 schema
Message-ID: <db751cb1-9107-3857-7576-644bde4c28e5@canonical.com>
Date:   Fri, 1 Oct 2021 11:59:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001000924.15421-2-leoyang.li@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2021 02:09, Li Yang wrote:
> Convert the txt binding to yaml format and add description.  Drop the
> "simple-bus" compatible string from the example and not allowed by the
> binding any more.  This will help to enforce the correct probe order
> between parent device and child devices, but will require the ifc driver
> to probe the child devices to work properly.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
> updates from previous submission:
> - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> - Fix one identiation problem of "reg"
> - Add type restriction to "little-endian" property
> 
>  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
>  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 82 deletions(-)
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
> index 000000000000..19871ce39fe3

Thanks for the patch.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)

Checkpatch should scream here. If it doesn't, maybe you work on some old
tree, which would also explain why you send it to my old address (not
the one from get_maintainers). Please use both checkpatch and
get_maintainers.

You basically relicense bindings from GPL-2.0 only to new license,
including GPL-3.0.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/fsl/ifc.yaml#

File name should be "fsl,ifc.yaml"

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
> +properties:
> +  $nodename:
> +    pattern: "^ifc@[0-9a-f]+$"

Nodes should be generic, so this looks like "memory-controller".

> +
> +  compatible:
> +    const: fsl,ifc
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
> +      Offset and length of the register set for the device.

Skip the description, it's obvious.

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
> +    $ref: '/schemas/types.yaml#/definitions/flag'

type: boolean


Best regards,
Krzysztof
