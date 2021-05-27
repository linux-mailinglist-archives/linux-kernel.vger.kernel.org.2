Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F239E392E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhE0MxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbhE0MxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:53:11 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0556C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:38 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id f141-20020a1c1f930000b029017ce5240ed6so79128wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OFJTCYvTlm44Js7Oh0x+dWK8ho65pfFD2cK8memDcmU=;
        b=QB0AuKgJ00Z+R2vn+s/ZmfmnVBgsEKhuVuQ5GcbOcE0XrgCVuJ6+3mvy4BAzFdXFy2
         1X1e/i9+3FlsRBqEHHm0KtN9SrVPvMu+S2ddDDgER5HsSXUzyEaApDT28GZ26LYc4kLD
         p1S/TVyiTqbLFEKpoN51NO4vJcLb9llEHm1hPXEenjscHufgWUjbLPFWPcVnOrMennnS
         LytX8aVgRwM9l/sQBgnwFzTnBYXKyxIAHjwuyyXS+ZFRIXPHSsnDThBI97VtcTWM2C3e
         MvvORRmCCYIza9KQ6XEe0MOeu9OEXlC/ONYqaxNATER10dOwNAT4jwSKlvDUKeh5IBQO
         +rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OFJTCYvTlm44Js7Oh0x+dWK8ho65pfFD2cK8memDcmU=;
        b=ucYeZVkBkfakFmAzmAssC7xVMUJkvRoDWmRr4QUp+iNNK1429hUD3b7xZOU/QbhqUX
         Xzya7D7d6arp+9LYRkhDrMUBqVZ+eTvG5BlIhcn7zI3v6VO365le/cMRRwt1TEpiteYO
         7ddqaihW0bWHYO/NsaIFFd3pQIhZ+VxjDq+jCnBJ0Bft9afmUsfBvjPNh9MGv+hW+L2H
         m1ixSjcEpM3PwCMN5wu4yckq0EIKiwzkubvN5xfLQRmP+7pQdfjpX6mMI2dxAVSn92DS
         yDnxS2AGBS10bb/sbUrcnGp6D/9HuicHJpzydNnGeF/Ki9xBGRIUULeHYI6iZ0QWgr3F
         Qopw==
X-Gm-Message-State: AOAM5313bO+67ShGu9he7aiCsW+FS6dFdH9qCGp/QdJwtP4XMcnvVUnn
        S04jjhwKp5T2srGTAF/wuSUZ7Z/uWjnU
X-Google-Smtp-Source: ABdhPJyAac0auDLnAIfnc5GbbqU7TodPnilNsvhasp1h2deq/n8uFLQy6e5SlSjZZmZ6iix6pWbwR7ycCt06
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:35cc:: with SMTP id
 r12mr1310535wmq.1.1622119896122; Thu, 27 May 2021 05:51:36 -0700 (PDT)
Date:   Thu, 27 May 2021 12:51:27 +0000
Message-Id: <20210527125134.2116404-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 0/7] KVM: arm64: Reduce hyp_vmemmap overhead
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When running in nVHE protected mode, the hypervisor manages its own
vmemmap and uses it to store page metadata, e.g. refcounts. This series
shrinks the size of struct hyp_page from 32 bytes to 4 bytes without
loss of functionality, hence reducing the cost of the hyp vmemmap from
8MB/GB to 1MB/GB with 4K pages.

The series has two immediate benefits:
  - the memory overhead of the nVHE protected mode is reduced;
  - it refactors the host stage-2 memory pools in a way that allows
    better re-use of pages to map MMIO ranges, allowing more MMIO
    mappings (currently limited to 1GB IPA space) most of the time.

But more importantly, the series reduces the hyp vmemmap overhead enough
that we might consider covering _all_ of memory with it at EL2 in the
future. This would simplify significantly the dynamic admission of
memory into the EL2 allocator, which will be required when the
hypervisor will allocate stage-2 page-tables of guests for instance.
This would also allow the hypervisor to refcount pages it doesn't 'own',
which be useful to track shared pages and such.

The series is split as follows
  - patches 01-03 move the list_head of each page from struct hyp_page
    to the page itself -- the pages are attached to the free lists only
    when they are free by definition;
  - patches 04-05 remove the hyp_pool pointer from struct hyp_page as
    that information can be inferred from the context;
  - patches 06-07 reduce the size of the remaining members of struct
    hyp_page which are currently oversized for the needs of the
    hypervisor.

On a last note, I believe we could actually make hyp_page fit in 16bits
when using 4K pages: limiting the MAX_ORDER to 7 should suffice and
require only 3 bits, and 13bits should be enough for the refcount for
the existing use-cases. I decided not to implement this as we probably
want to keep some room to grow in hyp_page (e.g. add flags, ...), that
might cause issues to make refcounts atomic, and 16bits are not enough
with 64K pages so we'd have to deal with that separately, but that _is_
a possibility.

Thanks!
Quentin

Quentin Perret (7):
  KVM: arm64: Move hyp_pool locking out of refcount helpers
  KVM: arm64: Use refcount at hyp to check page availability
  KVM: arm64: Remove list_head from hyp_page
  KVM: arm64: Unify MMIO and mem host stage-2 pools
  KVM: arm64: Remove hyp_pool pointer from struct hyp_page
  KVM: arm64: Use less bits for hyp_page order
  KVM: arm64: Use less bits for hyp_page refcount

 arch/arm64/kvm/hyp/include/nvhe/gfp.h         | 33 ++-----
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  7 +-
 arch/arm64/kvm/hyp/include/nvhe/mm.h          | 13 +--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 59 +++++++------
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 87 ++++++++++++-------
 arch/arm64/kvm/hyp/nvhe/setup.c               | 30 ++++---
 arch/arm64/kvm/hyp/reserved_mem.c             |  3 +-
 8 files changed, 123 insertions(+), 111 deletions(-)

-- 
2.31.1.818.g46aad6cb9e-goog

