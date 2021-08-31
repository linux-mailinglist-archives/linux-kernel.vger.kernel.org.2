Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED23FC529
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhHaJvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240733AbhHaJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=COg2VWl0oU8+KShi4vTMCLtrHzMoyIqvUtR/w8mfmp7J9kZVPCIyrtwvKuVdpON8kPZ0X3
        PBebcz+mwzmZq93IkYNkbDa/X8vaQfgWcyGPFL+EIjqz7yLkIPJT/CKvilZgZUHrrAcHbu
        JgHAMQq8mAvIcXIukncHLKczk1C0oNA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-5TQCOjchN6e4ckOShge2Ow-1; Tue, 31 Aug 2021 05:50:32 -0400
X-MC-Unique: 5TQCOjchN6e4ckOShge2Ow-1
Received: by mail-wr1-f69.google.com with SMTP id q14-20020a5d574e000000b00157b0978ddeso1239074wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqAj4ZrmrtKDThZEc8WrAKFFOfUsJKx4HE/+LaO0ups=;
        b=cFPOREXmUwFkcfkZ6mGf6v+WFc48f11Kbpc1PE5lNKODfkU30CxB+E3upmIPMChYFW
         Y4RpYWuz3g3CNVb6+PQEpOi48rblJYVAdw74r+fqiMRv+8qwhUiprBOJinGr3P+52n/j
         bjVriEHQMxlt0r4/3AZQrJMrv1+EguD+ZNpec099MT000Gptg/usEj4UbTxAEQABG5u/
         c6ePnem4jSDabkHr1XeXV4MZx0beJUvJ6DFP135tdbEBG0YXIgZ+vdAn3Dr9YjyETd4h
         5oatMl2JQB7Y0FFurRkfnas1dgs9oc9d7YLvJioPvX+YQOkCioZxoZUE6iYSfFluB1Gh
         y6IQ==
X-Gm-Message-State: AOAM5313A1d/Ufh9hYOuNI8aJyMjQE5q+hJFrvKO8wsyCWZ+D/niqWu0
        hD7gjwmh33V/OaVogtm8dXeYh3NOPtoFNqQYmaqpS2z1qxMvXPUNTKwYgeyP7LsjeNbHBy85tH/
        Lg4rKrAPQnhQ+8TKqcTq/LQiM
X-Received: by 2002:a5d:634f:: with SMTP id b15mr29948169wrw.220.1630403431301;
        Tue, 31 Aug 2021 02:50:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT+c1jjGRY2d3dwjvaR2TIlhGUOehXrslKaZ7jFbw+KAWrwQ4Lb33Z8Ifttxyc/c4WrcMAmQ==
X-Received: by 2002:a5d:634f:: with SMTP id b15mr29948160wrw.220.1630403431114;
        Tue, 31 Aug 2021 02:50:31 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id f23sm2150379wmc.3.2021.08.31.02.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:30 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 2/8] x86/ftrace: Remove fault protection code in prepare_ftrace_return
Date:   Tue, 31 Aug 2021 11:50:11 +0200
Message-Id: <20210831095017.412311-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Removing the fault protection code when writing return_hooker
to stack. As Steven noted:

> That protection was there from the beginning due to being "paranoid",
> considering ftrace was bricking network cards. But that protection
> would not have even protected against that.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace.c | 38 +++-----------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1b3ce3b4a2a2..c555624da989 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -625,12 +625,10 @@ int ftrace_disable_ftrace_graph_caller(void)
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
  */
-void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	unsigned long old;
-	int faulted;
 
 	/*
 	 * When resuming from suspend-to-ram, this function can be indirectly
@@ -650,37 +648,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-	/*
-	 * Protect against fault, even if it shouldn't
-	 * happen. This tool is too much intrusive to
-	 * ignore such a protection.
-	 */
-	asm volatile(
-		"1: " _ASM_MOV " (%[parent]), %[old]\n"
-		"2: " _ASM_MOV " %[return_hooker], (%[parent])\n"
-		"   movl $0, %[faulted]\n"
-		"3:\n"
-
-		".section .fixup, \"ax\"\n"
-		"4: movl $1, %[faulted]\n"
-		"   jmp 3b\n"
-		".previous\n"
-
-		_ASM_EXTABLE(1b, 4b)
-		_ASM_EXTABLE(2b, 4b)
-
-		: [old] "=&r" (old), [faulted] "=r" (faulted)
-		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
-		: "memory"
-	);
-
-	if (unlikely(faulted)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		return;
-	}
-
-	if (function_graph_enter(old, self_addr, frame_pointer, parent))
-		*parent = old;
+	if (!function_graph_enter(*parent, ip, frame_pointer, parent))
+		*parent = return_hooker;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.31.1

