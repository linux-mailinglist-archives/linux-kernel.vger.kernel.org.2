Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC7E38FA83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 08:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEYGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhEYGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 02:12:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A57BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l70so21903878pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
        b=J6FREe56XLQaskKPKpIZY8o/6rKQlqbWXWrWOfgs/0PcIBeJl/RrtbGyhl1knOo5j7
         3pPDCa6SHqmCtTegO+vl6A8NaRyI74dSAM3qNVn06MPqtP9o6UEW4Bov7ttLqs3w5NwT
         zbgKCQQwE5vZaQBL73afqhlGWftYxCEuscg0htIrTCAP8lXFtpzvaOww/VBzCAu6b5ko
         eIo5mL0oVXbIh0F7+tdmiWPXP7iLseDh73Q7/5GCoIjwzjiL8dEMyzY2Mm/zYgpg5qTw
         iI3GWdrGSYT5FgXgBZk5sKxcGoAc8EGQOWzc0ZDM7DFTg6TS6naiBR/7AFNat6MrOKla
         SQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ps8y9GbhEBsLGzJr1aFWBUm18dOXtTvNE0fP/wilCNA=;
        b=CrnLZVZvu58gBK/llIo5mr50fV4a7VytVVOH7E4xW9dW81zWmB1qnorhEhom88VCbj
         I5jih1ewLTIJpSdqfENhKotwhJaDv4tGYkQZrhSw98yYSCVjNZDbgUiLn7CklAxm43Qm
         xCNXMXf8egfE3AJmgjL3BRGDmbeFmOgFXbwWOIjQkwe5sNJvwba7Pn3t2iyuWSOBg3jT
         fD6Qst0+zR7kg9tmTHJyanoWfo+w5meRyX2Mv5HRHT3t0eeENnDxymAUDX1CFVRoUWsF
         Ebp+RoxHdO97TsP3vB7zdBdv6bqiU7koa8mzoDZE0xhBs4ozgBbjPE6zW8gzB0HN3tFa
         mgUQ==
X-Gm-Message-State: AOAM531P+vTpsDaLpCv4LNGjM30QWdE5UmSuIyGUdt29qlxdulEBR0KG
        iuJlUH3aZ+CvFuxPWZ9ypzQ=
X-Google-Smtp-Source: ABdhPJwmcRO1j0zX20F/VDoYPpFBrwgF6Aj3KuLNE0KTzIMXQkWwqWMAnAiOKWrCXg/i7eEibVFYhw==
X-Received: by 2002:a63:9316:: with SMTP id b22mr17750398pge.70.1621923075049;
        Mon, 24 May 2021 23:11:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id h3sm12452301pgp.10.2021.05.24.23.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 23:11:14 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iommu/amd: Fix wrong parentheses on page-specific invalidations
Date:   Mon, 24 May 2021 15:41:56 -0700
Message-Id: <20210524224159.32807-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
References: <20210524224159.32807-1-namit@vmware.com>
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

