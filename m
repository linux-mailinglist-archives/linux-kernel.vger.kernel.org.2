Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CEF35E111
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbhDMOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbhDMOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k26so204801wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXx9LUIjVsmXNCgsOPYQWPc+fsuv7zkfU+hMAJWj5xE=;
        b=Xn3p3r977PS4h0KsOTaf5zXgkYdGHCsrVtwKoY4xz1Gq18hveixZLRoXPEkdvvEQw1
         PVIzRFY/lROV5qJREmDIhsmkwEiJkWGzNMTGFyIUXq2er3QTVOEmifBO42suR4WReE+b
         T2xoldIdhthDIEvjwxRgx67CxSKX4P1mz/WU1FprlFZprDRsgDjaMYWwYR4dcfhyQEZr
         wIwzPN192GUeNn07V4X4Ul49NXjIWeT6U4hlMZ3NMVVJ5ImLom5IDlRFQwx6OyHvKi1E
         dxhhPiGjPHCmFtrC1u1R8BhBCpyOd2Z+8ap+kNy9l/t6G4Z7f0p2BQ4cOOND24+72HGV
         //Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXx9LUIjVsmXNCgsOPYQWPc+fsuv7zkfU+hMAJWj5xE=;
        b=LvnpMDRxzbowhQzTnmCH2FXgyK/hU0qZKgzIttMbFWfmWj0w/DflEfgK/7qT8D1LKq
         KwCfUTeFZaNtnUhthUq+DFo/uClUXjyT23dSBZCeVn6JvqhxOtYmarX8zxJdxipJ3+ti
         CrV/y82KOKHtrZ+h/fLcnaNBJbx1AOkmnkUvPB9+GavyBHrhjl+/do+p/83Y6kv8+ZSx
         AZ1KDaNEuKTPW6FASwtCkgzBLWctWjG8T1831tU2eQ2PElb9iQ554OcRmfGUl15ImTJ1
         6VKeuE8BsB6JKOXHCQ9ojsQf4Csx56xHefbqtpTmA8YrIvj/cqkQQU+8Fd+UoMTJ+FPN
         A3EA==
X-Gm-Message-State: AOAM53324aJhEchBiO3oeXGVoJ+rlXmnH1J/QKCEliIoVzN0j5HiDA83
        J44w8xQ/1RSOxHzr8HDsvcXf5qXhDWHgYQ==
X-Google-Smtp-Source: ABdhPJzuo31nctLBPDq3bIIbrfjlIWxWew+kmiyvGSk4vEyjOwb9ZhCiTY8KDnB0i6iMFJrRtDAhig==
X-Received: by 2002:adf:e608:: with SMTP id p8mr20379184wrm.249.1618323053681;
        Tue, 13 Apr 2021 07:10:53 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id n2sm3115865wmb.32.2021.04.13.07.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: rtl8723bs: put a new line after ';'
Date:   Tue, 13 Apr 2021 16:10:40 +0200
Message-Id: <686dff07c78a1be994c56083a4640d1b66a1f34e.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post commit hook checkpatch issue:

ERROR: space required after that ';' (ctx:VxV)
232: FILE: drivers/staging/rtl8723bs/core/rtw_odm.c:160:
+		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg
			(adapter->pnetdev,

This was coccinelle script output coding style issue.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_odm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index 084f6ae040ee..f4a0ef428564 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -157,14 +157,15 @@ void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
 
 	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
 		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
-		   "AdapEn_RSSI", "IGI_LowerBound");netdev_dbg(adapter->pnetdev,
-							       "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
-							       (u8)odm->TH_L2H_ini,
-							       odm->TH_EDCCA_HL_diff,
-							       odm->IGI_Base,
-							       odm->ForceEDCCA,
-							       odm->AdapEn_RSSI,
-							       odm->IGI_LowerBound);
+		   "AdapEn_RSSI", "IGI_LowerBound");
+	netdev_dbg(adapter->pnetdev,
+		   "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
+		   (u8)odm->TH_L2H_ini,
+		   odm->TH_EDCCA_HL_diff,
+		   odm->IGI_Base,
+		   odm->ForceEDCCA,
+		   odm->AdapEn_RSSI,
+		   odm->IGI_LowerBound);
 }
 
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
-- 
2.20.1

