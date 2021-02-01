Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4C30B106
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBAT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhBAToZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:44:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EEDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 11:43:41 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id s15so11044909wrt.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rJ16AiwqkpNVRFh+KkU2Ds7vTu96Je2z+5GU1bmSu0w=;
        b=sCPdWL3Ta0DpJRTYs6YqOedNph2JZBXXN/fK4StwO4OsV7a04cBNEoH089CZSJWqUB
         iRBZjs2U3hbbgmYqYIyRQo4/lJlthvUzW2iZuFFcgqS37Yf9BEuhiSFvdBJU8/oXNFbk
         E4v+77CSwMd/ZoYDRDs557B76A0+B0X3oRKAu34bVUiCysdR4Egshk29jdIopw+qWeJl
         w2rKw3kfRvFogekmwxhQmjW50dPploue1Sfo2fXHusBjbCyFm9UEoxj5PUUpIJh2huVC
         oSEdjcoh2PtfMA7bJmBZE93yLmhwujoX+aORuN1XU1hUZ/WedkYkl69gOPJFoXQCHE2K
         YehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rJ16AiwqkpNVRFh+KkU2Ds7vTu96Je2z+5GU1bmSu0w=;
        b=q5+JHPwGOe6xt98+gnsAYVhzEtP0bLp5DXNB1XEmKwSn2/fh5PixRIPWyz0FRlF/8i
         Grp/yJoE+wMvk5s4xrLMm+Dd23QS1IbyH9awMD8xk0Secnj6gyi0IW7l7euGuLMSykVa
         l/xKex/lgyOI65dV5a+cOSozIvapQSWgSL8aZbrqbIDrcafKF6SqOLggloZXU27LxEZt
         BQxjHIOmrKJZY8oDXn4PU7nDkc1wxei6O6vZpzvTqGIkHIY4+kx5ulMN9PeCi6V2a1hV
         NUEY2XxpuRzKUvp3xXaeUurd1WMGxkE45LrSh7xtL25qB5VimsiRJZNIxIva7dJDa9R1
         Trog==
X-Gm-Message-State: AOAM532zvcZ+iOqHQ7+U1ozQtFPfiwa2SwVrECdFgYZHJtTRUWJO7El8
        EsIdgBUu89rskD9Mo2+CUEZMZ8hFLgkaaUV+
X-Google-Smtp-Source: ABdhPJx0GGA/oYC3Q5vVJSxYh6mDgQG3g7RSK4wThiuyHA7aa0OWsctlY8JNwnGUn/Z8d+sJQ/MjD2ldz3KK5zid
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:356:: with SMTP id
 83mr415730wmd.31.1612208620129; Mon, 01 Feb 2021 11:43:40 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:43:24 +0100
Message-Id: <cover.1612208222.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 00/12] kasan: optimizations and fixes for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

This patchset goes on top of:

1. Vincenzo's async support patches, and
2. "kasan: untag addresses for KFENCE" fix.

This patchset makes the HW_TAGS mode more efficient, mostly by reworking
poisoning approaches and simplifying/inlining some internal helpers.

With this change, the overhead of HW_TAGS annotations excluding setting
and checking memory tags is ~3%. The performance impact caused by tags
will be unknown until we have hardware that supports MTE.

As a side-effect, this patchset speeds up generic KASAN by ~15%.

Andrey Konovalov (12):
  kasan, mm: don't save alloc stacks twice
  kasan, mm: optimize kmalloc poisoning
  kasan: optimize large kmalloc poisoning
  kasan: clean up setting free info in kasan_slab_free
  kasan: unify large kfree checks
  kasan: rework krealloc tests
  kasan, mm: remove krealloc side-effect
  kasan, mm: optimize krealloc poisoning
  kasan: ensure poisoning size alignment
  arm64: kasan: simplify and inline MTE functions
  kasan: always inline HW_TAGS helper functions
  arm64: kasan: export MTE symbols for KASAN tests

 arch/arm64/include/asm/cache.h     |   1 -
 arch/arm64/include/asm/kasan.h     |   1 +
 arch/arm64/include/asm/mte-def.h   |   2 +
 arch/arm64/include/asm/mte-kasan.h |  64 ++++++++--
 arch/arm64/include/asm/mte.h       |   2 -
 arch/arm64/kernel/mte.c            |  48 +-------
 arch/arm64/lib/mte.S               |  16 ---
 include/linux/kasan.h              |  25 ++--
 lib/test_kasan.c                   | 111 +++++++++++++++--
 mm/kasan/common.c                  | 187 ++++++++++++++++++++---------
 mm/kasan/kasan.h                   |  74 +++++++++---
 mm/kasan/shadow.c                  |  53 ++++----
 mm/slab_common.c                   |  18 ++-
 mm/slub.c                          |   3 +-
 14 files changed, 419 insertions(+), 186 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

