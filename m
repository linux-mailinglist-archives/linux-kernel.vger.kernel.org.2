Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69A33DC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhCPSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbhCPSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:04:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2AC061763
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2000852wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jAMR1tzN6t+ZWUcgWbXlq+JaBCRA0Hujrk61Pxu1HLU=;
        b=vUPWT2phDVmNnZCWlrK1LyTdq1MdbtsAaD3CTY8HRUJa4S0Vlr4F/Fz2wmJA+d+xnH
         mrMi360fB2Kdjw3Vtnn4371ecVGY77qvXAauy3oMYM5vl+U8hb/11BKgdJTuppbB2Vo8
         4uFBiVJ732HoTF5u3dCegpP7B7+IWBB94mbUMKAocjyf4Yt2pd8ssgjJdwkgfD7+XGtj
         SBHMvu8m4AcYYu7+ZMNEM4qcrK4TKVWX54JniXiGkXT3NnikAW5glcbCw6TuSSSmTVde
         pyIkLiFGQG5Og9bAIeaf3FmEqjdyOI/AFbp4VFzccPJbfXsQXEnXzJ0cl0qc7z42h7ZF
         Eiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jAMR1tzN6t+ZWUcgWbXlq+JaBCRA0Hujrk61Pxu1HLU=;
        b=rOXVIh7gyNFEMu5EUfwbmKi3ujsTidNO226QIpUFpd1sA9Nk0+o14tcl4Ua7y6L9nw
         j69vqXInfkILQop7eklguSz2kGBIMAoZqUquuIEBJvISb8sDghwtaeekOQS5q5jKCddc
         0x0xXHlh9+nte61KM8FfNUgu0nMNe6Y8ylLWQ4DGOqJugRTbv3Zkpt6YC2/L/EoRT8la
         mxjlo7OaNii7qwFIk8VraLqZPavv7IPBrAsD0UTThWRFr+dVNkiShOhCg57bP5dg1Vi4
         IKWFm7Oa9jLkbJfWCURrsg0gzv6O8wm0OiWhuDyNjYnY0LUkw71lBBWf4up4Cq9X4Boq
         J1JQ==
X-Gm-Message-State: AOAM531W0u0zltGLcDZuRL8Ap0EM+yYKZv5NVWmVPcAfy4xSOY/Hmmy/
        1m3oSOJt/3yLQhSTWN0lcG1ChA==
X-Google-Smtp-Source: ABdhPJwPx1GLZ0o+sRpXGja97LnPIc1qJRw/THZwVyPwL/JHea1LMlHj2CctXcte4zWyxSBibC77AA==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr108299wmg.130.1615917842511;
        Tue, 16 Mar 2021 11:04:02 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:84a6:25fa:dde:ecca])
        by smtp.gmail.com with ESMTPSA id d13sm23927858wro.23.2021.03.16.11.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:04:02 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 00/10] CoreSight configuration management; ETM strobing
Date:   Tue, 16 Mar 2021 18:03:50 +0000
Message-Id: <20210316180400.7184-1-mike.leach@linaro.org>
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

Applies to coresight/next (5.12-rc2 base)

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
  coresight: docs: Add documentation for CoreSight config

 .../trace/coresight/coresight-config.rst      | 244 ++++++
 Documentation/trace/coresight/coresight.rst   |  16 +
 drivers/hwtracing/coresight/Makefile          |   7 +-
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 149 ++++
 .../coresight/coresight-cfg-preload.c         |  27 +
 .../coresight/coresight-cfg-preload.h         |  11 +
 .../hwtracing/coresight/coresight-config.c    | 274 +++++++
 .../hwtracing/coresight/coresight-config.h    | 253 ++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 155 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 +++++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
 .../coresight/coresight-etm4x-core.c          |  38 +-
 .../coresight/coresight-etm4x-sysfs.c         |   3 +
 .../coresight/coresight-syscfg-configfs.c     | 399 ++++++++++
 .../coresight/coresight-syscfg-configfs.h     |  45 ++
 .../hwtracing/coresight/coresight-syscfg.c    | 738 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
 include/linux/coresight.h                     |   7 +
 20 files changed, 2644 insertions(+), 39 deletions(-)
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

