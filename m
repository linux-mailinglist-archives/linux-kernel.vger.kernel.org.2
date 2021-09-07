Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BD40227D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhIGDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:33:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9006 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhIGDd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:33:57 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3W684hMyzVsc4;
        Tue,  7 Sep 2021 11:32:00 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 11:32:44 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 7 Sep
 2021 11:32:44 +0800
Subject: Re: [PATCH 1/2] Documentation: tracing: Documentation for ultrasoc
 SMB drivers
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210719111737.47891-1-liuqi115@huawei.com>
 <20210719111737.47891-2-liuqi115@huawei.com> <20210906173446.GD1228692@p14s>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <58e929cf-29a6-26ec-807f-94cca17bb708@huawei.com>
Date:   Tue, 7 Sep 2021 11:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210906173446.GD1228692@p14s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2021/9/7 1:34, Mathieu Poirier wrote:
> On Mon, Jul 19, 2021 at 07:17:36PM +0800, Qi Liu wrote:
>> Ultrasoc trace module is a system level solution for tracing, and SMB
>> is the component in trace module to store trace message. This patch
>> brings in a documentation for ultrasoc SMB driver and simple introduces
>> how to use ultrasoc SMB by sysfs interface and perf interface.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>

>> +Example usage of perf::
>> +
>> +	 $# ./perf list pmu
>> +	 cs_etm//                                    [Kernel PMU event]
>> +    $# ./perf record -e cs_etm/@sink_smb0/ -C 0 --per-thread sleep 2s
>> +    [ perf record: Woken up 2 times to write data ]
>> +    [ perf record: Captured and wrote 0.288 MB perf.data ]
>> +    $# ./perf report
> 
> This IP block works like any other sink device and as such I don't really see a
> need for this documentation - especially since it is mostly conveying the same
> information already present in coresight.rst.
> 

Yes, smb works as a sink device.
got it, I'll drop this documentation next time.

Thanks,
Qi

> Thanks,
> Mathieu
> >> --
>> 2.17.1
>>
> .
> 

