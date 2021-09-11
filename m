Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24B407845
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhIKNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbhIKN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33F0C0617AD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u15so806169wru.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYeMGLf/paO1aMrb4LJnUFnTTu3xI65XWSWcy7ds8yI=;
        b=q4eL2IrB4POMj+LK/sURlezK8xxh+rT/RkWo2MSbF9zadn+PeRCqu5d5SlDwVTLLca
         5M1rx2t+usicWFM0amxn01pNCQQ0WZxAgpj+tnXCA3PCjqsqCH35xdTS5+OxyvBLcqtd
         bBtbBsJJgjtiQwNVMHdmmI3qhkVH9H2vSNYbidr6xNI400BCB2HyIST4gqLEjVWSi3OS
         s8WKFaknVSqlBavTNLLojt2hTTnQQbavbT6kc/Pq4rB4gSs+7JEYBFncD3QhXkETwgAT
         H3XOIpim+jmHDgpIkxXJwaqj8gWKiCbfHBNTaEZgFCoDZ+a7xc0ZiH5Cxr68vfQDWxBJ
         LdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYeMGLf/paO1aMrb4LJnUFnTTu3xI65XWSWcy7ds8yI=;
        b=XrhqiXoncHsiBH7xVix6RtvSFvNsq5LqvBnkRJMkgZbyi8WkZakwxgl9lODXJ9TICF
         kTBl4WXzqfmAMAgk6B9yt6hWEPOeOTUE1GkhxrObbnh/GDd89cHwxwedOhfQF10SkxmD
         ENI9GwpPQI6iP3NrWj8mk3kZ4g/1vgGOaMyeZ2NK78kZMUrCOLIo591EKrGthU3HbRLh
         1m9oa56KG5CBKj7Bsq8vnChz2dA3J5GM6VZWMP4vqUHJjQa0p2rbnmePGotiMHV1LNoA
         Vq/A1bdQbEIrxinkxSsP6oNnshgV+HuyRrhuzqT+nVMJtHkAjHEu17QJt/qM+iNKMO1+
         CCrA==
X-Gm-Message-State: AOAM533vl8KUE483z0w7VMiCMPnRSYf76/WOyIKzauG0gyDVLKJjmErW
        9iEPpPRgGbHfuod21H1ZWAQ=
X-Google-Smtp-Source: ABdhPJwLPE27AEY9hVhH4pXrc08jCKY7oTPMCKm1X+48YTcBcJnsDgkZzi+Rn2WrPOosKcEoKJEZmw==
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr3010285wrs.273.1631366833597;
        Sat, 11 Sep 2021 06:27:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/18] staging: r8188eu: remove unused ODM_ScheduleWorkItem()
Date:   Sat, 11 Sep 2021 15:26:27 +0200
Message-Id: <20210911132635.30369-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_ScheduleWorkItem() is unused and empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 4 ----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index f3b6fb886550..c4ab858db29b 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -94,10 +94,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u
 }
 
 /*  Work item relative API. FOr MP driver only~! */
-void ODM_ScheduleWorkItem(void *pRtWorkItem)
-{
-}
-
 void ODM_IsWorkItemScheduled(void *pRtWorkItem)
 {
 }
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index dd14f465e4d8..65749c213cb9 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -96,8 +96,6 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
 
 /*  ODM MISC-workitem relative API. */
-void ODM_ScheduleWorkItem(void *pRtWorkItem);
-
 void ODM_IsWorkItemScheduled(void *pRtWorkItem);
 
 /*  ODM Timer relative API. */
-- 
2.33.0

