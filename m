Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65503CC788
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 06:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhGREeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 00:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhGREdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 00:33:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA243C061764
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 62so15194914pgf.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 21:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D+eAaGntlq2QOmwIyhlRVot25FA5YhpCPiOnZm25IM=;
        b=Qyx3IP0s0+OyV2QXjMtUZosvefFPI5SxuXcZvuw12DQIchNsKYaA7Y324lin3Q3w+3
         /fy+w58NKJSaNdtz0J8baLNfUjScDvyq6RhhknyE4l6DsBxPqvIBVyh2+kl9yyEWNQyK
         69m/ABFt3Daq93p3dSOE9Om7KBMDekB3UgWd9g39jK09/au7qsI+027GxHv5fwJakXmo
         IwS/sSdn1T11/ANYZz6qEWJ5Tw7dx6StcjaunhM3BmlEmNezYL/AhoB52qWYxNjv8LjF
         6CIyS7SofjWAZ97G2R4axMD/JQsXYbw9V4bhF5PaWfhLKn3E6stvaxHtiU8nw2yWEiwg
         0qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D+eAaGntlq2QOmwIyhlRVot25FA5YhpCPiOnZm25IM=;
        b=jaaGl6waprytVVk2AQfI3ebH3RtSO8Frpuute1xeZmJ18FNBXeyctnvdV8SNdKdeK9
         5d7ue9gpvP+KEYSkEkleTP76kqqiIQETAjmb6cVw2G+MRhbbrhdvbygYStG7K5c2GpRr
         zjpK6EAfel1kqGbefmAfwu7/nMDhUrvDE3iCJkhV+4cqxYDr5KbPOw1ZrFuTE247mudD
         mOkHWSrR9serykmLLEwRdn/VVKsHfbPOA5nkepOntc3XeP00zPtry7v4SU0kkQm4b0bj
         FfYSFTGyB8ZvPs9mKwX8qoYJdss+Ev6Z5iRJ5A5N4+5i/oGVweP9nblkxLM+TWzrHBhT
         UHtA==
X-Gm-Message-State: AOAM532BvtwBLzIX3f6CRzBdUJAZsiKuoqy0vM0ZAvyP6U40Z3wB83CT
        O+TNKvDFGMHcET20LlvBGbrf+A==
X-Google-Smtp-Source: ABdhPJxCY5XIl075+j64oirxKlFOza8NBbgGhZNYT4TQ9zNONZTLttfahLdGHJ0Piy+bp6+IkUEaLQ==
X-Received: by 2002:a63:4607:: with SMTP id t7mr18238045pga.31.1626582655459;
        Sat, 17 Jul 2021 21:30:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a22sm16263217pgv.84.2021.07.17.21.30.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jul 2021 21:30:55 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/7] mm: fix the deadlock in finish_fault()
Date:   Sun, 18 Jul 2021 12:30:27 +0800
Message-Id: <20210718043034.76431-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 63f3655f9501(mm, memcg: fix reclaim deadlock with writeback)
fix a deadlock bug by pre-allocating the pte page table outside of the
page lock, the commit f9ce0be71d1f(mm: Cleanup faultaround and
finish_fault() codepaths) rework the relevant code but ignore this race,
fix it.

Fixes: f9ce0be71d1f(mm: Cleanup faultaround and finish_fault() codepaths)
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index db86558791f1..94a17a9a48ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4026,8 +4026,17 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+		if (vmf->prealloc_pte) {
+			vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+			if (likely(pmd_none(*vmf->pmd))) {
+				mm_inc_nr_ptes(vma->vm_mm);
+				pmd_populate(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
+				vmf->prealloc_pte = NULL;
+			}
+			spin_unlock(vmf->ptl);
+		} else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd))) {
 			return VM_FAULT_OOM;
+		}
 	}
 
 	/* See comment in handle_pte_fault() */
-- 
2.11.0

