Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11380436226
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhJUM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhJUM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:58:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7EC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:55:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u21so1577137lff.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeWqycYIuVt19sWOnyHEv1PGs8MPa9Z3i7y2gAAE/yk=;
        b=NawLACvWDNKuQZVM7gNhU33JZAmxzGAz0vAmzpC5uZmVYq9AxySnJhJUX7p4ZldZdf
         +LZOrKPc0ZBTJ1LxLk/yCZbuT8EOCxT93xgzD6jcR77fab2x2z0EP8GMxYLm6ecL+eKS
         Qo4TDqE3Skv/DOpgzZV0MRDfgEJHaHxMcMqGZv8/zJf2Bwsx52rQWramOL0xY+ZYc3A5
         lOzTOMiegLmfaM7ZWuMYvOIrZc6dBmPN68MK6/U7RjeOAXH1t8tuYKyR+MlkDP/nWrlt
         PVuDS1e6CSQffOi1epq0sOqsdA7FmEFdiwqrSVCl+yMiFZvZ5cdxb35WQrxDFJ3dVOcz
         /lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeWqycYIuVt19sWOnyHEv1PGs8MPa9Z3i7y2gAAE/yk=;
        b=Klf87s0mTqvSGaX48mUWM4n9cA3wdMrTZrybK/KJRQCSp9K58j6ZICZ/vEyhz1KmfF
         LVmWyWfpZ0rY+NSVEIf3fGfBCficRcU4JeUbkRg9JwsLjen9RH/v10xKaNYXHzJdpCst
         nH/HhR/GyRXllr1/9JqDy//gUjc15Vg1WhKHAIYSyxi6krmk6ZkrIYYts4DD0TOFeWha
         XuKJM9T3OVi3M7L8Hb3q8S2OkpAbH0e9tpIIIkQ38p6j07MPguGmlco/0xa17TiK3dLN
         2ALQ1Q2pRn0NS9n3UPSJzdjBA6NHukN5mSugrZcTlsms4kNAA0GH01cVAWrZDBtkutN0
         IZMg==
X-Gm-Message-State: AOAM530qigPzFMO5LN+donGcUja0Okzht7+NC4mkBqrRMQdvh8BecZqx
        s835iKWM741tr87F3Va7dGIxGg==
X-Google-Smtp-Source: ABdhPJxFzmGm3er4wZIEDT2Ppy5LMXVNyzH3mHvH0sSXnZoZwxhSW/0taeZrEqARBPg20tX5wEYXAw==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr5100924lfq.553.1634820945937;
        Thu, 21 Oct 2021 05:55:45 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id r30sm455285lfp.298.2021.10.21.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:55:45 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     SoC Team <soc@kernel.org>
Cc:     arm-soc <arm@kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] optee: smc_abi.c: add missing #include <linux/mm.h>
Date:   Thu, 21 Oct 2021 14:55:39 +0200
Message-Id: <20211021125539.3858495-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing #include <linux/mm.h> drivers/tee/optee/smc_abi.c to fix
compile errors like:
drivers/tee/optee/smc_abi.c:405:15: error: implicit
declaration of function 'page_to_section'
[-Werror,-Wimplicit-function-declaration]
        optee_page = page_to_phys(*pages) +
                     ^
arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
                                               ^
include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
                    ^
include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
drivers/tee/optee/smc_abi.c:405:15: note: did you mean
'__nr_to_section'?
arch/arm/include/asm/memory.h:148:43: note: expanded from
macro 'page_to_phys'
                                               ^
include/asm-generic/memory_model.h:52:21: note: expanded
from macro 'page_to_pfn'
                    ^
include/asm-generic/memory_model.h:35:14: note: expanded
from macro '__page_to_pfn'
        int __sec = page_to_section(__pg);                      \
                    ^
include/linux/mmzone.h:1365:35: note: '__nr_to_section'
declared here
static inline struct mem_section *__nr_to_section(unsigned long nr)

Fixes: c51a564a5b48 ("optee: isolate smc abi")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---

I wasn't able to reproduce the error above. It obviously involves
CONFIG_SPARSEMEM=y, but something more seems to be needed to trigger the
error. Nonetheless, including <linux/mm.h> should fix the error.

Thanks,
Jens


 drivers/tee/optee/smc_abi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 9a787fb4f5e5..6196d7c3888f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-- 
2.31.1

