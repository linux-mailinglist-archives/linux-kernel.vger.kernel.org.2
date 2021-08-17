Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D23EE833
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbhHQIN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhHQINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:13:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F719C061224
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:12:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t3so22088044qkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=s8gWaJfJ4WIQanuDSV4XHG60BxCx9sgBhrowAqyXAGc=;
        b=NMiekobsOEwgOm3HulE+GsIzl99RzYQahhmJFly4RZa7Rcp/RO3vQlKPXR4EsRt0Wh
         A4E9h0z0d/fOVyHVKd1AQmLoEqzhZyLuBPZ6P/1oHXSsAw0cSzQF2oWBKeFBI++U12Tk
         SAV3vRG7YPWYGZrns9/CsT4lduY4sRLp7ljD80rN/9LGJ/4Zz97EJd+3fk9smW5tFgYt
         I4XKfbcRiRj3hb2tqEaOEcm2fUoGyqw0XdGiZW0AC1yvdCiMfKqRKOgWtNvuDMgJ20Ho
         ikyOqbYBBUPmjVZhYiIcj4K1IdUF+EKe6UbsZ78qiMnbcqm/7lWVj6TllIgRw/sKPxUJ
         ZXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=s8gWaJfJ4WIQanuDSV4XHG60BxCx9sgBhrowAqyXAGc=;
        b=PD7+Exo8UVTwR6vruukuvq4sJK3W5TeBf1yP9/1im3nOdR5zJxSx4FYuISqvGs5jXx
         NoQDcem/JDmYCs6zdskSUtflT7M0Oo2ahGS2DbiFNdqgFiu6SPJH1TAhaNe4Rxj7zFmA
         orhrSrJihTc4uH4XPajPjRrqMv2uV73WZxg8SzxeOwnTfz/DkoBNp1aSjhXQ6TdGmm39
         SbnYiuAi2SXOKeWgBTZsGVuMm4ZGci+zFEu4k3RSekWpu57FXFPs0q7l6BU/SiDnXg9j
         YGZm8lVbZrHuZLGiSlUtVRBmwRcidgWiY0aJBkGE6k9K0wHHo4llZCzyqaMOE6BCg7GA
         //GA==
X-Gm-Message-State: AOAM530+So7PGU5W3atUhdLcg+4DGbCWjA2WOx5SP1jK0novtcpiIaLE
        DhVWHg3mk1P3gjrc37WoZdXS8g==
X-Google-Smtp-Source: ABdhPJxVnbd3A4PYs7GXspwmAshRWlMAmJn5RmJc1m6XsPvUMZ3wXL6wVHX3SfxeuLk6rSHNu5MNJQ==
X-Received: by 2002:a37:c09:: with SMTP id 9mr2543302qkm.73.1629187957273;
        Tue, 17 Aug 2021 01:12:37 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x125sm903535qkd.8.2021.08.17.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:12:36 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:12:34 -0700 (PDT)
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
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/9] huge tmpfs: revert shmem's use of
 transhuge_vma_enabled()
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <45e5338-18d-c6f9-c17e-34f510bc1728@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.14 commit e6be37b2e7bd ("mm/huge_memory.c: add missing read-only THP
checking in transparent_hugepage_enabled()") added transhuge_vma_enabled()
as a wrapper for two very different checks (one check is whether the app
has marked its address range not to use THPs, the other check is whether
the app is running in a hierarchy that has been marked never to use THPs).
shmem_huge_enabled() prefers to show those two checks explicitly,
as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
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

