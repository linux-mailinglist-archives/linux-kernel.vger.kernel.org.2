Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4A35D8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhDMH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229838AbhDMH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618298832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbNlXmW4twHjiHjHaeXid9uU36Go38oRtJs3RsrBYfw=;
        b=Ttuxwns2UxXUTtrSpdoybQJ99yvOYgc5L90LlOnXo0gZut8DNMVnm9Dht9gLzA+8Igp/wf
        4tppvf/X6StdPrdAb9mZ17An2IcPzM8VF/Gnp3O0tWaieQdd8gy/54t2jPlbDoriHQyOss
        ZrRw6IQjYGeBMt+Sng9oBoXKlyYzSnc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-TCnXsz30Nn6l_DkDJiG-fg-1; Tue, 13 Apr 2021 03:27:11 -0400
X-MC-Unique: TCnXsz30Nn6l_DkDJiG-fg-1
Received: by mail-ej1-f69.google.com with SMTP id jt26so4741657ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbNlXmW4twHjiHjHaeXid9uU36Go38oRtJs3RsrBYfw=;
        b=Z6Oxf0znWzI6FE6r+5FAHMe6k0rVGkBV/9F0apS/4KelHvoKi7rR1kmwpihNo6BSbq
         2CiOnyY54Qo4y6zQ7FKMGyrMPMshVOSO9GeZtti5ENF0HR/K/hq6/atNO6glsV0A1M7c
         el/s4/lJJsv41qIMKQ44vMwn7+YLxxBZPv5IEWCT6ZQF3zt5hstP3ecdXiD2t1l+nN6x
         gU9ZHDevwpDQ8dtiHq7ZkhC6l9NBl1FmsmrKMHyAJH5CADp6olOqJw/1pxZjS77j+SnF
         YuyFCSmSGREIwkQiJJ29kKIBKTFyB1NFnbBAIQKUmAlrBtfUijRf65d9pdFwNE5KYUWJ
         /l6Q==
X-Gm-Message-State: AOAM533kkTz6pLULKKLwvoBvNYvDl1YIDK/ceJq01XdwZwMy+pwxReTr
        hlfIWG3uBfgQf+vWu+aHUKUxAuGpeRIReXDKjKlFna2Xn/+A9aev4LSed3BWB4ty2Nww5jEEB2x
        XOR61SqvPtHQcxY/DKSjB8uXl
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr30733614ejz.244.1618298829696;
        Tue, 13 Apr 2021 00:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ+VkdAhIghxIna0GDqrGWN4W90YHkOrQc+JVIRmx8CO0Slp2tgYUlOwgV1IuZf+PPzcGzmw==
X-Received: by 2002:a17:906:b202:: with SMTP id p2mr30733601ejz.244.1618298829477;
        Tue, 13 Apr 2021 00:27:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e20sm2275247ejy.66.2021.04.13.00.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 00:27:08 -0700 (PDT)
Subject: Re: [PATCH v6] platform/x86: intel_pmc_core: export platform global
 reset bits via etr3 sysfs file
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210411141532.3004893-1-tomas.winkler@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1ab9f53a-d33c-308a-bb1a-5aefcb6077cc@redhat.com>
Date:   Tue, 13 Apr 2021 09:27:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210411141532.3004893-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/11/21 4:15 PM, Tomas Winkler wrote:
> From: Tamar Mashiah <tamar.mashiah@intel.com>
> 
> During PCH (platform/board) manufacturing process a global platform
> reset has to be induced in order for the configuration changes take
> the effect upon following platform reset. This is an internal platform
> state and is not intended to be used in the regular platform resets.
> The setting is exposed via ETR3 (Extended Test Mode Register 3).
> After the manufacturing process is completed the register cannot be
> written anymore and is hardware locked.
> This setting was commonly done by accessing PMC registers via /dev/mem
> but due to security concerns /dev/mem access is much more restricted,
> hence the reason for exposing this setting via the dedicated sysfs
> interface.
> To prevent post manufacturing abuse the register is protected
> by hardware locking and the file is set to read-only mode via is_visible
> handler.
> 
> The register in MMIO space is defined for Cannon Lake and newer PCHs.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: David E Box <david.e.box@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> V2:
> 1. Add locking for reading the ET3 register  (Andy)
> 2. Fix few style issues (Andy)
> V3:
> 1. Resend
> v4:
> 1. Fix return statement (Andy)
> 2. Specify manufacturing process (Enrico)
> V5:
> 1. Rename sysfs file to etr3 (Hans)
> 2. Make file read only when register is locked (Hans)
> 3. Add more info to sysfs ABI documentation
> V5:
> 1. Parentheses around arithmetic in operand of '|' [-Wparentheses] (lkp)
>    656 |  return reg & ETR3_CF9LOCK ? attr->mode & SYSFS_PREALLOC | 0444 : attr->mode
> 
>  .../ABI/testing/sysfs-platform-intel-pmc      |  20 ++++
>  MAINTAINERS                                   |   1 +
>  drivers/platform/x86/intel_pmc_core.c         | 113 ++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h         |   6 +
>  4 files changed, 140 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-pmc
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> new file mode 100644
> index 000000000000..ef199af75ab0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> @@ -0,0 +1,20 @@
> +What:		/sys/devices/platform/<platform>/etr3
> +Date:		Apr 2021
> +KernelVersion:	5.13
> +Contact:	"Tomas Winkler" <tomas.winkler@intel.com>
> +Description:
> +		The file exposes "Extended Test Mode Register 3" global
> +		reset bits. The bits are used during an Intel platform
> +		manufacturing process to indicate that consequent reset
> +		of the platform is a "global reset". This type of reset
> +		is required in order for manufacturing configurations
> +		to take effect.
> +
> +		Display global reset setting bits for PMC.
> +			* bit 31 - global reset is locked
> +			* bit 20 - global reset is set
> +		Writing bit 20 value to the etr3 will induce
> +		a platform "global reset" upon consequent platform reset,
> +		in case the register is not locked.
> +		The "global reset bit" should be locked on a production
> +		system and the file is in read-only mode.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7dd6b67f0f51..3e898660b5b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9145,6 +9145,7 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>  M:	David E Box <david.e.box@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>  F:	drivers/platform/x86/intel_pmc_core*
>  
>  INTEL PMIC GPIO DRIVERS
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b5888aeb4bcf..8fb4e6d1d68d 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -401,6 +401,7 @@ static const struct pmc_reg_map cnp_reg_map = {
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>  	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
> +	.etr3_offset = ETR3_OFFSET,
>  };
>  
>  static const struct pmc_reg_map icl_reg_map = {
> @@ -418,6 +419,7 @@ static const struct pmc_reg_map icl_reg_map = {
>  	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>  	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>  	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
> +	.etr3_offset = ETR3_OFFSET,
>  };
>  
>  static const struct pmc_bit_map tgl_clocksource_status_map[] = {
> @@ -585,6 +587,7 @@ static const struct pmc_reg_map tgl_reg_map = {
>  	.lpm_sts = tgl_lpm_maps,
>  	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
>  	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
> +	.etr3_offset = ETR3_OFFSET,
>  };
>  
>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
> @@ -603,6 +606,115 @@ static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
>  	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
>  }
>  
> +static int set_etr3(struct pmc_dev *pmcdev)
> +{
> +	const struct pmc_reg_map *map = pmcdev->map;
> +	u32 reg;
> +	int err;
> +
> +	if (!map->etr3_offset)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&pmcdev->lock);
> +
> +	/* check if CF9 is locked */
> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +	if (reg & ETR3_CF9LOCK) {
> +		err = -EACCES;
> +		goto out_unlock;
> +	}
> +
> +	/* write CF9 global reset bit */
> +	reg |= ETR3_CF9GR;
> +	pmc_core_reg_write(pmcdev, map->etr3_offset, reg);
> +
> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +	if (!(reg & ETR3_CF9GR)) {
> +		err = -EIO;
> +		goto out_unlock;
> +	}
> +
> +	err = 0;
> +
> +out_unlock:
> +	mutex_unlock(&pmcdev->lock);
> +	return err;
> +}
> +static umode_t etr3_is_visible(struct kobject *kobj,
> +				struct attribute *attr,
> +				int idx)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +	const struct pmc_reg_map *map = pmcdev->map;
> +	u32 reg;
> +
> +	mutex_lock(&pmcdev->lock);
> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +	mutex_unlock(&pmcdev->lock);
> +
> +	return reg & ETR3_CF9LOCK ? attr->mode & (SYSFS_PREALLOC | 0444) : attr->mode;
> +}
> +
> +static ssize_t etr3_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +	const struct pmc_reg_map *map = pmcdev->map;
> +	u32 reg;
> +
> +	if (!map->etr3_offset)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&pmcdev->lock);
> +
> +	reg = pmc_core_reg_read(pmcdev, map->etr3_offset);
> +	reg &= ETR3_CF9GR | ETR3_CF9LOCK;
> +
> +	mutex_unlock(&pmcdev->lock);
> +
> +	return sysfs_emit(buf, "0x%08x", reg);
> +}
> +
> +static ssize_t etr3_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
> +	int err;
> +	u32 reg;
> +
> +	err = kstrtouint(buf, 16, &reg);
> +	if (err)
> +		return err;
> +
> +	/* allow only CF9 writes */
> +	if (reg != ETR3_CF9GR)
> +		return -EINVAL;
> +
> +	err = set_etr3(pmcdev);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(etr3);
> +
> +static struct attribute *pmc_attrs[] = {
> +	&dev_attr_etr3.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pmc_attr_group = {
> +	.attrs = pmc_attrs,
> +	.is_visible = etr3_is_visible,
> +};
> +
> +static const struct attribute_group *pmc_dev_groups[] = {
> +	&pmc_attr_group,
> +	NULL
> +};
> +
>  static int pmc_core_dev_state_get(void *data, u64 *val)
>  {
>  	struct pmc_dev *pmcdev = data;
> @@ -1384,6 +1496,7 @@ static struct platform_driver pmc_core_driver = {
>  		.name = "intel_pmc_core",
>  		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
>  		.pm = &pmc_core_pm_ops,
> +		.dev_groups = pmc_dev_groups,
>  	},
>  	.probe = pmc_core_probe,
>  	.remove = pmc_core_remove,
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index f33cd2c34835..98ebdfe57138 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -200,6 +200,11 @@ enum ppfear_regs {
>  #define TGL_LPM_STATUS_OFFSET			0x1C3C
>  #define TGL_LPM_LIVE_STATUS_OFFSET		0x1C5C
>  
> +/* Extended Test Mode Register 3 (CNL and later) */
> +#define ETR3_OFFSET				0x1048
> +#define ETR3_CF9GR				BIT(20)
> +#define ETR3_CF9LOCK				BIT(31)
> +
>  const char *tgl_lpm_modes[] = {
>  	"S0i2.0",
>  	"S0i2.1",
> @@ -263,6 +268,7 @@ struct pmc_reg_map {
>  	const u32 lpm_residency_offset;
>  	const u32 lpm_status_offset;
>  	const u32 lpm_live_status_offset;
> +	const u32 etr3_offset;
>  };
>  
>  /**
> 

