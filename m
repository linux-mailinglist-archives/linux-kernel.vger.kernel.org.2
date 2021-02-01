Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081FD30AED7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBASOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhBASOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v19so12607496pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFOgTpiHkBF9ofh5+M0K4tbztjSHqDaQ0oqqJs8XkY4=;
        b=k4bze/SFDxy7CPmT7uqiZ6GEQyb260r5neivI7YcW+CBssKphZw719AYcgEq8i4qG1
         mxqvf3m5stalT7qBkdXfSQOZCj8SKYAFs1vHypA0lGjPiNZlZ/EjC9uyfUvr2stiNgC2
         YApE3tvZ6Q0HcmFndyP5Zf60lbwqzseR34auEFxPaaR2iwVhxV4+WrFRDpALyBfEXBKu
         oeE8F+PEzVtYO+6LOTXMLRpZYJMnxjczCSnRMSqsq6DmykyOgTGxwCGFP/4lC6rmJIdA
         LrI5URdI9drPU9TiDBII1AvDs0aujLbFDhB/JTnPKJQEXZEPH3POQphB4OAHlEiyHesc
         XHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VFOgTpiHkBF9ofh5+M0K4tbztjSHqDaQ0oqqJs8XkY4=;
        b=F+zW2cXG21ec4E0m5lOs+pgPtEcdixkm5cuOFq82hgXl1f6ftoqMBMB3ad2fDjhyL1
         bxk/3cbh034dbEZvMYZe56iiBnncXdWmBgA8GqRbKXJFuz5SSGNTMQ4KjHOC/gQDv/ay
         80G+mvyjojKoEAN/6nUOyVPF0+kFVc5E3IETCr02uumzk0TEbv/5LB4Sw81l2orS8JSA
         zK5jomLgJ1BhPhrkXVSCu4MtcfzN/uFTguPxK85S/4Skyok/lqrrd7VxiX2Xnx7mY8va
         SBvIs+chz2khtD9Mq3LQ7DB+JHFe9wJIpxDlXxXlm+a8Tg/OPHRKXVvF/hbHL4h3vVS9
         DFTA==
X-Gm-Message-State: AOAM531lDoJAS580cp94wLBL6nq9pkXnuMLYqilEP+w2Avhxd67XW/cE
        ESRN70Ai0SScBlX0Q6+lHOcBig==
X-Google-Smtp-Source: ABdhPJw7V4tLJwAMxge5G8rz0q6P/BD3q+4qOVI+BlveGvSZdv0grivN1bE8kslYPk3DuTC7zljogA==
X-Received: by 2002:a65:6152:: with SMTP id o18mr18239791pgv.392.1612203233048;
        Mon, 01 Feb 2021 10:13:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:52 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/31] coresight: Patches for v5.12 
Date:   Mon,  1 Feb 2021 11:13:20 -0700
Message-Id: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Greg,

Please consider the following patches for inclusion in the coming v5.12 cycle.

Note that patches 11, 13 and 14 make checkpatch angry over the lack of 
parentheses when defining complex macros but looking at the code I really don't
see how else it could be done. 

Thanks,
Mathieu 

Chunyan Zhang (1):
  coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75

Jonathan Zhou (2):
  arm64: Add TRFCR_ELx definitions
  coresight: Add support for v8.4 SelfHosted tracing

Markus Elfring (1):
  coresight: cti: Reduce scope for the variable 'cs_fwnode' in
    cti_plat_create_connection()

Suzuki K Poulose (27):
  coresight: etm4x: Handle access to TRCSSPCICRn
  coresight: etm4x: Skip accessing TRCPDCR in save/restore
  coresight: Introduce device access abstraction
  coresight: tpiu: Prepare for using coresight device access abstraction
  coresight: Convert coresight_timeout to use access abstraction
  coresight: Convert claim/disclaim operations to use access wrappers
  coresight: etm4x: Always read the registers on the host CPU
  coresight: etm4x: Convert all register accesses
  coresight: etm4x: Make offset available for sysfs attributes
  coresight: etm4x: Add commentary on the registers
  coresight: etm4x: Add sysreg access helpers
  coresight: etm4x: Hide sysfs attributes for unavailable registers
  coresight: etm4x: Define DEVARCH register fields
  coresight: etm4x: Check for Software Lock
  coresight: etm4x: Cleanup secure exception level masks
  coresight: etm4x: Clean up exception level masks
  coresight: etm4x: Handle ETM architecture version
  coresight: etm4x: Detect access early on the target CPU
  coresight: etm4x: Use TRCDEVARCH for component discovery
  coresight: etm4x: Expose trcdevarch via sysfs
  coresight: etm4x: Add necessary synchronization for sysreg access
  coresight: etm4x: Detect system instructions support
  coresight: etm4x: Refactor probing routine
  coresight: etm4x: Run arch feature detection on the CPU
  coresight: etm4x: Add support for sysreg only devices
  dts: bindings: coresight: ETM system register access only units
  coresight: etm4x: Handle accesses to TRCSTALLCTLR

 .../testing/sysfs-bus-coresight-devices-etm4x |   8 +
 .../devicetree/bindings/arm/coresight.txt     |   5 +-
 arch/arm64/include/asm/sysreg.h               |  11 +
 drivers/hwtracing/coresight/coresight-catu.c  |  12 +-
 drivers/hwtracing/coresight/coresight-core.c  | 122 ++-
 .../hwtracing/coresight/coresight-cti-core.c  |  18 +-
 .../coresight/coresight-cti-platform.c        |   6 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  10 +-
 .../coresight/coresight-etm3x-core.c          |   9 +-
 .../coresight/coresight-etm4x-core.c          | 810 ++++++++++++------
 .../coresight/coresight-etm4x-sysfs.c         | 189 ++--
 drivers/hwtracing/coresight/coresight-etm4x.h | 505 ++++++++++-
 .../hwtracing/coresight/coresight-funnel.c    |   7 +-
 .../coresight/coresight-replicator.c          |  13 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  16 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  10 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  31 +-
 include/linux/coresight.h                     | 218 ++++-
 20 files changed, 1527 insertions(+), 481 deletions(-)

-- 
2.25.1

