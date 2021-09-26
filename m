Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9236C418D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhIZXpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIZXpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:45:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85259C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x8so7679018plv.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CQKKv99L0xnu1rz1XhkT9JsaYC+t+sel+8jyZ49o3Y=;
        b=gtU0EfnRnqFNYBWtEUGER6RW4YhSo3Ezaj9dW8XhWZny48xAihOdkmFf7LAENN4UfW
         7ImzRXyt2DH6wK/1WRChceT3rCiQuFnonXwVX9ZCS4xsb57DsHqhQPmxDmgCZ8bLO73L
         KLTdKddD810O9bHzXYFw8QCiJaQNLkHSHU+4q2vXOOS53rWnx5VZ+K8TVvqTHxp+0nDj
         115b41uAE4cRu+c+rOUSg5DC6CNCWcDkfhtCyaIO/fSqrTJKLLE/dN2fClZ1lu2Ty8CU
         LIObWi3YYcPgggDrXEmOT6EPndIRqf4UKAu/yQlbScERv+tYBndI2B8bfn7vcjiQ2xQV
         o+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CQKKv99L0xnu1rz1XhkT9JsaYC+t+sel+8jyZ49o3Y=;
        b=Py+N8DwdZysJgE/R4v05qomqNZXGEPX4Cyi/d8OD+xbpwmt1vkQhFXEyDZQKoSGg9k
         8MRepUTXh8sCVhvV42AEuNWS50obFw+fOelBY9tiAIec3DTkh8cvexhQYyH+eYZwfVkK
         BGpH65609f78bn7Oi/GPpphGXdGMQiQqjfDHRBXLqyeFdIjiq6g7dbGnyJwuCmZeKR/M
         JmIJUOFofRDQB49vyfmWGLONOstPeb5mhWFv4do8gYloJ66gZyKZA8RgJQETfYSgiuKI
         B0ZnVmfZi36SRc2j1ITuJOqkb+sxc87Xt13k1Ij5qe5W6bvaZdeQVcHahP+lfDHNsFHS
         4ysQ==
X-Gm-Message-State: AOAM531G/fnQ4IDW9bGQCY5qvvQ5+YGXlHks/ccmFOWbHyg/DZjjSRaW
        WnG1oDvp21fOpmDpxBj36X8=
X-Google-Smtp-Source: ABdhPJzZXNgpk0RZkng+CNnHW3yPY3D9aVfvkzEamV6c/9RvZ3dkXeX2FGMFCRvzBnaGffL5wkf8cA==
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr16131508pjb.112.1632699833922;
        Sun, 26 Sep 2021 16:43:53 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id n22sm16783686pgc.55.2021.09.26.16.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 16:43:53 -0700 (PDT)
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
Subject: [RFC PATCH 0/8] mm/madvise: support process_madvise(MADV_DONTNEED)
Date:   Sun, 26 Sep 2021 09:12:51 -0700
Message-Id: <20210926161259.238054-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The goal of these patches is to add support for
process_madvise(MADV_DONTNEED). Yet, in the process some (arguably)
useful cleanups, a bug fix and performance enhancements are performed.

The patches try to consolidate the logic across different behaviors, and
to a certain extent overlap/conflict with an outstanding patch that does
something similar [1]. This consolidation however is mostly orthogonal
to the aforementioned one and done in order to clarify what is done in
respect to locks and TLB for each behavior and to batch these operations
more efficiently on process_madvise().

process_madvise(MADV_DONTNEED) is useful for two reasons: (a) it allows
userfaultfd monitors to unmap memory from monitored processes; and (b)
it is more efficient than madvise() since it is vectored and batches TLB
flushes more aggressively.

The first three patches should not interfere with the outstanding patch
[1]. The rest might need to be rebased after [1] is applied.

[1] https://lore.kernel.org/linux-mm/CAJuCfpFDBJ_W1y2tqAT4BGtPbWrjjDud_JuKO8ZbnjYfeVNvRg@mail.gmail.com/

Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: Suren Baghdasarya <surenb@google.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>

Nadav Amit (8):
  mm/madvise: propagate vma->vm_end changes
  mm/madvise: remove unnecessary check on madvise_dontneed_free()
  mm/madvise: remove unnecessary checks on madvise_free_single_vma()
  mm/madvise: define madvise behavior in a struct
  mm/madvise: perform certain operations once on process_madvise()
  mm/madvise: more aggressive TLB batching
  mm/madvise: deduplicate code in madvise_dontneed_free()
  mm/madvise: process_madvise(MADV_DONTNEED)

 mm/internal.h |   5 +
 mm/madvise.c  | 396 ++++++++++++++++++++++++++++++--------------------
 mm/memory.c   |   2 +-
 3 files changed, 248 insertions(+), 155 deletions(-)

-- 
2.25.1

