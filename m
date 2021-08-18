Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB23F0BED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhHRTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhHRTk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:40:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8806EC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o10so2540420plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XDPdkS72q7g8ReYvjeOrhrnuXjnS1ku+31GCbptnt8=;
        b=SOymdPAP5OoMlFfo4euAZVqSmqiu4CbFbYj1lc1YOcmxxBKsqop+sYapdsYO2hRiUc
         Z+Yw5ZcRablFlYRGSKbEniZ2HPLhIw1m3d+RHFaATGciRaVpMKeH5nRXSMrOj5pp7oVF
         xydwE7q0d8434SqK45mb9d+Lsb7whgqNZbM/yNvx5jpsfwnvsQYEQRCnFJ0qJoz5gcEp
         C4NPJu/hOyNbrCOpbpRgchp5uI+mRNFy3zPncsas8NhIdnV9emPuZy1Egl0koqBs70+A
         /aUYihnWBsALMTdng95ItvPP1kAmKs58AQcE/VD6zO/UZpHWu1Gp7ti1jbvMYQHBgwaN
         ek2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2XDPdkS72q7g8ReYvjeOrhrnuXjnS1ku+31GCbptnt8=;
        b=EiEBu1UFPkU0eqZ+zhZ5kIcf50i+89R2ZLwyQe9Mnv9NLLPB0FDvYVbXi+91V4m0Na
         Addq4mEGR+RGOu+8L5n8boVkBlnKW9uLoYaP3qAiiCRfZeyPY/6Ajat7kAb/Pug++TpE
         vVEKJDhO/Woi3o0Qr04bC4q8Y2we/nZP01l09jNIerEPzSniCsYz3U9UFWBs9tSqAb2w
         xQoM4HNdfPyIHhGXmsnkB17/Zk+cIFrK5Onp1BzIZPr9Y/WH/3t//6rR1JPfODythsPs
         aiZEkZTc3mpQWmYBbaw7OMJ1kkTzTJxDodrgfzO4ia6U9XnLtrnU4XptL1F2qvj5Ri6O
         XsJw==
X-Gm-Message-State: AOAM533Y5b20FuyahxNYqi2L7xTRW5kn8o6t9IfNUfarcwdk0uOTEUWx
        zsKFut5YjYMS81gxOEva/tf3lw==
X-Google-Smtp-Source: ABdhPJz5wtTx550guMrue4J60DkIvATsVj3homfaU3lidX5OUttOCBP3o2V7wJmFWT8NSQNov9e+Lg==
X-Received: by 2002:a17:90b:46cd:: with SMTP id jx13mr11073801pjb.181.1629315624115;
        Wed, 18 Aug 2021 12:40:24 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] coresight: Patches for v5.15
Date:   Wed, 18 Aug 2021 13:40:11 -0600
Message-Id: <20210818194022.379573-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is what I picked up for the next merge window (v5.15).  Please have
a look when time permits.

Applies cleanly on your char-misc-next branch (9e1b28b77388).  

Thanks,
Mathieu

Mike Leach (10):
  coresight: syscfg: Initial coresight system configuration
  coresight: syscfg: Add registration and feature loading for cs devices
  coresight: config: Add configuration and feature generic functions
  coresight: etm-perf: Update to handle configuration selection
  coresight: syscfg: Add API to activate and enable configurations
  coresight: etm-perf: Update to activate selected configuration
  coresight: etm4x: Add complex configuration handlers to etmv4
  coresight: config: Add preloaded configurations
  coresight: syscfg: Add initial configfs support
  Documentation: coresight: Add documentation for CoreSight config

Sebastian Andrzej Siewior (1):
  coresight: Replace deprecated CPU-hotplug functions.

 .../trace/coresight/coresight-config.rst      | 244 +++++
 Documentation/trace/coresight/coresight.rst   |  15 +
 drivers/hwtracing/coresight/Kconfig           |   1 +
 drivers/hwtracing/coresight/Makefile          |   7 +-
 .../hwtracing/coresight/coresight-cfg-afdo.c  | 153 ++++
 .../coresight/coresight-cfg-preload.c         |  31 +
 .../coresight/coresight-cfg-preload.h         |  13 +
 .../hwtracing/coresight/coresight-config.c    | 272 ++++++
 .../hwtracing/coresight/coresight-config.h    | 253 ++++++
 drivers/hwtracing/coresight/coresight-core.c  |  12 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   4 +-
 .../hwtracing/coresight/coresight-etm-perf.c  | 150 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  12 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.c | 182 ++++
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  30 +
 .../coresight/coresight-etm4x-core.c          |  38 +-
 .../coresight/coresight-etm4x-sysfs.c         |   3 +
 .../coresight/coresight-syscfg-configfs.c     | 396 ++++++++
 .../coresight/coresight-syscfg-configfs.h     |  45 +
 .../hwtracing/coresight/coresight-syscfg.c    | 847 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.h    |  81 ++
 include/linux/coresight.h                     |   9 +
 22 files changed, 2760 insertions(+), 38 deletions(-)
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
2.25.1

