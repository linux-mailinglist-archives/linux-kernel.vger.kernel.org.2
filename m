Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABAB3DCDD7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 23:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhHAVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhHAVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 17:04:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09263C0613D5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 14:04:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso10574394wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q60uXeQTP2Txfa0NFG78DG60WBiDi0/WKw762Gg42iM=;
        b=kSjbo0aNgF7p31Zy2G0sMg2MXD//HBQNueCr8rIRLHtr8llYsteoY1Fw3V5Pmhs+wA
         UODX86lQRtUmIp7yWEX4IfvIT923V/fP72LnX+QFYBZdUMEJReK9/rKWTjiN5T3lLkfd
         WQCLlQ0YU9TxWt/Bui+hcLdMd3OtaKzl+72chJL87Ahe3JB9N/qa5yyVej/vhhCBixYZ
         zw5bj0KZENtO6JeAmq5Rnx3GCiBswj0pqNRZD6yC6wseIYGHF3Prb+vtV97u7FnqS9wu
         GGIf5r873blKED3ndE2wiHkxEMxdbyUxLfolEsoC90bEHQ79kZf5ZaF30hbhpzbYuxyo
         PcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q60uXeQTP2Txfa0NFG78DG60WBiDi0/WKw762Gg42iM=;
        b=kMz9/id5jfYwLqWA94l53necFXyRmVxBKldIQXg6VLYblXatG2k+NW38jeC15kp/2n
         kvzWCiys2jROV20m/geHLG527uqi5rF4LZozSUcc9pOLLiCcNn164ZBHwqFnMPmNWnfO
         IB32oqPvhYzKAclOn96mepfC1HvnLJHS2jszpF4049fGahZ4ikIx7uriK5Wp0nrpaYzv
         EzHpBg3MK3Grst0K5CoiqHbD69KduEUKj6g+NcOAJnU2Q6WC6HCCDrKyf8W/F2xOoUJ5
         JQfHirWrEi1ReWpctHlMGuVj5np+ITLEYMtfV3THd+v73bocYi+6u5oAqeqzVmgElKCF
         hBQQ==
X-Gm-Message-State: AOAM5305kUTd+90p+b76IIRGcASIBohmDZQgNfKkv8sLRFfUx6ldo1on
        IKdS9zXTD5SE8TWu4EBsp48=
X-Google-Smtp-Source: ABdhPJxY8AmkJlB+piBlfcZnffkEreQvzhidAaoVuKzLFVwqaqSs8jNZtSsKDOe+mIsRdKQK1FqCpg==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr13774388wmk.124.1627851873717;
        Sun, 01 Aug 2021 14:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id f15sm8629709wrp.12.2021.08.01.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 14:04:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove empty function odm_DynamicPrimaryCCA()
Date:   Sun,  1 Aug 2021 23:03:54 +0200
Message-Id: <20210801210354.25218-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801210354.25218-1-straube.linux@gmail.com>
References: <20210801210354.25218-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DynamicPrimaryCCA() does nothing, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c              | 1 -
 drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 4 ----
 drivers/staging/r8188eu/include/odm_RTL8188E.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0bc836311036..08ec1e18b3f0 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -211,7 +211,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 	odm_RefreshRateAdaptiveMask(pDM_Odm);
 
 	odm_DynamicBBPowerSaving(pDM_Odm);
-	odm_DynamicPrimaryCCA(pDM_Odm);
 	if ((pDM_Odm->AntDivType ==  CG_TRX_HW_ANTDIV)	||
 	    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV)	||
 	    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 03fe29e16f1d..792284eac01f 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -342,7 +342,3 @@ bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
 
 	return	PrimaryCCA->DupRTS_flag;
 }
-
-void odm_DynamicPrimaryCCA(struct odm_dm_struct *dm_odm)
-{
-}
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index d6718186f2d6..776a8a6dab68 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -35,6 +35,4 @@ void odm_PrimaryCCA_Init(struct odm_dm_struct *pDM_Odm);
 
 bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *pDM_Odm);
 
-void odm_DynamicPrimaryCCA(struct odm_dm_struct *pDM_Odm);
-
 #endif
-- 
2.32.0

