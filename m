Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1903B7EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhF3ILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhF3ILo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:11:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E198B61D05;
        Wed, 30 Jun 2021 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625040556;
        bh=AnB297cq1an/p5yM1VCuQYRJ6yhgkedt4mx7LKYvZzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AU3RSqVW03Rg3PblGAIIwZFX7cED75mxXijroSA76zyv4O15enNPeGZ1uO2VKnQoI
         3MWxKUU7S9ecw7L/bQeGzyiYYjY2NQh2HcwqplBbks2DMjNN95hnHFa3ZECF/KWm7a
         14PE3Zb319JGgn5ZmWNFJC1vS7ITJl1img7SxY92WMxgzoQtyjxa3LSzXzckZ1B0/3
         RN2OevOb+fflo/cG4H6yVmepAoU/udEWAlpZ9UuwRV8MmWlc6FpQ+SMYHSINp9GUfR
         cvHgtSsjLN/daSKbzfh8sR4VM7Ig1SVz5RG6Hb7izazJVbTLCQ5ey+jrR9r1imKSHm
         IqDH0xTC7KJtQ==
Date:   Wed, 30 Jun 2021 10:09:11 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] regulator: hi6421v600: Fix getting wrong drvdata
 that causes boot failure
Message-ID: <20210630100911.5e866629@coco.lan>
In-Reply-To: <20210630074246.2305166-1-axel.lin@ingics.com>
References: <20210630074246.2305166-1-axel.lin@ingics.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

Em Wed, 30 Jun 2021 15:42:46 +0800
Axel Lin <axel.lin@ingics.com> escreveu:

> Since config.dev = pdev->dev.parent in current code, so
> dev_get_drvdata(rdev->dev.parent) actually returns the drvdata of the mfd
> device rather than the regulator. Fix it.
> 
> Fixes: 9bc146acc331 ("regulator: hi6421v600: Fix setting wrong driver_data")
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Mauro,
> Thanks for your analysis.
> Could you check if this patch works if you think it's good.
> I don't mind applying your earlier fix or this one.
> (This one has less code change with single purpose fot the fix,
> and this patch does not has other dependency.)

Yeah, this fixed the issue:

	[    1.105691] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.111942] spmi spmi-0: spmi_write_cmd: id:0 slave_addr:0x202, wrote value: ff
	[    1.119344] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.125589] spmi spmi-0: spmi_write_cmd: id:0 slave_addr:0x203, wrote value: ff
	[    1.132992] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.139238] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x212, read value: 00
	[    1.146461] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.152706] spmi spmi-0: spmi_write_cmd: id:0 slave_addr:0x212, wrote value: ff
	[    1.160103] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.166348] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x213, read value: 00
	[    1.173570] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.179815] spmi spmi-0: spmi_write_cmd: id:0 slave_addr:0x213, wrote value: ff
	[    1.187723] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.193970] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x51, read value: 08
	[    1.201114] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.207358] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x16, read value: 03
	[    1.234794] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.241040] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x51, read value: 08
	[    1.248182] spmi spmi-0: spmi_controller_wait_for_done: status 0x1
	[    1.254428] spmi spmi-0: spmi_read_cmd: id:0 slave_addr:0x16, read value: 03
	[    1.261560] ldo3: 1500 <--> 2000 mV at 1800 mV, enabled
...
	hikey970 login: 

And the regulators are also working:

	$ lsusb
	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
	Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port Hub
	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
	
Thanks! 

I'm OK on merging this version.

Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-

It would be better to merge this version either via Greg's tree or before
-rc1, in order to avoid conflicts with staging, as there will be a change
on this hunk:

	@@ -252,13 +255,12 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
	 		return -ENOMEM;
	 
	 	mutex_init(&priv->enable_mutex);
	-	platform_set_drvdata(pdev, priv);
	 
	 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
	 		info = &regulator_info[i];
	 
	 		config.dev = pdev->dev.parent;
	-		config.driver_data = info;
	+		config.driver_data = priv;
	 		config.regmap = pmic->regmap;
 
	 		rdev = devm_regulator_register(dev, &info->desc, &config);

As a patch at staging will be doing:

	- 		config.regmap = pmic->regmap;
	+		config.regmap = regmap;


> 
> Regards,
> Axel
>  drivers/regulator/hi6421v600-regulator.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
> index 9b162c0555c3..845bc3b4026d 100644
> --- a/drivers/regulator/hi6421v600-regulator.c
> +++ b/drivers/regulator/hi6421v600-regulator.c
> @@ -98,10 +98,9 @@ static const unsigned int ldo34_voltages[] = {
>  
>  static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
>  {
> -	struct hi6421_spmi_reg_priv *priv;
> +	struct hi6421_spmi_reg_priv *priv = rdev_get_drvdata(rdev);
>  	int ret;
>  
> -	priv = dev_get_drvdata(rdev->dev.parent);
>  	/* cannot enable more than one regulator at one time */
>  	mutex_lock(&priv->enable_mutex);
>  
> @@ -119,9 +118,10 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
>  
>  static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
>  {
> -	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
> +	struct hi6421_spmi_reg_info *sreg;
>  	unsigned int reg_val;
>  
> +	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
>  	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
>  
>  	if (reg_val & sreg->eco_mode_mask)
> @@ -133,9 +133,10 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
>  static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
>  					  unsigned int mode)
>  {
> -	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
> +	struct hi6421_spmi_reg_info *sreg;
>  	unsigned int val;
>  
> +	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
>  	switch (mode) {
>  	case REGULATOR_MODE_NORMAL:
>  		val = 0;
> @@ -159,7 +160,9 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
>  				       int input_uV, int output_uV,
>  				       int load_uA)
>  {
> -	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
> +	struct hi6421_spmi_reg_info *sreg;
> +
> +	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
>  
>  	if (!sreg->eco_uA || ((unsigned int)load_uA > sreg->eco_uA))
>  		return REGULATOR_MODE_NORMAL;
> @@ -252,13 +255,12 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	mutex_init(&priv->enable_mutex);
> -	platform_set_drvdata(pdev, priv);
>  
>  	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
>  		info = &regulator_info[i];
>  
>  		config.dev = pdev->dev.parent;
> -		config.driver_data = info;
> +		config.driver_data = priv;
>  		config.regmap = pmic->regmap;
>  
>  		rdev = devm_regulator_register(dev, &info->desc, &config);



Thanks,
Mauro
