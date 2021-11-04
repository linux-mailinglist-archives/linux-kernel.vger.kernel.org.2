Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7444592F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhKDSDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhKDSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:03:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D502C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 11:01:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x64so6595530pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yrFm/E0XsWR+7GqCkZ7gj/lB7VkzJ+8c3S+SCGFAF9s=;
        b=Ipm3F903lWt+zULFRhGDVCvXc3f6DF4Qh1dJCXpgAiayiS2AZ8BfC3RyLfoMbmGBMd
         h6X01ZAhyw4fksQFFlmLVcW3Kvq5Rxj5l78Xf+rt1//6WLzVN8FOFWGLAGf0CPNWx+Ue
         U6TC+jBycJrHqqvXBW9hbi9mR0w6nJdmO6CO7shUkWtH8QZH9TH1x1Hia4kW30ol8xW0
         10XL7R6iEDqxidAWnknKaz4wVRJq7yzNJL+WfKByaUXirpIEPNhXq5D1McZ5wSI105cm
         RaskBVMQQFdfmkzvPjbEbTSuvPxhPTk6jpVrX7UueflDWjyHU190+89RZw1MnIsRauom
         iZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrFm/E0XsWR+7GqCkZ7gj/lB7VkzJ+8c3S+SCGFAF9s=;
        b=HdQiv2yfzwVPEEDtT2JGEKkIh/0F9OebaDgi1ieCqkcIcPMHHOci53GNQlXfPfJ1EH
         3/7MPJ4WDCZwGIkU8dDFz6C9nxN0nVaRg5FC1A0PHzDBOuHnIRF3hCWlobu6fTe3Y8lk
         GHoHDXW1b/E6IdA+Lu5N2pw3mQPRHDLaBjFLHw2mxzfUHosKBEnzyjgu9KucJfYt5hxD
         b6PWDOUX2nseIUN3k5ar99Wkwt1BmuHUt4hlgbAERiNKsNW2a5vX6pvLjDssNwku9Chm
         LSaF5ibd/TDvCZyNvG8sLnEB8IDRH6Q2WEPNjymMfmhjnGmbFLh+hKnZDARJirpoWm6J
         RRLQ==
X-Gm-Message-State: AOAM531JLQvDhCP4/83TxcMHkayp6iAcRJuMgSm7B+vmwI/ayUD5mJge
        wDVrkzhsrOxODg/5ebTKZhoorqOju6j5Fg==
X-Google-Smtp-Source: ABdhPJzIUxCprdqh4Pe+YbKVm/CsUA3Uay8DNvwyeTEFcDZpvROwRqtnQJGmTpxvnHO8CCcMjzZJdA==
X-Received: by 2002:a05:6a00:24d0:b0:492:727a:8905 with SMTP id d16-20020a056a0024d000b00492727a8905mr10472683pfv.79.1636048870615;
        Thu, 04 Nov 2021 11:01:10 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e7sm4287214pgk.90.2021.11.04.11.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 11:01:09 -0700 (PDT)
Date:   Thu, 4 Nov 2021 12:01:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 05/10] Coresight: Add interface for TPDM BC subunit
Message-ID: <20211104180106.GD491267@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:38:51PM +0800, Tao Zhang wrote:
> The BC(Basic Counters) interface has RW, WO and RO fields for
> controlling BC dataset elements transmitted on ATB flush.
> The BC data set subunit supports from 1-32 counter instances
> allowing for collection of BC data sets.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpdm.c | 873 +++++++++++++++++++
>  1 file changed, 873 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index c0a01979e42f..0970c69ac8e2 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -668,6 +668,878 @@ static ssize_t gp_regs_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(gp_regs);
>  
> +static ssize_t bc_capture_mode_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)

Indentation.  I won't repeat this comment but please make sure it is fixed for
the entire patchset.

> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 drvdata->bc->capture_mode == TPDM_MODE_ATB ?
> +			 "ATB" : "APB");
> +}
> +
> +static ssize_t bc_capture_mode_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	char str[20] = "";

        char str[4];

> +	uint32_t val;
> +
> +	if (size >= 20)
> +		return -EINVAL;
> +	if (sscanf(buf, "%s", str) != 1)

        if (sscanf(buf, "%3s", str) != 1)

> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;

                return -EINVAL;

Please make sure this is fixed everywhere, except when -EINVAL is really
the right error code.

> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;

Why does the device need to be enabled for this operation?  Again no comments...

> +	}
> +
> +	if (!strcmp(str, "ATB")) {
> +		drvdata->bc->capture_mode = TPDM_MODE_ATB;
> +	} else if (!strcmp(str, "APB") &&
> +		   drvdata->bc->retrieval_mode == TPDM_MODE_APB) {
> +
> +		TPDM_UNLOCK(drvdata);
> +		val = tpdm_readl(drvdata, TPDM_BC_CR);
> +		val = val | BIT(3);
> +		tpdm_writel(drvdata, val, TPDM_BC_CR);
> +		TPDM_LOCK(drvdata);
> +
> +		drvdata->bc->capture_mode = TPDM_MODE_APB;
> +	} else {
> +		mutex_unlock(&drvdata->lock);
> +		return -EINVAL;
> +	}
> +
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_capture_mode);
> +
> +static ssize_t bc_retrieval_mode_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 drvdata->bc->retrieval_mode == TPDM_MODE_ATB ?
> +			 "ATB" : "APB");
> +}
> +
> +static ssize_t bc_retrieval_mode_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	char str[20] = "";
> +
> +	if (size >= 20)
> +		return -EINVAL;
> +	if (sscanf(buf, "%s", str) != 1)
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;

Same here, I don't know why the device needs to be enabled for this to success.
Please fix everywhere.

> +	}
> +
> +	if (!strcmp(str, "ATB")) {
> +		drvdata->bc->retrieval_mode = TPDM_MODE_ATB;
> +	} else if (!strcmp(str, "APB")) {
> +		drvdata->bc->retrieval_mode = TPDM_MODE_APB;
> +	} else {
> +		mutex_unlock(&drvdata->lock);
> +		return -EINVAL;
> +	}
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_retrieval_mode);
> +
> +static ssize_t bc_reset_counters_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	if (val) {
> +		TPDM_UNLOCK(drvdata);
> +		val = tpdm_readl(drvdata, TPDM_BC_CR);
> +		val = val | BIT(1);
> +		tpdm_writel(drvdata, val, TPDM_BC_CR);
> +		TPDM_LOCK(drvdata);
> +	}
> +
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_WO(bc_reset_counters);
> +
> +static ssize_t bc_sat_mode_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->sat_mode);
        
	return scnprintf(buf, PAGE_SIZE, "%#x\n", drvdata->bc->sat_mode);

And everywhere casting in used...


> +}
> +
> +static ssize_t bc_sat_mode_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->sat_mode = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_sat_mode);
> +
> +static ssize_t bc_enable_counters_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->enable_counters);
> +}
> +
> +static ssize_t bc_enable_counters_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf,
> +					     size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->enable_counters = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_enable_counters);
> +
> +static ssize_t bc_clear_counters_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->clear_counters);
> +}
> +
> +static ssize_t bc_clear_counters_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->clear_counters = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_clear_counters);
> +
> +static ssize_t bc_enable_irq_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->enable_irq);
> +}
> +
> +static ssize_t bc_enable_irq_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->enable_irq = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_enable_irq);
> +
> +static ssize_t bc_clear_irq_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->clear_irq);
> +}
> +
> +static ssize_t bc_clear_irq_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf,
> +				       size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->clear_irq = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_clear_irq);
> +
> +static ssize_t bc_trig_val_lo_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	for (i = 0; i < TPDM_BC_MAX_COUNTERS; i++)
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->bc->trig_val_lo[i]);

As previously stated, the sysfs interface should output single line and single
values.  I won't comment on this again, please fix everywhere.

> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +
> +static ssize_t bc_trig_val_lo_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> +	    index >= drvdata->bc_counters_avail ||
> +	    drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_NO ||
> +	    (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
> +		return -EPERM;
> 

This is hard to read and maintain.  Please break it up in multiple if()
statements.

> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->trig_val_lo[index] = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_trig_val_lo);
> +
> +static ssize_t bc_trig_val_hi_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	for (i = 0; i < TPDM_BC_MAX_COUNTERS; i++)
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->bc->trig_val_hi[i]);
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +
> +static ssize_t bc_trig_val_hi_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> +	    index >= drvdata->bc_counters_avail ||
> +	    drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_NO ||
> +	    (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->trig_val_hi[index] = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_trig_val_hi);
> +
> +static ssize_t bc_enable_ganging_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> +			 (unsigned long)drvdata->bc->enable_ganging);
> +}
> +
> +static ssize_t bc_enable_ganging_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->enable_ganging = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_enable_ganging);
> +
> +static ssize_t bc_overflow_val_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	for (i = 0; i < TPDM_BC_MAX_OVERFLOW; i++)
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  drvdata->bc->overflow_val[i]);
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +
> +static ssize_t bc_overflow_val_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index, val;
> +
> +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> +	    index >= TPDM_BC_MAX_OVERFLOW)
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->overflow_val[index] = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_overflow_val);
> +
> +static ssize_t bc_ovsr_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	val = tpdm_readl(drvdata, TPDM_BC_OVSR);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> +}
> +
> +static ssize_t bc_ovsr_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	if (val) {
> +		TPDM_UNLOCK(drvdata);
> +		tpdm_writel(drvdata, val, TPDM_BC_OVSR);
> +		TPDM_LOCK(drvdata);
> +	}
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_ovsr);
> +
> +static ssize_t bc_counter_sel_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	val = tpdm_readl(drvdata, TPDM_BC_SELR);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> +}
> +
> +static ssize_t bc_counter_sel_store(struct device *dev,
> +					 struct device_attribute *attr,
> +					 const char *buf,
> +					 size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable || val >= drvdata->bc_counters_avail) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	tpdm_writel(drvdata, val, TPDM_BC_SELR);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_counter_sel);
> +
> +static ssize_t bc_count_val_lo_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	val = tpdm_readl(drvdata, TPDM_BC_CNTR_LO);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> +}
> +
> +static ssize_t bc_count_val_lo_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val, select;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	if (val) {

        if (!val) {
                mutex_unlock(&drvdata->lock);
                return -EINVAL;               
        }

> +		TPDM_UNLOCK(drvdata);
> +		select = tpdm_readl(drvdata, TPDM_BC_SELR);
> +
> +		/* Check if selected counter is disabled */
> +		if (BMVAL(tpdm_readl(drvdata, TPDM_BC_CNTENSET), select, select)) {
> +			mutex_unlock(&drvdata->lock);
> +			return -EPERM;
> +		}
> +
> +		tpdm_writel(drvdata, val, TPDM_BC_CNTR_LO);
> +		TPDM_LOCK(drvdata);
> +	}
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_count_val_lo);
> +
> +static ssize_t bc_count_val_hi_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	val = tpdm_readl(drvdata, TPDM_BC_CNTR_HI);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> +}
> +
> +static ssize_t bc_count_val_hi_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val, select;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	if (val) {

Same

> +		TPDM_UNLOCK(drvdata);
> +		select = tpdm_readl(drvdata, TPDM_BC_SELR);
> +
> +		/* Check if selected counter is disabled */
> +		if (BMVAL(tpdm_readl(drvdata, TPDM_BC_CNTENSET), select, select)) {
> +			mutex_unlock(&drvdata->lock);
> +			return -EPERM;
> +		}
> +
> +		tpdm_writel(drvdata, val, TPDM_BC_CNTR_HI);
> +		TPDM_LOCK(drvdata);
> +	}
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_count_val_hi);
> +
> +static ssize_t bc_shadow_val_lo_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	for (i = 0; i < drvdata->bc_counters_avail; i++) {
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  tpdm_readl(drvdata, TPDM_BC_SHADOW_LO(i)));
> +	}
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RO(bc_shadow_val_lo);
> +
> +static ssize_t bc_shadow_val_hi_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	int i = 0;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	for (i = 0; i < drvdata->bc_counters_avail; i++)
> +		size += scnprintf(buf + size, PAGE_SIZE - size,
> +				  "Index: 0x%x Value: 0x%x\n", i,
> +				  tpdm_readl(drvdata, TPDM_BC_SHADOW_HI(i)));
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RO(bc_shadow_val_hi);
> +
> +static ssize_t bc_sw_inc_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	TPDM_UNLOCK(drvdata);
> +	val = tpdm_readl(drvdata, TPDM_BC_SWINC);
> +	TPDM_LOCK(drvdata);
> +	mutex_unlock(&drvdata->lock);
> +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> +}
> +
> +static ssize_t bc_sw_inc_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf,
> +				    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 16, &val))
> +		return -EINVAL;
> +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> +		return -EPERM;
> +
> +	mutex_lock(&drvdata->lock);
> +	if (!drvdata->enable) {
> +		mutex_unlock(&drvdata->lock);
> +		return -EPERM;
> +	}
> +
> +	if (val) {
> +		TPDM_UNLOCK(drvdata);
> +		tpdm_writel(drvdata, val, TPDM_BC_SWINC);
> +		TPDM_LOCK(drvdata);
> +	}
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_sw_inc);
> +
> +static ssize_t bc_msr_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned int i;
> +	ssize_t len = 0;
> +
> +	if (!drvdata->msr_support)
> +		return -EINVAL;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	for (i = 0; i < TPDM_BC_MAX_MSR; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%u 0x%x\n",
> +				 i, drvdata->bc->msr[i]);
> +
> +	return len;
> +}
> +
> +static ssize_t bc_msr_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned int num, val;
> +	int nval;
> +
> +	if (!drvdata->msr_support)
> +		return -EINVAL;
> +
> +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> +		return -EPERM;
> +
> +	nval = sscanf(buf, "%u %x", &num, &val);
> +	if (nval != 2)
> +		return -EINVAL;
> +
> +	if (num >= TPDM_BC_MAX_MSR)
> +		return -EINVAL;
> +
> +	mutex_lock(&drvdata->lock);
> +	drvdata->bc->msr[num] = val;
> +	mutex_unlock(&drvdata->lock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(bc_msr);
> +
> +static struct attribute *tpdm_bc_attrs[] = {
> +	&dev_attr_bc_capture_mode.attr,
> +	&dev_attr_bc_retrieval_mode.attr,
> +	&dev_attr_bc_reset_counters.attr,
> +	&dev_attr_bc_sat_mode.attr,
> +	&dev_attr_bc_enable_counters.attr,
> +	&dev_attr_bc_clear_counters.attr,
> +	&dev_attr_bc_enable_irq.attr,
> +	&dev_attr_bc_clear_irq.attr,
> +	&dev_attr_bc_trig_val_lo.attr,
> +	&dev_attr_bc_trig_val_hi.attr,
> +	&dev_attr_bc_enable_ganging.attr,
> +	&dev_attr_bc_overflow_val.attr,
> +	&dev_attr_bc_ovsr.attr,
> +	&dev_attr_bc_counter_sel.attr,
> +	&dev_attr_bc_count_val_lo.attr,
> +	&dev_attr_bc_count_val_hi.attr,
> +	&dev_attr_bc_shadow_val_lo.attr,
> +	&dev_attr_bc_shadow_val_hi.attr,
> +	&dev_attr_bc_sw_inc.attr,
> +	&dev_attr_bc_msr.attr,
> +	NULL,

This will result in a very crowded directory.  Please move under a "bc"
subdirectory.  And as I commented before, all sysfs entries need to be
documented under Documentation/ABI/testing.

> +};
> +
> +static struct attribute_group tpdm_bc_attr_grp = {
> +	.attrs = tpdm_bc_attrs,
> +};
> +
>  static struct attribute *tpdm_attrs[] = {
>  	&dev_attr_available_datasets.attr,
>  	&dev_attr_enable_datasets.attr,
> @@ -682,6 +1554,7 @@ static struct attribute_group tpdm_attr_grp = {
>  };
>  static const struct attribute_group *tpdm_attr_grps[] = {
>  	&tpdm_attr_grp,
> +	&tpdm_bc_attr_grp,

It is quite tedious to review all these options at the same time as the core
drivers.  I suggest to concentrate on the base functionality for now.  When that
is merged we can add configuration options such as these.

I am out of time for this patchset and as such will not review the remaining
patches - those will have to wait for another iteration.

Thanks,
Mathieu

>  	NULL,
>  };
>  
> -- 
> 2.17.1
> 
