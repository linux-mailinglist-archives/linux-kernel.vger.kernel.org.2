Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140EF3B960C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhGASUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:20:50 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171]:47001 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhGASUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:20:47 -0400
Received: by mail-il1-f171.google.com with SMTP id t12so7246819ile.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 11:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RfAst8jf06jV75PDGjbAHUMMTq2o1HWk2Y22ohLeAWI=;
        b=uP2EkQkzgjU7jFcsj28w8PThb6Q7Ay3jsg2thuYlujN0RtbeskUknV7deTLKMuZghp
         5MMTydha16D9eqI56Qk5RjRZyrutfrojBr+GKXs2klMtW50YpNAmO2MLwbNsW/jGyxm8
         LvlpNYw4Oe+DkrXQnrzyuinV/ZKqa3d0IlQl3x6SQ8NdwCBCgx4Mzszewj7XTh8Xs8F6
         wbKQfNo8NZ7QEBnGnh9Hi1ajVJdzQ0pE8dkZdry/eyj8XlnJFak+zcCjviSH+tLb9MC5
         gOoZclojkOUGV3B9zBZp1gjCLUiMU2GT28c55NESCYo+yVLGRZ2FlX9odTbLcFW1dWiK
         /N5Q==
X-Gm-Message-State: AOAM530jwd9vr/Gnw8euEvQBcoFX4okxM2Zq7696mbPrkcDnERturyIp
        ImROLBT57ZKD0kDjXGT42ak=
X-Google-Smtp-Source: ABdhPJyrQ4ADD4Uyu5RuVs6MaNMzOr1/6//DJiv68k2idk2ac/MXf70t+uVK1i/p8WheVBvPqIYo1Q==
X-Received: by 2002:a92:7b0f:: with SMTP id w15mr534304ilc.150.1625163495763;
        Thu, 01 Jul 2021 11:18:15 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id 67sm318917iob.15.2021.07.01.11.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:18:15 -0700 (PDT)
Date:   Thu, 1 Jul 2021 18:18:14 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.14-rc1
Message-ID: <YN4G5kUGi295tSzs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This pull request contains:
 - percpu chunk depopulation - depopulate backing pages for chunks with
   empty pages when we exceed a global threshold without those pages.
   This lets us reclaim a portion of memory that would previously be
   lost until the full chunk would be freed (possibly never).

 - memcg accounting cleanup - previously separate chunks were managed
   for normal allocations and __GFP_ACCOUNT allocations. These are now
   consolidated which cleans up the code quite a bit.

 - a few misc clean ups for clang warnings

Two notes though. First there is a small conflict in mm/memcontrol.c and
I have an example merge in percpu#for-5.14-merge [1]. Second, I have an
outstanding patch to do some level of batching for percpu depopulation.
Oliver Wang (krobot tests) is reporting a regression only on Knights
Landing cpus [2]. I am working on debugging it and hopefully will have
it figured out soon.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-5.14-merge
[2] https://lore.kernel.org/lkml/20210630074500.GB10248@xsang-OptiPlex-9020/

Thanks,
Dennis

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.14

for you to fetch changes up to e4d777003a43feab2e000749163e531f6c48c385:

  percpu: optimize locking in pcpu_balance_workfn() (2021-06-17 23:05:24 +0000)

----------------------------------------------------------------
Dennis Zhou (2):
      percpu: use pcpu_free_slot instead of pcpu_nr_slots - 1
      percpu: initialize best_upa variable

Roman Gushchin (8):
      percpu: fix a comment about the chunks ordering
      percpu: split __pcpu_balance_workfn()
      percpu: factor out pcpu_check_block_hint()
      percpu: implement partial chunk depopulation
      mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as __ro_after_init
      mm, memcg: introduce mem_cgroup_kmem_disabled()
      percpu: rework memcg accounting
      percpu: optimize locking in pcpu_balance_workfn()

Wei Yongjun (1):
      percpu: make symbol 'pcpu_free_slot' static

 include/linux/memcontrol.h |   5 +
 mm/memcontrol.c            |  11 +-
 mm/percpu-internal.h       |  56 +------
 mm/percpu-km.c             |  10 +-
 mm/percpu-stats.c          |  44 ++----
 mm/percpu-vm.c             |  35 ++++-
 mm/percpu.c                | 368 +++++++++++++++++++++++++++++++++------------
 7 files changed, 343 insertions(+), 186 deletions(-)
