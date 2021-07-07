Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23393BE8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhGGNct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhGGNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:32:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23643C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 06:30:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j39-20020a05600c1c27b029020028e48b8fso4278090wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lWYD5O5NUB/m36M7Xr8hF1LEHODFdxXbCDdntn5AZtE=;
        b=k2QgcFbZOkymepbXq/m1LBvalkIL4OPAO0V+Ta6uxouj0qD9PS+PDgm6t5zXtPEz/m
         Awl0GvBODxtt3HJD4TepMROBqqhifz4zixBdSW/yCuW//46clXg7jcR9ilWUV0pEMb0t
         hZTXC6eihKFER0edt4JrJzAebAs0cwrnaWbunwgdveXrZwbzxztjPSrAlvVnXLwm50BC
         IzM/mAPKPvFI9bt3DPeU8ESlTSfttHdaAo6IABIRbYshpuzzp2T22HpcU6H/UFdftzWc
         XUziRgLpjHDiiBR9kZwKu0iy+KRuxf4E/QUZZgCOHOUjzn8E99CWwFiYWP5mIoJgGDp6
         Gmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lWYD5O5NUB/m36M7Xr8hF1LEHODFdxXbCDdntn5AZtE=;
        b=Hs+TLt/vOVReWdaNGeiOcB3eDhfCSWkTovweykNakbj0H9sAHw2kmHqMbQycFSln3r
         0ePh7jQDcBMirmPEpGMVyIsW/fvWGrl0ZLCQdOAaK8O1syzIZuAfxusgZ/bfUBujBptQ
         UjQf5ZEjUpdUq2/DRN9eG89OxBlbazjPRNPwUV+RgnvGqu3msNNNVBMxBcIS4C17KnqH
         Th+hE7bqujdU5WDpKVkXqqhwiIlj9bUEJKdN/xl/SI+E7k+sDo2FDFO5Ob1s2wkaGll1
         LUqLRgIeonINJr4qKra0S79aJlXiTJAdhew9LnY221TFhMeT0TIJo19tPs679K1HdIwz
         EJww==
X-Gm-Message-State: AOAM533UU6N78aBwYUICdwd4zrdJyCkB3AcKXhgxinmZB7RPQ9Cb4RwC
        sUAD4lfLHrqXBUa9LhH8AUduIA==
X-Google-Smtp-Source: ABdhPJzDzd7TGUzArQiRe5T78kkDJeokrYYYqMGwogk+RvJe9sV73vLKI95w7P1H6EFceltPwKfr0A==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr26446759wma.126.1625664605562;
        Wed, 07 Jul 2021 06:30:05 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id l16sm6632403wmj.47.2021.07.07.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:30:05 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v8 00/10] CoreSight configuration management; ETM strobing
Date:   Wed,  7 Jul 2021 14:29:53 +0100
Message-Id: <20210707133003.5414-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces initial concepts in CoreSight system
configuration management support. to allow more detailed and complex
programming to be applied to CoreSight systems during trace capture.

Configurations consist of 2 elements:-
1) Features - programming combinations for devices, applied to a class of
device on the system (all ETMv4), or individual devices.
2) Configurations - a set of programmed features used when the named
configuration is selected.

Features and configurations are declared as a data table, a set of register,
resource and parameter requirements. Features and configurations are loaded
into the system by the virtual cs_syscfg device. This then matches features
to any registered devices and loads the feature into them.

Individual device classes that support feature and configuration register
with cs_syscfg.

Once loaded a configuration can be enabled for a specific trace run.
Configurations are registered with the perf cs_etm event as entries in
cs_etm/events. These can be selected on the perf command line as follows:-

perf record -e cs_etm/<config_name>/ ...

This patch set has one pre-loaded configuration and feature.
A named "strobing" feature is provided for ETMv4.
A named "autofdo" configuration is provided. This configuration enables
strobing on any ETM in used.

Thus the command:
perf record -e cs_etm/autofdo/ ...

will trace the supplied application while enabling the "autofdo" configuation
on each ETM as it is enabled by perf. This in turn will enable strobing for
the ETM - with default parameters. Parameters can be adjusted using configfs.

The sink used in the trace run will be automatically selected.

A configuration can supply up to 15 of preset parameter values, which will
subsitute in parameter values for any feature used in the configuration.

Selection of preset values as follows
perf record -e cs_etm/autofdo,preset=1/ ...

(valid presets 1-N, where N is the number supplied in the configuration, not
exceeding 15. preset=0 is the same as not selecting a preset.)

Applies to & tested against coresight/next (5.13-rc6 base)

Changes since v7:

Fixed kernel test robot issue - config with CORESIGHT=y & CONFIGFS_FS=m causes
build error. Altered CORESIGHT config to select CONFIGFS_FS.
Reported-by: kernel test robot <lkp@intel.com>

Replaced mutex use to protect loaded config lists in coresight devices with per
device spinlock to remove issue when disable called in interrupt context.
Reported-by: Branislav Rankov <branislav.rankov@arm.com>


Changes since v6:
Fixed kernel test robot issues-
Reported-by: kernel test robot <lkp@intel.com>

Changes since v5:

1) Fix code style issues from auto-build reports, as
Reported-by: kernel test robot <lkp@intel.com>
2) Update comments to get consistent docs for API functions.
3) remove unused #define from autofdo example.
4) fix perf code style issues from patch 4 (Mathieu)
5) fix configfs code style issues from patch 9. (Mathieu)

Changes since v4: (based on comments from Matthieu and Suzuki).
No large functional changes - primarily code improvements and naming schema.
1) Updated entire set to ensure a consistent naming scheme was used for
variables and struct members that refer to the key objects in the system.
Suffixes _desc used for all references to feature and configuraion descriptors,
suffix _csdev used for all references to load feature and configs in the csdev
instances. (Mathieu & Suzuki).
2) Dropped the 'configurations' sub dir in cs_etm perf directories as superfluous
with the configfs containing the same information. (Mathieu).
3) Simplified perf handling code (suzuki)
4) Multiple simplifications and improvements for code readability (Matthieu
and Suzuki)

Changes since v3: (Primarily based on comments from Matthieu)
1) Locking mechanisms simplified.
2) Removed the possibility to enable features independently from
configurations.Only configurations can be enabled now. Simplifies programming
logic.
3) Configuration now uses an activate->enable mechanism. This means that perf
will activate a selected configuration at the start of a session (during
setup_aux), and disable at the end of a session (around free_aux)
The active configuration and associated features will be programmed into the
CoreSight device instances when they are enabled. This locks the configuration
into the system while in use. Parameters cannot be altered while this is
in place. This mechanism will be extended in future for dynamic load / unload
of configurations to prevent removal while in use.
4) Removed the custom bus / driver as un-necessary. A single device is
registered to own perf fs elements and configfs.
5) Various other minor issues addressed.

Changes since v2:
1) Added documentation file.
2) Altered cs_syscfg driver to no longer be coresight_device based, and moved
to its own custom bus to remove it from the main coresight bus. (Mathieu)
3) Added configfs support to inspect and control loaded configurations and
features. Allows listing of preset values (Yabin Cui)
4) Dropped sysfs support for adjusting feature parameters on the per device
basis, in favour of a single point adjustment in configfs that is pushed to all
device instances.
5) Altered how the config and preset command line options are handled in perf
and the drivers. (Mathieu and Suzuki).
6) Fixes for various issues and technical points (Mathieu, Yabin)

Changes since v1:
1) Moved preloaded configurations and features out of individual drivers.
2) Added cs_syscfg driver to manage configurations and features. Individual
drivers register with cs_syscfg indicating support for config, and provide
matching information that the system uses to load features into the drivers.
This allows individual drivers to be updated on an as needed basis - and
removes the need to consider devices that cannot benefit from configuration -
static replicators, funnels, tpiu.
3) Added perf selection of configuarations.
4) Rebased onto the coresight module loading set. 

To follow in future revisions / sets:-
a) load of additional config and features by loadable module.
b) load of additional config and features by configfs
c) enhanced resource management for ETMv4 and checking features have sufficient
resources to be enabled.
d) ECT and CTI support for configuration and features.

Mike Leach (10):
  coresight: syscfg: Initial coresight system configuration
  coresight: syscfg: Add registration and feature loading for cs devices
  coresight: config: Add configuration and feature generic functions
  coresight: etm-perf: update to handle configuration selection
  coresight: syscfg: Add API to activate and enable configurations
  coresight: etm-perf: Update to activate selected configuration
  coresight: etm4x: Add complex configuration handlers to etmv4
  coresight: config: Add preloaded configurations
  coresight: syscfg: Add initial configfs support
  Documentation: coresight: Add documentation for CoreSight config

 .../trace/coresight/coresight-config.rst      | 244 ++++++
 Documentation/trace/coresight/coresight.rst   |  16 +
 drivers/hwtracing/coresight/Kconfig           |   1 +
 drivers/hwtracing/coresight/Makefile          |   7 +-
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
 .../coresight/coresight-cfg-preload.c         |  31 +
 .../coresight/coresight-cfg-preload.h         |  13 +
 .../hwtracing/coresight/coresight-config.c    | 275 ++++++
 .../hwtracing/coresight/coresight-config.h    | 253 ++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
 .../coresight/coresight-etm4x-core.c          |  38 +-
 .../coresight/coresight-etm4x-sysfs.c         |   3 +
 .../coresight/coresight-syscfg-configfs.c     | 396 +++++++++
 .../coresight/coresight-syscfg-configfs.h     |  45 +
 .../hwtracing/coresight/coresight-syscfg.c    | 829 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
 include/linux/coresight.h                     |  11 +
 21 files changed, 2746 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/trace/coresight/coresight-config.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-afdo.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.c
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-preload.h
 create mode 100644 drivers/hwtracing/coresight/coresight-config.c
 create mode 100644 drivers/hwtracing/coresight/coresight-config.h
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm4x-cfg.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg-configfs.h
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.c
 create mode 100644 drivers/hwtracing/coresight/coresight-syscfg.h

-- 
2.17.1

