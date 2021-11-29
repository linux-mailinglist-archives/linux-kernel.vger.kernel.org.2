Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD0460C74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhK2BwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:52:00 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46949 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbhK2Bt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:49:59 -0500
Received: by mail-oi1-f179.google.com with SMTP id s139so31549753oie.13;
        Sun, 28 Nov 2021 17:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YB0lGH1hYtRkq9xeTp6zskQk+3JQFjBsCekcZwVueQo=;
        b=auQ/6ozgvohqpLYMuigWND1CEgxwq4oML7hGpQ8FEPCDTczEh7K0vom8N6CHdBV5C+
         D/9vn76C77pU18mQge328h4KwO2bW3Jc+Tz5lTXt+qGx0kqlY7wiPQx6EOMjSpvvn9Y2
         45Dglr+efbdaNelUfsQvzSz4kTEisPse/HoEeR9Ago63B/lahujANOCf9ImX+i9YQYyr
         UoqZuDU0AV1RP8WTmTOBH07hRiGSkP5mARLDRFpf5Wpdy+hLRW+mwRz8PoCVjq/ZsVqw
         CuI7vg1CxEcLYZ3/6BqAPkxRCDYYWYuOOiELA0i5O1WG9CSS3UN3xhZCXsbzNRqsLsz3
         ljow==
X-Gm-Message-State: AOAM530n13WrR8BKVcsfMjsH3vrpHB0dhF3+ARnHV66k6xgKIzyl6kiD
        45lVST+3LeDpeZu8qhGqYsIDfm6Ffg==
X-Google-Smtp-Source: ABdhPJyxai8Uf7tZPqPrdnE2jg0SGF1y64khLGGyzMF28kr6gm4DtVyLI6KNiVwFakoN9d+aT52CYA==
X-Received: by 2002:aca:30c5:: with SMTP id w188mr37002376oiw.35.1638150402704;
        Sun, 28 Nov 2021 17:46:42 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id k16sm2419831otp.21.2021.11.28.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:46:42 -0800 (PST)
Received: (nullmailer pid 3000141 invoked by uid 1000);
        Mon, 29 Nov 2021 01:46:40 -0000
Date:   Sun, 28 Nov 2021 19:46:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com
Subject: Re: [PATCH v2] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Message-ID: <YaQxAH6hru20cVTl@robh.at.kernel.org>
References: <20211112084605.230253-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112084605.230253-1-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 02:16:05PM +0530, Shubhrajyoti Datta wrote:
> Convert the ipi doc to yaml.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> Fix the warnings reported by Rob
> 
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  63 +++++++++
>  2 files changed, 63 insertions(+), 127 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
>  create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> deleted file mode 100644
> index ad76edccf881..000000000000
> --- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -Xilinx IPI Mailbox Controller
> -========================================
> -
> -The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> -messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> -agent owns registers used for notification and buffers for message.
> -
> -               +-------------------------------------+
> -               | Xilinx ZynqMP IPI Controller        |
> -               +-------------------------------------+
> -    +--------------------------------------------------+
> -ATF                    |                     |
> -                       |                     |
> -                       |                     |
> -    +--------------------------+             |
> -                       |                     |
> -                       |                     |
> -    +--------------------------------------------------+
> -            +------------------------------------------+
> -            |  +----------------+   +----------------+ |
> -Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
> -            |  |  Registers     |   |                | |
> -            |  |                |   |                | |
> -            |  +----------------+   +----------------+ |
> -            |                                          |
> -            | Xilinx IPI Agent Block                   |
> -            +------------------------------------------+
> -
> -
> -Controller Device Node:
> -===========================
> -Required properties:
> ---------------------
> -IPI agent node:
> -- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
> -- interrupt-parent:	Phandle for the interrupt controller
> -- interrupts:		Interrupt information corresponding to the
> -			interrupt-names property.
> -- xlnx,ipi-id:		local Xilinx IPI agent ID
> -- #address-cells:	number of address cells of internal IPI mailbox nodes
> -- #size-cells:		number of size cells of internal IPI mailbox nodes
> -
> -Internal IPI mailbox node:
> -- reg:			IPI buffers address ranges
> -- reg-names:		Names of the reg resources. It should have:
> -			* local_request_region
> -			  - IPI request msg buffer written by local and read
> -			    by remote
> -			* local_response_region
> -			  - IPI response msg buffer written by local and read
> -			    by remote
> -			* remote_request_region
> -			  - IPI request msg buffer written by remote and read
> -			    by local
> -			* remote_response_region
> -			  - IPI response msg buffer written by remote and read
> -			    by local
> -- #mbox-cells:		Shall be 1. It contains:
> -			* tx(0) or rx(1) channel
> -- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
> -			connected to.
> -
> -Optional properties:
> ---------------------
> -- method:              The method of accessing the IPI agent registers.
> -                       Permitted values are: "smc" and "hvc". Default is
> -                       "smc".
> -
> -Client Device Node:
> -===========================
> -Required properties:
> ---------------------
> -- mboxes:		Standard property to specify a mailbox
> -			(See ./mailbox.txt)
> -- mbox-names:		List of identifier  strings for each mailbox
> -			channel.
> -
> -Example:
> -===========================
> -	zynqmp_ipi {
> -		compatible = "xlnx,zynqmp-ipi-mailbox";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 29 4>;
> -		xlnx,ipi-id = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		/* APU<->RPU0 IPI mailbox controller */
> -		ipi_mailbox_rpu0: mailbox@ff990400 {
> -			reg = <0xff990400 0x20>,
> -			      <0xff990420 0x20>,
> -			      <0xff990080 0x20>,
> -			      <0xff9900a0 0x20>;
> -			reg-names = "local_request_region",
> -				    "local_response_region",
> -				    "remote_request_region",
> -				    "remote_response_region";
> -			#mbox-cells = <1>;
> -			xlnx,ipi-id = <1>;
> -		};
> -		/* APU<->RPU1 IPI mailbox controller */
> -		ipi_mailbox_rpu1: mailbox@ff990440 {
> -			reg = <0xff990440 0x20>,
> -			      <0xff990460 0x20>,
> -			      <0xff990280 0x20>,
> -			      <0xff9902a0 0x20>;
> -			reg-names = "local_request_region",
> -				    "local_response_region",
> -				    "remote_request_region",
> -				    "remote_response_region";
> -			#mbox-cells = <1>;
> -			xlnx,ipi-id = <2>;
> -		};
> -	};
> -	rpu0 {
> -		...
> -		mboxes = <&ipi_mailbox_rpu0 0>,
> -			 <&ipi_mailbox_rpu0 1>;
> -		mbox-names = "tx", "rx";
> -	};
> -	rpu1 {
> -		...
> -		mboxes = <&ipi_mailbox_rpu1 0>,
> -			 <&ipi_mailbox_rpu1 1>;
> -		mbox-names = "tx", "rx";
> -	};
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> new file mode 100644
> index 000000000000..8019a7b294ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Xilinx IPI Mailbox controller bindings
> +
> +description:
> +  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
> +  messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
> +  agent owns registers used for notification and buffers for message.
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-ipi-mailbox
> +
> +  reg:
> +    maxItems: 4
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  xlnx,ipi-id:
> +    description: Xilinx IPI agent id
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - xlnx,ipi-id
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +     zynqmp_ipi {
> +          compatible = "xlnx,zynqmp-ipi-mailbox";
> +          interrupt-parent = <&gic>;
> +          interrupts = <0 29 4>;
> +          xlnx,ipi-id = <0>;
> +     };
> +
> +          /* Client node APU<->RPU0 IPI mailbox controller */
> +          ipi_mailbox_rpu0: mailbox@ff990400 {
> +               reg = <0xff990400 0x20>,
> +                     <0xff990420 0x20>,
> +                     <0xff990080 0x20>,
> +                     <0xff9900a0 0x20>;
> +               reg-names = "local_request_region",
> +                        "local_response_region",
> +                        "remote_request_region",
> +                        "remote_response_region";
> +               #mbox-cells = <1>;
> +               xlnx,ipi-id = <1>;
> +          };

This doesn't match the original example nor the schema. And also the 
actual dts files based on dtbs_check...

Rob
