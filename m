Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E961E3312A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCHPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:55:22 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7287CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:55:22 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id j2so2866168qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 07:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FoMoOBBpWzT75wmFJ4xJzRk+FU5MgOdLV7/pA36y50w=;
        b=gJjqv60KbnOg/rjkTVlwcooSILnYJ3qeJRQgS9DTzcLaQb5lxvLl1m11dOVtbvwUDv
         IyNBTpOv9RYKxYzlDivy5JN6bnZagUv6vYJdw670cjpVq20vt5lCwFKLdpfhGMfdUo45
         u4xs8vMYjYWNyhaPTw8Vvpt9eAscslNnL5twuLXJwVRWHKeBEdNcMzVXMsZSBcGmAfxN
         zSJytXSh0gYbY4k/oi5SGmevNq7lIDm2ke7+kxf8q8ZYBzCU+Nv0h2hM9SxKJDBM5GRi
         CmK/me3P/TgWsXjAugxJtgZQbjZaeefObcdBU/5Xa4xOYZui6YqK81n6kXBXsYOs2eJk
         QgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FoMoOBBpWzT75wmFJ4xJzRk+FU5MgOdLV7/pA36y50w=;
        b=ENtCt4TvqwVrddNtfT8kv42cLagdZcQ61+4rvChIyONXFoi6YS9RVVPVoGe+cYe9PX
         pLdFhYBahDyrMGTYytn7DynLT3mxcF67BhHfYbAWMyX/fsYC2Hj4XtXOCL1uxV8V/tvQ
         YPMeHwvSFCejzc9CkShRW9e495KvbNIZmoCFR1JNss8iEHitcMb4sCUt1vXiA5XiBRZI
         ixy0v4EzralJjwljlshN1u4UM1CJF1OzEJUMklYcqY9w0X+4xRcMJE4+XCvi3C3BpBFb
         cmkSO5tSfDxJ10YmUOedYRjNXnV467bIPoozHjiT6wjnWQNoeZ1dc5NOvjPAtFtrmUzi
         f2LQ==
X-Gm-Message-State: AOAM532RygEWiFe4m2iXKNE36N3yOM6efO1yiQATPOEm78NIVgXIb/HI
        XW1da7qrqbBTI5wK8OPvnZcG2p5GX9h25KZM
X-Google-Smtp-Source: ABdhPJxpc8xtWCUHnacmkUYbjfY6hvpOAtCcn6T/A/8xB55wTWfnA/FRfsF9ckMO+6ZAPsDaU0zHb/aq1Bb/PMdk
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:85fb:aac9:69ed:e574])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1870:: with SMTP id
 eh16mr8647655qvb.23.1615218921580; Mon, 08 Mar 2021 07:55:21 -0800 (PST)
Date:   Mon,  8 Mar 2021 16:55:13 +0100
Message-Id: <cover.1615218180.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 0/5] kasan: integrate with init_on_alloc/free
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
 arch/arm64/include/asm/mte-kasan.h | 20 ++++++---
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
 14 files changed, 196 insertions(+), 139 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

