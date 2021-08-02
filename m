Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266633DE013
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhHBT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhHBT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:28:24 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30740C061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:28:15 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id e11-20020a05620a208bb02903b854c43335so13259672qka.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=quVRBmXT16c8/+OvPaemt4sih+vYkJfmbVpHJfXSYSE=;
        b=JIWAzTD8mW/5i0lrePS1nmrHncrYMDBLUNta3fNF8Ym8CYZT1LUk485ozHVMBMDP3O
         QZrHPlUeWTuJF0oW+YnAumjLhjKHbXgy+pcl7q8c6osX3dCzZTpAjWjFcoNK9LoWBW0d
         Kqj87dr4gptUzqRPoLcm/S498Tbiqy2yQxKq48t2nLaQ9K9XyaXz2y+iqZVv9QEm1jPD
         Y5hI3hGYVSBEJzDRk15+/YPLJc2vTS5ZmzyLkBmRWgaOpuT7eps9fvzT6BBQjtHwKYON
         qQubl5pEdkRCv4fdLNsa0o7a8cWRy7YPFuAsNgjwl8cHNB+VLhFnxcNyWeYt8hzkt+C1
         R/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=quVRBmXT16c8/+OvPaemt4sih+vYkJfmbVpHJfXSYSE=;
        b=HQtCoOSwmfmjB2plWwVV3xr76pXr+qa7XqZJFT1Y3Z9H112qPmSE/7q/mBEdpEaJ6O
         aXF03jmIEUkzJb/P9EuqSn0O5rQMo49fAaMSBx5gNIfOmWb+tvXEFLZF295L10JWAX5r
         0uw+cSDgXJpH0O8P2ktfxWvo0HatJJkjrdOeZv9StEGBcf+WL2BC7lJizfVqveax25KC
         0WJN/Z8lrDmAv9EmoWS34s07k0T81YnhanvnzFAYEqOh3YaT95Gi7lFkRQAJF0YumRVJ
         VKf3HO8+c3fXbbD/i7Ufi8fWWSgjk2aouLCn2AGuV55PZ+3iKEIGVFUO8ahqYfEQHRj+
         IQ3g==
X-Gm-Message-State: AOAM530BQo5puAqKHZBeoXBteZUTfhK+5FbzLPAd8Rv0hjPlALe9RXJi
        qxFcUIqNBMBicyjfZW4qAKLiBJoIHZs=
X-Google-Smtp-Source: ABdhPJz1DQuSneO2f/+7Ncn9bFUKrFi6AUVYWFhFUwzGMFfXQ0w8T9ZZ7K0LwD0TDiocdSA4H4YvhPjht+k=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a0c:e508:: with SMTP id l8mr16364594qvm.41.1627932494378;
 Mon, 02 Aug 2021 12:28:14 -0700 (PDT)
Date:   Mon,  2 Aug 2021 19:28:07 +0000
In-Reply-To: <20210802192809.1851010-1-oupton@google.com>
Message-Id: <20210802192809.1851010-2-oupton@google.com>
Mime-Version: 1.0
References: <20210802192809.1851010-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v3 1/3] KVM: arm64: Record number of signal exits as a vCPU stat
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
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most other architectures that implement KVM record a statistic
indicating the number of times a vCPU has exited due to a pending
signal. Add support for that stat to arm64.

Reviewed-by: Jing Zhang <jingzhangos@google.com>
Signed-off-by: Oliver Upton <oupton@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 1 +
 arch/arm64/kvm/guest.c            | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 41911585ae0c..70e129f2b574 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -576,6 +576,7 @@ struct kvm_vcpu_stat {
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
 	u64 mmio_exit_kernel;
+	u64 signal_exits;
 	u64 exits;
 };
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..60d0a546d7fd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -783,6 +783,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		if (signal_pending(current)) {
 			ret = -EINTR;
 			run->exit_reason = KVM_EXIT_INTR;
+			++vcpu->stat.signal_exits;
 		}
 
 		/*
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 1dfb83578277..853d1e8d2e73 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -50,6 +50,7 @@ const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	STATS_DESC_COUNTER(VCPU, wfi_exit_stat),
 	STATS_DESC_COUNTER(VCPU, mmio_exit_user),
 	STATS_DESC_COUNTER(VCPU, mmio_exit_kernel),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
 	STATS_DESC_COUNTER(VCPU, exits)
 };
 static_assert(ARRAY_SIZE(kvm_vcpu_stats_desc) ==
-- 
2.32.0.554.ge1b32706d8-goog

