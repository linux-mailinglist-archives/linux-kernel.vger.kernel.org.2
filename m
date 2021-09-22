Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631D4415111
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbhIVUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbhIVUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C32C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i23so10503447wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2KHo/cgVsPXphTOqclY226ymCgxuFcLN/28gKh/lRY=;
        b=OsVsiT4eM5gEW3DiFfetMb1umnY7TuBomgLYRI/m2TYSQjLPhMK9wgRlgEy0tHyEOz
         qb2DdlJGMrA3L88pEbP0axJEkuxxf01wkaVWEXIiGul57kqgNiErIuHje2hFG4mAN0C5
         0eXRDdaKXrZT1ZfvhGkMi3iIkURvZBNCKuBjb3ydu2Slpwk88lMi1WOx4KR9knhEGdnk
         a31lR0q3LXV2Bjc5xeDctPB0kwMzTIPQZz7hp6MGEzD6hO3KQNrycl6l6qGwpWAt8V2R
         8DFVIir8ScE4l5WyjS4bMXeISePa5EAD7aG5KgWZIif5vxnwH6hg6gC4EadsQnuPWoGJ
         I/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2KHo/cgVsPXphTOqclY226ymCgxuFcLN/28gKh/lRY=;
        b=WABYstAGNndy3Af3wpeni4mowstLzcdppFfYyrG7Od+BlNbeSUbCzbXb7Xvpn3TgWp
         nnVbCkTTVxHD+tao5UrR+ttNFwWxrXHGyxgJIN4FUtxzaker5YmELFK2xatFA3bswmJq
         ygvtUc8fKaWmDdhKEleaB1KofwxQjl13mzQMHVEr8n2YVh/U7Q4nM8/AO3gBtaxHAhnM
         0JL/LmkAlQ7CB1ONrnuJj8j5nwIRN6oaYgSNw9LYz9KTWYipY4TwvSUVeyjxIzd0mqSI
         NrNQ7cEFASkpFhMWN8QQIh1R8kGLFSAdA0PTFS8wh9Yu0Z9eBc0lRW6uWqCVAvQjhm02
         WEBA==
X-Gm-Message-State: AOAM532FXHrfrc5xe9VlbPDJdPTaTf6HvvkKKzAH0b94/atD7mbde2Yd
        6BbFxzW9uf35UCDTOi/tP0k4yrW07/aUFw==
X-Google-Smtp-Source: ABdhPJyFk5i30kLxK1XkcamnhisCjUBjlHQFY/YGCSYoV9AhgXCrWm4bPiSjrc3CCHox5u2fUa//CA==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr802235wro.425.1632341152078;
        Wed, 22 Sep 2021 13:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:51 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 29/47] staging: r8188eu: remove rtw_IOL_cmd_buf_dump()
Date:   Wed, 22 Sep 2021 22:04:02 +0200
Message-Id: <20210922200420.9693-30-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_IOL_cmd_buf_dump() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c    | 17 -----------------
 drivers/staging/r8188eu/include/rtw_iol.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index ee7cda76e767..fe6078864158 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -163,20 +163,3 @@ u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame)
 	}
 	return is_cmd_bndy;
 }
-
-void rtw_IOL_cmd_buf_dump(int buf_len, u8 *pbuf)
-{
-	int i;
-	int j = 1;
-
-	pr_info("###### %s ######\n", __func__);
-	for (i = 0; i < buf_len; i++) {
-		printk("%02x-", *(pbuf + i));
-
-		if (j % 32 == 0)
-			printk("\n");
-		j++;
-	}
-	printk("\n");
-	pr_info("=============ioreg_cmd len=%d===============\n", buf_len);
-}
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 4d44e59fd04f..fb88ebc1dabb 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -59,6 +59,5 @@ int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
 	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))
 
 u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame);
-void  rtw_IOL_cmd_buf_dump(int buf_len, u8 *pbuf);
 
 #endif /* __RTW_IOL_H_ */
-- 
2.33.0

