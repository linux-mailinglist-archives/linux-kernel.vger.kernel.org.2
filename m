Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37B8367C80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhDVI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:28:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2902 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbhDVI2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:28:33 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FQr2b17Q8z6sl4C;
        Thu, 22 Apr 2021 16:20:23 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 10:27:55 +0200
Received: from localhost (10.52.123.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Apr
 2021 09:27:55 +0100
Date:   Thu, 22 Apr 2021 09:26:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 093/190] Revert "iio: hmc5843: fix potential NULL
 pointer dereferences"
Message-ID: <20210422092625.00005af6@Huawei.com>
In-Reply-To: <20210421130105.1226686-94-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-94-gregkh@linuxfoundation.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.71]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 14:59:28 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This reverts commit 536cc27deade8f1ec3c1beefa60d5fbe0f6fcb28.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Hi Greg,

Checked this one.  As far as I can tell it was a valid cleanup of
error handling. Far from critical though and unlikely to be seen in practice.

So either leave it in place, or we can bring it back later. I don't mind
which.

> ---
>  drivers/iio/magnetometer/hmc5843_i2c.c | 7 +------
>  drivers/iio/magnetometer/hmc5843_spi.c | 7 +------
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index 67fe657fdb3e..9a4491233d08 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -55,13 +55,8 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
>  static int hmc5843_i2c_probe(struct i2c_client *cli,
>  			     const struct i2c_device_id *id)
>  {
> -	struct regmap *regmap = devm_regmap_init_i2c(cli,
> -			&hmc5843_i2c_regmap_config);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> -
>  	return hmc5843_common_probe(&cli->dev,
> -			regmap,
> +			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
>  			id->driver_data, id->name);
>  }
>  
> diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
> index d827554c346e..58bdbc7257ec 100644
> --- a/drivers/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/iio/magnetometer/hmc5843_spi.c
> @@ -55,7 +55,6 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
>  static int hmc5843_spi_probe(struct spi_device *spi)
>  {
>  	int ret;
> -	struct regmap *regmap;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  
>  	spi->mode = SPI_MODE_3;
> @@ -65,12 +64,8 @@ static int hmc5843_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	regmap = devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> -
>  	return hmc5843_common_probe(&spi->dev,
> -			regmap,
> +			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
>  			id->driver_data, id->name);
>  }
>  

