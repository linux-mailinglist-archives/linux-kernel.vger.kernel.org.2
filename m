Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E05941FF02
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 02:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhJCA5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 20:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhJCA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 20:57:13 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF31C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 17:55:27 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id b34so9547595uad.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=WuNiwrSrEnX4dMPY+G+mXt6Rdx6le2ov5eo31uGaV4I=;
        b=bPORE+Ka6bQ6Ix9WoLbi801Em9kp1jiG0FyOFqPVZt65cg/2zt5ZuNpxySSs0hMhvQ
         ZnoU2ZEzcdWIcy11FGW1VofxIEHe7J4HSnuQtiCf630/RnccOOk81eSeU/KHzch4T/hy
         C1BAMcOgRuQq3GksdQWDdupDqRC9x5KzgZC+IAyAF3uz1tF5Hv0oPI9N2HomeZzcp3Yn
         RvXBXfxNVv+S8IIshKvE4V+2MwNCkZ0niKddHfZPN7VVdp5iP4+H1lue0twzVCoqTt0H
         fvBJgbGQB/9BJVohjDNI58sMDU4fQQKjJCPgtrESqNXxTfXHmUviJnW8Vv6T6D9e4KHv
         M83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=WuNiwrSrEnX4dMPY+G+mXt6Rdx6le2ov5eo31uGaV4I=;
        b=ungLEJGcx+lZjEVdxGbdx0oz8g8+iKfD2YMn8cDjf/rpbSd5eXTy0YW8ApNKViroJN
         6IuyIwhxfitYyijaGCCgaf5THwzigoHM5GExT0HKrruuarh7ummPEgDEb0d6EKmIvRlh
         cVqhp4gqlQdslheJOTcrj7foPfyezHdpnBxpobSdOAgqx0bEvdKGkldL0nHy+dSDc9Hl
         tRvueSLT60JNSbDJNVlt4pzI+Cr3Qrk9ebHnkcLUSZCsmP6z3wnBhAU4ygFLM0Lc2Yzv
         88Y/DJ42az0yI+6einxJX7XDMuH60TamQxnYNHxPKoR6eQh5rD2VJTTOtKnhVOVHdMCM
         fOHA==
X-Gm-Message-State: AOAM530r1wTU2WgDVg2thSIlyJnZ/AYxItCi+WhjSaf+UKQiwE6NSjY3
        QoKF3uAHWM5KN4dRwSOSyFb33R6ouCpjXg==
X-Google-Smtp-Source: ABdhPJzSW3IDnK2jC80wagzqFwX6QHpCIBNq6auYYvJl8xfq3QRo1kdhsuuVeVyrLEVwd1hGJp0MTA==
X-Received: by 2002:ab0:53c8:: with SMTP id l8mr2937713uaa.26.1633222526611;
        Sat, 02 Oct 2021 17:55:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q26sm5273759vkn.40.2021.10.02.17.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 17:55:26 -0700 (PDT)
Subject: [PATCH] RISC-V: Include clone3() on rv32
Date:   Sat,  2 Oct 2021 17:21:20 -0700
Message-Id: <20211003002120.198752-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        christian@brauner.io, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

As far as I can tell this should be enabled on rv32 as well, I'm not
sure why it's rv64-only.  checksyscalls is complaining about our lack of
clone3() on rv32.

Fixes: 56ac5e213933 ("riscv: enable sys_clone3 syscall for rv64")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/uapi/asm/unistd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 4b989ae15d59..8062996c2dfd 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,9 +18,10 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_SYS_CLONE3
 #endif /* __LP64__ */
 
+#define __ARCH_WANT_SYS_CLONE3
+
 #include <asm-generic/unistd.h>
 
 /*
-- 
2.33.0.800.g4c38ced690-goog

