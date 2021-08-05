Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2E3E1C00
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbhHETEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60197 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241974AbhHETEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:05 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E30B5C0163;
        Thu,  5 Aug 2021 15:03:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Aug 2021 15:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=Lf+Lo5XZBjeZj
        26CYxZH/xK3V5qmXEQIAGQy9/M8Fos=; b=BU7jEjGIWBuA7nBnSpdOo189jkLI5
        NwRqb67cGvmHezcEdmUpqZKPS3139uAuuaE3a/BBl+dukvx51LWU4ohrNfGAqfuX
        ylUL80D/dHflw7e+u+bJJUkDYqlBvvT0N5DHnVq1B+adObgI+yCtI5OTI2aNvTj5
        uJE1yMuyJSl63XF7j+hNDPP9pns04qrqXZvE9MGcwIe8qvV9STIYiYnuFQ/06ux5
        6kp8Dgv/Hxlw77Fq0m+2q1GTiUK3bPzuqsfiR0oya9dKhUixJB9Dg158nERscoLF
        3/VzMXrmYw74Aak9nOcxFRU66AJobAPCLnWM5zLw8xrNXLm2jFkLUgjuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lf+Lo5XZBjeZj26CYxZH/xK3V5qmXEQIAGQy9/M8Fos=; b=B1r8L+Yo
        PD3pvwzCaLIj12NCvVTj3l6HRer7jSt3363+mRBlrkicVMcqmsmWA/zRfWKJjgKU
        Ku3V9kJAn+ei1wTRrKpgK52IKHzV9+e3GSfK6NwUrD2j49U3uribv/2sQxgw4LyH
        9olPYqQOzd2nlVPRP+WB5UrGREV8c2sb6uCWi0kEGK7mGwHwYqLXV8xKAFcSg6rb
        VQMuanJUr8g94pni2ctv1BfiwaqXYwfgGvPdetXBQeaWIO8ek+HC8OqZXa2UKySD
        pv9/OwADCaeePO6T1P4KCWW0u76cDg0xaHRxg4dMChvq2cJtWBQTSHvgwWRxSJLA
        FsTUFmX9h1fz7A==
X-ME-Sender: <xms:FjYMYeONCo2jmYer6JbRfAkvHJg87moEwJUxpDvqCPZEsA4pCYLx8A>
    <xme:FjYMYc93MnhvrivmCyF2rWPb0MCIIL528woPsfQXkR3oQ7uF4XnfDwCSkpkHBEXb3
    RxK8aYP8gTYVzIC2g>
X-ME-Received: <xmr:FjYMYVRVVXESTdxLATeNUlYNraPvQepc93cjF97b6nEncBKpOmSIBt8BkxtQSpR_NeGZlJ5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:FjYMYes4UrKNIYJX0jYJwf_mJIb8iGd08KBq8xSSXwGYUILi_MfdeA>
    <xmx:FjYMYWciDUtPwKNvu3Rla7BSraVWYE3i3FnV6zYczerpvKJoledTTw>
    <xmx:FjYMYS3MWkv6z1UzSxvVwcR2wbV72BYCdV52Cs8Eh_11F3VFrHWr2A>
    <xmx:FjYMYdw6FNP8JXTixRliANw3TIp_p4_gVwOY0uh54b6xYS7Jo6Is_A>
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
Subject: [RFC PATCH 07/15] mm: hugetlb: use PAGES_PER_SECTION to check mem_map discontiguity
Date:   Thu,  5 Aug 2021 15:02:45 -0400
Message-Id: <20210805190253.2795604-8-zi.yan@sent.com>
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

mem_map is only guaranteed to be virtually contiguous within a section.
Use PAGES_PER_SECTION to check the condition properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ce79d76c42ce..7f78203d6feb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1784,7 +1784,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
 	pgoff_t index =3D page_index(page_head);
 	unsigned long compound_idx;
=20
-	if (compound_order(page_head) >=3D MAX_ORDER)
+	if (compound_order(page_head) >=3D PAGES_PER_SECTION)
 		compound_idx =3D page_to_pfn(page) - page_to_pfn(page_head);
 	else
 		compound_idx =3D page - page_head;
--=20
2.30.2

