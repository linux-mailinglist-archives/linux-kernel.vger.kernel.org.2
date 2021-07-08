Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD683BF6E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGHI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:28:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14037 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGHI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:28:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GL8Rs10s6zZpLP;
        Thu,  8 Jul 2021 16:22:49 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 16:26:01 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 8 Jul
 2021 16:26:01 +0800
Subject: Re: [RFC PATCH 4/4] ultrasoc: Add System Memory Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        <alexander.shishkin@linux.intel.com>, <mathieu.poirier@linaro.org>,
        <jonathan.zhouwen@huawei.com>, <f.fangjian@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-5-git-send-email-liuqi115@huawei.com>
 <da4d5c5e-5536-b8ca-3aa5-601c12d4e5ae@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <93cd762d-3f37-6805-0958-b7e1eb79caac@huawei.com>
Date:   Thu, 8 Jul 2021 16:25:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <da4d5c5e-5536-b8ca-3aa5-601c12d4e5ae@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,
On 2021/6/25 6:47, Suzuki K Poulose wrote:
> Hi Qi
> 
> On 15/06/2021 10:34, Qi Liu wrote:
>> This patch adds driver for System Memory Buffer. It includes
>> a platform driver for the SMB device.
>>
>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   drivers/hwtracing/ultrasoc/Kconfig        |   9 +
>>   drivers/hwtracing/ultrasoc/Makefile       |   3 +
>>   drivers/hwtracing/ultrasoc/ultrasoc-smb.c | 663 
>> ++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ultrasoc/ultrasoc-smb.h | 182 ++++++++
>>   4 files changed, 857 insertions(+)
>>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.h
>>
> 
>> +/*
>> + * Coresight doesn't export the following
>> + * structures(cs_mode,cs_buffers,etm_event_data),
>> + * so we redefine a copy here.
>> + */
> 
> Please do not duplicate them. This indicates, either :
> 
>   - You need to place your driver under coresight
> 
>   OR
> 
>   - Export the required definitions.
> 

got it, I'll move this driver to coresight/ultrasoc, thanks.

Qi
>> +enum cs_mode {
>> +    CS_MODE_DISABLED,
>> +    CS_MODE_SYSFS,
>> +    CS_MODE_PERF,
>> +};
>> +
> 
>> +struct cs_buffers {
>> +    unsigned int        cur;
>> +    unsigned int        nr_pages;
>> +    unsigned long        offset;
>> +    local_t            data_size;
>> +    bool            snapshot;
>> +    void            **data_pages;
>> +};
>> +
> 
> Why does this need to be replicated ?
> 
>> +struct etm_event_data {
>> +    struct work_struct work;
>> +    cpumask_t mask;
>> +    void *snk_config;
>> +    struct list_head * __percpu *path;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_CORESIGHT)
>> +int etm_perf_symlink(struct coresight_device *csdev, bool link);
>> +int etm_perf_add_symlink_sink(struct coresight_device *csdev);
>> +void etm_perf_del_symlink_sink(struct coresight_device *csdev);
>> +static inline void *etm_perf_sink_config(struct perf_output_handle 
>> *handle)
>> +{
>> +    struct etm_event_data *data = perf_get_aux(handle);
>> +
>> +    if (data)
>> +        return data->snk_config;
>> +    return NULL;
>> +}
>> +#else
>> +static inline int etm_perf_symlink(struct coresight_device *csdev, 
>> bool link)
>> +{ return -EINVAL; }
>> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
>> +{ return -EINVAL; }
>> +void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
>> +static inline void *etm_perf_sink_config(struct perf_output_handle 
>> *handle)
>> +{
>> +    return NULL;
>> +}
>> +
>> +#endif /* CONFIG_CORESIGHT */
>> +
>> +#endif
>>
> 
> Suzuki
> .

