Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D920F428D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhJKMxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhJKMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:53:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C2C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:51:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n11so10848119plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TfUZzwiLi5+SzReakJZopKh7Hr/7mT1olQHJVB0Sy/c=;
        b=XWik9ZjFOk/4LLMhsIRzlkjZAquZ5m7H8NaN5TMttt2vSZ3pq5pP3OZSf38j4YwHdI
         gjCeW9qYzgChbzQJD9+vA0aSFs6YXFrhxrd3rqnlmxR1GizzkXt+sM6zVBqjusLxYRlr
         oFCzJgZAGDR9YcUHlYmAWE+g+tAvAYJLMaPtkzylAJKuHQx0t9Nuf4vsRqWEWd36cLnk
         XPHOioohb1gNaWDDI5dDzjmVakYn8I6bGgwP5i3OdDKygO0wd1y5RikGTYGx9HuCBdMB
         EBIUYsbYxRCw9vpRoOvuU0Q8E7rX/J7r0WSXj9YUU4GRvKs5uaKHa3k30jMKryt0a4iH
         0BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TfUZzwiLi5+SzReakJZopKh7Hr/7mT1olQHJVB0Sy/c=;
        b=kbB7fLP/Cq0bRFSKqMQhFApC6zxEFd5eeXCJbMhYIsaXJDYjEbBfHQoj/pEio9B9LB
         phP67dbnAJBe8orHIeMKvPoIYLbvl/7TWVLMGOlROYRlfnvsvuLsGSDBzYUekZGnE4Qu
         yScRreh/ynwMrWvpQp7fnSIeh4TD8ZkETJQH0EDV0AwF7Txw3CZS7WEwf54t+txSwCUJ
         ZL+T1f64qEMWNXT+wHQd+dGOFOp5VUc6ixmPf635/S7xGBw4xRjCGyp9DP6xhvOyWwWh
         fM+IJxsLV/NDNZg3r/szp8aQc3UUpUmW/SpCdCSdTbAcm7VsFfhFA1tuAH4EK0O0iWrk
         tEcg==
X-Gm-Message-State: AOAM531ja4gXZyLyy1HexmGLNKoyi8CMWanOZLxlrQ3s94qlOje8M3eW
        wFsBYq086HqOL16VmttCzG/PokWwEtOJaTlq
X-Google-Smtp-Source: ABdhPJxFZ3ep63oEgxhyrB2JHoxuFpBAlBufBPTktok4aRDzrFgs5FckkIkLnYlFxBevJSyHzNRdhw==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr30587060pjr.17.1633956699007;
        Mon, 11 Oct 2021 05:51:39 -0700 (PDT)
Received: from localhost.localdomain ([223.178.212.208])
        by smtp.gmail.com with ESMTPSA id y18sm7734194pff.184.2021.10.11.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 05:51:38 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, rostedt@goodmis.org,
        mingo@redhat.com, samitolvanen@google.com, ben.dai@unisoc.com,
        mark.rutland@arm.com, nathan@kernel.org, keescook@chromium.org,
        ndesaulniers@google.com, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3] arm64: ftrace: use function_nocfi for _mcount as well
Date:   Mon, 11 Oct 2021 18:20:59 +0530
Message-Id: <20211011125059.3378646-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 800618f955a9 ("arm64: ftrace: use function_nocfi for ftrace_call")
only fixed address of ftrace_call but address of _mcount needs to be
fixed as well. Use function_nocfi() to get the actual address of _mcount
function as with CONFIG_CFI_CLANG, the compiler replaces function pointers
with jump table addresses which breaks dynamic ftrace as the address of
_mcount is replaced with the address of _mcount.cfi_jt.

With mainline, this won't be a problem since by default
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y with Clang >= 10 as it supports
-fpatchable-function-entry and CFI requires Clang 12 but for consistency
we should add function_nocfi() for _mcount as well.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---

Changes in v3:
- Droped fixes tag as it isn't critical.
- Modified commit description in order to make this change for consistency.
- Picked up Sami's review tag.

Changes in v2:
- Added fixes tag.
- Extended commit description.
- Picked up Mark's ack.

 arch/arm64/include/asm/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 91fa4baa1a93..347b0cc68f07 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -15,7 +15,7 @@
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #else
-#define MCOUNT_ADDR		((unsigned long)_mcount)
+#define MCOUNT_ADDR		((unsigned long)function_nocfi(_mcount))
 #endif
 
 /* The BL at the callsite's adjusted rec->ip */
-- 
2.17.1

