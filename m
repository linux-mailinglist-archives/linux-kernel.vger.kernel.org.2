Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F9A35734A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354921AbhDGRgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbhDGRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:36:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40278C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:35:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x22so24537629ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BkV3TKwWehfjnaclwW9FgblItKHUQzlZYJ9avEONYz4=;
        b=T1lZ4yFsqWYvoS1DiCRlCTHKUax+T8YUew0zGHGEepVrf48kgR1ww02JGu4Wz7xGbg
         KebB325BaJrEXYKMRPblZbXmYieYpbZ9NyspDV9Z7eCu4PcCaux9rKHXFVrkkNkAZcAh
         o1nxbNyJbYygsw+3C9+6y/LG6S5BFwBz5bV/vtAjwD1olEfHadnfdX5uTCBPRfoQW/pE
         z39vhTaUASvFpIZZ6/Q9i6OvVQ1pH7lfDpBo9ZtVyKqjL+V3KoiLAqziE98a4a0oXweA
         7Tn7Yl+CoR4FedqNprYiztoRanU3dCRerXKdpUVfYOG45l0pArst0TKyu+InPaAp8pKq
         YpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BkV3TKwWehfjnaclwW9FgblItKHUQzlZYJ9avEONYz4=;
        b=MNsLLHOtegM7ym9DdeZ4vy4zQU7+vqy0kfnL0hXdlIYXKWQLADOGcq/JX3SjV0TOT3
         yXoXdyYNvZ0Y+TslD0JMiJqLhRxhzWkBf9JlZLcisBh/PV5hdbLU++PB05BtDYXjBaFN
         3J7ocj40uB4Dt+7UvKOOccDAH8d0fKMBBAFF1LjCqER/gP4QA8zSXgUZRYPE05uVES3b
         Pwk4hb+QYE9kF8JsOUaEAe/F5Lul06RJAjPHD0xDziSPYzEaJGf00md3pBf0Y/cS3ElS
         nINCLKjqrHEuHOHwlzfgWCe1tCMP7jV8VijBFsI5nhBNIIVek0BHKnllTbCn4GKIWJNS
         Wp4Q==
X-Gm-Message-State: AOAM532He51kfO0qC0k6kUWUyCdCoi1bSC49gbjBY5JycO2TgEh8uoSN
        a9/awSTua+p2ciSpLIzIcfHdKuBz9TlYeOJE8Vk=
X-Google-Smtp-Source: ABdhPJy42rUOaM03Eh8vBFdcu8xaIMvohagdZNG+SvsZDA51FS/NywIwIVtK3bBARUCNSzyiJA8MLmGmNoXbrOcvVOs=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:c454:8587:ce1c:e900])
 (user=ndesaulniers job=sendgmr) by 2002:a25:f504:: with SMTP id
 a4mr5740161ybe.364.1617816952516; Wed, 07 Apr 2021 10:35:52 -0700 (PDT)
Date:   Wed,  7 Apr 2021 10:35:43 -0700
Message-Id: <20210407173543.3598006-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH] MIPS: select ARCH_KEEP_MEMBLOCK unconditionally
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While removing allnoconfig_y from Kconfig, ARCH=mips allnoconfig builds
started failing with the error:

WARNING: modpost: vmlinux.o(.text+0x9c70): Section mismatch in reference
from the function reserve_exception_space() to the function
.meminit.text:memblock_reserve()
The function reserve_exception_space() references the function __meminit
memblock_reserve().
This is often because reserve_exception_space lacks a __meminit
annotation or the annotation of memblock_reserve is wrong.
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

allnoconfig disables DEBUG_KERNEL and thus ARCH_KEEP_MEMBLOCK, which
changes __init_memblock to be equivalent to __meminit triggering the
above error.

Link: https://lore.kernel.org/linux-kbuild/20210313194836.372585-11-masahiroy@kernel.org/
Fixes: commit a8c0f1c634507 ("MIPS: Select ARCH_KEEP_MEMBLOCK if
DEBUG_KERNEL to enable sysfs memblock debug")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e9893cd34992..702648f60e41 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -12,7 +12,7 @@ config MIPS
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_GCOV_PROFILE_ALL
-	select ARCH_KEEP_MEMBLOCK if DEBUG_KERNEL
+	select ARCH_KEEP_MEMBLOCK
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
-- 
2.31.1.295.g9ea45b61b8-goog

