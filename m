Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A2316A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhBJPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:50:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2533 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBJPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:50:27 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbPGB6Kk7z67ln7;
        Wed, 10 Feb 2021 23:44:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 16:49:46 +0100
Received: from [10.210.168.117] (10.210.168.117) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 15:49:45 +0000
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
 <5b507e0e-0887-ee86-4fcd-06567d3f370b@huawei.com>
 <OSBPR01MB46003F3F8106E1AA231084D9F78D9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ae8b6d89-5fcd-bff6-6d4d-bb350dca38fe@huawei.com>
Date:   Wed, 10 Feb 2021 15:48:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB46003F3F8106E1AA231084D9F78D9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.117]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 15:34, nakamura.shun@fujitsu.com wrote:
> Hi, John
> 
>> So my series is now on remotes/origin/tmp.perf/core in Arnaldo's acme git, so
> 
>> you could resend against that.
> 
>> 
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> 
>> 
> 
>> Or again, put my series on perf/core and send against that.
> 
> I will resend based on tmp.perf/core.

Actually it is now on perf/core, so that is a better baseline.

> 
>> As for patch 3/4, firstly I'd say that it is not a 'fix'. As well, please ensure it causes
> 
>> no regression on x86 or arm64. So like "perf list" output is same as before (with
> 
>> just that change), and also test some same perf events and metrics (x86 only) to
> 
>> ensure that they are ok.
> 
>> Please also ensure no regression on "perf test".
> 
> I will fix the subject of patch 3/4.
> 
> I have checked the following:
> 
> - perf list does not change for x86 and A64FX
> 
> - No regression on perf test
> 
> - No problem with FLOPs and PMU event counters on x86
> 
>> BTW, please config your mail client for no text encoding.
> 
> I will send it in HTML format.

Hmmm, that's not better. I think that the mail servers reject html.

Please consult Documentation/process/email-clients.rst

Thanks,
John

