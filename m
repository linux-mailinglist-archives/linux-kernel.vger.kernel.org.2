Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC8398D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhFBOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:51 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53179 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhFBOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:16 -0400
Received: by mail-wm1-f48.google.com with SMTP id f17so1451658wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk39BS0/bKimRA7KpxocWhMuIWwoKnA1Ws/AOAzTtyE=;
        b=Ze4kBxas7q6PJHQjistPlY3BKGf9WVwTv4ZiKl4je3WZIzsP5ZUjZHbL5lDcXuJMJL
         Mp6ZI4gjntPB37vX8tuvvailzcv3mf843zkLy888nqtNLvPj8ZftiQaRrgOGdxX6VZPv
         9nS5yi91WCeR8aHzM7dFITyiGuynODpx8iVVYDuqNe5M2EIRZKaZLj43eza1GyjYePh5
         z+J1k4ToUKaDQtuIhWkKDvgcsElnM7zMy7MO9zXxOf7D3H7ZVqGhLBpHMxOCkxtIOhqa
         sF8t34MOtV5ptXDh2nnrsNorYSC9qUdeq8rjnDvFM2KD4u/mC1nLmDW3Pi0ir5dqBI8Y
         SILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk39BS0/bKimRA7KpxocWhMuIWwoKnA1Ws/AOAzTtyE=;
        b=uLzymf2MN/B1rELaqBem3Ucjxve1pMFCO+lfYXl13eYkjVjjVnKdZtd7KNWPUqs7el
         IS3xA6MK+EZnVSNZNbIBDSPKWAMFI4MrdzFRIlYc020QN0FQXNXf9wS4avazwYl3CI4x
         hOlg41bk9yUbiTv+rOqPTG/jw5DPO0NW3/zMLG5OnGxEsaHZ9GXzfZVm5/vYNImXh+Dt
         uR4ixjt1+jQ99EqNLrYSE93cXcFp7VzwxZbM6Eg69P/TrQmNHdQ7w1E5noUPUG6ileQe
         mv3Z7fCuRJ1ww25tmxaWZT2FOqJkN4zELVL2QZkgQdD8ZDKRtPW9PUuTN5UBSMbz3Dq3
         QWrA==
X-Gm-Message-State: AOAM532e4e+jHygqYAWFRGrKBH0g1VkuvcbYh6sRC4bW5R6Qj5zdJsUt
        3oKxEMmHjpcwHtgieuDRsluF9A==
X-Google-Smtp-Source: ABdhPJzazpZoPsfKHbTwLRr5XwTVN0m1xuPC8VZ0OMkDvXGUjqhs7uhxKBzSXvOh0BW+8aTEa0oiFA==
X-Received: by 2002:a05:600c:ad2:: with SMTP id c18mr21789423wmr.93.1622644411800;
        Wed, 02 Jun 2021 07:33:31 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 21/26] drm/panel/panel-sitronix-st7701: Demote kernel-doc abuse
Date:   Wed,  2 Jun 2021 15:32:55 +0100
Message-Id: <20210602143300.2330146-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/panel/panel-sitronix-st7701.c:42: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 4d2a149b202cb..320a2a8fd4592 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -38,7 +38,7 @@
 #define DSI_CMD2_BK1_SPD2		0xC2 /* Source EQ2 Setting */
 #define DSI_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
 
-/**
+/*
  * Command2 with BK function selection.
  *
  * BIT[4, 0]: [CN2, BKXSEL]
-- 
2.31.1

