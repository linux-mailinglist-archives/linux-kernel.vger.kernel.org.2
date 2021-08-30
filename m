Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF493FB5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhH3MRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhH3MQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272FC0617A8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q11so22106409wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/i9rKJcPxsCwJ6kNIOQV+qImhOF+UG8aTJL9Wyv+hOs=;
        b=noHnxrJcLvMQCWvRDvwpB3nwGLG6+rMkeQcfkJqFkDfcfTOqwK4DJorWksfevYNyd2
         YG2zvV64AKyyUpQVCmODZkzNXTwEfYi4L5TDMmjdQQRfGWuIW5qCZim2Qngl6ePTwQ1z
         pra1pQPbenoYg4e8XGX7NiDIWbg4sP670HhEpOgnKmsD5EFZVXnWCMIxluPtFnZyor+5
         30caJqA1CvPBALWuD5q2lURHxXly4bdn6Vq7096+XTyE98mp3RrQLIS+yqe4VeUgRfVo
         r/4f7DpOWEzrgg8BIiHcmSWZLn08QlWTIZ/WOgb7nG9pY0poF2vVVCaGhRz2hcxG2rcj
         fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/i9rKJcPxsCwJ6kNIOQV+qImhOF+UG8aTJL9Wyv+hOs=;
        b=PFCds4zZbrdcWNN8pB6O4S7qQDlJFHeMdhMSDu+7y7zA34NOvVWZL576xfO1G2+8ut
         bkMFmwQ/RLPH7qRxlCw/V2XoN6N4SLreRO2xuiJnrJNb1C3NzD7WMelePY0J75K9rlXy
         ACzyNESXhVn1UxFpe6wK3CzLEA/3EsqNnOE2+JCvt3b7bXUi7lkWj8Cbc75u+9C5byo6
         2NVUwv/RobkFIKAG22PNQTViPtRaFGaphO4WUBQJKlzOR+tFPD5YgWaGmaKiAs2E9Wbk
         TIQnSwKbh1V22OJ2m3JnvnPih6f0BVIjjWLMI8nMeBfiuaTcq+51Mc3admkIQRbADF/H
         hm6g==
X-Gm-Message-State: AOAM533ubA9Y0RjLoEgAYhG8s9GZV+qYV9AO9LGzkHK97hIpcFqaEaRL
        gYE9ZtNVt+4C4wgq4kTUSOo=
X-Google-Smtp-Source: ABdhPJwAg6PQZI/w0tl85ZAwyZYNBpuF4+1ZuvSh4A7001LBNJbGPe3RdZbDo6mYUTh5OWavGtY9jw==
X-Received: by 2002:a5d:6e0c:: with SMTP id h12mr25913814wrz.334.1630325751249;
        Mon, 30 Aug 2021 05:15:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 8/8] staging: r8188eu: remove unnecessary parentheses
Date:   Mon, 30 Aug 2021 14:15:08 +0200
Message-Id: <20210830121508.6411-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses around a variable to improve
readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index f76c762ccd4b..952ad3eec5bc 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1038,7 +1038,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		DBG_88E("MAC Address from efuse error, assign random one !!!\n");
 	}
 
-	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", (mac_addr));
+	DBG_88E("rtw_macaddr_cfg MAC Address  = %pM\n", mac_addr);
 }
 
 void dump_ies(u8 *buf, u32 buf_len)
-- 
2.33.0

