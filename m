Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9A38AEF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243083AbhETMs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbhETMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:47:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA0C0610E9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z130so9037183wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgRRldcE7qaeMwAh8NBDFamTUC06uAzZdQeyjsVPpJU=;
        b=eV7WWPIUc/f1mqsNiqq5oHzgq8fHiz6DyHTEDMRV8ydc+6Tx3ddB4d9NDmHejHmMJ2
         jh/X5XPhzOcCfqrtivhXVdvuv5VJZAj6EVxhXjepolp446r5GdCSefcWwwWxH1t+nub4
         uf3lvqc6aclnGz/hjpnP3cw+PyFZZJoDVsMl7v8Y+M2DwUKgpG6Q+jJnhJYDH1iu91RQ
         vL2n70vHw7dpk+OLcSozuW9DMvwmXypWxGQXR6ef767/8H7tkc2QusP45Kb5o/tGTv50
         OIALZAy8ImtMCUANHbDUOzPiej8WBV0d9MCz4jmN/m7JLbV5C5CiMYiNe7/xK7UGgeL2
         0jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgRRldcE7qaeMwAh8NBDFamTUC06uAzZdQeyjsVPpJU=;
        b=E1FV4d4xZpPVLimGIfGbpf11SdyaRVZtNMP/Tb+hGPy2EAot4E5KVp2PKKZ+nxGyqT
         1ImztcC/rnAE0AtatETgOjvtVLMICrHIP3Fokyk6ZFSoV1VWMo4Q/K+klJ8V4ppa4Wy3
         4/0pO4DLMQkqi6OA3OJvbOCfWVwcAK+m1pplOFFv7j7r3RWLhjGvxCSKb+skUyCQ0gb6
         BkQKomn7QBllzdJH0NbeeyB+0uhpHBNgJkQtUHNAiYlcDTekvgeGYgnCjcv0ABxYQ+8n
         qk8Eb2OUUQQk/kl4n1m3bb0r59GRDm+PaO3Pyml9VdXzUb0DT8ucbXKB+WbhM62PuaES
         xP/A==
X-Gm-Message-State: AOAM532+r06xKMOPKuMB6At+sNXpBDdL3/hzb+wuXud20dysOEu9UusH
        jUhRryw6XS8afna7+RmGGVZKXQ==
X-Google-Smtp-Source: ABdhPJzVTcGlKIz05U1xhSYtTKhqFrwb0Q4gvN2HOCEEo5HBFK0f/LLxrG51Q23O9+Q5hpER2vO5Jw==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr3125361wmg.81.1621512505917;
        Thu, 20 May 2021 05:08:25 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r7sm2237170wmq.18.2021.05.20.05.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:08:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kumar Sanghvi <kumar.sanghvi@stericsson.com>,
        Sundar Iyer <sundar.iyer@stericsson.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/7] mfd: db8500-prcmu: Fix multiple incorrectly documented function names
Date:   Thu, 20 May 2021 13:08:16 +0100
Message-Id: <20210520120820.3465562-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120820.3465562-1-lee.jones@linaro.org>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mfd/db8500-prcmu.c:624: warning: expecting prototype for prcmu_get_current_mode(). Prototype was for prcmu_get_xp70_current_state() instead
 drivers/mfd/db8500-prcmu.c:908: warning: expecting prototype for db8500_set_ape_opp(). Prototype was for db8500_prcmu_set_ape_opp() instead
 drivers/mfd/db8500-prcmu.c:2303: warning: expecting prototype for db8500_prcmu_reset_modem(). Prototype was for db8500_prcmu_modem_reset() instead

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Kumar Sanghvi <kumar.sanghvi@stericsson.com>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 167faac9b75bf..3bde7fda755f1 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -616,7 +616,7 @@ enum romcode_read prcmu_get_rc_p2a(void)
 }
 
 /**
- * prcmu_get_current_mode - Return the current XP70 power mode
+ * prcmu_get_xp70_current_state - Return the current XP70 power mode
  * Returns: Returns the current AP(ARM) power mode: init,
  * apBoot, apExecute, apDeepSleep, apSleep, apIdle, apReset
  */
@@ -898,7 +898,7 @@ static void request_even_slower_clocks(bool enable)
 }
 
 /**
- * db8500_set_ape_opp - set the appropriate APE OPP
+ * db8500_prcmu_set_ape_opp - set the appropriate APE OPP
  * @opp: The new APE operating point to which transition is to be made
  * Returns: 0 on success, non-zero on failure
  *
@@ -2297,7 +2297,7 @@ u16 db8500_prcmu_get_reset_code(void)
 }
 
 /**
- * db8500_prcmu_reset_modem - ask the PRCMU to reset modem
+ * db8500_prcmu_modem_reset - ask the PRCMU to reset modem
  */
 void db8500_prcmu_modem_reset(void)
 {
-- 
2.31.1

