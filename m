Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3448745B1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 03:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbhKXCRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 21:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 21:17:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:14:10 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u18so1265712wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 18:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe4o5Gm3OMdjS63wMnh/ZOlXxoaUWg1l/47qZWglxBI=;
        b=MOSdU1seSeuiSwHUZmk1UhtByoEtzLLRNtdxo0+O4R/7fz4+UeAjOE/Mk9Ow0CSnwq
         3gb8XKhUiw9t3A2lNpl3q5eiIcczC0zHyXPk+jtyM7uSucofkydcKRAj9qKlU+f450YM
         LKM1Suhlyj0yFzGEXiMjzWFh6oCfK04M97deJZ7clVgwi9v7EiyH7UZIfMFbssRYuF1L
         Ih3dfWs8WVzPdYnFBSF/YqpT8bXE85pWjbkFg6Dd1iVfQsXbF0TVt2Ng4cN0fOaW5cjK
         omgfVDAqexKTRZG8mxcZXQaPMnLyKSNmw3orJQkcewv4zXczLHCd4PHMKp7u59S+PCSH
         AbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xe4o5Gm3OMdjS63wMnh/ZOlXxoaUWg1l/47qZWglxBI=;
        b=6yNqwUVcKdAgcBdJ+2gavlJsRWRWn1H6u1GZ71VaKV/Z+6Ca15V69ZKQWFdQCJbGrt
         QpuOgd3iNrq7X9ebnSqByMf88hR1cVin2B7h8Qo9eKcJn2FCfu8/wyALcnEsMFukhUVv
         Q6zgGLFPtxlK4ppM8OvG+D9S5gXsMOQD3Ps58uMv2O06xDqhdvPuHy52JiIdlw12W8+j
         JKRmjOYvlibyxvRX17OYJZKc0fBLi55ksL9yy7mruvA2pQfW9zrZyAADwiAf0UX+gA/L
         tUsVmmBGsu2Wr6rKayppxwV/tbeDpdzfWoCLYgvo9TnjIBOugd2I4MaqotjlRZAhqJDR
         u9rQ==
X-Gm-Message-State: AOAM533iRGkXQOwxUxerH+uuDemvplZv94ET/ukc07UTHU7TD50//iRW
        y4/C9GIp7Cx7f0kCay9CWQ==
X-Google-Smtp-Source: ABdhPJxya3jKNOzfMuNmHXXGJbUVr3esV/uhag0CYzu7qmZmXnsDI9xK9zK5GsJCJLZTYTGmQtQ6lA==
X-Received: by 2002:adf:e848:: with SMTP id d8mr13671517wrn.3.1637720048717;
        Tue, 23 Nov 2021 18:14:08 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id c6sm3909458wmq.46.2021.11.23.18.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:14:08 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
Date:   Wed, 24 Nov 2021 03:13:25 +0100
Message-Id: <20211124021325.858139-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the submission of iommu driver for RK3568 a subtle bug was
introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
the other way arround - that leads to random errors, especially when
addresses beyond 32 bit are used.

Fix it.

Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---

I've found this bug, when testing the recent VOP2 submission, which is
the first perpherial which uses iommu for RK356x. I could use it on my
quartz64 8GB board only, when limiting the available memory to less 4GB.

This patch fixes it.

 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5cb260820eda..7f23ad61c094 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
 #define DTE_HI_MASK2	GENMASK(7, 4)
 #define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
 #define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
-#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
-#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
+#define PAGE_DESC_HI_MASK1	GENMASK_ULL(35, 32)
+#define PAGE_DESC_HI_MASK2	GENMASK_ULL(39, 36)
 
 static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
 {
-- 
2.30.2

