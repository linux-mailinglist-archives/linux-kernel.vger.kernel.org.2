Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A51347B99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236450AbhCXPDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhCXPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:03:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1115DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:03:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 32so8684977pgm.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FItyqxViIAmB8amy4A5vlzdR20mnIAmC2uA+KNkY1Gg=;
        b=Jq0HmIdidI3kiESpgQ+BC0vj3o2mde7P42Kiw+pHEnQOKhGpfCRFTJoME2bvKapawN
         WP3pLEgKYrF2sAzB+mmJAvjsOcdvNMbmGjx4Ocrubfo7asrx5cIXJ1m44gnw6MYYZHgK
         0vPgZFKLr1mCyHexFNM0oCV2bvsUhTT+mT/NMt3q5LtQENk6Hm94IGJAFp7BLPtqtSKB
         1dGEmDy8q2ksos80WZ2TTqJ+5mZr8kzVPJpPj/qqa615R5yJzuxPxd1NwgYsyc12UK1J
         LMI1FbMgNxiKkj/uloEBxOXsYX4tWQuP+aOM4rAIvmWEz9JYOW+bQIIz0RAOegSdVi8t
         SaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FItyqxViIAmB8amy4A5vlzdR20mnIAmC2uA+KNkY1Gg=;
        b=J8ESuUYnEXxfnqlMEzLxPktcgC7WqwPMaZYK4IqeIiO8ZShXzt4nnVZ0LmlAUlTQkB
         8FRhGgVw1PCzI+DnPIFlVx0nfGBHnmO6hbw+yHdhA8PV3I9RJIrBGlE648ZWMHO0pPHM
         AlW63QD+j+c1eG6nrzZSEv4nLKGdWb+6+dQbIAMZRGt0y07JUmslEAh10qk+G5wTxksC
         VTCD8qtGDpV7pyanEwGTbp5Bw4KtcnVERpT9lCMv17nDgpLpFnWaLbYYXQZf/ov24EvC
         eNxKNeIkTkA2UgGKHO0xC1G43jj2aLVCmWf59Wkyp+Ut+zQbvRCCOrBmMLMG98VRJXfN
         FGig==
X-Gm-Message-State: AOAM532bGdtFFOLVAQvdIotgvl8g66HajDZKR7FMUXGppZhhRSGf/hPl
        6qDcE8psQ+UHmrs8z8XqQBk=
X-Google-Smtp-Source: ABdhPJwFpEAvfqb+Zf7dyN0fn8XR4KvnxGeNssHrQoAba19JdnU4KnnFx00vSGIC4VzlJ00m72fkzw==
X-Received: by 2002:a62:683:0:b029:1ec:c88c:8ea2 with SMTP id 125-20020a6206830000b02901ecc88c8ea2mr3309240pfg.27.1616598203601;
        Wed, 24 Mar 2021 08:03:23 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f2sm2916749pfq.129.2021.03.24.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:03:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] riscv: Do not invoke early_init_dt_verify() twice
Date:   Wed, 24 Mar 2021 23:03:12 +0800
Message-Id: <20210324150312.20535-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the setup_arch() of riscv, function early_init_dt_verify() has
been done by parse_dtb(). So no need to call it again. Just directly
invoke unflatten_device_tree().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f8f15332caa2..2a3d487e1710 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -255,10 +255,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(dtb_early_pa)))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
 	misc_mem_init();
 
-- 
2.30.2

