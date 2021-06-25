Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A93B3D81
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFYHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFYHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:39:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD68C061756
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:37:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bv7-20020a17090af187b029016fb18e04cfso6859605pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arS0mKVzVlqtqVfiVwhtHqUqhLwMsArq/fcDdatjRgU=;
        b=dHO26QDY5LUMI+Tc2XZzsgpXZDpORNAX7YyZkCQ5xy7oSytr1O3oUF01CG9gH6yL5q
         Y3La01kqEVPP9WWTMrMPMSLK8aydIT/ocZATNuL06J51ec4Okfq4Nv5ekqNB14ZWBhjL
         tL88LfPKWlydh9eprQr48AASmItpc0PiVGEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arS0mKVzVlqtqVfiVwhtHqUqhLwMsArq/fcDdatjRgU=;
        b=Fq0cqLXFW83OQvLbA1G6Tr3cFzJFa9tR5CQvB6A4/WW7z0/vwpY+1K9vBu0OS3LoBO
         RbwMLGFPeeXyCs+5usopZb0ixC084I9Bu3che3Pl7CwdWaclt3Av1vbgI7oCZwksLaoI
         JAIq2Zleq6HfDvKvOCO4q8z2yqIe0Luq4NX/Ti4xSp4YsJJjHkKmdV4PpRm3XXvJ3PC5
         mcCXIfOWWBF1nagFKoHwXvO1oBs31FoMy9e0chP0/t4jYHJUCAokBSYvOeR9J1oDOaQ8
         VNVWJNwd2iN6nKx18SvewINFiaV0WQYRjtBzRx6iwU9vaEmjgziIkBi87a4mFBDK2pni
         NE3Q==
X-Gm-Message-State: AOAM533+W1Ab7CtAAG3JauLhLPxBZGykqNVAD+Zw9vB60SJxYu2CLB3H
        PER11qEf0XrVN18meWTLU6RN5w==
X-Google-Smtp-Source: ABdhPJzJyYhoE1B9Fk5Wy7zlre5sRlAATH1Tds+i1SalCyUSMMBey0lep4anSoEg3on5gb5KkCMm2Q==
X-Received: by 2002:a17:902:c947:b029:125:34d4:249d with SMTP id i7-20020a170902c947b029012534d4249dmr7925026pla.3.1624606637340;
        Fri, 25 Jun 2021 00:37:17 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1492:9d4f:19fa:df61])
        by smtp.gmail.com with UTF8SMTPSA id a9sm9986991pjm.51.2021.06.25.00.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 00:37:16 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nick Piggin <npiggin@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Stevens <stevensd@google.com>
Subject: [PATCH v2 0/5] Remove uses of struct page from x86 and arm64 MMU
Date:   Fri, 25 Jun 2021 16:36:11 +0900
Message-Id: <20210625073616.2184426-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM supports mapping VM_IO and VM_PFNMAP memory into the guest by using
follow_pte in gfn_to_pfn. However, the resolved pfns may not have
assoicated struct pages, so they should not be passed to pfn_to_page.
This series removes such calls from the x86 and arm64 secondary MMU. To
do this, this series introduces gfn_to_pfn_page functions that parallel
the gfn_to_pfn functions. These functions take an extra out parameter
which  contains the page if the hva was resovled by gup. This allows the
caller to call put_page only when necessated by gup.

The gfn_to_pfn functions are depreciated. For now the functions remain
with identical behavior to before, but callers should be migrated to the
new gfn_to_pfn_page functions. I added new functions instead of simply
adding another parameter to the existing functions to make it easier to
track down users of the deprecated functions.

I have migrated the x86 and arm64 secondary MMUs to the new
gfn_to_pfn_page functions.

This addresses CVE-2021-22543 on x86 and arm64.

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

Nicholas Piggin (1):
  KVM: do not allow mapping valid but non-refcounted pages

 arch/arm64/kvm/mmu.c            |  26 +++--
 arch/x86/kvm/mmu/mmu.c          |  50 ++++-----
 arch/x86/kvm/mmu/mmu_internal.h |   3 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  23 +++--
 arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
 arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
 arch/x86/kvm/x86.c              |   6 +-
 include/linux/kvm_host.h        |  17 +++
 virt/kvm/kvm_main.c             | 177 +++++++++++++++++++++++++-------
 9 files changed, 222 insertions(+), 90 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

