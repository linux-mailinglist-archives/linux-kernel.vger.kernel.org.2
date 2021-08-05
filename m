Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959E23E1A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhHERI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:08:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237565AbhHERI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628183292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RN93NwEe5WtbM1cvBFWuqQaTNSgmNNz3gZJhT/+o3w8=;
        b=JbxA7ACwBqKlb52ikT2tjL5Xdp0A46DiGrlcajPOQ0O5H0pySxJ6HZXbkyPDgx/eS/D1qo
        hhJAiF/XrE3trDDPGSqYrEJFjNxHlnyZMrbXkU0xR8oGmHIdXBygi5Zo9lTeYDHFSxqRZp
        1ONUuW5zStp9k7HJDgIagEhku/P/sI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-L60JlJt9PXyetW7tYPzBKw-1; Thu, 05 Aug 2021 13:08:08 -0400
X-MC-Unique: L60JlJt9PXyetW7tYPzBKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E3318799E0;
        Thu,  5 Aug 2021 17:08:07 +0000 (UTC)
Received: from [172.30.41.16] (ovpn-113-77.phx2.redhat.com [10.3.113.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 991AD60CC9;
        Thu,  5 Aug 2021 17:08:00 +0000 (UTC)
Subject: [PATCH 5/7] mm/interval_tree.c: Export vma interval tree iterators
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.williamson@redhat.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jgg@nvidia.com,
        peterx@redhat.com
Date:   Thu, 05 Aug 2021 11:08:00 -0600
Message-ID: <162818328044.1511194.11410182995960067691.stgit@omen>
In-Reply-To: <162818167535.1511194.6614962507750594786.stgit@omen>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
User-Agent: StGit/1.0-8-g6af9-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make use of vma_interval_tree_foreach() from a module
we need to export the first and next interators.  vfio code would
like to use this foreach helper to create a remapping helper,
essentially the reverse of unmap_mapping_range() for specific vmas
mapping vfio device memory.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 mm/interval_tree.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 32e390c42c53..faa50767496c 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -24,6 +24,9 @@ INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
 		     unsigned long, shared.rb_subtree_last,
 		     vma_start_pgoff, vma_last_pgoff, /* empty */, vma_interval_tree)
 
+EXPORT_SYMBOL_GPL(vma_interval_tree_iter_first);
+EXPORT_SYMBOL_GPL(vma_interval_tree_iter_next);
+
 /* Insert node immediately after prev in the interval tree */
 void vma_interval_tree_insert_after(struct vm_area_struct *node,
 				    struct vm_area_struct *prev,


