Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7DB446CDE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhKFHeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:34:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:26290 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhKFHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:34:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HmTT716LXzbhVZ;
        Sat,  6 Nov 2021 15:26:35 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 6 Nov 2021 15:31:21 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sat, 6 Nov 2021 15:31:21 +0800
Subject: Re: [PATCH v2] drivers/coresight: ultrasoc: Add System Memory Buffer
 driver
To:     Randy Dunlap <rdunlap@infradead.org>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
References: <20211105012012.86635-1-liuqi115@huawei.com>
 <af9dbbbf-64f0-f3c6-fa30-4e306e6156d2@infradead.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <477a4a27-2cd7-e9bc-363c-577271abac93@huawei.com>
Date:   Sat, 6 Nov 2021 15:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <af9dbbbf-64f0-f3c6-fa30-4e306e6156d2@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/5 9:36, Randy Dunlap wrote:
> On 11/4/21 6:20 PM, Qi Liu wrote:
>> diff --git a/drivers/hwtracing/coresight/ultrasoc/Kconfig 
>> b/drivers/hwtracing/coresight/ultrasoc/Kconfig
>> new file mode 100644
>> index 000000000000..c18c25bf9df3
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# ultrasoc configuration
>> +#
>> +config ULTRASOC_SMB
>> +    tristate "Ultrasoc system memory buffer drivers"
>> +        depends on ARM64 && CORESIGHT
> 
> The "depends" line should be indented with a tab instead of spaces...
> 
ah, yes, my editor might be set incorrectly, thanks for the reminder, 
I'll correct it next time.

Qi
>> +    help
>> +      This enables support for the Ultrasoc system memory buffer
>> +      driver that is responsible for receiving the trace data from
>> +      Coresight ETM devices and storing them to a system buffer
>> +      respectively.
> 
> 
