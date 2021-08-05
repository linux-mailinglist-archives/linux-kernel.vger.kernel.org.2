Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D223E1C05
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbhHETEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:25 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:47023 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242210AbhHETEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 23F145810B9;
        Thu,  5 Aug 2021 15:03:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 05 Aug 2021 15:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=bav9UkYGZvp/S
        Y4+sEgDfc5Rj+WNvVLnm5fMaKPJQdk=; b=AoYLNFC8R8d82d/WRFYvXz1pQUcLY
        ZRdB+YJbC1BZ2LsdT8uiKSRXrKQOVFtQeszFb7gfKMFVkoXcKPlIjnJi6m15HUBJ
        v27YQLZxVgSFkWugx1CKQmkSWO0dzqkNnmLbNwsrnKH1epPoJunr+Wl1yZjyiuxR
        K08mh6TSDgVYc7yo9bQJlmV+WCj09RPZkyMdgpYgJ7a8aHhtbNahW9+6ydqynB3t
        Yhhg2VHHAmI+XOyJ8kDCRX4LtHjmd/58YE1pzjFpi7aq2xQzdZ7972LCCMCyV0Do
        GO0T9OEz1KP3fneJ4L2HZNsRfmdwIETiQmt/pQ7nvxY6jvOXCm0B4k8cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=bav9UkYGZvp/SY4+sEgDfc5Rj+WNvVLnm5fMaKPJQdk=; b=FPhvCv8S
        EUsyNoH9KkfmXugX8+QcCXRQR00+NKVzQNjb59jnObV52uBKmPjj3MLPkZRQZqTp
        PXeAmHquCG3u/dTBtgygKNhxTPP/iKhnl78Bq9taENJgahMr/ABc9FDaNRIzcefv
        3bdObHO6RklONprTBrHerpD2Uq44qKeeYqFZfEZWeiYIpFitAvlFJxwCfMJstJyJ
        dTMtKv1Yw+FK7qmmGMeTe+yu6UqHXvixNyI/1HWpDrbI9shzGMq703Xi5FqWeBYT
        E0xbjKLb/yUFgM3/hnDwvGt4s86ZGrNcbOpDdOfQDLKnc5U8/Fs0xCCzha6Jye3F
        nXlMcTGsol4ULg==
X-ME-Sender: <xms:FzYMYQt79JgjUySSBo53-HQ3CGGNuESLMtFRcCC8D4HQpc3FthYdnA>
    <xme:FzYMYddhvgZ-Hp7K6cBc7JGVTGMD-HTZZL9kHLtvwOY-7JtzQYzFuo82SFvJ_-qju
    tJNce4mr8QC6S3uOw>
X-ME-Received: <xmr:FzYMYbwqi4YFu2Q4k0DsA0bCHYWI1xFeC9xZUuubDgwfjOdrDJx2T_mNMjs8ASJ6Q6QBkY4X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:GDYMYTOG2QO5ga7YLT5aWH59mEv7kwQK-6t3O4ZR398_71QUIQG_ig>
    <xmx:GDYMYQ-6dz8-kZyU-zqPvKAbkHQKQZ49aPPprkcY_VLS-HncUF1TxQ>
    <xmx:GDYMYbVO3p-L_tCvM9owaUJaq5r-5yBaJgro1phZaI7W_lHouesR0g>
    <xmx:GTYMYbV4qRzL5g3E16uapp8v0S-u2hjuObbjXw7MXEiaJLsNNSrNWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 15:03:51 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 09/15] virtio: virtio_mem: use PAGES_PER_SECTION instead of MAX_ORDER_NR_PAGES
Date:   Thu,  5 Aug 2021 15:02:47 -0400
Message-Id: <20210805190253.2795604-10-zi.yan@sent.com>
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

It keeps the existing behavior when MAX_ORDER grows beyond a section
size.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/virtio/virtio_mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 19036922f7ef..bab5a81fa796 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1105,11 +1105,11 @@ static void virtio_mem_clear_fake_offline(unsigned =
long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pag=
es)
 {
-	const unsigned long max_nr_pages =3D MAX_ORDER_NR_PAGES;
+	const unsigned long max_nr_pages =3D PAGES_PER_SECTION;
 	unsigned long i;
=20
 	/*
-	 * We are always called at least with MAX_ORDER_NR_PAGES
+	 * We are always called at least with PAGES_PER_SECTION
 	 * granularity/alignment (e.g., the way subblocks work). All pages
 	 * inside such a block are alike.
 	 */
@@ -1125,7 +1125,7 @@ static void virtio_mem_fake_online(unsigned long pfn,=
 unsigned long nr_pages)
 		if (PageDirty(page)) {
 			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      false);
-			generic_online_page(page, MAX_ORDER - 1);
+			generic_online_page(page, PAGES_PER_SECTION - 1);
 		} else {
 			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      true);
@@ -1228,7 +1228,7 @@ static void virtio_mem_online_page_cb(struct page *pa=
ge, unsigned int order)
 		if (vm->in_sbm) {
 			/*
 			 * We exploit here that subblocks have at least
-			 * MAX_ORDER_NR_PAGES size/alignment - so we cannot
+			 * PAGES_PER_SECTION size/alignment - so we cannot
 			 * cross subblocks within one call.
 			 */
 			id =3D virtio_mem_phys_to_mb_id(addr);
@@ -2438,14 +2438,14 @@ static int virtio_mem_init(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
=20
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
+	 * We want subblocks to span at least PAGES_PER_SECTION and
 	 * pageblock_nr_pages pages. This:
 	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
 	 *   and fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size =3D max_t(uint64_t, MAX_ORDER_NR_PAGES,
+	sb_size =3D max_t(uint64_t, PAGES_PER_SECTION,
 			pageblock_nr_pages) * PAGE_SIZE;
 	sb_size =3D max_t(uint64_t, vm->device_block_size, sb_size);
=20
--=20
2.30.2

