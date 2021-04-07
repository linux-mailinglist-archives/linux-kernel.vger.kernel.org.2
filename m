Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A63564D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhDGHOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhDGHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617779678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5uxaAMCe4qsDYncXjttivmeObDPAYgiHMnx3v4l6to=;
        b=SGYtOgDjRdfGmRSRcL45lYDW3BR8MKcNreejjMCkYJ/GmnNNQpIQYwpVKMXAxlte9+UZSD
        iH4Fd7oKn/O7G4NgKcDRiPdYn9An2gy8MBDuHiQ24d1uWANGt+4QLHZ7BmVPO9HPvDC0Rf
        saVlvVaL35ZBTO5+cmYSPl61xshfsrg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-y5eXcVqYOBedqaOhTPwxsA-1; Wed, 07 Apr 2021 03:14:36 -0400
X-MC-Unique: y5eXcVqYOBedqaOhTPwxsA-1
Received: by mail-ed1-f72.google.com with SMTP id r6so11662742edh.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 00:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x5uxaAMCe4qsDYncXjttivmeObDPAYgiHMnx3v4l6to=;
        b=p09fNiw9E8hxcB8szGx7PYET/qxIspDJnjvsTILENtkKrTIpxHCzNH53I6k4DweIVB
         W1IpdwK5QA1Yr75noJ5eA/j65VtPQmEoQcPTIgFnDktVolNHdtRbfLxW/30ap7Bfl+4Y
         apWCNFduXbhftM1XIISk42+1KTUJXueKUoSWfrLZoCiEgSGJb8YknSTdlO0lbTLI6i2N
         hhAQWhz5ZA55EjXcGdhJI89ccIN7bbc/fWsrzAwazgEGgKCHQbQjTwD/mGIOG0h0VqQ4
         AB6a0cwkKAG+2u6cUoNM3iWUXCc0Zh5+njfjd1lev8bWkIBFqK0s0/7LGpYXWOouPwzp
         6TMg==
X-Gm-Message-State: AOAM531evnl+YSNXfDw+hd44laJXg2EDpUaccRm3anaerpod/5qrAVHs
        MNh6lHGs+CuoN90l3uLs8lOz5/13d1kZ8c8dmGvgJn+uDeu5FpeS9NCvIp3bQE/hEM5k1fRd4o8
        DAyza/BraCUjWVBfnxHcRjEJL
X-Received: by 2002:a17:906:8988:: with SMTP id gg8mr2060693ejc.264.1617779675507;
        Wed, 07 Apr 2021 00:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYDvnCb1FB16cvjU4I/CTHGzPohPRbMvFLOVnBhq6jzcOrr5LHkuvwzfAe8isJdtltWRC6mg==
X-Received: by 2002:a17:906:8988:: with SMTP id gg8mr2060670ejc.264.1617779675217;
        Wed, 07 Apr 2021 00:14:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i2sm15404019edy.72.2021.04.07.00.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 00:14:34 -0700 (PDT)
Subject: Re: [PATCH v4] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "Box, David E" <david.e.box@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210402152113.1191796-1-tomas.winkler@intel.com>
 <d5021cc2-46c7-7c78-73b1-af50524e1db2@redhat.com>
 <3387dd6987634bffb7a5082d70bdecfc@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69b15385-8df2-b825-1977-a03abca70327@redhat.com>
Date:   Wed, 7 Apr 2021 09:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3387dd6987634bffb7a5082d70bdecfc@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/7/21 8:51 AM, Winkler, Tomas wrote:
>>>
>>> During PCH (platform/board) manufacturing process a global reset has
>>> to be induced in order for configuration changes take the effect upon
>>> following platform reset.
>>> This setting was commonly done by accessing PMC registers via /dev/mem
>>> but due to security concern /dev/mem access is much restricted, hence
>>> the reason for exposing this setting via dedicated sysfs interface.
>>> To prevent post manufacturing abuse the register is protected by
>>> hardware locking.
>>
>> The purpose of this reset functionality is not entirely clear to me.
>>
>> Is this only used during production of a board? Or is this also something
>> which a user/reseller may use as part of a factory-reset procedure?
> 
> Board production and refurbishing of the board. I can try to rephrase but I thought all the info is in the commit message. 
> As a runtime feature a user can check that her/his platform is correctly sealed. 

Manufacturing is clear, refurbishing is very much not clear, do you mean
actually desoldering the chip and replacing it with a new one ?

>> If this is only used once during production, then I'm not sure if introducing a
>> sysfs file for this is desirable.
> 
> What do you suggest, than?  I'm just guessing is where are you heading so the answer is that the manufacturing
> is often already run on the production OS installation,  w/o going into details swapping or reconfiguring the OS is not always an option.
> The manufacturer is also a user of ours.

Ok, so lets compromise here, please make use of the visibility sysfs attribute
callback, which returns a umask and make the file read-only at the umask level
if it has been sealed, to make it clear to users that they cannot write to it,
the -EACCES error means 'Permission denied' so if the user is already root
they are going to get mightily confused if ls -l shows the file is writable.

Also on set you are checking that the written value is bit 20, and on
show you are showing the contents of the "Extended Test Mode Register 3" in hex,
or at least those bits you are willing to show.

So in essence what you are doing here is giving userspace (some) access
to the "Extended Test Mode Register 3", I would prefer to spell that out
explicitly. The global_reset sysfs file name to me too much hints at
something which the user can trigger / use while it is not intended for
user usage.

Also the Documentation/ABI/testing/sysfs-platform-intel-pm file pretty much
describes this as direct register access rather then as some reset mechanism.

So I think it would be better to call the new file extended_test_mode_register3,
this will also be useful if we need to provide access to other bits in the
same register later; and this will be a good template to follow if we need to
provide some access to other registers later too.

Regards,

Hans



> 
>>
>> Can you please provide a new version where the purpsoe of the newly
>> introduced sysfs file is made more clear, both in the commit-msg as well as in
>> the:
> Okay I can do that.
>>
>> Documentation/ABI/testing/sysfs-platform-intel-pmc
>>
>> File ?
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>>
>>> The register in MMIO space is defined for Cannon Lake and newer PCHs.
>>>
>>> Cc: David E Box <david.e.box@intel.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
>>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>>> ---
>>> 2:
>>> 1. Add locking for reading the ET3 register  (Andy) 2. Fix few style
>>> issues (Andy)
>>> V3:
>>> 1. Resend
>>> v4:
>>> 1. Fix return statement (Andy)
>>> 2. Specify manufacturing process (Enrico)
>>>
>>>  .../ABI/testing/sysfs-platform-intel-pmc      | 11 +++
>>>  MAINTAINERS                                   |  1 +
>>>  drivers/platform/x86/intel_pmc_core.c         | 97 +++++++++++++++++++
>>>  drivers/platform/x86/intel_pmc_core.h         |  6 ++
>>>  4 files changed, 115 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-pmc
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc
>>> b/Documentation/ABI/testing/sysfs-platform-intel-pmc
>>> new file mode 100644
>>> index 000000000000..7ce00e77fbcd
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
>>> @@ -0,0 +1,11 @@
>>> +What:		/sys/devices/platform/<platform>/global_reset
>>> +Date:		Apr 2021
>>> +KernelVersion:	5.13
>>> +Contact:	"Tomas Winkler" <tomas.winkler@intel.com>
>>> +Description:
>>> +		Display global reset setting bits for PMC.
>>> +			* bit 31 - global reset is locked
>>> +			* bit 20 - global reset is set
>>> +		Writing bit 20 value to the global_reset will induce
>>> +		a platform global reset upon consequent platform reset.
>>> +		in case the register is not locked.
>>> diff --git a/MAINTAINERS b/MAINTAINERS index
>>> 04f68e0cda64..618676eba8c8 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9166,6 +9166,7 @@ M:	Rajneesh Bhardwaj
>> <irenic.rajneesh@gmail.com>
>>>  M:	David E Box <david.e.box@intel.com>
>>>  L:	platform-driver-x86@vger.kernel.org
>>>  S:	Maintained
>>> +F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>>>  F:	drivers/platform/x86/intel_pmc_core*
>>>
>>>  INTEL PMIC GPIO DRIVERS
>>> diff --git a/drivers/platform/x86/intel_pmc_core.c
>>> b/drivers/platform/x86/intel_pmc_core.c
>>> index ee2f757515b0..8afc198550a4 100644
>>> --- a/drivers/platform/x86/intel_pmc_core.c
>>> +++ b/drivers/platform/x86/intel_pmc_core.c
>>> @@ -401,6 +401,7 @@ static const struct pmc_reg_map cnp_reg_map = {
>>>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>>>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>>>  	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
>>> +	.etr3_offset = ETR3_OFFSET,
>>>  };
>>>
>>>  static const struct pmc_reg_map icl_reg_map = { @@ -418,6 +419,7 @@
>>> static const struct pmc_reg_map icl_reg_map = {
>>>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>>>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>>>  	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
>>> +	.etr3_offset = ETR3_OFFSET,
>>>  };
>>>
>>>  static const struct pmc_bit_map tgl_clocksource_status_map[] = { @@
>>> -585,6 +587,7 @@ static const struct pmc_reg_map tgl_reg_map = {
>>>  	.lpm_sts = tgl_lpm_maps,
>>>  	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
>>>  	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
>>> +	.etr3_offset = ETR3_OFFSET,
>>>  };
>>>
>>>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int
>>> reg_offset) @@ -603,6 +606,99 @@ static inline u64
>> pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
>>>  	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
>>>  }
>>>
>>> +static int set_global_reset(struct pmc_dev *pmcdev) {
>>> +	const struct pmc_reg_map *map = pmcdev->map;
>>> +	u32 reg;
>>> +	int err;
>>> +
>>> +	if (!map->etr3_offset)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	mutex_lock(&pmcdev->lock);
>>> +
>>> +	/* check if CF9 is locked */
>>> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
>>> +	if (reg & ETR3_CF9LOCK) {
>>> +		err = -EACCES;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	/* write CF9 global reset bit */
>>> +	reg |= ETR3_CF9GR;
>>> +	pmc_core_reg_write(pmcdev, map->etr3_offset, reg);
>>> +
>>> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
>>> +	if (!(reg & ETR3_CF9GR)) {
>>> +		err = -EIO;
>>> +		goto out_unlock;
>>> +	}
>>> +
>>> +	err = 0;
>>> +
>>> +out_unlock:
>>> +	mutex_unlock(&pmcdev->lock);
>>> +	return err;
>>> +}
>>> +
>>> +static ssize_t global_reset_show(struct device *dev,
>>> +				 struct device_attribute *attr, char *buf) {
>>> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>> +	const struct pmc_reg_map *map = pmcdev->map;
>>> +	u32 reg;
>>> +
>>> +	if (!map->etr3_offset)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	mutex_lock(&pmcdev->lock);
>>> +
>>> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
>>> +	reg &= ETR3_CF9GR | ETR3_CF9LOCK;
>>> +
>>> +	mutex_unlock(&pmcdev->lock);
>>> +
>>> +	return sysfs_emit(buf, "0x%08x", reg); }
>>> +
>>> +static ssize_t global_reset_store(struct device *dev,
>>> +				  struct device_attribute *attr,
>>> +				  const char *buf, size_t len)
>>> +{
>>> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>> +	int err;
>>> +	u32 reg;
>>> +
>>> +	err = kstrtouint(buf, 16, &reg);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	/* allow only CF9 writes */
>>> +	if (reg != ETR3_CF9GR)
>>> +		return -EINVAL;
>>> +
>>> +	err = set_global_reset(pmcdev);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	return len;
>>> +}
>>> +static DEVICE_ATTR_RW(global_reset);
>>> +
>>> +static struct attribute *pmc_attrs[] = {
>>> +	&dev_attr_global_reset.attr,
>>> +	NULL
>>> +};
>>> +
>>> +static const struct attribute_group pmc_attr_group = {
>>> +	.attrs = pmc_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *pmc_dev_groups[] = {
>>> +	&pmc_attr_group,
>>> +	NULL
>>> +};
>>> +
>>>  static int pmc_core_dev_state_get(void *data, u64 *val)  {
>>>  	struct pmc_dev *pmcdev = data;
>>> @@ -1364,6 +1460,7 @@ static struct platform_driver pmc_core_driver = {
>>>  		.name = "intel_pmc_core",
>>>  		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
>>>  		.pm = &pmc_core_pm_ops,
>>> +		.dev_groups = pmc_dev_groups,
>>>  	},
>>>  	.probe = pmc_core_probe,
>>>  	.remove = pmc_core_remove,
>>> diff --git a/drivers/platform/x86/intel_pmc_core.h
>>> b/drivers/platform/x86/intel_pmc_core.h
>>> index f33cd2c34835..98ebdfe57138 100644
>>> --- a/drivers/platform/x86/intel_pmc_core.h
>>> +++ b/drivers/platform/x86/intel_pmc_core.h
>>> @@ -200,6 +200,11 @@ enum ppfear_regs {
>>>  #define TGL_LPM_STATUS_OFFSET			0x1C3C
>>>  #define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
>>>
>>> +/* Extended Test Mode Register 3 (CNL and later) */
>>> +#define ETR3_OFFSET				0x1048
>>> +#define ETR3_CF9GR				BIT(20)
>>> +#define ETR3_CF9LOCK				BIT(31)
>>> +
>>>  const char *tgl_lpm_modes[] = {
>>>  	"S0i2.0",
>>>  	"S0i2.1",
>>> @@ -263,6 +268,7 @@ struct pmc_reg_map {
>>>  	const u32 lpm_residency_offset;
>>>  	const u32 lpm_status_offset;
>>>  	const u32 lpm_live_status_offset;
>>> +	const u32 etr3_offset;
>>>  };
>>>
>>>  /**
>>>
> 

