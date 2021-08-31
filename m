Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644E03FC527
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhHaJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240721AbhHaJvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630403427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=ZE15u+td5r1mW2/OqEBqoALMSlkl9lFGXp+G6nqsqryGxJy9RS1ryjPcNenslW+WLPi1LG
        SmMkKa/uLaELj8ETAdWBl6vGIlDAvWXZiUIiDLouyBstahbcaa2PkBSTzRzvMLnN3YIGd5
        4ufHCfgLN45XtT3h53F0AZl8RpFyXO0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-5W31Md0uM2mrTaAiDEbBBA-1; Tue, 31 Aug 2021 05:50:26 -0400
X-MC-Unique: 5W31Md0uM2mrTaAiDEbBBA-1
Received: by mail-wm1-f72.google.com with SMTP id j145-20020a1c2397000000b002ea321114f7so1245523wmj.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8XYUgR9kHcOYFdSNrWNV6bYolumP9ymhRdSASBvoKM=;
        b=bdyVrgNXWs6MiIaCiVI9cJNzDZy89PbKaZ+rKK0uvTpQO+hIeeK2ZJKU5yES975i8L
         zZZsE6Rlzgx987SNNZTu1ZFV/GcsgCm049yx+jvBvL+3sqCVIR6gkQ2eU3yO7qLmTPl0
         sOuTlUzWPRs+OnUevoG8w3daPG37/dqEH6KxcmeKQDQ/hWWVsQGGeVUYl4LOLCPsiEdT
         Q3Yw2OtXeZW9FOZgdBnMQzN0fMR4EJZgRXkiIFf6NkVUMaSg+BS0waU+Zh4B7/oBiyIT
         qVn3wJGzZ7oBU+tld+13hdfpH9gSw2ObOwQggePOmmBqkegHgc460q3EluYLKTC0oMbR
         MnTw==
X-Gm-Message-State: AOAM530Adf4H9YIGyeumI4AHN60uyqieh7MbRb6LUY0K2f4Qr5/xZ9Ls
        DxYzTKAICC67bv2hkNnwcysc++NTXWTnBjosF6M+4EPuwel9ho4MkPJUq0L/m5w0Q0H7h2gcp1w
        Nz+2kwYByHHUmTA2NP7X8FZ/I
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr3237231wmp.52.1630403424971;
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmw4QOsPrdbgK9ka9SXfqxCs3jTWhJePp5bIWBfxduD2YjHbSYNsMxcmqk6mS4WTpJhWp5+w==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr3237201wmp.52.1630403424699;
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
Received: from krava.redhat.com ([94.113.247.3])
        by smtp.gmail.com with ESMTPSA id y11sm21530442wru.0.2021.08.31.02.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:50:24 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 1/8] x86/ftrace: Remove extra orig rax move
Date:   Tue, 31 Aug 2021 11:50:10 +0200
Message-Id: <20210831095017.412311-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831095017.412311-1-jolsa@kernel.org>
References: <20210831095017.412311-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's identical move 2 lines earlier.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 7c273846c687..a8eb084a7a9a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -251,7 +251,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * If ORIG_RAX is anything but zero, make this a call to that.
 	 * See arch_ftrace_set_direct_caller().
 	 */
-	movq ORIG_RAX(%rsp), %rax
 	testq	%rax, %rax
 SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
 	jnz	1f
-- 
2.31.1

