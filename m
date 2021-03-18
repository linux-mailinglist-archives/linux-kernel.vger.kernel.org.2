Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819F4340B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhCRRMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhCRRLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:48 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DDDC061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:48 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a8so16819653plp.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=jf1TyFgM0qbBrh8PG+9UgOrM2tO3xTLSkbdFlAjoOHwSeKc0SfFX4Q0fQJiehD98Nx
         V8eHEHeFH6F/2w32lpdS3m06xBAZ3vNDNaCX7x8qpFxSBm6uQOUYcLoYxxuENofMBupO
         B6duso7Pzno7l5uVBkFz0xUe8AtQKuhaTmELX5H6eGSYwEqGS1XqRT74+g1vLez+eXeQ
         7z+ITybX9ylbz6ZkOa1dh63eUDWtdli7pIImj6+FfB23BTBDzIAs1fv35o+sxuUwBS44
         oltowRxFMks3nSe/2PYy3IOmtCU5Xy90zkjD6XlVuVonF/+UFPw1quOUALWqQTVSZsf8
         4bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=TlMucnqv7f5cDSdCLjv6vcu7CdUQBD+uMRYmX5VszUfeGvLY2IE5LEA2yFmoIWAZ+q
         QFUv942X9N7zqD4OYvIfmanQd16eC5OFqdGbRn/0sU21ZO1L29hYDMIfEdtNxrpHj93T
         G8ex6EEd7CX8cJQR6Rva5Bbm1vyTWO5i9r5ZspeJFG4GYu6mkuaw6EdTh+cSOM5weNRs
         dmvSVcId2g3uiQj/re++WjEy4sXPFhr799DK/ShYfa3g7FJBPB3jQwDSWtzI22Do1xxo
         t2gsisjHBD/mys/VaZ5CsXu7hXB3+8yG/J8gslecpQILBAim1TsvDDzu6pWWfKHV7BWF
         IYVg==
X-Gm-Message-State: AOAM533sbl2EQXaHq54IMt9uuyxEr+kEGktsbB0AhsyzFpYG3rjqb6V1
        BCy2200zMoVG3xF+KVyVdcrNOkI/zWi8JpRhCN8=
X-Google-Smtp-Source: ABdhPJwHw3Ga/ReLCOxUOvdN7Ru83Wr8fqQUCOT6GinoqE3bL2zrZGNpaekhia574g649F2KSLcKcxlK/YtI6PlZyyY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:aa7:9ae7:0:b029:20a:d94d:dd61 with
 SMTP id y7-20020aa79ae70000b029020ad94ddd61mr5297194pfp.0.1616087507868; Thu,
 18 Mar 2021 10:11:47 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:09 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 15/17] arm64: add __nocfi to __apply_alternatives
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

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.0.291.g576ba9dcdaf-goog

