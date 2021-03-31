Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B835009D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhCaMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235450AbhCaMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E315461959;
        Wed, 31 Mar 2021 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617194783;
        bh=TQkoHACl/sFM+5iuM6x9rFOysAjN+duolQetZcUwOWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tqRxQ6KO5Yo+HpqJhww4Y98I+1ZL0YA14AIiEGQRGDc2J8BaKegd6HvMh8s2S6Pu9
         hujaLdAsFyJWfrTLTxPDLXq/RrxSsZvSQVHG5SSedEqo4L8MYNBtUKtgzMNMKFp7Oy
         NedtbimR2scRy2fmCQCZaUkM3CD2+UW+JIqAaRgqPdWq4W58jEsGaIefGBgdtV1XsE
         +TwJHetOtZuV+LQVDRqeDSS/ge23LlmogViLNIDdgVZYhjbWCoDB2AEqosviKt12yI
         CuSM46EowOq91jlcKyYWy3iuUGVuWmqHCO87SX1e22aGLxwFxJo3FSxVXghWjmMPMy
         3xx3hJErZ0+/A==
Date:   Wed, 31 Mar 2021 18:16:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Atul Gopinathan <leoatul12@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-staging@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 (RESEND) 1/7] phy: phy-hi3670-usb3: move driver from
 staging into phy
Message-ID: <YGRvG+3sD0gX2I+b@vkoul-mobl.Dlink>
References: <cover.1616695231.git.mchehab+huawei@kernel.org>
 <36c31dcdcd49d5a728a1fe4040bbaef5268d7f79.1616695231.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c31dcdcd49d5a728a1fe4040bbaef5268d7f79.1616695231.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-21, 19:05, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.

Overall lgtm, some nits below. With those fixed:

Acked-By: Vinod Koul <vkoul@kernel.org>

> +static int hi3670_phy_cr_clk(struct regmap *usb31misc)
> +{
> +	int ret;
> +
> +	/* Clock up */
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +				 CFG54_USB31PHY_CR_CLK, CFG54_USB31PHY_CR_CLK);
> +	if (ret)
> +		return ret;
> +
> +	/* Clock down */
> +	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
> +				 CFG54_USB31PHY_CR_CLK, 0);
> +
> +	return ret;

return regmap_update_bits() ?
 (i see few more in driver like this, pls change others as well)

> +static int hi3670_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
> +{
> +	int reg;
> +	int i;
> +	int ret;

all these could be in a single line

-- 
~Vinod
