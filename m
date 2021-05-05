Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D61373F84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhEEQYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhEEQYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:24:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24EC061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 09:23:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d4so2488789wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XN47Z1msFXr3oDKB1aZHCS/bnZ/+lvKQpoKFFoW/yU=;
        b=ix/7UViMhrqY4NFEXW6WuTj61OtFrhsyijxpOhJFnH2MpopB33MturLkApDTYc4ET8
         10PpDLlIHgpSX6Q1Xmlu1ICN7V9HNsUnj9MMWPqxwlhDPTq6Hf7VVMnSf6Cb5Vlx0WGI
         zlTQMZyo8FUTla1KtAry3OcjORiOyuctj3DRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6XN47Z1msFXr3oDKB1aZHCS/bnZ/+lvKQpoKFFoW/yU=;
        b=evWfyM7CUA6i5PPvDVJHdkDP6oQCYMbfsrbPmzaRfxf9iIMRia5VguI3SY53vtHocf
         LcvGJ508RBNir+zCSn83ybc5FWAar6HZs/QDM30TiMkDS0SLmS4vz+7vaaM8fIXR5bk3
         xPM/GTgHXxfW3375mOI4Za+fDj7QCqUzv3Oi0uXzQ5gvOlGFCqc9xjo2HNqOlOudRq8S
         prPVShQjaa0POUDpcEqqmXW/5k9AMgyLNvhuFzlAFkitN9kLUrPqgF3olA4O4Hc0d69H
         tml+bvhUOs0+eVGHK0MAiZ5d2UTPg4KwxyBeKQuhMzWE5n1kcfxNdQKqhlnQZMsoBpoH
         bTjg==
X-Gm-Message-State: AOAM532y77x28blnk7FCmC4G8imcyfJBVhI0GfNvdxivpbZvonRSz4q4
        TOBXlliwLM05ZgzEWhEGLG7L87GJEvW9Gg==
X-Google-Smtp-Source: ABdhPJxEiHkV7KG5Rx3iD3zJ454hg4/eNOKMNBsVKrXdk6NEynpDH7WKCEjtkX41/46Nfo2ew7UwRg==
X-Received: by 2002:a5d:6e0d:: with SMTP id h13mr5103442wrz.118.1620231796710;
        Wed, 05 May 2021 09:23:16 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e29a:615e:d9e6:423e])
        by smtp.gmail.com with ESMTPSA id u6sm6260955wml.6.2021.05.05.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 09:23:15 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, sdf@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        syzbot <syzbot@syzkaller.appspotmail.com>
Subject: [PATCH bpf] bpf: Don't WARN_ON_ONCE in bpf_bprintf_prepare
Date:   Wed,  5 May 2021 18:23:07 +0200
Message-Id: <20210505162307.2545061-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
per-cpu buffer that they use to store temporary data (arguments to
bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
by the end of their scope with bpf_bprintf_cleanup.

If one of these helpers gets called within the scope of one of these
helpers, for example: a first bpf program gets called, uses
bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
another bpf program that calls bpf_trace_printk again, then the second
"get" fails. Essentially, these helpers are not re-entrant, and it's not
that bad because they would simply return -EBUSY and recover gracefully.

However, when this happens, the code hits a WARN_ON_ONCE. The guidelines
in include/asm-generic/bug.h say "Do not use these macros [...] on
transient conditions like ENOMEM or EAGAIN."

This condition qualifies as transient, for example, the next
raw_spin_lock_irqsave probe is likely to succeed, so it does not deserve
a WARN_ON_ONCE.

The guidelines also say "Do not use these macros when checking for
invalid external inputs (e.g. invalid system call arguments" and, in a
way, this can be seen as an invalid input because syzkaller triggered
it.

Signed-off-by: Florent Revest <revest@chromium.org>
Reported-by: syzbot <syzbot@syzkaller.appspotmail.com>
Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 544773970dbc..007fa26eb3f5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -709,7 +709,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 
 	preempt_disable();
 	used = this_cpu_inc_return(bpf_printf_buf_used);
-	if (WARN_ON_ONCE(used > 1)) {
+	if (used > 1) {
 		this_cpu_dec(bpf_printf_buf_used);
 		preempt_enable();
 		return -EBUSY;
-- 
2.31.1.527.g47e6f16901-goog

