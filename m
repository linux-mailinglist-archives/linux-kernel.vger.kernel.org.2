Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C05132FFAC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 09:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCGIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 03:39:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:26640 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhCGIj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:39:26 -0500
IronPort-SDR: zk6EYJHZOedSszN0wEqK7K7E2evhzfj7yGqpOAI9oZQkO7tRjepnNl2ZELIsTo3+2s6wy2LdKm
 UBQzTE+Zhy0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="207629168"
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="207629168"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 00:39:23 -0800
IronPort-SDR: M+e00K1rWQjSQqckLAaK0Mg7SbqPOvmw8j/6S2L1LXSv2HXm2R9M9tmv7r8hFbKrwEJXPBDuRv
 Bw7KDHupUSEg==
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="408933151"
Received: from sneftin-mobl.ger.corp.intel.com (HELO [10.185.168.83]) ([10.185.168.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 00:39:20 -0800
Subject: Re: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake
 platforms
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, hdegoede@redhat.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        "Neftin, Sasha" <sasha.neftin@intel.com>
References: <20210305190608.1834164-1-david.e.box@linux.intel.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <113b08b2-ead1-7f4c-1b09-4f3572d6134f@intel.com>
Date:   Sun, 7 Mar 2021 10:39:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305190608.1834164-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/2021 21:06, David E. Box wrote:
> Due to a HW limitation, the Latency Tolerance Reporting (LTR) value
> programmed in the Tiger Lake GBE controller is not large enough to allow
> the platform to enter Package C10, which in turn prevents the platform from
> achieving its low power target during suspend-to-idle.  Ignore the GBE LTR
> value on Tiger Lake. LTR ignore functionality is currently performed solely
> by a debugfs write call. Split out the LTR code into its own function that
> can be called by both the debugfs writer and by this work around.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Sasha Neftin <sasha.neftin@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org
> ---
>   drivers/platform/x86/intel_pmc_core.c | 55 ++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ee2f757515b0..ab31eb646a1a 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -863,34 +863,45 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>   }
>   DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>   
> -static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> -					 const char __user *userbuf,
> -					 size_t count, loff_t *ppos)
> +static int pmc_core_write_ltr_ignore(u32 value)
>   {
>   	struct pmc_dev *pmcdev = &pmc;
>   	const struct pmc_reg_map *map = pmcdev->map;
> -	u32 val, buf_size, fd;
> -	int err;
> -
> -	buf_size = count < 64 ? count : 64;
> -
> -	err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> -	if (err)
> -		return err;
> +	u32 fd;
> +	int err = 0;
>   
>   	mutex_lock(&pmcdev->lock);
>   
> -	if (val > map->ltr_ignore_max) {
> +	if (fls(value) > map->ltr_ignore_max) {
>   		err = -EINVAL;
>   		goto out_unlock;
>   	}
>   
>   	fd = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
> -	fd |= (1U << val);
> +	fd |= value;
>   	pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, fd);
>   
>   out_unlock:
>   	mutex_unlock(&pmcdev->lock);
> +
> +	return err;
> +}
> +
> +static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> +					 const char __user *userbuf,
> +					 size_t count, loff_t *ppos)
> +{
> +	u32 buf_size, val;
> +	int err;
> +
> +	buf_size = count < 64 ? count : 64;
> +
> +	err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> +	if (err)
> +		return err;
> +
> +	err = pmc_core_write_ltr_ignore(1U << val);
> +
>   	return err == 0 ? count : err;
>   }
>   
> @@ -1189,6 +1200,15 @@ static int quirk_xtal_ignore(const struct dmi_system_id *id)
>   	return 0;
>   }
>   
> +static int quirk_ltr_ignore(u32 val)
> +{
> +	int err;
> +
> +	err = pmc_core_write_ltr_ignore(val);
> +
> +	return err;
> +}
> +
>   static const struct dmi_system_id pmc_core_dmi_table[]  = {
>   	{
>   	.callback = quirk_xtal_ignore,
> @@ -1244,6 +1264,15 @@ static int pmc_core_probe(struct platform_device *pdev)
>   	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
>   	dmi_check_system(pmc_core_dmi_table);
>   
> +	/*
> +	 * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
> +	 * a cable is attached. Tell the PMC to ignore it.
> +	 */
> +	if (pmcdev->map == &tgl_reg_map) {
I would suggest: if (pmcdev->map >= &tgl_reg_map)
> +		dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
> +		quirk_ltr_ignore(1U << 3);
> +	}
> +
>   	pmc_core_dbgfs_register(pmcdev);
>   
>   	device_initialized = true;
> 

