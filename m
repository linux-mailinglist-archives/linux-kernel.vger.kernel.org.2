Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A493C92CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhGNVLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:11:03 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:42623 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbhGNVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:11:02 -0400
Received: by mail-il1-f173.google.com with SMTP id h3so2961814ilc.9;
        Wed, 14 Jul 2021 14:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAPaeGEp/AANcAQgWlZa+QgNEPGZZ4TuRtLmdFAhKuw=;
        b=HgAunjRWJ893J6ne6GCXhRJQMHrBkiXhN7QxuKOnExFCSL8CAu3H2d2DO58R2VEkoC
         7iXxjXLycD8xSJW8DpPMNK07W27zkUM7d6/94hkm9ksB6/PAO2BJlrbMaKHbwR3qrfB/
         2T+ajDsPqUlDGqc0xmJ1Dcn6n9eoGVwlWJuUAjM6v+wncb818RKF0msb+AGxjiybndHI
         4Mq09pElRNMjgXRAhILBEkwKOprr0kUAiLwIYvcwi7i4lm0/fztO1W5SB2fIQP4JXXAE
         e6GRfCmaa9XNnGnz8V5ku0yDKAsUSuiWGmoeR/SDVhrwtVN0TDZj4Nsc+BOblFRkCczK
         LC4w==
X-Gm-Message-State: AOAM530BQzRpzgt/QhV1q16XTlZWF3daD/1RW9vK/Zxw8HBEpjHSWB/o
        h447/bcAX78koXq4BCz20g==
X-Google-Smtp-Source: ABdhPJyzK8EMsz9Rwe9G0w6JNRub33pWCdo439pcbbxkuASJi0epEqj9Y00+tFVqrsNKoTF1FlSmYQ==
X-Received: by 2002:a05:6e02:666:: with SMTP id l6mr7933637ilt.245.1626296889484;
        Wed, 14 Jul 2021 14:08:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t24sm1902231ioh.24.2021.07.14.14.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 14:08:08 -0700 (PDT)
Received: (nullmailer pid 3525932 invoked by uid 1000);
        Wed, 14 Jul 2021 21:08:03 -0000
Date:   Wed, 14 Jul 2021 15:08:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, steen.hegelund@microchip.com,
        bjarni.jonasson@microchip.com, ioana.ciornei@nxp.com,
        likaige@loongson.cn, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@xilinx.com,
        radhey.shyam.pandey@xilinx.com
Subject: Re: [PATCH 2/3] dt-bindings: mscc: Add RGMII RX and TX delay tuning
Message-ID: <20210714210803.GA3522064@robh.at.kernel.org>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
 <20210629094038.18610-3-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629094038.18610-3-harini.katakam@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 03:10:37PM +0530, Harini Katakam wrote:
> Add optional properties to tune RGMII RX and TX delay.
> 
> Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Your S-o-b should be last as the last one to touch this.

> ---
>  .../devicetree/bindings/net/mscc-phy-vsc8531.txt         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 87a27d775d48..e201d24d8e27 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -33,7 +33,14 @@ Optional properties:
>  			  VSC8531_DUPLEX_COLLISION (8).
>  - load-save-gpios	: GPIO used for the load/save operation of the PTP
>  			  hardware clock (PHC).
> -
> +- vsc8531,rx-delay	: RGMII RX delay. Allowed values are defined in

'vsc8531' is not a vendor. The form is <vendor>,<propname>.

> +			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
> +			  Default value, set by the driver is
> +			  VSC8531_RGMII_CLK_DELAY_2_0_NS.
> +- vsc8531,tx-delay	: RGMII TX delay. Allowed values are defined in
> +			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
> +			  Default value, set by the driver is
> +			  VSC8531_RGMII_CLK_DELAY_2_0_NS.
>  
>  Table: 1 - Edge rate change
>  ----------------------------------------------------------------|
> -- 
> 2.17.1
> 
> 
