Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CC451BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348917AbhKPAHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:07:50 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:49133 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347618AbhKOTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:40:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 49F79580604;
        Mon, 15 Nov 2021 14:37:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 15 Nov 2021 14:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=AnymEuCYCocHA
        Ds+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=xB60fto7b9p9zKYRdTNdwVmSChO8D
        SsoFs9Iaft6I6qyt8nf1cWMRPpERDLgYtJOY0e4P4TglBSN2AD5X5hepF72gu8A9
        3bvt5vdgmvsE1/Rmxdq98v6ijYxlrVXB08X4oJCo6XWKh+j/x3mT3xJBTVhK9UTt
        gwPKsITbiYfpYQR72+sVMrihaWedOfxpwppqGJoxAVxys5BWkP3r8uWtHMgsBZEP
        L8ilWVDaa5mKsOtUesoBnZRwPXg4inqJjIUHFvHiZH7aFIfqcT+9zn68o17HRl4t
        cso1oqksai7tfAsNxYbjKiE9enRRMgsV4ASU/j9Z362aYKw93iODw8t0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AnymEuCYCocHADs+cC0A+imh3dmQP2pOP/ONvg/OKOg=; b=ARzj9GHt
        89g8ElhfXy2AeWhnjWydjJMa7fp8+4jCzsf+jp8rv0KH7rW7KKKl40wkQOQP06K3
        sop3YEKBNBAa2jUfpJo9pZ5EXaNJDa8zswYcftk3XMqBYiSXrHSa066NfWqNn1Zw
        96W9bSlWUscrUpyoAwaJMRaf23fi7ZvWYnEN9xPvIO48sq/n6KAOCEpZN2Rd3MeP
        9YghOUKXbxaU+2GuzQ/JKc6O2blT1W9oJ5qdLMt1YGGj6temHwPaGPTJ0jVGypV3
        djHnqcVbuQ/oN//2e48ZaqMMYe18Fm+pc0vyoOAp66vhtkFhOqx5WInoUtNJLyTX
        Vb0drxpdVv3WIg==
X-ME-Sender: <xms:D7eSYepi9_Z8uf-YaHwqRwLRPKfy8_CJW2g9ecIlmuCKhdZavlICEg>
    <xme:D7eSYcp14c186VrFe3DZgntVxmtYeZCcVNEh5-NBfBfe2e5nELed8sVqHe72rpUXU
    XvaoGjEFFbgF0eo_Q>
X-ME-Received: <xmr:D7eSYTP7avKM76qeEnjbyf3F9-6N7NXUyyLCQRFSS4ZKQoxTp6EMnMvUHusYBIy8Gnf1HltY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:D7eSYd4yJGehSQMDMdWB_xRmvIPDOk3IdN66w9wppYPuVduHoVtIyw>
    <xmx:D7eSYd7gCBUQmT2CMLvfkRawMDbo81AJQ-SFsg-Cja9aKjU1iUGJ9g>
    <xmx:D7eSYdjOXUCZtIHGbIbHMr9SQgmvy-WOZndHNEJ1sY9TXOEVGqurhQ>
    <xmx:D7eSYSHHQ-Is8qJNgu2aA7Y43q2g-vUX36d-mkxiqCvX19_ozECB1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:50 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 3/3] arch: powerpc: adjust fadump alignment to be pageblock aligned.
Date:   Mon, 15 Nov 2021 14:37:24 -0500
Message-Id: <20211115193725.737539-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115193725.737539-1-zi.yan@sent.com>
References: <20211115193725.737539-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

CMA only requires pageblock alignment now. Change CMA alignment in
fadump too.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/powerpc/include/asm/fadump-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/incl=
ude/asm/fadump-internal.h
index 8d61c8f3fec4..9198f20b6b68 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -20,9 +20,7 @@
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
=20
 /* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE << pageblock_order)
=20
 /* FAD commands */
 #define FADUMP_REGISTER			1
--=20
2.33.0

