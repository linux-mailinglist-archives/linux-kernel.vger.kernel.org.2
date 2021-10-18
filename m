Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3B432828
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhJRUKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:10:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53002 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhJRUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634587670; x=1666123670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jU2TIbW2nRIVyj8Hr+GCR3NNoC+DnWdiYc46k5ir78Q=;
  b=SVkt1rmFzI7oH2eP4pI6+2wa/CdXNTueyehCsuGczE/HvqnXsqSvrAa7
   RcVC2xFe2BBgjkCMspd6ulecF2FxEZ4ec45Kr0O/vWlcvhBKQBvBAtTwM
   Bl2OSTBrseiSKDpqOZITS+lHdaGmJCTDVF0RZ7g1SdT0KYR4pw1vH9HkP
   kJ7c9/FlwIDbKiBDYKLRtCPvJT1k7qFogx44Xm1JFF0L/xbSd8zQ2j+AQ
   AvRdmhT3d6ogrtyOJHTtK8t6jA8MDV6hukdRvnkVzwcjIZndWOPOYkvME
   dVSsDFZmSB6I5ZB3q43BQdIG2bs8WocjzZgl43Ybybe73Yw1f6jlSlSQe
   g==;
IronPort-SDR: LNpVprfZsbaYgkP7MRcdRpXlrF8FZ7NmDCIjbBzr/YXNX5iKtjTHEzTX0Rc8dq4m9GJR0WCVW/
 tem9yOwqBlicNf6OPg2kdRo0LJaLVNKFaPoxn6eL6m0iI6Htie4nKzxwNDGKOqOAL2C6jUojTb
 shEztbC6YHsC7mnWcP2HgdK2ltpuPNSdLySJ+/wE/iuDjvXXnH8PqJsGd0gD5SlKB9DrUSDyw3
 8aB1kIn6kb3lUdNUF4J3Qb+0qRS/janzi8NMH84cEpX2rwqCbbqL1mAkMrCnboo7suUZIsqFqr
 L0LmKv4qzw3Md4KgPe4UZx2B
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="133487798"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 13:07:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 13:07:43 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 18 Oct 2021 13:07:43 -0700
Date:   Mon, 18 Oct 2021 22:09:15 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
CC:     <robh+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <nicolas.ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Manohar.Puri@microchip.com>
Subject: Re: [PATCH v8 3/3] clk: lan966x: Add lan966x SoC clock driver
Message-ID: <20211018200915.5jdgf6lqrs633vck@soft-dev3-1.localhost>
References: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
 <20211008082635.31774-4-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20211008082635.31774-4-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/08/2021 13:56, Kavyasree Kotagiri wrote:
> This adds Generic Clock Controller driver for lan966x SoC.

Hi Kavya,

> 
> +#define DIV_MAX		256
> +
> +static const char *clk_names[N_CLOCKS] = {
> +	"qspi0", "qspi1", "qspi2", "sdmmc0",
> +	"pi", "mcan0", "mcan1", "flexcom0",
> +	"flexcom1", "flexcom2", "flexcom3",
> +	"flexcom4", "timer", "usb_refclk",
> +};

Aren't these names a little bit generic, especially 'timer'?
The problem that I am seeing, if there is another clock driver that
register a clock with the same name, then this will fail. Here is the
check for this[1]

> +
> +static int lan966x_clk_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *hw_data;
> +	struct device *dev = &pdev->dev;
> +	int i;
> +
> +	hw_data = devm_kzalloc(dev, sizeof(*hw_data), GFP_KERNEL);

Is this correct? Shouldn't be

devm_kzalloc(dev, struct_size(hw_data, hws, N_CLOCKS), GFP_KERNEL);

> +	if (!hw_data)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	init.ops = &lan966x_gck_ops;
> +
> +	hw_data->num = N_CLOCKS;
> +
> +	for (i = 0; i < N_CLOCKS; i++) {
> +		init.name = clk_names[i];
> +		hw_data->hws[i] = lan966x_gck_clk_register(dev, i);
> +		if (IS_ERR(hw_data->hws[i])) {
> +			dev_err(dev, "failed to register %s clock\n",
> +				init.name);
> +			return PTR_ERR(hw_data->hws[i]);
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
> +}
> +
> +static const struct of_device_id lan966x_clk_dt_ids[] = {
> +	{ .compatible = "microchip,lan966x-gck", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lan966x_clk_dt_ids);
> +
> +static struct platform_driver lan966x_clk_driver = {
> +	.probe  = lan966x_clk_probe,
> +	.driver = {
> +		.name = "lan966x-clk",
> +		.of_match_table = lan966x_clk_dt_ids,
> +	},
> +};
> +builtin_platform_driver(lan966x_clk_driver);
> +
> +MODULE_AUTHOR("Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>");
> +MODULE_DESCRIPTION("LAN966X clock driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 

[1] https://elixir.bootlin.com/linux/latest/source/drivers/clk/clk.c#L3423

-- 
/Horatiu
