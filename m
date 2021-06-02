Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5861F397DE5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhFBBJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:09:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3328 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhFBBJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:09:00 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvrNV5vjwz1BH2h;
        Wed,  2 Jun 2021 09:02:34 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:07:14 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:07:14 +0800
Subject: Re: [PATCH] remoteproc: pru: Remove redundant dev_err call in
 pru_rproc_probe()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20210601083100.130776-1-chengzhihao1@huawei.com>
 <20210601152047.GA1759269@xps15>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <73c51d6a-50e1-a7da-1c6f-66fb397c82ef@huawei.com>
Date:   Wed, 2 Jun 2021 09:07:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210601152047.GA1759269@xps15>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/6/1 23:20, Mathieu Poirier Ð´µÀ:
> On Tue, Jun 01, 2021 at 04:31:00PM +0800, Zhihao Cheng wrote:
>
> @@ -822,8 +822,6 @@ static int pru_rproc_probe(struct platform_device *pdev)
>   						   mem_names[i]);
>   		pru->mem_regions[i].va = devm_ioremap_resource(dev, res);
>   		if (IS_ERR(pru->mem_regions[i].va)) {
> -			dev_err(dev, "failed to parse and map memory resource %d %s\n",
> -				i, mem_names[i]);
> https://patchwork.kernel.org/project/linux-remoteproc/patch/20210511120426.5834-1-thunder.leizhen@huawei.com/
Thanks for reminding. Ignore this patch.
>>   			ret = PTR_ERR(pru->mem_regions[i].va);
>>   			return ret;
>>   		}
>> -- 
>> 2.31.1
>>
> .


