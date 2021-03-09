Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A1233270B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCINZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhCINYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:24:43 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71547C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 05:24:43 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h13so10355866qti.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 05:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mcTFS30JyBp5UEIivUihex+f+ayULWtQ0lH68CQCZDA=;
        b=gTizBqstGl5T21phg1I1K9VtIs664wU897rwXS3AOQBIXH3um4pyp155yLPoBJaqTq
         Ks/wQ/XfaqpyH0LflvdQ9R7fNyrMSzNZxk95p1pLh9p9/ZN+xWUkCE3QVPlENArU3V5Z
         bkqLzOgrKWhYCxbDcGOHAUmQY3eItG0ebyweURJwIGwUNSOHn9g1exTedyRpi/b3hxx5
         S8Fbx2c2l0nxE848ea6YiiJdP2I3AB3Zj2InIOO3fTBqMzBCmYfj8tBrjr1tOaJA3EVM
         vKQpK/QLImjduTgiS46MFXNCJwgFJ9qTSc0o/brfAhtpom5zoPMRDM84CQJxAWpsPKp5
         hXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mcTFS30JyBp5UEIivUihex+f+ayULWtQ0lH68CQCZDA=;
        b=E1KJZNxy1TMFRV+SccJGQ2jL0CqFUn8RJcbTjiZfbQRyan89xXBpjq/uJxBZa4Z/qm
         Zqq3xppsZDE4ewoN7bQtmeZahDz0Rxnj1p3FK8ircf474HaxrLtc7AphsDOGoLPbfn4s
         k30+4a646Fz0XxYGj3y4MqJMDi96grak1aJxl5iRimzK85vTSidMWGER7jeSElWVoVEF
         NJsgIT1pH+3MF0V2FLDXVfvygTXdEI+vAJjyy2AMLZnqENcRQDLxiEgoiJQKXLO4fTCz
         gApP5ugS7fVNGb1QMVx563v4zNpKuxJ5clN8JIDVI1w1MLLDQnZUEdLTSFeVP1g1ZYTP
         zRNQ==
X-Gm-Message-State: AOAM531XNsWHYKFFMseQJOkuykeE8er9jkgo7ktQU5XqjVbIkGa9qwhX
        P4jBDrREvtcfD6yfhKoCRW6fkfysVyow3PSC
X-Google-Smtp-Source: ABdhPJweE9948FBg9Sg3+ZSTxVw/xY9NiczdF8z6eCM2VRC6d+9Z58LpvBkzmdMVQtlRcAsbsoNW/XJszwbNxEs2
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:5802:818:ce92:dfef])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr25819084qvb.5.1615296282586; Tue, 09 Mar 2021 05:24:42 -0800 (PST)
Date:   Tue,  9 Mar 2021 14:24:34 +0100
Message-Id: <cover.1615296150.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 0/5] kasan: integrate with init_on_alloc/free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series integrates HW_TAGS KASAN with init_on_alloc/free
by initializing memory via the same arm64 instruction that sets memory
tags.

This is expected to improve HW_TAGS KASAN performance when
init_on_alloc/free is enabled. The exact perfomance numbers are unknown
as MTE-enabled hardware doesn't exist yet.

Changes v2->v3:
- Move init variable check out of initialization loop in
  mte_set_mem_tag_range().

Changes v1->v2:
- Add and use kasan_has_integrated_init() helper.
- Update comments to not explicitly mention relation between
  HW_TAGS KASAN and memory init.
- Fix non initting memory with kasan=off by checking kasan_enabled()
  instead of IS_ENABLED(CONFIG_KASAN_HW_TAGS).

Andrey Konovalov (5):
  arm64: kasan: allow to init memory when setting tags
  kasan: init memory in kasan_(un)poison for HW_TAGS
  kasan, mm: integrate page_alloc init with HW_TAGS
  kasan, mm: integrate slab init_on_alloc with HW_TAGS
  kasan, mm: integrate slab init_on_free with HW_TAGS

 arch/arm64/include/asm/memory.h    |  4 +-
 arch/arm64/include/asm/mte-kasan.h | 39 +++++++++++------
 include/linux/kasan.h              | 48 +++++++++++++-------
 lib/test_kasan.c                   |  4 +-
 mm/kasan/common.c                  | 45 +++++++++----------
 mm/kasan/generic.c                 | 12 ++---
 mm/kasan/kasan.h                   | 19 ++++----
 mm/kasan/shadow.c                  | 10 ++---
 mm/kasan/sw_tags.c                 |  2 +-
 mm/mempool.c                       |  4 +-
 mm/page_alloc.c                    | 37 +++++++++++-----
 mm/slab.c                          | 43 ++++++++++--------
 mm/slab.h                          | 17 ++++++--
 mm/slub.c                          | 70 +++++++++++++++---------------
 14 files changed, 207 insertions(+), 147 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

