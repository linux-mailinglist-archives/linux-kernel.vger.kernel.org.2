Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10E388438
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhESBIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:08:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4738 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhESBIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:08:41 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlF4N1TlnzqVSS;
        Wed, 19 May 2021 09:03:48 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:07:17 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:07:16 +0800
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_-next_v2=5d_staging=3a_comedi=3a_Remove_un?=
 =?UTF-8?Q?used_variable_=e2=80=98min=5ffull=5fscale=e2=80=99_and_function_?=
 =?UTF-8?B?J2dldF9taW5fZnVsbF9zY2FsZXMn?=
To:     Ian Abbott <abbotti@mev.co.uk>, <linux-kernel@vger.kernel.org>
CC:     <hsweeten@visionengravers.com>, <gregkh@linuxfoundation.org>,
        <grandmaster@al2klimov.de>
References: <20210514085214.53941-1-cuibixuan@huawei.com>
 <517e8f75-3faa-b564-5252-d5a3812f15f9@mev.co.uk>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <a21ada45-8eb8-88b7-7634-096487efc81e@huawei.com>
Date:   Wed, 19 May 2021 09:07:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <517e8f75-3faa-b564-5252-d5a3812f15f9@mev.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/17 17:44, Ian Abbott wrote:
> On 14/05/2021 09:52, Bixuan Cui wrote:
>> The variable ‘min_full_scale’ and function 'get_min_full_scales' are
>> not used, So delete them.
>>
>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
>> ---
>> Changes from v2:
>> * Delete function 'get_min_full_scales'
>>
>>   drivers/comedi/drivers/jr3_pci.c | 15 ---------------
>>   1 file changed, 15 deletions(-)
>>
>> diff --git a/drivers/comedi/drivers/jr3_pci.c b/drivers/comedi/drivers/jr3_pci.c
>> index 7a02c4fa3cda..f963080dd61f 100644
>> --- a/drivers/comedi/drivers/jr3_pci.c
>> +++ b/drivers/comedi/drivers/jr3_pci.c
>> @@ -186,19 +186,6 @@ static void set_full_scales(struct jr3_sensor __iomem *sensor,
>>       set_s16(&sensor->command_word0, 0x0a00);
>>   }
>>   -static struct six_axis_t get_min_full_scales(struct jr3_sensor __iomem *sensor)
>> -{
>> -    struct six_axis_t result;
>> -
>> -    result.fx = get_s16(&sensor->min_full_scale.fx);
>> -    result.fy = get_s16(&sensor->min_full_scale.fy);
>> -    result.fz = get_s16(&sensor->min_full_scale.fz);
>> -    result.mx = get_s16(&sensor->min_full_scale.mx);
>> -    result.my = get_s16(&sensor->min_full_scale.my);
>> -    result.mz = get_s16(&sensor->min_full_scale.mz);
>> -    return result;
>> -}
>> -
>>   static struct six_axis_t get_max_full_scales(struct jr3_sensor __iomem *sensor)
>>   {
>>       struct six_axis_t result;
>> @@ -504,10 +491,8 @@ jr3_pci_poll_subdevice(struct comedi_subdevice *s)
>>               result = poll_delay_min_max(20, 100);
>>           } else {
>>               /* Set full scale */
>> -            struct six_axis_t min_full_scale;
>>               struct six_axis_t max_full_scale;
>>   -            min_full_scale = get_min_full_scales(sensor);
>>               max_full_scale = get_max_full_scales(sensor);
>>               set_full_scales(sensor, max_full_scale);
>>  
> 
> I'm pretty sure this is OK.  The min_full_scale registers are just informational.  The driver used to print the values, but not since commit a1d16659538a ("staging: comedi: jr3_pci: remove noisy printk") so this code is now redundant.
Thanks for your reply.

Thanks
Bixuan Cui

> 
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
> 
