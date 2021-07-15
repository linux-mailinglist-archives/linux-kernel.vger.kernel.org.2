Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33E23C9B52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhGOJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:24:42 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11314 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOJYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:24:39 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQTKR3PH3z7tf4;
        Thu, 15 Jul 2021 17:17:15 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 17:21:40 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 15 Jul
 2021 17:21:39 +0800
Subject: Re: [PATCH 1/1] stm class: dummy_stm: Fix error return code in
 dummy_stm_init()
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508023615.1827-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e25baf8f-607c-6aa6-6902-c76b47834e55@huawei.com>
Date:   Thu, 15 Jul 2021 17:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210508023615.1827-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
  Can someone review it? Although it is unlikely that the OOM will
occur during initialization, this is indeed a coding error.

On 2021/5/8 10:36, Zhen Lei wrote:
> Although 'ret' has been initialized to -ENOMEM, but it will be reassigned
> by the "ret = stm_register_device(...)" statement in the for loop. So
> that, the value of 'ret' is unknown when kasprintf() failed.
> 
> Fixes: bcfdf8afdebe ("stm class: dummy_stm: Create multiple devices")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/hwtracing/stm/dummy_stm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
> index 38528ffdc0b3..36d32e7afb35 100644
> --- a/drivers/hwtracing/stm/dummy_stm.c
> +++ b/drivers/hwtracing/stm/dummy_stm.c
> @@ -68,7 +68,7 @@ static int dummy_stm_link(struct stm_data *data, unsigned int master,
>  
>  static int dummy_stm_init(void)
>  {
> -	int i, ret = -ENOMEM;
> +	int i, ret;
>  
>  	if (nr_dummies < 0 || nr_dummies > DUMMY_STM_MAX)
>  		return -EINVAL;
> @@ -80,8 +80,10 @@ static int dummy_stm_init(void)
>  
>  	for (i = 0; i < nr_dummies; i++) {
>  		dummy_stm[i].name = kasprintf(GFP_KERNEL, "dummy_stm.%d", i);
> -		if (!dummy_stm[i].name)
> +		if (!dummy_stm[i].name) {
> +			ret = -ENOMEM;
>  			goto fail_unregister;
> +		}
>  
>  		dummy_stm[i].sw_start		= master_min;
>  		dummy_stm[i].sw_end		= master_max;
> 
