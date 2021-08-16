Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB63EDA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbhHPQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbhHPQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:17 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5778C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q11so24337895wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CvQg54t0uTxeQkYvMZ3G2AVNpgHBvBBNyXUjt7db2UE=;
        b=HzitVE70ItCW+A326W4yF5iUm8zGewGNyPbjYefs+01iOM27VmHd4i69oVZ9UeXiKt
         SaSVfgaLKuYDBcF13Z8w/NnIwkpuNhetrym59zlMAgF0jRcWn0ojuV/0lAXCojDyV447
         28Lrea1FVk86ElyqUxJ2TA+xC8Lj83+nhiAi/dyGZQCRaC8d37Bx+GwV6x4PndRMt5aB
         jjeXbY7dAUTVpe3EggbLys3mBRivEdm/GYqrbLLbtoAhlOuxL0uTBUZUzMbmcUS1t+Jw
         4L6O7bhZbcFM3D2KLAa6IRpIIw4XkkknXTSjPepbYXbf2nbxhMrYO0Wm9U3d08OZlc4e
         tipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CvQg54t0uTxeQkYvMZ3G2AVNpgHBvBBNyXUjt7db2UE=;
        b=NVmmNxtoHR9tdT6UqfQF6VmzNAaS7cW0Y0yk4uXYO9HcSIWiYZq3HSiBf1sgnmx/jY
         PCcT2Pch26ORTx7Y+2GhCBmDGodCL1wYDgBHeMBjnjMqv8AaMU5bZzWvYT7XfoEwHfHW
         pi8kvWD6MwdN+L7IoJhJxKg/Hk9/VD5gFO1FV8DckXAe0HF9x3iwgGYZir/TNDGpKOXT
         MG/XYGvST1i6yl7o262Uj8OaTDrEakll91/DJYyx5Qz6ajlkuSIbIpDD2ARg+6FTEa5F
         X37NIXCK9+Rv8KD7KhtM07HYEBXuoBnUOO5XZ9UuBWTPt+zMiZx0W8f1T1fvWhQrUxPw
         qQoQ==
X-Gm-Message-State: AOAM53069z7erlvqz69Hb8LhmWwUAIb7zNhfwXcISSE6bk5BPHubkjLf
        +Cqn9KzMjUtKw23ybAvs9LY=
X-Google-Smtp-Source: ABdhPJwk4S0aDt8ktyP8CFhIjjCZpyrz5TQGzLMpJlDnYzqt8RzM9Cm4mcjoJQ9WMZK0AYCeX5UxKQ==
X-Received: by 2002:a05:6000:14f:: with SMTP id r15mr11256695wrx.18.1629129584481;
        Mon, 16 Aug 2021 08:59:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 21/23] staging: r8188eu: add space around operator in core/rtw_sreset.c
Date:   Mon, 16 Aug 2021 17:58:16 +0200
Message-Id: <20210816155818.24005-22-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing space around operator in core/rtw_sreset.c reported by
checkpatch.

CHECK: spaces preferred around that '|' (ctx:VxV)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sreset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index 5084bc036424..8e1bc62e74e5 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -45,7 +45,7 @@ u8 sreset_get_wifi_status(struct adapter *padapter)
 
 	if (WIFI_STATUS_SUCCESS != psrtpriv->Wifi_Error_Status) {
 		DBG_88E("==>%s error_status(0x%x)\n", __func__, psrtpriv->Wifi_Error_Status);
-		status = (psrtpriv->Wifi_Error_Status & (~(USB_READ_PORT_FAIL|USB_WRITE_PORT_FAIL)));
+		status = (psrtpriv->Wifi_Error_Status & (~(USB_READ_PORT_FAIL | USB_WRITE_PORT_FAIL)));
 	}
 	DBG_88E("==> %s wifi_status(0x%x)\n", __func__, status);
 
-- 
2.32.0

