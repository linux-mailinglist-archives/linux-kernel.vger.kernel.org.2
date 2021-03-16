Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C133E143
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCPWSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCPWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:17:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E75C06174A;
        Tue, 16 Mar 2021 15:17:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e9so8233670wrw.10;
        Tue, 16 Mar 2021 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kRA0HCbEjT4GZQCeNIs3PSJKICgvU616s1ESCC3pTK0=;
        b=NJaUaSprJa36hY/KVAoa+aRlI3mTw2pTEgLdQrvubH4tFieFibPRmLK8HlMfV7EyoB
         F4L8wblPUyyPpDJuioJUVCzgDAfNXqO0Guhdr1n6U3wowU8ifVbyM1/uKLySO3KyZPvk
         6qYqMv/ykaogHeItXU/N8Hp6Cb7JmWp8p3jyfxYSR2gUg49UFIYpQfo3ibEbRrG2+V0W
         cPowHEOno7Coa6TPyrlnCSoEGBXc1HLMb1fox7u8AyR3amKtrvfXKJ38Q0EEI4QXxnzw
         XBdU5+Hnnw5lk3OJsecQ0ptD4+HNNDufwn/Xk6HVa195cVepsQqVUEUIVclo53cCqsL4
         AM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kRA0HCbEjT4GZQCeNIs3PSJKICgvU616s1ESCC3pTK0=;
        b=tWJTyHQAywJQNl6e7t4PkWN9rrPtHe/4qC0sLFMOIxd+rLRNLjNSSpH9heTRYveHBW
         18U/4GKqf5zgO/dX1Tpz5o4XQma4VBNpqZPXE0wugPqfeMNipgZp8cC4oLZAnr5u0W9K
         T32PPr450L4ZJpIQVkZjZirmc4FPwuQBacEdJIWTmlGfJNM4VsZq+E7kP8KrtoVXSta8
         OVJSnbZEG4HYK4Aw/54GyL55G6enUafaSh589cto8dqDayleiVjtVfK2/MGUqNtIxNkA
         bLgGFVhd7KyE4QzexENkTI4C8o1/Oo54yN/sOVshWMIy38YnZ6K7hr0ualIbfswd/KKg
         K14Q==
X-Gm-Message-State: AOAM532oIugp0V0bMxMwWrCG40Qkc63eJSyfxN6VfQcSgmqH2NL7KHeu
        gT0nLACmoWkEUWCRKbQnjlI=
X-Google-Smtp-Source: ABdhPJzOp+ns2T7fZHW0zHZoOIrO5Dx7kB274pAizU3zKUV8TfAPTr9nvT+Xanapt/lbpE21QS/vVg==
X-Received: by 2002:a5d:4686:: with SMTP id u6mr1168656wrq.60.1615933070114;
        Tue, 16 Mar 2021 15:17:50 -0700 (PDT)
Received: from luca020400-laptop-arch.lan ([2001:b07:5d33:19f:ea1f:2342:ea78:219a])
        by smtp.googlemail.com with ESMTPSA id 1sm1151960wmj.0.2021.03.16.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:17:49 -0700 (PDT)
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     chiu@endlessm.com, Luca Stefani <luca.stefani.ge1@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: Disable fn-lock mode by default
Date:   Tue, 16 Mar 2021 23:17:47 +0100
Message-Id: <20210316221747.90829-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* On recent ZenBooks the fn-lock is disabled
  by default on boot while running Windows.

* Follow the same paradigm also here.

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 9ca15f724343..32319f7d6e17 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2673,7 +2673,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
 
 	if (asus_wmi_has_fnlock_key(asus)) {
-		asus->fnlock_locked = true;
+		asus->fnlock_locked = false;
 		asus_wmi_fnlock_update(asus);
 	}
 
-- 
2.31.0

