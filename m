Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27FB3E1C02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbhHETET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:19 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40077 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242227AbhHETEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C87F5C0165;
        Thu,  5 Aug 2021 15:03:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 15:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=pTLuD9o+Rmmgy
        0pSJ8qC8qZ3Ebj/NqVHsmXPx9g5Fxc=; b=Kp0Np0Hf0NGj5MD7k1hOtXahgTB13
        XkazXI1X7daDaaQnyFKuYl2p4JTQsccsGu0BF42Nl0GFFccmD3nUkiSxYDa4ehD7
        V9Fu2U/3KrbMx3oJDSBOZYKyogvAUZs1h2c+/KMelXJlnZiwMzrvSS8XieZOz2AV
        29ylT0zTceUen8nFsV9HJwcwFaNTOBS5V6YUOJ+Su3dJUPfn+LojBBeG3VUHHyrB
        OtWaPS9djWWtKZGQc4kpHtq2OVi/mIQ6VJb81fq5aTjNKatRstc0t92zpKJabC+6
        F0Fry3laq170IcGcO5wkkva9qJfGSFruj5TWWf615DTUjrIADTWfMlyiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pTLuD9o+Rmmgy0pSJ8qC8qZ3Ebj/NqVHsmXPx9g5Fxc=; b=cn0whdGO
        Exf5LNe8JX9l3+KjfyixQahsDwaAeSwhUpwYKaKjoGWKm9OAflpKpOgF1/yvtKUv
        m+l5/51VPD9Te0/h6kIlC3Pm03XIwJV28R9rV4bSkFoYCTvHqqrRDVhvhLK85IK7
        5i+1/Z+tUCG8ItxBlOtyyYFkU6FoRiK+S2Jk4qJgJmRkBh5gWEKZjODD658AhZo1
        DyelFHJs5BGheZGhVxF4Lm2ZtDOebrEp3MGtvKoGW+6LmkZEC9RA9bRN8qbR1zFc
        d3mP+D48U6OtAA8RbvJqDYw53CfhGPoTTC39g0anAAU1a+gnbtxjAiox7ZWUx/u2
        C1+4OSIoPuMGoA==
X-ME-Sender: <xms:GjYMYQuP4Sf3cWbggKT15QXtd4A9K6fpU877ExTsV6tvovZtJH87cA>
    <xme:GjYMYdflp1HqBwDth5GfH-W9d15BAYELXcvJt4gf4MTU9QO8qoVtE-yA8Vwjfvnbd
    cjGeTm4fPI9fbE4Aw>
X-ME-Received: <xmr:GjYMYbxekOgecEzg8s8qUiCN7fnp12QeTllq40oyeiknKH-lFFdPJBmpVP2u98mzJLYNIdqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:GjYMYTOqyFwnCygr9AJGDCzmdqGupeMjXScuu8GUalj_n-FrnCaw6g>
    <xmx:GjYMYQ8Ooiepkca11h5FMY3F02oT-ORM_mNyEZfVYrubl9edUeLvVw>
    <xmx:GjYMYbUSXPH7bYp3I-ebfqfZU3XYVUzJJOKistp6WEg5puRkTW-f1A>
    <xmx:GjYMYURuRNJKsw77Lja0k1DnD11pMKChyLwi_sn0jZhLZA2n0p2a4A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:53 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 11/15] mm/page_reporting: report pages at section size instead of MAX_ORDER.
Date:   Thu,  5 Aug 2021 15:02:49 -0400
Message-Id: <20210805190253.2795604-12-zi.yan@sent.com>
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

page_reporting_order was set to MAX_ORDER, which is always smaller than
a memory section size. An upcoming change will make MAX_ORDER larger
than a memory section size. Set page_reporting_order to
PFN_SECTION_SHIFT to match existing size assumption.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/page_reporting.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 382958eef8a9..dc4a2d699862 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,7 +11,8 @@
 #include "page_reporting.h"
 #include "internal.h"
=20
-unsigned int page_reporting_order =3D MAX_ORDER;
+/* Set page_reporting_order at section size */
+unsigned int page_reporting_order =3D PFN_SECTION_SHIFT;
 module_param(page_reporting_order, uint, 0644);
 MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
=20
--=20
2.30.2

