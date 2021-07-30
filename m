Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1203DB48F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbhG3Hg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhG3Hg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:36:58 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4583C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 00:36:53 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso8596398otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7byT5bHnPOS7y5EU7qUuO5PL/0UgHrhgbJIWzprjQ1c=;
        b=ORF4v5oDyw8K3+2KbHlXODBIhFHkD4R+F5BXpH8NINHorwAPc7YVmxWyBoy0+VRNAE
         iRWPTSbOiINERDx6exN7IO5B2+rcQcvZKXTcCtE6QuIObLXuRcETqSxKpDTl4aDVED1W
         flpybY/IOPY94ZThriNdKbiu4eo4W1HVyfAMe/K+b+McrV4pVrGqz4sHsXLKuhULr0Sy
         40L+6BulBdvLKtEDZvIKsPD999DXg6gVvLsh71e+BnYj3vnSg9H1aPldHjOBlpO9edCs
         /j8px2PnkGQnzt0Y30GWdAI+gXcB/8smhs7YN+/5xTUpp4FKs2IW42nOcpRARJEEu3wt
         sGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7byT5bHnPOS7y5EU7qUuO5PL/0UgHrhgbJIWzprjQ1c=;
        b=U3wk28FbXpSmDZl4gQrclAd9qrrNtyh4g1R8wt5Dh7nImrMQocSNYLZnhtKYl7i1ma
         dPtn5j+u7256CR8y51wM8asqkOgjB3WCOubvVMp2Ds7H8gLiyYu62kkWTjsFxDx8q7wV
         QjSN/wPNjnwFuEtYHFdITchmINASzTIzS0kwBbCdYtrO1+cvUIUVq0JUjCpO23L+vM1e
         N2lOWP32+vj7aD2DEdpmQ0ijtkqKi9VjLW93iUVFsR2jeyofvHuX6xuomTk0U9dr05hv
         phDi9pcRq/G4Dp3DpYQuQrAJXOWQKRGrkQMcwQ7bmcLFu3BCysZihYcdEOjW24JnNrRZ
         VGTg==
X-Gm-Message-State: AOAM5314iq0iMxCmFZZmhT3/emrIyCvJpq5jEedc2Urt4Bz2wcJ+7Y/p
        u2fnywDasoAFqxCP4pTkHigz4Q==
X-Google-Smtp-Source: ABdhPJzLIsT5sg4hoRajKGVV2ZmrG0gayWp/81hGgTA8eD8ZXDDcpn9inia6/YIQi3zQ3umq+wkPoA==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr1093386otf.38.1627630613080;
        Fri, 30 Jul 2021 00:36:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b70sm172434oii.24.2021.07.30.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:36:52 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:36:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 04/16] huge tmpfs: revert shmem's use of
 transhuge_vma_enabled()
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <b44e3619-712e-90af-89d2-e4ba654c5110@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.14 commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
checking in transparent_hugepage_enabled()") added transhuge_vma_enabled()
as a wrapper for two very different checks: shmem_huge_enabled() prefers
to show those two checks explicitly, as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ce3ccaac54d6..c6fa6f4f2db8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4003,7 +4003,8 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
-	if (!transhuge_vma_enabled(vma, vma->vm_flags))
+	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
-- 
2.26.2

