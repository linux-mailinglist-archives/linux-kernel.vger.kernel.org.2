Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B732BF61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835362AbhCCSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245101AbhCCPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:14:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3234C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:12:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id u125so6650335wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QbSzuQXaWQqlVas85i9P22YNEMaYY4GiLoB0CbKxqYU=;
        b=QXKSKS3fFG4f90a0xyB+pVd1nIJ0RWE4MIks3Ur6yEqanTuTB1hu/6r0VxRy6ZGcup
         TIE0wMNwk5n2F/Mi62JK+pQPageF8jSEZ8xkwDWjUoyIpJGxmx9r61zCJI0SNEaHp/fI
         Ov7CgNP7u4kcWFsvI4m5HsGV5MoiJ5TFzcvaBo0QQBY6I/iNE1Avus6S1aYzb7RCLxxx
         Efp4CiEC251FApjDkkuoZeJGqJsQT1+6lduqZG2wKZSvZZlPULjHKPrwwQ0zhE3bcc75
         EUNnJrnY10yHIsYpBxbGGpPvN8XEYgdJa84tJieFbjV5i4Be2bUWiEWaRuVKJlSjKiAP
         xYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QbSzuQXaWQqlVas85i9P22YNEMaYY4GiLoB0CbKxqYU=;
        b=k4XbAC/wHbUxM8+dGghKwR8wTWDGulW3bngk+nh5O4l3XtCsrfNL74sU4EGSh8MPYr
         36E3+Fl0/Hx+3FDOTvyXjA9Bkdtmr940RBB95Gcxz6ARyIpLecTQ7o5rgHXdL4WNHUtH
         yL0EKezgWpzhyRMJazsYJ2qcjo+d+nIMux7mr7+pZyjU4cn+FO+yaExTb89FazelPaGf
         WEZCSoHLgtJBf65SlheWgHocZgQ+TPJdp8txQi5Wf+z9NMscZ5CuxHhIFmz9zjXfW8yr
         vVzwReh29oSvNsjLlCIw7YwO5Dg0fO78Y/qRz/VyKZNNGjeCLoDM0N2zgxiT1PpMtp7p
         38YQ==
X-Gm-Message-State: AOAM5317V0kgy+aS2rGRDoDFBvhG5968SYpm77i8g2HgwlkB7WnWgF9U
        weQu4cBuW/pDpX4wi+OACNvhOrkbU5mmDMGIbLQ1qg==
X-Google-Smtp-Source: ABdhPJxPckPIWc+Bf8Kh9j4fIvUOkGQWmPWDBJkCz9OJjT8uQhggZHhxzbZ7D86CzgMlBBYTBFa47AHXKwi2JW8lw9Y=
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr9718488wmc.31.1614784370016;
 Wed, 03 Mar 2021 07:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-2-mike.leach@linaro.org>
 <4aa04906-d762-b51d-40bc-2e701583ef35@arm.com>
In-Reply-To: <4aa04906-d762-b51d-40bc-2e701583ef35@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 3 Mar 2021 15:12:39 +0000
Message-ID: <CAJ9a7Vic-3LS3HJn5o9K3=LX9zptRPStYd-Bj7+FYPZzTfcc-g@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] coresight: syscfg: Initial coresight system configuration
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

On Wed, 3 Mar 2021 at 10:09, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 1/28/21 5:09 PM, Mike Leach wrote:
> > Creates an system management API to allow complex configurations and
> > features to be programmed into a CoreSight infrastructure.
> >
> > A feature is defined as a programming set for a device or class of
> > devices.
> >
> > A configuration is a set of features across the system that are enabled
> > for a trace session.
> >
> > The API will manage system wide configuration, and allow complex
> > programmed features to be added to individual device instances, and
> > provide for system wide configuration selection on trace capture
> > operations.
> >
> > This patch creates the initial data object and the initial API for
> > loading configurations and features.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   .../hwtracing/coresight/coresight-config.h    | 167 +++++++++++++++
> >   drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> >   .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
> >   .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
> >   .../hwtracing/coresight/coresight-syscfg.c    | 197 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-syscfg.h    |  54 +++++
> >   7 files changed, 432 insertions(+), 4 deletions(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-config.h
> >   create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index f20e357758d1..4ce854c434b1 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -4,7 +4,7 @@
> >   #
> >   obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> > -             coresight-sysfs.o
> > +             coresight-sysfs.o coresight-syscfg.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
> > new file mode 100644
> > index 000000000000..3fedf8ab3cee
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-config.h
> > @@ -0,0 +1,167 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2020 Linaro Limited, All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +
> > +#ifndef _CORESIGHT_CORESIGHT_CONFIG_H
> > +#define _CORESIGHT_CORESIGHT_CONFIG_H
> > +
> > +#include <linux/coresight.h>
> > +#include <linux/types.h>
> > +
> > +/* CoreSight Configuration Management - component and system wide configuration */
> > +
> > +/*
> > + * Register type flags for register value descriptor:
> > + * describe how the value is interpreted, and handled.
> > + */
> > +#define CS_CFG_REG_TYPE_STD          0x80    /* reg is standard reg */
> > +#define CS_CFG_REG_TYPE_RESOURCE     0x40    /* reg is a resource */
> > +#define CS_CFG_REG_TYPE_VAL_PARAM    0x08    /* reg value uses param */
> > +#define CS_CFG_REG_TYPE_VAL_MASK     0x04    /* reg value bit masked */
> > +#define CS_CFG_REG_TYPE_VAL_64BIT    0x02    /* reg value 64 bit */
> > +#define CS_CFG_REG_TYPE_VAL_SAVE     0x01    /* reg value save on disable */
> > +
> > +/*
> > + * flags defining what device class a feature will match to when processing a
> > + * system configuration - used by config data and devices.
> > + */
> > +#define      CS_CFG_MATCH_CLASS_SRC_ALL      0x0001  /* match any source */
>
> nit: spurious TAB instead of SPACE
>
> > +#define CS_CFG_MATCH_CLASS_SRC_ETM4  0x0002  /* match any ETMv4 device */
> > +
> > +/* flags defining device instance matching - used in config match desc data. */
> > +#define CS_CFG_MATCH_INST_ANY                0x80000000 /* any instance of a class */
> > +
> > +/*
> > + * Limit number of presets in a configuration
> > + * This is related to the number of bits (4) we use to select the preset on
> > + * the perf command line. Preset 0 is always none selected.
> > + * See PMU_FORMAT_ATTR(preset, "config:0-3") in coresight-etm-perf.c
> > + */
> > +#define CS_CFG_CONFIG_PRESET_MAX 15
> > +
> > +/**
> > + * Parameter descriptor for a device feature.
> > + *
> > + * @name:  Name of parameter.
> > + * @value: Initial or default value.
> > + */
> > +struct cscfg_parameter_desc {
> > +     const char *name;
> > +     u64 value;
> > +};
> > +
> > +/**
> > + * Representation of register value.
> > + *
> > + * Supports full 64 bit register value, or 32 bit value with optional mask
> > + * value.
> > + *
> > + * @type:    define register usage and interpretation.
> > + * @offset:  the address offset for register in the hardware device (per device specification).
> > + * @hw_info: optional hardware device type specific information. (ETM / CTI specific etc)
> > + * @val64:   64 bit value.
> > + * @val32:   32 bit value.
> > + * @mask32:  32 bit mask when using 32 bit value to access device register.
> > + */
> > +struct cscfg_regval_desc {
> > +     struct {
> > +             u32 type:8;
> > +             u32 offset:12;
> > +             u32 hw_info:12;
> > +     };
> > +     union {
> > +             u64 val64;
> > +             struct {
> > +                     u32 val32;
> > +                     u32 mask32;
> > +             };
> > +     };
> > +};
> > +
> > +/**
> > + * Device feature descriptor - combination of registers and parameters to
> > + * program a device to implement a specific complex function.
> > + *
> > + * @name:    feature name.
> > + * @brief:   brief description of the feature.
> > + * @item:    List entry.
> > + * @match_flags: matching information if loading into a device
> > + * @nr_params:  number of parameters used.
> > + * @params:  array of parameters used.
> > + * @nr_regs: number of registers used.
> > + * @reg:     array of registers used.
> > + */
> > +struct cscfg_feature_desc {
> > +     const char *name;
> > +     const char *brief;
> > +     struct list_head item;
> > +     u32 match_flags;
>
> Either we could use the cscfg_match_desc here or, simply follow
> inlining match_flags everywhere, below (e.g, cscfg_config_feat_ref)
>

Following Mathieus comments and a re-think on my part this will be
addressed in the re-spin. I am planning to drop cfg_config_feat_ref in
favour of mathing just by name in configs, and having discrete flags
(and later named devices)  in the feat_desc.


> > +     int nr_params;
> > +     struct cscfg_parameter_desc *params;scfg_config_feat_ref
> > +     int nr_regs;
> > +     struct cscfg_regval_desc *regs;
> > +};
> > +
> > +/**
> > + * Match descriptor - Device / feature matching when loading into devices
> > + *
> > + * Used by loading configurations to define which class or specific devices
> > + * they want to match used features to, and registered devices to specify which
> > + * matching class and information they support.
> > + *
> > + * The load process uses these matching pairs to load feature instances into
> > + * matching devices.
> > + *
> > + * @match_flags:     used to match to a particular class of device.
> > + *
> > + */
> > +struct cscfg_match_desc {
> > +     u32 match_flags;
> > +};
> > +
> > +/**
> > + * Descriptor for features referenced by a configuration.
> > + *
> > + * @name:    name of feature to use. Match against the @name in struct
> > + *           cscfg_feature_desc.
> > + * @match:   match info for the feature when used in this configuration -
> > + *           may be all devices of a class or a specific device in that class.
> > + */
> > +struct cscfg_config_feat_ref {
> > +     const char *name;
> > +     struct cscfg_match_desc match;
> > +};
> > +
> > +/**
> > + * Configuration descriptor - describes selectable system configuration.
> > + *
> > + * A configuration describes device features in use, and may provide preset
> > + * values for the parameters in those features.
> > + *
> > + * A single set of presets is the sum of the parameters declared by
> > + * all the features in use - this value is @nr_total_params.
> > + *
> > + * @name:    name of the configuration - used for selection.
> > + * @brief:   description of the purpose of the configuration.
> > + * @item:    list entry.
> > + * @nr_refs: Number of features used in this configuration.
> > + * @refs:    references to features used in this configuration..
> > + * @nr_presets:      Number of sets of presets supplied by this configuration.
> > + * @nr_total_params: Sum of all parameters declared by used features
> > + * @presets: Array of preset values.
> > + *
> > + */
> > +struct cscfg_config_desc {
> > +     const char *name;
> > +     const char *brief;
>
> super nit: s/brief/desc ?
>

Probably 'description' to avoid clash with all the _desc names, but yes.

> > +     struct list_head item;
> > +     int nr_refs;
> > +     struct cscfg_config_feat_ref *refs;
> > +     int nr_presets;
> > +     int nr_total_params;
> > +     const u64 *presets; /* nr_presets * nr_total_params */
> > +};
> > +
> > +#endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
>
>
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
> > new file mode 100644
> > index 000000000000..f7e396a5f9cb
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.c
> > @@ -0,0 +1,197 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Linaro Limited, All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +
> > +#include "coresight-config.h"
> > +#include "coresight-syscfg.h"
> > +
> > +/*
> > + * cscfg_ API manages configurations and features for the entire coresight
> > + * infrastructure.
> > + *
> > + * It allows the loading of configurations and features, and loads these into
> > + * coresight devices as appropriate.
> > + */
> > +
> > +/* protect the cscsg_data and device */
> > +static DEFINE_MUTEX(cscfg_mutex);
> > +
> > +/* only one of these */
> > +static struct cscfg_manager *cscfg_mgr;
> > +
> > +/* load features and configuations into the lists */
> > +
> > +/* check feature list for a named feature - call with mutex locked. */
> > +static bool cscfg_match_list_feat(const char *name)
> > +{
> > +     struct cscfg_feature_desc *curr_item;
> > +
> > +     list_for_each_entry(curr_item, &cscfg_mgr->data.feat_desc_list, item) {
> > +             if (strcmp(curr_item->name, name) == 0)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +/* check all feat needed for cfg are in the list - call with mutex locked. */
> > +static int cscfg_check_feat_for_cfg(struct cscfg_config_desc *cfg_desc)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < cfg_desc->nr_refs; i++)
> > +             if (!cscfg_match_list_feat(cfg_desc->refs[i].name))
> > +                     return -EINVAL;
> > +     return 0;
> > +}
> > +
> > +/*
> > + * load feature - add to feature list.
> > + */
> > +static int cscfg_load_feat(struct cscfg_feature_desc *feat_desc)
> > +{
> > +     list_add(&feat_desc->item, &cscfg_mgr->data.feat_desc_list);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * load config into the system - validate used features exist then add to
> > + * config list.
> > + */
> > +static int cscfg_load_config(struct cscfg_config_desc *cfg_desc)
> > +{
> > +     int err;
> > +
> > +     /* validate features are present */
> > +     err = cscfg_check_feat_for_cfg(cfg_desc);
> > +     if (err)
> > +             return err;
> > +
> > +     list_add(&cfg_desc->item, &cscfg_mgr->data.config_desc_list);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * External API function to load feature and config sets.
> > + * Take a 0 terminated array of feature descriptors and/or configuration
> > + * descriptors and load into the system.
> > + * Features are loaded first to ensure configuration dependencies can be met.
> > + */
> > +int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> > +                        struct cscfg_feature_desc **feat_descs)
> > +{
> > +     int err, i = 0;
> > +
> > +     mutex_lock(&cscfg_mutex);
> > +
> > +     /* load features first */
> > +     if (feat_descs) {
> > +             while (feat_descs[i]) {
> > +                     err = cscfg_load_feat(feat_descs[i]);
> > +                     if (err) {
> > +                             pr_err("coresight-syscfg: Failed to load feature %s\n",
> > +                                    feat_descs[i]->name);
> > +                             goto do_unlock;
> > +                     }
> > +                     i++;
> > +             }
> > +     }
> > +
> > +     /* next any configurations to check feature dependencies */
> > +     i = 0;
> > +     if (cfg_descs) {
> > +             while (cfg_descs[i]) {
> > +                     err = cscfg_load_config(cfg_descs[i]);
> > +                     if (err) {
> > +                             pr_err("coresight-syscfg: Failed to load configuration %s\n",
> > +                                    cfg_descs[i]->name);
> > +                             goto do_unlock;
> > +                     }
> > +                     i++;
> > +             }
> > +     }
> > +
> > +do_unlock:
> > +     mutex_unlock(&cscfg_mutex);
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
>
> It looks like we keep the features and configs in the global list,
> even when there was a failure halfway. This could be problematic,
> as the caller could release/free the nodes we added and walking
> the list is going to explode. So, we either:
>
> 1) Do this in 2 pass. Check if the features and the configs can be
>     loaded in first pass. And load them in the second pass.
>
>   OR
>
> 2) Add cleanup code to remove the items that were added.
>
> Since we do this with the mutex lock, we should be fine.
>

In this initial set we are trying to keep to the minimum baseline to
provide the overall structure, with the autofdo configuration as a
built in.
Now we know that this configuration is by definition correct, so for
this baseline set at least, the code is guaranteed to work. We are not
allowing
additional user configs at this point.

There is a follow-up patch set that includes code to allow for dynamic
loading and unloading of configurations and features, and this
includes the correct error clean up, dependency locking to prevent
in-use configs from being unloaded, along with an example of how to
define a loadable module that loads a new set of configs / features.
But this adds a whole lot more code that is not needed in this
baseline set.

> > +
> > +/* Initialise system configuration management device. */
> > +
> > +struct device *to_device_cscfg(void)
>
> minor nit: to_device_cscfg() implies you are converting
> something to a device. But since this is a global device
> it could be better named as :
>
> struct device *cscfg_device(void);
>

Agreed.

>
> > +{
> > +     return cscfg_mgr ? &cscfg_mgr->dev : NULL;
> > +}
> > +
> > +/* Must have a release function or the kernel will complain on module unload */
> > +void cscfg_dev_release(struct device *dev)
> > +{
> > +     kfree(cscfg_mgr);
> > +     cscfg_mgr = NULL;
> > +}
> > +
> > +/* a device is needed to "own" some kernel elements such as sysfs entries.  */
> > +int cscfg_create_device(void)
> > +{
> > +     struct device *dev;
> > +     int err = -ENOMEM;
> > +
> > +     mutex_lock(&cscfg_mutex);
> > +     if (cscfg_mgr) {
> > +             err = -EINVAL;
> > +             goto create_dev_exit_unlock;
> > +     }
> > +
> > +     cscfg_mgr = kzalloc(sizeof(struct cscfg_manager), GFP_KERNEL);
> > +     if (!cscfg_mgr)
> > +             goto create_dev_exit_unlock;
> > +
> > +     /* setup the device */
> > +     dev = to_device_cscfg();
> > +     dev->release = cscfg_dev_release;
> > +     dev->init_name = "system_cfg";
>
> nit: Does it make sense to have "cs" somewhere in the name ?
>

It does.
It's not something that the user would ever see / use, but no doubt
linux makes hte name visible in a list somewhere.

> > +
> > +     err = device_register(dev);
> > +     if (err)
> > +             cscfg_dev_release(dev);
> > +
> > +create_dev_exit_unlock:
> > +     mutex_unlock(&cscfg_mutex);
> > +     return err;
> > +}
> > +
> > +void cscfg_clear_device(void)
> > +{
> > +     mutex_lock(&cscfg_mutex);
> > +     device_unregister(to_device_cscfg());
> > +     mutex_unlock(&cscfg_mutex);
> > +}
> > +
> > +/* Initialise system config management API device  */
> > +int __init cscfg_init(void)
> > +{
> > +     int err = 0;
> > +
> > +     err = cscfg_create_device();
> > +     if (err)
> > +             return err;
> > +
> > +     INIT_LIST_HEAD(&cscfg_mgr->data.csdev_desc_list);
> > +     INIT_LIST_HEAD(&cscfg_mgr->data.feat_desc_list);
> > +     INIT_LIST_HEAD(&cscfg_mgr->data.config_desc_list);
> > +     cscfg_mgr->data.nr_csdev = 0;
> > +
> > +     dev_info(to_device_cscfg(), "CoreSight Configuration manager initialised");
> > +     return 0;
> > +}
> > +
> > +void __exit cscfg_exit(void)
> > +{
> > +     cscfg_clear_device();
> > +}
> > diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
> > new file mode 100644
> > index 000000000000..907ba8d3efea
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-syscfg.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Coresight system configuration driver.
> > + */
> > +
> > +#ifndef CORESIGHT_SYSCFG_H
> > +#define CORESIGHT_SYSCFG_H
> > +
> > +#include <linux/coresight.h>
> > +#include <linux/device.h>
> > +
> > +#include "coresight-config.h"
> > +
> > +/**
> > + * System configuration manager API data.
> > + *
> > + * @csdev_list:              List of coresight devices registered with the configuration manager.
>
> Doesn't match the variable name below.
>

OK - will fix.

> > + * @feat_desc_list:  List of feature descriptors to load into registered devices.
> > + * @config_desc_list:        List of system configuration descriptors to load into registered devices.
> > + * @nr_csdev:        Number of registered devices with the cscfg system
> > + */
> > +struct cscfg_api_data {
> > +     struct list_head csdev_desc_list;
> > +     struct list_head feat_desc_list;
> > +     struct list_head config_desc_list;
> > +     int nr_csdev;
> > +};
> > +
> > +/* internal core operations for cscfg */
> > +int __init cscfg_init(void);
> > +void __exit cscfg_exit(void);
> > +
> > +/* syscfg manager external API */
> > +int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
> > +                        struct cscfg_feature_desc **feat_descs);
> > +
>
> ---> Cut here <---
>
> > +/**
> > + * System configuration manager device.
> > + *
> > + * Need a device to 'own' some coresight system wide sysfs entries in
> > + * perf events, configfs etc.
> > + *
> > + * @dev:     The device.
> > + * @data:    The API data.
> > + */
> > +struct cscfg_manager {
> > +     struct device dev;
> > +     struct cscfg_api_data data;
> > +};
> > +
> > +/* get reference to dev in cscfg_manager */
> > +struct device *to_device_cscfg(void);
>
> --> Cut End <---
>
> Do the above need to be exposed outside the core coresight-syscfg.c ?
>

Yes - they are used in the following patches in this set. They are
made visible here to avoid changing later in the patchset, which tends
to attract comments.

> Cheers
> Suzuki

Thanks for the review

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
