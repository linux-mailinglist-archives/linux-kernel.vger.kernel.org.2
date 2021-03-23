Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B81345491
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 02:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhCWBFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 21:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhCWBFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 21:05:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC00C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:05:08 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id u10so16625747ilb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 18:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YG4yj4hsnZR/4f8rre4fgjJmY4yF5aIvU/TNzt3CIg8=;
        b=WlBd2mNv5+r5aANitSL7zDIq2/gfELDxvGn4jkx05wYMHLgusvwkdskPJwdoBpXioa
         To+ABYDeKOUA2Ep0VsoKyuLhWoZkGKZVe7JoDugC5k3baGfd7SW4xS2GU0+3MwNSXFl9
         gNkGI3v3I/dQjOl/9n2DKRjPei18eMs2D3E3QUac7/p0t311lA7I6Cfpn+5i9VkYylPf
         anwHCN1MTP1YW+IsBRBElDZDc+8QCw/rE5eQZzKxWcAMPPWmWvGTpG7/EBhCumN78glI
         9sNVq6QaUqn6bKo8BhMYIel4/1igijNtcsvHDj+qqVrXLDXCDKEL7XZeJZHIQbsXKVkS
         cfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YG4yj4hsnZR/4f8rre4fgjJmY4yF5aIvU/TNzt3CIg8=;
        b=E7sCV2CfBwF8b5cRIpxJJn0LeJqxvbuIALP1GncrhdYQQ7VkOBu8x5tLVYl1fzfOiX
         VMyjifbKQBmmT1JFTB/yRmZrJgOI6qVYbd+9EaMJpdkO0Cc45s2jFUGYcTeN1zVPZ80S
         yrCSaKLO4mr2y0YaLJztqXv6ynpdMtGMlcvbW3ArfhSXFi/VCjBAZqRIWjT4OADAMf+s
         /qTonKFXNDsleg6P/yNW9O33B9RHzNqet4sLtzQ9MWh+Hm45amXKpNQ9G97GTp9i9DkG
         0qnw/6wp11SEMUF1k5agOfx+8sRbKuBkVJyhASI91X2hEbm7gFol9lop9slVZS0M8uD8
         eTwg==
X-Gm-Message-State: AOAM533y5+MG7WBBgtXCf/jUqr7dqBQaxHWk/Ub+hiWSUvVaQi2ReMsI
        8lpaTCu1xcqQeQ94H0VFMT4cng==
X-Google-Smtp-Source: ABdhPJyTyc9pjJIfkmtNXhpc0Cb81uMl02QF7k4vNBgPaFGV5ZzBOJfA/w3SnAzjvna5vO8xmk7iYg==
X-Received: by 2002:a05:6e02:1aa3:: with SMTP id l3mr2651538ilv.31.1616461508243;
        Mon, 22 Mar 2021 18:05:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c16sm8638702ils.2.2021.03.22.18.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 18:05:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     rdunlap@infradead.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ipa: avoid 64-bit modulus
Date:   Mon, 22 Mar 2021 20:05:05 -0500
Message-Id: <20210323010505.2149882-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for a 32 bit x86 build to use a 64 bit DMA address.

There are two remaining spots where the IPA driver does a modulo
operation to check alignment of a DMA address, and under certain
conditions this can lead to a build error on i386 (at least).

The alignment checks we're doing are for power-of-2 values, and this
means the lower 32 bits of the DMA address can be used.  This ensures
both operands to the modulo operator are 32 bits wide.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c       | 11 +++++++----
 drivers/net/ipa/ipa_table.c |  9 ++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 7f3e338ca7a72..b6355827bf900 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -1436,15 +1436,18 @@ static void gsi_evt_ring_rx_update(struct gsi_evt_ring *evt_ring, u32 index)
 /* Initialize a ring, including allocating DMA memory for its entries */
 static int gsi_ring_alloc(struct gsi *gsi, struct gsi_ring *ring, u32 count)
 {
-	size_t size = count * GSI_RING_ELEMENT_SIZE;
+	u32 size = count * GSI_RING_ELEMENT_SIZE;
 	struct device *dev = gsi->dev;
 	dma_addr_t addr;
 
-	/* Hardware requires a 2^n ring size, with alignment equal to size */
+	/* Hardware requires a 2^n ring size, with alignment equal to size.
+	 * The size is a power of 2, so we can check alignment using just
+	 * the bottom 32 bits for a DMA address of any size.
+	 */
 	ring->virt = dma_alloc_coherent(dev, size, &addr, GFP_KERNEL);
-	if (ring->virt && addr % size) {
+	if (ring->virt && lower_32_bits(addr) % size) {
 		dma_free_coherent(dev, size, ring->virt, addr);
-		dev_err(dev, "unable to alloc 0x%zx-aligned ring buffer\n",
+		dev_err(dev, "unable to alloc 0x%x-aligned ring buffer\n",
 			size);
 		return -EINVAL;	/* Not a good error value, but distinct */
 	} else if (!ring->virt) {
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 988f2c2886b95..4236a50ff03ae 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -658,10 +658,13 @@ int ipa_table_init(struct ipa *ipa)
 		return -ENOMEM;
 
 	/* We put the "zero rule" at the base of our table area.  The IPA
-	 * hardware requires rules to be aligned on a 128-byte boundary.
-	 * Make sure the allocation satisfies this constraint.
+	 * hardware requires route and filter table rules to be aligned
+	 * on a 128-byte boundary.  As long as the alignment constraint
+	 * is a power of 2, we can check alignment using just the bottom
+	 * 32 bits for a DMA address of any size.
 	 */
-	if (addr % IPA_TABLE_ALIGN) {
+	BUILD_BUG_ON(!is_power_of_2(IPA_TABLE_ALIGN));
+	if (lower_32_bits(addr) % IPA_TABLE_ALIGN) {
 		dev_err(dev, "table address %pad not %u-byte aligned\n",
 			&addr, IPA_TABLE_ALIGN);
 		dma_free_coherent(dev, size, virt, addr);
-- 
2.27.0

