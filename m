Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7C3106E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBEIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBEIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:39:35 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA51C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 00:38:53 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id a7so6094063qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 00:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhxlanQG+HqkGzdhY0ZNwODmu5HrV/AvfvoiC5bU/hI=;
        b=mEPsFHnXJw1EaJlHKxiZTiWm8o9wWelw7AvKGaWejdWBjlccSyME5HAg8wVNlnVI78
         acUTt5MiUuCrwfuh53Y0d8d48AXE+00oqgO+vyoaxna0UJIuJzdiW+yqbe2mzSBrPsK+
         prpN0irh8Ng9POO5rfHvSjeXeVZplxR0pRu3Rhrq2u0c50b+UNC09JOlliDCJ8UhXD81
         Q6+LAphQUwvf8IdiCB4eHZ3588WZUBWicewD//Xcfyo1guSoZqaz/Ufwg4cwy06QZ80w
         paZYEdeCVNTF0JAUNwVcPKP+bwnteAo6+BGhR5qi9rDoesVN74gzCTi2McuqrCyay9g/
         V3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhxlanQG+HqkGzdhY0ZNwODmu5HrV/AvfvoiC5bU/hI=;
        b=Z9mEl+AJuczDu4nfQ41B9T0vr/7i3W13cOdgH5TWY6WqIDod12O9j5tN2XmJPee0Qv
         NdJ2kILn4Ph57VDdYWDAoLdachcpaV2XdjRzhQRpMUcQSSnrsQePmH850B8AlL8jMHFZ
         L50xiyvUALtQg13Z6pdZF+Y0Cc1JTTCq1YSK+mTNxEe+T0EpcmpGSmNK97r4UAM11kZo
         1X9Fy0Wq09Jv8dReQmZyzO6jZ7nSo5/148/mtD8AEsr1psH6VN+frWCvxMw7sJpsC2FI
         nMJGVjEX/QaHboE9HpQ++zDqqqHGK8/y+WKYCUTwcMRMbF5w95K7gBuBfTwhv8KTc9Eq
         lPiA==
X-Gm-Message-State: AOAM533YCyM4SpHnJCqDtUyg1fSEbumoFdFt+icQR7kHiM9jn8VPySlC
        EPmwedY6sQrf0RTatClWwE0=
X-Google-Smtp-Source: ABdhPJxNOBXsC5fiUS4ovDwuoV+JLF+yNsZpjoYVEwBypXv+SGzYZaYERwmuL8lDui3dFkoqlcGO6Q==
X-Received: by 2002:a05:620a:12d7:: with SMTP id e23mr3229871qkl.58.1612514333097;
        Fri, 05 Feb 2021 00:38:53 -0800 (PST)
Received: from localhost.localdomain ([156.146.36.157])
        by smtp.gmail.com with ESMTPSA id w27sm7752007qtb.34.2021.02.05.00.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 00:38:52 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        yukuai3@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: arm: mach-imx: Fix a spelling in the file pm-imx5.c
Date:   Fri,  5 Feb 2021 14:08:31 +0530
Message-Id: <20210205083831.339095-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/confgiured/configured/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/arm/mach-imx/pm-imx5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx5.c b/arch/arm/mach-imx/pm-imx5.c
index e9962b48e30c..2e3af2bc7758 100644
--- a/arch/arm/mach-imx/pm-imx5.c
+++ b/arch/arm/mach-imx/pm-imx5.c
@@ -45,7 +45,7 @@
  * This is also the lowest power state possible without affecting
  * non-cpu parts of the system.  For these reasons, imx5 should default
  * to always using this state for cpu idling.  The PM_SUSPEND_STANDBY also
- * uses this state and needs to take no action when registers remain confgiured
+ * uses this state and needs to take no action when registers remain configured
  * for this state.
  */
 #define IMX5_DEFAULT_CPU_IDLE_STATE WAIT_UNCLOCKED_POWER_OFF
--
2.30.0

