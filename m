Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A943DAC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhG2T4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 15:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhG2T4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 15:56:47 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C4C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:56:43 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e11-20020a05620a208bb02903b854c43335so3833829qka.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AybauKNFPo3SsUjhjkW3rvaT9nCugcHZc2DTga5rD+Y=;
        b=pDjWXDMBoqce2Uo3OFtJqZEiF7+0tG6fbwCkYp/QACm55I5LeZi6KGbTuMrSoe1cpk
         cKB3vxAThRuWvsRaBsGqDa70j0yjXUL+jIyrVksRTaHkqWIM7fjB12MJIG2DFRppBsET
         OS+SgpYNdabohr+fskGck9XrjK1I9TB5SGCPbSFDRFCvXaVN/wK3x+926RV2yAWtXm92
         2RLXmBhRr2WiNQi5NX86D6YFvwO+mh5X+GudOeiT1cU81ScCAw9pXLpWtAYUlsvlEwny
         7LTUROpCB9f6RyfBw38ElnczcBXFnU+VcCD28lRKwo+UoPXYplSCMMbxGekOT21/omPJ
         aMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AybauKNFPo3SsUjhjkW3rvaT9nCugcHZc2DTga5rD+Y=;
        b=soJeUujVPUHQW9WCjUslr6jaExgku20sWyMuYjSaTd4mf/OK7ByPys+Ymb0uTz4jFF
         iNPvB/RZXJ0UlOXk/FPfLOssnCcqb8VbvZu+6dz2tToWRbCxS0mDe6NOXrRZTMgiJ8Py
         T1zofCWE/O5SJiYszEpWdpmAyh/r/xGcA3iinA7WQIdEFTIuN0xrBRnmlJUKYTEOuZax
         SGsxfz3/Bw62GP5LGN0JKw9U927sY0mLdOJ+QukTCMLEap9bg7t4EBf+QfJYDc5JUiSc
         32oKqVYhvdKPqkdlhKP5OJj1eOPWIvIoXOXQVYenBK6cW9PptRRwWyuNzJ/eW8BB5gya
         mXSw==
X-Gm-Message-State: AOAM530WLl4ljxL7LsfNBx7EtYbR7j9QkToDPXH7E+/AncFSoWOq1QI2
        Zb9BAJAFSEZiyUKRZL7KBGWPTepEFMI=
X-Google-Smtp-Source: ABdhPJwU8WQNmo1zhH1aQzP5f0AXaA7UbdvB2nIHEOEw8XVOvuCKD7pK9ur3hioyHd+oC0Rya2glIwWuYlI=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:ad4:5c49:: with SMTP id a9mr6517273qva.27.1627588602907;
 Thu, 29 Jul 2021 12:56:42 -0700 (PDT)
Date:   Thu, 29 Jul 2021 19:56:29 +0000
Message-Id: <20210729195632.489978-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH 0/3] KVM: arm64: Use generic guest entry infrastructure
From:   Oliver Upton <oupton@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Shier <pshier@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Guangyu Shi <guangyus@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 kernel doesn't yet support the full generic entry
infrastructure. That being said, KVM/arm64 doesn't properly handle
TIF_NOTIFY_RESUME and could pick this up by switching to the generic
guest entry infrasturture.

Patch 1 adds a missing vCPU stat to ARM64 to record the number of signal
exits to userspace.

Patch 2 unhitches entry-kvm from entry-generic, as ARM64 doesn't
currently support the generic infrastructure.

Patch 3 replaces the open-coded entry handling with the generic xfer
function.

This series was tested on an Ampere Mt. Jade reference system. The
series cleanly applies to kvm/queue (note that this is deliberate as the
generic kvm stats patches have not yet propagated to kvm-arm/queue) at
the following commit:

8ad5e63649ff ("KVM: Don't take mmu_lock for range invalidation unless necessary")

Oliver Upton (3):
  KVM: arm64: Record number of signal exits as a vCPU stat
  entry: KVM: Allow use of generic KVM entry w/o full generic support
  KVM: arm64: Use generic KVM xfer to guest work function

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/Kconfig            |  1 +
 arch/arm64/kvm/arm.c              | 26 ++++++++++++++------------
 arch/arm64/kvm/guest.c            |  3 ++-
 include/linux/entry-kvm.h         |  6 +++++-
 5 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

