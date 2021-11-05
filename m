Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06644460A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhKEI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:29:20 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6344 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232356AbhKEI3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636100799; x=1667636799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MSJi5EmH8yT7nrA2XzuFMzRCq+jzelAiSTwnrRCalns=;
  b=iBEtFyBNM3yrD8gHy+hKsYH1ABnhNKgIeR5UnrH+H1Nmvh8T0gJ4fvgG
   8dVQq8m+377vMXGfExmJYyzlhM8q48RDal0FMzOtM6GgcpTlikpDlTkPu
   6g0UkoCWrCnR9aI43yp3gTAMzoQcwqfV37gxtN4usnzD16D1GWpfq4Cbk
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Nov 2021 01:26:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:26:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:26:39 -0700
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:26:35 -0700
Date:   Fri, 5 Nov 2021 16:26:30 +0800
From:   Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 05/10] Coresight: Add interface for TPDM BC subunit
Message-ID: <20211105082625.GE25738@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
 <20211104180106.GD491267@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211104180106.GD491267@p14s>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:01:06PM -0600, Mathieu Poirier wrote:
> On Thu, Oct 21, 2021 at 03:38:51PM +0800, Tao Zhang wrote:
> > The BC(Basic Counters) interface has RW, WO and RO fields for
> > controlling BC dataset elements transmitted on ATB flush.
> > The BC data set subunit supports from 1-32 counter instances
> > allowing for collection of BC data sets.
> > 
> > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-tpdm.c | 873 +++++++++++++++++++
> >  1 file changed, 873 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> > index c0a01979e42f..0970c69ac8e2 100644
> > --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> > +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> > @@ -668,6 +668,878 @@ static ssize_t gp_regs_store(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RW(gp_regs);
> >  
> > +static ssize_t bc_capture_mode_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> 
> Indentation.  I won't repeat this comment but please make sure it is fixed for
> the entire patchset.
>

We will fix it for entire patchset.
 
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +			 drvdata->bc->capture_mode == TPDM_MODE_ATB ?
> > +			 "ATB" : "APB");
> > +}
> > +
> > +static ssize_t bc_capture_mode_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf,
> > +					  size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	char str[20] = "";
> 
>         char str[4];
> 
> > +	uint32_t val;
> > +
> > +	if (size >= 20)
> > +		return -EINVAL;
> > +	if (sscanf(buf, "%s", str) != 1)
> 
>         if (sscanf(buf, "%3s", str) != 1)
> 
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> 
>                 return -EINVAL;
> 
> Please make sure this is fixed everywhere, except when -EINVAL is really
> the right error code.
> 

We will check and update.

> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> 
> Why does the device need to be enabled for this operation?  Again no comments...
> 

We will add comments for this.

> > +	}
> > +
> > +	if (!strcmp(str, "ATB")) {
> > +		drvdata->bc->capture_mode = TPDM_MODE_ATB;
> > +	} else if (!strcmp(str, "APB") &&
> > +		   drvdata->bc->retrieval_mode == TPDM_MODE_APB) {
> > +
> > +		TPDM_UNLOCK(drvdata);
> > +		val = tpdm_readl(drvdata, TPDM_BC_CR);
> > +		val = val | BIT(3);
> > +		tpdm_writel(drvdata, val, TPDM_BC_CR);
> > +		TPDM_LOCK(drvdata);
> > +
> > +		drvdata->bc->capture_mode = TPDM_MODE_APB;
> > +	} else {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_capture_mode);
> > +
> > +static ssize_t bc_retrieval_mode_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +			 drvdata->bc->retrieval_mode == TPDM_MODE_ATB ?
> > +			 "ATB" : "APB");
> > +}
> > +
> > +static ssize_t bc_retrieval_mode_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf,
> > +					    size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	char str[20] = "";
> > +
> > +	if (size >= 20)
> > +		return -EINVAL;
> > +	if (sscanf(buf, "%s", str) != 1)
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> 
> Same here, I don't know why the device needs to be enabled for this to success.
> Please fix everywhere.
> 
> > +	}
> > +
> > +	if (!strcmp(str, "ATB")) {
> > +		drvdata->bc->retrieval_mode = TPDM_MODE_ATB;
> > +	} else if (!strcmp(str, "APB")) {
> > +		drvdata->bc->retrieval_mode = TPDM_MODE_APB;
> > +	} else {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EINVAL;
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_retrieval_mode);
> > +
> > +static ssize_t bc_reset_counters_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf,
> > +					    size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (val) {
> > +		TPDM_UNLOCK(drvdata);
> > +		val = tpdm_readl(drvdata, TPDM_BC_CR);
> > +		val = val | BIT(1);
> > +		tpdm_writel(drvdata, val, TPDM_BC_CR);
> > +		TPDM_LOCK(drvdata);
> > +	}
> > +
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_WO(bc_reset_counters);
> > +
> > +static ssize_t bc_sat_mode_show(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->sat_mode);
>         
> 	return scnprintf(buf, PAGE_SIZE, "%#x\n", drvdata->bc->sat_mode);
> 
> And everywhere casting in used...
> 
> 

We will upadte it.

> > +}
> > +
> > +static ssize_t bc_sat_mode_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf,
> > +				      size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->sat_mode = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_sat_mode);
> > +
> > +static ssize_t bc_enable_counters_show(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->enable_counters);
> > +}
> > +
> > +static ssize_t bc_enable_counters_store(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     const char *buf,
> > +					     size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->enable_counters = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_enable_counters);
> > +
> > +static ssize_t bc_clear_counters_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->clear_counters);
> > +}
> > +
> > +static ssize_t bc_clear_counters_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf,
> > +					    size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->clear_counters = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_clear_counters);
> > +
> > +static ssize_t bc_enable_irq_show(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->enable_irq);
> > +}
> > +
> > +static ssize_t bc_enable_irq_store(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf,
> > +					size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->enable_irq = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_enable_irq);
> > +
> > +static ssize_t bc_clear_irq_show(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->clear_irq);
> > +}
> > +
> > +static ssize_t bc_clear_irq_store(struct device *dev,
> > +				       struct device_attribute *attr,
> > +				       const char *buf,
> > +				       size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->clear_irq = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_clear_irq);
> > +
> > +static ssize_t bc_trig_val_lo_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +	int i = 0;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	for (i = 0; i < TPDM_BC_MAX_COUNTERS; i++)
> > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > +				  "Index: 0x%x Value: 0x%x\n", i,
> > +				  drvdata->bc->trig_val_lo[i]);
> 
> As previously stated, the sysfs interface should output single line and single
> values.  I won't comment on this again, please fix everywhere.
> 

We will fix it.

> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +
> > +static ssize_t bc_trig_val_lo_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf,
> > +					 size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long index, val;
> > +
> > +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> > +	    index >= drvdata->bc_counters_avail ||
> > +	    drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_NO ||
> > +	    (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
> > +		return -EPERM;
> > 
> 
> This is hard to read and maintain.  Please break it up in multiple if()
> statements.
> 

We will address your comments.

> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->trig_val_lo[index] = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_trig_val_lo);
> > +
> > +static ssize_t bc_trig_val_hi_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +	int i = 0;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	for (i = 0; i < TPDM_BC_MAX_COUNTERS; i++)
> > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > +				  "Index: 0x%x Value: 0x%x\n", i,
> > +				  drvdata->bc->trig_val_hi[i]);
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +
> > +static ssize_t bc_trig_val_hi_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf,
> > +					 size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long index, val;
> > +
> > +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> > +	    index >= drvdata->bc_counters_avail ||
> > +	    drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_NO ||
> > +	    (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->trig_val_hi[index] = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_trig_val_hi);
> > +
> > +static ssize_t bc_enable_ganging_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n",
> > +			 (unsigned long)drvdata->bc->enable_ganging);
> > +}
> > +
> > +static ssize_t bc_enable_ganging_store(struct device *dev,
> > +					    struct device_attribute *attr,
> > +					    const char *buf,
> > +					    size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->enable_ganging = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_enable_ganging);
> > +
> > +static ssize_t bc_overflow_val_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +	int i = 0;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	for (i = 0; i < TPDM_BC_MAX_OVERFLOW; i++)
> > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > +				  "Index: 0x%x Value: 0x%x\n", i,
> > +				  drvdata->bc->overflow_val[i]);
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +
> > +static ssize_t bc_overflow_val_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf,
> > +					  size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long index, val;
> > +
> > +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets) ||
> > +	    index >= TPDM_BC_MAX_OVERFLOW)
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->overflow_val[index] = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_overflow_val);
> > +
> > +static ssize_t bc_ovsr_show(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	val = tpdm_readl(drvdata, TPDM_BC_OVSR);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> > +}
> > +
> > +static ssize_t bc_ovsr_store(struct device *dev,
> > +				  struct device_attribute *attr,
> > +				  const char *buf,
> > +				  size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (val) {
> > +		TPDM_UNLOCK(drvdata);
> > +		tpdm_writel(drvdata, val, TPDM_BC_OVSR);
> > +		TPDM_LOCK(drvdata);
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_ovsr);
> > +
> > +static ssize_t bc_counter_sel_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	val = tpdm_readl(drvdata, TPDM_BC_SELR);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> > +}
> > +
> > +static ssize_t bc_counter_sel_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf,
> > +					 size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable || val >= drvdata->bc_counters_avail) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	tpdm_writel(drvdata, val, TPDM_BC_SELR);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_counter_sel);
> > +
> > +static ssize_t bc_count_val_lo_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	val = tpdm_readl(drvdata, TPDM_BC_CNTR_LO);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> > +}
> > +
> > +static ssize_t bc_count_val_lo_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf,
> > +					  size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val, select;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (val) {
> 
>         if (!val) {
>                 mutex_unlock(&drvdata->lock);
>                 return -EINVAL;               
>         }
> 

We will update it.

> > +		TPDM_UNLOCK(drvdata);
> > +		select = tpdm_readl(drvdata, TPDM_BC_SELR);
> > +
> > +		/* Check if selected counter is disabled */
> > +		if (BMVAL(tpdm_readl(drvdata, TPDM_BC_CNTENSET), select, select)) {
> > +			mutex_unlock(&drvdata->lock);
> > +			return -EPERM;
> > +		}
> > +
> > +		tpdm_writel(drvdata, val, TPDM_BC_CNTR_LO);
> > +		TPDM_LOCK(drvdata);
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_count_val_lo);
> > +
> > +static ssize_t bc_count_val_hi_show(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	val = tpdm_readl(drvdata, TPDM_BC_CNTR_HI);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> > +}
> > +
> > +static ssize_t bc_count_val_hi_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf,
> > +					  size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val, select;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (val) {
> 
> Same
> 

We will update it.

> > +		TPDM_UNLOCK(drvdata);
> > +		select = tpdm_readl(drvdata, TPDM_BC_SELR);
> > +
> > +		/* Check if selected counter is disabled */
> > +		if (BMVAL(tpdm_readl(drvdata, TPDM_BC_CNTENSET), select, select)) {
> > +			mutex_unlock(&drvdata->lock);
> > +			return -EPERM;
> > +		}
> > +
> > +		tpdm_writel(drvdata, val, TPDM_BC_CNTR_HI);
> > +		TPDM_LOCK(drvdata);
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_count_val_hi);
> > +
> > +static ssize_t bc_shadow_val_lo_show(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +	int i = 0;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	for (i = 0; i < drvdata->bc_counters_avail; i++) {
> > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > +				  "Index: 0x%x Value: 0x%x\n", i,
> > +				  tpdm_readl(drvdata, TPDM_BC_SHADOW_LO(i)));
> > +	}
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RO(bc_shadow_val_lo);
> > +
> > +static ssize_t bc_shadow_val_hi_show(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	ssize_t size = 0;
> > +	int i = 0;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	for (i = 0; i < drvdata->bc_counters_avail; i++)
> > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > +				  "Index: 0x%x Value: 0x%x\n", i,
> > +				  tpdm_readl(drvdata, TPDM_BC_SHADOW_HI(i)));
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RO(bc_shadow_val_hi);
> > +
> > +static ssize_t bc_sw_inc_show(struct device *dev,
> > +				   struct device_attribute *attr,
> > +				   char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	TPDM_UNLOCK(drvdata);
> > +	val = tpdm_readl(drvdata, TPDM_BC_SWINC);
> > +	TPDM_LOCK(drvdata);
> > +	mutex_unlock(&drvdata->lock);
> > +	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
> > +}
> > +
> > +static ssize_t bc_sw_inc_store(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    const char *buf,
> > +				    size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned long val;
> > +
> > +	if (kstrtoul(buf, 16, &val))
> > +		return -EINVAL;
> > +	if (!test_bit(TPDM_DS_BC, drvdata->enable_ds))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	if (!drvdata->enable) {
> > +		mutex_unlock(&drvdata->lock);
> > +		return -EPERM;
> > +	}
> > +
> > +	if (val) {
> > +		TPDM_UNLOCK(drvdata);
> > +		tpdm_writel(drvdata, val, TPDM_BC_SWINC);
> > +		TPDM_LOCK(drvdata);
> > +	}
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_sw_inc);
> > +
> > +static ssize_t bc_msr_show(struct device *dev,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned int i;
> > +	ssize_t len = 0;
> > +
> > +	if (!drvdata->msr_support)
> > +		return -EINVAL;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	for (i = 0; i < TPDM_BC_MAX_MSR; i++)
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%u 0x%x\n",
> > +				 i, drvdata->bc->msr[i]);
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t bc_msr_store(struct device *dev,
> > +				 struct device_attribute *attr,
> > +				 const char *buf,
> > +				 size_t size)
> > +{
> > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > +	unsigned int num, val;
> > +	int nval;
> > +
> > +	if (!drvdata->msr_support)
> > +		return -EINVAL;
> > +
> > +	if (!test_bit(TPDM_DS_BC, drvdata->datasets))
> > +		return -EPERM;
> > +
> > +	nval = sscanf(buf, "%u %x", &num, &val);
> > +	if (nval != 2)
> > +		return -EINVAL;
> > +
> > +	if (num >= TPDM_BC_MAX_MSR)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&drvdata->lock);
> > +	drvdata->bc->msr[num] = val;
> > +	mutex_unlock(&drvdata->lock);
> > +	return size;
> > +}
> > +static DEVICE_ATTR_RW(bc_msr);
> > +
> > +static struct attribute *tpdm_bc_attrs[] = {
> > +	&dev_attr_bc_capture_mode.attr,
> > +	&dev_attr_bc_retrieval_mode.attr,
> > +	&dev_attr_bc_reset_counters.attr,
> > +	&dev_attr_bc_sat_mode.attr,
> > +	&dev_attr_bc_enable_counters.attr,
> > +	&dev_attr_bc_clear_counters.attr,
> > +	&dev_attr_bc_enable_irq.attr,
> > +	&dev_attr_bc_clear_irq.attr,
> > +	&dev_attr_bc_trig_val_lo.attr,
> > +	&dev_attr_bc_trig_val_hi.attr,
> > +	&dev_attr_bc_enable_ganging.attr,
> > +	&dev_attr_bc_overflow_val.attr,
> > +	&dev_attr_bc_ovsr.attr,
> > +	&dev_attr_bc_counter_sel.attr,
> > +	&dev_attr_bc_count_val_lo.attr,
> > +	&dev_attr_bc_count_val_hi.attr,
> > +	&dev_attr_bc_shadow_val_lo.attr,
> > +	&dev_attr_bc_shadow_val_hi.attr,
> > +	&dev_attr_bc_sw_inc.attr,
> > +	&dev_attr_bc_msr.attr,
> > +	NULL,
> 
> This will result in a very crowded directory.  Please move under a "bc"
> subdirectory.  And as I commented before, all sysfs entries need to be
> documented under Documentation/ABI/testing.
> 

We will check and update.

> > +};
> > +
> > +static struct attribute_group tpdm_bc_attr_grp = {
> > +	.attrs = tpdm_bc_attrs,
> > +};
> > +
> >  static struct attribute *tpdm_attrs[] = {
> >  	&dev_attr_available_datasets.attr,
> >  	&dev_attr_enable_datasets.attr,
> > @@ -682,6 +1554,7 @@ static struct attribute_group tpdm_attr_grp = {
> >  };
> >  static const struct attribute_group *tpdm_attr_grps[] = {
> >  	&tpdm_attr_grp,
> > +	&tpdm_bc_attr_grp,
> 
> It is quite tedious to review all these options at the same time as the core
> drivers.  I suggest to concentrate on the base functionality for now.  When that
> is merged we can add configuration options such as these.
> 
> I am out of time for this patchset and as such will not review the remaining
> patches - those will have to wait for another iteration.
> 
> Thanks,
> Mathieu


Thank your for all the comments.
We will update the patches.

Thanks
Jinlong Mao 

> 
> >  	NULL,
> >  };
> >  
> > -- 
> > 2.17.1
> > 
