Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814D84457DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKDRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhKDRFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:05:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11385C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:02:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id n85so1952221pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyrDUfuVkXm+XYvJWKWEhg86DR2JDBASsY+NzkY4H5M=;
        b=FyM3fY5C+tQ/SrtcxhYUoh4Yf4COR8b9eQliX++1pz8SkK90IMEieuA2EQzrzRJa0T
         uykM6vcEUoc6MCroY9fmR9lJBAWDELZ7BP1qnWzMcpwuN4Q0gtAnpb8ok+/2JFy+fs7+
         PDcKfowhz5rc6IQjGT9jolEBgUb+z3rY8MisEeJX/SM3hgsD/lhs2UrapTcSDQgOvIM+
         YSfFDhmT4ZZDHeuxNozcoUtg5E2VQea269+x+iMf1YiVbHruxKHFJtGIiJeHfF8y9Zg1
         s4qq8h9xOjiPAj18g+6ON90taHVQ4s137lCi4Q7SyZoTvJe80an/gMhaQe9tlI0l+vT1
         N1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyrDUfuVkXm+XYvJWKWEhg86DR2JDBASsY+NzkY4H5M=;
        b=P2Y11+A2R0cJOH5DUI2dxaBXeamhtAz4GmwpBWvuNcVOoAYLtnuIg7PI8bTTe4Mob5
         FxNuzFhE850corE1hPtJOpWT8lN56/6HRaeYeovxpvA50+y/riz89++xEekJHXYBXcVk
         CLundkMim+/ROpyqZ3696fhSCWqTfZu/up2GR71+O5vrsXl2vIvvJhVb+hZ6G1iC86CX
         1rxv59sigBFRfVlh3DS3sjRvqMAR0CIW8+T3sGp8xICZ0lIu2kJtiYzXsyp8rLdCgo2l
         Iwf4AncCTf0tRnuY0axHdRCdkkRlX4Dc8LL99Fhoi8uKk8Ai2xQ+dTZRHt8HAnYa3Ffw
         6etw==
X-Gm-Message-State: AOAM532xBvQPIGZVWXlnPIMgWgchTsqJJJoKTMr5vGbuCqwdEwDiRhpq
        Iyway2v+92tbTyiDJIq9XnMuLw==
X-Google-Smtp-Source: ABdhPJzm+gz3+BU+45kA+pAFzkwjDU4S1W55FonrLk4cJP2ws02a+5SqS34Q3gMI106h6N8dqsFZQg==
X-Received: by 2002:a05:6a00:2405:b0:3e1:9f65:9703 with SMTP id z5-20020a056a00240500b003e19f659703mr54051327pfh.6.1636045349432;
        Thu, 04 Nov 2021 10:02:29 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p3sm5267413pfb.205.2021.11.04.10.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:02:26 -0700 (PDT)
Date:   Thu, 4 Nov 2021 11:02:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jinlong <quic_jinlmao@quicinc.com>
Cc:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 04/10] Coresight: Enable BC and GPR for TPDM driver
Message-ID: <20211104170224.GC491267@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-5-git-send-email-quic_taozha@quicinc.com>
 <20211103194300.GA383984@p14s>
 <20211104111323.GA14135@jinlmao-gv.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104111323.GA14135@jinlmao-gv.ap.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > +
> > > +static ssize_t reset_store(struct device *dev,
> > > +					  struct device_attribute *attr,
> > > +					  const char *buf,
> > > +					  size_t size)
> > > +{
> > > +	int ret = 0;
> > > +	unsigned long val;
> > > +	struct mcmb_dataset *mcmb_temp = NULL;
> > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +
> > > +	ret = kstrtoul(buf, 10, &val);
> > 
> > The coresight subsystem normally uses the hexadecimal base.
> > 
> 
> We will address you comments.
> 
> > > +	if (ret)
> > > +		return ret;
> > 
> > Shouldn't this be "if (!ret)" ? 
> >
> 
> When ret is not 0, it need to return.

I would expect something like this:

$ echo 1 > /sys/path/to/tpdm/device/reset

and not

$ echo 0 > /sys/path/to/tpdm/device/reset

The latter is what the code does.

Thanks,
Mathieu

>  
> > > +
> > > +	mutex_lock(&drvdata->lock);
> > > +	/* Reset all datasets to ZERO */
> > > +	if (drvdata->gpr != NULL)
> > > +		memset(drvdata->gpr, 0, sizeof(struct gpr_dataset));
> > > +
> > > +	if (drvdata->bc != NULL)
> > > +		memset(drvdata->bc, 0, sizeof(struct bc_dataset));
> > > +
> > > +	if (drvdata->tc != NULL)
> > > +		memset(drvdata->tc, 0, sizeof(struct tc_dataset));
> > > +
> > > +	if (drvdata->dsb != NULL)
> > > +		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
> > > +
> > > +	if (drvdata->cmb != NULL) {
> > > +		if (drvdata->cmb->mcmb != NULL) {
> > > +			mcmb_temp = drvdata->cmb->mcmb;
> > > +			memset(drvdata->cmb->mcmb, 0,
> > > +				sizeof(struct mcmb_dataset));
> > > +			}
> > > +
> > > +		memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
> > > +		drvdata->cmb->mcmb = mcmb_temp;
> > > +	}
> > > +	/* Init the default data */
> > > +	tpdm_init_default_data(drvdata);
> > > +
> > > +	mutex_unlock(&drvdata->lock);
> > > +
> > > +	/* Disable tpdm if enabled */
> > > +	if (drvdata->enable)
> > > +		coresight_disable(drvdata->csdev);
> > 
> > Why is this done out of the lock?
> > 
> 
> When call coresight_disable, tpdm_disable will be called. There is lock in tpdm_disable.
> If add it into the lock, there will be dead lock.
> 
> > > +
> > > +	return size;
> > > +}
> > > +static DEVICE_ATTR_WO(reset);
> > > +
> > > +static ssize_t integration_test_store(struct device *dev,
> > > +					  struct device_attribute *attr,
> > > +					  const char *buf,
> > > +					  size_t size)
> > > +{
> > > +	int i, ret = 0;
> > > +	unsigned long val;
> > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +
> > > +	ret = kstrtoul(buf, 10, &val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (val != 1 && val != 2)
> > > +		return -EINVAL;
> > > +
> > > +	if (!drvdata->enable)
> > > +		return -EINVAL;
> > > +
> > > +	if (val == 1)
> > > +		val = ATBCNTRL_VAL_64;
> > > +	else
> > > +		val = ATBCNTRL_VAL_32;
> > > +	TPDM_UNLOCK(drvdata);
> > > +	tpdm_writel(drvdata, 0x1, TPDM_ITCNTRL);
> > > +
> > > +	for (i = 1; i < 5; i++)
> > > +		tpdm_writel(drvdata, val, TPDM_ITATBCNTRL);
> > > +
> > > +	tpdm_writel(drvdata, 0, TPDM_ITCNTRL);
> > > +	TPDM_LOCK(drvdata);
> > > +	return size;
> > > +}
> > > +static DEVICE_ATTR_WO(integration_test);
> > 
> > Integration test interface should be conditional to a compile time option.  Have
> > a look at what was done for CTIs.
> > 
> 
> We will check and update.
> 
> > > +
> > > +static ssize_t gp_regs_show(struct device *dev,
> > > +				 struct device_attribute *attr,
> > > +				 char *buf)
> > > +{
> > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +	ssize_t size = 0;
> > > +	int i = 0;
> > > +
> > > +	if (!test_bit(TPDM_DS_GPR, drvdata->datasets))
> > > +		return -EPERM;
> > 
> >                 return -EINVAL;
> > 
> > > +
> > > +	mutex_lock(&drvdata->lock);
> > > +	for (i = 0; i < TPDM_GPR_REGS_MAX; i++) {
> > > +		if (!test_bit(i, drvdata->gpr->gpr_dirty))
> > > +			continue;
> > > +		size += scnprintf(buf + size, PAGE_SIZE - size,
> > > +				  "Index: 0x%x Value: 0x%x\n", i,
> > > +				  drvdata->gpr->gp_regs[i]);
> > 
> > This should not be - the sysfs interface requires outputs of a single line.
> > 
> 
> We will check and update.
> 
> > > +	}
> > > +	mutex_unlock(&drvdata->lock);
> > > +	return size;
> > > +}
> > > +
> > > +static ssize_t gp_regs_store(struct device *dev,
> > > +				  struct device_attribute *attr,
> > > +				  const char *buf,
> > > +				  size_t size)
> > > +{
> > > +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +	unsigned long index, val;
> > > +
> > > +	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
> > > +		return -EINVAL;
> > > +	if (!test_bit(TPDM_DS_GPR, drvdata->datasets) ||
> > > +	    index >= TPDM_GPR_REGS_MAX)
> > > +		return -EPERM;
> > > +
> > > +	mutex_lock(&drvdata->lock);
> > > +	drvdata->gpr->gp_regs[index] = val;
> > > +	__set_bit(index, drvdata->gpr->gpr_dirty);
> > > +	mutex_unlock(&drvdata->lock);
> > > +	return size;
> > > +}
> > > +static DEVICE_ATTR_RW(gp_regs);
> > > +
> > > +static struct attribute *tpdm_attrs[] = {
> > > +	&dev_attr_available_datasets.attr,
> > > +	&dev_attr_enable_datasets.attr,
> > > +	&dev_attr_reset.attr,
> > > +	&dev_attr_integration_test.attr,
> > > +	&dev_attr_gp_regs.attr,
> > > +	NULL,
> > > +};
> > 
> > All new sysfs interface need to be documented.  See here:
> > 
> > Documentation/ABI/testing/sysfs-bus-coresight-devices-xyz
> > 
> > More comments to come...
> > 
> 
> We will add the comments. 
> 
> > Thanks,
> > Mathieu
> > 
> > > +
> > > +static struct attribute_group tpdm_attr_grp = {
> > > +	.attrs = tpdm_attrs,
> > > +};
> > > +static const struct attribute_group *tpdm_attr_grps[] = {
> > > +	&tpdm_attr_grp,
> > > +	NULL,
> > > +};
> > > +
> > >  static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
> > >  {
> > >  	if (test_bit(TPDM_DS_GPR, drvdata->datasets)) {
> > > @@ -513,6 +846,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > >  	desc.ops = &tpdm_cs_ops;
> > >  	desc.pdata = adev->dev.platform_data;
> > >  	desc.dev = &adev->dev;
> > > +	desc.groups = tpdm_attr_grps;
> > >  	drvdata->csdev = coresight_register(&desc);
> > >  	if (IS_ERR(drvdata->csdev))
> > >  		return PTR_ERR(drvdata->csdev);
> > > -- 
> > > 2.17.1
> > > 
