Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D13C1C5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhGIAH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 20:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 20:07:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3987C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 17:05:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i9-20020ac871c90000b0290252173fe79cso2184292qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HcLnGXZfaeqCi0d4EsoaKKelu1NS9rMOMY3OT5HTNvs=;
        b=c+KFF36BFzAWbZ1ZqezCaWKkP9YnbQF8Z1exFWSQlGnsvkb6rwZgB5lPB6tZRCFSL/
         2e79NSQQsiyezU4RQCDxHfPlWsi6YTf1z98QAYFY+FNDZcHcFLisxhJYYm4MuhClcr0L
         iTSQFrSE/fJlNePefffT+DV0/KtGATS+VIhreboD6UhWQOtO+fHKucBKP4tNtAzuF6xN
         hRNEZI2oOI1CO5qUjzjj1hpxFivEdX9lLsZCgXvkSRwcRNX/xdPl8MChwTtLcO46X1eS
         6fmZYbxdNiwjfzfpzpNsDnt2sAPjYdsxhv2xWGbbsMAsuE8RvJqEwhZ3g/XB/JdF/JD6
         u4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HcLnGXZfaeqCi0d4EsoaKKelu1NS9rMOMY3OT5HTNvs=;
        b=QxZaGneo/C0T7nr8CFXtUwK3cuyMp4+62QGVzuW7iMnhw993gC1+LjpAWalRXRqH1S
         hbvImq59DFb2V8zQM1VP/zOIE0Px+UYkRM+3zOyQln/ggFn8ybmoQOJcaIXpiEHJQKRp
         DusZphQ4KcYy4JjVxvKqc6NT1pIl658a1gxnFuagY5i6p7niQkzqEEHf1HzxOHOvcGTO
         N7DvB0yOtO84WTr0U6dfq+EMBwaMo4JtDVlBhlraqRFFc0pa0LaJP2c0XT7+DkIihosn
         +tcuvgdtXZwjcsxJcDhqXxq2sePpDj54UDW7vEayflBz7bxscNHFtI3Wg5IIswyZUv0d
         TLUw==
X-Gm-Message-State: AOAM533yIiHqmecIX8x6bhDf1O8B+0DusHwNNKpKRddaLiCjBNO+KxYc
        CvD8KWs+6V7X8FD3W++G5nFRXtmb8B4=
X-Google-Smtp-Source: ABdhPJxpJbxIb/dIrslIBgNbMwn5YMXFsuNdJZ78tyu+64fXmFt5F1yZxOQNBOstcwSLciAbleba+fdVpQ8=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:7a7f:fa1f:71a4:365b])
 (user=surenb job=sendgmr) by 2002:a05:6214:1c1:: with SMTP id
 c1mr23668712qvt.37.1625789112724; Thu, 08 Jul 2021 17:05:12 -0700 (PDT)
Date:   Thu,  8 Jul 2021 17:05:06 -0700
Message-Id: <20210709000509.2618345-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 0/3] mm, memcg: Optimizations to minimize overhead when memcgs
 are disabled
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling memcgs on Android from kernel command-line because important due to
new requirements for all vendors to share the same kernel config and because
some vendors use memcgs while others don't. The ones who don't, have to disable
memcgs via "cgroup_disable=memory" kernel command-line option and we would like
to minimize the cost of disabling memcgs this way vs disabling CONFIG_MEMCG.
This patchset is focused on minimizing performance costs of this option.
When running pft test with memcgs disabled via CONFIG_MEMCG=n vs
"cgroup_disable=memory" command-line option, we measured ~6% drop in the
average pagefault/sec rate with stddev of ~2%. The results were obtained by
running pft test 1500 times and averaging the results on an 8-core ARM64
Android device with system services stopped, performance governor and enabling
only Big or Little cores in one test to minimize the noise.
Using perf, a number of relatively high-cost areas were identified where extra
operations can be minimized. The patchset consists of a number of optimisations
gradually reducing this regression. Patches are applied incrementally while
testing and recording the impact for each one:

6.01% with vanilla cgroup_disable vs CONFIG_MEMCG=n
3.87% after patch #1 adding mem_cgroup_disabled checks vs CONFIG_MEMCG=n
3.49% after patch #2 inlining mem_cgroup_{charge/uncharge} vs CONFIG_MEMCG=n
2.48% After patch #3 inlining swap-related functions vs CONFIG_MEMCG=n

I kept them separate because they vary in their "impact vs readability cost"
and I'm not sure which ones pass the acceptable threashold.

Suren Baghdasaryan (3):
  mm, memcg: add mem_cgroup_disabled checks in vmpressure and
    swap-related functions
  mm, memcg: inline mem_cgroup_{charge/uncharge} to improve disabled
    memcg config
  mm, memcg: inline swap-related functions to improve disabled memcg
    config

 include/linux/memcontrol.h | 54 ++++++++++++++++++++++++++++++++++----
 include/linux/swap.h       | 26 +++++++++++++++---
 mm/memcontrol.c            | 52 +++++-------------------------------
 mm/swapfile.c              |  2 +-
 mm/vmpressure.c            |  7 ++++-
 5 files changed, 86 insertions(+), 55 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

