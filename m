Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4DB370198
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhD3Tyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:54:54 -0400
Received: from server.lespinasse.org ([63.205.204.226]:46307 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhD3Txg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:53:36 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619812353; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=V+gT9krnriafAz+sMsWczyeeM3oMiD/qdk5LAIhe9Yg=;
 b=6H5+DJWUUSgWfXs0KVFOLhcS3YlB+lkUS1LWjaqexBE/zZ535kKaA1aq7BdXF2oe1B1z/
 Roh6vuKhxFHU5ZECA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619812353; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=V+gT9krnriafAz+sMsWczyeeM3oMiD/qdk5LAIhe9Yg=;
 b=HZvNX4/POpcRD77pCbupyXrI0ZmJA5Ak9aJV9RKOn3IjsghQfdP4EY8R9oWq8ApOp3Q5h
 bnXXSYPi7IGlYLGHvGFOBsIlqvIE02S7g1eRgIsTJ4PR+60JlTtpiq1Rs8WECoEq8WWYhGD
 MVFB1wl4X4qDgBNt4ez4i5eb+sibOS6zzu64RdvYKa/nMa4uJXf7MEsXQf2L2b2KV+pVXlV
 rUpSob+T26o99noRz5hgTLUi//lhC1ySxclol2A4whI6ZNXh9B9AuafHlB27hv93+jOKr54
 FI6DV6eaeyyN03FicM8YcMjSmRe9Wb8uKohTjSYTfEdYxw0urz/cvOE9h7MA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id A9075160360;
        Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 9B55D19F523; Fri, 30 Apr 2021 12:52:33 -0700 (PDT)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH 24/29] mm: enable speculative fault handling through do_swap_page()
Date:   Fri, 30 Apr 2021 12:52:25 -0700
Message-Id: <20210430195232.30491-25-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
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
index a3708b4a616c..cf1a1c0196f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3357,11 +3357,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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

