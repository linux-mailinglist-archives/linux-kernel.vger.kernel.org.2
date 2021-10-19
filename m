Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4489433C85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhJSQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:41:08 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:33723 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234377AbhJSQlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:41:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 05A18580FA6;
        Tue, 19 Oct 2021 12:38:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 19 Oct 2021 12:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Pc6itoB43a0du
        3xvsVw42627DuQ30enUuCWOyiMqqSk=; b=L+91XSFhczFWo9O4veNnaBiEmWsUL
        TIY7sVbTSXSARX6kBsxtBuWxF6B7sTIHfhnzXtGt+95k4FJgXIqaIdj7waQ86DjK
        PU23fziM1DA4vo6jiP9/pmNtkIpcFidMX8gH4awMq7qThX11Oxtq/UBGsxYC2ibq
        Hn2+WtGcxRNnbdsJLnCKctxQntEeLVhQMrb/dHb+rnwyETemj2KXp3C3Mxo9XEjA
        W11voY7D3Q1zpvvF2T3e6CU7FH7F6StQp83eSqn8/kdvo0JXjIMx/juq2+sckcHq
        Bu21/gk7+JQM4upkzAeXeCB/dvtRDFrUVSHQVqqlZegriCySN+z1kEcMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Pc6itoB43a0du3xvsVw42627DuQ30enUuCWOyiMqqSk=; b=VTQGR+iT
        jz0nEwmJRe86D50NysZi1Py/A2/Qqf76VxPuSuQNqaBg9vDkfCdcOJOwlxaobSZw
        NmR+CIeD64nGs8AhJ6RCeS71SvL+mIFek8V65qbpCqmtemUd23yYUsO24yRLWA8O
        xYsXPvXdzDq+2YUsp+5vhKPnc7K6Pq0GkFTuW47OTc5TCJ9151adSOXT5rktuL3Y
        2lhdjSzJdcHP1RuduDc9+AbFnEF404wLjeQoXxmoXPcx846Z4XsrIB+9eTY2NyWB
        zl404sti2Au34AbpSvRppY1vguvn01D39RBZ60EF9OFQfD8aOp5fDf1Rbgx0Uhww
        FO4NKb6iarmy+A==
X-ME-Sender: <xms:m_RuYa5LmM56YxwspPu-nuwpsJLhv-iYMkHGtlwSA35A07M7LKgkXQ>
    <xme:m_RuYT6pNLuIhbQBjwF7DwngdLgRgLFcV7qOBG_XU1BUAqqaHGwHAYvKoDn3ugUXa
    oHEw9nkNf7_67rbVQ8>
X-ME-Received: <xmr:m_RuYZcbAsaOr5HSxiD5CagXMj09XCMNk9Ra5oUgN5EQnuqrTLnh0FZwg9-te-ndXFGA7TO1N-kMDZ46oIOlNc6xm0aHUBUkSUJ04O17TBBxQFEqchnfjLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:m_RuYXLVxtlew9ypWl4Z8lLd-CHeuWEW_B-XHJ_4gEo_vrvB0a4nzA>
    <xmx:m_RuYeIRyTo4BCZJ4G0UFA4BAah3pCneBNOTlwiqW3pNMBg-8I7SDQ>
    <xmx:m_RuYYxF7KbPJEtuRrN_ylaVOvMJ1g9UEI_aGOLvwo6vVxMeLc5bkw>
    <xmx:nPRuYbDg_-nzMUC48vIKaP_fjEh498bhKxglwMpOxhqTR-YVq78h7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Oct 2021 12:38:50 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] iommu/dma: Disable get_sgtable for granule > PAGE_SIZE
Date:   Tue, 19 Oct 2021 18:37:32 +0200
Message-Id: <20211019163737.46269-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211019163737.46269-1-sven@svenpeter.dev>
References: <20211019163737.46269-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this function *probably* works correctly without any changes for
granule > PAGE_SIZE I don't have any code to actually test it and cannot
reason about how the function is supposed to work.
Disable it instead until we run into a use case where it's required.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/dma-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de5040b65529..17f25632a0d6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1249,9 +1249,15 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
 	struct page *page;
 	int ret;
 
+	if (iovad->granule > PAGE_SIZE)
+		return -ENXIO;
+
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
-- 
2.25.1

