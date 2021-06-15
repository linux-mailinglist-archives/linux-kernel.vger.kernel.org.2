Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8650A3A740D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFOChB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:37:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6489 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhFOCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3rxp00n6zZhKV;
        Tue, 15 Jun 2021 09:55:41 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:36 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:35 +0800
Subject: Re: [PATCH -next] video: fbdev: intelfb: Remove set but not used
 variable 'val'
To:     <mbroemme@libmpq.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210527085904.3861173-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <253d3e4d-c843-df88-5299-7b7b3dfd3c5b@huawei.com>
Date:   Tue, 15 Jun 2021 09:58:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210527085904.3861173-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/5/27 16:59, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setscl':
> drivers/video/fbdev/intelfb/intelfb_i2c.c:58:6: warning:
>   variable ‘val’ set but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setsda':
> drivers/video/fbdev/intelfb/intelfb_i2c.c:69:6: warning:
>   variable ‘val’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/video/fbdev/intelfb/intelfb_i2c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/intelfb/intelfb_i2c.c b/drivers/video/fbdev/intelfb/intelfb_i2c.c
> index 3300bd31d9d7..4df2f1f8a18e 100644
> --- a/drivers/video/fbdev/intelfb/intelfb_i2c.c
> +++ b/drivers/video/fbdev/intelfb/intelfb_i2c.c
> @@ -55,22 +55,20 @@ static void intelfb_gpio_setscl(void *data, int state)
>   {
>   	struct intelfb_i2c_chan *chan = data;
>   	struct intelfb_info *dinfo = chan->dinfo;
> -	u32 val;
>   
>   	OUTREG(chan->reg, (state ? SCL_VAL_OUT : 0) |
>   	       SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
> -	val = INREG(chan->reg);
> +	INREG(chan->reg);
>   }
>   
>   static void intelfb_gpio_setsda(void *data, int state)
>   {
>   	struct intelfb_i2c_chan *chan = data;
>   	struct intelfb_info *dinfo = chan->dinfo;
> -	u32 val;
>   
>   	OUTREG(chan->reg, (state ? SDA_VAL_OUT : 0) |
>   	       SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
> -	val = INREG(chan->reg);
> +	INREG(chan->reg);
>   }
>   
>   static int intelfb_gpio_getscl(void *data)
