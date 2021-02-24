Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA71E324281
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhBXQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhBXQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:49 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5BC061793
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so1520500plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMs1DVC4y+s8BiFEv/xRw15sV5bPEZeeQNwAspn8O98=;
        b=KiYwY0HreX9yoxxmmxcf0InD7oDh7+h6HVXcwez2vOzmUqC36ek5welIm9DkNBhF0b
         OYYRY7iUllOLfn/7hAkcG4HoVYDiQPMQG1F1f6MBvdwjP4pTYr3GD3KusjEQfytqxM22
         fYISh6gW6A3+rKe49JZdN7NYeQa4jovGOqPN0LkbPIQhTYwp2Fp8rD6mw+9FR57DIWXw
         gujn70QwO8pxb6qHlI/dL1WAd71EjsZd84Cq9GYynewwPrur0qSwXuTN7risOTN7OAq6
         nsgAFoO4pg5QbvhonVekIQVjaW/D87bHq5ZIED4xcu4Go+PQA73s2EJU+1ah3FqxqC1N
         so3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMs1DVC4y+s8BiFEv/xRw15sV5bPEZeeQNwAspn8O98=;
        b=sLXfy84w9GArBAGmaLyG+ctaH/f6nYkx1RxeB3vB34emxXiRue08vxCnQwnmlI0Ocy
         NketS1CQv11U+QZH7tdJPejDQ1aldn/OWVBavL/QdRdOwdPJiAA8zcKfV9vheu3IKrPU
         oCQ0GJWFdSy4Tb26i1RPnkNKXgVKhdZSqT25ErIbJtvnFS712uBDDDeeGr7U6QfizrH7
         a8ccHzWsOiTyVIcJ000Rm2JFcVeAJWGhQwe+0FB64RVTbb/NNQsCVQq7YT88KFo1SXP3
         vPlgoGwZfTqpVnPQOWjmCj5pGMNarBYK616QOyGWsRC0rgHDziN8Jsh3UYIteBbniq9h
         9m8A==
X-Gm-Message-State: AOAM533I+8pAP4mxT/S3XowuozmOk4QLhxSecWunx0ArvyZ4rBT8PcXX
        f0DSLwA+wpm9vEvN05ckbAzeMQ==
X-Google-Smtp-Source: ABdhPJwsUeT50NvNurP2aL3Nr8Nu/UBBY8PNSyCHu/fBhfU9Nv8I+UubvPDSid5FUqfCjEEIcY0ZiQ==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr5472808pjq.180.1614185316802;
        Wed, 24 Feb 2021 08:48:36 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:36 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Date:   Wed, 24 Feb 2021 09:48:29 -0700
Message-Id: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Arnaldo,

I noticed there is a couple of patchsets [1][2] that haven't made it
to your tree for the coming v5.12 cycle.  Do you think that can still
be done? 

I tallied the patches here to make it easier for you to pick up.

Applies cleanly on perf/core (84b7725536d8)

Thanks,
Mathieu

[1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
[2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/

Leo Yan (2):
  tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
  perf cs-etm: Add helper cs_etm__get_pid_fmt()

Mike Leach (1):
  perf: cs-etm: update ETM metadata format

Suzuki K Poulose (3):
  perf cs-etm: Fix bitmap for option
  perf cs-etm: Support PID tracing in config
  perf cs-etm: Detect pid in VMID for kernel running at EL2

 tools/include/linux/coresight-pmu.h           |  20 +-
 tools/perf/arch/arm/util/cs-etm.c             |  76 +++--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  38 ++-
 tools/perf/util/cs-etm.c                      | 277 +++++++++++++++---
 tools/perf/util/cs-etm.h                      |  31 +-
 5 files changed, 368 insertions(+), 74 deletions(-)

-- 
2.25.1

