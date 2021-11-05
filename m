Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6994460B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhKEIhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhKEIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:37:05 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3312C061714;
        Fri,  5 Nov 2021 01:34:25 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x64so8280974pfd.6;
        Fri, 05 Nov 2021 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNnCfv17plgKh9RNsKdF3tZqrD2oD4lNYpmjRFX5TC0=;
        b=cn96VUtrtEe34v4CwSgeMXiGkGdooCbrZ0WLupMfeQlAypP4rqpFmiI/UZKdR+tGoi
         W+EBLnPRWqojIJBGO+kiDtUXC9vusPwTL4SygJxYvUc22hauOsnColL9XRHOdJUBqc3A
         HFPUCdx70rh5c0jVRo2HzRyV13JkD9/WWfb2DVXYjz7Ua1ALAZTFAUjtSFMxbYgCaZ56
         CJUwhm96o1mQyefRxPrM397pNScFtrYcRcLsfOPnWvvXeQuIYrsg5dPWBNqz5L9yC9Tm
         cZ/L/WFFnVhveZt0RHm4daCN8ccStZSblyCIPMYmbGtFbGBwzA5Guhh3ianp00C/IG/t
         38Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNnCfv17plgKh9RNsKdF3tZqrD2oD4lNYpmjRFX5TC0=;
        b=PC04EUxh0LerBO1Pe+gqbDWzq7W5WrwoUihgkl38A4g3faTIv+c/3myMUQIl7ReHgj
         jOs88DBpfIlQQ7kc8RqgQEGAMWN+ILY8zgfN8QUFCAQIlKDxnTjZcpn401wbGjn5zU0c
         0mtulUMLYerlsMsMGINLmLWOC+F40hYvgXAMShAWAOD/QIeipStugpMyjf/tObtU8q1e
         vYBTRCksVHEZIUSzu/JNZzsdX2bJ0xdxpjp4U9CWUtbAMcco3T37zj6vSXLCgYXwtXSA
         6uIOhud5rB5S1aw9haKaIoAJbfmVt7+xE279ATCudCDzTzxpVZCu531BvQpGh3D/+F08
         0Wxg==
X-Gm-Message-State: AOAM5335UJmqtYs3JPfvDs4uELtVS317UdgJbuf+eMsVIErA09bE4xZN
        eJYP4yxJ9Lef+FxQhAVEhIM=
X-Google-Smtp-Source: ABdhPJwRAYQr850Kzbo6HuWtrY/BubzrbCiziHPueHrZyfJVVUI1HtNjKqjvLAdGNe0cKGvUJKystg==
X-Received: by 2002:a62:3084:0:b0:494:65fa:64f with SMTP id w126-20020a623084000000b0049465fa064fmr9472782pfw.22.1636101265574;
        Fri, 05 Nov 2021 01:34:25 -0700 (PDT)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id x13sm5599845pgt.80.2021.11.05.01.34.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Nov 2021 01:34:25 -0700 (PDT)
From:   Haimin Zhang <tcs.kernel@gmail.com>
X-Google-Original-From: Haimin Zhang <tcs_kernel@tencent.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: [PATCH 2/2] USB: ehci_brcm_hub_control: replace wIndex-1 with temp
Date:   Fri,  5 Nov 2021 16:33:57 +0800
Message-Id: <20211105083357.29715-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function `ehci_brcm_hub_control`, like following code,  
it filters out the case where the upper byte of wIndex is nonzero, 
so it need be replaced with temp.
```
	if ((typeReq == GetPortStatus) &&
	    (wIndex && wIndex <= ports) &&       // need to be replaced
	    ehci->reset_done[wIndex-1] &&
	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
```

Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Reported-by: TCS Robot <tcs_robot@tencent.com>
---
 drivers/usb/host/ehci-brcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
index a1e3290e5459..efcfca162126 100644
--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -73,9 +73,9 @@ static int ehci_brcm_hub_control(
 	 * of RESUME
 	 */
 	if ((typeReq == GetPortStatus) &&
-	    (wIndex && wIndex <= ports) &&
-	    ehci->reset_done[wIndex-1] &&
-	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
+	    (temp < ports) &&
+	    ehci->reset_done[temp] &&
+	    time_after_eq(jiffies, ehci->reset_done[temp]) &&
 	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
 
 		/*
-- 
2.30.1 (Apple Git-130)

