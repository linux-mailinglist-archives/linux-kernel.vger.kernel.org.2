Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C23523C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbhDAXcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhDAXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C1C0613A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:32:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y9so4772967qki.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=tM0gdLvYYrIGSQ3UU73+aYUTVKUNIBmfBmMOkqL3kVYculPRqLzgjOxKi8RSH39BMa
         jniLnYQk3/+tuCi/WvnaKTWlkCsW1fENUR+FZ5btuwg0G2PF2KxdXxmwadid13ZqOvDZ
         rnAbh16KswUlnaQJtOdiTw8jRv8opl7cYS0NURIXgAwstF9yjXbgfTteqYONzG6n+08t
         qKrhi560aPcoh7IRXPd/rOy6M0hLASHhaPpvZ1DvsZiV91yOvz7u4r2xHuiyO7s4WLQK
         1hCLqtc2RshinGwJtiZyyBClSa2dPX4j5ksIjHJxzt9tSnvJryiiPqFrpiL8tPgxVSFr
         cCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=QTuLlk83LZaPzsLxcC4MkPLJNMjqqhSe3MztCnwcKjmlLFOvlXOpaX78tknC8wZ717
         3PDk7vygW8mEF6AyLxGp1Qkb6bdaNZRA/i+A8XVsOLOWMItI9Mk8LOjjqcMmtIuMW7ER
         84sksHdJ2jriq336pNVtuzuY/OrD63cENAFjkIc+biFRE5iwH+QwiN0NsEvGgorg6/8J
         8gtVG3m6xuQV5ZJElLtJcbI8vYYTdwbWvHJodJcEd4dd2vS/jpKEwVlyknK3V2+0sU0E
         0g9CoAachIBChk9VZqN1eNYVnfdERT4OwQPMW6CP/bd+5RQ6IMHhsjYxcHYum/J0agGP
         CF/w==
X-Gm-Message-State: AOAM532fF2FKO5F1JttC6xOPalk2MTjtoXgIzUA8i/h/MZQ6aZOtC2rG
        JqveFwIsPyhOXGuAfWJy4TcRy6XZvvzPHUSoeCQ=
X-Google-Smtp-Source: ABdhPJz/GEAYNwZ86yFSuRvcWhakddiQDxgrF7XbdSdZeXfnn4teMz+Kc34ztrNSurf8c3YQYZvgWvRkfDCwo1+2V3U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d7d2:: with SMTP id
 g18mr10283542qvj.42.1617319948605; Thu, 01 Apr 2021 16:32:28 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:03 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 05/18] workqueue: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..03fe07d2f39f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.208.g409f899ff0-goog

