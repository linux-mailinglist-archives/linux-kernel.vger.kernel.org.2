Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963E83A7464
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFOCvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhFOCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:51:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA07C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:49:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m137so16646735oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ok1AmBf91H6Q/IhwbEd4jKqOoWLU/Xv6mOEECK2NByo=;
        b=H4VDtuClI+xBARo/PkX4faHPWxSILJD209oddgYal3t0beaYPakrVo/4tTDPLfWJ3r
         gotXX1n6Iq929WNOAdC9iC1VR2H3HXFpK3i9YDiyBj5NeVven5qtdU0yZITIYwJfT18R
         R402qr5t3f3fnjNl8J8Y7kwZfOxy0uVpk1qNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ok1AmBf91H6Q/IhwbEd4jKqOoWLU/Xv6mOEECK2NByo=;
        b=f5D/eMkkbvlMLNmKacsD9To2VUcwP9XpgZPd6eyPl3t5CftFYwOMJ0HMKRsDValm77
         ReBiiYpRypWjvYY5qtjxBz6+jpyQjPICw1bxypoe5Q7K7Zu1JRoyaGUjXyT5c71gVvZD
         QSVwzB5C2Lim8xXXiGqZiR+eprL4bz1wX5h/cwOCmkqk9oUt+80VfAZ2RYD+98CKBoqC
         GMNzKEl3VV0sW2eHZ6D4gTEIKfBO2HL9LUpI9r6/KM9n5kZa68PAqNTSPF1lyj+AgPfS
         IVrf9r/LaS9YTlWN6C9TnQMkzlW8MB1vVO5s2aJs14Ty0IvXzsDzNFIjLuiUlVCaFpJe
         //nw==
X-Gm-Message-State: AOAM532/sYzvMbX4/h9ZSjxloVWw3l62ZafUOjj8iDiVMGXi5HKXS293
        3PgwdPXnItpOGuFZpUvmBjgABukWIkG3KA==
X-Google-Smtp-Source: ABdhPJwweEOVq3GJfsTJTL6yeQhZ4Ms23CXanMBJCKsQmXd9Q1u6Wl2KRDctbbN/XtM4RyiyKCDmeA==
X-Received: by 2002:a17:90a:8546:: with SMTP id a6mr22237711pjw.128.1623721630780;
        Mon, 14 Jun 2021 18:47:10 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id gl13sm628913pjb.5.2021.06.14.18.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:47:10 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     elver@google.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v12 0/6] KASAN core changes for ppc64 radix KASAN
Date:   Tue, 15 Jun 2021 11:46:59 +1000
Message-Id: <20210615014705.2234866-1-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

I've been trying this for a while, but we keep having collisions
between the kasan code in the mm tree and the code I want to put in to
the ppc tree. So my aim here is for patches 1 through 4 or 1 through 5
to go in via the mm tree. I will then propose the powerpc changes for
a later cycle. (I have attached them to this series as an RFC, and
there are still outstanding review comments I need to attend to.)

v12 applies to next-20210611. There should be no noticable changes to
other platforms.

Kind regards,
Daniel

Daniel Axtens (6):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
  [RFC] powerpc: Book3S 64-bit outline-only KASAN support

 Documentation/dev-tools/kasan.rst             |  7 +-
 Documentation/powerpc/kasan.txt               | 58 +++++++++++
 arch/powerpc/Kconfig                          |  4 +-
 arch/powerpc/Kconfig.debug                    |  3 +-
 arch/powerpc/include/asm/book3s/64/hash.h     |  4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  4 +
 arch/powerpc/include/asm/book3s/64/radix.h    | 13 ++-
 arch/powerpc/include/asm/kasan.h              | 22 +++++
 arch/powerpc/kernel/Makefile                  | 11 +++
 arch/powerpc/kernel/process.c                 | 16 ++--
 arch/powerpc/kvm/Makefile                     |  5 +
 arch/powerpc/mm/book3s64/Makefile             |  9 ++
 arch/powerpc/mm/kasan/Makefile                |  3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |  0
 arch/powerpc/mm/kasan/init_book3s_64.c        | 95 +++++++++++++++++++
 arch/powerpc/mm/ptdump/ptdump.c               | 20 +++-
 arch/powerpc/platforms/Kconfig.cputype        |  1 +
 arch/powerpc/platforms/powernv/Makefile       |  6 ++
 arch/powerpc/platforms/pseries/Makefile       |  3 +
 include/linux/kasan.h                         | 18 +++-
 lib/Kconfig.kasan                             | 14 +++
 mm/kasan/common.c                             |  4 +
 mm/kasan/generic.c                            |  3 +
 mm/kasan/init.c                               |  6 +-
 mm/kasan/kasan.h                              |  4 +
 mm/kasan/shadow.c                             |  4 +
 26 files changed, 316 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.27.0

