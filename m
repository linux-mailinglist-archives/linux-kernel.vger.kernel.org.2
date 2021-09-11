Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A80407841
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhIKN3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbhIKN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC295C0613D9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so3245489wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1XjQypb/ml0GfH6ntHdvBBP2tDxlOwUZUZ6PJclaWc=;
        b=AwBQcCqDmEBkhwbTKbRcklMzO5PvasgT5Dj4W+mhpSzEcWxxMIBNtwomG6czMKC5mW
         5yq8RGbrtbVN92hTcvQE515ZXyIIZbUjy4PgnZG0p9Q7ls1OxKpR5g4nlaFZ9pd6RYpy
         5JqZsUG44t0LWk/mM54wBeu0/NBF+mW/90yjl6zvzPENTxnReaxScVzPB4Is3JHeBbKL
         ctLNfa0M1fEYSGXhvnJKWqVwD0kSe8IDzKifYsePXFrAWTiT14WNBnsSIe+6l4fhRYpt
         jiFGW5ztcSB8gnskoOZXnpUW3var2BM1vo70hrMl988vkjkcL++MNd+H5wB//n1JjN/l
         dZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1XjQypb/ml0GfH6ntHdvBBP2tDxlOwUZUZ6PJclaWc=;
        b=IjfPFiR5BDBATEuRRcU4O0qS5aH4ml1MpHXec/kmyAuUKkCW/H7zRTrx94hqM+bHD0
         DsQmE0uyIMmBtSr+EubfQC/rfJWp6HgIisKIAUHlH8LAkFEhR3RwosXd5tpZ0sO80SyN
         tjB1+MnnOuhIK8/c58fkWfx8mVzn7JCTrXs8Ggz/5J5W38gZ3PavdHsc9azVV63CNcMR
         aElF9Q7sO6YY+xdgAWPJi1CB7c1Be8yru2levIbp2gAweV1Jxi1wPfPENJd8Vaa+rJkW
         DYd8QjlMR8YcfZmsFS49PJUKfrwgB3UrEoY7QYtiMh4WwMLlM9VX7DOxdTlLfRRESZVK
         x9zA==
X-Gm-Message-State: AOAM533+/NnmBuh6Q4BdiJGABnhgOAwVZBB7E+U7kGiU/DquprW3Ru0x
        3xK56G87k3SWrllO7nDU9Ag=
X-Google-Smtp-Source: ABdhPJzlXnnKRWOEckr7IBBL8SKCxSCHcQTKMRpb8FfBY28mDb9YWOEQG7UEUE/jkwiE9lf1NZ7S5A==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr2683566wmj.70.1631366829346;
        Sat, 11 Sep 2021 06:27:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/18] staging: r8188eu: remove unused ODM_sleep_us()
Date:   Sat, 11 Sep 2021 15:26:22 +0200
Message-Id: <20210911132635.30369-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_sleep_us() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_interface.c     | 5 -----
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 7b36584f0e6d..80c8a18f3791 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -141,11 +141,6 @@ void ODM_sleep_ms(u32 ms)
 	msleep(ms);
 }
 
-void ODM_sleep_us(u32 us)
-{
-	rtw_usleep_os(us);
-}
-
 void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer, u32 msDelay)
 {
 	_set_timer(pTimer, msDelay); /* ms */
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 9afc5178955f..45caa73c0af0 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -119,8 +119,6 @@ void ODM_delay_us(u32 us);
 
 void ODM_sleep_ms(u32 ms);
 
-void ODM_sleep_us(u32 us);
-
 void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer,
 		  u32 msDelay);
 
-- 
2.33.0

