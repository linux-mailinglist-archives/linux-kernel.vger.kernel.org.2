Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E733258F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhBYVrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhBYVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:47:40 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:46:59 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p21so4700572pgl.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9XdyxBqMclQatVuENnBk32QXxl0v1yioF/D/2nEOFLY=;
        b=gO9UIfgFJjeY6oJkSigNM1bVS0KJty1nLZiC4/7Pis6M+/jH3zF/cAUYrwEx17qs+S
         n5gwSskSJyIM87Dlrp7lzhuHn1CZVr6ui4LFpmK20I055/LFrIDYbRR39L5IWM9/9jlC
         /9NKrLMtsef/OKKHTexwNN0m91C3/8vPtlICazWRucN9w+19Oams4gIJSjeV5nWbDkM8
         hkbU9DOyml1Eo2cEQYYZYGtbs7ewKW57hvmRLUmaSk2xPBR+Qh/muV4U9h3HwzV709X7
         84mYGSXY0Y9NhOgZDpd+Jn2gICczvg/CGhU1j7wVjLokMBotwvVqGzLs9dvuoI97roNh
         PKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XdyxBqMclQatVuENnBk32QXxl0v1yioF/D/2nEOFLY=;
        b=eQcXUIkjBGLcPQLxuSdP3A+iKfmImKTjgdAB2SeJiw0dIvr1bwIGvqntUrsIvQLMAb
         1O/nxCOd6n3sOZJgHxYYexF5r6RVhX/h+geYZl0SqwAWWGUb+qtTysAG3lJtzXTjTIzh
         hID9wgcvkf6PykhBppU/fsxhnDtOoBBUH2swiGT9UF7iHRFzdJS/0eY1L/7KrXfnglkd
         yMoFkBl1MpFpxqqfb14YI8QHyDu4Dc2WNiLFPtne5fZEjGNHSffjTYYW9N2OhoIMvTmG
         KDfaZbLWCHTojrQkKEc0YarKIfXFute4ybi+Nh0BV+GsJBKFVRmAI6ItgCS2swJ1jNS/
         98AA==
X-Gm-Message-State: AOAM532nF4HwXVtJXJPa5BTQfaUp7R6h1sd9L1uODGeUEIIw5t11Fi/L
        8fWnNxkzyz/uhb3ZQevEGFnpEg==
X-Google-Smtp-Source: ABdhPJzLPkw1cFxoWZzdUErBUKCWcBWFV421XY0KA3+hwuBC1XoNVDRfHt9gH6am2gmQDraEWmXQKQ==
X-Received: by 2002:a65:688e:: with SMTP id e14mr4806686pgt.32.1614289619393;
        Thu, 25 Feb 2021 13:46:59 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t189sm6845630pgt.39.2021.02.25.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:46:58 -0800 (PST)
Date:   Thu, 25 Feb 2021 14:46:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/10] coresight: syscfg: Add API to activate and
 enable configurations
Message-ID: <20210225214657.GB3567106@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-6-mike.leach@linaro.org>
 <20210225212050.GA3567106@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225212050.GA3567106@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > +
> > +/**
> > + * Mark a config descriptor as active.
> > + * This will be seen when csdev devices are activated in the system.
> > + *
> > + * Selection by hash value - generated from the configuration name when it
> > + * was loaded and added to the cs_etm/configurations file system for selection
> > + * by perf.
> > + *
> > + * @cfg_hash: Hash value of the selected configuration name.
> > + */
> > +int cscfg_activate_config(unsigned long cfg_hash)
> > +{
> > +	struct cscfg_config_desc *curr_item, *match_item = 0;
> > +
> > +	mutex_lock(&cscfg_mutex);
> > +
> > +	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> > +		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> > +			match_item = curr_item;
> > +			atomic_inc(&cscfg_mgr->data.sys_active_cnt);
> 
> It would be nice to have a comment that mentions why this is needed.  I had to
> go look in patch 09 to see that it prevents a feature from being changed when
> any configuration is active.  And since patch 09 is the only place where
> @sys_active_cnt is used, please move the declaration and handling of the
> variable there.
> 
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&cscfg_mutex);
> > +
> > +	if (!match_item)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(to_device_cscfg(), "Activate config %s.\n", match_item->name);
> > +
> > +	/* mark the descriptors as active so enable config will use them */
> > +	mutex_lock(&cscfg_csdev_mutex);
> > +	atomic_inc(&match_item->active_cnt);
> 
> What is ->active_cnt used for?  I see it referenced in
> cscfg_csdev_enable_active_config() but it doesn't do much other than to confirm
> the configuration has been activated by someone.  
> 
> There is also a chance that a caller would call cscfg_activate_config() once and
> call cscfg_csdev_enable_active_config() multiple time, which would really create
> problems.  I would move the incrementation of sys_active_cnt within the mutex
> hold in cscfg_csdev_enable_active_config() and get rid of ->active_cnt.  If I am
> correct we wouldn't need cscfg_activate_config() after that.
>

I looked at patch 06 and I understand why incrementing sys_active_cnt has to be
done before enabling it.  If it wasn't so someone could update the feature
between the time setup_aux() is called and the event is installed on a CPU.  As
such cscfg_activate_config() should stay but I still think ->active_cnt should
go. 
 
> > +	mutex_unlock(&cscfg_csdev_mutex);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> > +
> > +void cscfg_deactivate_config(unsigned long cfg_hash)
> 
> I'm fine with either cfg_hash or id_hash, but not both.
> 
> > +{
> > +	struct cscfg_config_desc *curr_item, *match_item = 0;
> > +
> > +	mutex_lock(&cscfg_mutex);
> > +
> > +	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> > +		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> > +			match_item = curr_item;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&cscfg_mutex);
> > +	if (!match_item)
> > +		return;
> > +
> > +	dev_dbg(to_device_cscfg(), "Deactivate config %s.\n", match_item->name);
> > +
> > +	mutex_lock(&cscfg_csdev_mutex);
> > +	atomic_dec(&match_item->active_cnt);
> > +	mutex_unlock(&cscfg_csdev_mutex);
> > +
> > +	atomic_dec(&cscfg_mgr->data.sys_active_cnt);
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> > +
> > +/* Find and program any active config for the supplied device.*/
> > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > +				     unsigned long id_hash, int preset)
> > +{
> > +	struct cscfg_config_csdev *cfg = NULL, *item;
> > +	const struct cscfg_config_desc *desc;
> > +	int err = 0;
> > +
> > +	/* quickly check global count */
> > +	if (!atomic_read(&cscfg_mgr->data.sys_active_cnt))
> > +		return 0;
> > +
> > +	mutex_lock(&cscfg_csdev_mutex);
> > +	list_for_each_entry(item, &csdev->config_csdev_list, node) {
> > +		desc = item->desc;
> > +		if ((atomic_read(&desc->active_cnt)) &&
> > +		    ((unsigned long)desc->id_ea->var == id_hash)) {
> > +			cfg = item;
> > +			break;
> > +		}
> > +	}
> > +	if (cfg) {
> > +		err = cscfg_csdev_enable_config(cfg, preset);
> > +		if (!err)
> > +			csdev->active_cfg_ctxt = (void *)cfg;
> > +	}
> > +	mutex_unlock(&cscfg_csdev_mutex);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> > +
> > +/* save and disable the active config for the device */
> > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> > +{
> > +	struct cscfg_config_csdev *cfg;
> > +
> > +	mutex_lock(&cscfg_csdev_mutex);
> > +	cfg = (struct cscfg_config_csdev *)csdev->active_cfg_ctxt;
> > +	if (cfg)
> > +		cscfg_csdev_disable_config(cfg);
> > +	mutex_unlock(&cscfg_csdev_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> > +
> >  /* Initialise system configuration management device. */
> >  
> >  struct device *to_device_cscfg(void)
> > @@ -546,6 +672,7 @@ int __init cscfg_init(void)
> >  	INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
> >  	INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
> >  	cscfg_mgr->data.nr_csdev = 0;
> > +	atomic_set(&cscfg_mgr->data.sys_active_cnt, 0);
> >  
> >  	dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
> >  	return 0;
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> > index ebf5e1491d86..301e26e1e98f 100644
> > --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> > @@ -17,13 +17,15 @@
> >   * @csdev_list:		List of coresight devices registered with the configuration manager.
> >   * @feat_desc_list:	List of feature descriptors to load into registered devices.
> >   * @config_desc_list:	List of system configuration descriptors to load into registered devices.
> > - * @nr_csdev:	Number of registered devices with the cscfg system
> > + * @nr_csdev:		Number of registered devices with the cscfg system
> > + * @sys_active_cnt:	Total number of active config descriptor references.
> >   */
> >  struct cscfg_api_data {
> >  	struct list_head csdev_desc_list;
> >  	struct list_head feat_desc_list;
> >  	struct list_head config_desc_list;
> >  	int nr_csdev;
> > +	atomic_t sys_active_cnt;
> >  };
> >  
> >  /**
> > @@ -53,6 +55,12 @@ int cscfg_register_csdev(struct coresight_device *csdev,
> >  			 struct cscfg_match_desc *info,
> >  			 struct cscfg_csdev_feat_ops *ops);
> >  void cscfg_unregister_csdev(struct coresight_device *csdev);
> > +int cscfg_activate_config(unsigned long cfg_hash);
> > +void cscfg_deactivate_config(unsigned long cfg_hash);
> > +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > +				     unsigned long id_hash, int preset);
> > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
> >  
> >  /**
> >   * System configuration manager device.
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index d0126ed326a6..3941854e8280 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -221,6 +221,7 @@ struct coresight_sysfs_link {
> >   * @has_conns_grp: Have added a "connections" group for sysfs links.
> >   * @feature_csdev_list: List of complex feature programming added to the device.
> >   * @config_csdev_list:  List of system configurations added to the device.
> > + * @active_cfg_ctxt:    Context information for current active congfig.
> >   */
> >  struct coresight_device {
> >  	struct coresight_platform_data *pdata;
> > @@ -245,6 +246,7 @@ struct coresight_device {
> >  	/* system configuration and feature lists */
> >  	struct list_head feature_csdev_list;
> >  	struct list_head config_csdev_list;
> > +	void *active_cfg_ctxt;
> >  };
> >  
> >  /*
> > -- 
> > 2.17.1
> > 
