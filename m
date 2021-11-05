Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E574460B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhKEIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhKEIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:36:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519FAC061714;
        Fri,  5 Nov 2021 01:33:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so2882613pjb.4;
        Fri, 05 Nov 2021 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xMd49k8O5HKDuplqHxeRrL1ifEW/yK24JPUKrIN/oo=;
        b=ZJPHU4CU49LQhRsS/Dj9U2Orgv+GrD1KlvlCRijxi8LkfbB1/7BNiAn3fIiuCuJbtK
         R4kPXHIKoQ2fV0cRGn3R4hC+q7poev0ERJnyihgBtRKoOCi6reUEg6spDNq8qdt+FJge
         6GaQimffWpY6FvkSKJx5UkT5tveSJt87v01BvDU9zESq7Eo2kt72dqNmdnqiQl2io/PV
         DgAQRmPk3372iCrIqiNvEdDXMWYbRdaCtgi3U1In3tdHun3AjODDZHmVCGeYVx7hJBa1
         pHMH2wP9py/yfVgPYvhNDvG3nwlZQt1FjIwZHOiAi9aoHJ4yCdi1Z4w/UQeJk69HwHm1
         /x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/xMd49k8O5HKDuplqHxeRrL1ifEW/yK24JPUKrIN/oo=;
        b=Lhy+vqdIIH3UzdSpUwzJspdr9B47kdElybPykBViuBEhipkUyJxLzeT99bTSWeeIWI
         VoVQcvyJ1uWA0p6wnAlirgkmw9/21S8cKLpJs00D17pp59synKX9KvivP2Kdg8N1orw3
         X/gd7aDL8VMQm1aGJ/1rqx82OZBZq+QtqcV9WUc4BKO/JOMBQzDdsFKz+SqderfvPGmO
         25KMSAKoHkfuy0QqWviFR2mXAiDpVi9sc7xy7L8YxkNhMCY1zZisdxSsUAIf1LYhSouI
         2ux1Hm2Q+6TsqSP2dlNzULuxI9rXnwUGdBAaLr7fJS3bWiK+P2N20RbUTgYrvB8DS9Xp
         lUkg==
X-Gm-Message-State: AOAM532Q4rCg9mllmSduT4BgwHnjE0OPDORmX+btgPlXU9A81x5coU4T
        ibI0IqMQyUdmQ8cHHLIMXH/8XXfF2d0=
X-Google-Smtp-Source: ABdhPJyp0FyU29b9eLxN+7iyF0eSO/DbHpabIQ20Bry8AEMX7k+v//EFyOodyPKmRabgCmk5d0rnQA==
X-Received: by 2002:a17:90a:3009:: with SMTP id g9mr28979752pjb.205.1636101207912;
        Fri, 05 Nov 2021 01:33:27 -0700 (PDT)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id l9sm5518814pga.49.2021.11.05.01.33.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 01:33:27 -0700 (PDT)
From:   Haimin Zhang <tcs.kernel@gmail.com>
X-Google-Original-From: Haimin Zhang <tcs_kernel@tencent.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH 1/2] USB: array-index-out-of-bounds in ehci_brcm_hub_control
Date:   Fri,  5 Nov 2021 16:32:50 +0800
Message-Id: <20211105083250.29464-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't enough check parameter `wIndex` in the function
`ehci_brcm_hub_control`;due to the size of array `port_status`
is 15, so it may lead to out of bounds.

Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Reported-by: TCS Robot <tcs_robot@tencent.com>
---
 drivers/usb/host/ehci-brcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index d3626bfa966b..a1e3290e5459 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -62,8 +62,11 @@ static int ehci_brcm_hub_control(
 	u32 __iomem	*status_reg;
 	unsigned long flags;
 	int retval, irq_disabled = 0;
+	u32 temp;
 
-	status_reg = &ehci->regs->port_status[(wIndex & 0xff) - 1];
+	temp = (wIndex & 0xff) - 1;
+	if (temp < ports)
+		status_reg = &ehci->regs->port_status[temp];
 
 	/*
 	 * RESUME is cleared when GetPortStatus() is called 20ms after start
-- 
2.30.1 (Apple Git-130)

