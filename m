Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD735988D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhDIJEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:04:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIJEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:04:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 640C11FB;
        Fri,  9 Apr 2021 02:04:19 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C26353F73D;
        Fri,  9 Apr 2021 02:04:16 -0700 (PDT)
Subject: Re: [PATCH -next] coresight: core: Make symbol 'csdev_sink' static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20210409013215.488823-1-weiyongjun1@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <291c6015-dbef-553b-c756-9d5acd1d9fe2@arm.com>
Date:   Fri, 9 Apr 2021 14:35:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409013215.488823-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 7:02 AM, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/hwtracing/coresight/coresight-core.c:26:1: warning:
>  symbol '__pcpu_scope_csdev_sink' was not declared. Should it be static?
> 
> This symbol is not used outside of coresight-core.c, so this
> commit marks it static.

commit ? It is not on the tree yet. s/commit/change instead.

> 
> Fixes: 2cd87a7b293d ("coresight: core: Add support for dedicated percpu sinks")

There is no functional problem that this patch is proposing to fix
and hence the "Fixes:" tag is not warranted. Suzuki/Matihieu ?

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 3e779e1619ed..6c68d34d956e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -23,7 +23,7 @@
>  #include "coresight-priv.h"
>  
>  static DEFINE_MUTEX(coresight_mutex);
> -DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> +static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>  
>  /**
>   * struct coresight_node - elements of a path, from source to sink
> 

Otherwise LGTM. As csdev_sink is not being used outside coresight-core.c
file after the introduction of coresight_[set|get]_percpu_sink() helpers.
