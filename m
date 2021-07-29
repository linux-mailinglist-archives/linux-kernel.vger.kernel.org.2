Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE923DA8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhG2QO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG2QO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:14:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A640C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:14:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f6so2036537ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHn3Mjf0ltvyA7q9q/MupFjAmkbw6+fc6Z36tQyPi7I=;
        b=kaRNG2pLzeE0TFXPkDZMPxc7IyooCyII3mI2+M/FJVKqDlxqj64NmCSdgphugtjttG
         V/AkvPYJuLkvFILQ/UoXZPW8+GzM9ZQcazJbqt1NFh5R+/uwrF20M5krJz3dg8P5YY0s
         M45JbQiZg8W/S6uuSe/2B+laXbMgyH5otjPHjpByOqbzRfQiCaj0IrpgxfYflVx5lRKs
         Da6Lb7mvhHhIJQgHOm/uNFlCQRKNwDAOHL1YDl/0tUgpEpcTcRZlSfICku/npQ9GnHUX
         EDTw31eefY13SKXgM7RXK0Nx7aekJWtPh+kfrn3jVFNx7WMb/X/qSxa3YCQn1Bu8wD63
         EkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHn3Mjf0ltvyA7q9q/MupFjAmkbw6+fc6Z36tQyPi7I=;
        b=LXtzOVbgEMmih8gaEJhsHXnMnODsvEUNCuap2VSH673HuV9LzVRzs/KOX+5TdAJ8me
         QSSjvOhHHvVvMl683n9phKmqnl1UIsF/6HbyC06x9rb34IyN5D2PKnzAT/0WJR+0TM93
         AS4f8v7ZW68dnFf2kKdH8AeShrjntRv17F2/S7l8XkBmvAfkntacte9FY9snBSnIMzpa
         9T5vazSVCcd9D1RB+okNJ8HQH0V55yv9gFkDoTeMP8MMD9Kq/BDZWewMMfJtUimxl9Gi
         s414jJquQMga9RXny4R7X1VysLNOQ+ArtrdPOH/BiFvDBgp6J9m/OO3JpgYXSvPheAo8
         2gDg==
X-Gm-Message-State: AOAM533Un22vx/gTp40ce2m6x5EmLkU5oX+OpPyMys/4SRPzTM29n5O8
        agVwGvWk1NgMfjqTtiZa4BYvHgvMQDDXsq3SWXZtQQ==
X-Google-Smtp-Source: ABdhPJxoBxfAlB+7K/S07ggZJs+8igA6gGElUqWmCesQVSVLuSECWCdciqQzJutkv2Bk4fJGDoLMrWk76QwkG+ONceU=
X-Received: by 2002:a05:6638:41a7:: with SMTP id az39mr5157368jab.52.1627575294386;
 Thu, 29 Jul 2021 09:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210723165444.1048-1-mike.leach@linaro.org> <20210723165444.1048-6-mike.leach@linaro.org>
 <20210728162409.GA2763979@p14s> <CAJ9a7ViN9hS6Z+MH2Z1s-KgDBPeiDZ260FfMd23OG9MzZc4mTQ@mail.gmail.com>
In-Reply-To: <CAJ9a7ViN9hS6Z+MH2Z1s-KgDBPeiDZ260FfMd23OG9MzZc4mTQ@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 29 Jul 2021 10:14:43 -0600
Message-ID: <CANLsYkwZfLM2qbaPkWnAKZHWrF0UgY_ApDT6yjJ=HAadA2azsQ@mail.gmail.com>
Subject: Re: [PATCH v9 05/10] coresight: syscfg: Add API to activate and
 enable configurations
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Yabin Cui <yabinc@google.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > +
> > > +/**
> > > + * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
> > > + *
> > > + * Enables the configuration selected by @cfg_hash if the configuration is supported
> > > + * on the device and has been activated.
> > > + *
> > > + * If active and supported the CoreSight device @csdev will be programmed with the
> > > + * configuration, using @preset parameters.
> > > + *
> > > + * Should be called before driver hardware enable for the requested device, prior to
> > > + * programming and enabling the physical hardware.
> > > + *
> > > + * @csdev:   CoreSight device to program.
> > > + * @cfg_hash:        Selector for the configuration.
> > > + * @preset:  Preset parameter values to use, 0 for current / default values.
> > > + */
> > > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > +                                  unsigned long cfg_hash, int preset)
> > > +{
> > > +     struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > +     const struct cscfg_config_desc *config_desc;
> > > +     unsigned long flags;
> > > +     int err = 0;
> > > +
> > > +     /* quickly check global count */
> > > +     if (!atomic_read(&cscfg_mgr->sys_active_cnt))
> > > +             return 0;
> > > +
> > > +     /* look for matching config - set in_enable flag if found */
> >
> > The second part of this comment no longer applies.
> >
>
> You are right - sorry missed that!
>
> > > +     spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > +     list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > > +             config_desc = config_csdev_item->config_desc;
> > > +             if ((atomic_read(&config_desc->active_cnt)) &&
> > > +                 ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > +                     config_csdev_active = config_csdev_item;
> > > +                     csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> > > +                     break;
> > > +             }
> > > +     }
> > > +     spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> > > +
> > > +     /*
> > > +      * If found, attempt to enable
> > > +      */
> > > +     if (config_csdev_active) {
> > > +             /*
> > > +              * Call the generic routine that will program up the internal
> > > +              * driver structures prior to programming up the hardware.
> > > +              * This routine takes the driver spinlock saved in the configs.
> > > +              */
> > > +             err = cscfg_csdev_enable_config(config_csdev_active, preset);
> > > +             if (!err) {
> > > +                     /*
> > > +                      * Successful programming. Check the active_cscfg_ctxt
> > > +                      * pointer to ensure no pre-emption disabled it via
> > > +                      * cscfg_csdev_disable_active_config() before
> > > +                      * we could start.
> > > +                      *
> > > +                      * Set enabled if OK, err if not.
> > > +                      */
> > > +                     spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > +                     if (csdev->active_cscfg_ctxt)
> > > +                             config_csdev_active->enabled = true;
> > > +                     else
> > > +                             err = -EBUSY;
> > > +                     spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> > > +             }
> >
> > This is much better.  I spent some time trying to break the heuristic and I
> > can't.  I intend to re-apply this set to give it as much exposure as possible but
> > want to see the above comment fixed.  I will do that locally though to avoid
> > having to deal with another revision.  What do you think of:
> >
> >         /*
> >          * Look for a matching configuration - set the active configuration
> >          * context if found.
> >          */
> >
>
> That looks fin to me
>
> Thanks

I have applied this set.

>
> Mike
>
>
> > Thanks,
> > Mathieu
> >
> > > +     }
> > > +     return err;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> > > +
> > > +/**
> > > + * cscfg_csdev_disable_active_config - disable an active config on the device.
> > > + *
> > > + * Disables the active configuration on the CoreSight device @csdev.
> > > + * Disable will save the values of any registers marked in the configurations
> > > + * as save on disable.
> > > + *
> > > + * Should be called after driver hardware disable for the requested device,
> > > + * after disabling the physical hardware and reading back registers.
> > > + *
> > > + * @csdev: The CoreSight device.
> > > + */
> > > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> > > +{
> > > +     struct cscfg_config_csdev *config_csdev;
> > > +     unsigned long flags;
> > > +
> > > +     /*
> > > +      * Check if we have an active config, and that it was successfully enabled.
> > > +      * If it was not enabled, we have no work to do, otherwise mark as disabled.
> > > +      * Clear the active config pointer.
> > > +      */
> > > +     spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > +     config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
> > > +     if (config_csdev) {
> > > +             if (!config_csdev->enabled)
> > > +                     config_csdev = NULL;
> > > +             else
> > > +                     config_csdev->enabled = false;
> > > +     }
> > > +     csdev->active_cscfg_ctxt = NULL;
> > > +     spin_unlock_irqrestore(&csdev->cscfg_csdev_lock, flags);
> > > +
> > > +     /* true if there was an enabled active config */
> > > +     if (config_csdev)
> > > +             cscfg_csdev_disable_config(config_csdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> > > +
> > >  /* Initialise system configuration management device. */
> > >
> > >  struct device *cscfg_device(void)
> > > @@ -536,6 +747,7 @@ int __init cscfg_init(void)
> > >       INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
> > >       INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
> > >       INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
> > > +     atomic_set(&cscfg_mgr->sys_active_cnt, 0);
> > >
> > >       dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
> > >       return 0;
> > > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> > > index 5bcae3b374c6..a52775890670 100644
> > > --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> > > +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> > > @@ -24,12 +24,14 @@
> > >   * @csdev_desc_list: List of coresight devices registered with the configuration manager.
> > >   * @feat_desc_list:  List of feature descriptors to load into registered devices.
> > >   * @config_desc_list:        List of system configuration descriptors to load into registered devices.
> > > + * @sys_active_cnt:  Total number of active config descriptor references.
> > >   */
> > >  struct cscfg_manager {
> > >       struct device dev;
> > >       struct list_head csdev_desc_list;
> > >       struct list_head feat_desc_list;
> > >       struct list_head config_desc_list;
> > > +     atomic_t sys_active_cnt;
> > >  };
> > >
> > >  /* get reference to dev in cscfg_manager */
> > > @@ -61,5 +63,11 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> > >  int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
> > >                        struct cscfg_csdev_feat_ops *ops);
> > >  void cscfg_unregister_csdev(struct coresight_device *csdev);
> > > +int cscfg_activate_config(unsigned long cfg_hash);
> > > +void cscfg_deactivate_config(unsigned long cfg_hash);
> > > +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> > > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > +                                  unsigned long cfg_hash, int preset);
> > > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
> > >
> > >  #endif /* CORESIGHT_SYSCFG_H */
> > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > index 16544ae2b532..93a2922b7653 100644
> > > --- a/include/linux/coresight.h
> > > +++ b/include/linux/coresight.h
> > > @@ -223,6 +223,7 @@ struct coresight_sysfs_link {
> > >   * @feature_csdev_list: List of complex feature programming added to the device.
> > >   * @config_csdev_list:  List of system configurations added to the device.
> > >   * @cscfg_csdev_lock:        Protect the lists of configurations and features.
> > > + * @active_cscfg_ctxt:  Context information for current active system configuration.
> > >   */
> > >  struct coresight_device {
> > >       struct coresight_platform_data *pdata;
> > > @@ -248,6 +249,7 @@ struct coresight_device {
> > >       struct list_head feature_csdev_list;
> > >       struct list_head config_csdev_list;
> > >       spinlock_t cscfg_csdev_lock;
> > > +     void *active_cscfg_ctxt;
> > >  };
> > >
> > >  /*
> > > --
> > > 2.17.1
> > >
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
