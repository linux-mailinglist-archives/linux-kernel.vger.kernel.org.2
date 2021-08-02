Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42D3DE015
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhHBT2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhHBT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:28:26 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1AC061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:28:16 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id d9-20020a056e021c49b02902095727d18dso8906902ilg.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OUDEC1vqPr7sdUdf2B7zr2nu10+QX6s5o8FUl8jn128=;
        b=UGdnaf0Z5zkw/NSqrI8i5gZcNR0jvyngA3yzdo3qsADSiJEY6hBCd+mpE/zuWfHHRK
         1uu3eDJRyuFQ2ZFJORG7LWmLah5k/+OgglzudgvK4iTfUlNbWqThqIgSaY5vTYXHBOHe
         VSNGHmflOtl8HILOX35h8lv6KZ27Eg6gCVfW1TSSp6TuuN0kIBefed3k0k+pTHI93Ppj
         /YVEfDB/dDnXAWmDJXHRiBWcrGjzys2+pKWHoje00bxlY+OaXkMAzjZqwCsOcjlMqaYu
         sSnh4SFsoRSWsaWU93DH+gz+BGSC54rKvFG6GeqZJVeELDYvCIyKollPVH04QqV4NaTI
         88sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OUDEC1vqPr7sdUdf2B7zr2nu10+QX6s5o8FUl8jn128=;
        b=Lq1fODppQwcBHw42SMQ9112Xu0bufy1voon5u8S73/dQDoqWvUCI6zlKzQ46CkV8LL
         fmtUmiiGJ7lnt/sc6qII08RthPMKCeFpBaBASMISQ4B+MnqsivDvRv2BC3uMHZUjtdYc
         uxUTTVfc6w3bojqeOVxdy+u7rF9FGpggMc7FCMiYk0X2A42uAmNc6v7BGjNFZM8ZxsRA
         o+vOyMTgRW+EBexso47SlD8yNaX09EbM7+IGZ+IlXu72S2ybrM8Gm0Aur0SVtlGEfJZO
         B2J9rG1ycjYGAYhPef4H+S2hn73ycemQ0z2QWEjO6oCUNYnILrcF6EHagbpGTcBiDs7K
         tFjA==
X-Gm-Message-State: AOAM53291KU9bEmLTDL62q5T5/qXIo+qtDFalMR0vhJAykPE+1/pWs8a
        SsLMR6/8rh08t/JkIgDAgzrleN/RKvo=
X-Google-Smtp-Source: ABdhPJw9BuQeA1J7hyFa/wKhd4oWSoC8qIUMN6Ku6i73EKILJHTfLU4lRZ39Qjqel47OyIbrpzh0uk5O0G4=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6602:3404:: with SMTP id
 n4mr724981ioz.31.1627932495517; Mon, 02 Aug 2021 12:28:15 -0700 (PDT)
Date:   Mon,  2 Aug 2021 19:28:08 +0000
In-Reply-To: <20210802192809.1851010-1-oupton@google.com>
Message-Id: <20210802192809.1851010-3-oupton@google.com>
Mime-Version: 1.0
References: <20210802192809.1851010-1-oupton@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v3 2/3] entry: KVM: Allow use of generic KVM entry w/o full
 generic support
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

Some architectures (e.g. arm64) have yet to adopt the generic entry
infrastructure. Despite that, it would be nice to use some common
plumbing for guest entry/exit handling. For example, KVM/arm64 currently
does not handle TIF_NOTIFY_PENDING correctly.

Allow use of only the generic KVM entry code by tightening up the
include list. No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 include/linux/entry-kvm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 136b8d97d8c0..0d7865a0731c 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -2,7 +2,11 @@
 #ifndef __LINUX_ENTRYKVM_H
 #define __LINUX_ENTRYKVM_H
 
-#include <linux/entry-common.h>
+#include <linux/static_call_types.h>
+#include <linux/tracehook.h>
+#include <linux/syscalls.h>
+#include <linux/seccomp.h>
+#include <linux/sched.h>
 #include <linux/tick.h>
 
 /* Transfer to guest mode work */
-- 
2.32.0.554.ge1b32706d8-goog

