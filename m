Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5807A418646
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhIZE1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 00:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhIZE1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 00:27:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CBBC061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l6so9338120plh.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 21:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eci95qFJwxt5whQI1jVEQofO7PeEx2QBhVEGTRmpE3E=;
        b=jpfhB/aAUgTyiQ8HW32VMzVZX4P07EEdBZmcgdgfXmTh4Z5lBF3TjM+QFJfr1JM22H
         c6jRNJ3UEZe/+OPQjr96wTQI5N3ozGl4cnag5nw7X8Kp1FUYh3/dmT0lZuGJYuKygaxP
         QzI7K6TNX6dDCniEU6Pfw8zDxuzUdeQe7OWAtrm8GsUTShkGtazrvKFkjD2wGUTKbpM8
         ideyc3zSfk3QeiTWtv5VuoD0f5tIGE6x/UfXxuEs6Gx6azPajTIM6fAaiJsrUpl+J0Bi
         QPCwV4oFfzp9pqG2I1F/v0LbcP0cSVPrnX1EZXrssYJ4Y5F9Yoo828moqfXZ/a/q/vo+
         +k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eci95qFJwxt5whQI1jVEQofO7PeEx2QBhVEGTRmpE3E=;
        b=ely94heo1mgUUjUFMe7auBV7iAKZ2m4+ZrulZzZQwEeP9RF7ZJtxjqXw8BInnAYO4p
         pZ5hHx98M4/i152V2X1OM1nSDYSvm1edYrA+SwjCIG3ekpOfeH5Nv/EUNYcGuNYqTNuc
         LlIZ9FaneKcvvjEaL+aulrAhRIKdDunfkk1t7EVOpW1DyH+AoqXjIwL2aC8g7Q9hh4H0
         5ikUxNcM4fmGRzQ5F3NynBGzPgMp52lSF6xc3wA9wdqNfYbIWpRH2XS59DiQNM00CxZe
         DDbQXdsIH3gzbBgydGQP4evCyo6vaS3vBE85JQpst8ujzaP1wSaeP2qvNMcOBtl2ozYo
         OC6w==
X-Gm-Message-State: AOAM530ExwNQzCiOrvHkY5oY1TfEzoPB3Q7n2fz3zEd0MzcSHE8oHgFI
        h6NTihe4VNxpA1sxVTNi0pY=
X-Google-Smtp-Source: ABdhPJyDtM5RMnAud1UQvGlqFOKRKSP0yb0lYaXQsjAInxblUyVpccuDdRj4Nd8I+XKyOBrGJ49/ow==
X-Received: by 2002:a17:90a:4207:: with SMTP id o7mr11569863pjg.192.1632630343776;
        Sat, 25 Sep 2021 21:25:43 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q11sm12406154pjf.14.2021.09.25.21.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 21:25:43 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH 0/2] mm/mprotect: avoid unnecessary TLB flushes
Date:   Sat, 25 Sep 2021 13:54:21 -0700
Message-Id: <20210925205423.168858-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

This patch-set is based on a very small subset of an old RFC (see link
below), and intended to avoid TLB flushes when they are not necessary
architecturally.  Specifically, memory-unprotect using userfaultfd
(i.e., using userfaultfd IOCTL) triggers a TLB flush when in fact no
architectural data, other than a software flag, is updated.  This
overhead shows up in my development workload profiles.

Instead of tailoring a solution for this specific scenario, it is
arguably better to use this opportunity to consolidate the interfaces
that are used for TLB batching, avoid the open-coded
[inc|dec]_tlb_flush_pending() and use the tlb_[gather|finish]_mmu()
interface instead.

Avoiding the TLB flushes is done very conservatively (unlike the RFC):
1. According to x86 specifications no flushes are necessary on
   permission promotion and changes to software bits.
2. Linux does not flush PTEs after the access bit is cleared.

I considered the feedback of Andy Lutomirski and Andrew Cooper for the
RFC regarding avoiding TLB invalidations when RW is cleared for clean
PTEs. Although the bugs they pointed out can be easily addressed, I am
concerned since I could not find specifications that explicitly clarify
this optimization is valid.

--

RFC -> v1:
* Do not skip TLB flushes when clearing RW on clean PTEs
* Do not defer huge PMD flush as it is already done inline


Link: https://lore.kernel.org/lkml/20210131001132.3368247-1-namit@vmware.com/
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org

Nadav Amit (2):
  mm/mprotect: use mmu_gather
  mm/mprotect: do not flush on permission promotion

 arch/x86/include/asm/tlbflush.h | 40 ++++++++++++++++++++++++++
 include/asm-generic/tlb.h       |  4 +++
 mm/mprotect.c                   | 51 +++++++++++++++++++--------------
 3 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.25.1

