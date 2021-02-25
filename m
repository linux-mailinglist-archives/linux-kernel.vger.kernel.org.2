Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECB1324B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBYHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbhBYHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:34:13 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85363C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:48 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t25so3234696pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uPn+gulMqhjaE42kJBeaOP3zpjHqeQ12o0+1jYccOE=;
        b=MclzpfaLfKRRoTmtHKOR+QpD7iRU7gZnLM4D29YRc09BXBn6SZA0QA16+njtTz4Yoy
         Ks5SD7jL/4HV6tcNHIZGTQB/J5tjAasaxzcJKnNe++qadDyDLJsL+yTi5JRr1SjCiqjj
         +4rDvsM1JQ2ZdaXT1z3K+8BIIaoLhvM8lW+FM/GhEdA/H6PHn6mjp3nt89vBEEvBumIo
         4L3Dd5EaOQx+AS8CYcb9m+ZLDGmA3gDJSayp1sQgAqOAi8K7heOgqUP+72auHRfBMeBY
         zCo7eXCAVdBTaxOnQw2OGRilwbn6RwA+6D2Uv7fPK7pUJzJ4JSaEn2UvPlUgdQGuRzfE
         sp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7uPn+gulMqhjaE42kJBeaOP3zpjHqeQ12o0+1jYccOE=;
        b=fVjq2wLZyh+RwT/zFyQewmqJ3Pz7ORDtNbMPDHi8CfBRgstmrNpWPGpsBZrVznBpaL
         kjdTJpx+GC0z2LBcnOUhq8dH32Gi1bOxqj3/nKWzTOYJMXOVkasgisTD8Qy+T/17SJA6
         /j4PkE4hwFLItn1HtbMayMaeuSJ5NopMrdIta6Dc05CS8i5lonVLYDr/24D1jyRV/tlk
         eLYWUmotM6wSi4JJw689zOKxZT8+/w6+/HfizThTxq5gzFTOtSpMeAcOPuTrykUvYBdH
         sz/2grgktRKm98r4+QE4Tix5kf5HlwZoTAdkm/66r+7qA5wI2/ZK4zDMYXKKJHfUDsGE
         sFHg==
X-Gm-Message-State: AOAM533vrO3cPUjavOgU93cRdxP9rC/u25frtaCocKLVd+dV9cN1ENYZ
        cKHlWIw6fveIAB/vLPA4cY0=
X-Google-Smtp-Source: ABdhPJwiWsHFEuH/7othAr6zlobxWGfqE+W8XfT/aMywpYl+JLK2CPN8bEN880NqGtcE7kVM1JG7GQ==
X-Received: by 2002:aa7:83cc:0:b029:1ed:446b:1ae2 with SMTP id j12-20020aa783cc0000b02901ed446b1ae2mr1938968pfn.47.1614238427898;
        Wed, 24 Feb 2021 23:33:47 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id w3sm4917561pjt.24.2021.02.24.23.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 23:33:47 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <namit@vmware.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
Subject: [RFC 0/6] x86: prefetch_page() vDSO call
Date:   Wed, 24 Feb 2021 23:29:04 -0800
Message-Id: <20210225072910.2811795-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Just as applications can use prefetch instructions to overlap
computations and memory accesses, applications may want to overlap the
page-faults and compute or overlap the I/O accesses that are required
for page-faults of different pages.

Applications can use multiple threads and cores for this matter, by
running one thread that prefetches the data (i.e., faults in the data)
and another that does the compute, but this scheme is inefficient. Using
mincore() can tell whether a page is mapped, but might not tell whether
the page is in the page-cache and does not fault in the data.

Introduce prefetch_page() vDSO-call to prefetch, i.e. fault-in memory
asynchronously. The semantic of this call is: try to prefetch a page of
in a given address and return zero if the page is accessible following
the call. Start I/O operations to retrieve the page if such operations
are required and there is no high memory pressure that might introduce
slowdowns.

Note that as usual the page might be paged-out at any point and
therefore, similarly to mincore(), there is no guarantee that the page
will be present at the time that the user application uses the data that
resides on the page. Nevertheless, it is expected that in the vast
majority of the cases this would not happen, since prefetch_page()
accesses the page and therefore sets the PTE access-bit (if it is
clear). 

The implementation is as follows. The vDSO code accesses the data,
triggering a page-fault it is not present. The handler detects based on
the instruction pointer that this is an asynchronous-#PF, using the
recently introduce vDSO exception tables. If the page can be brought
without waiting (e.g., the page is already in the page-cache), the
kernel handles the fault and returns success (zero). If there is memory
pressure that prevents the proper handling of the fault (i.e., requires
heavy-weight reclamation) it returns a failure. Otherwise, it starts an
I/O to bring the page and returns failure.

Compilers can be extended to issue the prefetch_page() calls when
needed.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org

Nadav Amit (6):
  vdso/extable: fix calculation of base
  x86/vdso: add mask and flags to extable
  x86/vdso: introduce page_prefetch()
  mm/swap_state: respect FAULT_FLAG_RETRY_NOWAIT
  mm: use lightweight reclaim on FAULT_FLAG_RETRY_NOWAIT
  testing/selftest: test vDSO prefetch_page()

 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |   1 +
 arch/x86/entry/vdso/extable.c                 |  70 +++--
 arch/x86/entry/vdso/extable.h                 |  21 +-
 arch/x86/entry/vdso/vdso.lds.S                |   1 +
 arch/x86/entry/vdso/vprefetch.S               |  39 +++
 arch/x86/entry/vdso/vsgx.S                    |   9 +-
 arch/x86/include/asm/vdso.h                   |  38 ++-
 arch/x86/mm/fault.c                           |  11 +-
 lib/vdso/Kconfig                              |   5 +
 mm/memory.c                                   |  47 +++-
 mm/shmem.c                                    |   1 +
 mm/swap_state.c                               |  12 +-
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_test_prefetch_page.c  | 265 ++++++++++++++++++
 15 files changed, 470 insertions(+), 53 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vprefetch.S
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_prefetch_page.c

-- 
2.25.1

