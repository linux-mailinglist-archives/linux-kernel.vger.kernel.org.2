Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06F35E114
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbhDMOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346287AbhDMOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so16637086wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHxXKOLbXXf4jCbvUXo0q9HvS5LSluPLIgJqE3tNdY0=;
        b=StmWosAqmPvyTpA5E50Wou71XRa8HdKzDscM5ABNr55qfv8aEjc2BPOffT9X2amJhb
         sgBJCLuHUVVf9QQ76RbD6uBdoAllOKyWok59IPUrnqz35qpESAQbs15fbeKxdCrrmAlE
         +aaqvtWdoPzfAP9zh5pa+z9x+ERvylFuTGozBccJt+5pY/K8yLfqB0p51hK5gYVtUc2R
         9Lqu9rphDH4blILBRJa00Ska+1Q4wbRMLEmQ/mekNv1cglMpcbRQ9kL4E0xx1ExPZcGP
         5j7rSUJ+O14RGpKVBKpgH/QQmrQKi6drlJU6aL2DMBqskajrBaPJep1JIcq8+iKW5YKG
         lwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHxXKOLbXXf4jCbvUXo0q9HvS5LSluPLIgJqE3tNdY0=;
        b=jtKUBdn61TaR42WdcpH1IzB+u62Uytoj1dxbYEULIXZBeNXKXVF+NdKUdP17/AFDTx
         I39drPWtE5QNBVpCgjK472P34b2OiwGA7BrnpPDKGnC6UX29oOHjj9ZlmT5u198dNqox
         cI+J2no3O4m7fLO8KvKdTROe53py1b424/vRVKSzq8TuVrh1kqigtGFluGVPJWztKHN5
         yopaYCMQPx2lmYVg/HjHi0vgtnIkBFbUMQShTbBxYze3aGKFRCWXFuE0ddiKkaw+A4pf
         RmZyoyec+XLPIOifGbOQdc+Gn5tZi7PBHAIAHNIekmJEQoGlyvbz5K1wIbWKVPA4xMyq
         XoZQ==
X-Gm-Message-State: AOAM533mCvXUMQKXbhFAZ5JN9c6AvlnFYvguY85RsI3btHk1IilaAySi
        pQKiWaag2mN2uVDXzHVu+63cgb6yXsdMuQ==
X-Google-Smtp-Source: ABdhPJyZ3r7quLihI/5dLMrLQxHkuI1Sn0dinWQuzqJuxaHf6fgOZMim1uOtoBdV0940OBObvuyojA==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr38174219wrr.140.1618323056943;
        Tue, 13 Apr 2021 07:10:56 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id s83sm2610974wms.16.2021.04.13.07.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] staging: rtl8723bs: remove unused argument in function
Date:   Tue, 13 Apr 2021 16:10:42 +0200
Message-Id: <c1924d9369d4b2ba6224b3d280d6087f2a281e5b.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618322367.git.fabioaiuto83@gmail.com>
References: <cover.1618322367.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

removed unused 'void *sel' argument in rtw_odm_dbg_comp_msg()
function, after DBG_871X_SEL_NL replacement.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_odm.c       | 2 +-
 drivers/staging/rtl8723bs/include/rtw_odm.h    | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index f4a0ef428564..f6b73a2a0270 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -90,7 +90,7 @@ static const char * const odm_dbg_level_str[] = {
 
 #define RTW_ODM_DBG_LEVEL_NUM 6
 
-void rtw_odm_dbg_comp_msg(void *sel, struct adapter *adapter)
+void rtw_odm_dbg_comp_msg(struct adapter *adapter)
 {
 	u64 dbg_comp;
 	int i;
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index 263e92cfea96..94fc68a5c424 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -13,7 +13,7 @@
 * This file provides utilities/wrappers for rtw driver to use ODM
 */
 
-void rtw_odm_dbg_comp_msg(void *sel, struct adapter *adapter);
+void rtw_odm_dbg_comp_msg(struct adapter *adapter);
 void rtw_odm_dbg_comp_set(struct adapter *adapter, u64 comps);
 void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter);
 void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 98c9eb399ba7..816033b6847c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2622,7 +2622,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x16:
 				{
 					if (arg == 0xff) {
-						rtw_odm_dbg_comp_msg(RTW_DBGDUMP, padapter);
+						rtw_odm_dbg_comp_msg(padapter);
 					} else {
 						u64 dbg_comp = (u64)extra_arg;
 						rtw_odm_dbg_comp_set(padapter, dbg_comp);
-- 
2.20.1

