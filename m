Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338A93A24D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFJG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:58:02 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45572 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJG6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:58:01 -0400
Received: by mail-qt1-f178.google.com with SMTP id l17so16016563qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zujSa+nymJg/DkygOzBqfFRpvoPGGLvQoUzC9rD2EmM=;
        b=d+CHzx9kx2FW5+g+wRTEglrZHDD2va0NJeQznMTqavHkJKp8sIQAoV4Xl6VPkL/21a
         GQeN3iyeoaNEmvPVwRrrGCrG6C8d6PZbBDxVmEyxIgTXugm3GmBDemitSpPAF8c4I8iU
         rhlfqQRvxv244TvuzRX2C190uZyOlY5zGSVwvdz2Zs7F9UAZyU3xADhczznWRvYlpZRm
         ALXo36ZKcmd8MTCNDLR51p1ZO9TF30Cg1VH7dw7T7Z44WunIOIV9cIhr9+rsiNeG4/VS
         UtwMtJ8r4/tj/Vmp+gDCrtzjuM3wf6vtEeN27WC6LLMmQZXQPKpKPv3YKoKpS9NpptTM
         0XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zujSa+nymJg/DkygOzBqfFRpvoPGGLvQoUzC9rD2EmM=;
        b=sQELR0OKM+30Ktu/ayRrZlw6MI8m3Qk2crf0t7t+Wka3UoEF+xJOwqMK0/G2Y9qtSa
         7JrVhdFz8bWPIsIIRRkwcE/EMcaxOub44gpElhyShEHu37Nc6uAgLES0+grNYivpweRs
         vpsBLOJgfc6fHa/gldI+MtXYmdd4HDwW0FemSoPfmhomyhdwYjbtyx7spe8QaQ5HoqPP
         tF1jJoV60w/vFI4CNjwiSDZPyX+i4ifKuaMg+EFNe7VuQcbW+HKRY6oM9yh1Cx7sCHZq
         Wmunlqy40Rw6ceS9LQmgbOGEmzsHb5XM0o2QsnIXA412LXd2AzPWRnAkiVi0Y5SnlJwl
         KQew==
X-Gm-Message-State: AOAM533pB6LderD/dx/jXKj+VMOtULLZLFb4L72pilnKH2104o+yEo9u
        DmDEXoXCdWrzamtGsostwHn5Cg==
X-Google-Smtp-Source: ABdhPJyWmrIYtT3Hki5va0KGk1YyG5yE6G/KbTu0XqJoO/SiXciAA8VL5O7uhLNqek19ZMtnb91BBw==
X-Received: by 2002:ac8:47c2:: with SMTP id d2mr3771672qtr.128.1623308088731;
        Wed, 09 Jun 2021 23:54:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u3sm1611578qtg.16.2021.06.09.23.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:54:48 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:54:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] mm/thp: another PVMW_SYNC fix in
 page_vma_mapped_walk()
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <1bdf384c-8137-a149-2a1e-475a4791c3c@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aha!  Shouldn't that quick scan over pte_none()s make sure that it holds
ptlock in the PVMW_SYNC case?  That too might have been responsible for
BUGs or WARNs in split_huge_page_to_list() or its unmap_page(), though
I've never seen any.

Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 6eb2f1863506..7ae4a016304b 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -277,6 +277,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				goto restart;
 			}
 			pvmw->pte++;
+			if ((pvmw->flags & PVMW_SYNC) && !pvmw->ptl) {
+				pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
+				spin_lock(pvmw->ptl);
+			}
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-- 
2.26.2

