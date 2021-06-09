Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554C73A1796
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbhFIOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:43:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3929 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhFIOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:43:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0V8l1CKJz6try;
        Wed,  9 Jun 2021 22:38:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:41:35 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 22:41:34 +0800
Subject: Re: [PATCH v2 1/1] lib: Fix spelling mistakes in header files
To:     Christoph Lameter <cl@gentwo.de>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210609013451.13706-1-thunder.leizhen@huawei.com>
 <20210609013451.13706-2-thunder.leizhen@huawei.com>
 <alpine.DEB.2.22.394.2106091508030.60148@gentwo.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <931f9505-0e4c-e339-92f9-e2c82f8f141c@huawei.com>
Date:   Wed, 9 Jun 2021 22:41:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2106091508030.60148@gentwo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/9 21:09, Christoph Lameter wrote:
> On Wed, 9 Jun 2021, Zhen Lei wrote:
> 
>> @@ -152,7 +152,7 @@ struct lc_element {
>>  	 * for paranoia, and for "lc_element_to_index" */
>>  	unsigned lc_index;
>>  	/* if we want to track a larger set of objects,
>> -	 * it needs to become arch independend u64 */
>> +	 * it needs to become arch independent u64 */
> 
> it needs to become *an* arch independent u64

OK, I will also change "arch" to "architecture".

> 
> 
> .
> 

