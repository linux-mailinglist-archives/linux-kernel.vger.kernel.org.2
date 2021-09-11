Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BB407856
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhIKNam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbhIKN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B2BC0613A8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3250168wml.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2fkjqvpR8abaNlEvVWIoS62+awuGE1JwFovkYfulF8=;
        b=ADj8dQFiYZ7CBnyL6edh+oUmxxayiVqMi763OuGXn0YtFGdCTKbNRbSbsKmvbcj8hV
         WpsHFCiuvh2FjwEDY6uobs4D3HZ+exkLfvIj8SmeW/7ItVqiKjb3vAgRVGsii7xHMdLS
         B82ZFpazlw1o4UDJIDTgaadpPUOz7efumu5mYEPHqqpxlPiN2EdPCl9OhjWgibeTa8Mw
         2mj4m0PpQLGbQ56uxrLfdltmHQexEVRviuzV+mZtsVjzeVxn6UFwGpDK9yt44QWWdNTr
         G1CmECpor9AKJqmabHSxKa4Jea8NQUIUKJBx/okQ/w+wv2vKT1YzokA40TfCBa209/jw
         qoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2fkjqvpR8abaNlEvVWIoS62+awuGE1JwFovkYfulF8=;
        b=gbrjUsMMeCLcwOLZBORWTCCX7GqsoY5QMKWtvymUzDxhu+UCYcNhvaok6dOKZPvOJT
         Dqs7kN0GTd3H1bYvU1//3Ey1JC4aLsbkGTyxoyXNCWsOAr+SZvHLhiZFr7MEEMCiaj8K
         5Eqe3cCCCUxN1A5R4NBGkDKXnYJTeZxf73VAzSS7oZGX1iUz9U46GuiA/mAQnRfmtMnu
         a+GpxtK1KlQ1TUiOftW5gF7fpyWwL+H/5c/ecuPtxudv2ZLsjE9f3KHpkKmH8iYZk4Ay
         jsci/awpL0AIl3xAl4Zo24MnKQLqjudTWWujvKCkQYS0IidVoQfV8njyczeHm/t1UfoT
         lkrQ==
X-Gm-Message-State: AOAM532tmLo8teisFeOGRC+c6IyopjpMM2B+g5Hy4rDrfeXpf/gCnPwr
        P7F7rvIElc5vjkm853kuZuo=
X-Google-Smtp-Source: ABdhPJx5gGCMJZGYOD/aJ7zZBaJDd/j0+JIZQb/8cWU/qcK3KPYFbMH+lkE6TMYrZKtuN1BzkH900A==
X-Received: by 2002:a05:600c:3203:: with SMTP id r3mr2717161wmp.175.1631366839836;
        Sat, 11 Sep 2021 06:27:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/18] staging: r8188eu: remove unused ODM_CancelAllTimers()
Date:   Sat, 11 Sep 2021 15:26:34 +0200
Message-Id: <20210911132635.30369-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_CancelAllTimers() is unused and it is the only caller
of function ODM_CancelTimer(). Remove both.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 5 -----
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm.h           | 2 --
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 4 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 011ebcdac797..0e5b14051ffd 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1409,11 +1409,6 @@ void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm)
 	timer_setup(&pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer, odm_SwAntDivChkAntSwitchCallback, 0);
 }
 
-void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm)
-{
-	ODM_CancelTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer);
-}
-
 /* 3============================================================ */
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 4e56ebf30e76..c97104c3682f 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -96,8 +96,3 @@ void ODM_sleep_ms(u32 ms)
 {
 	msleep(ms);
 }
-
-void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
-{
-	_cancel_timer_ex(pTimer);
-}
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index a100fdf87379..4a5a7c754008 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -1137,8 +1137,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
 void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm);
 
-void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm);
-
 void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
 			      u32 PWDBAll, bool isCCKrate);
 
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index c7784f540e7d..95e0303c28b8 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -99,6 +99,4 @@ void ODM_delay_us(u32 us);
 
 void ODM_sleep_ms(u32 ms);
 
-void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
-
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.33.0

