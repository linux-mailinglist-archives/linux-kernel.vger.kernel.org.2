Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF15832A1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836328AbhCBHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:00:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42312 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347661AbhCBFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:52:24 -0500
Received: from [192.168.0.114] (unknown [49.207.214.138])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42D7A20B83EA;
        Mon,  1 Mar 2021 21:51:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42D7A20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614664298;
        bh=/ckm4hpJQMLPLRduFqR8+KLJLPJLAdSa7Z0HzY+zdP8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mSUt4IVEUFIAk7XeNpoz8MZq31IkhU/TZCmi4B2x26uwNwU5uPxNRgobTzfCslL+c
         Hulo+Eoog+6dGA+jBsG8BQfTwJTXGcLr0cAR/gEleZo6Z/5oCfdoPEb2yXSRte+IIq
         GNYs1rpUUy0S1zZw5EEwCLp+9iYpiBDjqRfM9Ydk=
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <allen.lkml@gmail.com>
Cc:     zajec5@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-2-allen.lkml@gmail.com>
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
From:   Allen Pais <apais@linux.microsoft.com>
Message-ID: <6f1c6529-7c89-21c9-0ce6-28545c251a9f@linux.microsoft.com>
Date:   Tue, 2 Mar 2021 11:21:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> From: Allen Pais <apais@linux.microsoft.com>
>>
>> The following out of memory errors are seen on kexec reboot
>> from the optee core.
>>
>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>>
>> tee_shm_release() is not invoked on dma shm buffer.
>>
>> Implement .shutdown() method to handle the release of the buffers
>> correctly.
>>
>> More info:
>> https://github.com/OP-TEE/optee_os/issues/3637
>>
>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> ---
>>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> This looks good to me. Do you have a practical way of testing this on
> QEMU for instance?

   I have not tried this on QEMU. I will give it a go today.

Thanks.

> 
> Thanks,
> Jens
> 
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index cf4718c6d35d..80e2774b5e2a 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -582,6 +582,13 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
>>          return ERR_PTR(-EINVAL);
>>   }
>>
>> +/* optee_remove - Device Removal Routine
>> + * @pdev: platform device information struct
>> + *
>> + * optee_remove is called by platform subsystem to alter the driver
>> + * that it should release the device
>> + */
>> +
>>   static int optee_remove(struct platform_device *pdev)
>>   {
>>          struct optee *optee = platform_get_drvdata(pdev);
>> @@ -612,6 +619,18 @@ static int optee_remove(struct platform_device *pdev)
>>          return 0;
>>   }
>>
>> +/* optee_shutdown - Device Removal Routine
>> + * @pdev: platform device information struct
>> + *
>> + * platform_shutdown is called by the platform subsystem to alter
>> + * the driver that a shutdown/reboot(or kexec) is happening and
>> + * device must be disabled.
>> + */
>> +static void optee_shutdown(struct platform_device *pdev)
>> +{
>> +       optee_disable_shm_cache(platform_get_drvdata(pdev));
>> +}
>> +
>>   static int optee_probe(struct platform_device *pdev)
>>   {
>>          optee_invoke_fn *invoke_fn;
>> @@ -738,6 +757,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
>>   static struct platform_driver optee_driver = {
>>          .probe  = optee_probe,
>>          .remove = optee_remove,
>> +       .shutdown = optee_shutdown,
>>          .driver = {
>>                  .name = "optee",
>>                  .of_match_table = optee_dt_match,
>> --
>> 2.25.1
>>
