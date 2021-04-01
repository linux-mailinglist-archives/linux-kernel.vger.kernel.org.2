Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9B3523F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhDAXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbhDAXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED89C0613A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:32:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b13so3650551plh.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UnGCKexXdTyI7Eiqrpiu9/A3gEqTseA/WgHOqsa1uKs=;
        b=Y6zfeKMJZ/0smJ+JE3FMI+/MMd/ZXHcogVJQP02BVRavDHQc2Edoxb8O9UMVaoGWhY
         9M7E77BUjYKqGqhxNg2Ko45u1WpKF8gpGXMiV7k/Tc1x//nVTn29FLsuyQQgeT3V8din
         SROVjqBNbPfeHTigsIDGDSOViR6QN9BzqkYAwyvaBD4SA5L9n9oHfj14K7uLGlt9J08o
         mKGxub1wSpYG2Y+5GS3JqQ4O0M0C5WJF9Q77BaDZaElF6rrR+h+xp7Ff9VOWJ+6vYTF6
         /Wx+GGqcw4dH75WEKap9ddzI2quiNytHhOyUqj2yLAD5J+cNXqEslF8JyxBMuvId9p8q
         rGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UnGCKexXdTyI7Eiqrpiu9/A3gEqTseA/WgHOqsa1uKs=;
        b=Ipmy5W0uJKjOZPMiFj6UNJkheBqS/97XJdcwt3ckMviKBueeB4w6XTu1EPVAt1u+Vf
         /EzYk8Mr+xj0KVhF/igk8OLpGd2LAfL4kGBGR61w5uEGDScGhSJEbUuj0mvOJj7fYr+E
         xMX6V6U7+TpP21N5T9haVoj4R9YObohj+huL6//4UdDvSJX1WB/BZEpg6PKsVCVqdja4
         wWqHyisN46qQjGFG5GOcD5SvH2DzyGDzvuq8KTLwbEJxBaoCckI1iBBuH+fcBeX7yS1W
         d9lHXQGKTP6giip3xPo44idr7r2dAcaKqq2orVCbP6sSYpq3kR2u5MGf1sZbko0nMujk
         e2ww==
X-Gm-Message-State: AOAM5320NAhWvBSjd63Q+TXqi9lsFRHgmfRWu/BxO01k5EB8v/PZ4NoA
        YXO0VZ/XKep9lSGL/TXk9uT6q3zrbOm4CuBsCrI=
X-Google-Smtp-Source: ABdhPJyBRWK1tySqgHsv5VTyvnh7AhzpICkyfxDBUbSBurGBw1+GMJMgKtJy/KlOFY96rLBaJQLLx0AfoI3De6kZmhg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a62:e805:0:b029:1f8:16ba:4518 with
 SMTP id c5-20020a62e8050000b02901f816ba4518mr9437095pfi.37.1617319970406;
 Thu, 01 Apr 2021 16:32:50 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:13 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 15/18] arm64: add __nocfi to __apply_alternatives
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
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
2.31.0.208.g409f899ff0-goog

