Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF73F0DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhHRWCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 18:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhHRWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:02:35 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32EEC061764;
        Wed, 18 Aug 2021 15:01:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e14so4875635qkg.3;
        Wed, 18 Aug 2021 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOX0l/fl4xpz60byGyTMxCTy5AkyJhMnJ4UUh6rzZho=;
        b=bHeS2KPUXJxWBRyADUT/fW9YbgQNW8oGSMVKiI872ERL/9c7bdtduU3Gl/mQd1PTl7
         AQDwngtA+ZBRQx/wEdriwdk6PgZkSOB/KbU6AGe/k9ZhX+UBDZMbt4sPeOUjF1bMtVOy
         pN5o3SpZxbpvLh6BLRbudWPLltlJDM4HMD2gVUKe3/fA3vXPDj0z89EKuWI6m73aubaE
         kXoqZ2TxG/Tijk1sGNXBcNN4HAH5luXWGf/iy3w5VxDMS6xl0AW/0PkprUVyoMeW6Fq3
         BH+zzzCqsvBNNhWlF7enE9MZU4q5/uTJSMjGW+6/7CSHar3QVHLggVaIX2FluVrClOoZ
         Rg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yOX0l/fl4xpz60byGyTMxCTy5AkyJhMnJ4UUh6rzZho=;
        b=caMXGdGfdhivMbncS4fQvDMSUISeSYjUVVTD9WH3UEclfsYRxQCwsPPAofEXcv3u2Z
         tshaGisGdOs22XF0cwR46BefWNpsm+FZWoOmHQzNoDPfgQtbocy3R43elvu3j8CeNCHl
         hql9ErhBJB83sCrLgwX7O15RhxmVRL5xAnjj8T2xcNorakI0DmE5y0Z2j6t69ldc1KxS
         aa8QUjyGq56kgNZxXJQX0RSBvzKvmsqOyqRoElO1wO5DN6UO8JSbl7ItDR8Ztp636mKz
         0DZFp25TCFwcFnawSP9+1eDYbXgxKiy2+dLuJozfLCGhvvZZjLdYi7rLl9ZRF6kCbFVx
         2DjQ==
X-Gm-Message-State: AOAM532pyl+uxJ3cD1e9WI4/QvMCqLGFnkcYqjCzFVECAFYpP7h3iiA+
        PLrE9a4x49+2aGMlBkDB1Q==
X-Google-Smtp-Source: ABdhPJy4+XHy3BeKdDDlAJeXIogFALVcQPuLvQrOqELodzwoxicsSpxtlzgj8tiDaAnXnw2FWiMjOw==
X-Received: by 2002:a37:84c:: with SMTP id 73mr494625qki.208.1629324118450;
        Wed, 18 Aug 2021 15:01:58 -0700 (PDT)
Received: from bytedance.tiktokd.org (104-9-124-193.lightspeed.sntcca.sbcglobal.net. [104.9.124.193])
        by smtp.gmail.com with ESMTPSA id i18sm602099qkk.115.2021.08.18.15.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:01:57 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH RESEND v2] docs: x86: Remove obsolete information about x86_64 vmalloc() faulting
Date:   Wed, 18 Aug 2021 15:01:23 -0700
Message-Id: <20210818220123.2623-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <peilin.ye@bytedance.com>

x86_64 vmalloc() mappings are no longer "synchronized" among page tables
via faulting since commit 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD
pages for vmalloc area"), since the corresponding P4D or PUD pages are
now preallocated at boot, by preallocate_vmalloc_pages().  Drop the
"lazily synchronized" description for less confusion.

While this file is x86_64-specific, it is worth noting that things are
different for x86_32, where vmalloc()-related changes to `init_mm.pgd` are
synchronized to all page tables in the system during runtime, via
arch_sync_kernel_mappings().  Unfortunately, this synchronization is
subject to race condition, which is further handled via faulting, see
vmalloc_fault().  See commit 4819e15f740e ("x86/mm/32: Bring back vmalloc
faulting on x86_32") for more details.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
Hi all,

Resending this with Muchun's Reviewed-by:.

Thanks,
Peilin Ye

Changes in v2:
    - More information for x86_32 in commit message (Joerg Roedel
      <jroedel@suse.de>)
    - Use my new email address for work

 Documentation/x86/x86_64/mm.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index ede1875719fb..9798676bb0bf 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -140,10 +140,6 @@ The direct mapping covers all memory in the system up to the highest
 memory address (this means in some cases it can also include PCI memory
 holes).
 
-vmalloc space is lazily synchronized into the different PML4/PML5 pages of
-the processes using the page fault handler, with init_top_pgt as
-reference.
-
 We map EFI runtime services in the 'efi_pgd' PGD in a 64Gb large virtual
 memory window (this size is arbitrary, it can be raised later if needed).
 The mappings are not part of any other kernel PGD and are only available
-- 
2.20.1

