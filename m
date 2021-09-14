Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C840B0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhINOcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhINOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:32:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5032C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:31:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t1so12903785pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0OnMvsDVskt5GO6UPoyhHQ+fQZFdSjePNVx2sNQE/o=;
        b=WoiotpieTT+jVVeokS5GLYFcwyaC45SPW/UM4a76quzE/R4aR7TmMNDfidSmrxdpHh
         sZ9kL+wPjdNPRlPVREHitomHTBrgxmtpBfqtkVvUFqJF31V9t+ycbishWeQoPS/n0q1g
         Frn5c0tiwOf/FIyoZB0U9WftFGpMiaiReHbyzKjB3oAvha00x4VuJUU6sTK/2TfYg1zo
         0MO7gckoCZbKjgjDULwGJmXL5u4eO97dvuuxM3DXlsPqVtUUA4D+B/5VU+dJHbeXrXzk
         qHzxGujsX7DtZc6KFXY07TvBMWUgdV/BSXQuqR1w803PGtdjRrYdhtbj0TYesQqWertd
         1MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w0OnMvsDVskt5GO6UPoyhHQ+fQZFdSjePNVx2sNQE/o=;
        b=bIaDCSDemc4RE4tbexj12PaSMYBf2B/CLZimXCZ5vsccStlZ0Ot5z0mxmsGC04EbBH
         Jlw9RA7DjmxaYsx3niXCuTLmgBskYei/mkxsR5JW55IR3aL+N7dVUmulr7Ho8lYDvuz9
         VY7JgoSW6RUvcJRp1knz57LlmMGvsVGB6eVdgMy/wfW66M3BCE2gh6kCLLz1elJ9Hta/
         bsrV3ZDl+3zXqtqPl7IPviCpszpY1ubEmK2MEgUVsikzceON/8z7v2ryVsGanTh1d9WN
         MbCTEHagYTyXA3RgsaM5hHCTU2R9q/pxZDepPJfeUdVeOQvwIKIa6Vc+TlHbVdHmpGe+
         5+sw==
X-Gm-Message-State: AOAM530q0wKDdMjAuxfBLILyprRwiopk/+TgvO16sgRTDWdgX49mcWaY
        0CVNiIgZ1qXBh9VuY4kKCW/SsvkOTAPVtQ==
X-Google-Smtp-Source: ABdhPJx+1bKb7b1nUkHsmCbarE6xqR+X/fKwp0fj/jnKlt7HW9AigaevdLjwlFuIs+zsRpahzX20Og==
X-Received: by 2002:a63:7a0e:: with SMTP id v14mr15821775pgc.466.1631629873230;
        Tue, 14 Sep 2021 07:31:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c26:79fe:c0f6:4118:85fb:d7f6])
        by smtp.gmail.com with ESMTPSA id p16sm10365073pfw.66.2021.09.14.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:31:12 -0700 (PDT)
From:   Srivathsa Dara <srivathsa729.8@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Srivathsa Dara <srivathsa729.8@gmail.com>
Subject: [PATCH] staging: wfx: sta: Fix 'else' coding style warning
Date:   Tue, 14 Sep 2021 20:01:06 +0530
Message-Id: <20210914143107.18436-1-srivathsa729.8@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'else is not generally useful after a break or return' checkpatch
warning

Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
---
 drivers/staging/wfx/sta.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/wfx/sta.c b/drivers/staging/wfx/sta.c
index aceb18a1f54b..23c0425e3929 100644
--- a/drivers/staging/wfx/sta.c
+++ b/drivers/staging/wfx/sta.c
@@ -169,19 +169,18 @@ static int wfx_get_ps_timeout(struct wfx_vif *wvif, bool *enable_ps)
 			if (wvif->vif->bss_conf.assoc && wvif->vif->bss_conf.ps)
 				dev_info(wvif->wdev->dev, "ignoring requested PS mode");
 			return -1;
-		} else {
-			/* It is necessary to enable PS if channels
-			 * are different.
-			 */
-			if (enable_ps)
-				*enable_ps = true;
-			if (wvif->wdev->force_ps_timeout > -1)
-				return wvif->wdev->force_ps_timeout;
-			else if (wfx_api_older_than(wvif->wdev, 3, 2))
-				return 0;
-			else
-				return 30;
 		}
+		/* It is necessary to enable PS if channels
+		 * are different.
+		 */
+		if (enable_ps)
+			*enable_ps = true;
+		if (wvif->wdev->force_ps_timeout > -1)
+			return wvif->wdev->force_ps_timeout;
+		else if (wfx_api_older_than(wvif->wdev, 3, 2))
+			return 0;
+		else
+			return 30;
 	}
 	if (enable_ps)
 		*enable_ps = wvif->vif->bss_conf.ps;
-- 
2.25.1

