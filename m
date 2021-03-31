Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E00350828
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhCaU0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbhCaUZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:25:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:25:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3003598wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gi9OUsUoRxjAcioEAF4TQW9mJ2fTHnHNzeSFEtVk1Wk=;
        b=FhezNaAYqaHT6VhiYQCDNq6ndWAbOd8uPtZWcvln9/4Ha0ctMuPzJr32kuGiG1RJ1M
         xWXaPh0XHlgJL3tHCQjhyzrRtx4R7n9If58CaT/jwZl1i+TRKFGtDcsbWB1YOPj3PD6A
         xp6r51Wufdf2+DHOM/tdy1zE1W8IZCuMjUFNsqvNGxkLwrZEoepPsRR3MjXT+i1ztSRV
         +N6O7vNuav8nphw+acRW8Zr1Uk16iIEu3YgcsxCRbeXhXaML4FW7Sg+7DA4hEIaZ8bA6
         r/tWEjNWSuU4660KSi5eiN/0Hd4R7Nq5wcGz9Vi3Df9O6wNTvVFLJ/nBQxibjfQ0Rds7
         KwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gi9OUsUoRxjAcioEAF4TQW9mJ2fTHnHNzeSFEtVk1Wk=;
        b=DjC0sZ9U8WyWFPyI1+obOVidXddBhkdTcKvtRCQJAR1qDPjKlc7SqexthNkyqKPWxS
         BjVgnE/RPGUvWrscrIaPSB0EbaQc8DgP/V0K0QdMlR4y9CBE0d72c1RwxYddot87ntGO
         7n824Yp4+mt1rJ/Iyk0A8WhPRxCAAzCMU9ZIh1FxuEzwJoa0DLrcmFd3J0hbpNA7VYn5
         NG0gEoifwcc18qm+uQLEyHWtKts5p6CeQd+7Wh5eUYI0yWzVy5R9ps45baC4us3iAv6g
         MervelWH76T9ENgEiwdnAD80NWcD3pfCEntwwAwncWYsqjr/CC7Tv1qqAY8BcMCFamvZ
         La4w==
X-Gm-Message-State: AOAM532y4G7KxEAlBGytAPM8P4YnCqDP1+uXJhXZpCMgpQ8ZOYUc1GNk
        DEpF14FZjC1Fn36Wya0QbhY=
X-Google-Smtp-Source: ABdhPJzqSgyQVibalW7B3aVhjcAgmvHwW8HWc7q4lM9+ie7AzcVPs9VcvFZsoFPnVCxpDbyCELPK2A==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr4701240wmq.18.1617222331572;
        Wed, 31 Mar 2021 13:25:31 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:87e9:fdd6:2b7a:c720])
        by smtp.gmail.com with ESMTPSA id u3sm6138637wrt.82.2021.03.31.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:25:31 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: greybus: arche-platform: Fix ending '(' warnings
Date:   Wed, 31 Mar 2021 21:24:45 +0100
Message-Id: <20210331202445.108678-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch check "CHECK: Lines should not end with a '('"
in arche-platform.c:80 and arche-platform.c:184.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index eebf0deb39f5..e374dfc0c92f 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -77,9 +77,8 @@ static void arche_platform_set_state(struct arche_platform_drvdata *arche_pdata,
 }
 
 /* Requires arche_pdata->wake_lock is held by calling context */
-static void arche_platform_set_wake_detect_state(
-				struct arche_platform_drvdata *arche_pdata,
-				enum svc_wakedetect_state state)
+static void arche_platform_set_wake_detect_state(struct arche_platform_drvdata *arche_pdata,
+						 enum svc_wakedetect_state state)
 {
 	arche_pdata->wake_detect_state = state;
 }
@@ -181,9 +180,8 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 						WD_STATE_COLDBOOT_START) {
 					arche_platform_set_wake_detect_state(arche_pdata,
 									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(
-						&arche_pdata->wake_lock,
-						flags);
+					spin_unlock_irqrestore(&arche_pdata->wake_lock,
+							       flags);
 					return IRQ_WAKE_THREAD;
 				}
 			}
-- 
2.25.1

