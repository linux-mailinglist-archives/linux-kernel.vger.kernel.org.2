Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F23A08E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbhFIBNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:13:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4526 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFIBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:13:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G08BR3gTPzZdsX;
        Wed,  9 Jun 2021 09:08:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 09:11:36 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 09:11:35 +0800
Subject: Re: [PATCH 1/1] lib: Fix spelling mistakes in header files
To:     Joe Perches <joe@perches.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210608021932.12581-1-thunder.leizhen@huawei.com>
 <20210608021932.12581-2-thunder.leizhen@huawei.com>
 <20210609091821.32b82ba464f6f9aecc3a7d59@kernel.org>
 <2ab2fd8be606ad925bb19054b74d1f3ebd2da095.camel@perches.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e351aa75-6764-6118-261a-873a10b070c4@huawei.com>
Date:   Wed, 9 Jun 2021 09:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2ab2fd8be606ad925bb19054b74d1f3ebd2da095.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/9 8:28, Joe Perches wrote:
> On Wed, 2021-06-09 at 09:18 +0900, Masami Hiramatsu wrote:
>> On Tue, 8 Jun 2021 10:19:32 +0800
>> Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>>> Fix some spelling mistakes in comments found by "codespell":
> 
> Another:
> 
>>> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> []
>>> @@ -165,7 +165,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
>>>   * is stroed to @anode and @value. If the @node doesn't have @key node,
> 
> stroed/stored

Good eye, I will fix it in V2.

> 
>>>   * it does nothing.
> 
> 
> 
> .
> 

