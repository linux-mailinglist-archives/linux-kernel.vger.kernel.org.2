Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1030B8D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhBBHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:43:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12404 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhBBHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:43:42 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DVGwf696FzjFsT;
        Tue,  2 Feb 2021 15:41:54 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 2 Feb 2021
 15:42:55 +0800
Subject: Re: [PATCH] coresight: Remove duplicate header files of coresight
 drivers
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>
References: <1612184564-26613-1-git-send-email-liuqi115@huawei.com>
 <20210201170537.GA1399621@xps15>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <5c76cdc8-fa58-ddb0-c1b9-4a6db85f463a@huawei.com>
Date:   Tue, 2 Feb 2021 15:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210201170537.GA1399621@xps15>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/2 1:05, Mathieu Poirier wrote:
> Good day,
> 
> On Mon, Feb 01, 2021 at 09:02:44PM +0800, Qi Liu wrote:
>> Remove duplicate included header files, as coresight-priv.h is included in
>> these coresight drivers.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c         | 2 --
>>   drivers/hwtracing/coresight/coresight-core.c         | 3 ---
>>   drivers/hwtracing/coresight/coresight-cpu-debug.c    | 3 ---
>>   drivers/hwtracing/coresight/coresight-cti-core.c     | 3 ---
>>   drivers/hwtracing/coresight/coresight-cti-platform.c | 1 -
>>   drivers/hwtracing/coresight/coresight-cti.h          | 1 -
>>   drivers/hwtracing/coresight/coresight-etb10.c        | 4 ----
>>   drivers/hwtracing/coresight/coresight-etm-perf.c     | 1 -
>>   drivers/hwtracing/coresight/coresight-etm3x-sysfs.c  | 1 -
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c   | 5 -----
>>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c  | 1 -
>>   drivers/hwtracing/coresight/coresight-funnel.c       | 3 ---
>>   drivers/hwtracing/coresight/coresight-platform.c     | 2 --
>>   drivers/hwtracing/coresight/coresight-replicator.c   | 3 ---
>>   drivers/hwtracing/coresight/coresight-stm.c          | 3 ---
>>   drivers/hwtracing/coresight/coresight-tmc-core.c     | 3 ---
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c      | 1 -
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c      | 1 -
>>   drivers/hwtracing/coresight/coresight-tpiu.c         | 4 ----
>>   19 files changed, 45 deletions(-)
> 
> The idea is to make sure every file stands on its own without dependencies on
> other header files.  Otherwise it is difficult and expensive to move files
> around or make changes to any header file.   As such I will not move forward
> with this set.
> 
> Thanks,
> Mathieu
> 
Hi Mathieu,

got it, thanks :).

Qi
> 
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>> index a61313f..fcc0367 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -7,10 +7,8 @@
>>    * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
>>    */
>>
>> -#include <linux/amba/bus.h>
>>   #include <linux/device.h>
>>   #include <linux/dma-mapping.h>
>> -#include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/slab.h>
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 4ba801d..5fb8b12 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -7,17 +7,14 @@
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/export.h>
>>   #include <linux/slab.h>
>>   #include <linux/stringhash.h>
>>   #include <linux/mutex.h>
>>   #include <linux/clk.h>
>> -#include <linux/coresight.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/delay.h>
>> -#include <linux/pm_runtime.h>
>>
>>   #include "coresight-etm-perf.h"
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index e1d2324..f8df512 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -4,15 +4,12 @@
>>    *
>>    * Author: Leo Yan <leo.yan@linaro.org>
>>    */
>> -#include <linux/amba/bus.h>
>> -#include <linux/coresight.h>
>>   #include <linux/cpu.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/init.h>
>> -#include <linux/io.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
>> index 61dbc1a..ed7ab82 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>> @@ -4,18 +4,15 @@
>>    * Author: Mike Leach <mike.leach@linaro.org>
>>    */
>>
>> -#include <linux/amba/bus.h>
>>   #include <linux/atomic.h>
>>   #include <linux/bits.h>
>>   #include <linux/coresight.h>
>>   #include <linux/cpu_pm.h>
>>   #include <linux/cpuhotplug.h>
>>   #include <linux/device.h>
>> -#include <linux/io.h>
>>   #include <linux/kernel.h>
>>   #include <linux/list.h>
>>   #include <linux/mutex.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>   #include <linux/spinlock.h>
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
>> index ccef04f..60b0580 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
>> @@ -2,7 +2,6 @@
>>   /*
>>    * Copyright (c) 2019, The Linaro Limited. All rights reserved.
>>    */
>> -#include <linux/coresight.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/of.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
>> index acf7b54..0a3b313 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti.h
>> +++ b/drivers/hwtracing/coresight/coresight-cti.h
>> @@ -7,7 +7,6 @@
>>   #ifndef _CORESIGHT_CORESIGHT_CTI_H
>>   #define _CORESIGHT_CORESIGHT_CTI_H
>>
>> -#include <linux/coresight.h>
>>   #include <linux/device.h>
>>   #include <linux/fwnode.h>
>>   #include <linux/list.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 0cf6f0b..8d5bc04 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -10,17 +10,13 @@
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/fs.h>
>>   #include <linux/miscdevice.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/seq_file.h>
>> -#include <linux/coresight.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/clk.h>
>>   #include <linux/circ_buf.h>
>>   #include <linux/mm.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index bdc34ca..01aba63 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -4,7 +4,6 @@
>>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>>    */
>>
>> -#include <linux/coresight.h>
>>   #include <linux/coresight-pmu.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/device.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> index e8c7649..5cf6660 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> @@ -5,7 +5,6 @@
>>    */
>>
>>   #include <linux/pid_namespace.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/sysfs.h>
>>   #include "coresight-etm.h"
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index b20b6ff..0438ef7 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -3,13 +3,11 @@
>>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>>    */
>>
>> -#include <linux/bitops.h>
>>   #include <linux/kernel.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/fs.h>
>>   #include <linux/slab.h>
>> @@ -20,14 +18,11 @@
>>   #include <linux/clk.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpu_pm.h>
>> -#include <linux/coresight.h>
>>   #include <linux/coresight-pmu.h>
>>   #include <linux/pm_wakeup.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/perf_event.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>
>>   #include <asm/sections.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> index 989ce7b..347ccb7 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> @@ -5,7 +5,6 @@
>>    */
>>
>>   #include <linux/pid_namespace.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/sysfs.h>
>>   #include "coresight-etm4x.h"
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
>> index 071c723..c79ded9 100644
>> --- a/drivers/hwtracing/coresight/coresight-funnel.c
>> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
>> @@ -15,9 +15,6 @@
>>   #include <linux/slab.h>
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>> -#include <linux/pm_runtime.h>
>> -#include <linux/coresight.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/clk.h>
>>
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 3629b78..ca22409 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -13,8 +13,6 @@
>>   #include <linux/of_graph.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>> -#include <linux/amba/bus.h>
>> -#include <linux/coresight.h>
>>   #include <linux/cpumask.h>
>>   #include <asm/smp_plat.h>
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
>> index 7e2a2b7..36788de 100644
>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>> @@ -6,14 +6,11 @@
>>    */
>>
>>   #include <linux/acpi.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/kernel.h>
>>   #include <linux/device.h>
>>   #include <linux/platform_device.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/slab.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>   #include <linux/clk.h>
>>   #include <linux/of.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
>> index 9979177..75f0bd8 100644
>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>> @@ -17,17 +17,14 @@
>>    */
>>   #include <asm/local.h>
>>   #include <linux/acpi.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/bitmap.h>
>>   #include <linux/clk.h>
>> -#include <linux/coresight.h>
>>   #include <linux/coresight-stm.h>
>>   #include <linux/err.h>
>>   #include <linux/kernel.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/of_address.h>
>>   #include <linux/perf_event.h>
>> -#include <linux/pm_runtime.h>
>>   #include <linux/stm.h>
>>
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 8169dff..4fff281 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -9,7 +9,6 @@
>>   #include <linux/types.h>
>>   #include <linux/device.h>
>>   #include <linux/idr.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/fs.h>
>>   #include <linux/miscdevice.h>
>> @@ -21,8 +20,6 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/of.h>
>> -#include <linux/coresight.h>
>> -#include <linux/amba/bus.h>
>>
>>   #include "coresight-priv.h"
>>   #include "coresight-tmc.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 989d965..b263f75 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -6,7 +6,6 @@
>>
>>   #include <linux/atomic.h>
>>   #include <linux/circ_buf.h>
>> -#include <linux/coresight.h>
>>   #include <linux/perf_event.h>
>>   #include <linux/slab.h>
>>   #include "coresight-priv.h"
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index bf5230e..1ab0b28 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -5,7 +5,6 @@
>>    */
>>
>>   #include <linux/atomic.h>
>> -#include <linux/coresight.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/iommu.h>
>>   #include <linux/idr.h>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
>> index d5dfee9..c5675f9 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
>> @@ -9,12 +9,8 @@
>>   #include <linux/kernel.h>
>>   #include <linux/init.h>
>>   #include <linux/device.h>
>> -#include <linux/io.h>
>>   #include <linux/err.h>
>>   #include <linux/slab.h>
>> -#include <linux/pm_runtime.h>
>> -#include <linux/coresight.h>
>> -#include <linux/amba/bus.h>
>>   #include <linux/clk.h>
>>
>>   #include "coresight-priv.h"
>> --
>> 2.8.1
>>
> 
> .
> 

