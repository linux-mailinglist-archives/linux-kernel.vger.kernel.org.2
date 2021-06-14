Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF23A6BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhFNQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234772AbhFNQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623688332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DISslyfLGhpMa3WyA2T18Pg0TsQiGkTpC7aVUBeR5IM=;
        b=Oe/bs1dw5xCZp+QOubuLqot8KPdio+mTh9GK/0/vpzYkG+t2Mwkkh+QVDaKi6Q4mAOsdwN
        NBgJE5znqOTAmCDi26+lkS2FUIovXNc4qyJzrzYWZ3s2EZVvCKrD5zWIt7/WrOzKOaQZeT
        a4AYlspw48Loe5bN22NnCbQ5bzd83Jo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-9Rt0MFACNfm04za9HN9Tmw-1; Mon, 14 Jun 2021 12:32:04 -0400
X-MC-Unique: 9Rt0MFACNfm04za9HN9Tmw-1
Received: by mail-qk1-f199.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so4653781qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DISslyfLGhpMa3WyA2T18Pg0TsQiGkTpC7aVUBeR5IM=;
        b=lyB3euYA7Pex8ZRG1wZzzW9qXVD5Or/ggqfKTsRn7LVWYcjOGfaRU0JhNRyqcQr5hb
         HSTqyIJjJqfrNBJNfyd1uVnR1XnozvKgFC5rRMthLFMTt0Wyqk9hQvwfBeFEAuNg0DN+
         fkGL4estcNI6swrpZUzjYh+GlhSE6mdUSoOM8nw4U6Rbhl6fc+W+5ePEXvmil4xfgWKq
         0LCam3sHL8sHnSoUjkTfwcFX21LI/NeEyoTr8kbUUjhFOybPX/Ez2cDp02PsQO3je/04
         bkqJ70OqZnxuTboeRXEAZlXDXqaAZGq572PEu3yrJ5d1A5JNCAf1TcEsZ5Eg9+mTgaoT
         UVhw==
X-Gm-Message-State: AOAM532IorUWpbFPPY5ZCQfGmEmUg88VKYp+DL+cr5EEETw3RsYvqhJq
        +i47z0ZaQ0aJaebyZYDSeJ21Ci0xF9ZwkNJmyNORfMnoCNsWc/rNDwXPTavutCSsG5+v5X1saIQ
        E5XsGD88pi+mjHCyo+NlMBJfZ
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr17106000qke.326.1623688324322;
        Mon, 14 Jun 2021 09:32:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCvxn+ltzjQlfYVUxjQ+5bHloF+7JsMElf+UL5szMp3AVyCsKA+9NhZBjoT78OZ0Xt7flNDw==
X-Received: by 2002:a37:a2d6:: with SMTP id l205mr17105966qke.326.1623688324062;
        Mon, 14 Jun 2021 09:32:04 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j14sm8455892qtq.56.2021.06.14.09.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:32:03 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 4/4] driver core: Allow showing cpu as offline if not
 valid in cpuset context
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210614152306.25668-1-longman@redhat.com>
 <20210614152306.25668-5-longman@redhat.com> <YMd7PEU0KPulsgMz@kroah.com>
Message-ID: <ad33a662-7ebe-fb92-4459-5dd85a013501@redhat.com>
Date:   Mon, 14 Jun 2021 12:32:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMd7PEU0KPulsgMz@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 11:52 AM, Greg KH wrote:
> On Mon, Jun 14, 2021 at 11:23:06AM -0400, Waiman Long wrote:
>> Make /sys/devices/system/cpu/cpu<n>/online file to show a cpu as
>> offline if it is not a valid cpu in a proper cpuset context when the
>> cpuset_bound_cpuinfo sysctl parameter is turned on.
> This says _what_ you are doing, but I do not understand _why_ you want
> to do this.
>
> What is going to use this information?  And now you are showing more
> files than you previously did, so what userspace tool is now going to
> break?

One reason that is provided by the customer asking for this 
functionality is because some applications use the number of cpu cores 
for licensing purpose. Even though the applications are running in a 
container with a smaller set of cpus, they may still charge as if all 
the cpus are available. They ended up using a bind mount to mount over 
the cpuX/online file.

I should have included this information in the patchset.


>
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/base/core.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 54ba506e5a89..176b927fade2 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/sched/mm.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/dma-map-ops.h> /* for dma_default_coherent */
>> +#include <linux/cpuset.h>
>>   
>>   #include "base.h"
>>   #include "power/power.h"
>> @@ -2378,11 +2379,24 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
>>   }
>>   static DEVICE_ATTR_RW(uevent);
>>   
>> +static bool is_device_cpu(struct device *dev)
>> +{
>> +	return dev->bus && dev->bus->dev_name
>> +			&& !strcmp(dev->bus->dev_name, "cpu");
>> +}
> No, this is not ok, there is a reason we did not put RTTI in struct
> devices, so don't try to fake one here please.
>
>> +
>>   static ssize_t online_show(struct device *dev, struct device_attribute *attr,
>>   			   char *buf)
>>   {
>>   	bool val;
>>   
>> +	/*
>> +	 * Show a cpu as offline if the cpu number is not valid in a
>> +	 * proper cpuset bounding cpuinfo context.
>> +	 */
>> +	if (is_device_cpu(dev) && !cpuset_current_cpu_valid(dev->id))
>> +		return sysfs_emit(buf, "0\n");
> Why are you changing the driver core for a single random, tiny set of
> devices?  The device code for those devices can handle this just fine,
> do NOT modify the driver core for each individual driver type, that way
> lies madness.
>
> This change is not ok, sorry.

OK, thanks for the comments. I will see if there is alternative way of 
doing it.

Cheers,
Longman

