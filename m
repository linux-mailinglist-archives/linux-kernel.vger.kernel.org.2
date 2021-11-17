Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BF454F32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhKQVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:18:49 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57655 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233213AbhKQVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:18:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0D6945806D0;
        Wed, 17 Nov 2021 16:15:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 17 Nov 2021 16:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=wPBXm1hEB0gt3
        4jZTLq7duc5h40FbhA9Yj5in8Tpo00=; b=F2QEnSh7HLLmJz1viZ1cWsA7UicA7
        SX6lcHbylYTro07UIqm4ni5LevGAViojKswXZtIXWTskxfudYwpUJOPdmHGZBSfH
        cl9oVUVaR63S6MzMXJndhY8ZkP36aTJcOVfI7I2Ro3j1I7+L5x3O6mEOaLHkLIK6
        hs+4Kk4JYIWYuupu1CDpnVqUGy1c7VKIQayM+AokxbDeLao9I4QdZj7AKEI/51lm
        UnWXi3AjNkoV2ext3XWHhf5zRNReIeYZAW8VUsktJAm6m5E4dffYFcJlJZNKrs7q
        JUOm15DCgL08/0cF9R2ifFdXGhsVG7KYA/28nAoeeXRtRyX4spJY3TnDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wPBXm1hEB0gt34jZTLq7duc5h40FbhA9Yj5in8Tpo00=; b=cNK5VYz0
        y3f1fiaPuvaRg193CzV90rdNs4a03fEjmgh7wR4cImrGkxlVPZK9r6Hna1BREClu
        FMRubxTmsD3MuLKfMEvmVgzeQjvcnxG+OhB7zZ7gn0rUYbrSHqEXMDaoh4iv+j7Z
        NIV1MMUWg1Mwws05GG7sj2a1n0/TsUpULvxy+v+dO/BoDH0cGzeYOZCIUqVDX1LW
        8U8BSd6fWPJFi5zbqJ4d+rtfJN6hQoXmuThRTigu0SMaESyzgINl9b9X3Ww0fpTX
        nx44qttS7VWKIREVUJSSJz4nYgu2JNH1D3fSxswgQVke/VqJtwyHbvTGcXPLoRLu
        G7qnGzAWqVAO9Q==
X-ME-Sender: <xms:8XCVYb-8YVgQ_cSB5hPWT2Dktmm2xjfIY6Q-QGTrIbIEumMTDyWZ7g>
    <xme:8XCVYXsTO1sHLIcud8x8k06y9lU_xpSJREtLPMplFJarV3m25fO1tvvpnSmrBFrB8
    AqftYI_PmBGZxBZsr8>
X-ME-Received: <xmr:8XCVYZAlbIJdWooPIjPft6ldGrX8nzBUvW2RRVQeZ1iLkYzFcOEyaH2ZrOJ0t6_jjgjPxI5NKh4eUU-ORgZgFkX19qLKdBilNoyBWtmwDyE7t3JmSi7CWbUSUZsZyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:8XCVYXfKbncoClymTnwTiZs_EP05QpukhSSKdPjnw3hwR3dFYzzXmQ>
    <xmx:8XCVYQPjCni0qVGq7qj73mP_RtVafoXj12nNRPiEmY0WjhquJX226Q>
    <xmx:8XCVYZn2QUYJUp1rGSKIQyHY70J0t2FnRRFqMncbXkyBO9Oy7KZNpQ>
    <xmx:8nCVYRE8TB6uAAQSWaaxbnNoLAzLs2W8SlcCX1PXnoKhggW0b_XVAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:27 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Janne Grunau <j@jannau.net>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] iommu/io-pgtable: Add DART subpage protection support
Date:   Wed, 17 Nov 2021 22:15:07 +0100
Message-Id: <20211117211509.28066-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DART allows to only expose a subpage to the device. While this is an
optional feature on the M1 DARTs the new ones present on the Pro/Max
models require this field in every PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd9e47189d0d..a8c660b8b3e9 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -133,6 +134,9 @@
 #define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
 #define APPLE_DART_PTE_PROT_NO_READ (1<<8)
 
+#define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -273,6 +277,12 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
+	if (data->iop.fmt == APPLE_DART) {
+		/* subpage protection: always allow access to the entire page */
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+	}
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-- 
2.25.1

