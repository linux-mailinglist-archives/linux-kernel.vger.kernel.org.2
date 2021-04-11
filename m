Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477F335B272
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbhDKIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhDKI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 04:29:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47EC06138B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 01:29:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x4so11394044edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72TVdz9a5dPpG854x3X6drcOYv9ZRloX7LoA17BMc3E=;
        b=nZ9AXibbwW7DMAcaH0yiehMHVmFFpyecFdA4OfmXykn6ehXJ1daGFOh0EYdVISralX
         pBOxWkg8NpIouMVIImOIcvIyuzwnK0V53bQJpHhz/X9QmAUvgXe9AXXgIOU22mcjfKLa
         x4H/qymCxedCmUbVw95mbrZ2YX1QR7FmxYOgjPdlAHwDS9D8z0Rlu3D5X+WfAEDDwcpb
         YaelfQ3m7P2QP3yppcfJpBaWXo9JJ5t/2Vfr+W31IK3EqSMf7yz6ApI96sUHBQZHRxLw
         VTsA5EqNcrHX3EvLx8QpvH4tuQh39TVQ38y9o5vlExmrTDKJSNdIRKR4lWi4CCSBZOF5
         j+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72TVdz9a5dPpG854x3X6drcOYv9ZRloX7LoA17BMc3E=;
        b=E8xgEIcTpJSmDjD8S7Mse0tH26WtJrW8ncApptbM4LOR4ApTAf0FxYOV36GlgbmAYY
         QcwDiU2qlxlcDQDAWn9Vq1HStVUXOVIHSbo4hyJ+qEEVCJNMQZB8sxrtP1yNbNV/P/tv
         N4ViL8CGrVKnnZYBdGtu8lJKcXSeJV/zii+ohBZ7w6HdIUgLzRyfwGYE4e062+mVOFft
         8v11655Lo0pk2kLVjyX+vAjTUYI2o3/ydvpA9UAz3FnuPsqlaZ0jeM0B2L0W97UauIjr
         YVyPgNbXVgE+U2VRyzG54wFORjqxFFlCSmNG3avP1kPsBEc6U4eBEoUKVqhqz/NxPsiM
         kuZQ==
X-Gm-Message-State: AOAM531gma2uBVQT0Bl/m6Pn5XBQGKVbcj6ORhT1j1WPEF4IKerEAep8
        Wn+ZN0WPAbvPJq7naYkAI1E=
X-Google-Smtp-Source: ABdhPJzHp6hZmhUgCG/tx/rle9YX6dEajijj9b1hL2nT1CIxeDwFFwOMMF9skmZk9KwOzJ/GFmtYSw==
X-Received: by 2002:a05:6402:440d:: with SMTP id y13mr24827489eda.316.1618129762062;
        Sun, 11 Apr 2021 01:29:22 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id hp12sm3682541ejc.46.2021.04.11.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 01:29:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v3 3/4] staging: rtl8723bs: Change the type and use of a variable
Date:   Sun, 11 Apr 2021 10:29:07 +0200
Message-Id: <20210411082908.31876-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210411082908.31876-1-fmdefrancesco@gmail.com>
References: <20210411082908.31876-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool. Shorten the controlling expression of an 
'if' statement.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

 drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 96fe172ced8d..8dc4dd8c6d4c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -348,7 +348,7 @@ void rtw_hal_dm_watchdog(struct adapter *padapter)
 
 void rtw_hal_dm_watchdog_in_lps(struct adapter *padapter)
 {
-	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode == true) {
+	if (adapter_to_pwrctl(padapter)->fw_current_in_ps_mode) {
 		if (padapter->HalFunc.hal_dm_watchdog_in_lps)
 			padapter->HalFunc.hal_dm_watchdog_in_lps(padapter); /* this function caller is in interrupt context */
 	}
diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 0a48f1653be5..0767dbb84199 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 fw_current_in_ps_mode;
+	bool fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.31.1

