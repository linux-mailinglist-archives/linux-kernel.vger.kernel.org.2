Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5134A274
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCZHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:19:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14559 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhCZHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:19:25 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6Cvd0fX8zNqcq;
        Fri, 26 Mar 2021 15:16:45 +0800 (CST)
Received: from [10.67.103.10] (10.67.103.10) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 15:19:10 +0800
Subject: Re: [PATCH -next] drivers: crypto: CRYPTO_DEV_HISI_HPRE select
 CRYPTO_ECC and CRYPTO_ECDH
To:     Zhang Jianhua <zhangjianhua18@huawei.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <xuzaibo@huawei.com>, <qianweili@huawei.com>,
        <yuehaibing@huawei.com>, <tanshukun1@huawei.com>,
        <sfr@canb.auug.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johnny.chenyi@huawei.com>
References: <20210326071648.15480-1-zhangjianhua18@huawei.com>
From:   yumeng <yumeng18@huawei.com>
Message-ID: <1f92336a-202a-3a00-8a24-0e3f8c5967db@huawei.com>
Date:   Fri, 26 Mar 2021 15:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210326071648.15480-1-zhangjianhua18@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.10]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, there is a similar patch to yours that was sent in advance:
https://www.spinics.net/lists/linux-crypto/msg54238.html

�� 2021/3/26 15:16, Zhang Jianhua д��:
> If CRYPTO_DEV_HISI_HPRE=y, the following errors will be seen while
> building hpre_crypto.c
> 
> drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
> `hpre_curve25519_compute_value':
> hpre_crypto.c:(.text+0x151b): undefined reference to
> `ecc_get_curve25519'
> drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
> `hpre_curve25519_set_secret':
> hpre_crypto.c:(.text+0x2714): undefined reference to
> `ecc_get_curve25519'
> drivers/crypto/hisilicon/hpre/hpre_crypto.o: In function
> `hpre_ecdh_set_secret':
> hpre_crypto.c:(.text+0x27ed): undefined reference to
> `crypto_ecdh_decode_key'
> hpre_crypto.c:(.text+0x2954): undefined reference to `ecc_get_curve'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
> ---
>   drivers/crypto/hisilicon/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> index c45adb15ce8d..d87c89af2a7f 100644
> --- a/drivers/crypto/hisilicon/Kconfig
> +++ b/drivers/crypto/hisilicon/Kconfig
> @@ -69,6 +69,8 @@ config CRYPTO_DEV_HISI_HPRE
>   	select CRYPTO_DEV_HISI_QM
>   	select CRYPTO_DH
>   	select CRYPTO_RSA
> +	select CRYPTO_ECC
> +	select CRYPTO_ECDH
>   	help
>   	  Support for HiSilicon HPRE(High Performance RSA Engine)
>   	  accelerator, which can accelerate RSA and DH algorithms.
> 
