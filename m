Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5193231113F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhBERud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhBEPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:53:18 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842DC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:34:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id h13so5524782qvo.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uW4XwdDsDqPZKdJsjSNV/lvgiACDWFIJBYlg/yy/ua8=;
        b=gREtjvrNU/DL/BB5f0NB+H4mklQaYOxi0xqMR54soyojmd5TpblFukPUVRrIbkIdkd
         hfABx4PHO1ExToVFCxYaWggl0Nz2GFYGPoMq70828isVXaPRjrE4zpGUF/CgEn6Ky/kg
         t9foBh6L2WHIEQMPmljuLensxPBFII4zfY7I7FAE1CiQrxMtplU9KLRf1p2WFcpkVmhB
         XfqhiYJZbIULXBdzmX58JxPik9yU9xSWmtQr+1Gapmzot2SOKyvfuRtgoetvYxIBe4+V
         v4ZU9xlOx9HdQNEtUwffl7d/VtaLFIlxv6Ld1fYCJ98jg/1zudsVC2jlTN4SNXGP15ZA
         xV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uW4XwdDsDqPZKdJsjSNV/lvgiACDWFIJBYlg/yy/ua8=;
        b=NoN8JnKK3SA+9nzLUHkqxkvPiIPlYs94Vscn3t7JCcXss6xCGtMz3CVrAR+RG2tlx7
         6NMb8Yb3HjXCWTkY4sTS9GnDBrVs7bgixApvH1hPdT1upmnxVXpeJIcc8DK62XkwKIA8
         uaRtT3/s5SJK7Q+JNYxY6M1RB2lLnc21IBvmlEvCMOafOdgKk2pMIaGP2I2UV6byCJAS
         pzQbob5QhyV5jCQyAlccp+PggnvnHBKba3AdzdfICj4WkRWgVy3/BFQtlaQerCDkOviB
         ZoDGWzvlpRHqR0avP7VoYI+IXPQ4rvBHpECuiBNH4hu8vdWUiM/oKWctHSFepQjHA8+v
         BmXw==
X-Gm-Message-State: AOAM533LsBF+WzKeZSfGuPhVBbSaRbSGzVTE+oF8yTBMyP/5CSt2YNxQ
        uFwUpawKQNCsAoNS5NLpHAJ2hQgm8Z6pDEba
X-Google-Smtp-Source: ABdhPJzuQv6b7CvA7ADc4i5f9Vgssq9E+uX168n5SbxDe6+yK6EQLRrOkgWeNI0WZVCe58w78UzylPBPDFpwROPs
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:edb8:b79c:2e20:e531])
 (user=andreyknvl job=sendgmr) by 2002:a0c:9b9e:: with SMTP id
 o30mr5523277qve.62.1612546490248; Fri, 05 Feb 2021 09:34:50 -0800 (PST)
Date:   Fri,  5 Feb 2021 18:34:34 +0100
Message-Id: <cover.1612546384.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 mm 00/13] kasan: optimizations and fixes for HW_TAGS
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

This patchset makes the HW_TAGS mode more efficient, mostly by reworking
poisoning approaches and simplifying/inlining some internal helpers.

With this change, the overhead of HW_TAGS annotations excluding setting
and checking memory tags is ~3%. The performance impact caused by tags
will be unknown until we have hardware that supports MTE.

As a side-effect, this patchset speeds up generic KASAN by ~15%.

Changes v2->v3:
- Rebased onto mm.
- Add documentation update patch.

Changes v1->v2:
- Use EXPORT_SYMBOL_GPL() for arm64 symbols.
- Rename kmalloc bool flag argument to is_kmalloc.
- Make empty mte_set_mem_tag_range() return void.
- Fix build warning in 32-bit systems by using unsigned long instead
  of u64 in WARN_ON() checks.
- Minor changes in comments and commit descriptions.
- Use kfence_ksize() before __ksize() to avoid crashes with KFENCE.
- Use inline instead of __always_inline.

Andrey Konovalov (13):
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
  kasan: clarify that only first bug is reported in HW_TAGS

 Documentation/dev-tools/kasan.rst  |   8 +-
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
 mm/kasan/hw_tags.c                 |   2 +-
 mm/kasan/kasan.h                   |  72 +++++++++--
 mm/kasan/shadow.c                  |  53 ++++----
 mm/slab_common.c                   |  18 ++-
 mm/slub.c                          |   3 +-
 16 files changed, 425 insertions(+), 189 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

