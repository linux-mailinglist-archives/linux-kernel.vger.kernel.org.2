Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F0410D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhISWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhISWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:07:54 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t4so36200640qkb.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mfYd+b856xF2znmD8vgv1lw332UND5JAV7Y9/ZlVnqk=;
        b=TDZhgdW8zLMG4mDcHV/Zk+TwCyZCwnIeriU66Z0y9XH4I0JyJPVn5dpiG2eIiAuvAm
         7spVm4H9aAPIjvSK0Gi6c26LeW4UB2dANItBEQKllplYbrX7LiouHNr8gZL/2AoG1rtC
         XQLT00cJX9sSiumqdDZdO1qpA0sqcoIvegZd3nzzFYKdX0I8EcelYHt4o1iqmKbZ2E+d
         yLZRQ5jgtelwwrJY2DpylI70CvliUYdgaDpEDMNMJu9Mwfpoe8EmOxCr9hseIHEyO3s7
         mQeGGMtp69BrC0+jO3uVAw2Kp8Xmf2qvIxmj36EPzdOsTlLSTrxtxEFSYjsUfLNVYjYu
         gfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfYd+b856xF2znmD8vgv1lw332UND5JAV7Y9/ZlVnqk=;
        b=wn82hbMucEX7dhB/uNdMu44QVX5/lsALCMscTM0S53Jh5I+ZPGTgZpT5ccNl/CE6kg
         aTUYsUVyLlN8YjP/9lolTwOmXE32pA+UVTCYXe+tTsHTvptucjiHJquQBdd0Lft3jh4B
         IP8Yawn6uUj/z7Kx0/bHKKm33kVO6l9CNCbjXuWOuE80NfxKehHX/gOtNodkLBULHunm
         yVRTUDSt+Mcoe6/d9IZfgSmfTuLIFGaJsWR608qNl6g+CKR/KlVoL/FvGfxmoDT8/wgs
         UUdBFLczyOvhCJlaRIt2Rfb/q5myWkFiaK4QMgbManoG7+AUCDRx6yxh5RwJwByuA4EE
         1gPw==
X-Gm-Message-State: AOAM531860oKs9is8kCJnlR8L5RlKnGUhLZnQSrSxg7d3bWYgt4sP/Ho
        WM0GeZ4o1WzB6P36RzfOv2I=
X-Google-Smtp-Source: ABdhPJy/Vbacm+ffq+LhaTjLNEMcyDWPIpyl3Ny1MP8EuvNHAUQS0ECA9s22fIt0gJkTxam81+97/g==
X-Received: by 2002:ae9:e897:: with SMTP id a145mr3323482qkg.297.1632089188284;
        Sun, 19 Sep 2021 15:06:28 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:27 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 2/7] staging: vchiq_arm: remove unnecessary space in cast
Date:   Sun, 19 Sep 2021 18:59:09 -0300
Message-Id: <20210919215914.539805-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl, no space is necessary after a cast.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 22de17f64ed2..e8b84b2b1ac3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -337,7 +337,7 @@ create_pagelist(char *buf, char __user *ubuf,
 		down(&g_free_fragments_mutex);
 		fragments = g_free_fragments;
 		WARN_ON(!fragments);
-		g_free_fragments = *(char **) g_free_fragments;
+		g_free_fragments = *(char **)g_free_fragments;
 		up(&g_free_fragments_mutex);
 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
 			(fragments - g_fragments_base) / g_fragments_size;
-- 
2.33.0

