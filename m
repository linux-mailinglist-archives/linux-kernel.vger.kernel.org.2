Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EA32404E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhBXOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:50:38 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36895 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhBXNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:40:03 -0500
Received: by mail-wr1-f54.google.com with SMTP id v15so1918232wrx.4;
        Wed, 24 Feb 2021 05:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dq4qL90OCu8ib/iGkBDTsJu+uvHjzn/c/ym0u/ajUA0=;
        b=a3qCBCQ1x8jbqz3Ga3Q3muTTwi2OMwKAAa5lNUOcBKlvfLCSyHVXpRbhTdIXqiA1iG
         Nq0up29Jkf95kN6pJAQ5D7sAiKFDRepTw3kDLjojWnFrQITfK01uMfO5k2ND3HI1n71Z
         xXtYohcy4NUR4hLvt2fWPHPYOOzfHbEwFvP/347Oxd2c7J6U+wLGKP0ncuEJZYvS1gJM
         qjYR9FREWYyIQhxT2WCeNCdClC5C86HTiLGyuvU8I0ghR8hBP7XGXnTibAc9nFgxoRiR
         Q8L+ctsYQSIVVcMFS7YTGXW94uawV55QtUGstekV3AVLJ9lSYv2klkFXiOiFLYEbe8qV
         dMjA==
X-Gm-Message-State: AOAM5308otmj9X3o8LsXWJuY8Mv2rsiItEc0LIec3BxcQlbzsvBzot8B
        luMvZdbl+zwKa5mqzcVT0XR6G0DraC91vw==
X-Google-Smtp-Source: ABdhPJxhksCAGOk3JAcFq15JrepLPez2XrzSDA7b9WxJVd1Jzq2verZqIaVftogrwqD0KjajojtEsw==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr26874209wrq.310.1614173779234;
        Wed, 24 Feb 2021 05:36:19 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j125sm3000640wmb.44.2021.02.24.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:36:18 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:36:16 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <YDZWUGcKet/lNWlF@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-4-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-4-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianjun,

Thank you for all the work here!

[...]
> + * struct mtk_pcie_port - PCIe port information
> + * @dev: pointer to PCIe device
> + * @base: IO mapped register base
> + * @reg_base: Physical register base
> + * @mac_reset: mac reset control
> + * @phy_reset: phy reset control
> + * @phy: PHY controller block
> + * @clks: PCIe clocks
> + * @num_clks: PCIe clocks count for this port

It would be "MAC" and "PHY" in the above.

[...]
> + * mtk_pcie_config_tlp_header
> + * @bus: PCI bus to query
> + * @devfn: device/function number
> + * @where: offset in config space
> + * @size: data size in TLP header
> + *
> + * Set byte enable field and device information in configuration TLP header.

The kernel-doc above might be missing brief function description.  See
the following for more concrete example:

  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

[...]
> +static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
> +				    resource_size_t cpu_addr,
> +				    resource_size_t pci_addr,
> +				    resource_size_t size,
> +				    unsigned long type, int num)
> +{
> +	void __iomem *table;
> +	u32 val;
> +
> +	if (num >= PCIE_MAX_TRANS_TABLES) {
> +		dev_err(port->dev, "not enough translate table[%d] for addr: %#llx, limited to [%d]\n",

The wording of this error message is a little confusing.

> +			num, (unsigned long long) cpu_addr,

No space between the bracket and the variable name.

[...]
> +	err = phy_init(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PCIe phy\n");
> +		goto err_phy_init;
> +	}
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PCIe phy\n");
> +		goto err_phy_on;
> +	}
[...]

It would be "PHY" in the error messages above.

[...]
> +	if (err) {
> +		dev_err(dev, "clock init failed\n");
> +		goto err_clk_init;
> +	}
[...]

A nitpick, so feel free to ignore it, of course.  What about "failed to
initialize clock" to keep the style consistent.

[...]
> +	err = mtk_pcie_startup_port(port);
> +	if (err) {
> +		dev_err(dev, "PCIe startup failed\n");
[...]

Also a nitpick.  What about "failed to bring PCIe link up"?

Krzysztof
