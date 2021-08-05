Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2673B3E1BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhHETEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:10 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39227 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242069AbhHETED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 05DDA5810B5;
        Thu,  5 Aug 2021 15:03:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 15:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=ppy32GVmy6OZk
        OOejSng3cThhTAJUY99OP+ee8s2A8E=; b=S/XJQV6eETWl+Cvdsgb1bFI94cbuu
        y/h6D8K4a90v2BwHExBPeOeC/LyOjL0a5z1tFhq4nQzAgli9WrQULDIy0DolhiVD
        cbMGHXcvzKugFEZfWnLTGdWPJCGKLNMfRq8mphzsV4+xT7+G9Ij7lD8fbJaWDD2k
        YNBaicI7S5yFQhsY5fiF7wZKpU8F1eVT4LUJx8sR0JXkx/348nSSifHKZz4hYBUt
        n41iqv+5lrmr8C1gGfSlSj0pJEZfR6MAFiHV3mfIkK/vX/nt3IoTQcXR0xiiTjfE
        7gaAdcGehqF/DSunoObtIL92uu1Xcls32HmNC5UNv5Qe0ash2eIM0Vjrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ppy32GVmy6OZkOOejSng3cThhTAJUY99OP+ee8s2A8E=; b=KJDFjjZV
        yIOQrCPlG/TJKc5wOfEVskvE0+O33WC52LwAV+KJLw6KATiAK4kCJESSY+wYZx0y
        Ll5GolCNLMUB///tI6PDTMPOiNXSgkybq+s9pV1snev+0jgNVoALD/LlQugZCYJA
        wwIgsHmY3DFM6FCMJqzV3U3RBxOiD+YUDJI619NLJGMV4IOGwHeD515XCkD3YbFj
        LBhX0TitF9X+oU0zlcWSnLcjH6AigIKjV2j8aF3YWmOskD6E7w+pCY+aB6+of+hc
        HzD5hGti7vYcAjJu3BHUnMEmB5xyZ9WTY2hX+ZAm2EEY1brRjTLGeRP3K73X++Ze
        6GQN61lJFdxqaQ==
X-ME-Sender: <xms:FDYMYeE4FffRITZkxb8s_ZZ4PUHSymIZ0thzOic_LJPrdBNFDF_nNQ>
    <xme:FDYMYfV5hRoqVEh_fqKLQNHYjqfUdWrc39GK3bGHpdgQbz2b1Vjg-QbootH1teBXq
    Ra_A8njqXgzl7xyOg>
X-ME-Received: <xmr:FDYMYYJjoxE9CIYtXTt-pR3f86xBPsrWndaODNQJUvHoxIv5J7TuomsYGJh-QSRvYNR6eByt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:FDYMYYGWswrdBkw5bs8FkcPy8_ehQ9HlUjD9MSIbPAFkK8-mHv75GA>
    <xmx:FDYMYUW_3sD1WPQC-hBUGdWADCjAGtCWGROjcM0Et7yQ6JmFXeIteA>
    <xmx:FDYMYbMKMumFC-4D3xYdL-oQK4RGy84XmSAdLy4nMia1A6asmdbPGw>
    <xmx:FTYMYYRZT86LclaCLf7clm4C3HM8yLZzk2vhZaC1v1aiIKgDefKHvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:48 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [RFC PATCH 04/15] mm: prevent pageblock size being larger than section size.
Date:   Thu,  5 Aug 2021 15:02:42 -0400
Message-Id: <20210805190253.2795604-5-zi.yan@sent.com>
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

Only physical pages from a section can be guaranteed to be contiguous
and so far a pageblock can only group contiguous physical pages by
design. Set pageblock_order properly to prevent pageblock going beyond
section size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/pageblock-flags.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flag=
s.h
index 973fd731a520..4277b4267767 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -44,8 +44,11 @@ extern unsigned int pageblock_order;
=20
 #else /* CONFIG_HUGETLB_PAGE */
=20
-/* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		(MAX_ORDER-1)
+/*
+ * If huge pages are not used, group by MAX_ORDER_NR_PAGES or
+ * PAGES_PER_SECTION when MAX_ORDER_NR_PAGES is larger.
+ */
+#define pageblock_order		(min(PFN_SECTION_SHIFT, MAX_ORDER-1))
=20
 #endif /* CONFIG_HUGETLB_PAGE */
=20
--=20
2.30.2

