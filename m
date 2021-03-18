Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E923340B71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhCRRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhCRRLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:52 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:52 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id gv10so21688734pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WZ2fsTX5FLJhX01BulIdj9aVU+u+1SaaqVDcWrlk7vo=;
        b=p/MDs2PDjsFiD6r2Ts6jM6BFyv2fovLwrbhh8l+TmOVc+XN/ujL2rtlnXKiP30RH8t
         S6UgRxg5+yaZATMiFP0V7CZXbXRNJuWO2POyPyc/+mNIGwUkdBn8lGC2KIC6cz2hh6sv
         CJDbF1wva6NSYjwFp6yOZ5B/8Wi6p/+1TbqSDvFzeJTm5qNOjQDlJzu+az351Kb6k01L
         8H9aN9DLPhNUJmU3pg9aSJhzVGaGFQW4kJ4pkEcD6+oA15BQDjpnmOHp8Myq3XE58psG
         csbaakT5tvQ7HUsKigBvtgqMzAnRmEwTfvnkEOj9XxC1ys8T6tR9JZXH1i/okjccLokC
         xvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WZ2fsTX5FLJhX01BulIdj9aVU+u+1SaaqVDcWrlk7vo=;
        b=N4cuDGDDDaOVSq5e82VKCIr03uYjDTmyz5ORuPqJNdSWpFnth481CwKzhJPkh7F+Ep
         7mZY3JDWXAwYXwjR1/LYXOLMrpttmmmKHKNzL3zSW/hXwvthqhSXnJA5+LQ9t0mkGvTI
         yE6txm8EdZ9z8NZR8AKMdxFiiC7hUfA3GGZn68ry/gi0KBEkh0P39n327VoHYJyGtSU5
         ObSDmcMeQi/LL+6v0/tf/eQ7ap+myPlLkERwaGIITjj8SPVuMINyr8GknOoQMkFk1jLU
         Y5PH9jxFxunMkjnGdC3dTrKytkEYnan5sVeG8JKQWOiK+/SJdNverRPrUN+lJ4sucgTS
         Q7Pg==
X-Gm-Message-State: AOAM531M0IrgbeGrz90eS2S0Kxf4B5r1Th92hzNavw5FwZeZ9nqV9b2m
        vS9h5ua2ouiReHNPjSCM/yep3+/Mvt5PPWiOYFk=
X-Google-Smtp-Source: ABdhPJwVhIeJ7eN/c102kC0C0PDipbzyJDdK32hnyHrtAGB4zJkWiAPX1yDL/oR7lqAn8+vlGW94yr5eZySyWBFd8bM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:aa8a:b029:e6:64bd:e29d with
 SMTP id d10-20020a170902aa8ab02900e664bde29dmr10716922plr.24.1616087511958;
 Thu, 18 Mar 2021 10:11:51 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:11 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5656e7aacd69..2eefdbc3e3c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -75,6 +75,7 @@ config ARM64
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_LTO_CLANG if CPU_LITTLE_ENDIAN
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_CFI_CLANG
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.31.0.291.g576ba9dcdaf-goog

