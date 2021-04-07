Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6F356115
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbhDGBx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 21:53:26 -0400
Received: from server.lespinasse.org ([63.205.204.226]:52281 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347840AbhDGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:51:53 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617759903; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=dxj+e2mCTN/mq8/QKyjl2SahvK7RHudQGhkISRnBVig=;
 b=+Q3LDhDV38Tl/5VVpqEc6k0vUGZdg8aC5vuZTmv9XW2HYt5SSVn8xVrXOLUhh39OTr4Yk
 BKC/hKD7DF5025fBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617759903; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=dxj+e2mCTN/mq8/QKyjl2SahvK7RHudQGhkISRnBVig=;
 b=JZCFDV30/yXf6H5J+f3SdyNh3hYLqYl3vEW/Ni6crQkjRh6o64d2cKCZQ12mIdV86AgjG
 0xb5dvncR9Q3KIcUxaTww6pmfH1dLtaCq1+ywsEV/VkJRKDmMqq2UPyWsGYMvmOB2h81Mps
 ZWcf0+Bkuo1o4Aul81AclAy77gUiuOhdyIRW9wyIF6E+BzIZARbKoxx0xNxmxbu11pF0uPI
 HpgNlVPPyxwfH5rbkK60cLgd+29R2XTs+4kyo2nRLVJ4eIM7XcMOQenuTzpR9GikW/t7IEy
 h18AfoPFjs2trfBmdlGX++FxPVo1dYiS2yW0X60gIkpTzML88X/k546hS3/A==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 59267160650;
        Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 4A03A19F31F; Tue,  6 Apr 2021 18:45:03 -0700 (PDT)
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
Subject: [RFC PATCH 33/37] mm: enable speculative fault handling only for multithreaded user space
Date:   Tue,  6 Apr 2021 18:44:58 -0700
Message-Id: <20210407014502.24091-34-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407014502.24091-1-michel@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tuning: single threaded userspace does not benefit from
speculative page faults, so we turn them off to avoid any related
(small) extra overheads.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 arch/x86/mm/fault.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 48b86911a6df..b1a07ca82d59 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1318,6 +1318,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
+	/* Only try spf for multithreaded user space faults. */
+	if (!(flags & FAULT_FLAG_USER) || atomic_read(&mm->mm_users) == 1)
+		goto no_spf;
+
 	count_vm_event(SPF_ATTEMPT);
 	seq = mmap_seq_read_start(mm);
 	if (seq & 1)
@@ -1351,6 +1355,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 spf_abort:
 	count_vm_event(SPF_ABORT);
+no_spf:
 
 	/*
 	 * Kernel-mode access to the user address space should only occur
-- 
2.20.1

