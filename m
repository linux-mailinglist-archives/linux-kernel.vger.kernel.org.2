Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068A335097C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCaV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhCaV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0858EC061761
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:27:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 71so562437ybl.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LhQny/aeJmeAJ3bCETNM8gy3/qff2yzp1+GBUrzrBDs=;
        b=km1dlNMsZVD+nYKyhmf8suslG6lRpTXA9bXfPOZq3XJD2bh9lwyHlyugNqkc/9xIHZ
         pvZZvVE7uTiP4xcSdTYcIUDfgVzPvR8B7rp/SUuIegT/xhp5Kgp8M2Jfv/MMMGMErURD
         D9lFaSTH90mT4zzz7CkOxbEyPbFaLhhQWqZx9kshO8db8Eo6StC3w+wbFjJuHk4jG3HN
         ucAsImNaXJzMhnj+fyaph3WhubhiwK8ZKwoWXX0hwNzxpHCWqtnmqIC8+kn65eGYZQAL
         IxDudopx6hMfpUdyShz//HZdprJ0b8BJcZVh1a1jajI/rhbjlvcxdscLYnc6MfVzw/7Z
         xOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LhQny/aeJmeAJ3bCETNM8gy3/qff2yzp1+GBUrzrBDs=;
        b=EWY9NNuVwV5sSAgeT20VVhIhumRXlWdCjd39Q/CKxjGuf+6EmB+Ew2y9Sri3qE5klN
         vJsWGg+TJ7R15AfFV+QKiYeHLpiAmDrrnTXRL4xEYR+YEx9f55mGYu+Fo+riMqFj3+Ea
         9HcqlRRQ8105INifhx24g0EM2Z3x9yb5fdCQ1V5X2krALKD2UwrsbYArwXYXAhENIOtU
         Td2EjXw2k4U7btvgHyqcDE6ej1tovRslXwUzIZXgokR8CwulJ9wnebPa3FC2sfBHQ89M
         duq/aK07DC4e0b9na9I/Bo9FhpAmBjy//yk7LUonOTANmD8m2EKkADvA3a19O/5bpf0m
         UMYA==
X-Gm-Message-State: AOAM532fTTID27hs0ywrbkh/q9wL4Ew5v14Zi/Fd3kIKmIowou4TO1U3
        HdxIPAVcU1rDa0BbOq6useqSkgF1qUj9OKE+rWE=
X-Google-Smtp-Source: ABdhPJwLju6B+haVkuwTRD6OTE7Kj+Fskb9zJBbkaGFlIanyE03asSCx14sDc0Ys7LCvhLw3MkN686iAQEZQHDgH42E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:38c6:: with SMTP id
 f189mr7492638yba.183.1617226063121; Wed, 31 Mar 2021 14:27:43 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:14 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 10/17] lkdtm: use function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure we take the actual address of a function in kernel text,
use function_nocfi. Otherwise, with CONFIG_CFI_CLANG, the compiler
replaces the address with a pointer to the CFI jump table, which is
actually in the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..15d220ef35a5 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.291.g576ba9dcdaf-goog

