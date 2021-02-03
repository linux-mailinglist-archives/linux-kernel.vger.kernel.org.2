Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCBF30D53B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhBCIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:30:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2488 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhBCIaf (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:30:35 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVvsV1lLQz67cHK;
        Wed,  3 Feb 2021 16:26:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 09:29:52 +0100
Received: from [10.210.171.46] (10.210.171.46) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 3 Feb 2021 08:29:51 +0000
Subject: Re: [PATCH] perf metricgroup: Fix segmentation fault for metrics with
 no pmu event
To:     "Jin, Yao" <yao.jin@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <Linux-kernel@vger.kernel.org>, <ak@linux.intel.com>,
        <kan.liang@intel.com>, <yao.jin@intel.com>
References: <20210202022424.10787-1-yao.jin@linux.intel.com>
 <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
 <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <efb5c6b5-6759-b0b8-b934-9d68d9f2cbf5@huawei.com>
Date:   Wed, 3 Feb 2021 08:28:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.46]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 00:46, Jin, Yao wrote:
>>
>> This should be fixed in v5.11-rc6 - please check it.
>>
>> 9c880c24cb0d perf metricgroup: Fix for metrics containing duration_time
>>
>> Thanks,
>> John
> 
> Oh, I see, your patch is in Arnaldo's perf/urgent branch. Sorry about 
> that, I just tested Arnaldo's perf/core branch. :(

Yeah, I'm not sure on the policy to merge back/rebase there. But sorry 
for the hassle with this issue.

john
