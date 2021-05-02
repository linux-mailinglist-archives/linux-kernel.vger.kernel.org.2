Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D52370AA3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhEBHGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhEBHGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E44C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1579504pjv.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
        b=nzAOPawlkFRQBAAKpT/I7SCsKt3G7/7pFFxpmCxNWUu7nCA7k/PR6WqLYOmSsnEfWF
         /SNPniMJHRJDDtKSXh6qsAZ35Eivh60QDg4VJpd/RfmS0lrr1T98g3+ItK15jfZjYd++
         lDjdK5AFe4JyBV9NN2qQOYnWhsAU/HaqXYx49DOu2cAApP8i9AFnhaAA7h9hRKY72WsW
         dhT2Y6mQWFSpZJPPs+fD8d3rOfe2n4qw0ixk4f5MfCn0UQTNFYKaDNm8UrazYPLbag/N
         Wtc/rE7BiMDsp/3X1zVMgDzLMC34egdoYXC7EDl1fhWLkARXvnZwfKi2/CQ3yb5cmLDM
         LXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
        b=pkVYMrXawDH751JgKCBDLScOQfjpoPIdJdfYv0lI5Epe0X87hlb2+7XRW2ofsybO37
         YV+zzhfgmMlH4HE6CW0Ib6+/0VR2OOgnXrXjnZ1l6bb63//h+68Z6STSjCfm44syEewq
         qUIrbIIm1q5pwjg99PX86sU2XQn8U7FHAwxQyP8v+qdDonNYmK3yuhaJkSWT5t6+riaV
         tF69rpA0tq4u1mEVTdX/Hq7bNjUSL/EjBCxYkVD25kMLxgz+1lCAVBxFfJX0Adh/FzMh
         WNPI18gk10QOEnI3mY5XJgjjnCg+ntTnRAVvswUD1msTHCDNGm+75zs5wjHHhNeKG48N
         tvvA==
X-Gm-Message-State: AOAM5313ryfpipvs0/7xX99elHtKg/bg+7gdqcWew0IZTrjQoCprGHA4
        xw8UejMlDXQdBdq6DGTbU9I=
X-Google-Smtp-Source: ABdhPJxPBy++Qp4ydPC32XHC9Z7AwhNX5sWUQVB7n/azwsoleB2uXIgRCFnMS3ZIsLSb1QE5ZshhYA==
X-Received: by 2002:a17:90a:7896:: with SMTP id x22mr14335204pjk.182.1619939110572;
        Sun, 02 May 2021 00:05:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:10 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/amd: Fix wrong parentheses on page-specific invalidations
Date:   Sat,  1 May 2021 23:59:56 -0700
Message-Id: <20210502070001.1559127-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502070001.1559127-1-namit@vmware.com>
References: <20210502070001.1559127-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The logic to determine the mask of page-specific invalidations was
tested in userspace. As the code was copied into the kernel, the
parentheses were mistakenly set in the wrong place, resulting in the
wrong mask.

Fix it.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Fixes: 268aa4548277 ("iommu/amd: Page-specific invalidations for more than one page")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 80e8e1916dd1..6723cbcf4030 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -884,7 +884,7 @@ static inline u64 build_inv_address(u64 address, size_t size)
 		 * The msb-bit must be clear on the address. Just set all the
 		 * lower bits.
 		 */
-		address |= 1ull << (msb_diff - 1);
+		address |= (1ull << msb_diff) - 1;
 	}
 
 	/* Clear bits 11:0 */
-- 
2.25.1

