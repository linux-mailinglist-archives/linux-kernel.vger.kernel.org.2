Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53E40FE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhIQQtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhIQQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631897280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pa8MHd+zhEGwg2joKcZLXbQa7nEEAjicA5Pn9RIdpts=;
        b=PTsNkFwQIZnGEQ5ePGkgKEgrhbMH4zK2vK3d8rozGRmy7730Mr1kDjrg9cjxgXyJspu8F1
        OopnCH/gusb3pnkJSyJecEdGqvBmzWftn2aXiNnxU9cyd9eiRZzzfF8+QCDaZpghyN8tjh
        +DPMpTIoJkkW1EOpS7F0DdzNCVpi/Dg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-ukr-sL2KOh6TY8YPSYg23g-1; Fri, 17 Sep 2021 12:47:59 -0400
X-MC-Unique: ukr-sL2KOh6TY8YPSYg23g-1
Received: by mail-qv1-f70.google.com with SMTP id w10-20020a0cb54a000000b0037a9848b92fso92798046qvd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pa8MHd+zhEGwg2joKcZLXbQa7nEEAjicA5Pn9RIdpts=;
        b=Q1Wbd0OWozas5criVn3boX5/hYXp3ZnVDOJ5Gxr+rOJpK0grf2kvmZiZfiQWcr7SIK
         PrD+1JAZpDTDI+vY069gCMS4tpnf1mqfdOYlA53M6DQXxTRtKDGuxyQr0doeLk22dsf/
         Di9qPTI83JY1QLLKeVpSq4ybl0ZU10m9DL2Piq0HJzcwPwNWsiNMByAF4yynPdMeLCnj
         8/5r4bugx9EaEUQ+S6TUZG8xY1ypeZsGTNy+mvawA46Q4xj3UBNxL9HjulRdlM+ccYxR
         We02c8XPPR4KlNMf8lprdCEUe4iY22iIe5XA3eX/V8pFdkE2TeBq+RWfdTfnXmcDOrKV
         Uucg==
X-Gm-Message-State: AOAM531FZnmPOn+mkPQ8xqrlUgCZnhI7hZ2eXOLpBz6Of4bXnL9gArxs
        pgWq9pbMBubVBsfaHg1+eBmBdMbzYR1yxVeBvKow4c3dDiESWAQ5V04XFZBM631HTvla17zGvye
        8l6YoQSbbAr+0Mrqlh1I8/mH3
X-Received: by 2002:a05:6214:4d3:: with SMTP id ck19mr12105615qvb.36.1631897278560;
        Fri, 17 Sep 2021 09:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvWa3v979LKi3hdwvp9c4fs/KF12HbNLbnT6E2cjqqBevUTq+WQmEMVQScmJCrd9d0nYou6A==
X-Received: by 2002:a05:6214:4d3:: with SMTP id ck19mr12105589qvb.36.1631897278279;
        Fri, 17 Sep 2021 09:47:58 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id t26sm4898057qkm.0.2021.09.17.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:47:57 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/3] mm/smaps: Fixes and optimizations on shmem swap handling
Date:   Fri, 17 Sep 2021 12:47:53 -0400
Message-Id: <20210917164756.8586-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series grows from the patch previously posted here:

  [PATCH] mm/smaps: Use vma->vm_pgoff directly when counting partial swap
  https://lore.kernel.org/lkml/20210916215839.95177-1-peterx@redhat.com/

Vlastimil reported a bug that is even more important to fix than the cleanup,
so I put it as patch 1 here.  There's a test program we can use to verify the
bug before/after the patch.  I used the same program to test patch 2/3 because
it covers walking shmem swap both in page cache and in pgtables.

Patch 2 is the original patch, though with a tiny touchup as Vlastimil
suggested.

Patch 3 is a further cleanup of the shmem swap logic, hopefully make it even
cleaner.

Please review, thanks.

Peter Xu (3):
  mm/smaps: Fix shmem pte hole swap calculation
  mm/smaps: Use vma->vm_pgoff directly when counting partial swap
  mm/smaps: Simplify shmem handling of pte holes

 fs/proc/task_mmu.c | 28 ++++++++++++++++------------
 mm/shmem.c         |  5 ++---
 2 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.31.1

