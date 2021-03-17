Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9304933FB39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhCQWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhCQW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:29:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:29:53 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k8so236094iop.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJHY8qu/zb8ROas4WV0ki8PTfXxIvdJCtkC7EQYxU/c=;
        b=uXrdEig5Q8aCl1RmZxxC9heobx+8PUPj8zBCf68sGS3hl/B21E3YDLBvV60dnyzv/a
         b51ixW1V2GvEMmyfRXpf7wx2nkZMeMEcA9zgVdNHajKV6tdVTlM1xZqctm6kdr1YQEqR
         iyTUFD+jkrXmvLoEWPNvK+VSG4AQWP1cbOm4AKCOJxuQm9KZZTOnS4fCzO13zHBM053d
         DoRc/gAuYEltZVjBA3VXsQKMuFk6fqASc+AJnP0N1cPnBirs+minRT/G/BXYTkT0BEvC
         wUNog2ve70IdlV2bvX/tBr0MDbdjxJ4ZJbVEEOJwWoY7Vx+Yc15EXzaB7yVEoLjHNhKx
         2OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJHY8qu/zb8ROas4WV0ki8PTfXxIvdJCtkC7EQYxU/c=;
        b=FHmKXXbJgDBfN9e0sMdwGpMAbfJwLTauKi0tz/PVNbjzCqdLhiz0IHWL51Khrmcdll
         xjU70EqebRzVHicQvz82/+43yMAGpzcXjymRmFGaNvVSsa7wVg1UFEuin0QnRUY14oGD
         UWlTLhCZ9L2lFRJ6FjwHWjmtBorW++k+iV1UKkwoJTkPyy0dn/QF6Zhk6LLoW9Wx7r7m
         ABd6ni8zZZ0KsCQmQAKJz396Q2Xc9FdNPkJb3AfZ6FpwxNCcTwsDFqHXZFDUuHet6ttQ
         VKbbwh5K235DYyr9lW/59YG+PobiiBgcviW78k9rAKV+M83PtoCM34gkJIqJ87vdKhU2
         iDiw==
X-Gm-Message-State: AOAM530YsczcRGg9xXLn02nA4S3gDEOdoVey1knX2vWDvgT656hWU2/t
        thmR6WPFuV/jrKL9X5ZRH2X6qA==
X-Google-Smtp-Source: ABdhPJw6YnjvWAUfRm9waslOSl/uRPGYD7PG21A0gPfUrkpwUIetoveKR7JKJzqsngPOskX6vQcdPw==
X-Received: by 2002:a02:c8d4:: with SMTP id q20mr4593415jao.90.1616020193197;
        Wed, 17 Mar 2021 15:29:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f3sm176405ilk.74.2021.03.17.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 15:29:52 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] net: ipa: fix table alignment requirement
Date:   Wed, 17 Mar 2021 17:29:45 -0500
Message-Id: <20210317222946.118125-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317222946.118125-1-elder@linaro.org>
References: <20210317222946.118125-1-elder@linaro.org>
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

