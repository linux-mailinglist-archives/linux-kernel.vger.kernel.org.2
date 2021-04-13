Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD135E207
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbhDMO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbhDMO5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06425C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so4043558wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXx9LUIjVsmXNCgsOPYQWPc+fsuv7zkfU+hMAJWj5xE=;
        b=ccHwQ6zuzZGYRDZ1tmjcqXpBWQMH8dtQiXGPOJuDssVxRrZ8P0YjuW51NG/rXeHOCE
         2eiyOPx/qqOC+saqyoSi/ruLZkuECMSRBkT+opwhBNE9pHPdBIFKXp2+5/4/XpetG09f
         0p882RPrsheRB8ZMprHM9+R+zP/8Stb6YGaBHrrumcTEt77PAyoC8l6miehTxYrULpHk
         6UO1rUFkWfHw4t9uoolcTa2Z80QNiPuZh74KEKnRTrgQTBoSZJy0PQ5lclZvbzyseY7l
         SmTpEp91ER5JdulezSWiqqoe7dJVxBSaP/ihyxHICVNDT307uUUth6SMReo96FgSwnoR
         4vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXx9LUIjVsmXNCgsOPYQWPc+fsuv7zkfU+hMAJWj5xE=;
        b=lA/NuqZwsHL+Ell1VgOF3JwHSGUp3swNykyPFkzck96cEbRQhIWkds06/ea2GUff0U
         pLFkP/bHGUKBaxyz2JTYoO4L87QAsG7i/hkudOOIayfVQBrOd3IpQaK+4jzV5EiwXTv1
         qoMKAkImEMOIc886bjGoO0W7S973xswomF/XG4AFLiFifk3G9v+IofylLtis0Gr03uAX
         9PNeViv6YDRAcpEVcIZ9jIRi8/2wXda1q1VwB8XU/C40WM/zr0pCf00lpImLZ5hSwvnS
         OjbDGtuF/Nl6CC4YmgvsKHbLcFxHhfmbpJsCdwGTBEdAXjsk1bndBbtPPp0IB5hQgcdS
         y8Tg==
X-Gm-Message-State: AOAM531a/dTNSk9mho0Xu7W8LfhwU74hMyr4sfS7zU9i+PimiIEuC62c
        BfWmsIJP9HrGeuA77XYdHRveUprDHVzEJA==
X-Google-Smtp-Source: ABdhPJxHVHoPDCjWVTD9p9hWWDvQxPH8Mw9K7NxbPUBXEo9wiUIohDz5iapxfPHZGcmJTdkclUyD9w==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr36804602wrw.256.1618325804511;
        Tue, 13 Apr 2021 07:56:44 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id c131sm2761809wma.37.2021.04.13.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] staging: rtl8723bs: put a new line after ';'
Date:   Tue, 13 Apr 2021 16:56:33 +0200
Message-Id: <7e796fe7a5a370d055be201204dcac14f09c974a.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618325614.git.fabioaiuto83@gmail.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

