Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C390390BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhEYVtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEYVtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:49:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC2AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:48:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1c79120000b0290181c444b2d0so7075885wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUwfQkmiRnjFz2qxX8HCV1pEPlucmbsrX/15Cke5c5o=;
        b=fF2xTUabe1AjeIQeGgOxEs9RSGofg+Q3M+pYBgU/7zN7P2Kz7XWnJrFE9SVsySJQfY
         jvIih2u/Txb5H+u4qFJ3HOzcPCMUeGXaUVEGjWn5fTFfk7/R2wUiOVnNmaTZqDqmdw4Y
         BMCJ2yGF3O51kXpI1/+2vGgzGjwth7kKsO90Wfcm/OYRvLK7yAw9J3gy2dTYcCITQgQq
         Yioon5eMA6u1Xi3AuqXoPVvNFP+iAF8mX+Axp95HGMmx4HKkQQrFuSfAhPvOP4FSy/w8
         f4Fa/YG97EzL5KZ+zKFuheG0PAXIlfEBzV1292R8ikpZHwz7pB37d03mDdJ+wQFpbOEU
         8MWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YUwfQkmiRnjFz2qxX8HCV1pEPlucmbsrX/15Cke5c5o=;
        b=DtjEidLhpMKNRcIu9C/0LugbLg+pVzwciqFNZt7fy/xFX+6gXmrQ4cWCARqX07pU2Z
         wXAzDiGmO4hJ+YxlJSPMNK3W22K7THLcyeSLRW7FpcyBi4BiXXpHacOuMVBu48cEXoyd
         qc9aCIUH/XaR6fRj3T8nP1XvHFIIuNKoUWTipgg4SCqy3o6pQ82DEiSdjBJDdydnWTto
         zi9Thgypbol+WRFl3PaWEGkYu6IJJRpOy6xvGmEKGTk2hpoOuH8dasxIJhVLfzUtcJ63
         8pg4NfnEKHPN94rocuaJlkPGk6UfGbN94MqDniLRSUfDsVOfz/8VpYsrlZ9yoRaBaXvH
         tLOg==
X-Gm-Message-State: AOAM530OMNDua8E0+nUu9/QIb0+t/SspugqRkJ+C9Pujj0pXfOzQje2v
        eq/fq5WaLQVpSCkJjVg3vmuV1A==
X-Google-Smtp-Source: ABdhPJybo1sNZQyiBTcZDr1PArpOs8FxI6Xf5+379b2XU3uwXiQU//y1IXiYdpoCwI8w4DSgj2Jhcw==
X-Received: by 2002:a1c:a98d:: with SMTP id s135mr334702wme.147.1621979295424;
        Tue, 25 May 2021 14:48:15 -0700 (PDT)
Received: from KernelVM.home (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id h13sm12791188wml.26.2021.05.25.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:48:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: convert pr_info call to dev_err call ODM_RAStateCheck
Date:   Tue, 25 May 2021 22:48:13 +0100
Message-Id: <20210525214813.6362-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce logic to extract struct device pointer from passed in struct
odm_dm_struct pointer argument, and use this to call dev_err instead of
pr_info. As this is an error state if this line is reached, this is not
just information. Also, this is a driver, so dev_err is more
appropriate.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index b800d0c6dff5..8348e02b4c86 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -808,6 +808,7 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 	u8 HighRSSIThreshForRA = pRA->HighRSSIThresh;
 	u8 LowRSSIThreshForRA = pRA->LowRSSIThresh;
 	u8 RATRState;
+	struct device *dev = dvobj_to_dev(adapter_to_dvobj(pDM_Odm->Adapter));
 
 	/*  Threshold Adjustment: */
 	/*  when RSSI state trends to go up one or two levels, make sure RSSI is high enough. */
@@ -824,7 +825,7 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 		LowRSSIThreshForRA += GoUpGap;
 		break;
 	default:
-		pr_info("%s(): wrong rssi level setting %d!\n", __func__, *pRATRState);
+		dev_err(dev, "%s(): wrong rssi level setting %d!\n", __func__, *pRATRState);
 		break;
 	}
 
-- 
2.30.2

