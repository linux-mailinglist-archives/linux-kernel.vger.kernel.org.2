Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D23B44E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFYN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFYN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:57:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:54:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j1so10675268wrn.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OmCF3EXb79cyqT+KimnXpzyEkNABaXMyM+9GlcyEQiU=;
        b=Cn7TowtSV9T4Ntsf6eY0RiSHWGXO4sfKEqPPbknw9K5xKGNq+AetNtec17dzLp/8Wa
         bHEW+XqiCCVLGF6v2oddg0LDr5zOtqaoPqME7vc6j74DKpvxSLtI+d1ZrhrxvmrajPOG
         7mz8M/YN3e2s3CIdfm5UAb8Bs/AapS0BW8EakgBpN/7h9kEuBwkkECzdcYzl4jHwbvcU
         jIfVEaEyOB01zV7w1BMp+BUS1z2YuPGPw0cBl/TKwHGzV426WGDsxgnKDQvaOKNPiDTQ
         C4xy6S1UgU0fCIK8Kn/XhpT7NOSDRL/n8j1W3ojZq2UeDg/THakKPft0RDIBhOOAO/vC
         6x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmCF3EXb79cyqT+KimnXpzyEkNABaXMyM+9GlcyEQiU=;
        b=CyAlFyydGQ2fJH5zbJRPl4mSLGsN2+Yt6g7r1Z88qVTOo5yz23A1s4hvzb4LdbM3d7
         lT/BZei+2Kummufy3U+ouRpa9GM15PqPRJkNsrhL3EADupHDc4Oq4b6B5xgXFydePq3v
         pz9szqrvK0tu7eTya7OD95uuQYElQCSxueiTz+iN6VjRs2R0kvwg07qL8FD6VDv92x6a
         4uPA2py6VtaK5gvNtGwszIdnLbsGzKEdoMznyROY6e8efxlbGKEYbX9OasYvdwUwES51
         xjEA6OEAqdXLY/RjPynuOj3+MuE+YqXhMszHEqa6/c+Rw/hzZJlgHxCLPuUqXbGcW6Hx
         3PPw==
X-Gm-Message-State: AOAM533whZY7D3PPpA/gCAVhZX4jpX8FoKKObwmsnJoP4b2NjJFuqYEo
        lug8Az0MjpMDon8Peef3CjcCCA==
X-Google-Smtp-Source: ABdhPJwZI6fBG7TGVWyWkr7vFFGShuSNny50y2wd79o8ixzJqk6Oyg+ubbTUUbDe98vdjzSnurasTA==
X-Received: by 2002:adf:e485:: with SMTP id i5mr11214582wrm.214.1624629277257;
        Fri, 25 Jun 2021 06:54:37 -0700 (PDT)
Received: from [172.25.20.242] (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id f13sm6139535wrt.86.2021.06.25.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 06:54:37 -0700 (PDT)
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, platform-driver-x86@vger.kernel.org
References: <20210622142334.14883-1-hans-gert.dahmen@immu.ne>
 <YNJB4HoRa6qWgOJC@kroah.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Message-ID: <8b29585e-ace7-35ef-0317-99663f82024c@immu.ne>
Date:   Fri, 25 Jun 2021 15:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNJB4HoRa6qWgOJC@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the first time I am working on the Linux kernel, so please 
excuse that I overlooked some things.

On 22.06.21 22:02, Greg KH wrote:
> On Tue, Jun 22, 2021 at 04:23:34PM +0200, Hans-Gert Dahmen wrote:
>> Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
>> on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
>> for pen-testing, security analysis and malware detection on kernels
>> which restrict module loading and/or access to /dev/mem.
>>
>> It will be used by the open source Converged Security Suite.
>> https://github.com/9elements/converged-security-suite
>>
>> Signed-off-by: Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
>> ---
>>   drivers/firmware/Kconfig             |  9 ++++
>>   drivers/firmware/Makefile            |  1 +
>>   drivers/firmware/x86_64_flash_mmap.c | 65 ++++++++++++++++++++++++++++
>>   3 files changed, 75 insertions(+)
>>   create mode 100644 drivers/firmware/x86_64_flash_mmap.c
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index db0ea2d2d75a..bd77ca2b4fa6 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -296,6 +296,15 @@ config TURRIS_MOX_RWTM
>>   	  other manufacturing data and also utilize the Entropy Bit Generator
>>   	  for hardware random number generation.
>>   
>> +config X86_64_FLASH_MMAP
>> +	tristate "Export platform flash memory-mapped BIOS region"
>> +	depends on X86_64
>> +	help
>> +	  Export the memory-mapped BIOS region of the platform SPI flash as
>> +	  a read-only sysfs binary attribute on X86_64 systems. The first 16MiB
>> +	  will be accessible via /sys/kernel/firmware/flash_mmap/bios_region
>> +	  for security and malware analysis for example.
> 
> Module name information here?
> 
> Can this be auto-loaded based on hardware-specific values somewhere?
> Otherwise it just looks like if this module loads, it will "always
> work"?
> 
> And why would you want to map the bios into userspace?
> 
> What bios, UEFI?
> 
> And you need a Documentation/ABI/ update for new sysfs files.

The core use-case is security analysis and detecting BIOS/UEFI malware. 
It is going to be used by the open-source Converged Security Suite 
developed by Facebook, Google and 9elements security. The CSS dissects 
UEFI binaries and checks it for common vulnerabilities.

The current state is that there are some drivers to access the SPI flash 
bit they are in a questionable state and often don't work. Using this 
memory mapped region works most of the time without requiring a real 
hardware driver and significantly lowers the barrier to asses UEFI 
security of systems deployed in the wild.

In another mail I have shown that this can safely be done on Intel 
systems so I will make this module load on Intel systems for now and 
also fix the documentation.

> 
> 
>> +
>>   source "drivers/firmware/broadcom/Kconfig"
>>   source "drivers/firmware/google/Kconfig"
>>   source "drivers/firmware/efi/Kconfig"
>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>> index 5e013b6a3692..eb7483c5a2ac 100644
>> --- a/drivers/firmware/Makefile
>> +++ b/drivers/firmware/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_QCOM_SCM)		+= qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
>>   obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>>   obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
>>   obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
>> +obj-$(CONFIG_X86_64_FLASH_MMAP)	+= x86_64_flash_mmap.o
>>   
>>   obj-y				+= arm_scmi/
>>   obj-y				+= broadcom/
>> diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x86_64_flash_mmap.c
>> new file mode 100644
>> index 000000000000..f9d871a8b516
>> --- /dev/null
>> +++ b/drivers/firmware/x86_64_flash_mmap.c
>> @@ -0,0 +1,65 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Export the memory-mapped BIOS region of the platform SPI flash as
>> + * a read-only sysfs binary attribute on X86_64 systems.
>> + *
>> + * Copyright © 2021 immune GmbH
>> + */
>> +
>> +#include <linux/version.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/kobject.h>
>> +
>> +#define FLASH_REGION_START 0xFF000000ULL
>> +#define FLASH_REGION_SIZE 0x1000000ULL
> 
> Where do these values come from?

I have listed the relevant Intel datasheets in another mail in this thread.

> 
>> +#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
>> +
>> +struct kobject *kobj_ref;
> 
> Only 1?  Not per-hardware-device?

Yes, there is only one BIOS/UEFI that is configured to actively boot the 
system. This method is not suitable to access shadow flash chips or 
other wild things that mainboard manufacturers did in the past.

> 
>> +
>> +static ssize_t bios_region_read(struct file *file, struct kobject *kobj,
>> +				struct bin_attribute *bin_attr, char *buffer,
>> +				loff_t offset, size_t count)
>> +{
>> +	resource_size_t pa = FLASH_REGION_START + (offset & FLASH_REGION_MASK);
>> +	void __iomem *va = ioremap(pa, PAGE_SIZE);
> 
> Why PAGE_SIZE?

Please correct me if I'm wrong: the documentation is sparse and from 
what I could see in the sources it appears that binary attributes pass a 
page sized buffer around. I was assuming that the offset parameter would 
be page aligned.

> 
>> +
>> +	memcpy_fromio(buffer, va, PAGE_SIZE);
>> +	iounmap(va);
>> +
>> +	return min(count, PAGE_SIZE);
>> +}
>> +
>> +BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
>> +
>> +static int __init flash_mmap_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	kobj_ref = kobject_create_and_add("flash_mmap", firmware_kobj);
>> +	ret = sysfs_create_bin_file(kobj_ref, &bin_attr_bios_region);
> 
> You just raced with userspace and lost :(

I have taken inspiration from other modules. The documentation doesn't 
say a lot. Could somebody point me to a proper example somewhere in the 
source?

> 
> Please make a sysfs attribute part of a default "group" for a kobject.
> But as you are using a "raw" kobject here, that feels really wrong to
> me.  Isn't this some sort of platform device really?  Why not go that
> way, why tie this to the firmware subsystem?
> 

What this module provides read access to is the firmware. I am new to 
Linux kernel development and found it quite hard to decide where to put 
this. Suggestions are welcome.

>> +	if (ret) {
>> +		pr_err("sysfs_create_bin_file failed\n");
>> +		goto error;
>> +	}
>> +
>> +	return ret;
> 
> So this just "always works"?  That feels VERY dangerous.

Will change that.

> 
> As this is a x86 thing, you should also cc: the x86 maintainers.

Will do.

> 
> thanks,
> 
> greg k-h
> 

Hans-Gert Dahmen
