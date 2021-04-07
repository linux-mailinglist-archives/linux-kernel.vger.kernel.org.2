Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B423560F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbhDGBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:51:50 -0400
Received: from server.lespinasse.org ([63.205.204.226]:60961 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbhDGBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:48 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 21:51:48 EDT
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=VxqJ3bt6CreFlT+E4DjXvWhsZS5gJ+ukh7zd7QuHvYk=;
 b=X3Xxdqgv/cgatkx6bKCq22bsDyuGIIFuutQU1wa2874aUSk8GjJZaziUZfVG9XXLdrI4V
 2OUJDOleRQVwLd7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=VxqJ3bt6CreFlT+E4DjXvWhsZS5gJ+ukh7zd7QuHvYk=;
 b=bt136Q8H0jbNSpwOh6Dm3mmUCo51a8AE75Ga5NiYl+NqjmDdqfmbcMcqVRCabeL568R29
 QOV1rl19/dycIxYj6qjh5xGGTb3JZcZseB4ugflSTEx91ZKfCqN1yNS+gNUcjEe70Tjov8O
 jSOu/5mupmTj/x2dv6Jj/fvMkZ7DljWhsoae5tgXf2v17pkoqhqMGUHetO/9qIvSHqf0IB3
 43aCaoZX9oubJLJZkd+NJnnie6w1ZqcrAHGbxuTWPlHsB7G4O2657zl+ev+3Pdv9MKz8N8l
 L39OQy2kIRL9HG0UzDQQJhoLw44rV7Cq+5tzxdGWfWNoaM4jIuwHLRFc02YQ==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 09034160356;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id EF43A19F31D; Tue,  6 Apr 2021 18:45:02 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [RFC PATCH 22/37] mm: enable speculative fault handling through do_swap_page()
Date:   Tue,  6 Apr 2021 18:44:47 -0700
Message-Id: <20210407014502.24091-23-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change do_swap_page() to allow speculative fault execution to proceed.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ab3160719bf3..6eddd7b4e89c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3340,11 +3340,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
-	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
-		pte_unmap(vmf->pte);
-		return VM_FAULT_RETRY;
-	}
-
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
 		/*
-- 
2.20.1

