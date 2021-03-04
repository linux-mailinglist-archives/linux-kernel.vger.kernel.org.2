Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F59432D953
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhCDSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbhCDSQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:16:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E4CC061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 10:15:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l22so8925032wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R39PAZ7G4RVGo7k05BwsFK/20JT9Co0kTXdvtJ95tjo=;
        b=drXXoS49h6sGXB2kaXQfv9mnRH8Kky5X5/s3/3sxjGWinAaC6cCzg/rp0nlCc9eoxI
         lZvy3k4koollJC/FkHRQq4MzIMH+q6CA9vmV7VsxmJoOmNRUfedbhUg5xm/x4V1vfzCV
         NriGQQgtP695jrIjoI4Yxr4ToanAufMOh8eICrS1a3Rc4C3/xaFwKOv4OifnDatzl+X5
         K4qF/0c29JVDR3U4norPx6zX5nPmOI+8m58hfsa8pwEtq583od0C/sZUOztSK56fREE7
         xINcUOi0Qh/YDFVZA7MXfkvru506hrk4ElA80q429NpEBUcKLGgOK6Su9sjLxxLj0VCJ
         3xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R39PAZ7G4RVGo7k05BwsFK/20JT9Co0kTXdvtJ95tjo=;
        b=YRyz8u6yMB/pRiTFXrM3H3RpsnfIVW3OdV+AuaHbi+znHSgoj6+AYJ7iyNaitn/yAo
         PB1BDqP/mRSndozgey5IgwPSyNgrF6DY5HSJ144i+b2cZ2fHPNlI89Sd5kh4Tsi9V+1O
         y+FfKEIe1qZ/NFE0kfm2jwCs2SWDZuQK/71RBAZEQFGe034b/F7RpzfEJMkfgp2R25A1
         H4ngOf9MX3CnxDufw0f4bTOqTVlihimJNjHSVG41/BlmjB5OnoC3Orcm6i5OjFq4ua8l
         0nhUmKDJcBeWCGBNd5MVuzizG8hNCX2pUNYt/W6yNgIdeE9yP9WuNtPu6rlbEMelKyLA
         8NUA==
X-Gm-Message-State: AOAM5320LyhPWWQbLt0JnNB7EB8bE2ieoW15NdEcH/VdYg4g+zOjb2mM
        Pxqu4I0ILXqZmfN1/Iv660oxUq/5S3OvghxyD0avJw==
X-Google-Smtp-Source: ABdhPJz68B1yIZH137AMO3DkcHV0gN97GH5lV9wJ3ZkVH3LACa6EwRqB6wzNilb3YVwQTBekwqrtd+7RXUQ+zc7I3S0=
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr5321573wme.5.1614881724661;
 Thu, 04 Mar 2021 10:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-6-mike.leach@linaro.org>
 <2ff0fd68-969f-292b-f8d3-5dace8f1a435@arm.com>
In-Reply-To: <2ff0fd68-969f-292b-f8d3-5dace8f1a435@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Mar 2021 18:15:13 +0000
Message-ID: <CAJ9a7Vj=WGPM3t2HtfrS-o=+9rntL90E=++8Gsxk1W8Aj=nggQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] coresight: syscfg: Add API to activate and
 enable configurations
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Yabin Cui <yabinc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, 4 Mar 2021 at 16:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 1/28/21 5:09 PM, Mike Leach wrote:
> > Configurations are first activated, then when any coresight device is
> > enabled, the active configurations are checked and any matching
> > one is enabled.
> >
> > This patch provides the activation / enable API.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   .../hwtracing/coresight/coresight-config.h    |   2 +
> >   .../hwtracing/coresight/coresight-syscfg.c    | 127 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-syscfg.h    |  10 +-
> >   include/linux/coresight.h                     |   2 +
> >   4 files changed, 140 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 98380b496046..26396b70c826 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -156,6 +156,7 @@ struct cscfg_config_feat_ref {
> >    * @presets:        Array of preset values.
> >    * @id_ea:  Extended attribute for perf configid value
> >    * @event_ea:       Extended attribute for perf event value
> > + * @active_cnt: ref count for activate on this configuration.
> >    */
> >   struct cscfg_config_desc {
> >       const char *name;
> > @@ -168,6 +169,7 @@ struct cscfg_config_desc {
> >       const u64 *presets; /* nr_presets * nr_total_params */
> >       struct dev_ext_attribute *id_ea;
> >       struct dev_ext_attribute *event_ea;
> > +     atomic_t active_cnt;
> >   };
> >
> >   /**
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> > index a070f135eca3..d79cf5b36758 100644
> > --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> > @@ -298,6 +298,7 @@ static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
> >               return err;
> >
> >       list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
> > +     atomic_set(&cfg_desc->active_cnt, 0);
> >       return 0;
> >   }
> >
> > @@ -477,6 +478,131 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
> >   }
> >   EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
> >
> > +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > +{
> > +     struct cscfg_feature_csdev *feat;
> > +
> > +     mutex_lock(&cscfg_csdev_mutex);
> > +     if (list_empty(&csdev->feature_csdev_list))
> > +             goto unlock_exit;
> > +
> > +     list_for_each_entry(feat, &csdev->feature_csdev_list, node)
> > +             cscfg_reset_feat(feat);
> > +
> > +unlock_exit:
> > +     mutex_unlock(&cscfg_csdev_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
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
> > +     struct cscfg_config_desc *curr_item, *match_item = 0;
>
> nit: s/0/NULL
>

OK.

> > +
> > +     mutex_lock(&cscfg_mutex);
> > +
> > +     list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> > +             if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> > +                     match_item = curr_item;
> > +                     atomic_inc(&cscfg_mgr->data.sys_active_cnt);
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&cscfg_mutex);
> > +
> > +     if (!match_item)
> > +             return -EINVAL;
> > +
> > +     dev_dbg(to_device_cscfg(), "Activate config %s.\n", match_item->name);
> > +
> > +     /* mark the descriptors as active so enable config will use them */
> > +     mutex_lock(&cscfg_csdev_mutex);
> > +     atomic_inc(&match_item->active_cnt);
> > +     mutex_unlock(&cscfg_csdev_mutex);
>
> Is there a guarantee that this item is active and present in the list after
> we dropped the mutex above ? We could certainly nest the mutex as long as
> we follow the order everywhere to prevent such a race.
>

Although removal not supported in this set, the rule is that nothing
can be removed while any configuration is active (count on
sys_active_cnt). - but a comment here could be added.
That said, given this is an atomic, not sure that the mutex is
necessary (I think previous versions did more than just update the
count), & perhaps the increment should be moved to the main
list_for_each loop.

> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> > +
> > +void cscfg_deactivate_config(unsigned long cfg_hash)
> > +{
> > +     struct cscfg_config_desc *curr_item, *match_item = 0;
> > +
> > +     mutex_lock(&cscfg_mutex);
> > +
> > +     list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> > +             if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> > +                     match_item = curr_item;
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&cscfg_mutex);
> > +     if (!match_item)
> > +             return;
> > +
> > +     dev_dbg(to_device_cscfg(), "Deactivate config %s.\n", match_item->name);
> > +
> > +     mutex_lock(&cscfg_csdev_mutex);
> > +     atomic_dec(&match_item->active_cnt);
> > +     mutex_unlock(&cscfg_csdev_mutex);
> > +
> > +     atomic_dec(&cscfg_mgr->data.sys_active_cnt);
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> > +
> > +/* Find and program any active config for the supplied device.*/
> > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > +                                  unsigned long id_hash, int preset)
> > +{
> > +     struct cscfg_config_csdev *cfg = NULL, *item;
> > +     const struct cscfg_config_desc *desc;
> > +     int err = 0;
> > +
> > +     /* quickly check global count */
> > +     if (!atomic_read(&cscfg_mgr->data.sys_active_cnt))
> > +             return 0;
> > +
> > +     mutex_lock(&cscfg_csdev_mutex);
> > +     list_for_each_entry(item, &csdev->config_csdev_list, node) {
> > +             desc = item->desc;
> > +             if ((atomic_read(&desc->active_cnt)) &&
> > +                 ((unsigned long)desc->id_ea->var == id_hash)) {
> > +                     cfg = item;
> > +                     break;
> > +             }
> > +     }
> > +     if (cfg) {
> > +             err = cscfg_csdev_enable_config(cfg, preset);
> > +             if (!err)
> > +                     csdev->active_cfg_ctxt = (void *)cfg;
> > +     }
> > +     mutex_unlock(&cscfg_csdev_mutex);
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> > +
> > +/* save and disable the active config for the device */
> > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> > +{
> > +     struct cscfg_config_csdev *cfg;
> > +
> > +     mutex_lock(&cscfg_csdev_mutex);
> > +     cfg = (struct cscfg_config_csdev *)csdev->active_cfg_ctxt;
> > +     if (cfg)
> > +             cscfg_csdev_disable_config(cfg);
> > +     mutex_unlock(&cscfg_csdev_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> > +
> >   /* Initialise system configuration management device. */
> >
> >   struct device *to_device_cscfg(void)
> > @@ -546,6 +672,7 @@ int __init cscfg_init(void)
> >       INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
> >       INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
> >       cscfg_mgr->data.nr_csdev = 0;
> > +     atomic_set(&cscfg_mgr->data.sys_active_cnt, 0);
> >
> >       dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
> >       return 0;
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> > index ebf5e1491d86..301e26e1e98f 100644
> > --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> > @@ -17,13 +17,15 @@
> >    * @csdev_list:             List of coresight devices registered with the configuration manager.
> >    * @feat_desc_list: List of feature descriptors to load into registered devices.
>
> nit: Is this aligned ? (It is from Patch 1, though).
>
> >    * @config_desc_list:       List of system configuration descriptors to load into registered devices.
> > - * @nr_csdev:        Number of registered devices with the cscfg system
> > + * @nr_csdev:                Number of registered devices with the cscfg system
>
> Spurious change ?
>

This struct disappears in the v5 respin, so the comments will too.

> > + * @sys_active_cnt:  Total number of active config descriptor references.
> >    */
> >   struct cscfg_api_data {
> >       struct list_head csdev_desc_list;
> >       struct list_head feat_desc_list;
> >       struct list_head config_desc_list;
> >       int nr_csdev;
> > +     atomic_t sys_active_cnt;
> >   };
> >
> >   /**
> > @@ -53,6 +55,12 @@ int cscfg_register_csdev(struct coresight_device *csdev,
> >                        struct cscfg_match_desc *info,
> >                        struct cscfg_csdev_feat_ops *ops);
> >   void cscfg_unregister_csdev(struct coresight_device *csdev);
> > +int cscfg_activate_config(unsigned long cfg_hash);
> > +void cscfg_deactivate_config(unsigned long cfg_hash);
> > +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > +                                  unsigned long id_hash, int preset);
> > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
> >
> >   /**
> >    * System configuration manager device.
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index d0126ed326a6..3941854e8280 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -221,6 +221,7 @@ struct coresight_sysfs_link {
> >    * @has_conns_grp: Have added a "connections" group for sysfs links.
> >    * @feature_csdev_list: List of complex feature programming added to the device.
> >    * @config_csdev_list:  List of system configurations added to the device.
> > + * @active_cfg_ctxt:    Context information for current active congfig.
> >    */
> >   struct coresight_device {
> >       struct coresight_platform_data *pdata;
> > @@ -245,6 +246,7 @@ struct coresight_device {
> >       /* system configuration and feature lists */
> >       struct list_head feature_csdev_list;
> >       struct list_head config_csdev_list;
> > +     void *active_cfg_ctxt;
> >   };
> >
>
> Suzuki
>

Thanks for the review.

Mike
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
