Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1877B39AF32
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFDAui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:50:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7097 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFDAuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:50:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fx3wX3DT0zYqc8;
        Fri,  4 Jun 2021 08:46:04 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 08:48:38 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 08:48:38 +0800
Subject: Re: [PATCH] tools/testing/nvdimm: use vzalloc() instead of
 vmalloc()/memset(0)
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <bp@suse.de>,
        <rafael.j.wysocki@intel.com>, <mpe@ellerman.id.au>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
References: <1622425715-146012-1-git-send-email-wubo40@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <590552c1-5032-5243-20b5-e5701972812e@huawei.com>
Date:   Fri, 4 Jun 2021 08:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1622425715-146012-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping ...

On 2021/5/31 9:48, Wu Bo wrote:
> Use vzalloc() instead of vmalloc() and memset(0) to simpify
> the code.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>   tools/testing/nvdimm/test/nfit.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 54f367cbadae..258bba22780b 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1625,7 +1625,6 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
>   	if (rc)
>   		goto err;
>   	INIT_LIST_HEAD(&nfit_res->list);
> -	memset(buf, 0, size);
>   	nfit_res->dev = dev;
>   	nfit_res->buf = buf;
>   	nfit_res->res.start = *dma;
> @@ -1652,7 +1651,7 @@ static void *test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma)
>   	struct genpool_data_align data = {
>   		.align = SZ_128M,
>   	};
> -	void *buf = vmalloc(size);
> +	void *buf = vzalloc(size);
>   
>   	if (size >= DIMM_SIZE)
>   		*dma = gen_pool_alloc_algo(nfit_pool, size,
> 

