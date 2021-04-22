Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C0368710
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhDVTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhDVTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:19:09 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0708EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:18:34 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 65-20020adf82c70000b0290107593a42c3so2594831wrc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=N0/i2Z5Ah+iH6G2EkCovNrk2mBQPzeAFd1m1GTNwITesl1LuHaJiptjsZe5b00INE0
         ryeY0Z6v39pUAKaMEgkBjhW9/H/F8x/EC1yO/tKfGc8ZaoNHTpOR9kAM3kK/NKb9i4Pi
         FlpKg43hd6FHxaowCZWxZ85B0Wp9kl8rUBQYQCuPGlvNV3qeM451H99iVqhHIVlfUK9m
         lepgeHJbEFEyQ7zPZRBJfT+zBUJiByw7ElIIWWkDTdmMULFDO6JX+UcPAAyUlDsTmZvS
         /4YCAC5rfJyuBzED+h/5nhWMGtXI7GGykXofz5B7Eq49UNx9nLFJt6fGKSXmdCAZS3la
         Aamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=ejeH91kbxPXWuMfIXZuCkydKC21c1F+aP0byMc+OXNjM7+mVeVIR6H764oxXxSqtgg
         0ErN5RdQntC4Qx4/n/B9xZmr61q6D1e8PCSjWge1doaTXzEgFvpNmLdZQDCYmPg9VNjN
         1IymnGO+cUvHUPmC/fZK2po7HE6TFzLoRxkHL7fguQ/ha9s+IZ6PlYOYseU9UW9uks2O
         oVGhOzJqspEqwNhJ1ypOdi+DQbvyQRNRhDX+F8XoYDeoQMDavd1Hl5Y9g6Tg/L7bSHT7
         9Ur9lyLPh1xyCk4789ze8IWHmFWuL6hqNFR16kSb9gLyJ3HKuu9q35otdQQVPrDFnB3f
         b5dw==
X-Gm-Message-State: AOAM532Yow5ZGopVg4ORq8+oATZ7d3z4sqc50NrqpCiGtfya/IWP9mj4
        i4IvwMgonN0uz4xYHpNzmCheH9SNkQ==
X-Google-Smtp-Source: ABdhPJwl+q5WjR5zsegf/9T50JzWO1+p0hZUP1HC7HBRkSIEzansnudeZv6f3dYlA7JH8yzgTt1aNJBYgQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:145c:dc52:6539:7ac5])
 (user=elver job=sendgmr) by 2002:a1c:c246:: with SMTP id s67mr312123wmf.86.1619119112369;
 Thu, 22 Apr 2021 12:18:32 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:18:23 +0200
In-Reply-To: <20210422191823.79012-1-elver@google.com>
Message-Id: <20210422191823.79012-2-elver@google.com>
Mime-Version: 1.0
References: <20210422191823.79012-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip v2 2/2] signal, perf: Add missing TRAP_PERF case in siginfo_layout()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Cc:     m.szyprowski@samsung.com, jonathanh@nvidia.com, dvyukov@google.com,
        glider@google.com, arnd@arndb.de, christian@brauner.io,
        axboe@kernel.dk, pcc@google.com, oleg@redhat.com,
        David.Laight@aculab.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing TRAP_PERF case in siginfo_layout() for interpreting the
layout correctly as SIL_PERF_EVENT instead of just SIL_FAULT. This
ensures the si_perf field is copied and not just the si_addr field.

This was caught and tested by running the perf_events/sigtrap_threads
kselftest as a 32-bit binary with a 64-bit kernel.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ed81ee4ff17..b354655a0e57 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3251,6 +3251,8 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			else if ((sig == SIGSEGV) && (si_code == SEGV_PKUERR))
 				layout = SIL_FAULT_PKUERR;
 #endif
+			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
+				layout = SIL_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
-- 
2.31.1.498.g6c1eba8ee3d-goog

