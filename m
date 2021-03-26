Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DE034A3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCZJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCZJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 12so2571535wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CX+k7L0dBpqzzkBS4QmeuVEOJ0i6MHJNVxNRfQlTdyE=;
        b=beZ5ASvBlhZXl2YABm+2wVgMYwlM8Q7EZgxSl0iNaHWMlBBptng3bgUVKSeNH58ofr
         /Slncjt1X8cIF9Bjtj7oyolQXtRpOOF+xDP3Q4NC+gL4PHK2bh3whdpympHWiX/0fIdq
         ygrbyQUeKxx6dT1wjJoEtd7SpUWXWAWlmIFBnjqMmmiY8nErJQbY0Y9DkV/5YvB1tCG0
         aPDe7cn63+7SX2RlkAZxQdNFe8r9q4tXthkCsmP+vcgByS0nJbYGyX4oEK/p9SKvRbjy
         9tYajHx70hX/T4fBC3jlZpcjhZuElLM39r7+2b/UCbP+m6+l5rG8jKFBw6jzZimgCTau
         1q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CX+k7L0dBpqzzkBS4QmeuVEOJ0i6MHJNVxNRfQlTdyE=;
        b=WJ6sVDg7argncwRjoac1CyUoh0qUY2SV2toZN2Uu/rTEmVtA3QtMeh6zEjsz/Wvafv
         YBxxc21IZLfFeUialbPWgqG5drwSVnIKBorI5DL6LZs44nln5kkhVZWPODalNygqoR0b
         G1ub/FQOQXe4Asg1MptwD6bnc/3ydAnGEEVmZvWPT1IBC2sfa7oD6O9y3LY1TXBcPRUq
         fMV8CSZA9TGKcYKqPllbm0xAr26sgramW5+Xe+Hd9liaffcwrtE6Ohv+iJHz+lJbMcYb
         rGtLgVs+t72tdutH3skH/WV2bSyA8mCGm8/erAUrOYwMMeJXeqs780mTZpt90w/3Xu8X
         iBXQ==
X-Gm-Message-State: AOAM531lVH2FXLw+PVREEtbo63xJ7AFbThOLDnE335k+OjWntBTJBqeT
        lSgOazE+S/wSyKSnV0yJxRvL04jwnxHRBA==
X-Google-Smtp-Source: ABdhPJziawl4cAqcASZavZ4uijFRIdBS2O2jKSoadCjlGjWEMivLoDkc/ryjlYh/+dnCpVi16ua9Hg==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr12188957wma.39.1616749793724;
        Fri, 26 Mar 2021 02:09:53 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id n6sm11060482wmd.27.2021.03.26.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/15] staging: rtl8723bs: put parentheses on macros with complex values in include/hal_data.h
Date:   Fri, 26 Mar 2021 10:09:15 +0100
Message-Id: <bf9a56fe341baea4f07fcb4a2e43fcec293fb960.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warnings:

ERROR: Macros with complex values should be enclosed in parentheses
49: FILE: drivers/staging/rtl8723bs/include/hal_data.h:49:
+#define CHANNEL_MAX_NUMBER
		14+24+21	/*  14 is the max channel number */
--
ERROR: Macros with complex values should be enclosed in parentheses
53: FILE: drivers/staging/rtl8723bs/include/hal_data.h:53:
+#define CHANNEL_GROUP_MAX
		3+9	/*  ch1~3, ch4~9, ch10~14 total three groups */
--
ERROR: Macros with complex values should be enclosed in parentheses
76: FILE: drivers/staging/rtl8723bs/include/hal_data.h:76:
+#define IQK_Matrix_Settings_NUM_92D	1+24+21

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_data.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index b5a0be35a6ce..2f73540dd738 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -46,11 +46,11 @@ enum rt_ampdu_burst {
 	RT_AMPDU_BURST_8723B	= 7,
 };
 
-#define CHANNEL_MAX_NUMBER		14+24+21	/*  14 is the max channel number */
+#define CHANNEL_MAX_NUMBER		(14+24+21)	/*  14 is the max channel number */
 #define CHANNEL_MAX_NUMBER_2G		14
 #define CHANNEL_MAX_NUMBER_5G		54			/*  Please refer to "phy_GetChnlGroup8812A" and "Hal_ReadTxPowerInfo8812A" */
 #define CHANNEL_MAX_NUMBER_5G_80M	7
-#define CHANNEL_GROUP_MAX		3+9	/*  ch1~3, ch4~9, ch10~14 total three groups */
+#define CHANNEL_GROUP_MAX		(3+9)	/*  ch1~3, ch4~9, ch10~14 total three groups */
 #define MAX_PG_GROUP			13
 
 /*  Tx Power Limit Table Size */
@@ -73,7 +73,7 @@ enum rt_ampdu_burst {
 #define IQK_BB_REG_NUM_92D	10
 #define IQK_BB_REG_NUM_test	6
 
-#define IQK_Matrix_Settings_NUM_92D	1+24+21
+#define IQK_Matrix_Settings_NUM_92D	(1+24+21)
 
 /* define HP_THERMAL_NUM		8 */
 /*  duplicate code, will move to ODM ######### */
-- 
2.20.1

