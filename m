Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA43C60C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhGLQrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhGLQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:47:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45397C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:44:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l11so10450416pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ManJWWY0NbygXL9gv0aID0YB7I8L8S56TgZVG7q2PVc=;
        b=fVm+SRfdYq5x3SkeNPXsew9Sd4VLzU2VsfxA59VFZI4/LkSLkWDfHYSj+Lvs0eyYCS
         cCbobIQ1IC9D5k9jY0A5FJu9tFrbH5sI4ZMjrlePmSzwk9Jc/82y4Nu0ppGaUbD2BYIR
         6SS6shT/4DAtOX4eL16g2qPOYl2QiW3e+x8sqI68+DsKfqNi3MY4k1WQqbtcF++tGvl6
         w42cdWToVProjNC9pjxrj+dfCt91rpofeL5cKORyEqZdrgLEIWXunekFaSL5dUC+Twh8
         uXM05UHB63EA+9/qEENjvmGsczQfs+xIe6AqaVvYrZI3BI53jwBDfcbXP4tjkmR5j+s3
         hejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ManJWWY0NbygXL9gv0aID0YB7I8L8S56TgZVG7q2PVc=;
        b=F4Eh72f0/2MheIVlvJwdkkPYjWiSr9es2wNt26CdzRjS6MUQB8wCT0HNhoYmsP83XN
         9zufxQXavnWh1/2dKXs5mF8swA39SpG7XgAJs9RJUU2I7b9Hg28R5mvkkBfthGNz3scZ
         NBX2AOBMe/sTjOr7iYPDsaY9UpIThZYnun0v4sykYAiXZtOGyjOSUHRvGpNTPCuV59ZG
         R9PTDQEFj05oPtNQw5FpHkYNnjLnWFJxU7UGc4qFD1cKVCEfAkT+Im735sKShHVTpbnk
         GTyd6DdIgTgEp94l42NL61G2FW19RTXTWilKLZxchNSHCt6YVtUksZVH9/kfMc2WMAkA
         FJrQ==
X-Gm-Message-State: AOAM530ElFfL7VA5iyG4FoD5IDQWfr8Bls6fSfmwq4rpkMXuphVKWXCn
        uk9E+2/if3leBrC6TS9vo0uUiQ==
X-Google-Smtp-Source: ABdhPJxfl26OYZG+t1WPVE44ogV4jzO+i8shZoDPeHRf706ml1/CE9/wb44eXVp6pnmkwqNu6PtZOQ==
X-Received: by 2002:a17:90b:3844:: with SMTP id nl4mr14489837pjb.78.1626108256639;
        Mon, 12 Jul 2021 09:44:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 198sm15472219pfw.21.2021.07.12.09.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:44:15 -0700 (PDT)
Date:   Mon, 12 Jul 2021 10:44:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
Message-ID: <20210712164413.GA1777012@p14s>
References: <20210707133003.5414-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707133003.5414-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Mike,

On Wed, Jul 07, 2021 at 02:29:53PM +0100, Mike Leach wrote:
> This patchset introduces initial concepts in CoreSight system
> configuration management support. to allow more detailed and complex
> programming to be applied to CoreSight systems during trace capture.
> 
> Configurations consist of 2 elements:-
> 1) Features - programming combinations for devices, applied to a class of
> device on the system (all ETMv4), or individual devices.
> 2) Configurations - a set of programmed features used when the named
> configuration is selected.
> 
> Features and configurations are declared as a data table, a set of register,
> resource and parameter requirements. Features and configurations are loaded
> into the system by the virtual cs_syscfg device. This then matches features
> to any registered devices and loads the feature into them.
> 
> Individual device classes that support feature and configuration register
> with cs_syscfg.
> 
> Once loaded a configuration can be enabled for a specific trace run.
> Configurations are registered with the perf cs_etm event as entries in
> cs_etm/events. These can be selected on the perf command line as follows:-
> 
> perf record -e cs_etm/<config_name>/ ...
> 
> This patch set has one pre-loaded configuration and feature.
> A named "strobing" feature is provided for ETMv4.
> A named "autofdo" configuration is provided. This configuration enables
> strobing on any ETM in used.
> 
> Thus the command:
> perf record -e cs_etm/autofdo/ ...
> 
> will trace the supplied application while enabling the "autofdo" configuation
> on each ETM as it is enabled by perf. This in turn will enable strobing for
> the ETM - with default parameters. Parameters can be adjusted using configfs.
> 
> The sink used in the trace run will be automatically selected.
> 
> A configuration can supply up to 15 of preset parameter values, which will
> subsitute in parameter values for any feature used in the configuration.
> 
> Selection of preset values as follows
> perf record -e cs_etm/autofdo,preset=1/ ...
> 
> (valid presets 1-N, where N is the number supplied in the configuration, not
> exceeding 15. preset=0 is the same as not selecting a preset.)
> 
> Applies to & tested against coresight/next (5.13-rc6 base)
> 
> Changes since v7:
> 
> Fixed kernel test robot issue - config with CORESIGHT=y & CONFIGFS_FS=m causes
> build error. Altered CORESIGHT config to select CONFIGFS_FS.
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Replaced mutex use to protect loaded config lists in coresight devices with per
> device spinlock to remove issue when disable called in interrupt context.
> Reported-by: Branislav Rankov <branislav.rankov@arm.com>
>

Can you indicate which patches have changed so I don't have to review the whole
thing again?   It is also common practice to remove the RB tag when patches
have changed enough to mandate another review.  In this case all patches still
bare my RB tags.

Branislav reported the problem but he is not a recipient.  I would like to have
a confirmation from him that this set fixes the problem he observed before I
start looking at it.

Thanks,
Mathieu

> 
> Changes since v6:
> Fixed kernel test robot issues-
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Changes since v5:
> 
> 1) Fix code style issues from auto-build reports, as
> Reported-by: kernel test robot <lkp@intel.com>
> 2) Update comments to get consistent docs for API functions.
> 3) remove unused #define from autofdo example.
> 4) fix perf code style issues from patch 4 (Mathieu)
> 5) fix configfs code style issues from patch 9. (Mathieu)
> 
> Changes since v4: (based on comments from Matthieu and Suzuki).
> No large functional changes - primarily code improvements and naming schema.
> 1) Updated entire set to ensure a consistent naming scheme was used for
> variables and struct members that refer to the key objects in the system.
> Suffixes _desc used for all references to feature and configuraion descriptors,
> suffix _csdev used for all references to load feature and configs in the csdev
> instances. (Mathieu & Suzuki).
> 2) Dropped the 'configurations' sub dir in cs_etm perf directories as superfluous
> with the configfs containing the same information. (Mathieu).
> 3) Simplified perf handling code (suzuki)
> 4) Multiple simplifications and improvements for code readability (Matthieu
> and Suzuki)
> 
> Changes since v3: (Primarily based on comments from Matthieu)
> 1) Locking mechanisms simplified.
> 2) Removed the possibility to enable features independently from
> configurations.Only configurations can be enabled now. Simplifies programming
> logic.
> 3) Configuration now uses an activate->enable mechanism. This means that perf
> will activate a selected configuration at the start of a session (during
> setup_aux), and disable at the end of a session (around free_aux)
> The active configuration and associated features will be programmed into the
> CoreSight device instances when they are enabled. This locks the configuration
> into the system while in use. Parameters cannot be altered while this is
> in place. This mechanism will be extended in future for dynamic load / unload
> of configurations to prevent removal while in use.
> 4) Removed the custom bus / driver as un-necessary. A single device is
> registered to own perf fs elements and configfs.
> 5) Various other minor issues addressed.
> 
> Changes since v2:
> 1) Added documentation file.
> 2) Altered cs_syscfg driver to no longer be coresight_device based, and moved
> to its own custom bus to remove it from the main coresight bus. (Mathieu)
> 3) Added configfs support to inspect and control loaded configurations and
> features. Allows listing of preset values (Yabin Cui)
> 4) Dropped sysfs support for adjusting feature parameters on the per device
> basis, in favour of a single point adjustment in configfs that is pushed to all
> device instances.
> 5) Altered how the config and preset command line options are handled in perf
> and the drivers. (Mathieu and Suzuki).
> 6) Fixes for various issues and technical points (Mathieu, Yabin)
> 
> Changes since v1:
> 1) Moved preloaded configurations and features out of individual drivers.
> 2) Added cs_syscfg driver to manage configurations and features. Individual
> drivers register with cs_syscfg indicating support for config, and provide
> matching information that the system uses to load features into the drivers.
> This allows individual drivers to be updated on an as needed basis - and
> removes the need to consider devices that cannot benefit from configuration -
> static replicators, funnels, tpiu.
> 3) Added perf selection of configuarations.
> 4) Rebased onto the coresight module loading set. 
> 
> To follow in future revisions / sets:-
> a) load of additional config and features by loadable module.
> b) load of additional config and features by configfs
> c) enhanced resource management for ETMv4 and checking features have sufficient
> resources to be enabled.
> d) ECT and CTI support for configuration and features.
> 
> Mike Leach (10):
>   coresight: syscfg: Initial coresight system configuration
>   coresight: syscfg: Add registration and feature loading for cs devices
>   coresight: config: Add configuration and feature generic functions
>   coresight: etm-perf: update to handle configuration selection
>   coresight: syscfg: Add API to activate and enable configurations
>   coresight: etm-perf: Update to activate selected configuration
>   coresight: etm4x: Add complex configuration handlers to etmv4
>   coresight: config: Add preloaded configurations
>   coresight: syscfg: Add initial configfs support
>   Documentation: coresight: Add documentation for CoreSight config
> 
>  .../trace/coresight/coresight-config.rst      | 244 ++++++
>  Documentation/trace/coresight/coresight.rst   |  16 +
>  drivers/hwtracing/coresight/Kconfig           |   1 +
>  drivers/hwtracing/coresight/Makefile          |   7 +-
>  .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
>  .../coresight/coresight-cfg-preload.c         |  31 +
>  .../coresight/coresight-cfg-preload.h         |  13 +
>  .../hwtracing/coresight/coresight-config.c    | 275 ++++++
>  .../hwtracing/coresight/coresight-config.h    | 253 ++++++
>  drivers/hwtracing/coresight/coresight-core.c  |  12 +-
>  .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
>  .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
>  .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
>  .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
>  .../coresight/coresight-etm4x-core.c          |  38 +-
>  .../coresight/coresight-etm4x-sysfs.c         |   3 +
>  .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
>  .../coresight/coresight-syscfg-configfs.h     |  45 +
>  .../hwtracing/coresight/coresight-syscfg.c    | 829 ++++++++++++++++++
>  .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
>  include/linux/coresight.h                     |  11 +
>  21 files changed, 2746 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/trace/coresight/coresight-config.rst
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-config.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-config.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h
> 
> -- 
> 2.17.1
> 
