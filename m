Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E032D11A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbhCDKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhCDKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:48:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D421DC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 02:47:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n4so9167997wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 02:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjqzWY75OT326vBwyxG3tSQkk/MUvHw5ITJLfqXrbpg=;
        b=IfFCkDtsaa/qv26twEwIg243Xc1Zg44J/xRE7n/z3w9CvQFXX3rqsjvbKbK2k2R1qP
         0DhcvGUo3kQGMjeFDuE76EErbKk24p9Vbuj+23FvVCbr7R/ihrA2G1vSS3erJiNNH75R
         W6lwa0s7qne/lLORE+cPJXEIs/O9bFD2EEqx9tx1zMKzrzQvHvghuTVdFqKvuvMY0zIR
         Tz4HTaEX5niT9l18kLx9p+NBhbrLT85tRhWgK2l+jpQEe2BeI8nwkY3VcmKwnEVf/hzt
         e5bGv0ud+bFy7nmiJi5Q/Uya1aWKLHrjOPLHkhgmHUytJqFbrPCYS9qgnuHZNUwTuVcQ
         Ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjqzWY75OT326vBwyxG3tSQkk/MUvHw5ITJLfqXrbpg=;
        b=uDKWECE8r0wecn0VYoDIWm3SWZLaEl3xr4ovRUAoVi7qwk+Q7vyUsQ2wiXCs0zAZNP
         OE2aQBVHEqxzhfsPlv2/BOQgLqm2H+WCXB+XAva3YxzSKF8xqFJBcxk1p5+3IZPGC55p
         YjYSlwCdTqqUTgpFCa80RlaCaDaVhm+cP17YfESR6oRXTLPMr8UYLWT4Q/PTikvEGAJN
         JdUiMkzJ1+qx/pIqK3nWg2bytG10srCztD2G04b9BztMAxhms8eVZGbyQfFrnIEO1q4X
         0Ln9X3o3e5ReM4xN3EQCK7nMgW2oW7pYvizOz6F1P3x23F5vCROCsgaGj2jYjYBihBXt
         iRMA==
X-Gm-Message-State: AOAM531h0xo0Rfngms4cHfcWdb45SDg95oxI5k6WJh0Z6G2JRvFsQe1q
        af2ZV65+vjc2u1mfXPmAUpXpHXpTlaBZZvA96GRYug==
X-Google-Smtp-Source: ABdhPJybGUiciIEpsMdJmNt6BYDfNaJDk0UodMcOnCYKVagObt7U98aZyFHtG3J4dNmszkhqncQFckdFPlla1IbNiVY=
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr3380450wme.5.1614854877391;
 Thu, 04 Mar 2021 02:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210128170936.9222-1-mike.leach@linaro.org> <20210128170936.9222-2-mike.leach@linaro.org>
 <b5dcaacc-567e-616d-5195-b841dd00eac0@arm.com>
In-Reply-To: <b5dcaacc-567e-616d-5195-b841dd00eac0@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Mar 2021 10:47:46 +0000
Message-ID: <CAJ9a7Vh_bU_vBxz12JHdgiHYY_DO-v6QPZ3=ojz_SH6vtepjmg@mail.gmail.com>
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

On Thu, 4 Mar 2021 at 10:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
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
> > +     struct list_head item;
> > +     int nr_refs;
> > +     struct cscfg_config_feat_ref *refs;
>
> s/refs/config_feat_refs/ ?
>
> In general please name the fields to make it easier to infer the type, given
> the number of structures we deal with, it becomes very difficult to track
> while reading the code.
>


Mathieu made the same comment - I'm updating the naming convention for v5

Thanks

Mike

> Cheers
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
