Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89A367CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhDVIhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:37:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2904 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhDVIhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:37:11 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FQrGy4nsKz6yhSP;
        Thu, 22 Apr 2021 16:31:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Apr 2021 10:36:35 +0200
Received: from localhost (10.52.123.71) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 22 Apr
 2021 09:36:34 +0100
Date:   Thu, 22 Apr 2021 09:35:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 164/190] Revert "iio: ad9523: fix a missing check of
 return value"
Message-ID: <20210422093505.00006f77@Huawei.com>
In-Reply-To: <20210421130105.1226686-165-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
        <20210421130105.1226686-165-gregkh@linuxfoundation.org>
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

On Wed, 21 Apr 2021 15:00:39 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This reverts commit ae0b3773721f08526c850e2d8dec85bdb870cd12.
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

Checked. Original fix was correct.  As with others I don't mind how we handle
this.  Can either drop the revert, or bring it back later.

Thanks,

Jonathan

> ---
>  drivers/iio/frequency/ad9523.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index bdb0bc3b12dd..91eb47e27db0 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -944,14 +944,11 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  		}
>  	}
>  
> -	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN) {
> -		ret = ad9523_write(indio_dev,
> +	for_each_clear_bit(i, &active_mask, AD9523_NUM_CHAN)
> +		ad9523_write(indio_dev,
>  			     AD9523_CHANNEL_CLOCK_DIST(i),
>  			     AD9523_CLK_DIST_DRIVER_MODE(TRISTATE) |
>  			     AD9523_CLK_DIST_PWR_DOWN_EN);
> -		if (ret < 0)
> -			return ret;
> -	}
>  
>  	ret = ad9523_write(indio_dev, AD9523_POWER_DOWN_CTRL, 0);
>  	if (ret < 0)

