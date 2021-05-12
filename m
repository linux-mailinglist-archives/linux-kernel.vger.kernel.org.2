Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824B737ECE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384878AbhELUC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355432AbhELSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:49:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0DC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:45:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so12987731plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8E+f2v9QvhbBgVYDW+xO78Asl5jNnBHA79MzCC/Nhas=;
        b=J7bDw0Gb42knuv/5bGWUha8tmHo/XAaKNe92liTG6ZQwgtbmUqSHXcAo62HQMUsj2m
         /o0PlQXpwrRKXe6ZwQaDyYQaps2WtGJO7qg34HTldk8NJf672Yy1K5M8qWfNK6rQTGva
         ked/2CiwoZxYMIV5gUtUOEL+MmwD7bfaVGx11T63lBtNp9AOjiJFpsNT5ln8ycfbWLu6
         3w+Zr+bIT8wjOu0FdtCPYjZrQ58AfxbcYzahN4/IoE10ZrR0EPoXQmye1K5r+gw/QOWe
         VT4J7eyU5ILGajWs9sSmpcYikLltLV+Xbnem9ZhEyPOmxEDEve6TrSuroGsBdQATPl9r
         lJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8E+f2v9QvhbBgVYDW+xO78Asl5jNnBHA79MzCC/Nhas=;
        b=RMg3J8uTnTF39pXopvzGlc2jge6YVaLIfYb0NQ7b+PDsi3tgcx9QOeeHaVIs6vKoXc
         CJAUacu/o/7HQ0FZEERR97Dy56BXLPMEqxxTmzkzTwfn+ujietJkTqMrmua/Qc1fzdT2
         zuC7GsSbEnGG72TG9tjAuXwwsuxNlziKm78XPlvRXnHlF95M1Dernkyib7aLVENbZIMg
         fIHpcoKqPgK/7sDtwB6IP5bcUD8vZEIS5Bxd9ciPNmPOJN8TxCMyHWSQRRV9g4U3TOjj
         LJTQBERFuGMhagS7JXRRLu6lGIKOla5gxc322aKw92a2idShKHfJqOuHBFVdg1kxTLmJ
         oBFw==
X-Gm-Message-State: AOAM531CoDqRtlYli7Lgr/62fCYDDsHILQ4BgofewTiTcIam4Lij4tFV
        SGpz+04N+9GfLTlHDMZeKrI=
X-Google-Smtp-Source: ABdhPJy12DfRG5nZRsp7rm36qc2tCg3elZwyQpgFDCh4280CcUdTsjRL1HQlgtDqszqv54R2HjGSfQ==
X-Received: by 2002:a17:902:4:b029:ee:8f40:ecbf with SMTP id 4-20020a1709020004b02900ee8f40ecbfmr35791300pla.28.1620845108131;
        Wed, 12 May 2021 11:45:08 -0700 (PDT)
Received: from localhost.localdomain ([118.200.63.8])
        by smtp.gmail.com with ESMTPSA id i8sm367165pjs.54.2021.05.12.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 11:45:07 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        stefan.wahren@i2se.com, dan.carpenter@oracle.com,
        phil@raspberrypi.com, amarjargal16@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: vchiq_arm: Using pr_err and pr_notice instead of printk
Date:   Thu, 13 May 2021 02:44:40 +0800
Message-Id: <20210512184440.550116-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:
fix Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1b1356833b8f..ee759cb786b0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2192,10 +2192,10 @@ vchiq_get_state(void)
 {
 
 	if (!g_state.remote)
-		printk(KERN_ERR "%s: g_state.remote == NULL\n", __func__);
+		pr_err("%s: g_state.remote == NULL\n", __func__);
 	else if (g_state.remote->initialised != 1)
-		printk(KERN_NOTICE "%s: g_state.remote->initialised != 1 (%d)\n",
-			__func__, g_state.remote->initialised);
+		pr_notice("%s: g_state.remote->initialised != 1 (%d)\n",
+			  __func__, g_state.remote->initialised);
 
 	return (g_state.remote &&
 		(g_state.remote->initialised == 1)) ? &g_state : NULL;
-- 
2.25.1

