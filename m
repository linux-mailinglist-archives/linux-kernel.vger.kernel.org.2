Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA5422457
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhJELC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhJELC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:02:28 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E529C0617AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 04:00:12 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so26539500qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=qua6hkgX1DqgYC81lcf9MuNL3xFoQ65uNHSjN4wVu7E=;
        b=p1/pKdO+SM/iSx7K48QqvvkZX8FRzxvzYLgyl79HaAerm0m5U1Bp+IoclavLshBho3
         9v5r/FDpEkKHjM73/00RJzHlPnJYWGnBbgiPdsMTyqBVXLZlxU2uLtOwr24IAOBwdgIq
         720NGi4mOnutTp5+XTPjJbCKHbF/pTi0cGjx2S3ZuVxIApBJcDo0W5f46EUTC03hjuxR
         ldCPYX1y7fMSAA8nTXfIXJV74VGl/mBa9CIkNqVC3xF0G1TnEx6IWSv5Y4OmJr3crRuQ
         GoLKr0jisSBGsmq5thpuIc+3+6B5odAgmhDZKnxQoP8WOzjXERpMFOtl0K6B3PCvje/j
         938g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=qua6hkgX1DqgYC81lcf9MuNL3xFoQ65uNHSjN4wVu7E=;
        b=wlPfoXm0TxYl8hRVp9oExK9iX3n562sC2lV500ZewUd+2/K7GlJPjOi61DxrPMSGE0
         MIrJCkSHaicN9z4M3BP/sc0gjAZ0AltIWGlULB2Tc3U48B5c3FmYpK09R/PBtVgWobgB
         jPR5f0Q09UJk6CZD+uDWqAvScFvwGMIoMyy0w/cPm6fkV+dphM8wc1um6R3sfTEIqR2H
         BObKJfagp5IrEKI6arnxS615C2B4Kk4Xl+ZepWgwlKVUZYq271gPToJEE1MpBD2bkOpL
         l6w6VzEzjDM3XD00ASb7aGQfRd9u7ce5qcaraly9aSjeqBZ+7AKpEIB3wWci8OWlvHtt
         aIjg==
X-Gm-Message-State: AOAM530C5fPwxFitxcrPIdQGrTcjkI6ugjpNJ9OWKsvjH2wsLEoTSyaS
        3qpQvhJKHH82T9XIZUC8SKpkVk4I+Q==
X-Google-Smtp-Source: ABdhPJxjHycsrzsJBhlbfWkRoL+tWY9Y18zzBZYEfmQkvpWJfrNPv+9OM/BxphLh6Kg/b61r/C2Vuw5AJg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1083:: with SMTP id
 o3mr436313qvr.57.1633431611175; Tue, 05 Oct 2021 04:00:11 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:58:54 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-13-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 12/23] kcsan: Ignore GCC 11+ warnings about TSan
 runtime support
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 11 has introduced a new warning option, -Wtsan [1], to warn about
unsupported operations in the TSan runtime. But KCSAN !=3D TSan runtime,
so none of the warnings apply.

[1] https://gcc.gnu.org/onlinedocs/gcc-11.1.0/gcc/Warning-Options.html

Ignore the warnings.

Currently the warning only fires in the test for __atomic_thread_fence():

kernel/kcsan/kcsan_test.c: In function =E2=80=98test_atomic_builtins=E2=80=
=99:
kernel/kcsan/kcsan_test.c:1234:17: warning: =E2=80=98atomic_thread_fence=E2=
=80=99 is not supported with =E2=80=98-fsanitize=3Dthread=E2=80=99 [-Wtsan]
 1234 |                 __atomic_thread_fence(__ATOMIC_SEQ_CST);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which exists to ensure the KCSAN runtime keeps supporting the builtin
instrumentation.

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 4c7f0d282e42..19f693b68a96 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,12 @@ kcsan-cflags :=3D -fsanitize=3Dthread -fno-optimize-sibl=
ing-calls \
 	$(call cc-option,$(call cc-param,tsan-compound-read-before-write=3D1),$(c=
all cc-option,$(call cc-param,tsan-instrument-read-before-write=3D1))) \
 	$(call cc-param,tsan-distinguish-volatile=3D1)
=20
+ifdef CONFIG_CC_IS_GCC
+# GCC started warning about operations unsupported by the TSan runtime. Bu=
t
+# KCSAN !=3D TSan, so just ignore these warnings.
+kcsan-cflags +=3D -Wno-tsan
+endif
+
 ifndef CONFIG_KCSAN_WEAK_MEMORY
 kcsan-cflags +=3D $(call cc-option,$(call cc-param,tsan-instrument-func-en=
try-exit=3D0))
 endif
--=20
2.33.0.800.g4c38ced690-goog

