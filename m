Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11FC311768
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBEXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbhBEORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:17:43 -0500
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9ABC061221
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 07:47:14 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id b28so1632212vko.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PJe3Rz3EeSdJQyMwgR6n+MLd+6qUSUTULfhGZkHnlC0=;
        b=GLpv906g70oyvKfx1lT8SRlfZX2GptMlW62xAuuPrNcN5zEhH2h3cLKrfSCDjRMFmU
         u4PksceHe87HdqGH5yoTD8mj36rlwfetF+aaiHsU0z6CWtT3Ek0ktXZ3ZXLWRnbeRz+t
         MSbUY+sjHlx+0um5/NpwJr+RE7EzMFWL0gF64teWSuITRQL0gQSnDU85jJv2OP85+G2r
         SgNt+Szam3Q4/rRxSSQ8joLWgA/dbIyBEz6IbVeaY77h/JmVlXLcEzq9Sqawa5rQSGkq
         9En+9QURKs1MSdqNAup9OsWlAS7XkoN2apB1AowPfwA42QdwnhAIvQ1gSagLgJoWQIrz
         +Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PJe3Rz3EeSdJQyMwgR6n+MLd+6qUSUTULfhGZkHnlC0=;
        b=MGXCciGSoxhTxFunL81LTaSgKuELD9mWx0VnEwskZLDWd7ZiAtQUVqoLC6+gzueMuX
         sbClN96yBRTpeBGMp+keUhFteEHCx7YQOSLFheg1USEPYuXPYTxn/DcTlphp+5cZPaiC
         /o64roXEqoKbBRDY/o1bRA3LeBffHFBTncLD776BQnYTDORn0QXbF0XVJHsGcaqYw2g6
         58N7Sss5sMbGeWyS2T0HBVHhEU8g94kMQvzs6J1cn7Ft3EWW+8+ug8Ypgu5FN826pkfS
         aTSpBSO6sMWoIEbqtYYMPzPCX5zEkEEXbFnwUWwMB6IpT8sGEc8j24wLHs0EQ9kRITEp
         hEyg==
X-Gm-Message-State: AOAM531drPjNf595XhFWAouJpmYleoHcHw1nH9CzKuMJzEr4GxFOP8EP
        L23qBY9S9bD3FMTn23D/oByFBqFrXm6TgNoL
X-Google-Smtp-Source: ABdhPJzslOGVJmt8BToaF+8002Gc6wGSVe80ou5CaX5bVJOBaYQOullRpF7SC/hcnNqvALzxl6/B1Gm2DaOADJ/b
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:a692:: with SMTP id
 t18mr5040489qva.18.1612539558216; Fri, 05 Feb 2021 07:39:18 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:39:01 +0100
Message-Id: <cover.1612538932.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 00/12] kasan: optimizations and fixes for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

1. Vincenzo's async support patches [1], and
2. "kasan: untag addresses for KFENCE" fix [2] (already in mm).

[1] https://lore.kernel.org/linux-arm-kernel/20210130165225.54047-1-vincenzo.frascino@arm.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=dec4728fab910da0c86cf9a97e980f4244ebae9f

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
  kasan, mm: fail krealloc on freed objects
  kasan, mm: optimize krealloc poisoning
  kasan: ensure poisoning size alignment
  arm64: kasan: simplify and inline MTE functions
  kasan: inline HW_TAGS helper functions
  arm64: kasan: export MTE symbols for KASAN tests

 arch/arm64/include/asm/cache.h     |   1 -
 arch/arm64/include/asm/kasan.h     |   1 +
 arch/arm64/include/asm/mte-def.h   |   2 +
 arch/arm64/include/asm/mte-kasan.h |  65 ++++++++--
 arch/arm64/include/asm/mte.h       |   2 -
 arch/arm64/kernel/mte.c            |  48 +-------
 arch/arm64/lib/mte.S               |  16 ---
 include/linux/kasan.h              |  25 ++--
 lib/test_kasan.c                   | 111 +++++++++++++++--
 mm/kasan/common.c                  | 187 ++++++++++++++++++++---------
 mm/kasan/kasan.h                   |  72 +++++++++--
 mm/kasan/shadow.c                  |  53 ++++----
 mm/slab_common.c                   |  18 ++-
 mm/slub.c                          |   3 +-
 14 files changed, 418 insertions(+), 186 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

