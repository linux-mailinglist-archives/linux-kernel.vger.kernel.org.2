Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CBA418D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhIZXpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbhIZXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8CC061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso11959495pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dVwIqoXrWYrBeh50L+yTf5lQAryqwYLoi0T5EzujgU=;
        b=H90hDEbMYLTnjkduq4ioXC3Q6x4/kREz9IaMVmY4/QEAYpTVnrObJL0XyucVJgD0aE
         EroOvxTubIUR87F0ETk3/AfezkybAt06QkLRvFwNPeOWs900MrsK69QBOKmj+3uAXqlu
         76kIT0uPgs6y4eusRE9/4nKXyhs1PGnvHYzON1LLB6G3EKMkCz/HK3ES3vT2s8hooQ3A
         mPWEj+92GHVCaZme0s8KuSghaNpssd2ip2J3WBBlw0Li8DqNYFJ/qMbbVP8F9bJqPTTJ
         DYHtU+uKxiX7VF0Yucv9b5C2pNn8OECmb/XmfH+qEyf2ICr+/DhjNMsNc0gydewwR2Zl
         McOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dVwIqoXrWYrBeh50L+yTf5lQAryqwYLoi0T5EzujgU=;
        b=r0vgH4px1eW5UvICO4fAMBHOcMDmO+Jc9nm/jTyAN7ggzlVhorCgYmpfambYqyh9wu
         Vu0zukhjKnvYctVE/X0sHcsUpqn1/qp5gV/Pa+XJMjZ7UC3PGA1X0f3J+0uJZ2fd+4+j
         u/SR0B5fHZNRRENYk0TW29zzG/ZbKmVfmDk8z/SkUI6uyfyhJj/84p/GkH3e2fhIeilq
         ppj/KAjoTiq0n4RZnPaMK+LybIUmdEO7NXtGSIJ6ZK4YRIVdE4ux3SUEmVkTCcOR7Ij8
         aCaZuLZ/ImiMRtON0c+7yamcEoZVLX5yLaAdDr7l8Boe6xN7VnZe4QxcFPPmx07kiGmK
         NTPw==
X-Gm-Message-State: AOAM530jWKqhbAtwQkCcwTFo8iNiFpQJlVCjPI9refybKltvEotorZaI
        uSkuGj1hBA++TfEJMUePlMQ=
X-Google-Smtp-Source: ABdhPJyRIFjbZLc5BHV5apUrQUvzT/e1HBNNhmP+BETtZps1zARdLAa0dGFFMUZLxRSGC2M1VfACxw==
X-Received: by 2002:a17:90b:1bd1:: with SMTP id oa17mr16386548pjb.82.1632699836897;
        Sun, 26 Sep 2021 16:43:56 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:43:56 -0700 (PDT)
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
Subject: [RFC PATCH 2/8] mm/madvise: remove unnecessary check on madvise_dontneed_free()
Date:   Sun, 26 Sep 2021 09:12:53 -0700
Message-Id: <20210926161259.238054-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926161259.238054-1-namit@vmware.com>
References: <20210926161259.238054-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

madvise_dontneed_free() is called only from madvise_vma() and the
behavior is always either MADV_FREE or MADV_DONTNEED. There is no need
to check again in madvise_dontneed_free() if the behavior is any
different.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/madvise.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index a2b05352ebfe..fe843513a4e8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -820,10 +820,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 
 	if (behavior == MADV_DONTNEED)
 		return madvise_dontneed_single_vma(vma, start, end);
-	else if (behavior == MADV_FREE)
+	else /* behavior == MADV_FREE */
 		return madvise_free_single_vma(vma, start, end);
-	else
-		return -EINVAL;
 }
 
 static long madvise_populate(struct vm_area_struct *vma,
-- 
2.25.1

