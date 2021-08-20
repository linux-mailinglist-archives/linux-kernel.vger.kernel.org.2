Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C183F36D4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhHTWvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbhHTWvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57271C0617A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v130-20020a25c5880000b0290593c8c353ffso11096209ybe.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=TA/KEkzCm9eGIgSQhw9KNiaLFa6mERWpjzl8Sm2LP0D8MHshBELhR9PNTUHRE29ifz
         mo90lRoRaNLAOUKwpDqprlo0/pMwtc5l0/AtaGDQuwQPp72yFVvsNL3ynlMO5kSBRj5m
         LzAltW2EylkOxsEkvhRVhVSBOVOdYc11dmbjDqZ/XhKiygxbSFOOyUayIR4kGClbFLgR
         /kFKufJdXalO6BD5koMO2tBk/9JBu0VO4U4stsueIYQrrElmsEUFhO7RIz6hEZLybaDq
         KKumExIW2OSfE2RbrTkormhrvk3570q+R6kLizKIzC3ltGy9bDIK5NfDidM6k/fKRiu/
         zAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=s841h0ya/HJLhQQdz4S4IMA7XiR+7kPP6Nen8lujFZFYsPophZCUkmL5nFuyH+KuXc
         GKmQ7slDy3BrguAgqDVBYf95oRRni2sswvIw5ruZhug2sciSGuMNYnQ/rc2TF+0jyfqC
         zgv2PP5FU2JWjmFMWCqZqAKWECxT+RUPO7lwI4gF/6dgzo70RNg+zSsEB0EPVGfOKzUf
         D0YzfbKC7eF7G/Z6HQ/GKqcORTJphQXl+m6XAwidP+XrqGM0FLyksPq0C+xVGTFsBx6w
         Zx9Mx1ePqW7+R+FK8epKPzK7OAdUyHnLdqyFiJ3X4a4ZodRJWoJ4a5UmNan8OR7Ptrj7
         QfuQ==
X-Gm-Message-State: AOAM533UnmH2W+cDHRHRshL/rtfXcAs5wtRubwbHXBZh8LuvBimnJ65Z
        IqvTuibHn/4jaGNG+pPKJVTlOsYzV4A=
X-Google-Smtp-Source: ABdhPJx3Gy465odAHrKuwh+xxU3EOcrY9EoPkXADk8KHQbivIS4NsZANbgwhJ1nQlBB3M+0Hs3NCAAyvqg4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:acc4:: with SMTP id x4mr8790476ybd.376.1629499835531;
 Fri, 20 Aug 2021 15:50:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:02 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
from the installed kernel headers.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 4205ed4158bf..cb52a3a8b8fc 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_userfaultfd
-#define __NR_userfaultfd 282
-#endif
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
-- 
2.33.0.rc2.250.ged5fa647cd-goog

