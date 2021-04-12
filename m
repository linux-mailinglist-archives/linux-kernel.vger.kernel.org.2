Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED5D35BBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhDLIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbhDLIJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:09:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA443C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qAg7ftC4OvKycFZYdaaiu+3hyvWOHeF5S6ch3cOk3oo=; b=mJW73nMnogALLCn/T+nyvoRxqW
        YpAoQeHEIvO4hKk/p6e4x3vj5bJ7h8FG3QuAoRXDxwEJDrvWuPVXSHmNBXTJh17grSYZgpiuXFFfP
        4NnPM3aFN5h9HNpDVlnB8BbyNlRWQ5w8kfwfFDS3LpeEV70KIjrgxh+sJpWP+oMBXmCZOWQkavDZW
        scLU/P95X0P1Ax+URV2p26ndNJPDYf1TNcfibumLpgPPOZNwKmM+Id5no3phHBlcZzOzpW2vjaYzM
        g+qpMTspD2/vHPMqPHIx+Y3LTBb7qugrwl0xGqW5g3E4RsbYPaVhBq7TTbi+8nCiErSW7Wi7No7tN
        giIPPjBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcl-0063yK-HH; Mon, 12 Apr 2021 08:08:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4B133002C1;
        Mon, 12 Apr 2021 10:08:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4236E25F2152F; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.835675015@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 5/7] xen/privcmd: Use verify_page_range()
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using apply_to_page_range() from modules, use the safer
verify_page_range() instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/xen/privcmd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -946,9 +946,9 @@ static int privcmd_mmap(struct file *fil
  * on a per pfn/pte basis. Mapping calls that fail with ENOENT
  * can be then retried until success.
  */
-static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
+static int is_mapped_fn(pte_t pte, unsigned long addr, void *data)
 {
-	return pte_none(*pte) ? 0 : -EBUSY;
+	return pte_none(pte) ? 0 : -EBUSY;
 }
 
 static int privcmd_vma_range_is_mapped(
@@ -956,8 +956,8 @@ static int privcmd_vma_range_is_mapped(
 	           unsigned long addr,
 	           unsigned long nr_pages)
 {
-	return apply_to_page_range(vma->vm_mm, addr, nr_pages << PAGE_SHIFT,
-				   is_mapped_fn, NULL) != 0;
+	return verify_page_range(vma->vm_mm, addr, nr_pages << PAGE_SHIFT,
+				 is_mapped_fn, NULL) != 0;
 }
 
 const struct file_operations xen_privcmd_fops = {


