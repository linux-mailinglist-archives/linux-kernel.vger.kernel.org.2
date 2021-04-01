Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0C351178
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhDAJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhDAJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:08:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E3C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:08:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j9so1028354wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUJdzQc6vGqaF/tH9fjrVo5h9ptifyriz2mlBFMVazk=;
        b=MRR4QO5AiRIwwXG4y8t9iiQv4w64a7HkwnanCJD7qbLzg9B388whJgj8We6h0L6J0J
         yV7oEcEd23/V6iu9M5EA3bMUuydsVIYord96BohBOFT/u90NgQhFVLBiO81I5QbYLBtb
         WYftikXIomG3z5w16KyreWl5XZGTzt4lt7sgCbHlsrlpPouiFzGUgAp0gEQiK8mmtHB7
         TZdg/FHHHfGlOqnQ/yVGnilWnXwb47xhilA5FUehQS4v0c237hGgJQlwhIzAEZN18tOX
         sEyxPPm7b0TJ6p29EIWC28y55Lt0wyTr4tBXPaS989eRa8ycmJMykgPefijW1SQkApSR
         cH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUJdzQc6vGqaF/tH9fjrVo5h9ptifyriz2mlBFMVazk=;
        b=VYCQoxMuB3g771W50D51fT3OGgHj7lS7s7GMjE50Wbo6N/+DUns+rfhcfHBqxYKJkm
         g24Dhx38CuAy1l1O67/DRQIBSELWsh2M0Ti5Oq5tmmZVgfVQjmvOUWovhFFJpQk/OpYg
         hCoLZgA5hSisCPQspN13FIn1wzOiD+77rfoOdib6/+A31paDCBgYnDmH99ZNF9XukOlp
         GDOkzxWaf4jVEPCAl8DiAlpQhRAY4IKGETjoGlo23ADZhf1NM2G9nYw6lIcenjPoeb3N
         R44ziiXu9WQZ/BoA8WmCqdYDSjB5F28lSLfwaG4D9aNf+4l+do/v9BgPrC2L5aeM5rzc
         fWfw==
X-Gm-Message-State: AOAM533vOcf+sRqilGejpj1GeFvKA9nQzKcZanP5pa7Y82Bh2Z7Q1QZx
        mET3g4JgJd6xeYy8oFgyjok=
X-Google-Smtp-Source: ABdhPJxdgy8DJO+g1gU1IIdvU1b1sjuvWBitFUneRSVeAtmNRykqv/kB6WPB5qc8GdpOe/0yZeuIhg==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr8370069wrd.47.1617268111249;
        Thu, 01 Apr 2021 02:08:31 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:87e9:fdd6:2b7a:c720])
        by smtp.gmail.com with ESMTPSA id 135sm8193856wma.44.2021.04.01.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:08:30 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v2] staging: greybus: arche-platform: Ending line with argument
Date:   Thu,  1 Apr 2021 10:07:54 +0100
Message-Id: <20210401090754.116522-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove checkpatch check "CHECK: Lines should not end with a '('"
with argument present in next line.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
Changes in v2:
	- correction commit title
	- correction commit message
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

