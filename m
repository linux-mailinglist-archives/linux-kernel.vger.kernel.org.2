Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC532D812
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhCDQu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:50:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238407AbhCDQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:50:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9AAD6E;
        Thu,  4 Mar 2021 08:49:16 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0C83F7D7;
        Thu,  4 Mar 2021 08:49:13 -0800 (PST)
Subject: Re: [PATCH v4 05/10] coresight: syscfg: Add API to activate and
 enable configurations
To:     Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-6-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2ff0fd68-969f-292b-f8d3-5dace8f1a435@arm.com>
Date:   Thu, 4 Mar 2021 16:49:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210128170936.9222-6-mike.leach@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 5:09 PM, Mike Leach wrote:
> Configurations are first activated, then when any coresight device is
> enabled, the active configurations are checked and any matching
> one is enabled.
> 
> This patch provides the activation / enable API.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   .../hwtracing/coresight/coresight-config.h    |   2 +
>   .../hwtracing/coresight/coresight-syscfg.c    | 127 ++++++++++++++++++
>   .../hwtracing/coresight/coresight-syscfg.h    |  10 +-
>   include/linux/coresight.h                     |   2 +
>   4 files changed, 140 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> index 98380b496046..26396b70c826 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h
> @@ -156,6 +156,7 @@ struct cscfg_config_feat_ref {
>    * @presets:	Array of preset values.
>    * @id_ea:	Extended attribute for perf configid value
>    * @event_ea:	Extended attribute for perf event value
> + * @active_cnt: ref count for activate on this configuration.
>    */
>   struct cscfg_config_desc {
>   	const char *name;
> @@ -168,6 +169,7 @@ struct cscfg_config_desc {
>   	const u64 *presets; /* nr_presets * nr_total_params */
>   	struct dev_ext_attribute *id_ea;
>   	struct dev_ext_attribute *event_ea;
> +	atomic_t active_cnt;
>   };
>   
>   /**
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> index a070f135eca3..d79cf5b36758 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> @@ -298,6 +298,7 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
>   		return err;
>   
>   	list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
> +	atomic_set(&cfg_desc->active_cnt, 0);
>   	return 0;
>   }
>   
> @@ -477,6 +478,131 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
>   }
>   EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
>   
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> +{
> +	struct cscfg_feature_csdev *feat;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	if (list_empty(&csdev->feature_csdev_list))
> +		goto unlock_exit;
> +
> +	list_for_each_entry(feat, &csdev->feature_csdev_list, node)
> +		cscfg_reset_feat(feat);
> +
> +unlock_exit:
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> +
> +/**
> + * Mark a config descriptor as active.
> + * This will be seen when csdev devices are activated in the system.
> + *
> + * Selection by hash value - generated from the configuration name when it
> + * was loaded and added to the cs_etm/configurations file system for selection
> + * by perf.
> + *
> + * @cfg_hash: Hash value of the selected configuration name.
> + */
> +int cscfg_activate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *curr_item, *match_item = 0;

nit: s/0/NULL
	
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> +		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> +			match_item = curr_item;
> +			atomic_inc(&cscfg_mgr->data.sys_active_cnt);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +
> +	if (!match_item)
> +		return -EINVAL;
> +
> +	dev_dbg(to_device_cscfg(), "Activate config %s.\n", match_item->name);
> +
> +	/* mark the descriptors as active so enable config will use them */
> +	mutex_lock(&cscfg_csdev_mutex);
> +	atomic_inc(&match_item->active_cnt);
> +	mutex_unlock(&cscfg_csdev_mutex);

Is there a guarantee that this item is active and present in the list after
we dropped the mutex above ? We could certainly nest the mutex as long as
we follow the order everywhere to prevent such a race.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> +
> +void cscfg_deactivate_config(unsigned long cfg_hash)
> +{
> +	struct cscfg_config_desc *curr_item, *match_item = 0;
> +
> +	mutex_lock(&cscfg_mutex);
> +
> +	list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> +		if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> +			match_item = curr_item;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&cscfg_mutex);
> +	if (!match_item)
> +		return;
> +
> +	dev_dbg(to_device_cscfg(), "Deactivate config %s.\n", match_item->name);
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	atomic_dec(&match_item->active_cnt);
> +	mutex_unlock(&cscfg_csdev_mutex);
> +
> +	atomic_dec(&cscfg_mgr->data.sys_active_cnt);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> +
> +/* Find and program any active config for the supplied device.*/
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long id_hash, int preset)
> +{
> +	struct cscfg_config_csdev *cfg = NULL, *item;
> +	const struct cscfg_config_desc *desc;
> +	int err = 0;
> +
> +	/* quickly check global count */
> +	if (!atomic_read(&cscfg_mgr->data.sys_active_cnt))
> +		return 0;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	list_for_each_entry(item, &csdev->config_csdev_list, node) {
> +		desc = item->desc;
> +		if ((atomic_read(&desc->active_cnt)) &&
> +		    ((unsigned long)desc->id_ea->var == id_hash)) {
> +			cfg = item;
> +			break;
> +		}
> +	}
> +	if (cfg) {
> +		err = cscfg_csdev_enable_config(cfg, preset);
> +		if (!err)
> +			csdev->active_cfg_ctxt = (void *)cfg;
> +	}
> +	mutex_unlock(&cscfg_csdev_mutex);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> +
> +/* save and disable the active config for the device */
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> +{
> +	struct cscfg_config_csdev *cfg;
> +
> +	mutex_lock(&cscfg_csdev_mutex);
> +	cfg = (struct cscfg_config_csdev *)csdev->active_cfg_ctxt;
> +	if (cfg)
> +		cscfg_csdev_disable_config(cfg);
> +	mutex_unlock(&cscfg_csdev_mutex);
> +}
> +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> +
>   /* Initialise system configuration management device. */
>   
>   struct device *to_device_cscfg(void)
> @@ -546,6 +672,7 @@ int __init cscfg_init(void)
>   	INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
>   	INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
>   	cscfg_mgr->data.nr_csdev = 0;
> +	atomic_set(&cscfg_mgr->data.sys_active_cnt, 0);
>   
>   	dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
>   	return 0;
> diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> index ebf5e1491d86..301e26e1e98f 100644
> --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> @@ -17,13 +17,15 @@
>    * @csdev_list:		List of coresight devices registered with the configuration manager.
>    * @feat_desc_list:	List of feature descriptors to load into registered devices.

nit: Is this aligned ? (It is from Patch 1, though).

>    * @config_desc_list:	List of system configuration descriptors to load into registered devices.
> - * @nr_csdev:	Number of registered devices with the cscfg system
> + * @nr_csdev:		Number of registered devices with the cscfg system

Spurious change ?

> + * @sys_active_cnt:	Total number of active config descriptor references.
>    */
>   struct cscfg_api_data {
>   	struct list_head csdev_desc_list;
>   	struct list_head feat_desc_list;
>   	struct list_head config_desc_list;
>   	int nr_csdev;
> +	atomic_t sys_active_cnt;
>   };
>   
>   /**
> @@ -53,6 +55,12 @@ int cscfg_register_csdev(struct coresight_device *csdev,
>   			 struct cscfg_match_desc *info,
>   			 struct cscfg_csdev_feat_ops *ops);
>   void cscfg_unregister_csdev(struct coresight_device *csdev);
> +int cscfg_activate_config(unsigned long cfg_hash);
> +void cscfg_deactivate_config(unsigned long cfg_hash);
> +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> +				     unsigned long id_hash, int preset);
> +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
>   
>   /**
>    * System configuration manager device.
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d0126ed326a6..3941854e8280 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -221,6 +221,7 @@ struct coresight_sysfs_link {
>    * @has_conns_grp: Have added a "connections" group for sysfs links.
>    * @feature_csdev_list: List of complex feature programming added to the device.
>    * @config_csdev_list:  List of system configurations added to the device.
> + * @active_cfg_ctxt:    Context information for current active congfig.
>    */
>   struct coresight_device {
>   	struct coresight_platform_data *pdata;
> @@ -245,6 +246,7 @@ struct coresight_device {
>   	/* system configuration and feature lists */
>   	struct list_head feature_csdev_list;
>   	struct list_head config_csdev_list;
> +	void *active_cfg_ctxt;
>   };
>   

Suzuki

