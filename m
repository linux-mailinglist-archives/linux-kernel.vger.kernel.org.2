Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C573767A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbhEGPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237828AbhEGPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620399964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XI4rD6YmuMtYUwEz0cLMaw9lo4eF56mgullQHfANGQM=;
        b=L99NrZspKHYAceE4f3P4C6OiCu/cx8FNJL5J9zKqiJ+kUk3TYdQpizkFTH5EJbFLIqFho6
        fNCL2/IJP+YWVMEp/Ypqg+GbCgPLgYm/O4Pm7be7xImK7RErAbYmX0jnNw8srd1C+0bi/U
        evE4P8xNWlXpxxQY5cMirix4oWvvYvM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-5A8AT75HO-O62Pz2wSJN4Q-1; Fri, 07 May 2021 11:06:03 -0400
X-MC-Unique: 5A8AT75HO-O62Pz2wSJN4Q-1
Received: by mail-qv1-f72.google.com with SMTP id o6-20020a0ccb060000b02901c0933b76e1so6841166qvk.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XI4rD6YmuMtYUwEz0cLMaw9lo4eF56mgullQHfANGQM=;
        b=F5ytxWOYF6ZObIGxHXzMrhWKEY/YIPRXcV9Kr+VTsQz7xzmZnHSGIDVvkYKyMhZd3p
         oeUsLKHtbJmg+ULSSJk/9qbGivVPoRnx5EvD6A2gF0U35gulYFwq/4EXzhStFs2c79gQ
         zNJsNeVyX4Yye/5/As46FpgEPv7FfPdKCJz9oG6skus4nSNED9INJWjUbrUBbGNXVoju
         rX3jCpOeKOHkBvVjFVcoLyf2TGnliEb2Qv846DQGdnp6ZGjhGcPWnAHgSWSpnzozGQ8k
         Ofj0YaZucE1dfW5gJue/sa5P2NXheu7ekw1WpxlzzjGuaYs20l4nVtnCKmjlffoNoQxN
         wfpw==
X-Gm-Message-State: AOAM533kAwNbx4PIh9q4RNgNpSvbE86V2DLjn38GBX4x30C1Yr/6kGOn
        vqwe4sbJUKc6La9Tz3WZoN56m7PkDSs5TsK09YHJXuVBC0gSR1MKCJ0JDVFDn6OwtIrW7K7TlCd
        k/WDE+dhE6TXtA5mUQ0ZVDtiM
X-Received: by 2002:a05:6214:248e:: with SMTP id gi14mr10461264qvb.7.1620399962208;
        Fri, 07 May 2021 08:06:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB55PqZ+EcRjTPmnEKYJdh2C7Wh9UTwfVjNOoEAdmIkbA9ceUr6vcr1sJBVKD90XDiauZoLA==
X-Received: by 2002:a05:6214:248e:: with SMTP id gi14mr10461232qvb.7.1620399961952;
        Fri, 07 May 2021 08:06:01 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c141sm950456qke.12.2021.05.07.08.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 08:06:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2 2/3] mm: gup: allow FOLL_PIN to scale in SMP
Date:   Fri,  7 May 2021 11:05:52 -0400
Message-Id: <20210507150553.208763-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507150553.208763-1-peterx@redhat.com>
References: <20210507150553.208763-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

has_pinned cannot be written by each pin-fast or it won't scale in
SMP. This isn't "false sharing" strictly speaking (it's more like
"true non-sharing"), but it creates the same SMP scalability
bottleneck of "false sharing".

To verify the improvement, below test is done on 40 cpus host with Intel(R)
Xeon(R) CPU E5-2630 v4 @ 2.20GHz (must be with CONFIG_GUP_TEST=y):

  $ sudo chrt -f 1 ./gup_test -a  -m 512 -j 40

Where we can get (average value for 40 threads):

  Old kernel: 477729.97 (+- 3.79%)
  New kernel:  89144.65 (+-11.76%)

On a similar condition with 256 cpus, this commits increases the SMP
scalability of pin_user_pages_fast() executed by different threads of the same
process by more than 4000%.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
[peterx: rewrite commit message, add parentheses against "(A & B)"]
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 63a079e361a3d..9933bc5c2eff2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1292,7 +1292,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
-	if (flags & FOLL_PIN)
+	if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))
 		atomic_set(&mm->has_pinned, 1);
 
 	/*
@@ -2617,7 +2617,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
-	if (gup_flags & FOLL_PIN)
+	if ((gup_flags & FOLL_PIN) && !atomic_read(&current->mm->has_pinned))
 		atomic_set(&current->mm->has_pinned, 1);
 
 	if (!(gup_flags & FOLL_FAST_ONLY))
-- 
2.31.1

