Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E449036A06C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhDXJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237527AbhDXJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7137C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k14so767042wrv.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSLHJhjopzWcP47W8szCHSpkYXOdx6ZRmSWKH8NfH8Q=;
        b=YnvoyRaoyo4VVzB6PqIf+ji0QQ3ClXrPQp3BAO2MNVgNDpkAHm5xsWfHjuIuUDUXuB
         bNRaBCzXYiyyiESdBGjRNyaBZoJYd6r/InlfEIJj22GYb7AoPBhxruoqer8Ftdx5ZXFD
         yhcPLKmBo438BoFtOxhF8pVxtxfrbAYxmbiw78PX4wYd1IMEutmpeo5PkDEHHs3Mi+ox
         Xr0DEtfyekkqNleExfBWdRYiGuKquDLviKkVbNHt89cq++6l581QSw0RWZuoRU/8he5p
         +TxXrZDCNb1dpdIrf1OAoudph3QCotehU4OIUchBCK1wcCVFu92mkFrw1TtbR6/AD5Nk
         HfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSLHJhjopzWcP47W8szCHSpkYXOdx6ZRmSWKH8NfH8Q=;
        b=N/3yz0mjSlsWdA3q50RVH86ly4n2Um8QuB7a3vqve40Fiyz9EABi/s0heikoKI4KUA
         8dEeLwFJ8qTx7Nm4wJ+1514M59Aej9mx00zOsjzixgK/bE+zqvSwNfkcjO5sMeG9yaeH
         JK740yJzB/f4eXsoX8XXfbzH1GQgVmwHPAfDyNl6W1rLgz8ZwI9nqopJ/9RBUoDW//Py
         m33cXAR1ZnOUAIN3lfMHW24Oc1BRjRgTt2aY4nBo2l5A7UR6v0VtxKKU6Fcb3ub9YQiD
         KU34X50lSPLiMHPppSrrMSrurPBvxMr6SJyLDgvb6/qS0RicHShzdUy2T3AtKAS6a6dQ
         6jJA==
X-Gm-Message-State: AOAM53084fqiLpStuCf54PVCwWqlP42vq3qKv1zOyuq1hpkkRpcA1C9S
        6+4+V94KXBEvWR6aOZB9W2kvzX3PBknOmQ==
X-Google-Smtp-Source: ABdhPJzvHaEmaMmOVAlrJAXcj1/lNsViySWTkGoQgcH3byHb1Na7txV/jIidHZxERp3D3QOM5MtL3Q==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr9621897wry.232.1619255029383;
        Sat, 24 Apr 2021 02:03:49 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id q17sm12225226wro.33.2021.04.24.02.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 44/50] staging: rtl8723bs: remove unused macros tied to _RTL8712_CMD_C_ definition
Date:   Sat, 24 Apr 2021 11:02:27 +0200
Message-Id: <5e4a8015eaca090e8a4df872760c9a1556ff551f.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to
_RTL8712_CMD_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 550cff9b1147..1a52200e525c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl8712_cmd_c_		BIT(26)
 /* define _module_efuse_			BIT(27) */
 #define	_module_rtl8192c_xmit_c_ BIT(28)
 #define _module_hal_xmit_c_	BIT(28)
@@ -17,9 +16,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL8712_CMD_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
-#elif defined _RTL8192C_XMIT_C_
+#if defined _RTL8192C_XMIT_C_
 	#define	_MODULE_DEFINE_	1
 #elif defined _RTL8723AS_XMIT_C_
 	#define	_MODULE_DEFINE_	1
-- 
2.20.1

