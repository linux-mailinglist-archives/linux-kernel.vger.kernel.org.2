Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0925A3413F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhCSEEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:03:40 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3570CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:03:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so4009180pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryeZqjeyYgMVyJ2yaoJp0ylfGz6ueh5H5F2dT0FCD+4=;
        b=NEapts2xA7NIOuh03lb2AfHJiMCEq2c9+HhCbqNF1ZLNnT3sOAOrgUHGF8LylRFR64
         54Oo13jXEFjx27m3Blc1t1sOFcxy2ajFjm48s2K2HdKcoj/R9LPGBV7r7/+vWshTgyuw
         lTv23UVUs7HckciSLX98yORfNgmVndcjlhnuzx+r/LB51spj65OJBzqVt8rI2OdTa7AF
         1IXKDoP7EQLYyB5prCP6meBtuGt0JThbFkswykK80FWRYblqrP6pC3e77L+nWCWZXuBN
         IIBuMO1vYsVuROQiMUKF2zjoBnw1HyGirYSYI/zFlnLGo6TFGUyEQx/x7UA+Du17zsZd
         S5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryeZqjeyYgMVyJ2yaoJp0ylfGz6ueh5H5F2dT0FCD+4=;
        b=FEXQxQssoxVvPSuJkZioPXP3Pxn4e4ECzY5OiTSjrRLl+4r4JFEr1zFb8YDBA2QNws
         e+A4eP8wqG8YOxE2qj/afOJHpKqK3rVlkidv1RCr1tXX+/dDXDqMaGm/QnGkpROPYVPg
         Aa5AWRGUzCdnBXkk2j2Ofei4imb9SIBsOZJjhLwweiX0NAHsXBrBq9keAwKIJEvTjW0I
         Zj6QcV/fzBIdWPlRWph2RyG9hXueo/z5Y5t9DqJAnqvMSFHYWgs5YRI5F0Ime4c+XdAW
         sEUA84TABLFjALUq278sV3zvBqJYM4jVmzNQmpbVzN41mTBRLnyWX+QWXch+MUWmGY5w
         ZfPw==
X-Gm-Message-State: AOAM531LC7FF8Bk/8rb0Ia8qFLXP5x5yee3rYehlcK0EPrgKFulEOGhc
        OQpIlfILiSDqjZAEuKiAelY=
X-Google-Smtp-Source: ABdhPJxZ3c4SvE803b8zFFu+UyX5aqgBp0K5SuPW9aexu1KTNF02FpBMiTobs5HTmQueK0iWEmUBOA==
X-Received: by 2002:a17:90b:fd2:: with SMTP id gd18mr7792951pjb.115.1616126617718;
        Thu, 18 Mar 2021 21:03:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c24sm3752517pfi.193.2021.03.18.21.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:03:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:SWIOTLB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
Subject: [PATCH] ARM: Qualify enabling of swiotlb_init()
Date:   Thu, 18 Mar 2021 21:03:33 -0700
Message-Id: <20210319040333.183827-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need a SWIOTLB unless we have DRAM that is addressable beyond
the arm_dma_limit. Compare max_pfn with arm_dma_pfn_limit to determine
whether we do need a SWIOTLB to be initialized.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..8356bf1daa28 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -301,7 +301,11 @@ static void __init free_highpages(void)
 void __init mem_init(void)
 {
 #ifdef CONFIG_ARM_LPAE
-	swiotlb_init(1);
+	if (swiotlb_force == SWIOTLB_FORCE ||
+	    max_pfn > arm_dma_pfn_limit)
+		swiotlb_init(1);
+	else
+		swiotlb_force = SWIOTLB_NO_FORCE;
 #endif
 
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
-- 
2.25.1

