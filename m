Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA9446080
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhKEIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:20:42 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:21619 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhKEIUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636100282; x=1667636282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5z0lc5arPXjc9rbg0SLGR76prjn+CXbpFZhL/Mq8CIA=;
  b=jrhsxrR6rjuq9bGWe+TbUcpgkjLTP9lJiK8nUQ0IcxOhvcTXDgCE53Sm
   rvWvzPOBh+j0rgYgLyZcEhQ0+RhUQyVj/Nmhwl/3fXjjrjbCrABOwgVii
   KfybgBF2E5xpxEHUg3/qMdtnjbMv/VuG3AB7M1RI8xDc6rs9yichITWFg
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Nov 2021 01:18:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 01:18:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:18:01 -0700
Received: from jinlmao-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Fri, 5 Nov 2021 01:17:58 -0700
Date:   Fri, 5 Nov 2021 16:17:54 +0800
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
Subject: Re: [PATCH 04/10] Coresight: Enable BC and GPR for TPDM driver
Message-ID: <20211105081750.GD25738@jinlmao-gv.ap.qualcomm.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-5-git-send-email-quic_taozha@quicinc.com>
 <20211103194300.GA383984@p14s>
 <20211104111323.GA14135@jinlmao-gv.ap.qualcomm.com>
 <20211104170224.GC491267@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211104170224.GC491267@p14s>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:02:24AM -0600, Mathieu Poirier wrote:
> [...]
> 
> > > > +
> > > > +static ssize_t reset_store(struct device *dev,
> > > > +					  struct device_attribute *attr,
> > > > +					  const char *buf,
> > > > +					  size_t size)
> > > > +{
> > > > +	int ret = 0;
> > > > +	unsigned long val;
> > > > +	struct mcmb_dataset *mcmb_temp = NULL;
> > > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > +
> > > > +	ret = kstrtoul(buf, 10, &val);
> > > 
> > > The coresight subsystem normally uses the hexadecimal base.
> > > 
> > 
> > We will address you comments.
> > 
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Shouldn't this be "if (!ret)" ? 
> > >
> > 
> > When ret is not 0, it need to return.
> 
> I would expect something like this:
> 
> $ echo 1 > /sys/path/to/tpdm/device/reset
> 
> and not
> 
> $ echo 0 > /sys/path/to/tpdm/device/reset
> 
> The latter is what the code does.
> 
> Thanks,
> Mathieu
> 

Hi Mathieu,

The ret is the result of kstrtoul not the val.

Thanks
Jinlong Mao  

> >  
> > > > +
> > > > +	mutex_lock(&drvdata->lock);
> > > > +	/* Reset all datasets to ZERO */
> > > > +	if (drvdata->gpr != NULL)
> > > > +		memset(drvdata->gpr, 0, sizeof(struct gpr_dataset));
> > > > +
> > > > +	if (drvdata->bc != NULL)
> > > > +		memset(drvdata->bc, 0, sizeof(struct bc_dataset));
> > > > +
> > > > +	if (drvdata->tc != NULL)
> > > > +		memset(drvdata->tc, 0, sizeof(struct tc_dataset));
> > > > +
> > > > +	if (drvdata->dsb != NULL)
> > > > +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> > > > +
> > > > +	if (drvdata->cmb != NULL) {
> > > > +		if (drvdata->cmb->mcmb != NULL) {
> > > > +			mcmb_temp = drvdata->cmb->mcmb;
> > > > +			memset(drvdata->cmb->mcmb, 0,
> > > > +				sizeof(struct mcmb_dataset));
> > > > +			}
> > > > +
> > > > +		memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
> > > > +		drvdata->cmb->mcmb = mcmb_temp;
> > > > +	}
> > > > +	/* Init the default data */
> > > > +	tpdm_init_default_data(drvdata);
> > > > +
> > > > +	mutex_unlock(&drvdata->lock);
> > > > +
> > > > +	/* Disable tpdm if enabled */
> > > > +	if (drvdata->enable)
> > > > +		coresight_disable(drvdata->csdev);
> > > 
> > > Why is this done out of the lock?
> > > 
> > 
> > When call coresight_disable, tpdm_disable will be called. There is lock in tpdm_disable.
> > If add it into the lock, there will be dead lock.
> > 
> > > > +
> > > > +	return size;
> > > > +}
> > > > +static DEVICE_ATTR_WO(reset);
> > > > +
> > > > +static ssize_t integration_test_store(struct device *dev,
> > > > +					  struct device_attribute *attr,
> > > > +					  const char *buf,
> > > > +					  size_t size)
> > > > +{
> > > > +	int i, ret = 0;
> > > > +	unsigned long val;
> > > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > +
> > > > +	ret = kstrtoul(buf, 10, &val);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (val != 1 && val != 2)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (!drvdata->enable)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (val == 1)
> > > > +		val = ATBCNTRL_VAL_64;
> > > > +	else
> > > > +		val = ATBCNTRL_VAL_32;
> > > > +	TPDM_UNLOCK(drvdata);
> > > > +	tpdm_writel(drvdata, 0x1, TPDM_ITCNTRL);
> > > > +
> > > > +	for (i = 1; i < 5; i++)
> > > > +		tpdm_writel(drvdata, val, TPDM_ITATBCNTRL);
> > > > +
> > > > +	tpdm_writel(drvdata, 0, TPDM_ITCNTRL);
> > > > +	TPDM_LOCK(drvdata);
> > > > +	return size;
> > > > +}
> > > > +static DEVICE_ATTR_WO(integration_test);
> > > 
> > > Integration test interface should be conditional to a compile time option.  Have
> > > a look at what was done for CTIs.
> > > 
> > 
> > We will check and update.
> > 
> > > > +
> > > > +static ssize_t gp_regs_show(struct device *dev,
> > > > +				 struct device_attribute *attr,
> > > > +				 char *buf)
> > > > +{
> > > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > +	ssize_t size = 0;
> > > > +	int i = 0;
> > > > +
> > > > +	if (!test_bit(TPDM_DS_GPR, drvdata->datasets))
> > > > +		return -EPERM;
> > > 
> > >                 return -EINVAL;
> > > 
> > > > +
> > > > +	mutex_lock(&drvdata->lock);
> > > > +	for (i = 0; i < TPDM_GPR_REGS_MAX; i++) {
> > > > +		if (!test_bit(i, drvdata->gpr->gpr_dirty))
> > > > +			continue;
> > > > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > > > +				  "Index: 0x%x Value: 0x%x\n", i,
> > > > +				  drvdata->gpr->gp_regs[i]);
> > > 
> > > This should not be - the sysfs interface requires outputs of a single line.
> > > 
> > 
> > We will check and update.
> > 
> > > > +	}
> > > > +	mutex_unlock(&drvdata->lock);
> > > > +	return size;
> > > > +}
> > > > +
> > > > +static ssize_t gp_regs_store(struct device *dev,
> > > > +				  struct device_attribute *attr,
> > > > +				  const char *buf,
> > > > +				  size_t size)
> > > > +{
> > > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > > +	unsigned long index, val;
> > > > +
> > > > +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> > > > +		return -EINVAL;
> > > > +	if (!test_bit(TPDM_DS_GPR, drvdata->datasets) ||
> > > > +	    index >= TPDM_GPR_REGS_MAX)
> > > > +		return -EPERM;
> > > > +
> > > > +	mutex_lock(&drvdata->lock);
> > > > +	drvdata->gpr->gp_regs[index] = val;
> > > > +	__set_bit(index, drvdata->gpr->gpr_dirty);
> > > > +	mutex_unlock(&drvdata->lock);
> > > > +	return size;
> > > > +}
> > > > +static DEVICE_ATTR_RW(gp_regs);
> > > > +
> > > > +static struct attribute *tpdm_attrs[] = {
> > > > +	&dev_attr_available_datasets.attr,
> > > > +	&dev_attr_enable_datasets.attr,
> > > > +	&dev_attr_reset.attr,
> > > > +	&dev_attr_integration_test.attr,
> > > > +	&dev_attr_gp_regs.attr,
> > > > +	NULL,
> > > > +};
> > > 
> > > All new sysfs interface need to be documented.  See here:
> > > 
> > > Documentation/ABI/testing/sysfs-bus-coresight-devices-xyz
> > > 
> > > More comments to come...
> > > 
> > 
> > We will add the comments. 
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > +
> > > > +static struct attribute_group tpdm_attr_grp = {
> > > > +	.attrs = tpdm_attrs,
> > > > +};
> > > > +static const struct attribute_group *tpdm_attr_grps[] = {
> > > > +	&tpdm_attr_grp,
> > > > +	NULL,
> > > > +};
> > > > +
> > > >  static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
> > > >  {
> > > >  	if (test_bit(TPDM_DS_GPR, drvdata->datasets)) {
> > > > @@ -513,6 +846,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > > >  	desc.ops = &tpdm_cs_ops;
> > > >  	desc.pdata = adev->dev.platform_data;
> > > >  	desc.dev = &adev->dev;
> > > > +	desc.groups = tpdm_attr_grps;
> > > >  	drvdata->csdev = coresight_register(&desc);
> > > >  	if (IS_ERR(drvdata->csdev))
> > > >  		return PTR_ERR(drvdata->csdev);
> > > > -- 
> > > > 2.17.1
> > > > 
