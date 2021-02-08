Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E8312D2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBHJXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:23:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2520 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhBHJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:00:26 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZ0Gm2w4zz67m45;
        Mon,  8 Feb 2021 16:55:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 09:59:05 +0100
Received: from [10.47.8.138] (10.47.8.138) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 8 Feb 2021
 08:59:03 +0000
Subject: Re: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>,
        "'will@kernel.org'" <will@kernel.org>,
        "'mathieu.poirier@linaro.org'" <mathieu.poirier@linaro.org>,
        "'leo.yan@linaro.org'" <leo.yan@linaro.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'acme@kernel.org'" <acme@kernel.org>,
        "'mark.rutland@arm.com'" <mark.rutland@arm.com>,
        "'alexander.shishkin@linux.intel.com'" 
        <alexander.shishkin@linux.intel.com>,
        "'jolsa@redhat.com'" <jolsa@redhat.com>,
        "'namhyung@kernel.org'" <namhyung@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
 <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
 <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46007C599F706F3C56B20E64F7B29@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600E5D5B5BF038D5A3F8544F78F9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5b507e0e-0887-ee86-4fcd-06567d3f370b@huawei.com>
Date:   Mon, 8 Feb 2021 08:57:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB4600E5D5B5BF038D5A3F8544F78F9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.8.138]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2021 01:53, nakamur'd a.shun@fujitsu.com wrote:
> Hi, John
> 
>>>> Apart from that, I think that we're a bit uncertain about patch 3/4
>>> What are your concerns?
>>> I think it's okay for perf to read a new event code with a number at the
>> beginning.
>>
>> The impact of this fix is on {name} and later rules.
>> parse_events.l uses {name} only in one place.
>> The only rule defined after {name} is {name_tag}.
>>
>> I think the point of current fix is that the rules defined after {name} are not
>> misrecognize and the syntax is not broken.
>> {name_tag} starts with ', but {name} does not contain'.
>> Therefore, the corrected {name} does not misrecognize the {name_tag}, and I
>> think there is no problem.
> Do you have any advice?

Hi,

So my series is now on remotes/origin/tmp.perf/core in Arnaldo's acme 
git, so you could resend against that.

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Or again, put my series on perf/core and send against that.

As for patch 3/4, firstly I'd say that it is not a 'fix'. As well, 
please ensure it causes no regression on x86 or arm64. So like "perf 
list" output is same as before (with just that change), and also test 
some same perf events and metrics (x86 only) to ensure that they are ok. 
Please also ensure no regression on "perf test".

BTW, please config your mail client for no text encoding.

Thanks,
John

