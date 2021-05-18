Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D603881C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbhERVAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238437AbhERVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:00:21 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE18C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:59:02 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso4267559qta.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nnsMNSAI45Y61w2ZwBBkPC0ZzHgySsNQlypNad+FRoA=;
        b=esqjwBlzLOiKotMW09Du14ROzMqRS857IjgeTucMFUKAqnbXWJDyRt15fr+8vLpIKr
         T1eEEbyofUbsHLOQaohOsCwO57jpBxw0vBIx2phAja8dWCU7Qih06YOVKPKDw8q1LqsG
         ZUqIwXhRZpqymHYfAgblPGRNzQnXwHwwMOWLaJUTdPwyTtqa/+Kv6poqxqbksq6g3+kb
         TsPqwzjIDkb4Y2HdpZ+gPoCOMdHCJgPEooByl5HQXOKCzQuedhJuLnp4sHSFn2qC+rN7
         AQmqnjq+vF1zZJ7KfrKju7puYPsCpskXUBpb6KalINQ5KhQt3Q/RPrMYk6hV+PIuL1E4
         AXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nnsMNSAI45Y61w2ZwBBkPC0ZzHgySsNQlypNad+FRoA=;
        b=QuCEbJUu/Q20rDE0RpelFpsi49noNkufI1ElbHv1X/rLDwiPk4CM/87kyStdGkE4Wn
         fRIqQrJ92OU5AOe2YXjkP/D/6pTROzzIDNS54T3l5j8+L586Kls3g5Yb1DC3O9BByKuF
         /86RcQw/Hn2IaYInzalipqojlWVNynbA2uDqbPNTMtUdPGkaY2EfyLcjkmKzU9NJLPDy
         3WeldutZ5o2T0sXfK9CiG+tPw8xrNXxil9CtL4iz5Rbe0tE7jzcJtrwo4t816z7E+JlD
         I/Asb+vfvtoQNsBZ/epgK6BNLiojGHTCcJv9DC2Orr6RzpALxKUoqLt8Ag9RM1zR0FKh
         MPWA==
X-Gm-Message-State: AOAM533XL0ZCfjpMCECvAL04NlWIcpr6l2qs5EGfBVfQvVxasG4O68QF
        NzOAighCkblfkN8m+t8sNV3xTlw2PbyETsTN5ug=
X-Google-Smtp-Source: ABdhPJzLXe5fcHrZr+dhBgrrMBuJvRjijTzgEAczvcdBQ5qmM0LOeNAM9JzQs+YYe2+wCuIlawCmy4lJfoz1fmAjzB0=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:5ce9:69f5:c21b:140f])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:450f:: with SMTP id
 k15mr8283687qvu.4.1621371541687; Tue, 18 May 2021 13:59:01 -0700 (PDT)
Date:   Tue, 18 May 2021 13:58:57 -0700
Message-Id: <20210518205858.2440344-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Fangrui Song <maskray@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until clang-12, clang would attempt to assemble 32b powerpc assembler in
64b emulation mode when using a 64b target triple with -m32, leading to
errors during the build of the compat VDSO. Simply disable all of
CONFIG_COMPAT; users should upgrade to the latest release of clang for
proper support.

Link: https://github.com/ClangBuiltLinux/linux/issues/1160
Link: https://github.com/llvm/llvm-project/commits/2288319733cd5f525bf7e24dece08bfcf9d0ff9e
Link: https://groups.google.com/g/clang-built-linux/c/ayNmi3HoNdY/m/XJAGj_G2AgAJ
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ce3f59531b51..2a02784b7ef0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -289,6 +289,7 @@ config PANIC_TIMEOUT
 config COMPAT
 	bool "Enable support for 32bit binaries"
 	depends on PPC64
+	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
 	default y if !CPU_LITTLE_ENDIAN
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
-- 
2.31.1.751.gd2f1c929bd-goog

