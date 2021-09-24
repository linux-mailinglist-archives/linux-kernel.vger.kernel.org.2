Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0A416A17
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbhIXCnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:43:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9762 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhIXCnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:43:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HFx8k3cyXzWNjN;
        Fri, 24 Sep 2021 10:40:22 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:41:30 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 10:41:30 +0800
Subject: Re: [PATCH v3 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chen Jun <chenjun102@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <feng.tang@intel.com>, <mhocko@suse.com>, <rui.xiang@huawei.com>
References: <20210923020524.13289-1-chenjun102@huawei.com>
 <20210923192312.53dbe65db0375038c99defaa@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <2e27177d-2db2-de2e-96ba-fe9048c82978@huawei.com>
Date:   Fri, 24 Sep 2021 10:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210923192312.53dbe65db0375038c99defaa@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/24 10:23, Andrew Morton wrote:
> On Thu, 23 Sep 2021 02:05:24 +0000 Chen Jun <chenjun102@huawei.com> wrote:
>
>> An unexpected value of /proc/sys/vm/overcommit_memory we will get,
>> after running the following program.
>>
>> int main()
>> {
>>      int fd = open("/proc/sys/vm/overcommit_memory", O_RDWR)

Hi Andrew，

missing  ';' here,

> Thanks.  I added a cc:stable to this, so the fix will be backported
> into earlier kernels.

...  and the Fixes tag miss a ')' in the end ,  please help to add them :)

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

