Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265123DA4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhG2Nx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237794AbhG2NxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:53:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:53:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m1so10430589pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAVeohC8Zb1P0slBgD8gi8FAQTZUN+m4NlZ2IA+vPgY=;
        b=D7dBwGXnI2eVSbvlw3qFJNGjQtW5IG2lZZRruwfT/w/RrjRheUbtR3rGbGDgryTXIJ
         HO0ljZXha58uKgGsu5XaXaN+hyE5KrIeV5fbaPgx7+JFn/NuNQ6Vo1qf1iw6bvqaEx33
         KlAUMkDe+ODsDTh1pFOOwYB6KatE5cPbSeCmt+4cJtfLnoHds38Si19YSGniA+8dOujO
         QngF9SH+boXZbCBtXDA7RPNILqdbXYVgQCY9FSBy5DQwloYEguA/HWawlc/E7Xz/wJQe
         f9yJqTSYCeePNpNou8cSXKKyxTq4zJYdT0RgOc0XN/LZJmuTc5q7rEqrknXIth8PShkP
         GN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAVeohC8Zb1P0slBgD8gi8FAQTZUN+m4NlZ2IA+vPgY=;
        b=YwoD2NxAyf8UFTGUrMhGOLcjqjFFuMqvIb+2x52/AEeMbDuYMYW6OO4gvdP/DJfJZU
         mW8UQ5oaUnxqpXztbIjS3UiJL4gVGvi3Yygaj1U54n5gEl8T5YipzJSCXFdN95cydq9s
         axGpF5utai0KaFm9wE4Ag+2y0xx+GGxx0+Zu/N09L4JLEjkJd43UYqQXOPy97I3JOa61
         4oM64/Ci1sclgwe+0kxgjL3XA9QE8tRYq3O5044UcWivfTq0+UxzIp6VKPsthphlL7ko
         6wnbyLZg7vLox00eqN5CxKTHVRLaQkMHS7Koor7e6WRPbsp+x8rlUnb56AVjA29hy78E
         tlGw==
X-Gm-Message-State: AOAM5328vsFxUHZN1xWpftza/7BQU5LFh79ScxyUSH9BOftGo2rR2pxh
        y2BnW+VGKpOnarAGAtBhWMc=
X-Google-Smtp-Source: ABdhPJy2KYe7jP/YHWOgw5zxo53AaWMW3fc9FKhCkHdrgoN5i8sINMlUSYVw0N/zRRxMqAMi7r+zWg==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr5415108pjz.80.1627566801437;
        Thu, 29 Jul 2021 06:53:21 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id e16sm3406155pja.14.2021.07.29.06.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 06:53:20 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 58177236056A; Thu, 29 Jul 2021 22:53:18 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] drm/amdgpu/powerplay/smu10: Fix a typo in error message
Date:   Thu, 29 Jul 2021 22:53:14 +0900
Message-Id: <20210729135314.661858-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in error message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 43c3f6e755e7..7dd92bdf7ffb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1580,7 +1580,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 		}
 
 		if (smu10_data->gfx_actual_soft_min_freq > smu10_data->gfx_actual_soft_max_freq) {
-			pr_err("The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+			pr_err("The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
 					smu10_data->gfx_actual_soft_min_freq, smu10_data->gfx_actual_soft_max_freq);
 			return -EINVAL;
 		}
-- 
2.25.0

