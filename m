Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968CA3FA13F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhH0VqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhH0VqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:46:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB65C0613D9;
        Fri, 27 Aug 2021 14:45:27 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so9664529otg.11;
        Fri, 27 Aug 2021 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ouZTg4zsFx0uMVk4ebH+S61geCrhsSVEPoyVZAJgaQ=;
        b=Cof9235zkIdizb3baMDkhJmYgicHTyasHHeKSbkwcGPwTN6+6CuNuX3SoBqhDwTczf
         +/6P/O+31vN/UrYF9kQvtHehfZgmvGY6l1k+TEy813hG+pInhBXsrg3dA98ShzDCYGzQ
         A/ZMSoExgb9Thyxw4Vou8BxaJVmNS1DYn4tdFczMERJPMnz5rPnIY2AcsGrUIdCi+JMV
         d4q/oS3bUXb0zsZUpvEGWLbs9pqhlw31nP+VMVQnl7Z8xw9E7nEhPzFa8mlEnHxPYfme
         CHCcmufEQ52bi2Yym5gYxzEvoLgcOY7ZFfvkYEmmbV+3X329+8k+AqZFh+WXOar9xQQS
         zC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ouZTg4zsFx0uMVk4ebH+S61geCrhsSVEPoyVZAJgaQ=;
        b=eDAHhOBAuxKChLS2uqemn902Hxika19E9btFMFBd0mcHwFC+PUKVnfw9iKr2GEW4bI
         9loEg/V/afVECTDiZG3jbmcBP1S7koG84NriynwyIqtopbrDFqTFf0P63kRvsXeuBdkL
         dM8eGtMqlE9y+TxSC88EGCEmKs0hmrqWydo7k2naGM51+vcogpfY/TXFH0xYmurDWuHB
         mPQ7AEqPHuskZy1OnPhy8fa1dnuOwAvUTrhVpwUvp2lN7lT8eo86GFugNnVOdnN1iWts
         ZwJlUMFiObSAqM6BHazEh/vPLbjFnS2Fb732gMgxuaYO7xNB45vRPz2kM0wiprtepuxS
         Ir1A==
X-Gm-Message-State: AOAM5331pAK0mc/jT1pVwW6feba72Hrwayb1DqnnoWPeZGLmSURyxGFC
        BGSG7JK2eS+5e936PTdl1hS/cJaD9d4=
X-Google-Smtp-Source: ABdhPJyzDnRWqTspGlf7kEb23/DrG5O8uEQibg9lWAsqsjcmMWndEQ4Jc3T0HI0nFqDdXwFijHCReA==
X-Received: by 2002:a05:6830:2151:: with SMTP id r17mr10034408otd.141.1630100726509;
        Fri, 27 Aug 2021 14:45:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16sm1440768oop.3.2021.08.27.14.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 14:45:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Wei Huang <wei.huang2@amd.com>,
        Jean Delvare <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-4-mario.limonciello@amd.com>
 <20210827210648.GA678755@roeck-us.net>
 <90d283d0-06f6-baa5-b41b-fcd2f4b3ba99@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/3] hwmon: (k10temp): Show errors failing to read
Message-ID: <ebdfd938-d381-3c8f-8b7f-accfd90f4169@roeck-us.net>
Date:   Fri, 27 Aug 2021 14:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <90d283d0-06f6-baa5-b41b-fcd2f4b3ba99@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/21 2:10 PM, Limonciello, Mario wrote:
> On 8/27/2021 16:06, Guenter Roeck wrote:
>> On Fri, Aug 27, 2021 at 03:15:27PM -0500, Mario Limonciello wrote:
>>> Enabling Yellow Carp was initially not working "properly"
>>> because extra IDs were needed, but this wasn't obvious because fail values
>>> from `amd_smn_read` were ignored.
>>>
>>> Don't discard errors from any functions providing them, instead pass up
>>> to the caller.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/hwmon/k10temp.c | 87 ++++++++++++++++++++++++-----------------
>>>   1 file changed, 52 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>>> index 38bc35ac8135..2edb49d39d22 100644
>>> --- a/drivers/hwmon/k10temp.c
>>> +++ b/drivers/hwmon/k10temp.c
>>> @@ -98,8 +98,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>>>   struct k10temp_data {
>>>       struct pci_dev *pdev;
>>> -    void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>>> -    void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>>> +    int (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
>>> +    int (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
>>>       int temp_offset;
>>>       u32 temp_adjust_mask;
>>>       u32 show_temp;
>>> @@ -129,55 +129,65 @@ static const struct tctl_offset tctl_offset_table[] = {
>>>       { 0x17, "AMD Ryzen Threadripper 29", 27000 }, /* 29{20,50,70,90}[W]X */
>>>   };
>>> -static void read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>>> +static int read_htcreg_pci(struct pci_dev *pdev, u32 *regval)
>>>   {
>>> -    pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>>> +    return pci_read_config_dword(pdev, REG_HARDWARE_THERMAL_CONTROL, regval);
>>>   }
>>> -static void read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>>> +static int read_tempreg_pci(struct pci_dev *pdev, u32 *regval)
>>>   {
>>> -    pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>>> +    return pci_read_config_dword(pdev, REG_REPORTED_TEMPERATURE, regval);
>>>   }
>>> -static void amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>>> +static int amd_nb_index_read(struct pci_dev *pdev, unsigned int devfn,
>>>                     unsigned int base, int offset, u32 *val)
>>>   {
>>> +    int ret;
>>> +
>>>       mutex_lock(&nb_smu_ind_mutex);
>>> -    pci_bus_write_config_dword(pdev->bus, devfn,
>>> -                   base, offset);
>>> -    pci_bus_read_config_dword(pdev->bus, devfn,
>>> -                  base + 4, val);
>>> +    ret = pci_bus_write_config_dword(pdev->bus, devfn,
>>> +                     base, offset);
>>> +    if (ret)
>>> +        goto out;
>>> +    ret = pci_bus_read_config_dword(pdev->bus, devfn,
>>> +                    base + 4, val);
>>> +out:
>>>       mutex_unlock(&nb_smu_ind_mutex);
>>> +    return ret;
>>>   }
>>> -static void read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>> +static int read_htcreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>>   {
>>> -    amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>>> -              F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>>> +    return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>>> +                F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET, regval);
>>>   }
>>> -static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>> +static int read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
>>>   {
>>> -    amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>>> -              F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>> +    return amd_nb_index_read(pdev, PCI_DEVFN(0, 0), 0xb8,
>>> +                F15H_M60H_REPORTED_TEMP_CTRL_OFFSET, regval);
>>>   }
>>> -static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>>> +static int read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
>>>   {
>>> -    amd_smn_read(amd_pci_dev_to_node_id(pdev),
>>> -             ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>>> +    return amd_smn_read(amd_pci_dev_to_node_id(pdev),
>>> +                ZEN_REPORTED_TEMP_CTRL_BASE, regval);
>>>   }
>>> -static long get_raw_temp(struct k10temp_data *data)
>>> +static int get_raw_temp(struct k10temp_data *data, long *val)
>>>   {
>>>       u32 regval;
>>> -    long temp;
>>> +    int ret;
>>> -    data->read_tempreg(data->pdev, &regval);
>>> -    temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>>> +    ret = data->read_tempreg(data->pdev, &regval);
>>> +    if (ret)
>>> +        return ret;
>>> +    *val = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
>>>       if (regval & data->temp_adjust_mask)
>>> -        temp -= 49000;
>>> -    return temp;
>>> +        *val -= 49000;
>>> +    if (*val < 0)
>>> +        return -EINVAL;
>>
>> Please don't do that. More on that see below.
>>
>>> +    return 0;
>>>   }
>>>   static const char *k10temp_temp_label[] = {
>>> @@ -212,24 +222,27 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>>   {
>>>       struct k10temp_data *data = dev_get_drvdata(dev);
>>>       u32 regval;
>>> +    int ret;
>>>       switch (attr) {
>>>       case hwmon_temp_input:
>>>           switch (channel) {
>>>           case 0:        /* Tctl */
>>> -            *val = get_raw_temp(data);
>>> -            if (*val < 0)
>>> -                *val = 0;
>>
>> We have to take the history into account here. A negative value
>> is not an error per se, but it suggests that the chip returns wrong
>> data. See commit aef17ca12719 ("hwmon: (k10temp) Only apply temperature
>> offset if result is positive") for some of the background. I don't really
>> want to change that into an error return just because we don't know
>> what the chip is doing. Please retain the above code, either by fixing
>> the values up here or in get_raw_temp().
> 
> Actually I thought what I was doing *was* making it a lot less ambiguous.
> 
> The caller getting -EINVAL from get_raw_tempt will indicate that the data shouldn't be trusted rather than a surely wrong "0".
> 

First, EINVAL is "Invalid argument" and thus most definitely the wrong
error.

Second, this is a logically different change and violates "one logical
change per patch". You can try to argue this in a separate patch,
but do not try sneak it in with an unrelated change.

Plus, of course, I'd rather get code from AMD that does the right thing
and reports the correct temperature in the observed situation.

Thanks,
Guenter
