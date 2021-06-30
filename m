Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF963B7EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhF3IXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhF3IXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F3561D06;
        Wed, 30 Jun 2021 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625041255;
        bh=H9uTwHJ4d8IL5zLhXZmwPHfHssJs2iDctqoSB22iCS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wdt59lfeUE3bXU9pUOzNA9RO7jirkjNXNelTbKgWVK2ZtC6m8ZWU5tF83064ufI8b
         0hf14128Lsg2N9E42rWdaXCSgHmaTqwaB8ErasF8LpQBi5rds/ne9hm6TaUNTKIZDa
         6GpnrBaEAEM1gooAvR2hnYFOEP/FFO+LltmqU4vRgimpK03Evy74HmQwaNJz4wJDJ3
         3Ym+yzd0+g6J3eZpbxdimAoOdAUTg5rq41T6vWbkbNMVZ7i/kFH/TrivMTNyeq+gzW
         THKT9P+eQmVLL8g5K9CIS8werBOvclemRFuygsUrOAyraI1bGpvnrU/kARsotKvMMC
         2nTK8BHFfua2w==
Date:   Wed, 30 Jun 2021 10:20:49 +0200
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
Message-ID: <20210630102049.4446b48f@coco.lan>
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

It turns that the problem was not related to any bad usage of
platform data by MFD/SPMI drivers. There used to have a need to access
the SPMI privdata before we added support for regmap, but this is
long gone.

The problem is just that the Axel's patch was setting the platform
drvdata, but the internal logic was addressing a different memory
region (from the SPMI driver), because hi6421v600-regulator driver sets
the config.dev as:

	config.dev = pdev->dev.parent;

The config.dev needs to point to the SPMI driver, in order to ensure that 
regulator_register() will access the proper OF data from the SPMI
devicetree descriptors here:

	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
					       &rdev->dev.of_node);

With the Axel's fixup patch:

	https://lore.kernel.org/lkml/20210630100911.5e866629@coco.lan/T/#t

the regression was solved.

Thanks,
Mauro
