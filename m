Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2435F361
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbhDNMTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350808AbhDNMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:19:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A085C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so15934162wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHxXKOLbXXf4jCbvUXo0q9HvS5LSluPLIgJqE3tNdY0=;
        b=gJkkFRfNXLvG4jt+tAedtlI9HMvzaW04dmh3umM3HcL8YBFQ+HkYbIUYSYA2P9GnMv
         1u0CWq7g/42eETBBi5xylMZwd6YsTRCjNW/l4Ld+PNkBzcs+BuJ/nLczCUaGwAHZ2KfB
         UmxMlJOpTDs1KNwP8+QZlKBZTo3Now9+/+3Emb+bX2HylDkKipWSktda+6sPbhK/77aF
         2sSJOgAHyV1Jd+9P3jYmzWvD05vHKyZiVc8Vyb1y/VApvIPJk666HGZnMYRN8Kq2Or3D
         ys1z5kYexo9d9tiosq9ZtQr7YSM8wwe8QhFGPVE9p647Q5RujHhPG4FRUdAVeBUTyMw4
         isrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHxXKOLbXXf4jCbvUXo0q9HvS5LSluPLIgJqE3tNdY0=;
        b=ApbFetg7zmPdrmJhQ21kdiJwyqWZD7D8khIZqHma3K/GxSQYdFkqYUOd0/G6yPkG/P
         gZ4ZEF5xgrKKMSj+CUyaPFDJuIEYGQjD+V34kXruCVphSZ1bEk4+PaWj2A16GKxP9Asb
         J1aOw9hE3xvoPe2P+1N6NqwMuQkbuXClC9spYJlrdYDigv8vwcTpllIf2nn6eH4pwUu+
         zK4ig2iQU8AxfDBU2tLnSveUnnEuTO/VjjsV8wf1JhngAvII2WOTPG6XAmJX3A3rG+Oq
         7g0Vbrv22zkZRlvkpAA1h282qsbcvPcuCFk36Z+/RtMcdq2byQ4MQd0A9gD6Xn+dQKhA
         vdng==
X-Gm-Message-State: AOAM533GfzGej++G8vpxi8KI7XGLyRTGGM9SUYI76pL04gPolZN7yzQj
        TFV1EWl3iUnwFzRfuX7mn1wSZPRKHgZ5zQ==
X-Google-Smtp-Source: ABdhPJyBJ45HRcrWjomGDuwO2FOKRJs5IPRgT/Iu973clDRIKmdk44+jguGbLV4OapK0PkPplq0FCQ==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr12208810wrm.380.1618402737189;
        Wed, 14 Apr 2021 05:18:57 -0700 (PDT)
Received: from agape ([5.171.26.216])
        by smtp.gmail.com with ESMTPSA id u9sm5237502wmc.38.2021.04.14.05.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:18:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: rtl8723bs: remove unused argument in function
Date:   Wed, 14 Apr 2021 14:18:50 +0200
Message-Id: <1bd83b936584432fdb09406f26ed8a8b66cd4c8d.1618401896.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618401896.git.fabioaiuto83@gmail.com>
References: <cover.1618401896.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

