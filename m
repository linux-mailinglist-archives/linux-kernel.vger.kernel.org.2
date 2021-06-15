Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA603A7D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFOLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFOLrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF96C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so50709642edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D/6RpZ0CBKmM6q27QzR8lVWMKF+tf59W0tNVEeHUkI=;
        b=RQuzMP4Y7ST0DiBwa2uoK897Wxi8exvgtS9yfYnhReV13YJgv9WoD75eGNmolwY66L
         wTrzUuX89sN/tOKGo3NK7EBS1XtoD7LjBK1BfyM9mCit/tRFj1zn7lCt2fZZ+AaYJs/Z
         eoyWGrU7zRPSRaI3/aoQUE3Q1Zyk96r5/gpyZBGHmXBAu8MV1vje7bhl3G/VEM/UH6VH
         u2Lz2GqDp8DHPTCumRU1D42gPlsshsqtjAWCy5lFOOi1J9qQMewukKomhPCMJPCIRgXq
         g+XY0pHUsF33Mw7ud57EuRYZrzWM4lpshJkJOjqvvY+nl4lYa55lpSgOYB0dUHXF/tRh
         9g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D/6RpZ0CBKmM6q27QzR8lVWMKF+tf59W0tNVEeHUkI=;
        b=divtFlfhzHshaOKf9TFIEUKqdJCUhBJqzEBiMPyU66ddV24VSAgEi7f5UFWtM9gIZA
         eQfc77rNgocEbxn/1gQrcBfRyvTyKmhEtXnmjL4ZCIp/q7YmqsLdS16HDHOuvhGunB7d
         nJ+AmEIsJJw08PDbc9s8L+A0QjRW6ez5AAriV1LZfqZaj1SAHCj3COtlPmfHfmfw0rwx
         LtdilCKY/KCxkJFIcUz/cxVZO1gf2YOPsTN0atDJFALTTgKnuAZQFYtJjGDksYxszpYh
         D5hPkBDqefMrYngEF5zZrDcsP86ot/HjxF5SfVSFm5VxbPRcwsLR2pgx+VvQynK1Xrt4
         4jXA==
X-Gm-Message-State: AOAM533+pIGNMWNIHnP6XAGNbwGRMIB/7iMGeBrfRrqO5+O1zloJg0zm
        ehuaXkyZOKbVJOcM+5n28lZ5IhbV5LkROw==
X-Google-Smtp-Source: ABdhPJzBZYD2xGg1ZUBPx6MEf26TO8DAnTN2Zhzolm0qA3msILuY2E5mMOy1P96HM1QVd+Cw4ZNx4g==
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr3640244edy.201.1623757541293;
        Tue, 15 Jun 2021 04:45:41 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id g11sm7579533edz.12.2021.06.15.04.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: rtl8723bs: remove unused debug macro
Date:   Tue, 15 Jun 2021 13:45:31 +0200
Message-Id: <4d1e9ad759fc4b66fa3309637b3b4c8eb81d2ea9.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macro definition in
include/autoconf.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 944a7d2a1e53..aeb9479d1327 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -40,11 +40,5 @@
  */
 #define WAKEUP_GPIO_IDX	12	/* WIFI Chip Side */
 
-/*
- * Debug Related Config
- */
-
-#define DBG	0	/*  for ODM & BTCOEX debug */
-
 /* define DBG_XMIT_BUF */
 /* define DBG_XMIT_BUF_EXT */
-- 
2.20.1

