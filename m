Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E63F4F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhHWROd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhHWROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:23 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F1DC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w6-20020a0cfc46000000b00370b0997afeso1801992qvp.15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BYMhGy+epBtHbIYQT2/VbUiIkPl/Kv4Ems36NpeUGps=;
        b=wT0V05nbcLtKte6uXnUlxE52FOtdLnLKCupQHGQRJf16S2rE9Ids9NA0gz3Qev9arc
         k/a1BmTpNar/ew1KuYgFbWsa9Hd7abezUfV1EGIX9ItkLJlPMAtrIwBQm1SUyUfRBcvR
         Xr+kamQphUmQtMBsy/tgLZtXd7i/pWvsYgWSlVO20GdhlNLif9AyfKvI72ySabnAk1AU
         YQSTOlYLxjxC64U0Z8LllnN2Uf28waRqdV/5NjfXntrfjzJ5yDWPUyc7XJ6ViBnDUri0
         erHfjBnjz9nZKsQTvtmmke2PwOpW7jBd0Ij27ONud4W+BXjk+auaDZp6zw3J1QJGv7NN
         tG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BYMhGy+epBtHbIYQT2/VbUiIkPl/Kv4Ems36NpeUGps=;
        b=dx6Nx0O2+pVSWdFcGvPtD18V3apFl8E9VJD/F3VYWL24ofAzxm6z9KH1D4K6EbZP51
         nn22SdhRpouirEV84LSZjpfyAGbv+CiaKEn+BlhLMbc7ABJ3pNG+/uQV1CiyirJ+zMHm
         V+9bLIX/X/oKGTsOZBAjEhjws9evUl1iWK1XZa2yF45giq3/cc6BhuDJO8kO4Q8iuvno
         o7kQtbUJJQjE0bZ1gHxehV4gJeIDFjiiR9KhoQEnqd9x397zS/KyonYNn5JlK8AfJJ6x
         MK8G708iQgfpXj6+RqTOBrQ1jUM/08AfMT9Wq0YVmzufzG0pwSczRYiCuEElWvoNy/KX
         SlMA==
X-Gm-Message-State: AOAM5300A9AqYu97dDvoKvQewUk8gn9yCOkawdj7GlGtD+IVGQhXIvmG
        Hx3ItI9kbJIzfP0UqYXzJ4zLjQPLa2ALslR5Lj4=
X-Google-Smtp-Source: ABdhPJwiVYYbpwCgNO4jaCxSi5gp0M4KQZKNZEPiQ9kbx3ytaOBPYGiiWpIefhbqdr1fOsij3cYx8walgEP31P0VulA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:2623:: with SMTP id
 gv3mr11237178qvb.9.1629738820095; Mon, 23 Aug 2021 10:13:40 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:12 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 08/14] x86/extable: Do not mark exception callback as CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

The exception table entries are constructed out of a relative offset
and point to the actual function, not the CFI table entry. For now,
just mark the caller as not checking CFI. The failure is most visible
at boot with CONFIG_DEBUG_RODATA_TEST=y.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/mm/extable.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index e1664e9f969c..d150d4d12d53 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
 		return EX_HANDLER_OTHER;
 }
 
+__nocfi
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		    unsigned long fault_addr)
 {
-- 
2.33.0.rc2.250.ged5fa647cd-goog

