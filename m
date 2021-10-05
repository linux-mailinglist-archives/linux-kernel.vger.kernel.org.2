Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9599B4230B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhJETXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 15:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhJETXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:23:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95664C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 12:21:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w14so154656pll.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dp7Oi0QvrWBA209df2TQmdc5am4px2pX99t2tf1pAOA=;
        b=qeegXRnHsBlkibk5tUFoabMfu3zzlKUEKQH7rYQ28kZj6ymxw4SS/GEpOGOgEU5luQ
         9f3CLmT4pDRCeIkZPL3qADZe7KgRF4pPRr189hXw5RQnYwKwX3VWzo1O7Yk0OybN69yN
         JdH+1YDGcI9p9tzvNzNT6IKMCCmR/S4fXDM1D8Wj/SmpGyUp8UN9l7JeHOCmqUWAb5oz
         GBG3ecNgmff2cNvvaXs3Q8Z2uldi6ztVehlpjtZM1REmnoVRR681ihHeCpcNEDH/Lb7b
         tm4iiAokTt3t3P57gIsxPRxdtUAy9TJNFKYGtjWLrmo7eXmmTSBI5BWM6TLZSIWQuiN7
         SecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dp7Oi0QvrWBA209df2TQmdc5am4px2pX99t2tf1pAOA=;
        b=DaKdpo5eLpAATSHg9gO3lGti1qaZX1KUo6xI192gqQwiVDFobbMw+hb4Y5S5BH4Px0
         6U64AL3U6uZJdWKwfhZsHv3RXpxiOqojJaBtPL6lNwP845XS3UkkbGikX5kGeHc42FCa
         sMbQYUhVdJpOrgKkiwQYUHZB1etBrJLs/JXd9y7VMe7hiAZ4THIX90nVhrmFS3PwgOmR
         4bTRpDsTjAZAknChX6CIdlGpYfUCSgkjl4u3xG7JfFfkwGKvlRvKriCo6tRSp6rZwpu9
         5Ve0BzB8FE3DU9OrR1HD/jTXXvKkcOod73N5rLpO7r8vfQz1j8JZimG2SpNIbFFTdHVB
         O5/Q==
X-Gm-Message-State: AOAM533qhWweO7ctZt44CDR77m94XbxOyWrAB96F0Cp0x28+qXDlDa04
        8EQ5oUl8oOgsXDf4iuBNxOo=
X-Google-Smtp-Source: ABdhPJyJTPXzQzt2fRdm8g4PPQOf0uG3dyJc5pU2jYIUzBuSTXMcR1kvR1pDwVkT0Bq1U+iQTBRFzg==
X-Received: by 2002:a17:90a:a88a:: with SMTP id h10mr5779808pjq.226.1633461681055;
        Tue, 05 Oct 2021 12:21:21 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ecea:c8ec:ff7b:52])
        by smtp.gmail.com with ESMTPSA id s19sm1482211pfh.18.2021.10.05.12.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:21:20 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF
Date:   Tue,  5 Oct 2021 12:21:11 -0700
Message-Id: <20211005192111.14732-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform data to initialize xtfpga device drivers when CONFIG_USE_OF
is not selected. This fixes xtfpga networking when CONFIG_USE_OF is not
selected but CONFIG_OF is.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/xtfpga/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 4f7d6142d41f..59b7f11f2a3e 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -66,7 +66,7 @@ void __init platform_calibrate_ccount(void)
 
 #endif
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_USE_OF
 
 static void __init xtfpga_clk_setup(struct device_node *np)
 {
@@ -284,4 +284,4 @@ static int __init xtavnet_init(void)
  */
 arch_initcall(xtavnet_init);
 
-#endif /* CONFIG_OF */
+#endif /* CONFIG_USE_OF */
-- 
2.20.1

