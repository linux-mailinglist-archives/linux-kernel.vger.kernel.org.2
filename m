Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE24F41D5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349065AbhI3I5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348225AbhI3I5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:57:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A7C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 01:55:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id q127-20020a1ca785000000b0030cb71ea4d1so3751318wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5G1WMOdybTHNdPof1ZH122GKAZP+cXsQk45ElRVpsZU=;
        b=GoOsmq5GN1EtxJSG2wScb0HJI1K31aD0s8i1S58CV9IAjSqTOoqbIwQFq5GzIZJkZi
         yV/MFJ7knnNzWEEfNYjeMqc9S0soX2GRBQ1wk0+HxHrDuRfOEizC/K93nIv67CTtUEWa
         XQEq5qIOgcOGa2+QgtxzJjnFN0KKoxuV6jDVciWsZdh9dZQqV7GEQePSekGSWlpmD2gA
         x/Gzgztyn5yqWMCQI2DAglavk7Wb1cfPxsC3eBMublvRKO4+v7KHFlMrOR2q9Mt+WkU9
         ZZwVTigWsfPkmCESuj8RSh4L0Lxw4x/Pe0sWrFDMDQa3tl5sMyehFWbbVLI1LnkWhMwg
         6VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5G1WMOdybTHNdPof1ZH122GKAZP+cXsQk45ElRVpsZU=;
        b=Y0O9TOECxaiSX+icHH/XuBq712CxDRb8UmbckdbDISO5YEb/LkqTvXBXeZJGDeX9pp
         lyMu7sqmxLMUwujI9UtUZ51MEsrkvd93qA6zi5kj1xu6rlHs/CP81bZAG52o0evh8727
         fQycZcx46nNhQfgZqqqLtG1w85ArzNp964tDyja8R06TYRuASp9eAp9KLc5CDS0WGQCF
         ilvLZSQS9aQnE2y1u4PhY13HU2UoBDkmDweH25pR9YY7tVNkCAM8va/vsWyo5UClZaT5
         ai7LnVNaTJOi7XGOq2kwadMmYqyhaGHbevBSIXFbgLEWUFHDQjFkN83GTF5DVIIF35fT
         9MwA==
X-Gm-Message-State: AOAM533Brh6Bvz/oUUAVHUEd6t3gsTH5lrIZnNpDnxBAIdwfJnvpAvJg
        c7IQyF3jo0KMgi8Ct7HL58I=
X-Google-Smtp-Source: ABdhPJzulD8ClM0I6+u8cn14MvEo3HhZ5YtqwWWUEn21Xbh1JMk8ajm99cnF55gIrTIkuBpSt1vj6w==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr11160111wma.85.1632992150831;
        Thu, 30 Sep 2021 01:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::bfc8])
        by smtp.gmail.com with ESMTPSA id i92sm2311397wri.28.2021.09.30.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 01:55:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove rtl8188e_silentreset_for_specific_platform()
Date:   Thu, 30 Sep 2021 10:55:42 +0200
Message-Id: <20210930085542.10222-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_silentreset_for_specific_platform() is empty, remove
it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c     | 6 ------
 drivers/staging/r8188eu/include/rtl8188e_sreset.h | 1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c      | 1 -
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 16fa249e35d3..a16f10b438ad 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -6,10 +6,6 @@
 #include "../include/rtl8188e_sreset.h"
 #include "../include/rtl8188e_hal.h"
 
-void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter)
-{
-}
-
 void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
@@ -24,7 +20,6 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 	if (txdma_status != 0x00) {
 		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
-		rtl8188e_silentreset_for_specific_platform(padapter);
 	}
 	/* total xmit irp = 4 */
 	current_time = jiffies;
@@ -38,7 +33,6 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 				diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_complete_time);
 				if (diff_time > 4000) {
 					DBG_88E("%s tx hang\n", __func__);
-					rtl8188e_silentreset_for_specific_platform(padapter);
 				}
 			}
 		}
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
index 880c5792d5dd..5d7fec78a27b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_sreset.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
@@ -8,7 +8,6 @@
 #include "drv_types.h"
 #include "rtw_sreset.h"
 
-void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter);
 void rtl8188e_sreset_xmit_status_check(struct adapter *padapter);
 void rtl8188e_sreset_linked_status_check(struct adapter *padapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index dd47098ed1e5..852f8e0bbf64 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4005,7 +4005,6 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x0f:
 			if (extra_arg == 0) {
 				DBG_88E("###### silent reset test.......#####\n");
-				rtl8188e_silentreset_for_specific_platform(padapter);
 			}
 			break;
 		case 0x15:
-- 
2.33.0

