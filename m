Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC71426044
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhJGXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhJGXRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:17:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD8AC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:15:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1-20020a056902060100b005b9c7c04351so10071644ybt.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=zTDXcunRW0mLz0ta7epTL95M0gXJNpWmqwgTbVFaJlo=;
        b=jgOqRcer/lpEzXqGWBc2AUrjI5dWQPS0+63PDV5cu9+OBbnbopuJKim6vB8xpjHOFQ
         z/pIOogU6NQ1lRREz5dI4CdQ+y2/EaZ2VCJXMKHC3dUb1lMLHJxFvTTyYtZhvP0kHYrI
         oYPYFUgWYETmX9sH1ihAb8OjqP+SI327x7ewSuWhi91sVLO2hF7BJ6Pmx7vYh6vITunW
         5Axpvb5sHF1vDqCPNfEELsXcqPuMdGaYaZHcXt6BZzeJTB/TQukG/tQK3wW7G1R/l/z5
         4jVSBtKn2waSzi8ghasdXNs3ZbSB25SR7HP89B+6Nnp7A3M9EdlXlgTfRaco+d4bDaew
         K0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=zTDXcunRW0mLz0ta7epTL95M0gXJNpWmqwgTbVFaJlo=;
        b=z/qKUTjyYSriBd/+tfgME3nWz/40HyZYGpCtb6UIFGDi+HvQZZ3CCOD/ac7OsFRL8B
         iPUYKldaKzC7Z5EsHXsXgZHFEjdes31Y9+Ly8FOZUlApITuiDlPPity+gxwTcZ80+jMq
         L/9gOJZo9NtxY4MKiNFbSLG8QPPwstXmtYeCNWg3iLQzkTzcoJaYbQp6iRQQev+JV6RZ
         TH+CrPQqN7Zzw5fcg8fRDtarFEKhm2bxWhYvzqakUF9KDGGdhgtre03DN12lxpDDr7DQ
         sKwA+AuWnkCArzIcIC1NMe6LmPSeLR5BYrtxDPgFnQdmy3GsC7SIxj2fgqCEyLVsm/h3
         95Vg==
X-Gm-Message-State: AOAM532rAQKuo8MTe0GFusO8kpKKoMEEY9ab8Yb8yndpKMbG0kREsUnY
        nImXCyLVthBt4rQ5DpxNkeK2FywFsHQ=
X-Google-Smtp-Source: ABdhPJzziD1JO1ZpCg93N4lPos3c4HjXW+5ivjiLOidiS7X79gwf1R9b49iOiTPgtcQqQoeHbHwHQWj7bZ4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:2783:a5c0:45f5:b0ed])
 (user=seanjc job=sendgmr) by 2002:a25:3142:: with SMTP id x63mr7130266ybx.99.1633648506078;
 Thu, 07 Oct 2021 16:15:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  7 Oct 2021 16:15:02 -0700
Message-Id: <20211007231502.3552715-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] mm: Fix NULL page->mapping dereference in page_is_secretmem()
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, "Darrick J . Wong" <djwong@kernel.org>,
        Stephen <stephenackerman16@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for a NULL page->mapping before dereferencing the mapping in
page_is_secretmem(), as the page's mapping can be nullified while gup()
is running, e.g. by reclaim or truncation.

  BUG: kernel NULL pointer dereference, address: 0000000000000068
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 6 PID: 4173897 Comm: CPU 3/KVM Tainted: G        W
  RIP: 0010:internal_get_user_pages_fast+0x621/0x9d0
  Code: <48> 81 7a 68 80 08 04 bc 0f 85 21 ff ff 8 89 c7 be
  RSP: 0018:ffffaa90087679b0 EFLAGS: 00010046
  RAX: ffffe3f37905b900 RBX: 00007f2dd561e000 RCX: ffffe3f37905b934
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffe3f37905b900
  ...
  CR2: 0000000000000068 CR3: 00000004c5898003 CR4: 00000000001726e0
  Call Trace:
   get_user_pages_fast_only+0x13/0x20
   hva_to_pfn+0xa9/0x3e0
   try_async_pf+0xa1/0x270
   direct_page_fault+0x113/0xad0
   kvm_mmu_page_fault+0x69/0x680
   vmx_handle_exit+0xe1/0x5d0
   kvm_arch_vcpu_ioctl_run+0xd81/0x1c70
   kvm_vcpu_ioctl+0x267/0x670
   __x64_sys_ioctl+0x83/0xa0
   do_syscall_64+0x56/0x80
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: Stephen <stephenackerman16@gmail.com>
Tested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/secretmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
index 21c3771e6a56..988528b5da43 100644
--- a/include/linux/secretmem.h
+++ b/include/linux/secretmem.h
@@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
 	mapping = (struct address_space *)
 		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
 
-	if (mapping != page->mapping)
+	if (!mapping || mapping != page->mapping)
 		return false;
 
 	return mapping->a_ops == &secretmem_aops;
-- 
2.33.0.882.g93a45727a2-goog

