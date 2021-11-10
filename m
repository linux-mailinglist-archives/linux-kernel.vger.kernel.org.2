Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D260C44C06C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhKJMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhKJMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:00 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2216C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so1386699pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=cBpJh0bcbu7MfD9fakpMWYsu15YNry8bnAS96AwdZSSbmNxGmtsuPwLwfgxOBoZrHf
         er5f8BI0KC2n9rT3Z2LPw8dR8TIqgd33gjY5FbN/eVTT9D/u/DG9vXxwwNbCrebAQwGu
         KVVsgwkFLSkI//IQpKXIVLkUL5tjCib5Lt0AaMGTHiiJj2XEP6Wm7a9rQ3v2N6p1VNhG
         OyDQquk3+qVn0O2yvsA3O0xHSbDYE69aQZ95WUY+a1tiMdQBEowsMAX3ObKVYbNSg2pU
         2qOZECU60+cVrJVjHIo6BrVILQfVpay5Ou6SePgPJL7yjqNA3f7JgZb4M+PnkttvHzPy
         0VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=zKcCX7lEeximARaukyTceLz6U/1reV9BcuYOpmGpxBNyGM7OLaukIcAIVARRQqpdSA
         DjrqDEvUEEidWVeDKuNUiE27yLeK/Y2t2JOCSRgwtmLpN7Ign9rgqp4Oyz3HaZzCvJHI
         usvmZcmkflO3uou+z4qL56PIbxaBVk9pRyVB+Uitsovu2WoCgJjTk0exbnUOYRbhNLyq
         vqIhZf1fgTPCr+64f25TNLl1/sO4yQe8kmfCRVgFDfAH+ACqLxVQ2UKe98ervBgvoFUw
         y088Ud6ZpE3AxzjrOVTSxcIrWL7mGJpvZdlKsb21P2zSzHho5/Hfd+95NYNs9F4TEsjY
         KoSg==
X-Gm-Message-State: AOAM532nAeGeRF59yrLXBY1GQ95tP2He5UwuUsqxlmW35CL93DbfBOG2
        Ob7Qs6UaaHU0FOERC+KFkTWV5bDc0kM=
X-Google-Smtp-Source: ABdhPJwbqwHxBht6m4dPu0GPzM+XILis+8ZMV/nOBn88U1k4layJqDu3soFUWwMVghqgb8+QgDoihg==
X-Received: by 2002:a17:902:bc8a:b0:141:eb43:81a1 with SMTP id bb10-20020a170902bc8a00b00141eb4381a1mr15153557plb.52.1636545492397;
        Wed, 10 Nov 2021 03:58:12 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id gc22sm5349464pjb.57.2021.11.10.03.58.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:12 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 07/50] x86/entry: Introduce __entry_text for entry code written in C
Date:   Wed, 10 Nov 2021 19:56:53 +0800
Message-Id: <20211110115736.3776-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in C files.  __entry_text is needed
to set them in .entry.text section.  __entry_text disables instrumentation
like noinstr, but it doesn't disable stack protector since not all
compiler supported by kernel supporting function level granular
attribute to disable stack protector.  It will be disabled by C file
level.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..6779def97591 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
-- 
2.19.1.6.gb485710b

