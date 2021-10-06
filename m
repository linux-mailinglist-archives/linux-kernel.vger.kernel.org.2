Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E027C4234BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhJFAFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:05:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42988 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhJFAFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:05:39 -0400
Received: by linux.microsoft.com (Postfix, from userid 1046)
        id D8A1C20B861E; Tue,  5 Oct 2021 17:03:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8A1C20B861E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1633478627;
        bh=Lba9wJEZ48njfaVv79S/RD8k06p4EsANJ/0HCRU1yKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1tmXIJ1YElDF76BCq50LrBsRxfIyeMYNGIXdZvUB1ikVsM92HjWmTlGOc3YsEXoL
         7Tj043DIAAMst2f3czz/PcRI8/AwSiIU5oIOSd2+ZW8vHm2Igf5ILftBNUKFUGKF/M
         iJ70OmGEujqxsd0Pi/QyxnQF06Ro/tIuJVGAyeuU=
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
To:     zev@bewilderbeest.net
Cc:     andrew@aj.id.au, clg@kaod.org, gregkh@linuxfoundation.org,
        jk@codeconstruct.com.au, joel@jms.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, michael@walle.cc,
        miquel.raynal@bootlin.com, openbmc@lists.ozlabs.org,
        p.yadav@ti.com, richard@nod.at, tudor.ambarus@microchip.com,
        vigneshr@ti.com, Dhananjay Phadke <dphadke@linux.microsoft.com>
Subject: Re: [PATCH 3/6] mtd: spi-nor: aspeed: Refactor registration/unregistration
Date:   Tue,  5 Oct 2021 17:03:14 -0700
Message-Id: <1633478594-16793-1-git-send-email-dphadke@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20210929115409.21254-4-zev@bewilderbeest.net>
References: <20210929115409.21254-4-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Sep 2021, Zev Weiss wrote:

> We now have separate functions for registering and unregistering
> individual flash chips, instead of the entire controller.  This is a
> preparatory step for allowing userspace to request that a specific
> chip be attached or detached at runtime.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
> drivers/mtd/spi-nor/controllers/aspeed-smc.c | 73 ++++++++++++--------
> 1 file changed, 45 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> index 7225870e8b18..3c153104a905 100644
> --- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> +++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
> @@ -107,9 +107,10 @@ struct aspeed_smc_controller {
> 	const struct aspeed_smc_info *info;	/* type info of controller */
> 	void __iomem *regs;			/* controller registers */
> 	void __iomem *ahb_base;			/* per-chip windows resource */
> +	struct resource *ahb_res;		/* resource for AHB address space */
> 	u32 ahb_window_size;			/* full mapping window size */
>
> -	struct aspeed_smc_chip *chips[];	/* pointers to attached chips */
> +	struct aspeed_smc_chip *chips[];	/* pointers to connected chips */
> };
>
> /*
> @@ -399,15 +400,24 @@ static ssize_t aspeed_smc_write_user(struct spi_nor *nor, loff_t to,
> 	return len;
> }
>
> +static int aspeed_smc_unregister_chip(struct aspeed_smc_chip *chip)
> +{
> +	return mtd_device_unregister(&chip->nor.mtd);
> +}
> +
> static int aspeed_smc_unregister(struct aspeed_smc_controller *controller)
> {
> 	struct aspeed_smc_chip *chip;
> -	int n;
> +	int n, ret;
>
> 	for (n = 0; n < controller->info->nce; n++) {
> 		chip = controller->chips[n];
> -		if (chip)
> -			mtd_device_unregister(&chip->nor.mtd);
> +		if (chip) {
> +			ret = aspeed_smc_unregister_chip(chip);
> +			if (ret)
> +				dev_warn(controller->dev, "failed to unregister CS%d: %d\n",
> +				         n, ret);
> +		}
> 	}
>
> 	return 0;
> @@ -756,14 +766,39 @@ static const struct spi_nor_controller_ops aspeed_smc_controller_ops = {
> 	.write = aspeed_smc_write_user,
> };
>
> -static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
> -				  struct device_node *np, struct resource *r)
> +static int aspeed_smc_register_chip(struct aspeed_smc_chip *chip)
> {
> -	const struct spi_nor_hwcaps hwcaps = {
> +	static const struct spi_nor_hwcaps hwcaps = {
> 		.mask = SNOR_HWCAPS_READ |
> 			SNOR_HWCAPS_READ_FAST |
> 			SNOR_HWCAPS_PP,
> 	};
> +	int ret;
> +
> +	ret = aspeed_smc_chip_setup_init(chip, chip->controller->ahb_res);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * TODO: Add support for Dual and Quad SPI protocols attach when board
> +	 * support is present as determined by of property.
> +	 */
> +	ret = spi_nor_scan(&chip->nor, NULL, &hwcaps);
> +	if (ret)
> +		goto out;
> +
> +	ret = aspeed_smc_chip_setup_finish(chip);
> +	if (ret)
> +		goto out;
> +
> +	ret = mtd_device_register(&chip->nor.mtd, NULL, 0);
> +out:
> +	return ret;
> +}

I was looking into this driver probe walking sub-nodes.

It looks like all controller drivers are doing / have to do similar work -

(1) Parse common dt bindings documented in Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
(2) Run spi_nor_scan() with tweaked/reduced capabilities.
(3) mtd_register_device().

It would be good to absorb this workflow in mtd/spi-nor core and add 'reserved' as common
dt property to avoid (2) and (3) from probe.


Regards,
Dhananjay

