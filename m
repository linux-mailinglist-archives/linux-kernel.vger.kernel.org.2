Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C39324588
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhBXVA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhBXVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:00:22 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEDBC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:59:42 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id ba14so2512399qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YwiIAFcQXSeOyp/B8vNFcEf24Aae8LYt2opoMrIBm4w=;
        b=nP+vgqZ0dzk4IGVqW8m5HtrSUTpQlMCc1E3sUtxbLr4f9qcUlVRhyhzXENZ+P3BsOS
         AxPzzISWVGYh9dQX+C7ep0FPPCcePXgSt4guAVfmKdINo7+IXRw9pChj28dozoinOIxv
         WouUfuFgv4kwScX9SYN4b/dqKvXmet/Gu/TQVfOMny5LlgvbS4/L3yn7dgBCIrZsTTK6
         29JcyQjRTx93Lp7KyNG3bPfA5Dx8+rAvIdBJsqi6D5ZF3rbswJdsqyqY+NduF/FW07yg
         B/qn512iGpIL1KzO8GeSUUWO5DY3PXm/tjxGpNxN05JTr8JOKrtW+MG2EAVvggu5H+6J
         0r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YwiIAFcQXSeOyp/B8vNFcEf24Aae8LYt2opoMrIBm4w=;
        b=ir6tC10Sny7alNGRZqa4d1x7oKP/gVjLlEyVKywhMaUsnOIXZ6e1Nn0223Kk4vxvkl
         c2fpP7o+kPmW45SDzU5ol3cW+ODqh0YDv2XLe26fVs62qAORqWYQe0M2DHB6QfLUXaPF
         4GtfrOourLFrJMCULjp1i759z56Q97BIc5wPv5kSfowB4NFG95lJF9hERWTeQT37TyWm
         uFU2aRLJN6TgynPLA3REwUeC6wYChn9QO8ytnN8W8jrCQH6DRdh1+kUqT49kY6O6glbX
         LnXpPsya4ocXsanoqwReJRc0rYEA8dPAlW07uecewhTAXW7yfriN8mdSTVgDJyasAFmm
         sshQ==
X-Gm-Message-State: AOAM531mogMkjmOKMIyRJkGspkWJ9wAVpz+1asP6JBYiYgmsiyFWhm5a
        HoGpETHmnzS+khclDgKdp7QosAbtYb2nbgyFvxc=
X-Google-Smtp-Source: ABdhPJxLvqBsrn6Tk4z+azNaXS+pIsaPj9yOQChrOZY+UeProfXJUK31ge+jhddPN97Q8GSNA6HuD3JhsDSMUfS6j+8=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:2c05:1953:5dce:c3b0])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e884:: with SMTP id
 b4mr19273642qvo.38.1614200381556; Wed, 24 Feb 2021 12:59:41 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:59:38 -0800
Message-Id: <20210224205938.4104543-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
From:   Sami Tolvanen <samitolvanen@google.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
to tell that to the build system.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 3b15cdc15956 ("tracing: move function tracer options to Kconfig")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/parisc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index ecef9aff9d72..9ee806f68123 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -60,6 +60,7 @@ config PARISC
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_DYNAMIC_FTRACE if $(cc-option,-fpatchable-function-entry=1,1)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS

base-commit: 719bbd4a509f403f537adcaefd8ce17532be2e84
-- 
2.30.0.617.g56c4b15f3c-goog

