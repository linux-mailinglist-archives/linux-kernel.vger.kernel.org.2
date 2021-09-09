Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27941405EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbhIIVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbhIIVVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:21:13 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8025C061756
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 14:20:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so4526926wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjVEcRwSUp15VhRofJDWnHv3EIrC+ItI8VvG9mNn4Is=;
        b=bxU+T2wvN6781GavtovvUr9Lj3oaqHmLstpWaGelZ9C25kkLW5gF/2WhvtOGEfVgJ+
         F6CXVpk9+36JHYHbhIjYyn0pOy2sRanBnmWL5XjHm6ULMawIrkh1Esd4r5mLPek3d1lI
         3kUhNYPdlCBB46cMt/ddzvcOY392dMlES4hlx2u468MWKqRKATZl4gvuGg8Mc/CwonDC
         6CK7nXuOCRt6uR8aQnqMIRoKIX1vSASAuZd+UMzjDkiBWmDzEYTrKS/936urn3Nllhba
         F+W8XD2DDnYRxMEY2TaWkRNoh9cQehyRBhSqd8sbjZe3PzOcT5abmtEIY1+dk4PlYKSy
         BPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjVEcRwSUp15VhRofJDWnHv3EIrC+ItI8VvG9mNn4Is=;
        b=5S29NmLuAaVXaVcd1lB/lROKTVnMavjnQFVpUf0ZsVpebqvFfrYEUc2gZYtML6jZBh
         /NwJ4eJ+O2Qipm7CO69Kb70dGFyx2pP7ADuT3M9VxXIblXVEtte0C7AUrZzjIR9P6hjk
         7mgJxW2h9DskbC/QXlzBDbRXSfRudbCK3502nvzSrNapeotGJ9A4EPM/9yVtPy9YhCvp
         6J2rNPHxyKlgOT2aB8+ofrGoPZaQh7Oz8opnJ1W/8yPCn/bM1N+mbyDO6klH9gN4Pdts
         eYg2PI4sx3W1kP0YWYNqlztZjw66yIJqgOzSBJGaQoai0IhtbzB24h2aQgHW3IARLerv
         rCfg==
X-Gm-Message-State: AOAM531sgSJixRNKacMQtkXfr1nxz6sr1lFNojm/G2rC6OCc3CMKXAO7
        O51/UA/hKtIGl/wVwfh3h48=
X-Google-Smtp-Source: ABdhPJwxXGWNK1YLaOUsud7PSKcuxnzCNFBthMoYkcjNXjtHTvKKPE+Kp8EDuBRlQ8dkKOMhSifyyg==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr6166207wro.109.1631222401550;
        Thu, 09 Sep 2021 14:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id n5sm2511973wmd.29.2021.09.09.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:20:00 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove unused macros from ioctl_linux.c
Date:   Thu,  9 Sep 2021 23:19:22 +0200
Message-Id: <20210909211922.24872-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are not used in the driver, remove them.
Found with GCC -Wunused-macros.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 908022a17b3f..27fb1be036b8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -15,20 +15,6 @@
 
 #define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV+30)
 
-#define SCAN_ITEM_SIZE 768
-#define MAX_CUSTOM_LEN 64
-#define RATE_COUNT 4
-
-/*  combo scan */
-#define WEXT_CSCAN_HEADER		"CSCAN S\x01\x00\x00S\x00"
-#define WEXT_CSCAN_HEADER_SIZE		12
-#define WEXT_CSCAN_SSID_SECTION		'S'
-#define WEXT_CSCAN_CHANNEL_SECTION	'C'
-#define WEXT_CSCAN_ACTV_DWELL_SECTION	'A'
-#define WEXT_CSCAN_PASV_DWELL_SECTION	'P'
-#define WEXT_CSCAN_HOME_DWELL_SECTION	'H'
-#define WEXT_CSCAN_TYPE_SECTION		'T'
-
 static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
-- 
2.33.0

