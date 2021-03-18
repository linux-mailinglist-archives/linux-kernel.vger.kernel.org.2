Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE25E340DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhCRTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbhCRS7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:59:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6EC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e8so3437674iok.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJHY8qu/zb8ROas4WV0ki8PTfXxIvdJCtkC7EQYxU/c=;
        b=Q9Wc6XbbM16YwfxDXr3sNWeSKz5zpvJ0E/Um5exSMglmBlQkVU4K7TDXNRXvmxctG0
         bd2x3/DTy7h7opWcMw9wF27cNZXkZ/tVEpg3RBBFDNlw42KNGWuGPqiISn5sNW/tGdx+
         fm3F8uOHIP0SqLl+hHNV5VgGSC6nt82g+M+rVRLvnK5pBckYA3DjPBWqNIxwW5C4BlSe
         gQzRGsmXe8h/9QQIz3HrLnQG4KcNUwngLEiepeEWCN4tWnk2SNEK8yj6MWqYs63kSims
         qUOuuOOeygYDjxTcJnPR/re3reqGogVna2Tme8PqD3To+2listO5gM3ouIgPdQwdgO/M
         HfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJHY8qu/zb8ROas4WV0ki8PTfXxIvdJCtkC7EQYxU/c=;
        b=a89MalMU8SUVmrZ0hQ6KMVXgUQNp5hsrItKbxlytgX1Z8AfZHMaVqQ1XcXJ95R/Gtr
         Q1xnNq3wFfCVUksZ+BbHRWrHDrhFFqVsFYNKOyRfQCciou6oEYZdGGEeALXHq0y2EPIy
         DtqkDMmKAxCMCD6NRVwCKpzICNXCvya3bQGX1YhRGWBG7+ySb4TTtopv+CadgulDD4nh
         4vbmZYGAgDtdZOJzDMxpp8Y3Oty/XsaZVn7gNAuR5hXY8eBD6INBzaSEhFw3yR/Fw/1D
         pbgHClHf2x/7FTlPZhi0y1PdkM148JmAnnPDVYQFtgVbYPjk0QSpTw9fLYSWAHPkhH88
         uC2w==
X-Gm-Message-State: AOAM5300Ii0aIAYGxEBFjbObMs1iFAUfq5smSwUkPloxJ87p7g+WCRMc
        5vMmaQUhrv2qKW6ESm6ST/cfKw==
X-Google-Smtp-Source: ABdhPJzF3uG8CQhldT167jLqJ4M1hKxnKZ8EdjhwowQlEa4cPBe19KWdhkRl2d+jVcjsqc3I3Gnruw==
X-Received: by 2002:a5d:8707:: with SMTP id u7mr44175iom.18.1616093976458;
        Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k7sm770359ils.35.2021.03.18.11.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 11:59:36 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/4] net: ipa: fix table alignment requirement
Date:   Thu, 18 Mar 2021 13:59:29 -0500
Message-Id: <20210318185930.891260-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318185930.891260-1-elder@linaro.org>
References: <20210318185930.891260-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have a build-time check to ensure that the minimum DMA
allocation alignment satisfies the constraint that IPA filter and
route tables must point to rules that are 128-byte aligned.

But what's really important is that the actual allocated DMA memory
has that alignment, even if the minimum is smaller than that.

Remove the BUILD_BUG_ON() call checking against minimim DMA alignment
and instead verify at rutime that the allocated memory is properly
aligned.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index dd07fe9dd87a3..988f2c2886b95 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -118,14 +118,6 @@
 /* Check things that can be validated at build time. */
 static void ipa_table_validate_build(void)
 {
-	/* IPA hardware accesses memory 128 bytes at a time.  Addresses
-	 * referred to by entries in filter and route tables must be
-	 * aligned on 128-byte byte boundaries.  The only rule address
-	 * ever use is the "zero rule", and it's aligned at the base
-	 * of a coherent DMA allocation.
-	 */
-	BUILD_BUG_ON(ARCH_DMA_MINALIGN % IPA_TABLE_ALIGN);
-
 	/* Filter and route tables contain DMA addresses that refer
 	 * to filter or route rules.  But the size of a table entry
 	 * is 64 bits regardless of what the size of an AP DMA address
@@ -665,6 +657,18 @@ int ipa_table_init(struct ipa *ipa)
 	if (!virt)
 		return -ENOMEM;
 
+	/* We put the "zero rule" at the base of our table area.  The IPA
+	 * hardware requires rules to be aligned on a 128-byte boundary.
+	 * Make sure the allocation satisfies this constraint.
+	 */
+	if (addr % IPA_TABLE_ALIGN) {
+		dev_err(dev, "table address %pad not %u-byte aligned\n",
+			&addr, IPA_TABLE_ALIGN);
+		dma_free_coherent(dev, size, virt, addr);
+
+		return -ERANGE;
+	}
+
 	ipa->table_virt = virt;
 	ipa->table_addr = addr;
 
-- 
2.27.0

