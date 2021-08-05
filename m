Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0E3E1BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhHETEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53295 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242145AbhHETEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DA32D5C0164;
        Thu,  5 Aug 2021 15:03:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Aug 2021 15:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=9b9lnDrs9VQeu
        LXncQCMIbv4vy0L5khM/fC6d/oCDXA=; b=OU4cZ8TjVlVmleX2bWKetvc5gwm7e
        jNkfnKbXADKL0QRCPeRLPUYmqPzTKQo8Ahc4VKw6mzAgL3RYFC8kT6o0M71/03G3
        dNWLljRBSfrzRzdr+wXOlCQvWuo1CBUn0Aidpzrc9nwwqWHTkR2rhKzvGgqHnpt0
        xq3S/JeOJ8/Xfc8HffM2q7IIecv7zOT9T+XhiT+0gysc4Th9IQd+p4cYWVLLqR2u
        oGQN/VXw1hOirdA59cfd6qTrm9aci5QwnaR6ZDfvpcPYAQkhaaYI02eOiCEn/cTC
        BDvUB28BUGnrCRTcvcojUZxP9SkoCciZBEneTq4H2RKbsjlpPTjPQA50w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9b9lnDrs9VQeuLXncQCMIbv4vy0L5khM/fC6d/oCDXA=; b=dFXQ9IEJ
        kYsiA0Yev3dse3G5yyI07udU8K/EmFWe9HfhOVwymJigLFi5ru9alNfRIAIzgbU4
        6L26WRHprShkvLASjc2/5Rh1PyTwQWDiOLJbGAspghSOmXseuY4g5QE72SF8Jhhr
        6jEG8Qkvz70sMciuY1SkVND29uXciqrNXJBBmp39gqjKKHu79Mi/2iWIyo2JGLrb
        wTqDwSK7I5dOS+V1+/lIKC66qZHkzzbDgN5WQNlWDxzZHcHCZXztN9PXGbIYNo5y
        Uh6pQy1/7Gl+RZfb812ehwc22PlFwfUZAHPa0115lifI2Ft2UBHDmazpDZWgh/ls
        oXUQo5jhcb4QFA==
X-ME-Sender: <xms:FTYMYU6AyoQNCieivLgJ7Hzl7WI6AV8WY6jD2qTVopaSv1_VlwJ8Bw>
    <xme:FTYMYV7RXK29tXe2Bq_KRjVWucjcnaPsl1r6J2DdXYHSjDI6uaZLjCaBLoMvtMjqr
    0W9tnL7YgBE3n-w3Q>
X-ME-Received: <xmr:FTYMYTfxp7LyfffElVQ1cl3p7-DTV-gnc45oci8AYgt3L-zzR3kYxw1hD0AgwS5y5ywDyWkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:FTYMYZKK0ElgXqtXItKpVLC5MKzfKlzZyCLoDTd_UACGyTPcnXj1Wg>
    <xmx:FTYMYYLwJWHNi82RQEeVdYYTf0EHCsf7yZ-U_zF4uA6ANeD1OO6L1A>
    <xmx:FTYMYazP-meVJUQhFG0FMuZiYvV_RS5thQW8AcMYQk430Y5uRT1svQ>
    <xmx:FTYMYX-VIdFUAdLdRlr7xIAdTi3vDoxL7esRrIDf09h6ZAhQSDq3wQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:49 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 06/15] mm: use PAGES_PER_SECTION instead for mem_map_offset/next().
Date:   Thu,  5 Aug 2021 15:02:44 -0400
Message-Id: <20210805190253.2795604-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210805190253.2795604-1-zi.yan@sent.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

mem_map is only guaranteed to be virtually contiguous within a
section, so mem_map_offset/next() uses pfn to handle mem_map
discontiguity. Use PAGES_PER_SECTION instead of MAX_ORDER_NR_PAGES to
describe this condition more precisely.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b1001ebeb286..4ca52c696902 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -485,7 +485,7 @@ static inline void vunmap_range_noflush(unsigned long s=
tart, unsigned long end)
  */
 static inline struct page *mem_map_offset(struct page *base, int offset)
 {
-	if (unlikely(offset >=3D MAX_ORDER_NR_PAGES))
+	if (unlikely(offset >=3D PAGES_PER_SECTION))
 		return nth_page(base, offset);
 	return base + offset;
 }
@@ -497,7 +497,7 @@ static inline struct page *mem_map_offset(struct page *=
base, int offset)
 static inline struct page *mem_map_next(struct page *iter,
 						struct page *base, int offset)
 {
-	if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) =3D=3D 0)) {
+	if (unlikely((offset & (PAGES_PER_SECTION - 1)) =3D=3D 0)) {
 		unsigned long pfn =3D page_to_pfn(base) + offset;
 		if (!pfn_valid(pfn))
 			return NULL;
--=20
2.30.2

