Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8378F307D00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhA1RuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhA1RK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:10:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F4C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e15so5177298wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qHj5B+XRBw8ZN//XBzRxFjouBYl1AmeCxw5wS7tt9Zs=;
        b=ek9dujSJWuy1cvvTTTNxOdjHTrr/Mhptwq6r/6fF3skaS7p+lvvNlkgOghIwca3d+J
         aUT/hqfmpoKWXk+l9RRSGJggPPe8t2PxxHGrleuYaNa4AWjUsgipBmS0MZ5yPx9QEByS
         8Jx46mL68M5WOSRhbNNUpxLtHdZrFFdj3+Bzjtm95ovVxQbGiJpoZabOgyFDtRBmKRXN
         FpZTuYsb6CCrvlfaZMqghyq3YH8usCqr0rBDPXmwdar5icB/gPYwkd6AeCZQMN+LfCEt
         9e4sdJuozKivPar5bpIbAAqlMrIJrQ0S9+81NLhyWBSdxEamV/bP0Qgn3HdXxB47ai/Z
         u9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qHj5B+XRBw8ZN//XBzRxFjouBYl1AmeCxw5wS7tt9Zs=;
        b=ANeC0WetPdfJJUE66FVRhRvLKQyGqj1Mv3/jCVR9QfTd8E8l08LxSOKEi0voND01Kj
         +fXWbjpTlPCNluZweJjkLqf3fCMh6Qso+9KRgTf72I+dZql1Fy9UdhhXk93HsJQTdpF6
         5OTzuR1611rfzPquvLyJa0jwSHb/c2UivoTQC/Ku+GHr+W48XJ2P1B6mxvZd2L8RcZjl
         +Mfo6B9IgUdOYrFj7Ru0wlb00tcTKGMa7xByR4ywveC1xwBqyshMCvwijI20fzItxFPY
         cUgqGtdgdxpjKTZgd83paKbxuyxr1hzu8JQxEjeOvpymfxI38dalihCsk8YAgZUO2XQj
         w7nQ==
X-Gm-Message-State: AOAM5323f5MjJZv7iVOcIwfxX4fJQL33UJ8EcgZzFM9p6yBuLMQiOFb0
        GQPQRCgah7hTqtsc8g8zr1/psw==
X-Google-Smtp-Source: ABdhPJyqPKa4d7Pc3KiZLVsa+7wdwvoGKAYr16WPvIyT3ioKx2ryAffq+whZq7yT2UOXQLINGbA68Q==
X-Received: by 2002:a1c:7906:: with SMTP id l6mr259740wme.22.1611853784623;
        Thu, 28 Jan 2021 09:09:44 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:44 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 00/10]  CoreSight configuration management; ETM strobing
Date:   Thu, 28 Jan 2021 17:09:26 +0000
Message-Id: <20210128170936.9222-1-mike.leach@linaro.org>
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
cs_etm/cs_config. These can be selected on the perf command line as follows:-

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

A configuation can supply up to 15 of preset parameter values, which will
subsitute in parameter values for any feature used in the configuration.

Selection of preset values as follows
perf record -e cs_etm/autofdo,preset=1/ ...

(valid presets 1-N, where N is the number supplied in the configuration, not
exceeding 15. preset=0 is the same as not selecting a preset.)

Applies to coresight/next (5.11-rc2 base)

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
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 154 ++++
 .../coresight/coresight-cfg-preload.c         |  25 +
 .../coresight/coresight-cfg-preload.h         |  11 +
 .../hwtracing/coresight/coresight-config.c    | 246 ++++++
 .../hwtracing/coresight/coresight-config.h    | 282 +++++++
 drivers/hwtracing/coresight/coresight-core.c  |  18 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 180 ++++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 184 +++++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  29 +
 .../coresight/coresight-etm4x-core.c          |  38 +-
 .../coresight/coresight-etm4x-sysfs.c         |   3 +
 .../coresight/coresight-syscfg-configfs.c     | 399 +++++++++
 .../coresight/coresight-syscfg-configfs.h     |  45 ++
 .../hwtracing/coresight/coresight-syscfg.c    | 761 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  90 +++
 include/linux/coresight.h                     |   7 +
 20 files changed, 2721 insertions(+), 30 deletions(-)
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

