Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4DB3B695C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhF1T6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhF1T6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:58:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3264C061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:56:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n11so5705582pjo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1k4lkp2PXUed6jkqwghumL5lahHakZzmhrDkz/Kqso=;
        b=uadnvBwgHrfWjJA06MU6jnajMBUslm/m8pG6NON27aoYkE2WgdgDy+Y04qDLRhOAm5
         WlgdqSP/CsIBV2OQCU6iz3RjYjB0MvPVBqUQkhAGkn0FYjc87KOYr+WP9aAQgO/nXs/D
         jfAPRkPh0UHyJV4XxtDJTLoQ408Y97VDXEQNs1BeVtdlE62H7EtuYGQueIfLtAMt1Z4X
         0PWKr0W6tUrB8w+CAANQGG0XEfUb2LDirqPsL+X+62r1SYRslOBdvivyuRJn3myTyoP0
         ik6xf9a3LupEWeS3iSY0gIduSCFvCd4i0dv61kUFRnK8zvNEnmzgkOUEIqecsa2dCVPg
         U/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1k4lkp2PXUed6jkqwghumL5lahHakZzmhrDkz/Kqso=;
        b=EbEe2L2zKU0YdQgwopF3vRx34IRHPCM8nvNYC5JfP13FNhEWwIGB/zmzmnaYmVN15Y
         2fTP1BHEvbbPsCXqAuoLvpqZv5ZW8AvWdcXtxi6QcyDaeTEL7yrX6BpU0qG0Yk16ufjl
         Nf62cgx2fDZ1JhAhYKy38HwtXkJlhv6vEmMD3T2U7svczJHK92dZQRMm+5OZSyUuYavT
         Wp7pv+GYhK7xncr2x0B1Mxg0CjHRDmlyOvd74nc4+pMmDChPbndjh6wm8OsyVILn2r0e
         cPUm2OutOB2TousiSA5gunXZ9gOmzJcy22h16U5SFPXytfivaEFnzNmCoZE3lK4oheE5
         InlA==
X-Gm-Message-State: AOAM5327vD5bwbDAP5Z6/dyDIWn1QHgSnS4R1t8dsTmZXvAmDTYNba0t
        /cgrFuH7QG7BviDemPuEDZ7jIw==
X-Google-Smtp-Source: ABdhPJwZ0ba2ljER8LBhGJP500U4YDWEXEokgBVYDnCTuOB5quJYg7Xt/4Ii9nLE51zFv+6ZgNfStg==
X-Received: by 2002:a17:90b:8ce:: with SMTP id ds14mr7310278pjb.131.1624910174050;
        Mon, 28 Jun 2021 12:56:14 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id r14sm15783731pgu.18.2021.06.28.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:56:12 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:56:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Branislav Rankov <branislav.rankov@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Yabin Cui <yabinc@google.com>, Jon Corbet <corbet@lwn.net>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v7 05/10] coresight: syscfg: Add API to activate and
 enable configurations
Message-ID: <20210628195610.GA1200359@p14s>
References: <20210414191903.18349-1-mike.leach@linaro.org>
 <20210414191903.18349-6-mike.leach@linaro.org>
 <dfbb1acf-b174-1990-33d3-39e2ab746959@arm.com>
 <CANLsYkyR-kUO7CiK4vuw+DNFMxCCsLN24s3mZ2Uw4vAq5aPD3g@mail.gmail.com>
 <CAJ9a7Vjsmu88ZY1h11o13VMu9C9gaBr_8HEmSa5iAH3NvwM=NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vjsmu88ZY1h11o13VMu9C9gaBr_8HEmSa5iAH3NvwM=NA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 03:37:16PM +0100, Mike Leach wrote:
> HI Branislav, Mathieu,
> 
> I have started to look into this as a top priority.

Perfect.  

There was also a report from a build bot realted to an undefined reference to
config_group_init_type_name().  Please see if there is something to do on that
one as well - I haven't had the opportunity to look at the report.

Thanks,
Mathieu

> 
> However, when I enable the CONFIG_DEBUG_ option my board fails to boot
> at all. (Dragonboard DB410c), so the resolution make take a little
> time.
> 
> At this point I am assuming that the mutex will need to be replaced by
> a spinlock - so a re-design + v8 set may well be required.
> 
> Regards
> 
> Mike
> 
> On Mon, 14 Jun 2021 at 18:03, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > Hi Branislav,
> >
> > On Thu, 10 Jun 2021 at 05:05, Branislav Rankov <branislav.rankov@arm.com> wrote:
> > >
> > >
> > > On 4/14/21 8:18 PM, Mike Leach wrote:
> > > > Configurations are first activated, then when any coresight device is
> > > > enabled, the active configurations are checked and any matching
> > > > one is enabled.
> > > >
> > > > This patch provides the activation / enable API.
> > > >
> > > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >   .../hwtracing/coresight/coresight-config.h    |   2 +
> > > >   .../hwtracing/coresight/coresight-syscfg.c    | 172 ++++++++++++++++++
> > > >   .../hwtracing/coresight/coresight-syscfg.h    |   8 +
> > > >   include/linux/coresight.h                     |   2 +
> > > >   4 files changed, 184 insertions(+)
> > > >
> > > > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > > > index 0667581822c1..25eb6c632692 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-config.h
> > > > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > > > @@ -127,6 +127,7 @@ struct cscfg_feature_desc {
> > > >    * @nr_total_params:        Sum of all parameters declared by used features
> > > >    * @presets:                Array of preset values.
> > > >    * @event_ea:               Extended attribute for perf event value
> > > > + * @active_cnt:              ref count for activate on this configuration.
> > > >    *
> > > >    */
> > > >   struct cscfg_config_desc {
> > > > @@ -139,6 +140,7 @@ struct cscfg_config_desc {
> > > >       int nr_total_params;
> > > >       const u64 *presets; /* nr_presets * nr_total_params */
> > > >       struct dev_ext_attribute *event_ea;
> > > > +     atomic_t active_cnt;
> > > >   };
> > > >
> > > >   /**
> > > > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> > > > index e35f8c0ac2f8..b234e45c153f 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-syscfg.c
> > > > +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> > > > @@ -283,6 +283,7 @@ static int cscfg_load_config(struct cscfg_config_desc *config_desc)
> > > >               return err;
> > > >
> > > >       list_add(&config_desc->item, &cscfg_mgr->config_desc_list);
> > > > +     atomic_set(&config_desc->active_cnt, 0);
> > > >       return 0;
> > > >   }
> > > >
> > > > @@ -468,6 +469,176 @@ void cscfg_unregister_csdev(struct coresight_device *csdev)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(cscfg_unregister_csdev);
> > > >
> > > > +/**
> > > > + * cscfg_csdev_reset_feats - reset features for a CoreSight device.
> > > > + *
> > > > + * Resets all parameters and register values for any features loaded
> > > > + * into @csdev to their default values.
> > > > + *
> > > > + * @csdev: The CoreSight device.
> > > > + */
> > > > +void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > > > +{
> > > > +     struct cscfg_feature_csdev *feat_csdev;
> > > > +
> > > > +     mutex_lock(&cscfg_csdev_mutex);
> > > > +     if (list_empty(&csdev->feature_csdev_list))
> > > > +             goto unlock_exit;
> > > > +
> > > > +     list_for_each_entry(feat_csdev, &csdev->feature_csdev_list, node)
> > > > +             cscfg_reset_feat(feat_csdev);
> > > > +
> > > > +unlock_exit:
> > > > +     mutex_unlock(&cscfg_csdev_mutex);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> > > > +
> > > > +/**
> > > > + * cscfg_activate_config -  Mark a configuration descriptor as active.
> > > > + *
> > > > + * This will be seen when csdev devices are enabled in the system.
> > > > + * Only activated configurations can be enabled on individual devices.
> > > > + * Activation protects the configuration from alteration or removal while
> > > > + * active.
> > > > + *
> > > > + * Selection by hash value - generated from the configuration name when it
> > > > + * was loaded and added to the cs_etm/configurations file system for selection
> > > > + * by perf.
> > > > + *
> > > > + * Increments the configuration descriptor active count and the global active
> > > > + * count.
> > > > + *
> > > > + * @cfg_hash: Hash value of the selected configuration name.
> > > > + */
> > > > +int cscfg_activate_config(unsigned long cfg_hash)
> > > > +{
> > > > +     struct cscfg_config_desc *config_desc;
> > > > +     int err = -EINVAL;
> > > > +
> > > > +     mutex_lock(&cscfg_mutex);
> > > > +
> > > > +     list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > > > +             if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > > +                     /*
> > > > +                      * increment the global active count - control changes to
> > > > +                      * active configurations
> > > > +                      */
> > > > +                     atomic_inc(&cscfg_mgr->sys_active_cnt);
> > > > +
> > > > +                     /*
> > > > +                      * mark the descriptor as active so enable config on a
> > > > +                      * device instance will use it
> > > > +                      */
> > > > +                     atomic_inc(&config_desc->active_cnt);
> > > > +
> > > > +                     err = 0;
> > > > +                     dev_dbg(cscfg_device(), "Activate config %s.\n", config_desc->name);
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +     mutex_unlock(&cscfg_mutex);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cscfg_activate_config);
> > > > +
> > > > +/**
> > > > + * cscfg_deactivate_config -  Mark a config descriptor as inactive.
> > > > + *
> > > > + * Decrement the configuration and global active counts.
> > > > + *
> > > > + * @cfg_hash: Hash value of the selected configuration name.
> > > > + */
> > > > +void cscfg_deactivate_config(unsigned long cfg_hash)
> > > > +{
> > > > +     struct cscfg_config_desc *config_desc;
> > > > +
> > > > +     mutex_lock(&cscfg_mutex);
> > > > +
> > > > +     list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > > > +             if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > > +                     atomic_dec(&config_desc->active_cnt);
> > > > +                     atomic_dec(&cscfg_mgr->sys_active_cnt);
> > > > +                     dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +     mutex_unlock(&cscfg_mutex);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cscfg_deactivate_config);
> > > > +
> > > > +/**
> > > > + * cscfg_csdev_enable_active_config - Enable matching active configuration for device.
> > > > + *
> > > > + * Enables the configuration selected by @cfg_hash if the configuration is supported
> > > > + * on the device and has been activated.
> > > > + *
> > > > + * If active and supported the CoreSight device @csdev will be programmed with the
> > > > + * configuration, using @preset parameters.
> > > > + *
> > > > + * Should be called before driver hardware enable for the requested device, prior to
> > > > + * programming and enabling the physical hardware.
> > > > + *
> > > > + * @csdev:   CoreSight device to program.
> > > > + * @cfg_hash:        Selector for the configuration.
> > > > + * @preset:  Preset parameter values to use, 0 for current / default values.
> > > > + */
> > > > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > +                                  unsigned long cfg_hash, int preset)
> > > > +{
> > > > +     struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > > +     const struct cscfg_config_desc *config_desc;
> > > > +     int err = 0;
> > > > +
> > > > +     /* quickly check global count */
> > > > +     if (!atomic_read(&cscfg_mgr->sys_active_cnt))
> > > > +             return 0;
> > > > +
> > > > +     mutex_lock(&cscfg_csdev_mutex);
> > > > +     list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > > > +             config_desc = config_csdev_item->config_desc;
> > > > +             if ((atomic_read(&config_desc->active_cnt)) &&
> > > > +                 ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > > +                     config_csdev_active = config_csdev_item;
> > > > +                     break;
> > > > +             }
> > > > +     }
> > > > +     if (config_csdev_active) {
> > > > +             err = cscfg_csdev_enable_config(config_csdev_active, preset);
> > > > +             if (!err)
> > > > +                     csdev->active_cscfg_ctxt = (void *)config_csdev_active;
> > > > +     }
> > > > +     mutex_unlock(&cscfg_csdev_mutex);
> > > > +     return err;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cscfg_csdev_enable_active_config);
> > > > +
> > > > +/**
> > > > + * cscfg_csdev_disable_active_config - disable an active config on the device.
> > > > + *
> > > > + * Disables the active configuration on the CoreSight device @csdev.
> > > > + * Disable will save the values of any registers marked in the configurations
> > > > + * as save on disable.
> > > > + *
> > > > + * Should be called after driver hardware disable for the requested device,
> > > > + * after disabling the physical hardware and reading back registers.
> > > > + *
> > > > + * @csdev: The CoreSight device.
> > > > + */
> > > > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev)
> > > > +{
> > > > +     struct cscfg_config_csdev *config_csdev;
> > > > +
> > > > +     mutex_lock(&cscfg_csdev_mutex);
> > >
> > > This line seems to cause a bug report when the kernel is compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y
> > >
> > > I have tested this by applying the series to 5.10 kernel on Dragonboard 845c.
> > >
> > > It only happens when strobing is used.
> >
> > Thanks for reporting this.  Unfortunately Mike is away and likely
> > won't be able to look at this in time for the merge window.  As such I
> > backed out the complex configuration feature from the next branch but
> > that code is still available on next-complex-configuration.
> >
> > Thanks,
> > Mathieu
> >
> > >
> > > The report is this:
> > >
> > > [13431.885395] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
> > > [13431.893919] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 3525, name: perf
> > > [13431.901882] CPU: 0 PID: 3525 Comm: perf Tainted: G        W         5.10.0-rc5-17282-g923b456a55fb #124
> > > [13431.911436] Hardware name: Thundercomm Dragonboard 845c (DT)
> > > [13431.917450] Call trace:
> > > [13431.919938]  dump_backtrace+0x0/0x1a0
> > > [13431.923644]  show_stack+0x18/0x68
> > > [13431.927008]  dump_stack+0xd0/0x12c
> > > [13431.930444]  ___might_sleep+0xf0/0x130
> > > [13431.934228]  __might_sleep+0x54/0x90
> > > [13431.937945]  mutex_lock+0x28/0x80
> > > [13431.941468]  cscfg_csdev_disable_active_config+0x24/0x50
> > > [13431.946952]  etm4_disable+0xf0/0x100
> > > [13431.950571]  etm_event_stop+0xb8/0x130
> > > [13431.954380]  etm_event_del+0x14/0x20
> > > [13431.958008]  event_sched_out.isra.0+0x84/0x1c8
> > > [13431.962496]  group_sched_out.part.0+0x44/0xc8
> > > [13431.967010]  __perf_event_disable+0xe4/0x198
> > > [13431.971549]  event_function+0x8c/0xe8
> > > [13431.975256]  remote_function+0x64/0x78
> > > [13431.979161]  generic_exec_single+0xa0/0x100
> > > [13431.983876]  smp_call_function_single+0x158/0x1d8
> > > [13431.988629]  event_function_call+0x128/0x138
> > > [13431.992942]  _perf_event_disable+0x48/0x70
> > > [13431.997082]  perf_event_for_each_child+0x3c/0x90
> > > [13432.001751]  _perf_ioctl+0x198/0x4a8
> > > [13432.005359]  perf_ioctl+0x4c/0x78
> > > [13432.008715]  __arm64_sys_ioctl+0xa8/0xf0
> > > [13432.012835]  el0_svc_common.constprop.0+0x78/0x1a0
> > > [13432.017767]  do_el0_svc+0x24/0x90
> > > [13432.021616]  el0_sync_handler+0x160/0x168
> > > [13432.025670]  el0_sync+0x174/0x180
> > >
> > >
> > > > +     config_csdev = (struct cscfg_config_csdev *)csdev->active_cscfg_ctxt;
> > > > +     if (config_csdev) {
> > > > +             cscfg_csdev_disable_config(config_csdev);
> > > > +             csdev->active_cscfg_ctxt = NULL;
> > > > +     }
> > > > +     mutex_unlock(&cscfg_csdev_mutex);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cscfg_csdev_disable_active_config);
> > > > +
> > > >   /* Initialise system configuration management device. */
> > > >
> > > >   struct device *cscfg_device(void)
> > > > @@ -536,6 +707,7 @@ int __init cscfg_init(void)
> > > >       INIT_LIST_HEAD(&cscfg_mgr->csdev_desc_list);
> > > >       INIT_LIST_HEAD(&cscfg_mgr->feat_desc_list);
> > > >       INIT_LIST_HEAD(&cscfg_mgr->config_desc_list);
> > > > +     atomic_set(&cscfg_mgr->sys_active_cnt, 0);
> > > >
> > > >       dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
> > > >       return 0;
> > > > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> > > > index 5bcae3b374c6..a52775890670 100644
> > > > --- a/drivers/hwtracing/coresight/coresight-syscfg.h
> > > > +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> > > > @@ -24,12 +24,14 @@
> > > >    * @csdev_desc_list:        List of coresight devices registered with the configuration manager.
> > > >    * @feat_desc_list: List of feature descriptors to load into registered devices.
> > > >    * @config_desc_list:       List of system configuration descriptors to load into registered devices.
> > > > + * @sys_active_cnt:  Total number of active config descriptor references.
> > > >    */
> > > >   struct cscfg_manager {
> > > >       struct device dev;
> > > >       struct list_head csdev_desc_list;
> > > >       struct list_head feat_desc_list;
> > > >       struct list_head config_desc_list;
> > > > +     atomic_t sys_active_cnt;
> > > >   };
> > > >
> > > >   /* get reference to dev in cscfg_manager */
> > > > @@ -61,5 +63,11 @@ int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> > > >   int cscfg_register_csdev(struct coresight_device *csdev, u32 match_flags,
> > > >                        struct cscfg_csdev_feat_ops *ops);
> > > >   void cscfg_unregister_csdev(struct coresight_device *csdev);
> > > > +int cscfg_activate_config(unsigned long cfg_hash);
> > > > +void cscfg_deactivate_config(unsigned long cfg_hash);
> > > > +void cscfg_csdev_reset_feats(struct coresight_device *csdev);
> > > > +int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > +                                  unsigned long cfg_hash, int preset);
> > > > +void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
> > > >
> > > >   #endif /* CORESIGHT_SYSCFG_H */
> > > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > > index 6fb516e1b22e..a348049ee08b 100644
> > > > --- a/include/linux/coresight.h
> > > > +++ b/include/linux/coresight.h
> > > > @@ -222,6 +222,7 @@ struct coresight_sysfs_link {
> > > >    * @has_conns_grp: Have added a "connections" group for sysfs links.
> > > >    * @feature_csdev_list: List of complex feature programming added to the device.
> > > >    * @config_csdev_list:  List of system configurations added to the device.
> > > > + * @active_cscfg_ctxt:  Context information for current active system configuration.
> > > >    */
> > > >   struct coresight_device {
> > > >       struct coresight_platform_data *pdata;
> > > > @@ -246,6 +247,7 @@ struct coresight_device {
> > > >       /* system configuration and feature lists */
> > > >       struct list_head feature_csdev_list;
> > > >       struct list_head config_csdev_list;
> > > > +     void *active_cscfg_ctxt;
> > > >   };
> > > >
> > > >   /*
> > > >
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
