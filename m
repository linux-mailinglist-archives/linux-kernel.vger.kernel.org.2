Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6D3E1C04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhHETEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:04:23 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60747 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242220AbhHETEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:04:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id B4D585810BA;
        Thu,  5 Aug 2021 15:03:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Aug 2021 15:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=km9HG7d0aLbun
        QBTsj+FmyouAn5cvVzLddI+NBf1S5I=; b=Ca99plPmsBIKRdYO73L+eS0IcmVTU
        rQSzJdkmcEqNR+acpa6Ghbl6oZt0oiu25ZQXDo/sSV2PLXp/yIIMVcOlU1ylgFt9
        c1YnNjK+GpDhW6pyK+lhlbNCxL7T6gdSvktHSfpfWtD0QhtPvdvjhKyVIhLvEinQ
        kykZMM3z7wSpTyOG7jdOdd3hUStmHdcdlPSag+1k8M+PL3HwtEO7e4YSaPmmM4yQ
        SJ+8Jk6nXsko2p98OHkZQxJJlRElU2hQuB7exc6I+oce3blx11SjUHbMMQTnayYh
        r9drJ3osSoKD2iDArGm22yqpzLb9yuYAwbPqcaGGRwPN7skJXVJp4k9pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=km9HG7d0aLbunQBTsj+FmyouAn5cvVzLddI+NBf1S5I=; b=AuCaNREa
        il44gT/59h7oet5zTmexPudy5yoEZgJCPZQWT7Q0sj457+hvSUKjw8WYNRNeoFU+
        7AtmUotFAQvTWp6TIJU2XU72XE4rp8CtLlJWimlnYkacVl+0asDOKEVAsupxLJpn
        aMzazxF3PLktYouWanmoFUvzdaK2NtMaq4z4N5WkzG+ebCelp0jX+/bx+uJL76Ym
        pSsHMf+UCjzguTxJWmpDNAkmVRA9x67tWA0rZJF1rEpRXgl5hCPjc699yzI/lesD
        lrNYXf+930L/MK+heiyUvifpguRsDKx1s+vSWGVZh844Bb3aXkJk+SbK7fHV/bG6
        /Y8xv55+X2nSew==
X-ME-Sender: <xms:GTYMYSpGwiu9NOlzH1yVSbQyvaF6u2AmOei37QpW0yHdAHq5d70qqA>
    <xme:GTYMYQq4b49heDQ_V6UbfLjGsnBENV-sZ2iu1UyugzHQIFju1ZLM_qTOJfDwatPpY
    3mvWlRKPj92ArMKRw>
X-ME-Received: <xmr:GTYMYXOwgr7nepA75MpEUakBwTmGEbwLnnBKioUokH2ojWlbtyzdysvx_7qtY-F5v_oUOTB1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
    dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:GTYMYR7fEzFhfS0EQJgTj57yG72QU41LXmYblLOjG_McgHdugFswIA>
    <xmx:GTYMYR641q9wkTeYWadGOyGbVI2ZSMHANbzijWrYdHOn-SVBWFMY2w>
    <xmx:GTYMYRj1ZQjridQ5OZclZqmrfc-Uq2n6QiFhJ2cIwgblXJzeZhOx_w>
    <xmx:GTYMYdh9Qzts9rqvQUJM7VzqQyVRwMVil4tR1CFM--p9uS3XUeDn3Q>
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
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 10/15] virtio: virtio_balloon: use PAGES_PER_SECTION instead of MAX_ORDER_NR_PAGES.
Date:   Thu,  5 Aug 2021 15:02:48 -0400
Message-Id: <20210805190253.2795604-11-zi.yan@sent.com>
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

It keeps the existing behavior when MAX_ORDER grows beyond a section.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 47dce91f788c..de8d0355d827 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -36,7 +36,7 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN =
| \
 					     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (PFN_SECTION_SHIFT - 1)
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
--=20
2.30.2

