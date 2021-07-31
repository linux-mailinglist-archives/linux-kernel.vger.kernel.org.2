Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801F53DC90C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 02:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhGaX5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhGaX47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 19:56:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376D4C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 16:56:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h13so3115248wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 16:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlgQ4zodi9G4CtU/C9MKVtFIarxkNvlp0PU1Vx9JfrI=;
        b=HQZt4JuH5hSHbS6H+iQSwxlSC0N9roPc/5P1qYbFqF301Q7cwcFgsGO9AkymFeNJSl
         ol+kJEV8TcyupF0YouNb6Cbfxi95X57mkvDfVbG0K3ni66yBIYAl34dVoHoWyuuw1Ve1
         XU9Tu0uE57ttMAxC+AUVH02U1QUiC8B1EydW3V4kFSuEHq/mdIFUh9tcc+DjptvhTgjy
         5tHxeC03DEiskZgGqHJ7P6U0mF5IgKtlBHx9wmC8pyRlgEifdSPryWQ8cmrIOlaay1O+
         nKklCZIzOGzPIKZdycHets5dbG/bMWMzRikxJWxw1RXmF3nE3wBwiZgcgE8Nn2M+9ZSM
         EDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XlgQ4zodi9G4CtU/C9MKVtFIarxkNvlp0PU1Vx9JfrI=;
        b=JK8wmvPaoCYMwLs6R7i5342H0dzTpAq0RSMDk0UKUTX0cqmDciHZXte5SeRudMefGs
         HfCOyx7p9vgS2f55EA0hOYZPv8dU3Y1AleAuriQlSK30ic0K1RVTLxDYguDf/YqqnArR
         XZnl6T4t+RnXJjWsgjlivSleeC0PClY7BMgn+EomVkAWkoXQPxGh7i5ObQeqT6ZXg125
         AvQZipHUiBxHR4JBiUEWefkBCPSYFBoOE5/CbKgYzYXP1AnUHrlnRc/U9Ae8z8bkxSSY
         eIuO41nMN6twaKcLodld0j/+31j5LlK0oEYzMk4dVrsEmz9cOteunWFMv3u7xji3VMc4
         pR6Q==
X-Gm-Message-State: AOAM533htIa6qOFmK3nn58BvvfyZvmWg3X4gamjH3RATfM+bk1YLGdvb
        0VI7TZkUi7H4i7DXaRfjXhzYFy/sFZpBC1Lm
X-Google-Smtp-Source: ABdhPJwsLg+XYeW5CJMP6DuZ0e3P9OnoRWi6rKmRtpPVNLNFCyinLsCrQMRLuJcrutDBlTqIp5h3Zg==
X-Received: by 2002:a5d:508b:: with SMTP id a11mr10742542wrt.244.1627775810799;
        Sat, 31 Jul 2021 16:56:50 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l5sm7121782wrc.90.2021.07.31.16.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 16:56:50 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: remove RT_PRINT_DATA macro
Date:   Sun,  1 Aug 2021 00:56:48 +0100
Message-Id: <20210731235648.67642-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_PRINT_DATA definition from include/rtw_debug.h, and its
two calling statements in hal/hal_com.c, as this code was not written
with best practices in mind and is safer to simply remove.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/hal_com.c       |  7 -------
 drivers/staging/r8188eu/include/rtw_debug.h | 18 ------------------
 2 files changed, 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 66a2f3d6d9e7..91d5182f9bb1 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -339,18 +339,11 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL);
 	*(buf+1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_, "c2h_evt_read(): ",
-		      &c2h_evt, sizeof(c2h_evt));
-
 	/* Read the content */
 	for (i = 0; i < c2h_evt->plen; i++)
 		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL +
 						sizeof(*c2h_evt) + i);
 
-	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_,
-		      "c2h_evt_read(): Command Content:\n",
-		      c2h_evt->payload, c2h_evt->plen);
-
 	ret = _SUCCESS;
 
 clear_evt:
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 56af0751f70e..83c71275c47b 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -81,24 +81,6 @@ extern u32 GlobalDebugLevel;
 		}							\
 	} while (0)
 
-#define RT_PRINT_DATA(_comp, _level, _titlestring, _hexdata, _hexdatalen)\
-	do {								\
-		if (_level <= GlobalDebugLevel) {			\
-			int __i;					\
-			u8	*ptr = (u8 *)_hexdata;			\
-			pr_info("%s", DRIVER_PREFIX);			\
-			pr_info(_titlestring);				\
-			for (__i = 0; __i < (int)_hexdatalen; __i++ ) {	\
-				pr_info("%02X%s", ptr[__i],		\
-					 (((__i + 1) % 4) == 0) ?	\
-					 "  " : " ");	\
-				if (((__i + 1) % 16) == 0)		\
-					printk("\n");			\
-			}						\
-			printk("\n");					\
-		}							\
-	} while (0)
-
 int proc_get_drv_version(char *page, char **start,
 			 off_t offset, int count,
 			 int *eof, void *data);
-- 
2.31.1

