Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DA35BBC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbhDLIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbhDLIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:09:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0118C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=a6+zHHfrmNSjnuKpDcqXJsViLAaAf+vjd+fWHfxBxIo=; b=iwOjMpKKyzAFrBidkEKF+HSfqn
        BEsev2o8dOMHA2L1zmtC0v0cDfJ9HOjS5jFS4yuc956dZDcciHG8tfQQIdUNVgs7p31HLXh2UhGNb
        B3pps3OSkNrQ0HcW5nYzgeNDld2ah1kqbkiuJ1h0vNhDTI5TWwqoLKZ2RqEASFl4cPUljMZmb3GsD
        g1TBPdomVhvxlaQ6egk0eFTeeLhj14kQf1qdm6o2RwJeQVQIaTYV9PKUEaCadfElKLH2icgOF5WJP
        z7DRDA90J2bbDAAvPJxdlj96pnVRijnEVnxDLiHHVH9OY+cb7Rv+EUFDV6mS/XDbyT8+lMqgPpz5c
        HKg0/Oog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVrcl-003yd9-Fg; Mon, 12 Apr 2021 08:08:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3D6830026E;
        Mon, 12 Apr 2021 10:08:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B56525F21533; Mon, 12 Apr 2021 10:08:44 +0200 (CEST)
Message-ID: <20210412080611.902470568@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 10:00:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org, hch@lst.de
Subject: [PATCH 6/7] i915: Convert to verify_page_range()
References: <20210412080012.357146277@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_{present,absent}() only need R/O access, use verify_page_range()
instead to remove modular use of apply_to_page_range().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -1225,9 +1225,9 @@ static int igt_mmap_gpu(void *arg)
 	return 0;
 }
 
-static int check_present_pte(pte_t *pte, unsigned long addr, void *data)
+static int check_present_pte(pte_t pte, unsigned long addr, void *data)
 {
-	if (!pte_present(*pte) || pte_none(*pte)) {
+	if (!pte_present(pte) || pte_none(pte)) {
 		pr_err("missing PTE:%lx\n",
 		       (addr - (unsigned long)data) >> PAGE_SHIFT);
 		return -EINVAL;
@@ -1236,9 +1236,9 @@ static int check_present_pte(pte_t *pte,
 	return 0;
 }
 
-static int check_absent_pte(pte_t *pte, unsigned long addr, void *data)
+static int check_absent_pte(pte_t pte, unsigned long addr, void *data)
 {
-	if (pte_present(*pte) && !pte_none(*pte)) {
+	if (pte_present(pte) && !pte_none(pte)) {
 		pr_err("present PTE:%lx; expected to be revoked\n",
 		       (addr - (unsigned long)data) >> PAGE_SHIFT);
 		return -EINVAL;
@@ -1249,14 +1249,14 @@ static int check_absent_pte(pte_t *pte,
 
 static int check_present(unsigned long addr, unsigned long len)
 {
-	return apply_to_page_range(current->mm, addr, len,
-				   check_present_pte, (void *)addr);
+	return verify_page_range(current->mm, addr, len,
+				 check_present_pte, (void *)addr);
 }
 
 static int check_absent(unsigned long addr, unsigned long len)
 {
-	return apply_to_page_range(current->mm, addr, len,
-				   check_absent_pte, (void *)addr);
+	return verify_page_range(current->mm, addr, len,
+				 check_absent_pte, (void *)addr);
 }
 
 static int prefault_range(u64 start, u64 len)


