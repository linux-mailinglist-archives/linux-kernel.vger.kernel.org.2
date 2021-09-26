Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAA418D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhIZXpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIZXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1ECC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so10475869plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NySU333JXW/fyiS9W1CxTkc8pnmhF1ZxQI/NACcKQmE=;
        b=S2Xi3H0DaUdTWODZoF6hKlWXPNbgIRsxr+vIrSIhNnJVNSOFJz/CL1weP2sL5o/aC8
         paGG1RCdehDqjnIGdEuBezmF2cfX5r7V75kFFEx7yR73kkvUzjUDdqBrf9BrrJiKM7cC
         pmHlhh1Gf4IALFaw9lBJKJyZGODDCdcbHsiGf02WdaRxzCVPDs9+25P5/bKOhiBdBLyd
         mh9KXGUJt/7fOUwc5kdkLGLTnwnpf1a7p8cEQv4wSc338zrdXcD2vj/04po7T4y1o7Su
         zyW4dnzYq4bN0B9fxef857ggnUOZiN+emo0zn3toHpLbDVvRFLCWrmqfGJq0VaK6THsq
         FuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NySU333JXW/fyiS9W1CxTkc8pnmhF1ZxQI/NACcKQmE=;
        b=p1oa9LIt3j3GQiFYHmwLNJzQ+QBVwEDEu6o2y7wc2eU8UAOo3vzpXSWUQ9JbCxNZeN
         fsqOFAAOXDCr/ygaU7xJOcdTlB6e5nBrLTEpa2ebJSSEl82K+6j3QWmhy1vXBvHSlkm4
         i9uFuoqYnfWBzCatALDS1uZG5D6sn2nYWQaUvsKFTBK9KDTPVRnpjBW7vDkXBpk/tYIP
         +61agflGvBFL0V/9QlBGvfE6tMSmvy9aMV1VqjSxOknxpvyST5jxq+H6luvfJJSg32p6
         Lm1hk0RncpT4qm7cJVxZicBBoofAU26iIMvNcOtZSzBMA/ngjjVnpX3Ut0BNApnqtilk
         g6Rg==
X-Gm-Message-State: AOAM533SdYj/xZKLteTFM68pNGzuOg7TBBc3HhbJlx9iJoYVaMhGkC/C
        5MkwWbp7kq0xWNHH8t8xDts=
X-Google-Smtp-Source: ABdhPJylHV5/+/gjFjZAYFu4kVShQNgLaLHnT25MFpUQmwpdWFzGophkZ/jj2j+GSp2ZtFbgIvdljg==
X-Received: by 2002:a17:902:9684:b0:13e:32cb:c95d with SMTP id n4-20020a170902968400b0013e32cbc95dmr383828plp.31.1632699838216;
        Sun, 26 Sep 2021 16:43:58 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:43:57 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [RFC PATCH 3/8] mm/madvise: remove unnecessary checks on madvise_free_single_vma()
Date:   Sun, 26 Sep 2021 09:12:54 -0700
Message-Id: <20210926161259.238054-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

madvise_free_single_vma() currently rechecks that the range fits within
the VMA, adapts it accordingly, and returns -EINVAL if the range is
entirely outside of the VMA.

The error-code of -EINVAL is incorrect according to the man pages (as it
should have been -ENOMEM), but anyhow the range that is provided to
madvise_free_single_vma() should always be valid. It is set correctly in
do_madvise() and then rechecked in madvise_dontneed_free() is the
mmap-lock is dropped.

Remove this check.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index fe843513a4e8..17e39c70704b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -716,14 +716,8 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 	if (!vma_is_anonymous(vma))
 		return -EINVAL;
 
-	range.start = max(vma->vm_start, start_addr);
-	if (range.start >= vma->vm_end)
-		return -EINVAL;
-	range.end = min(vma->vm_end, end_addr);
-	if (range.end <= vma->vm_start)
-		return -EINVAL;
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
-				range.start, range.end);
+				start_addr, end_addr);
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
-- 
2.25.1

