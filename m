Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC18336A048
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbhDXJDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhDXJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D9C06138C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s7so50599742wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1geH8MaSIgPsbNMxb2TdqgxuHhF/mDAA2khFi82Rz4g=;
        b=X0M7hUHsT8s32KzF8D5jLFxJI1uKbHZYMK4VTzfb3GyVgrpy3kcKohg0XBvPvVw0eZ
         KNdDe0B2r/yyRZjCwewLT+A49RiLOXK94ERjjD/xpLd8T9ukNac6RfBFSj0Q+3R9EeIl
         2QqbcFekegl7Yh5DOxqeBhZSaqlcTVxh4Dppmjwosf7OFVIpM28T45HX6dttSJUplT//
         CgF8SHCex/dHIHMgTwoXrdKFsMv9JM9pEW7Bg1oCEdY8IplQHMXrm9soigpvx5hG7X+/
         Jy5vxdSt7yIgipC53RA4ZZqxn+dvlQQ63ZO+ZaoALUWNLePBHZkZpX76uHhw/ppcTqGM
         ckWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1geH8MaSIgPsbNMxb2TdqgxuHhF/mDAA2khFi82Rz4g=;
        b=k6JhDbVMalQ9rnOjOfnvN7oeneL8TO78JZYUYTZKROp/H8ibJ25GccFp2Y0eoTgOb0
         ebdeM1A9l3PeAR1JSQM+3BP4Vy/WWLMrLiRU1DTrm7s+efBDV5OY/WAmrpvXLp+omwW0
         DXA2dHd6zdGg2pHAtb8cLSgM18tUduF+SyLtvBho1/+lFUTIf+xUmFV+4x9VRhNbo2TW
         zC5WMkO8/FGwj1+wXLR9yY00YzHkrJQXx6fAHRjQfFeaHiC0mNIQiwqkTCmyDxqG6kBT
         ikteW7npuXiNXApo4QrHozFjRkVGb6ce6pQVdtu6JICX9qyQBhGHMJhcw0UI9cnX/cl1
         PkYQ==
X-Gm-Message-State: AOAM5301IUuvauHylohLwPonZRFD69BhAfDQMP6jvr4EINW2QJqMjyTg
        HMeg3ZfM+zp7h0AyeZdNRRciFLkcGQioVA==
X-Google-Smtp-Source: ABdhPJx/B/wLoWNdmcJXM/Z0KGhsKXFxqObAux7bt0ANQojCJiWhFrWPpY8hwg30h7SjDw+hMV4Lyg==
X-Received: by 2002:adf:c541:: with SMTP id s1mr9760171wrf.370.1619254968873;
        Sat, 24 Apr 2021 02:02:48 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id y19sm12962286wmj.28.2021.04.24.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/50] staging: rtl8723bs: remove unused rf_reg_dump() function argument
Date:   Sat, 24 Apr 2021 11:01:51 +0200
Message-Id: <32d99e0a094cc59a35788c468dd3e20b486c9e20.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused function argument void *sel from rf_reg_dump.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h  | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 9dfa71580b2e..642aa556c462 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -59,7 +59,7 @@ static void dump_4_rf_regs(struct adapter *adapter, int path, int offset)
 		   i, reg[0], reg[1], reg[2], reg[3]);
 }
 
-void rf_reg_dump(void *sel, struct adapter *adapter)
+void rf_reg_dump(struct adapter *adapter)
 {
 	int i, path;
 	u8 rf_type = 0;
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6064de93c24c..fc187a4ed2c3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -150,6 +150,6 @@
 
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
-void rf_reg_dump(void *sel, struct adapter *adapter);
+void rf_reg_dump(struct adapter *adapter);
 
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index fa260714b588..5912915a7870 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2738,7 +2738,7 @@ static int rtw_dbg_port(struct net_device *dev,
 						else if (extra_arg == 1)
 							bb_reg_dump(padapter);
 						else if (extra_arg == 2)
-							rf_reg_dump(RTW_DBGDUMP, padapter);
+							rf_reg_dump(padapter);
 					}
 					break;
 
-- 
2.20.1

