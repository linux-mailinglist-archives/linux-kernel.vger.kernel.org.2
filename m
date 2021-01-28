Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B43071E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhA1Ipx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:45:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2441 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhA1Ioq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:44:46 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DRDS00QwNz67fJV;
        Thu, 28 Jan 2021 16:40:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 28 Jan 2021 09:43:21 +0100
Received: from [10.47.11.225] (10.47.11.225) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 28 Jan
 2021 08:43:19 +0000
Subject: Re: [PATCH 2/4] perf vendor events arm64: Add common and uarch event
 JSON
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "james.clark@arm.com" <james.clark@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1611575600-2440-1-git-send-email-john.garry@huawei.com>
 <1611575600-2440-3-git-send-email-john.garry@huawei.com>
 <OSBPR01MB460053B9A7E7A1710D73D21EF7BA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a668afcc-b06b-04d3-aba2-507a8d1d8f6e@huawei.com>
Date:   Thu, 28 Jan 2021 08:41:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB460053B9A7E7A1710D73D21EF7BA9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.225]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2021 05:30, nakamura.shun@fujitsu.com wrote:
> Hi ,john
> 
> I would like to make a comment because there is excess or deficiency in comma.
> There are no differences in pmu-events.c.
> 
>> +    {
>> +        "PublicDescription": "Attributable Bus access",
>> +        "EventCode": "0x19",
>> +        "EventName": "BUS_ACCESS",
>> +        "BriefDescription": "Attributable Bus access",
>> +    },
> Comma is not required at the end of BriefDescription.
> 
>> +    {
>> +        "PublicDescription": "Bus cycle"
>> +        "EventCode": "0x1D",
>> +        "EventName": "BUS_CYCLES",
>> +        "BriefDescription": "Bus cycle"
>> +    },
> Missing comma at end of PublicDescription.
> 
>> +    {
>> +        "PublicDescription": "Attributable Last level cache memory read"
>> +        "EventCode": "0x36",
>> +        "EventName": "LL_CACHE_RD",
>> +        "BriefDescription": "Attributable Last level cache memory read"
>> +    },
>> +    {
>> +        "PublicDescription": "Last level cache miss, read"
>> +        "EventCode": "0x37",
>> +        "EventName": "LL_CACHE_MISS_RD",
>> +        "BriefDescription": "Last level cache miss, read"
>> +    },
> Missing comma at end of PublicDescription.
> 
>> +    },
>> +]
> Commas are not required.
> 
> Best Regards
> Shunsuke

Fine, I can fix those up and re-post today.

Thanks,
john
