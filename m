Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A273F3D8A50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhG1JK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230520AbhG1JK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627463426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIVE6zqlAFnf5TgD5F5ZRXOVlE25qGQt6KHbh4ikc0M=;
        b=EHCLmtqz/mehTsehDjvpLoHcg3jOOT2Cy7zi29MhidOUEK2Sx5YfpUr0dPUho9Fv5eKMQe
        0SlEa9GDCIcsq2tGJsi8C/SC0HPMUOp0YNdoStszS7Ta22mjKTjCl0xqLxDM/VevBCnsyg
        EipjTGGJT3nKE0xtaCdqca5btkjQHfw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-3i2CoQ9oM5izLYA0-UaBXw-1; Wed, 28 Jul 2021 05:10:24 -0400
X-MC-Unique: 3i2CoQ9oM5izLYA0-UaBXw-1
Received: by mail-ej1-f71.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso586858ejb.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIVE6zqlAFnf5TgD5F5ZRXOVlE25qGQt6KHbh4ikc0M=;
        b=pVqh1et2xl87JHlmCwEWy2RORKv+TDN/4voARexiYCXvFfrbPZ7ab0X2n2STMW+yL7
         syDVa4ss2TEYFAwpmFKXRjibRlyAny0/8BXar3KPzScB0HXB34M9GLbfvmP1ce5x3rkZ
         SLW/gwTJOJzqPki9bLSEmhRQUJm91DSxXtYTXlKDHB3MccuskeMDLziLQtIRCDcu/Jap
         cYtNMFSxWGjPd2ioRTMh+P1nf4lYaDcp/4qJm+6T/n0OONsPKy51pXqD8tEW0APGCfuA
         Xr6qk11G1i7butpfzBn8F0vVU0vbOcTuwnoOvY6BX69dsXZaTolnwXHz9CD8s1P+CLdz
         VRdg==
X-Gm-Message-State: AOAM531LxT5R9jw/vNkrtoSYylT1ZCuIkMdVcnVviP/Ykym2ErRuKDU8
        1JBp9j256IDNSK4rlVVdOoW7qKscMWfoKWPkb6uknzSbgamrvE3zfUnBxxiX/pCd63KyetTaOhn
        GmjTd4i6vGX1hbsP9ED6fLN0t
X-Received: by 2002:a17:906:2547:: with SMTP id j7mr12542177ejb.491.1627463423104;
        Wed, 28 Jul 2021 02:10:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfOAqX4sUvZiXyEc3viUelpZYIe5hgv9UfRYjIObD/mH3YbzjOeJSn/2+bGjJA3sHP8RZ2ow==
X-Received: by 2002:a17:906:2547:: with SMTP id j7mr12542165ejb.491.1627463422923;
        Wed, 28 Jul 2021 02:10:22 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id cw9sm1780398ejc.59.2021.07.28.02.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:10:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] acpi: Add acpi_init_properties to ACPI driver code
From:   Hans de Goede <hdegoede@redhat.com>
To:     Michael Bottini <michael.a.bottini@linux.intel.com>,
        rjw@rjwysocki.net, lenb@kernel.org, irenic.rajneesh@gmail.com,
        david.e.box@linux.intel.com, mgross@linux.intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
 <d8e4f0f3-7282-50d4-16ac-2f67b210373c@redhat.com>
Message-ID: <1fd1a48e-3756-e933-9038-cb3f3e247144@redhat.com>
Date:   Wed, 28 Jul 2021 11:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d8e4f0f3-7282-50d4-16ac-2f67b210373c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/21 11:08 AM, Hans de Goede wrote:
> Hi,
> 
> On 7/23/21 10:21 PM, Michael Bottini wrote:
>> Some products in the field, like Intel Rocket Lake systems, contain
>> AML code that can modify _DSD properties after they have been
>> evaluated by ACPI init code. Therefore, there is a need for drivers
>> to be able to reevaluate _DSDs so that the updated property values can
>> be read. Export acpi_init_properties() for this purpose.
>>
>> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> 
> My first instinct here is this is a firmware bug and we should
> go out of our way here to not support this and to instead apply
> pressure on the vendor to get the firmware fixed.
> 
> Let me explain, the standard use of _DSD is to allow embedding
> open-firmware/devicetree style properties inside ACPI nodes.
> 
> devicetree files, unlike AML contain static information, which
> is parsed once and only once.
> 
> Allowing AML code to dynamically change _DSD results pretty
> much breaks this entire model.
> 
> So I might be shooting from the hip a bit here:
> "no, just no". IOW nack.

I should have read the rest of the thread first I guess.

I see that Andy and Rafael are saying the same thing.

So here we have 3 people who all 3 are somewhat experts in ACPI
saying no to this. So yes please talk to the BIOS team as you
indicated elsewhere in the thread.

Regards,

Hans




>> ---
>>  drivers/acpi/property.c | 1 +
>>  include/linux/acpi.h    | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
>> index e312ebaed8db..2c1f8cf1a8f0 100644
>> --- a/drivers/acpi/property.c
>> +++ b/drivers/acpi/property.c
>> @@ -432,6 +432,7 @@ void acpi_init_properties(struct acpi_device *adev)
>>  	if (!adev->data.pointer)
>>  		acpi_extract_apple_properties(adev);
>>  }
>> +EXPORT_SYMBOL(acpi_init_properties);
>>  
>>  static void acpi_destroy_nondev_subnodes(struct list_head *list)
>>  {
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 72e4f7fd268c..57defc3bc9b9 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -716,6 +716,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
>>  
>>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
>>  
>> +void acpi_init_properties(struct acpi_device *adev);
>> +
>>  #else	/* !CONFIG_ACPI */
>>  
>>  #define acpi_disabled 1
>> @@ -976,6 +978,10 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>>  	return -ENODEV;
>>  }
>>  
>> +static inline void acpi_init_properties(struct acpi_device *adev)
>> +{
>> +}
>> +
>>  #endif	/* !CONFIG_ACPI */
>>  
>>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>>

