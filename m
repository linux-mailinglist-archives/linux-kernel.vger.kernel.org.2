Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D53A741E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFOCiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:38:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6366 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhFOCiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:38:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G3rxX65XMz63X1;
        Tue, 15 Jun 2021 09:55:28 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:22 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:59:22 +0800
Subject: Re: [PATCH -next] w1: ds1wm: Remove set but not used variable 'inten'
To:     <zbr@ioremap.net>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210529035945.2754099-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <bc019cfa-95e7-c88b-89a9-430a6c21b220@huawei.com>
Date:   Tue, 15 Jun 2021 09:59:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210529035945.2754099-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/5/29 11:59, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/w1/masters/ds1wm.c: In function 'ds1wm_probe':
> drivers/w1/masters/ds1wm.c:512:5: warning:
>   variable ‘inten’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   drivers/w1/masters/ds1wm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
> index f661695fb589..f59d92865ecb 100644
> --- a/drivers/w1/masters/ds1wm.c
> +++ b/drivers/w1/masters/ds1wm.c
> @@ -509,7 +509,6 @@ static int ds1wm_probe(struct platform_device *pdev)
>   	struct ds1wm_driver_data *plat;
>   	struct resource *res;
>   	int ret;
> -	u8 inten;
>   
>   	if (!pdev)
>   		return -ENODEV;
> @@ -564,7 +563,7 @@ static int ds1wm_probe(struct platform_device *pdev)
>   	ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
>   
>   	/* Mask interrupts, set IAS before claiming interrupt */
> -	inten = ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
> +	ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
>   	ds1wm_write_register(ds1wm_data,
>   		DS1WM_INT_EN, ds1wm_data->int_en_reg_none);
>   
