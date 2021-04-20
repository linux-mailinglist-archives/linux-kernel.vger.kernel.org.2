Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05D5365B01
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhDTOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:15:44 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41728 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhDTOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:15:39 -0400
Received: by mail-ot1-f50.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso27271843ott.8;
        Tue, 20 Apr 2021 07:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQrvXF6jsBsxQM/n8Qq8tJqXRILLahzSGccdVi41rnI=;
        b=ToVL/VuGHSudHLc3Ez+E+to+CYK4noz3cGRqs7Qb+MQwtWcg4399fb2/Xa8Vslf+0G
         qofTEsCieHfXkXtyd+wLfRTKnvF+V4sQG3kol9BO+ddeH5hZjJNA2GZbOgNF2citgF+T
         Ie3PQB0wxl7fQzbvpmi4FFdz1UEQ6E/k7syfUoPLpbNi1evzsoWEkNKHKINqOqy+C7/6
         3V1JGjmIdEUTLbjOI4zw1pHNRyrFa6Xlq6h0Lm3Re0M9TQHUHuI4fNrTf66l94BJ7JyS
         ynYxlh5gNvYuf7Q50wsotQQaa+zCaxV/bMq0aQT7y3Q9hMgWDd/qXMBfaB0qUd5k95tO
         ktQQ==
X-Gm-Message-State: AOAM5333HgueLmIvzFJLowUV1Dd5ahpUSQM3m1XKAvwnBa0uimoxHm81
        0TE6PNAFs+El5iI5eSN7qA==
X-Google-Smtp-Source: ABdhPJzBaI1//hsQGZTcOWdRWoMXwE1B6ZcuDc85ad+AzX0kLozdA0RkAjoMY5tiPLN4fWNr5i/Cpg==
X-Received: by 2002:a9d:5f0c:: with SMTP id f12mr18888376oti.258.1618928106552;
        Tue, 20 Apr 2021 07:15:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r127sm224943oor.2.2021.04.20.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:15:05 -0700 (PDT)
Received: (nullmailer pid 3257176 invoked by uid 1000);
        Tue, 20 Apr 2021 14:15:04 -0000
Date:   Tue, 20 Apr 2021 09:15:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejas.patel@xilinx.com,
        amit.sunil.dhamne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com, git@xilinx.com
Subject: Re: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config
 driver
Message-ID: <20210420141504.GA3250182@robh.at.kernel.org>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-5-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420081153.17020-5-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:41:52PM +0530, Nava kishore Manne wrote:
> This patch adds the binding document for the zynqmp afi
> config driver.

Bindings are for h/w blocks, not drivers.

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> new file mode 100644
> index 000000000000..3ae22096b22a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
> @@ -0,0 +1,136 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/xlnx,zynqmp-afi-fpga.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx ZynqMP AFI interface Manager.
> +
> +maintainers:
> +  - Nava kishore Manne <nava.manne@xilinx.com>
> +
> +description: |
> +  The Zynq UltraScale+ MPSoC Processing System core provides access from PL
> +  masters to PS internal peripherals, and memory through AXI FIFO interface(AFI)
> +  interfaces.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - xlnx,zynqmp-afi-fpga
> +
> +  config-afi:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Pairs of  <regid value >
> +      The possible values of regid and values are
> +      regid - Regids of the register to be written possible values

If we wanted sequences of register accesses in DT, we'd have a 
generic mechanism to do so.

> +        0- AFIFM0_RDCTRL
> +        1- AFIFM0_WRCTRL
> +        2- AFIFM1_RDCTRL
> +        3- AFIFM1_WRCTRL
> +        4- AFIFM2_RDCTRL
> +        5- AFIFM2_WRCTRL
> +        6- AFIFM3_RDCTRL
> +        7- AFIFM3_WRCTRL
> +        8- AFIFM4_RDCTRL
> +        9- AFIFM4_WRCTRL
> +        10- AFIFM5_RDCTRL
> +        11- AFIFM5_WRCTRL
> +        12- AFIFM6_RDCTRL
> +        13- AFIFM6_WRCTRL
> +        14- AFIFS
> +        15- AFIFS_SS2
> +      value - Array of values to be written.
> +        for FM0_RDCTRL(0) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM0_WRCTRL(1) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM1_RDCTRL(2) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM1_WRCTRL(3) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM2_RDCTRL(4) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM2_WRCTRL(5) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM3_RDCTRL(6) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM3_WRCTRL(7) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM4_RDCTRL(8) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM4_WRCTRL(9) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM5_RDCTRL(10) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM5_WRCTRL(11) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM6_RDCTRL(12) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for FM6_WRCTRL(13) the valid values-fabric width
> +          2 - 32-bit
> +          1 - 64-bit
> +          0 - 128-bit
> +        for AFI_FA(14)
> +          dw_ss1_sel      bits (11:10)
> +          dw_ss0_sel      bits (9:8)
> +            0x0 - 32-bit AXI data width
> +            0x1 - 64-bit AXI data width
> +            0x2 - 128-bit AXI data width
> +            All other bits are 0 write ignored.
> +
> +        for AFI_FA(15)  selects for ss2AXI data width valid values
> +          0x000 - 32-bit AXI data width
> +          0x100 - 64-bit AXI data width
> +          0x200 - 128-bit AXI data width
> +    minItems: 1
> +    maxItems: 15
> +
> +required:
> +  - compatible
> +  - config-afi
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        compatible = "xlnx,zynqmp-firmware";
> +        method = "smc";
> +        afi0: afi {
> +          compatible = "xlnx,afi-fpga";
> +          config-afi = <0 2>, <1 1>, <2 1>;
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.18.0
> 
