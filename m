Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCA835549C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbhDFNMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232492AbhDFNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617714713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zdu7Z4OAVqUaEnvzGzloKUYCcB96TWUsjOVZ7fqb7qI=;
        b=JMeOUMP6BDv17xc/nTf4oGu7A+iLs9ZbCCAy14JHTTy9jN9s9wmjF5JmBLwt+DBN5DssPq
        hgVgBpiCDpFmD01XssQZr1psNJ2yHuS6ow7GjNlgLjXqte2MEe9tgp84/UyPRrbTG0Du1g
        LD7p635AYscpT73C7YTKHqqo2u81Q14=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-ATOoy4zHMDaSGouF99MUXg-1; Tue, 06 Apr 2021 09:11:52 -0400
X-MC-Unique: ATOoy4zHMDaSGouF99MUXg-1
Received: by mail-ed1-f70.google.com with SMTP id q12so10382838edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zdu7Z4OAVqUaEnvzGzloKUYCcB96TWUsjOVZ7fqb7qI=;
        b=MUkc7ma5sRHhAS11QIx72QsndMxqVcaaBrK54vdelLMOkvj7kVeHBJMqVmmllvI5Al
         ck4nDzszhkQVc4nLf0vJ/JX8eUFy7VswcfprIEmKBGoKDvABwlXOZHJB5ApmvAHAAQZf
         o7ZlkJpDBFZ/mKfu19M4XhdsncJOA31ijl47zyi2EL+zKyHPzt/CXRaAUz6Qj7cKpw9G
         50UX9X90E2i2TAo3RCtHO/dZmWJNtOnjYoRGy3rj0Pk/eCnWETRI5vkqsnLxPZ0AmvLR
         Diovn6azlWDFsfLi1+C/Gmp3a19U4GPm8nWV64M/YBF1UxBP8NG+d3h2xO3gPhHLgeRO
         Pdww==
X-Gm-Message-State: AOAM530N2rD3WM8liP6VVAOHoXFcdkjQH/zoCK4eCRcg3DR4XiAvmlkV
        D6hsM609xtojG7TmrtUpuC7j+HAHg42Zhyc4Tu9lUbxHE8oYY+zqgXAdkpa0YCrFE1sVNLNUiU5
        PtfS/GJ5eMMxhD+SZXfyId+jE
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr33339189ejc.45.1617714710795;
        Tue, 06 Apr 2021 06:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/h0mKZVO7oYncVW57PsitLtCsYd75f0lMC8dK2GMYZjh2IcqD2MgTZiPUlc9W8gpbm/JI8A==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr33339174ejc.45.1617714710608;
        Tue, 06 Apr 2021 06:11:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id rk1sm6760433ejb.88.2021.04.06.06.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:11:50 -0700 (PDT)
Subject: Re: [PATCH v4] platform/x86: intel_pmc_core: export platform
 global_reset via sysfs.
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210402152113.1191796-1-tomas.winkler@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d5021cc2-46c7-7c78-73b1-af50524e1db2@redhat.com>
Date:   Tue, 6 Apr 2021 15:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210402152113.1191796-1-tomas.winkler@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/2/21 5:21 PM, Tomas Winkler wrote:
> From: Tamar Mashiah <tamar.mashiah@intel.com>
> 
> During PCH (platform/board) manufacturing process a global reset
> has to be induced in order for configuration changes take the effect
> upon following platform reset.
> This setting was commonly done by accessing PMC registers via /dev/mem
> but due to security concern /dev/mem access is much restricted, hence
> the reason for exposing this setting via dedicated sysfs interface.
> To prevent post manufacturing abuse the register is protected
> by hardware locking.

The purpose of this reset functionality is not entirely clear to me.

Is this only used during production of a board? Or is this also something
which a user/reseller may use as part of a factory-reset procedure?

If this is only used once during production, then I'm not sure if
introducing a sysfs file for this is desirable.

Can you please provide a new version where the purpsoe of the newly
introduced sysfs file is made more clear, both in the commit-msg
as well as in the:

Documentation/ABI/testing/sysfs-platform-intel-pmc

File ?

Regards,

Hans



> 
> The register in MMIO space is defined for Cannon Lake and newer PCHs.
> 
> Cc: David E Box <david.e.box@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> 2:
> 1. Add locking for reading the ET3 register  (Andy)
> 2. Fix few style issues (Andy)
> V3:
> 1. Resend
> v4:
> 1. Fix return statement (Andy) 
> 2. Specify manufacturing process (Enrico)
> 
>  .../ABI/testing/sysfs-platform-intel-pmc      | 11 +++
>  MAINTAINERS                                   |  1 +
>  drivers/platform/x86/intel_pmc_core.c         | 97 +++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h         |  6 ++
>  4 files changed, 115 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-pmc
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> new file mode 100644
> index 000000000000..7ce00e77fbcd
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> @@ -0,0 +1,11 @@
> +What:		/sys/devices/platform/<platform>/global_reset
> +Date:		Apr 2021
> +KernelVersion:	5.13
> +Contact:	"Tomas Winkler" <tomas.winkler@intel.com>
> +Description:
> +		Display global reset setting bits for PMC.
> +			* bit 31 - global reset is locked
> +			* bit 20 - global reset is set
> +		Writing bit 20 value to the global_reset will induce
> +		a platform global reset upon consequent platform reset.
> +		in case the register is not locked.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04f68e0cda64..618676eba8c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9166,6 +9166,7 @@ M:	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>  M:	David E Box <david.e.box@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>  F:	drivers/platform/x86/intel_pmc_core*
>  
>  INTEL PMIC GPIO DRIVERS
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ee2f757515b0..8afc198550a4 100644
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
> @@ -603,6 +606,99 @@ static inline u64 pmc_core_adjust_slp_s0_step(struct pmc_dev *pmcdev, u32 value)
>  	return (u64)value * pmcdev->map->slp_s0_res_counter_step;
>  }
>  
> +static int set_global_reset(struct pmc_dev *pmcdev)
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
> +
> +static ssize_t global_reset_show(struct device *dev,
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
> +static ssize_t global_reset_store(struct device *dev,
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
> +	err = set_global_reset(pmcdev);
> +	if (err)
> +		return err;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(global_reset);
> +
> +static struct attribute *pmc_attrs[] = {
> +	&dev_attr_global_reset.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pmc_attr_group = {
> +	.attrs = pmc_attrs,
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
> @@ -1364,6 +1460,7 @@ static struct platform_driver pmc_core_driver = {
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

