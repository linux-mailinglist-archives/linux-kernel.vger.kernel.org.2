Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E1432D4A4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhCDNxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241651AbhCDNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614865891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXMZR9NYDhRem8zZDsBYRp3qs3UWS1OqKUVN3Wolnks=;
        b=E6lcqrXI1Nm/0M/i7JAO112QFRkDOmk/gjSXei6q3Igv8x/vzN6c9PpNjkr53Nkga9Ncg1
        RweuwpT5v5eqZ35xXaPU7Mvk+XI7jbYkmTPWl8DPSq8jAxBVD9lydvSwEdw4yITvytvqiN
        zL/FJtgPQJExhwGqo7ijHE+Znsp9lv0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-AxivtlA6MLam6dbRvg4hWA-1; Thu, 04 Mar 2021 08:51:27 -0500
X-MC-Unique: AxivtlA6MLam6dbRvg4hWA-1
Received: by mail-qt1-f200.google.com with SMTP id i16so10236985qtv.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lXMZR9NYDhRem8zZDsBYRp3qs3UWS1OqKUVN3Wolnks=;
        b=kT43wNqyzSC0D+xBVvLMEYS3VWzqk3HHa1oM2DOJuXBjfkoWyIY8uvIArla5YNfuZ2
         SbYo8XQaMw3Qn6/kgiUVYWb/z5XOq6jBduKskGfMSqD6BBYvy8ySkVUFXkKPt6LqqZ9O
         oVVj6O6PBZErWUMUaehhsqLfNM0cYl+wIO18pjbInNyC1gaID7Tniy/QHUQRPyoeutAJ
         vRRXluUPEqJXpdZCAEa4D4hUlzDTDpTuo+mFYAbrQa5plADsqFTe2lf8VwsmYNcBbwu/
         YI2nkWjYK48761trno8ozknXLwGqfK2wUxhIDaDM+4C3ItIZbljE3sBXK6WTFmpCiex3
         nSzA==
X-Gm-Message-State: AOAM533JciuzJpzLLYTHh5jAFx0A2y1+RH/RtfIwv/6/AacJV0Dypr/i
        +WSg8jHZHbmsAnWNSCXEihuWWd39D6Ab6FTjqvUfCCP+zwTOI93YWGPe11GbNXNk/4qGvuAtonT
        1djW5SK5eXmvtlUrPY84UsvR7
X-Received: by 2002:a0c:c488:: with SMTP id u8mr4207331qvi.9.1614865887157;
        Thu, 04 Mar 2021 05:51:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydKS0YxaVm2uUcf5l7dt7ZzBbAEphGXDYwwuYbgKa51KOqdSpIeFGKh+wa05uWEvmNF6ixrA==
X-Received: by 2002:a0c:c488:: with SMTP id u8mr4207320qvi.9.1614865886891;
        Thu, 04 Mar 2021 05:51:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z5sm3703621qtc.42.2021.03.04.05.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:51:26 -0800 (PST)
Subject: Re: [PATCH v2 2/2] fpga: Add support for Xilinx DFX AXI Shutdown
 manager
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Cc:     git@xilinx.com
References: <20210211051148.16722-1-nava.manne@xilinx.com>
 <20210211051148.16722-3-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <156f2240-2360-b47a-26af-cfd4eb88ddf5@redhat.com>
Date:   Thu, 4 Mar 2021 05:51:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211051148.16722-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/21 9:11 PM, Nava kishore Manne wrote:
> This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
> shutdown manager IP. It can be used to safely handling the AXI traffic
> on a Reconfigurable Partition when it is undergoing dynamic reconfiguration
> and there by preventing system deadlock that may occur if AXI transactions
> are interrupted during reconfiguration.
>
> PR-Decoupler and AXI shutdown manager are completely different IPs.
> But both the IP registers are compatible and also both belong to the
> same sub-system (fpga-bridge).So using same driver for both IP's.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Fixed some minor coding issues as suggested by
>                  Tom Rix.
>
>  drivers/fpga/Kconfig               |  9 +++++++-
>  drivers/fpga/xilinx-pr-decoupler.c | 37 ++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5645226ca3ce..bf85b9a65ec2 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -118,10 +118,17 @@ config XILINX_PR_DECOUPLER
>  	depends on FPGA_BRIDGE
>  	depends on HAS_IOMEM
>  	help
> -	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler.
> +	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
> +	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
>  	  The PR Decoupler exists in the FPGA fabric to isolate one
>  	  region of the FPGA from the busses while that region is
>  	  being reprogrammed during partial reconfig.
> +	  The Dynamic Function eXchange AXI shutdown manager prevents
> +	  AXI traffic from passing through the bridge. The controller
> +	  safely handles AXI4MM and AXI4-Lite interfaces on a
> +	  Reconfigurable Partition when it is undergoing dynamic
> +	  reconfiguration, preventing the system deadlock that can
> +	  occur if AXI transactions are interrupted by DFX.
>  
>  config FPGA_REGION
>  	tristate "FPGA Region"
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 7d69af230567..78a6f5324193 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2017, National Instruments Corp.
> - * Copyright (c) 2017, Xilix Inc
> + * Copyright (c) 2017, Xilinx Inc
>   *
>   * FPGA Bridge Driver for the Xilinx LogiCORE Partial Reconfiguration
>   * Decoupler IP Core.
> @@ -18,7 +18,12 @@
>  #define CTRL_CMD_COUPLE		0
>  #define CTRL_OFFSET		0
>  
> +struct xlnx_config_data {
> +	const char *name;
> +};
> +
>  struct xlnx_pr_decoupler_data {
> +	const struct xlnx_config_data *ipconfig;
>  	void __iomem *io_base;
>  	struct clk *clk;
>  };
> @@ -76,15 +81,28 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
>  	.enable_show = xlnx_pr_decoupler_enable_show,
>  };
>  
> +static const struct xlnx_config_data decoupler_config = {
> +	.name = "Xilinx PR Decoupler",
> +};
> +
> +static const struct xlnx_config_data shutdown_config = {
> +	.name = "Xilinx DFX AXI Shutdown Manager",
> +};
> +
>  static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
> -	{ .compatible = "xlnx,pr-decoupler-1.00", },
> -	{ .compatible = "xlnx,pr-decoupler", },
> +	{ .compatible = "xlnx,pr-decoupler-1.00", .data = &decoupler_config },
> +	{ .compatible = "xlnx,pr-decoupler", .data = &decoupler_config },
> +	{ .compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
> +					.data = &shutdown_config },
> +	{ .compatible = "xlnx,dfx-axi-shutdown-manager",
> +					.data = &shutdown_config },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
>  
>  static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct xlnx_pr_decoupler_data *priv;
>  	struct fpga_bridge *br;
>  	int err;
> @@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	if (np) {
> +		const struct of_device_id *match;
> +
> +		match = of_match_node(xlnx_pr_decoupler_of_match, np);
> +		if (match && match->data)
> +			priv->ipconfig = match->data;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(priv->io_base))
> @@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	clk_disable(priv->clk);
>  
> -	br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
> +	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
>  				     &xlnx_pr_decoupler_br_ops, priv);
>  	if (!br) {
>  		err = -ENOMEM;
> @@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	err = fpga_bridge_register(br);
>  	if (err) {
> -		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
> +		dev_err(&pdev->dev, "unable to register %s",
> +			priv->ipconfig->name);
>  		goto err_clk;
>  	}
>  

The changes I asked for were made.

Reviewed-by: Tom Rix <trix@redhat.com>

