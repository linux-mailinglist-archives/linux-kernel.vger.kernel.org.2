Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D336A046
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhDXJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbhDXJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11755C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so50701996wrr.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pW8S2qDA8lfJoWNaoF5GHjJlm4hypdByKozOq82+4Nk=;
        b=SBSurnZsbLdTwh3Ik2x6C1ah1gSig3IKceI8bKVqqbxHLCUH+g4pxQIl+iHZCLtEsI
         rO9XC+RDbTVS2B0wkBaxfsUSIJnuyRpsvf6wTV+ScS67XQtfSDb1hnQA696kn8mfwvuM
         tHU38+mI8bGxfrTVtp5fw8fJymjFrcarZk1/GJKM4q0R1nSqGQKcS47GQu6jQTxkZbUn
         qOd7XmhqOeuvCb04FqFMOR9BYcdc+hQyVUOxgPutyFft5gRpOdEui+PGUKWesCHNE+7b
         Q34YsR+iwNMhNSWeXAm7tXFnHkyidcDn/p8mjZ7sJIuArIsJ06UGL1mKs+BWeRkCGYUE
         gaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pW8S2qDA8lfJoWNaoF5GHjJlm4hypdByKozOq82+4Nk=;
        b=gztnCvm1FpWbA+CeFvS5dcY9icw8JvjO8iIv8pvpBEp9ed6bFuWMwY1I78Utb6mVvo
         KkeW+id/LsHP/L7uuMv47xcUnHfYdzV3W/BOz1QzMfxopTKpKgIllCJlMbKRz5hqjJ5Y
         fLknQAk39zuNn6hQabX+ZjJmh2Vv/5Mz5rYKbIBEpOEPc5IHMjWzKNYquStTO+fy6Cgr
         CXGAXS/910m15yLDtLvt1i/c8/6iVa9Gdcg+gJqqAXKSnRd8bgkwoAw1WZggWs1a+QDH
         +O0nPogNStP6aEwSo4Z8FgeuVC/ZWoqgCQeZA3mCeQL+G8Jwn5S0oGdIFubeQnQOJDA0
         ia9Q==
X-Gm-Message-State: AOAM532aZhaj6kIT2WIWoPt/q6QD5NPnUoJnzS2f/LSlgjNcDT5ufBmh
        +UzGixeQLI8XQl1p6WEmkoNi7aSxMq9BVA==
X-Google-Smtp-Source: ABdhPJxQbafWckPtQgjy159SW4/6uCWXNerGBr/tk93gOH60fYTRZsb2zKuIZwjjHfiIZdkT4yLZuQ==
X-Received: by 2002:adf:fb07:: with SMTP id c7mr9804836wrr.88.1619254965683;
        Sat, 24 Apr 2021 02:02:45 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id n16sm1587426wrp.50.2021.04.24.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/50] staging: rtl8723bs: remove unused mac_reg_dump() function argument
Date:   Sat, 24 Apr 2021 11:01:49 +0200
Message-Id: <2ae03ee765c861d1fd4237af7b8d11a918be0d76.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused function argument void *sel from mac_reg_dump.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h  | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 0e13a226e9be..ad3cdbe45e55 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -26,7 +26,7 @@ static void dump_4_regs(struct adapter *adapter, int offset)
 		   i, reg[0], reg[1], reg[2], reg[3]);
 }
 
-void mac_reg_dump(void *sel, struct adapter *adapter)
+void mac_reg_dump(struct adapter *adapter)
 {
 	int i;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index fdd5933a3d5a..eabc21d2b689 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -148,7 +148,7 @@
 
 #endif /* defined(_dbgdump) */
 
-void mac_reg_dump(void *sel, struct adapter *adapter);
+void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(void *sel, struct adapter *adapter);
 void rf_reg_dump(void *sel, struct adapter *adapter);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e98e5388d5c7..7951c362d664 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2734,7 +2734,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0xdd:/* registers dump , 0 for mac reg, 1 for bb reg, 2 for rf reg */
 					{
 						if (extra_arg == 0)
-							mac_reg_dump(RTW_DBGDUMP, padapter);
+							mac_reg_dump(padapter);
 						else if (extra_arg == 1)
 							bb_reg_dump(RTW_DBGDUMP, padapter);
 						else if (extra_arg == 2)
-- 
2.20.1

