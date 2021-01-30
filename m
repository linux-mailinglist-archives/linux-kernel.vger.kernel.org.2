Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69813096DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhA3Ql5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3Qlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:41:45 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CDBC061573;
        Sat, 30 Jan 2021 08:31:44 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kg20so17644888ejc.4;
        Sat, 30 Jan 2021 08:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNHQ/r8xjwlATTjyCST6zMPoqhT2XCo3FFqzLsunPus=;
        b=PNbChg72Ox2MNBPK0o8btZ0knX9PMLBSFBZ7Jamtm8xQRqTPG1ABYUUX9B7a0GiCTU
         jb+asUYHW+7omLKFqkS2YBmnsjWwZktyv9GqWfIjZlTRst6cn+es4oR6HIXyVM9u3PLh
         AxwzB2nyVjjvoDNzXmfueArV/9r+qy9Z4j1LBsp5WDEVGEqp9aAWpTEai4zxXDFe4OO5
         XI5nr7GX45lpnCKy4eCpZ/86sf7DJdOtbaGqIK4lgIMKP3T+QwqGUTf86O7yudJeMUW/
         U9VFG46wwaNWWRcOe2YRERxDEKa4PHLJPtKPTzTTqR9cZ2MVL5snds8hCPaqHomVoFnT
         NwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNHQ/r8xjwlATTjyCST6zMPoqhT2XCo3FFqzLsunPus=;
        b=ik+lKbNn1YTktidsijvK1xmTsn3GOrpi+AMJVLp+k1LbdcFnsURUuWyS2G1HR5IPMN
         v6Ef6P+WkKpH/dP/1355WPqrrR2xELqiUAsUwpwHlRW89C1RJG+j0bMxro5nChVlBtJO
         xPazTH/1S5x2QfqQ4gzUETIqvox4u/KLBObD/aYr9f0jaWEnl3oVHTYI0vRFU9cMym+K
         xxnxh0v8nNQlsHKR8Do0YUfKoBEBS+d5mRO+mbDbcLRA8zkRd6o4qzC53m4G2B8nrhrG
         loUyt8XrLooNDlzArq/f09ezEV3UM2PUThR6mEp/xJTozkgUtRb1CyVsWzKMJPMLZChV
         WjDg==
X-Gm-Message-State: AOAM530B8I5Upj6I5T7HdaPbLfniWNFk7V/D6yowOvnADfsiuowJfAMH
        Km+OnQJ5CLq/6EkURkzaARo=
X-Google-Smtp-Source: ABdhPJx4sfuNdr/CIEPwr+X/9AqBHXOOJorh1yfBEmH/QeguDIUDZzrZbT2LkK7ie+RUBrxf9u/tmQ==
X-Received: by 2002:a17:906:26ca:: with SMTP id u10mr9786284ejc.165.1612024302970;
        Sat, 30 Jan 2021 08:31:42 -0800 (PST)
Received: from [10.8.0.2] (terefe.re. [5.255.96.200])
        by smtp.gmail.com with ESMTPSA id p15sm5474059ejd.121.2021.01.30.08.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 08:31:42 -0800 (PST)
Subject: Re: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Chen <peter.chen@nxp.com>
References: <20201223162403.10897-1-pali@kernel.org>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <8560857d-a090-1e18-bdf0-3389897716a2@gmail.com>
Date:   Sat, 30 Jan 2021 17:31:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20201223162403.10897-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 23.12.2020 o 17:24, Pali Rohár pisze:
> Older ATF does not provide SMC call for USB 3.0 phy power on functionality
> and therefore initialization of xhci-hcd is failing when older version of
> ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.
> 
> [    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
> [    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
> [    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95
> 
> This patch calls phy_power_on() in xhci_mvebu_a3700_init_quirk() function
> and in case it returns -EOPNOTSUPP then XHCI_SKIP_PHY_INIT quirk is set to
> instruct xhci-plat to skip PHY initialization.
> 
> This patch fixes above failure by ignoring 'not supported' error in
> aardvark driver. In this case it is expected that phy is already power on.
> 
> It fixes initialization of xhci-hcd on Espressobin boards where is older
> Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.
> 
> This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
> armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
> and therefore xhci-hcd on Espressobin with older ATF started failing.
> 
> Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
> Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization
> 
> ---
> 
> When applying this patch, please include additional line
> 
> Cc: <stable@vger.kernel.org> # 5.1+: <COMMIT_ID>: usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT quirk
> 
> with correct COMMIT_ID of mentioned patch which is available in the thread:

Hi,
and sorry for late reply, but that might be good reminder for maintainers.
Anyway I tested this patch in conjunction with v2 from this topic:
> https://lore.kernel.org/lkml/20201221150903.26630-1-pali@kernel.org/T/#u
The USB ports work flawlessly with older ATF, so:

Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

At OpenWrt we are using patch which removes Comphy assignments from nodes
in dts, but that is sub optimal, since that "discriminates" users with
updated ATF. I would prefer this patch instead of what we are doing now
in OpenWrt.

Thanks.

> 
> As mentioned patch is required for change in this patch to work. Above
> mentioned patch is prerequisite for this patch and therefore needs to be
> reviewed and applied prior this patch.
> 
> Note that same issue as in this USB 3.0 PHY patch was already resolved and
> applied also for SATA PHY and PCIe PHY on A3720 SOC in following commits:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45aefe3d2251e4e229d7662052739f96ad1d08d9
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6
> 
> And these commits were also backported to stable kernel versions (where
> were affected commits which broke drivers initialization).
> ---
>  drivers/usb/host/xhci-mvebu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
> index 60651a50770f..ec4f6d6e44cf 100644
> --- a/drivers/usb/host/xhci-mvebu.c
> +++ b/drivers/usb/host/xhci-mvebu.c
> @@ -8,6 +8,7 @@
>  #include <linux/mbus.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>  
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -77,9 +78,43 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
>  int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
>  {
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> +	struct device *dev = hcd->self.controller;
> +	struct phy *phy;
> +	int ret;
>  
>  	/* Without reset on resume, the HC won't work at all */
>  	xhci->quirks |= XHCI_RESET_ON_RESUME;
>  
> +	/* Old bindings miss the PHY handle */
> +	phy = of_phy_get(dev->of_node, "usb3-phy");
> +	if (IS_ERR(phy) && PTR_ERR(phy) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +	else if (IS_ERR(phy))
> +		goto phy_out;
> +
> +	ret = phy_init(phy);
> +	if (ret)
> +		goto phy_put;
> +
> +	ret = phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> +	if (ret)
> +		goto phy_exit;
> +
> +	ret = phy_power_on(phy);
> +	if (ret == -EOPNOTSUPP) {
> +		/* Skip initializatin of XHCI PHY when it is unsupported by firmware */
> +		dev_warn(dev, "PHY unsupported by firmware\n");
> +		xhci->quirks |= XHCI_SKIP_PHY_INIT;
> +	}
> +	if (ret)
> +		goto phy_exit;
> +
> +	phy_power_off(phy);
> +phy_exit:
> +	phy_exit(phy);
> +phy_put:
> +	of_phy_put(phy);
> +phy_out:
> +
>  	return 0;
>  }
> 

-- 
TMN
