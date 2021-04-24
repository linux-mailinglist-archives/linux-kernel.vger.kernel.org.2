Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47036A041
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhDXJDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j5so49707804wrn.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zuLarW/DVl6DwK0Y58hVKAVu2th5zfZnIaCNSJUZPc0=;
        b=e6ZKJwnLY4gzBIzPuaVFA528n/+CRTX1v2c8sZ0W9hYqI/6vJXa5EhEYi1bi8130S7
         wUXf3le7ANi+gVI8jHO7eQci3PyAUtDsIR3Tvyc8Mt8Jci6loL10gd7BtIlQ9qtKhcmE
         egdl1e6yIh0Nc1g5/87FysV+ko/m4Pb23URnC9+UPdTcGXILxClolcfWQPalWxde979V
         gVzSlUO00ExouwSSfKV8SbpFNrnt1kDn2lyXz6OWAq8BmL4me83iD3kxM7eTgr5LVJbO
         cS6wYHHjv09DwId10STfDZc8vdcPahT4hDfIrFUgsnx23FitM0lsSgJSx2x/yK8LypZ/
         /GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zuLarW/DVl6DwK0Y58hVKAVu2th5zfZnIaCNSJUZPc0=;
        b=jBx9x4TroHpO5uPKIpzpbZQeAKqfVIHOAvGRuuDlqL3YwbDKbyIH2kgXdGwgUY9XfS
         dMDZ4BhSVG0Bafe4tJK/d7XGJ08bPjUrlbyNgw41P2G8aHNczb8rUOtZqEIcG2bJwKob
         SQkYGb6NxZA8esO2yZrJtX4/1TtM7l6dBBNsZ+qeI1NlwifrgxPKAmMD9U5s0I8/7pJq
         f0Jp/SWg06tUJG41kcrZmn80s+q21vYpt+xElSGrQUlwytHtTvDtL07B7NPU6w/4FcQg
         Hr73njwM9WhqmnTmmTYPlldXPXyHByBIpoPMKs1nX02+T6WgwJwF3e0oyAaYMnSQxF4h
         6WAQ==
X-Gm-Message-State: AOAM530hiQMaa4N6eRpPIM+OYybyLqo1L3cqcoCrAFyKA2iZvfC9K1Zs
        KgirsghIHQM/TrwtNn3DeBvGkFmc5eKdEg==
X-Google-Smtp-Source: ABdhPJzPYUEwm/BNOUR+v3uYYdJxDosIVAe2ZQo2OinO2HQimsqaCenwoGCm3ThXk3xWoKt/TfaMaw==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr9793184wrp.368.1619254957221;
        Sat, 24 Apr 2021 02:02:37 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id z17sm12115834wro.1.2021.04.24.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/50] staging: rtl8723bs: remove unused log function
Date:   Sat, 24 Apr 2021 11:01:44 +0200
Message-Id: <397a4082fa2a49c67ac7d6869284334d3fa7bea6.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused sd_f0_reg_dump() function.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 17 -----------------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 79fd968bb147..0ee0190c09d7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -14,23 +14,6 @@ u32 GlobalDebugLevel = _drv_err_;
 
 #include <rtw_version.h>
 
-void sd_f0_reg_dump(void *sel, struct adapter *adapter)
-{
-	int i;
-
-	for (i = 0x0; i <= 0xff; i++) {
-		if (i%16 == 0)
-			netdev_dbg(adapter->pnetdev, "0x%02x ", i);
-
-		DBG_871X_SEL(sel, "%02x ", rtw_sd_f0_read8(adapter, i));
-
-		if (i%16 == 15)
-			DBG_871X_SEL(sel, "\n");
-		else if (i%8 == 7)
-			DBG_871X_SEL(sel, "\t");
-	}
-}
-
 void mac_reg_dump(void *sel, struct adapter *adapter)
 {
 	int i, j = 1;
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 23f4cb4711d4..ed75db1b16f8 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -169,8 +169,6 @@
 
 #endif /* defined(_dbgdump) */
 
-void sd_f0_reg_dump(void *sel, struct adapter *adapter);
-
 void mac_reg_dump(void *sel, struct adapter *adapter);
 void bb_reg_dump(void *sel, struct adapter *adapter);
 void rf_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

