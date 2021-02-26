Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795E032686E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBZURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhBZULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:11:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB44C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:08:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i9so8010208wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA79inqCbrjz8sKzpoyROoDbHQ92sBRaWEKpVIll+MM=;
        b=NGyOewOZgFKMTMKbAAwyEg5kJW6UqI3AiQPcAHJ9NEc6zh2Xu12o8DabHNOKbT7Nh+
         S7xE6F8xgae7V96FiFCnqJb8PuJdtT56rfzHgGqA5dwDlkVMjSd97b550KFEanMIueor
         xeg0wvjj3ZdjFJc6qGAC3VUbIww99+GFdQcv0w2qhkwgDjSvtQ0R4TIZeVBCGyuOJ3a8
         uHwpexMmXE981yV+CptzTdNDxFi4LTr+0QqtpL5owtBEIQ3ucTePCY5QbF03MHnvlBHb
         9MlMv7k7gt+1LANBSg4uqnnDhZ6irwg8MunFLpqDBm4G1eRxSunMegqMjX8uHd9zL2YH
         wqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA79inqCbrjz8sKzpoyROoDbHQ92sBRaWEKpVIll+MM=;
        b=e2idSMmKD3ixyLwUN646shNbRihHtSx6GxzGF6wQw7/L07sOCZfPyi+7qAbxm/xl3N
         sv7YV8g2DO5Yexs4WOgn6geZnyyiIK2T6O82OfotO5htSCja2eLUTQPi2tE/C7KU8SAp
         j3P4bXWv7NIgTDoy5dvLM/6u6IyYMha8iWKA8XxXPlh7ZR6Wb2xw/9imkc/+L0NSDJBr
         co+s6i1u1VidN9F5EETN4xPNJBCvkIfE5Xn0jnkot7Ajw8/GoL/REesmyR48KDYmk7pb
         vjkvUYjivRP2d8YQ8VrmH9ruRFw/hACdl1XVW7GC67puBGupP53ec+Ge5kyFqbjDv7EA
         b4oA==
X-Gm-Message-State: AOAM531GYvnLzHdylLzFuYgeJWSdLGe66OZ4kOneVZGAUwKEEoXSu5N4
        m6tHeJC52tKAFNLmO06Lp1auppe6d+Tg0NY93yQp4g==
X-Google-Smtp-Source: ABdhPJwPJOpQZzoVQNguW3T8SiUbZswwi0ghUEpHWqxyCVZSl6BTFRNEdwgB1BcSxXWS0604nEKACpT3ivcyqZCBhE8=
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr4505744wmb.31.1614370137092;
 Fri, 26 Feb 2021 12:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-6-mike.leach@linaro.org>
 <20210225212050.GA3567106@xps15>
In-Reply-To: <20210225212050.GA3567106@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 26 Feb 2021 20:08:46 +0000
Message-ID: <CAJ9a7VgBAh_KiF8vP8Kzc89HLO9Le1DNKnXWYE0o0Y7-xEDK5w@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] coresight: syscfg: Add API to activate and
 enable configurations
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
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

HI Mathieu,

On Thu, 25 Feb 2021 at 21:20, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, Jan 28, 2021 at 05:09:31PM +0000, Mike Leach wrote:
> > Configurations are first activated, then when any coresight device is
> > enabled, the active configurations are checked and any matching
> > one is enabled.
> >
> > This patch provides the activation / enable API.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  .../hwtracing/coresight/coresight-config.h    |   2 +
> >  .../hwtracing/coresight/coresight-syscfg.c    | 127 ++++++++++++++++++
> >  .../hwtracing/coresight/coresight-syscfg.h    |  10 +-
> >  include/linux/coresight.h                     |   2 +
> >  4 files changed, 140 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > index 98380b496046..26396b70c826 100644
> > --- a/drivers/hwtracing/coresight/coresight-config.h
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -156,6 +156,7 @@ struct cscfg_config_feat_ref {
> >   * @presets: Array of preset values.
> >   * @id_ea:   Extended attribute for perf configid value
> >   * @event_ea:        Extended attribute for perf event value
> > + * @active_cnt: ref count for activate on this configuration.
> >   */
> >  struct cscfg_config_desc {
> >       const char *name;
> > @@ -168,6 +169,7 @@ struct cscfg_config_desc {
> >       const u64 *presets; /* nr_presets * nr_total_params */
> >       struct dev_ext_attribute *id_ea;
> >       struct dev_ext_attribute *event_ea;
> > +     atomic_t active_cnt;
> >  };
> >
> >  /**
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
> >  }
> >
> > @@ -477,6 +478,131 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
> >  }
> >  EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
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
> > +
> > +     mutex_lock(&cscfg_mutex);
> > +
> > +     list_for_each_entry(curr_item, &cscfg_mgr->data.config_desc_list, item) {
> > +             if ((unsigned long)curr_item->id_ea->var == cfg_hash) {
> > +                     match_item = curr_item;
> > +                     atomic_inc(&cscfg_mgr->data.sys_active_cnt);
>
> It would be nice to have a comment that mentions why this is needed.  I had to
> go look in patch 09 to see that it prevents a feature from being changed when
> any configuration is active.  And since patch 09 is the only place where
> @sys_active_cnt is used, please move the declaration and handling of the
> variable there.
>

sys_active_cnt is used later in this patch in
cscfg_csdev_enable_active_config().
In that case it is to give a fast exit to the enable function if
nothing is actually active. The set is written so that the process of
enabling or disabling the config onto an actual device is effiecient
as possible - as this can happen frequently and across many devices.

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

The activate / enable paradigm was developed when I was working on the
dynamic feature load / unload in the follow up sets.
A little of this has been pulled in here - just enough of the
framework to get the built-in config going.

The idea is that activate is called first - in this set perf calls it
as it sets up / tears down and auxtrace session. In a later patchset,
configfs will call it to activate a configuration to allow it for be
active for sysfs controlled coresight.
This also ensures that the configuration cannot be removed while it is
needed, as you have observed in you next e-mail.

Then as any (etm) device has the perf event on it and enabled, the
cscfg_enable_active_config for the specific instance is then called.
This is deliberately independent of the activate process - activate is
system global, enable is per device. Therefore as an event moves
across ETMs, the relevent ETM will have the configuration activated.
The cscfg_enable_active_config() call matches the incoming config_hash
with an active config ( ->active_cnt) and if it finds this then a call
is made to do the actual activation on csdev.  This it does more than
just check for the active configuration.

This arrangement allows for different sessions of perf to have
different active configurations (looking to the near future when it
will be possible to support multiple perf sessions on 1:1 topologies).
It also validates that the requested configuration for enable, has
actually been activated.

That said - active_cnt could be dropped if we don't want the
additiional validation. (in the original dynamic load set I was
considering allowing unload of inactive configs even if others were
active - but that was too complicated and unnecessary).

Thanks

Mike



> > +     mutex_unlock(&cscfg_csdev_mutex);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> > +
> > +void cscfg_deactivate_config(unsigned long cfg_hash)
>
> I'm fine with either cfg_hash or id_hash, but not both.
>
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
> >  /* Initialise system configuration management device. */
> >
> >  struct device *to_device_cscfg(void)
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
> >   * @csdev_list:              List of coresight devices registered with the configuration manager.
> >   * @feat_desc_list:  List of feature descriptors to load into registered devices.
> >   * @config_desc_list:        List of system configuration descriptors to load into registered devices.
> > - * @nr_csdev:        Number of registered devices with the cscfg system
> > + * @nr_csdev:                Number of registered devices with the cscfg system
> > + * @sys_active_cnt:  Total number of active config descriptor references.
> >   */
> >  struct cscfg_api_data {
> >       struct list_head csdev_desc_list;
> >       struct list_head feat_desc_list;
> >       struct list_head config_desc_list;
> >       int nr_csdev;
> > +     atomic_t sys_active_cnt;
> >  };
> >
> >  /**
> > @@ -53,6 +55,12 @@ int cscfg_register_csdev(struct coresight_device *csdev,
> >                        struct cscfg_match_desc *info,
> >                        struct cscfg_csdev_feat_ops *ops);
> >  void cscfg_unregister_csdev(struct coresight_device *csdev);
> > +int cscfg_activate_config(unsigned long cfg_hash);
> > +void cscfg_deactivate_config(unsigned long cfg_hash);
> > +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > +                                  unsigned long id_hash, int preset);
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
> >       struct coresight_platform_data *pdata;
> > @@ -245,6 +246,7 @@ struct coresight_device {
> >       /* system configuration and feature lists */
> >       struct list_head feature_csdev_list;
> >       struct list_head config_csdev_list;
> > +     void *active_cfg_ctxt;
> >  };
> >
> >  /*
> > --
> > 2.17.1
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
