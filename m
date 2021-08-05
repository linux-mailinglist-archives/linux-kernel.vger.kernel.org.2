Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298F83E1BFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbhHETEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:12 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58753 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242113AbhHETEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7774A5C0160;
        Thu,  5 Aug 2021 15:03:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 15:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=WkfkSBDKtT+JV
        svcnvI+ensvQFYsr8arKk51nWla/ns=; b=Eig43P7o6pypWoyU3Hgwo3CSypMVP
        ukIGgpHhdvWi079VQpHg45cL6bV27wy668fQ77gO7jaLVuUa6yrgVDNE31izvaGD
        Qq4PHwqogRrBecw7ulqS9gS36MAKu0ceQhm4tY0fezKT7Ral+2B9qzpb/IQezyGN
        o3drdYRotmiJStMDWBCD3ptzV954eIPG8LPXu2DvNWNqDGXFOnZwBRe/G+1aNSze
        KiYp6za1VQb4iz8hyARC1qCKNH/JXWJOJO5dYrlBwkm6rL86GC4Ua3D2K9dVT3RE
        VMvJpeKGHJPJE4v4ajSKrbAo/Ei3bjy8BRUrZJWtJ95CmhGRnDzJh7Mtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=WkfkSBDKtT+JVsvcnvI+ensvQFYsr8arKk51nWla/ns=; b=rprndRDD
        7vPzUXWe215Wt32209lM4uzb3aVuktPzk8wLAdRoVDG5zPo3syWwO05AmQd+1Ooj
        d0ZsRdEEsZFgUSit6tF6bp8OozeIEz4LZD6cUQf9VWbjQDxisfnuOu8/wghjlEgz
        l2FlVeuC0ts3Zm6Oz7Se6kFD8e81U46aRIl7zJPve1FkmmOSCamVil6A29t80cKx
        64fFn/UKHI9LAE49zNqeXGVegPWgcl9WLlkTMlXVVca8hwGELSjIibZ9uCRp9I1V
        DrOZrNjJ4ZHrvpG0oDqcUWdaJf9r5D1WADoVc3+IuZCwwkKIRUo31DQdRWefH4YM
        aHLFjXncJqQOuA==
X-ME-Sender: <xms:FTYMYd5cu-jDmcTNOq3q3gTBhsDawmWiUpjY4wfsK2UTiWfl5W3Z2Q>
    <xme:FTYMYa4a1NU60KVZtdwiV7alg211xkj4JN-p26SFkFkQO-3rLBFjs7XJXBcFKG1X-
    cyZHsvS0NYtJUrkAw>
X-ME-Received: <xmr:FTYMYUcIEA_QV8SfwXf9463qvr0SaMkhMw_ANXC1Y8WhytmKRK3wLtFeBOj8CkqxkQ3DSNQH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:FTYMYWK8mkkV_j3813wYuZ7jnNtedQpyTn_SluBzO26AdxSQJlaIZg>
    <xmx:FTYMYRIGvj47ZAWBs7oHjziALkDRna2x50IXZNMJ5vVhOk_LZpj-RQ>
    <xmx:FTYMYfxd2yVq200097ouP1RSIrLr9W0fX0VuJf8VtEIxmIujQoDNQQ>
    <xmx:FTYMYY-Q_YqUs2aSdD30DrtQTfZqAfxe3B39F77pIBv_9i8Vjc3bEw>
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
Subject: [RFC PATCH 05/15] mm/memory_hotplug: online pages at section size.
Date:   Thu,  5 Aug 2021 15:02:43 -0400
Message-Id: <20210805190253.2795604-6-zi.yan@sent.com>
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

When CONFIG_SET_MAX_ORDER is used, MAX_ORDER can be larger than section
size. Holes can appear in hotplug memory chunks with size of
2^MAX_ORDER. Use PFN_SECTION_SHIFT (the order of section size) to limit
hotplug memory size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memory_hotplug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 85029994a494..91ca751ac20c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -601,16 +601,16 @@ static void online_pages_range(unsigned long start_pf=
n, unsigned long nr_pages)
 	unsigned long pfn;
=20
 	/*
-	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
-	 * decide to not expose all pages to the buddy (e.g., expose them
+	 * Online the pages in PFN_SECTION_SHIFT aligned chunks. The callback
+	 * might decide to not expose all pages to the buddy (e.g., expose them
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 * When using memmap_on_memory, the range might not be aligned to
-	 * MAX_ORDER_NR_PAGES - 1, but pageblock aligned. __ffs() will detect
-	 * this and the first chunk to online will be pageblock_nr_pages.
+	 * PAGES_PER_SECTION - 1, but section size aligned. __ffs() will detect
+	 * this and the first chunk to online will be PAGES_PER_SECTION.
 	 */
 	for (pfn =3D start_pfn; pfn < end_pfn;) {
-		int order =3D min(MAX_ORDER - 1UL, __ffs(pfn));
+		int order =3D min_t(unsigned long, PFN_SECTION_SHIFT, __ffs(pfn));
=20
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn +=3D (1UL << order);
--=20
2.30.2

