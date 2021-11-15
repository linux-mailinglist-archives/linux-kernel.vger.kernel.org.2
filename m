Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296F9451BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350380AbhKPAHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:07:53 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48239 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347620AbhKOTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:40:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 490E5580631;
        Mon, 15 Nov 2021 14:37:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Nov 2021 14:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm2; bh=YFFMYVihWiPWk
        tyuxrOQDQ9eoOlotAMNNpVZGNCElO4=; b=0KSmGcem0XSmBLi02KfOtT89MOTZm
        Z4IwFx+QEXZqMm9++dx+bVPqeYflclLgTijihCkbG3s6+Eky5F2lf6aFaXEqLRHD
        QXWVVps72mZG/SDaBR48uA/py4FZ/lrH/C8H4IYNePPY1SMkE7zG7RLQBeJ6iOgb
        NWmjiIROVXymlsb3OlpA9NcHUZYGin1/sGkSx5cV33lSBFFerYaA4a042ztvizP9
        lYIZ/7miQQEPhi3OzlywV4dxvBWTb/4LVxVzhZqHze5C2nL8kZ0+Szraiw+sWqSL
        YhaD1bH8jWoPpwRqkwRJkpLfmSo75LU4pv8XDfIkpXx9LtFqufoufdDtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=YFFMYVihWiPWktyuxrOQDQ9eoOlotAMNNpVZGNCElO4=; b=AG6W7724
        w7Vhj06SHRZjFE5aU+pnidCinTGfjv2nhxJZ6TS6uRSphj9r4DRwfRzwtAlwiyIu
        bfcqb9UuKAeHnI7c65ujBBKh4zFj/kh8Lv5pexFDa4EtIURbKPur0FTkBPl2Qzag
        dfp0NU1PZ+tTPSTFvTb40cpl9zNtKGA4Vv5Mtqxs4NqEQE7zaPJsCcFtjyYVOnMJ
        CM4rCwlCYtDhE/5L2eyV2fVmI2iPcdD994UiDrGP05p3G3gzrFnzL74Bm7/4In48
        NG1l/W0XuYMPkAR0fI4Haw8j13qj2IUs7iW/Dp20cmR+VZ7XEeUkvCxrdv08tiJU
        JTsrAy3/AJdG6A==
X-ME-Sender: <xms:D7eSYR6F2OCY0aXFjolRkyiLBwUm32hkrpDW71yH2l3z9yq8yQcirQ>
    <xme:D7eSYe69Z0e0J9imxreIuQ7ljrcXkMShhzOi7Hiyiin8CWsdHLManl2sSfm1bZoL7
    353LyVjCu3k_AXYlw>
X-ME-Received: <xmr:D7eSYYcKmA6JuI4rVsFCUxaAaWia70Hkyp3ZR9MO9sMh6Mmwt0A2cv0pf2oFWt0QncpB6bI9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:D7eSYaIxidt93JQnvs-8VA9VlQE9H9wWsjtj_jteON4m098vlZF6Fw>
    <xmx:D7eSYVJynTUv1E1Gn2kLXcxam7_4OfTH85AuqAk3OrDZU0k1gkO-rQ>
    <xmx:D7eSYTz1PUmixsZoMw4rWRLueT399yXJBV5agTa10jzreI5ii-_DkA>
    <xmx:ELeSYeX-tSoOAwwfRfuGF2owt7JF4z9ZpWx6we5_tg1jp0WhR_Q9Jg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 14:37:51 -0500 (EST)
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
Subject: [RFC PATCH 3/3] arch: powerpc: adjust fadump alignment to pageblock aligned.
Date:   Mon, 15 Nov 2021 14:37:25 -0500
Message-Id: <20211115193725.737539-5-zi.yan@sent.com>
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

CMA only requires pageblock alignment. Change fadump too.

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

