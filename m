Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3343DAEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhG2WJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhG2WJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:09:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285AAC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:09:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso8184899ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y1FozKgR1OGtch4GBgu/T53ekVcZG3++UIur3cT4k1g=;
        b=KCVCCjvfgPmT2bb35uWb5YZDXm5qgf3gJxeSBmXlrVF1vncKlfaP8Wzzg1bfZi5Nkr
         T8v+aNTulTf6jbCZMm835Z7w86SM4E2eEqKDSBtbNqNvwJqd1ScPCOp0Ppmlru9mdffm
         2PjMw4XxdccM8Am6I5NOcHkW9SIi6d5kd/NOAMDmNU4AT0AtBagT7M03wnlA7CmKb395
         D5Bhao5isUgygnfi8Jw5PgpS4XM74rDfLMjm2dFm0CYi7EcZcLhU7AzADCylciD28fEy
         aVUkLMiMdzIfZcktnJjBcPjav6cUYulnE9PWO19nsbfIJ9H+tszoSYfrdd5VQDoykvdb
         fBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y1FozKgR1OGtch4GBgu/T53ekVcZG3++UIur3cT4k1g=;
        b=pO+t2GJfxmeVz/2Q0fqPhVx7UlZdtNPBkbHbdKBundWCYkpi8+5BMpzHuWVivrWYlu
         6VkmKnMuXn1O+OI8jxnx60o9NPc8pgZxXVUpUwpdGyrqMwDEADdSvxM5rmndAj4ClZ+F
         sSyw/XbZR+py/+rqJe4ynBYlSMRsf8WA61iVEolCJwuAe2eoe7lM0HlmxcgCFH6qquC7
         bedjCTZw36Cah7r3vHm0BVQ1D6r9hWgKkdsicMP3QiD5nxEC2WssgA8oraNLLOL8osMj
         7k0PrGCgOCbDpsQIvbzvIzKVavrj/M1Itc9uv/w+Rma2LIiqsUnuXIIggbRnYNc53thj
         0yJg==
X-Gm-Message-State: AOAM530WK64avRvx33Bxp6gKiMoZIlgQP6u3ac+3DxEINWYh+EltrwZO
        oYqTnQNBHNTY4PeZFt6oKUl42HkoTbs=
X-Google-Smtp-Source: ABdhPJweYbkW6ntZKyVJeSlR2LDQ77+i9PG1QNakarKHqxX2ZyAz6vYGDXkzuixuoiNM0eHVpr8gTAurhys=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a25:3503:: with SMTP id c3mr7258148yba.316.1627596565260;
 Thu, 29 Jul 2021 15:09:25 -0700 (PDT)
Date:   Thu, 29 Jul 2021 22:09:13 +0000
Message-Id: <20210729220916.1672875-1-oupton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2 0/3] KVM: arm64: Use generic guest entry infrastructure
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

v1 -> v2:
 - Address Jing's comment
 - Carry Jing's r-b tag

v1: http://lore.kernel.org/r/20210729195632.489978-1-oupton@google.com

Oliver Upton (3):
  KVM: arm64: Record number of signal exits as a vCPU stat
  entry: KVM: Allow use of generic KVM entry w/o full generic support
  KVM: arm64: Use generic KVM xfer to guest work function

 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/Kconfig            |  1 +
 arch/arm64/kvm/arm.c              | 26 ++++++++++++++------------
 arch/arm64/kvm/guest.c            |  1 +
 include/linux/entry-kvm.h         |  6 +++++-
 5 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

