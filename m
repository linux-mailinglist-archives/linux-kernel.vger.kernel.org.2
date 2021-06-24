Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C813B37C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhFXU2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:28:01 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40917 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXU2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:28:00 -0400
Received: by mail-io1-f48.google.com with SMTP id r12so9863458ioa.7;
        Thu, 24 Jun 2021 13:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1srSw9djj3aE0hZl1UwtMCiUfWV+Qd6ksCBqCVsKFrA=;
        b=cUYfk0e7hODiKgvYahSUZkUo0GzpPf2y1IUZtGmPB1HUmqD07q3Za6DNl3pdaz6VxP
         Iz79w6GSQyqhHsA3wSSz53GlGCSbh8IbMHkp4M1O2lqaiKYuGOv7Lxd/2g2enGCN0Gc3
         CLLlP/eYdOF2wuNVscPwby9bV8t/CCH/M7zvL56GxfiaWt9MFEbfR3626p5aNAQqSgtO
         dfoaZFWIil5O1suF2k2DRJVciip8vaIKXaethFrgngZMh3ghQ95vV3qJ8bW0SUp9yk4E
         1hQakMkN8jqoPtixVCfl7778jKxyURKMn7BObnbXNnhg46s5qEbbIwfhiJppIuB1R7UR
         LFHw==
X-Gm-Message-State: AOAM532ayoOIfN7NKVgGC6BfywZVoyJLsSswcxE33QkQEg6g+PI2Cxf5
        Nb0yfDuGtwptbbjWj/7sKw==
X-Google-Smtp-Source: ABdhPJwe/5Hx7iUneDMwrrXFoJWPvvXETCyKdfaAvHzf8grTRznsTSIUzXqtBcMvErIpbGMY5npQhQ==
X-Received: by 2002:a5d:89d0:: with SMTP id a16mr5628232iot.76.1624566340465;
        Thu, 24 Jun 2021 13:25:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s17sm1873575ioe.32.2021.06.24.13.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:25:38 -0700 (PDT)
Received: (nullmailer pid 1931032 invoked by uid 1000);
        Thu, 24 Jun 2021 20:25:35 -0000
Date:   Thu, 24 Jun 2021 14:25:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     michal.simek@xilinx.com, mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: clk: zynqmp: convert bindings to YAML
Message-ID: <20210624202535.GA1929073@robh.at.kernel.org>
References: <20210613204742.292053-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613204742.292053-1-iwamatsu@nigauri.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:47:42AM +0900, Nobuhiro Iwamatsu wrote:
> Convert common clock for Xilinx Zynq MPSoC SoC bindings documentation
> to YAML.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
> v3: Drop commit for mailbox/xlnx,zynqmp-ipi-mailbox.txt
> v2: Fix warning with DT_CHECKER_FLAGS=-m.
> 
>  .../bindings/clock/xlnx,zynqmp-clk.txt        | 63 -------------------
>  .../bindings/clock/xlnx,zynqmp-clk.yaml       | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> deleted file mode 100644
> index 391ee1a60bed4a..00000000000000
> --- a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> +++ /dev/null
> @@ -1,63 +0,0 @@
> ---------------------------------------------------------------------------
> -Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
> -Zynq MPSoC firmware interface
> ---------------------------------------------------------------------------
> -The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
> -tree. It reads required input clock frequencies from the devicetree and acts
> -as clock provider for all clock consumers of PS clocks.
> -
> -See clock_bindings.txt for more information on the generic clock bindings.
> -
> -Required properties:
> - - #clock-cells:	Must be 1
> - - compatible:		Must contain:	"xlnx,zynqmp-clk"
> - - clocks:		List of clock specifiers which are external input
> -			clocks to the given clock controller. Please refer
> -			the next section to find the input clocks for a
> -			given controller.
> - - clock-names:		List of clock names which are exteral input clocks
> -			to the given clock controller. Please refer to the
> -			clock bindings for more details.
> -
> -Input clocks for zynqmp Ultrascale+ clock controller:
> -
> -The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
> -inputs. These required clock inputs are:
> - - pss_ref_clk (PS reference clock)
> - - video_clk (reference clock for video system )
> - - pss_alt_ref_clk (alternative PS reference clock)
> - - aux_ref_clk
> - - gt_crx_ref_clk (transceiver reference clock)
> -
> -The following strings are optional parameters to the 'clock-names' property in
> -order to provide an optional (E)MIO clock source:
> - - swdt0_ext_clk
> - - swdt1_ext_clk
> - - gem0_emio_clk
> - - gem1_emio_clk
> - - gem2_emio_clk
> - - gem3_emio_clk
> - - mio_clk_XX		# with XX = 00..77
> - - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51

What happened to these with no explanation.

> -
> -
> -Output clocks are registered based on clock information received
> -from firmware. Output clocks indexes are mentioned in
> -include/dt-bindings/clock/xlnx-zynqmp-clk.h.
> -
> --------
> -Example
> --------
> -
> -firmware {
> -	zynqmp_firmware: zynqmp-firmware {
> -		compatible = "xlnx,zynqmp-firmware";
> -		method = "smc";
> -		zynqmp_clk: clock-controller {
> -			#clock-cells = <1>;
> -			compatible = "xlnx,zynqmp-clk";
> -			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> -			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
> new file mode 100644
> index 00000000000000..e7a1384fb646e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/xlnx,zynqmp-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Ultrascale+ MPSoC clock controller Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +description: |
> +  The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
> +  tree. It reads required input clock frequencies from the devicetree and acts
> +  as clock provider for all clock consumers of PS clocks.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    description: |
> +      List of clock specifiers which are external input
> +      clocks to the given clock controller.
> +    items:
> +      - description: PS reference clock
> +      - description: reference clock for video system
> +      - description: alternative PS reference clock
> +      - description: auxiliary reference clock
> +      - description: transceiver reference clock
> +
> +  clock-names:
> +    items:
> +      - const: pss_ref_clk
> +      - const: video_clk
> +      - const: pss_alt_ref_clk
> +      - const: aux_ref_clk
> +      - const: gt_crx_ref_clk
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        zynqmp_clk: clock-controller {
> +          #clock-cells = <1>;
> +          compatible = "xlnx,zynqmp-clk";
> +          clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> +          clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> +        };
> +      };
> +    };
> +...
> -- 
> 2.32.0
> 
> 
