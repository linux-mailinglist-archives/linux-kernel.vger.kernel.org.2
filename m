Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F03D1555
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhGUREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhGURD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:03:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F780C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:44:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b12so2768039pfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7g04vBKtF0ZEElYFfHTxoyICeD5Xbte2szynNTtKTgU=;
        b=KMqxCPJK9BUAR4yIp3GNnad/u9nrO2pFwCRlcbuPIDMnz3qJveugb8M6SYvFz0iww4
         QDNPZbNvaGiWM5T3O99Nrmbh38asRORFQehJDhXKmAOGx9gINpTu7deme+hZDTQCWwbp
         k2SH1D3QNtGg8E8Z16mvHEJReUXeVEQ8wcV9OfhorSYJD/Vr/2EcKUlJ458t56sG64ri
         GPTfOwXbzRH1VLyfY13kcC+MkFEyUCsQiBkXN8gl74qMxXCAPnG81f9EofRS8Y8jr3AW
         cs4K9z6DLl2dQYNyFJ+yYFjH5vykaBOs/D6/kw5Q1JW1wWk6MecVVElEsHC6/OVHN/QK
         3jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7g04vBKtF0ZEElYFfHTxoyICeD5Xbte2szynNTtKTgU=;
        b=l/zEOvTC7FOd1xHe0fddgGAf+yhYEbDfSmjAUV9arxodM7X8nxYJYQZreeS/ComYa9
         XLLWbRVaz28Bj7Z0bI2+EjL6mA585aOJhrvK+t6B+wlOW3u6P1Dw334p8wCB7+TlvarW
         mJSzMRRb5Umsf3uqjJ3ibWoEhlgQmeQsVpOgo+64A7Z/BLcPt109s92DkY3G9RyBSu+b
         xOCEHAnXv5dsKAwKo/E0nIDAyoqr9L1/36EHlapTv53YsOW2QGalmA6k48KDsqFbOSDK
         QnEmpCts/+b7chF9gJZzIMClBbI6F8n2YesKMzmYeoi1+5fpLq9OTzYku8Tr3hnRT2tr
         HZiA==
X-Gm-Message-State: AOAM530VMmoZcuUz0B6MOOyjNVQUOhjkkhK3iF7XVyddv3rNg2V+GnHQ
        AcseSiN2BVP8J2C0uHV7NyCLWQ==
X-Google-Smtp-Source: ABdhPJxz2cPOQ/4/hN3ve/rcMePrZuyJgMWDJTMmkUwlsfLtFBF2K68WPa46bBAriZKDyErPQf2x8g==
X-Received: by 2002:a05:6a00:b83:b029:352:9507:f3b9 with SMTP id g3-20020a056a000b83b02903529507f3b9mr8638760pfj.13.1626889473023;
        Wed, 21 Jul 2021 10:44:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b1sm501569pjn.11.2021.07.21.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:44:19 -0700 (PDT)
Date:   Wed, 21 Jul 2021 11:44:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Branislav Rankov <branislav.rankov@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
Message-ID: <20210721174417.GB2377909@p14s>
References: <20210707133003.5414-1-mike.leach@linaro.org>
 <20210712164413.GA1777012@p14s>
 <a80b9a03-01ba-3752-9e6e-ee2d194ba2a1@arm.com>
 <CAJ9a7ViieBazkBckF+2Bb0eeQyp14EpUAJ0j_GmU_Kibj9OBMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ9a7ViieBazkBckF+2Bb0eeQyp14EpUAJ0j_GmU_Kibj9OBMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 11:25:47AM +0100, Mike Leach wrote:
> HI Mathieu,
> 
> Below my change notes for the patches changed between v7 and v8 in this set.
> 
> Regards
> 
> Mike
> 
> 0001, 0003, 0004, 0006, 0007, 0008, 0010 - no change
> 
> 0002 -
> coresight-syscfg.c
>     top of file - mutex declaration removed.
>     cscfg_add_csdev_cfg()
>         Spinlock replaces mutex
>     cscfg_load_feat_csdev()
>         Spinlock replaces mutex
>     cscsg_list_add_csdev()
>         Init spinlock
> coresight.h
>     struct coresight_device {}
>         Add spinlock cscfg_csdev_lock alongside the csdev feature and
> config lists that it protects.
> 
> 0005 -
> coresight-syscfg.c
>     cscfg_csdev_reset_feats()
>             Spinlock replaces mutex.
> 
>     cscfg_csdev_enable_active_config()
>             Spinlock replaces mutex. In enable flag to avoid race with disable.
>     cscfg_csdev_disable_active_config()
>             Spinlock replaces mutex. In enable flag to avoid race with enable.
>

I'm good with the changes made to the above two patches.

> 
> coresight.h
>     struct coresight_device {}
>         In enable flag introduced to control possible race between
> enable and disable. E.g. if we are enabling a config, but a power
> event tries to shut down the CPU/ETM causing a disable call. We don’t
> want to hold the cscfg_csdev_lock spinlock throughout the entire
> enable process - especially as the programming call will claim the
> internal driver spinlock when writing internal driver data, but we
> need to ensure that if there is a condition that permits a disable
> call out of normal sequence then we are able to see it and handle it.
> 

Here I'm assuming the enable and disable calls you are referring to are
cscfg_csdev_enable_active_config() and cscfg_csdev_disable_active_config().

From the above paragraph I understand that a call to cscfg_csdev_enable_config()
can be interrupted at any time when the CPU is shutting down, which can only
happen when operating from sysfs.

With the above in mind and looking at the implementation in patch 05, if the
code gets interrupted right after cscfg_csdev_enable_config(), function
cscfg_csdev_disable_config() in cscfg_csdev_disable_active_config() won't be
called.

In function cscfg_csdev_enable_active_config(), could it be possible to set
csdev->active_cscfg_ctxt instead of csdev->cscfg_in_enable?  If
cscfg_csdev_enable_config() gets interrupted then function
cscfg_csdev_disable_config() can be called.  At that point disabling a feature
that hasn't been enabled shouldn't do anything. 

Thanks,
Mathieu

> 0009 -
>     KConfig
>     add in dependency on CONFIGFS_FS to eliminate problem highlighted
> by the kernel bot tests. This had configured coresight as Y, but
> configfs as M - meaning link issues for configfs code introduced in
> this set.
> 
> On Tue, 13 Jul 2021 at 10:43, Branislav Rankov <branislav.rankov@arm.com> wrote:
> >
> > Hi Mathieu,
> >
> > On 7/12/21 5:44 PM, Mathieu Poirier wrote:
> > > Good morning Mike,
> > >
> > > On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
> > >> This patchset introduces initial concepts in CoreSight system
> > >> configuration management support. to allow more detailed and complex
> > >> programming to be applied to CoreSight systems during trace capture.
> > >>
> > >> Configurations consist of 2 elements:-
> > >> 1) Features - programming combinations for devices, applied to a class of
> > >> device on the system (all ETMv4), or individual devices.
> > >> 2) Configurations - a set of programmed features used when the named
> > >> configuration is selected.
> > >>
> > >> Features and configurations are declared as a data table, a set of register,
> > >> resource and parameter requirements. Features and configurations are loaded
> > >> into the system by the virtual cs_syscfg device. This then matches features
> > >> to any registered devices and loads the feature into them.
> > >>
> > >> Individual device classes that support feature and configuration register
> > >> with cs_syscfg.
> > >>
> > >> Once loaded a configuration can be enabled for a specific trace run.
> > >> Configurations are registered with the perf cs_etm event as entries in
> > >> cs_etm/events. These can be selected on the perf command line as follows:-
> > >>
> > >> perf record -e cs_etm/<config_name>/ ...
> > >>
> > >> This patch set has one pre-loaded configuration and feature.
> > >> A named "strobing" feature is provided for ETMv4.
> > >> A named "autofdo" configuration is provided. This configuration enables
> > >> strobing on any ETM in used.
> > >>
> > >> Thus the command:
> > >> perf record -e cs_etm/autofdo/ ...
> > >>
> > >> will trace the supplied application while enabling the "autofdo" configuation
> > >> on each ETM as it is enabled by perf. This in turn will enable strobing for
> > >> the ETM - with default parameters. Parameters can be adjusted using configfs.
> > >>
> > >> The sink used in the trace run will be automatically selected.
> > >>
> > >> A configuration can supply up to 15 of preset parameter values, which will
> > >> subsitute in parameter values for any feature used in the configuration.
> > >>
> > >> Selection of preset values as follows
> > >> perf record -e cs_etm/autofdo,preset=1/ ...
> > >>
> > >> (valid presets 1-N, where N is the number supplied in the configuration, not
> > >> exceeding 15. preset=0 is the same as not selecting a preset.)
> > >>
> > >> Applies to & tested against coresight/next (5.13-rc6 base)
> > >>
> > >> Changes since v7:
> > >>
> > >> Fixed kernel test robot issue - config with CORESIGHT=y & CONFIGFS_FS=m causes
> > >> build error. Altered CORESIGHT config to select CONFIGFS_FS.
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >> Replaced mutex use to protect loaded config lists in coresight devices with per
> > >> device spinlock to remove issue when disable called in interrupt context.
> > >> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
> > >>
> > >
> > > Can you indicate which patches have changed so I don't have to review the whole
> > > thing again?   It is also common practice to remove the RB tag when patches
> > > have changed enough to mandate another review.  In this case all patches still
> > > bare my RB tags.
> > >
> > > Branislav reported the problem but he is not a recipient.  I would like to have
> > > a confirmation from him that this set fixes the problem he observed before I
> > > start looking at it.
> >
> > I have tested this series and the issue I reported is fixed.
> > >
> > > Thanks,
> > > Mathieu
> > >
> > >>
> > >> Changes since v6:
> > >> Fixed kernel test robot issues-
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >>
> > >> Changes since v5:
> > >>
> > >> 1) Fix code style issues from auto-build reports, as
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> 2) Update comments to get consistent docs for API functions.
> > >> 3) remove unused #define from autofdo example.
> > >> 4) fix perf code style issues from patch 4 (Mathieu)
> > >> 5) fix configfs code style issues from patch 9. (Mathieu)
> > >>
> > >> Changes since v4: (based on comments from Matthieu and Suzuki).
> > >> No large functional changes - primarily code improvements and naming schema.
> > >> 1) Updated entire set to ensure a consistent naming scheme was used for
> > >> variables and struct members that refer to the key objects in the system.
> > >> Suffixes _desc used for all references to feature and configuraion descriptors,
> > >> suffix _csdev used for all references to load feature and configs in the csdev
> > >> instances. (Mathieu & Suzuki).
> > >> 2) Dropped the 'configurations' sub dir in cs_etm perf directories as superfluous
> > >> with the configfs containing the same information. (Mathieu).
> > >> 3) Simplified perf handling code (suzuki)
> > >> 4) Multiple simplifications and improvements for code readability (Matthieu
> > >> and Suzuki)
> > >>
> > >> Changes since v3: (Primarily based on comments from Matthieu)
> > >> 1) Locking mechanisms simplified.
> > >> 2) Removed the possibility to enable features independently from
> > >> configurations.Only configurations can be enabled now. Simplifies programming
> > >> logic.
> > >> 3) Configuration now uses an activate->enable mechanism. This means that perf
> > >> will activate a selected configuration at the start of a session (during
> > >> setup_aux), and disable at the end of a session (around free_aux)
> > >> The active configuration and associated features will be programmed into the
> > >> CoreSight device instances when they are enabled. This locks the configuration
> > >> into the system while in use. Parameters cannot be altered while this is
> > >> in place. This mechanism will be extended in future for dynamic load / unload
> > >> of configurations to prevent removal while in use.
> > >> 4) Removed the custom bus / driver as un-necessary. A single device is
> > >> registered to own perf fs elements and configfs.
> > >> 5) Various other minor issues addressed.
> > >>
> > >> Changes since v2:
> > >> 1) Added documentation file.
> > >> 2) Altered cs_syscfg driver to no longer be coresight_device based, and moved
> > >> to its own custom bus to remove it from the main coresight bus. (Mathieu)
> > >> 3) Added configfs support to inspect and control loaded configurations and
> > >> features. Allows listing of preset values (Yabin Cui)
> > >> 4) Dropped sysfs support for adjusting feature parameters on the per device
> > >> basis, in favour of a single point adjustment in configfs that is pushed to all
> > >> device instances.
> > >> 5) Altered how the config and preset command line options are handled in perf
> > >> and the drivers. (Mathieu and Suzuki).
> > >> 6) Fixes for various issues and technical points (Mathieu, Yabin)
> > >>
> > >> Changes since v1:
> > >> 1) Moved preloaded configurations and features out of individual drivers.
> > >> 2) Added cs_syscfg driver to manage configurations and features. Individual
> > >> drivers register with cs_syscfg indicating support for config, and provide
> > >> matching information that the system uses to load features into the drivers.
> > >> This allows individual drivers to be updated on an as needed basis - and
> > >> removes the need to consider devices that cannot benefit from configuration -
> > >> static replicators, funnels, tpiu.
> > >> 3) Added perf selection of configuarations.
> > >> 4) Rebased onto the coresight module loading set.
> > >>
> > >> To follow in future revisions / sets:-
> > >> a) load of additional config and features by loadable module.
> > >> b) load of additional config and features by configfs
> > >> c) enhanced resource management for ETMv4 and checking features have sufficient
> > >> resources to be enabled.
> > >> d) ECT and CTI support for configuration and features.
> > >>
> > >> Mike Leach (10):
> > >>   coresight: syscfg: Initial coresight system configuration
> > >>   coresight: syscfg: Add registration and feature loading for cs devices
> > >>   coresight: config: Add configuration and feature generic functions
> > >>   coresight: etm-perf: update to handle configuration selection
> > >>   coresight: syscfg: Add API to activate and enable configurations
> > >>   coresight: etm-perf: Update to activate selected configuration
> > >>   coresight: etm4x: Add complex configuration handlers to etmv4
> > >>   coresight: config: Add preloaded configurations
> > >>   coresight: syscfg: Add initial configfs support
> > >>   Documentation: coresight: Add documentation for CoreSight config
> > >>
> > >>  .../trace/coresight/coresight-config.rst      | 244 ++++++
> > >>  Documentation/trace/coresight/coresight.rst   |  16 +
> > >>  drivers/hwtracing/coresight/Kconfig           |   1 +
> > >>  drivers/hwtracing/coresight/Makefile          |   7 +-
> > >>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
> > >>  .../coresight/coresight-cfg-preload.c         |  31 +
> > >>  .../coresight/coresight-cfg-preload.h         |  13 +
> > >>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
> > >>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
> > >>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
> > >>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
> > >>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
> > >>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
> > >>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
> > >>  .../coresight/coresight-etm4x-core.c          |  38 +-
> > >>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
> > >>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
> > >>  .../coresight/coresight-syscfg-configfs.h     |  45 +
> > >>  .../hwtracing/coresight/coresight-syscfg.c    | 829 ++++++++++++++++++
> > >>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
> > >>  include/linux/coresight.h                     |  11 +
> > >>  21 files changed, 2746 insertions(+), 36 deletions(-)
> > >>  create mode 100644 Documentation/trace/coresight/coresight-config.rst
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
> > >>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> > >>
> > >> --
> > >> 2.17.1
> > >>
> > > _______________________________________________
> > > CoreSight mailing list
> > > CoreSight@lists.linaro.org
> > > https://lists.linaro.org/mailman/listinfo/coresight
> > >
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
