Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6241BE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 06:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbhI2Eb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 00:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2EbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 00:31:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 21:29:31 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so890382pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 21:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkzreDQI8QXcNj6KF3HsvP+QbXFPHw1Mmnt63rKUKkA=;
        b=SUgnMZX/AWTndTbWHhZMsZ/Q8rq2mha6o26G7OvAkCmtpgykvlWgC91PFYQimoCXyV
         v8PubmTDiQJMqehVuvd15V+PbUnLDyYAlOhEqLeGTkimABHe/8DNH5GMjyR3wqkwUf4N
         LrwHmT0opEc0XBq0yUrUiNhN23ksP4p5EJqgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QkzreDQI8QXcNj6KF3HsvP+QbXFPHw1Mmnt63rKUKkA=;
        b=JFgOlVHSLdXojFD9tmxeLEBMlUDalfSB28Jk1e3HMbSHDDPGo0W5jpVeo9CTCVhdMw
         SiJclz/yEw7V+Mg8JexvAcWSDRrj+qfioSTAusWM9xBOBhM8+MrWkcrIW4b1bhNevK2+
         K8rtJJlwzRbr6R5E2ZuDQ1dmxtXxCNpQ0vFf6Y9q6azxZk62t05qUWaRrhK/kGbRvE2k
         eLUvDW22eBAlvrC3ds48qEHSLs9JS0COtv1UNDDFME8PxDfe0CpJwjoEqsCE+psjoryB
         oh4W8WA89+WYQ0AQfXhnAVYqb2lhz7ZNTJp8r136rBDNvoXwW2K4WACMeZ86FNm+YAQh
         Ksbw==
X-Gm-Message-State: AOAM532SfyAt7ViYvgTaUTRqbop6tmBH0fbozIbl5HNW2Hh9cg0Ju+k7
        utK+PfC6S8AIXmtq2QkeWZnnQqUvBgzIlw==
X-Google-Smtp-Source: ABdhPJwdVPiqe25K8PElzE9sWsXwBxyck9GIaCUbQQkjXlHvGKR9mvFoORzocViMa6RYiKVWceOf5A==
X-Received: by 2002:a63:e741:: with SMTP id j1mr7938740pgk.86.1632889771324;
        Tue, 28 Sep 2021 21:29:31 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id b5sm261924pjk.18.2021.09.28.21.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 21:29:30 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 0/4] KVM: allow mapping non-refcounted pages
Date:   Wed, 29 Sep 2021 13:29:04 +0900
Message-Id: <20210929042908.1313874-1-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

This patch series adds support for mapping non-refcount VM_IO and
VM_PFNMAP memory into the guest.

Currently, the gfn_to_pfn functions require being able to pin the target
pfn, so they will fail if the pfn returned by follow_pte isn't a
ref-counted page.  However, the KVM secondary MMUs do not require that
the pfn be pinned, since they are integrated with the mmu notifier API.
This series adds a new set of gfn_to_pfn_page functions which parallel
the gfn_to_pfn functions but do not pin the pfn. The new functions
return the page from gup if it was present, so callers can use it and
call put_page when done.

The gfn_to_pfn functions should be depreciated, since as they are unsafe
due to relying on trying to obtain a struct page from a pfn returned by
follow_pte. I added new functions instead of simply adding another
optional parameter to the existing functions to make it easier to track
down users of the deprecated functions.

This series updates x86 and arm64 secondary MMUs to the new API.

v3 -> v4:
 - rebase on kvm next branch again
 - Add some more context to a comment in ensure_pfn_ref
v2 -> v3:
 - rebase on kvm next branch
v1 -> v2:
 - Introduce new gfn_to_pfn_page functions instead of modifying the
   behavior of existing gfn_to_pfn functions, to make the change less
   invasive.
 - Drop changes to mmu_audit.c
 - Include Nicholas Piggin's patch to avoid corrupting refcount in the
   follow_pte case, and use it in depreciated gfn_to_pfn functions.
 - Rebase on kvm/next

David Stevens (4):
  KVM: mmu: introduce new gfn_to_pfn_page functions
  KVM: x86/mmu: use gfn_to_pfn_page
  KVM: arm64/mmu: use gfn_to_pfn_page
  KVM: mmu: remove over-aggressive warnings

 arch/arm64/kvm/mmu.c            |  27 +++--
 arch/x86/kvm/mmu/mmu.c          |  50 ++++----
 arch/x86/kvm/mmu/mmu_internal.h |   3 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  23 ++--
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              |   6 +-
 include/linux/kvm_host.h        |  17 +++
 virt/kvm/kvm_main.c             | 198 +++++++++++++++++++++++---------
 9 files changed, 231 insertions(+), 103 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

