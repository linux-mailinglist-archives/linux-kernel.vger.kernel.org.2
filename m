Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B159E3B78B2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhF2Teb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233670AbhF2Te3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB5F861DE7;
        Tue, 29 Jun 2021 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624995122;
        bh=7qlnV8Wl2x3Qvv6mjcrc1tpRP72lSFEAs94lptLsNag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OtoOXB+ZI2h/+SJgHhKPPbLYyNLu+3r1mZ0jlff2s5A9AoMdTxn6fPhhWbOZ0rPp0
         2dKDi3WiNCr6Pe+7sD7CS+x/IKX48v4o+ceYEd9ONlxoUvyawzS5YwelmiRgqHB3y2
         7VQ5LrQkfVsUji2I7nDdwL0xyngSsUeAhp0DnttnMvKPo9NGGFu/zlA4g/SU5DljFV
         5ZYt9sz/wVIGnx6mCmlDwdJ/xso5eExSp2xc613M2T2VxEmBpOUDJlxVecHCmEsJ5g
         EyF3BMnAlTr9WZiUntFPqZxaDUTj9KyuxtJ5S6LigcoB1S2qCjApxGw06nK+UUZZMH
         E4zkSGIxq4jxg==
Date:   Tue, 29 Jun 2021 21:31:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Axel Lin <axel.lin@ingics.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v10 2/5] regulator: hi6421v600-regulator: fix platform
 drvdata
Message-ID: <20210629213156.56e6f126@coco.lan>
In-Reply-To: <20210629151101.GB4613@sirena.org.uk>
References: <cover.1624962269.git.mchehab+huawei@kernel.org>
        <eed34e8897c79a2ab13573d3da12c86569bca0f6.1624962269.git.mchehab+huawei@kernel.org>
        <20210629151101.GB4613@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 29 Jun 2021 16:11:01 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Jun 29, 2021 at 12:31:28PM +0200, Mauro Carvalho Chehab wrote:
> 
> > platform drvdata can't be used inside the regulator driver,
> > as this is already used by the MFD and SPMI drivers.  
> 
> Can you clarify what exactly is using which platform drvdata already?
> This all feels very confused and I can't tell what the problem that's
> being fixed is, if it's a real issue or how this fixes it.

I don't remember the dirty details anymore... It has been almost a year
since when I started doing that. The SPMI controller driver left staging
8 months ago.

I guess it is related with passing the parent's device to
devm_regulator_register() at the hi6421v600-regulator driver:

	struct regulator_config config = { };
...
	config.dev = pdev->dev.parent;
...
	rdev = devm_regulator_register(dev, &info->desc, &config);

This is needed by SPMI bus and the SPMI controller in order to use the 
right platform data when talking to the hardware.

> >  drivers/misc/hi6421v600-irq.c               |  9 ++--
> >  drivers/regulator/hi6421v600-regulator.c    | 49 +++++++++++----------
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 18 +++-----
> >  include/linux/mfd/hi6421-spmi-pmic.h        | 25 -----------  
> 
> I'm especially nervous about the core driver still being in staging
> perhaps meaning there's some issue with it doing odd and confusing
> things.

The only missing part in staging is the MFD driver. At the current way,
it is very simple (71 lines in total): it just declares a regmap, and has 
a single function on it:

	static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
	{
		struct device *dev = &pdev->dev;
		int ret;
		struct hi6421_spmi_pmic *ddata;
		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
		if (!ddata)
			return -ENOMEM;
	
		ddata->regmap = devm_regmap_init_spmi_ext(pdev, &regmap_config);
		if (IS_ERR(ddata->regmap))
			return PTR_ERR(ddata->regmap);
	
		ddata->dev = dev;
	
		dev_set_drvdata(&pdev->dev, ddata);

		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
					   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
					   NULL, 0, NULL);
		if (ret < 0)
			dev_err(dev, "Failed to add child devices: %d\n", ret);

		return ret;
	}

You can see the full driver's code at:
	https://lore.kernel.org/lkml/8d871e2ccc544d11959c16d8312dbf03dd01b1c8.1624962269.git.mchehab+huawei@kernel.org/#Z30drivers:mfd:hi6421-spmi-pmic.c

I'm not aware of anything left preventing it to leave staging.

Thanks,
Mauro
