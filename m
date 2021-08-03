Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F7F3DF556
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhHCTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239649AbhHCTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628018319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q17h1pdEGdt8JIaw02VsUlnrBoQF8gFRk/rFD3Gs3xY=;
        b=QXgvN5Z66FZJtoArYiE7eJexAyJtzNghWcPdysNO3UWUgwWi5dlDnLJl3DC86Qyxa/vrz4
        3QZCMKRhlNKvz8m/FAkp2QyxU8X/swASsmQBlGl1q324Rx1m4FNMecFkJ2c1u9u0VQipxC
        cWfcDIRuw9I+qb5e7Iv037z6SWR/ToY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-vsWp9TtcOrevVIR2_y5zBw-1; Tue, 03 Aug 2021 15:18:36 -0400
X-MC-Unique: vsWp9TtcOrevVIR2_y5zBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6CDA3E75E;
        Tue,  3 Aug 2021 19:18:33 +0000 (UTC)
Received: from max.com (unknown [10.40.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E72B160C0F;
        Tue,  3 Aug 2021 19:18:30 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v5 02/12] powerpc/kvm: Fix kvm_use_magic_page
Date:   Tue,  3 Aug 2021 21:18:08 +0200
Message-Id: <20210803191818.993968-3-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
References: <20210803191818.993968-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from __get_user to fault_in_pages_readable, commit 9f9eae5ce717
broke kvm_use_magic_page: fault_in_pages_readable returns 0 on success.  Fix
that.

Fixes: 9f9eae5ce717 ("powerpc/kvm: Prefer fault_in_pages_readable function")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 arch/powerpc/kernel/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 617eba82531c..d89cf802d9aa 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -669,7 +669,7 @@ static void __init kvm_use_magic_page(void)
 	on_each_cpu(kvm_map_magic_page, &features, 1);
 
 	/* Quick self-test to see if the mapping works */
-	if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
+	if (fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))) {
 		kvm_patching_worked = false;
 		return;
 	}
-- 
2.26.3

