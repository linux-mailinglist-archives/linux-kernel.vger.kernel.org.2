Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7C32D20F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhCDLza convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Mar 2021 06:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCDLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:55:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E3FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 03:54:26 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmYg-0001x8-GK; Thu, 04 Mar 2021 12:54:22 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHmYf-0004l2-GS; Thu, 04 Mar 2021 12:54:21 +0100
Message-ID: <eda54f59067bdefd13af9ad9c5c254cb1b04049b.camel@pengutronix.de>
Subject: Re: [PATCH v4 06/13] phy: cadence: cadence-sierra: Move all
 reset_control_get*() to a separate function
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Date:   Thu, 04 Mar 2021 12:54:21 +0100
In-Reply-To: <20210304044122.15166-7-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
         <20210304044122.15166-7-kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-04 at 10:11 +0530, Kishon Vijay Abraham I wrote:
> No functional change. Group devm_reset_control_get() and
> devm_reset_control_get_optional() to a separate function.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 36 ++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index 7bf1b4c7774a..935f165404e4 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -509,6 +509,28 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
>  	return 0;
>  }
>  
> +static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
> +				      struct device *dev)
> +{
> +	struct reset_control *rst;
> +
> +	rst = devm_reset_control_get(dev, "sierra_reset");

Please use
	rst = devm_reset_control_get_exclusive(dev, "sierra_reset");
here ...

> +	if (IS_ERR(rst)) {
> +		dev_err(dev, "failed to get reset\n");
> +		return PTR_ERR(rst);
> +	}
> +	sp->phy_rst = rst;
> +
> +	rst = devm_reset_control_get_optional(dev, "sierra_apb");

... and
	rst = devm_reset_control_get_optional_exclusive(dev, "sierra_apb");	
here (no functional change).

With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
