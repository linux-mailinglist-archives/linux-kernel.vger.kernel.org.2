Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936D73A175C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhFIOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:36:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5362 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbhFIOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:36:50 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0V011Q7pz6tvy;
        Wed,  9 Jun 2021 22:30:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 22:34:49 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 22:34:48 +0800
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
 <alpine.DEB.2.22.394.2106091509590.60148@gentwo.de>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cc989f3d-4bcb-a6be-7e0c-c2a72a32b856@huawei.com>
Date:   Wed, 9 Jun 2021 22:34:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2106091509590.60148@gentwo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/9 21:11, Christoph Lameter wrote:
> On Wed, 9 Jun 2021, Zhen Lei wrote:
> 
>>  #endif
>>
>> -/* A example struture for using NODEMASK_ALLOC, used in mempolicy. */
>> +/* A example structure for using NODEMASK_ALLOC, used in mempolicy. */
> 
> An Example
> 
> Or better
> 
> Example structure ...

"Example structure" is better, I will send V3 tomorrow.

> 
> 
> .
> 

