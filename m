Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB38326744
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBZTLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 14:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhBZTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:11:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5035DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:10:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h98so9577996wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHgCO8palFYT8nsBZsW8MHZ560P7D66t44r53kupewg=;
        b=O+gKGD8Y8OLzauFscIMx4uQ/64/Zcv42xDd0wI3wueExoGYctTZm+G/JLo+z9WSO/m
         NeZ3yrpJG6oq1XxhAFRYkiZk2H23C1XDK2s0lA7dgFsdaYCRpH1EzazAM0OOQGobLDiG
         8HqSsruokpKZICzSBfCFNPD9DqjOMNBJbR8KAalPa9BXrfaRgLMb4SgCSekGwhWt5I3Q
         pFjuUF8gFa948RVAyvzVmL6ErYPnQCXkTX+r8PqYJwcizNouiBduIJs0vA5DJ9IERXm2
         jqonWIgiqsXJsMhujldkFMXJdedQANbwOAnXE4pel1Qau5FJ8wEODbfTjJw/kLytZxRr
         7/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHgCO8palFYT8nsBZsW8MHZ560P7D66t44r53kupewg=;
        b=P2uXk2/A0sebk17C+DnfjiJWhvRwlSuas0SPr3ZSmL4rXVFsp6konOUEv105bpd8kM
         cHYp9sBlQjlWg029lFuXxorPobXr8uH9fMWhi8MInfoaGm7kMe5AhnVALFQM1+tCy/t/
         7Lvssv1tm91BW0bgX7hCbWfWPSuSYyseys4VxkrtukBrZjeku2GqNxCw6ZJr1+st0oXM
         5vKXt3TF39T2Le2FNIw6fDI1+aTADAQm5E1S2xqokuXwLD/IENtRc78jcRxN8nGI862H
         gzarRKsMRUIh8qWELPP0MghQyLGpRxJYCiRlxhCSy0tPNaXEW5kH+TP4L/WP8i5VY2o7
         LcVw==
X-Gm-Message-State: AOAM533S71jxeu2B2kDw1zyP9S8LfWrfCxcdX3uKBpRJ4++Iw7pPu8y7
        oNPBHBEf3fGzgaXYy5q3otUBTT3kSwTZxt0lSP32PQ==
X-Google-Smtp-Source: ABdhPJxX7lkvczkwq9dTWsP37FcHxq+DRwW0cDVpd/sK60TCufHYf6Y9m/zZCtjvF1MTFUxBJtp9+BvtkZOAZBO91I8=
X-Received: by 2002:a5d:558b:: with SMTP id i11mr4671319wrv.176.1614366649948;
 Fri, 26 Feb 2021 11:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-2-mike.leach@linaro.org>
 <20210222185055.GA3239381@xps15>
In-Reply-To: <20210222185055.GA3239381@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 26 Feb 2021 19:10:39 +0000
Message-ID: <CAJ9a7Vjnt1O6btkBFCTqjHDUOCApcjZcLj1ozNbanDrs6FnOyg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] coresight: syscfg: Initial coresight system configuration
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

Hi Mathieu,

On Mon, 22 Feb 2021 at 18:50, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Thu, Jan 28, 2021 at 05:09:27PM +0000, Mike Leach wrote:
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
> >  drivers/hwtracing/coresight/Makefile          |   2 +-
> >  .../hwtracing/coresight/coresight-config.h    | 167 +++++++++++++++
> >  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> >  .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
> >  .../hwtracing/coresight/coresight-etm-perf.h  |   2 +-
> >  .../hwtracing/coresight/coresight-syscfg.c    | 197 ++++++++++++++++++
> >  .../hwtracing/coresight/coresight-syscfg.h    |  54 +++++
> >  7 files changed, 432 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
> >  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index f20e357758d1..4ce854c434b1 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -4,7 +4,7 @@
> >  #
> >  obj-$(CONFIG_CORESIGHT) += coresight.o
> >  coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> > -             coresight-sysfs.o
> > +             coresight-sysfs.o coresight-syscfg.o
> >  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
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
> > +     int nr_params;
> > +     struct cscfg_parameter_desc *params;
>
>         struct cscfg_parameter_desc *params_desc;
>
> > +     int nr_regs;
> > +     struct cscfg_regval_desc *regs;
>
>         struct cscfg_regval_desc *regs_desc;
>
> That way I know exactly what I'm looking at when I see something like the
> following in patch 03:
>
>         reg_desc = &feat->desc->regs[i];
>

Agreed - I'll improve the naming consistency in the next revision

Mike


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
