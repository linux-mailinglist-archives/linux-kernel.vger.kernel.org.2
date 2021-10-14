Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76DB42D14D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJNEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhJNEAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:00:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A378C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa4so3799357pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iv2xBEWgdsLbsGrbI1Ynj++RbyVyoOiqc5Pz0aTXiaA=;
        b=WnqduEVBGy81TydMP0Z6/4eCjE1cq/ydzIyEBn9jMSV41ydgOTj6edr+wN5c22DQGM
         I+vbmXyfwsztWVvd/2kbprQkCbuRsg767yG0gIKMMmMdmCKXAnuzd4QFQypgUOv+Jxbz
         lXpKVHLIaiN5X5JCqs8xkkY5lXE9O0XKjLwv5h35fZF/F//SxIsLfRg5CddDML9CHHUH
         t0nmLDxJ44vJuaPBAUDpESqHKoVlLHUn7juwAcdl2Q5m5ewIdimYmN6DCmKdaFGCo+QA
         03m4IHkgn6ekbkVvEgyQSbM0yN6I+RuJNFqNGlZXCwijsCCFqbIG9j2zNLB3Bezt/G6e
         pLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iv2xBEWgdsLbsGrbI1Ynj++RbyVyoOiqc5Pz0aTXiaA=;
        b=SeqNwkukoDICGTooOTTdKIX6Gi6dux3LQCkkPvcV00rbTmQWKX8XHJgEbOe9Q7knFa
         PFSBNdoBR2icshYoyUvLITetnYFgHZ4K9hTLSBKBjx8Mwd/dR6wphFAiJpxCDgQvh+VY
         GGNWNuRkNsfvLqlRl5cNJkXusYdlsAvUnkJFlPQRfvFzvBPK5vlkCqNjV+Xex4tTKp9v
         Qe7EtHJhfCR+0LCV89QRijjXZ4lwNMZc2d4dvXsVSckJKtmChOpAZAzK/ANyXrxD4jbm
         KUnNFPoe5NqFkpZNhbqGhzvzNQmpo4z4uLlHiZXXlHJcp/Iym0dVyg0qD/Ze4afoSkhG
         jdHw==
X-Gm-Message-State: AOAM5335OvwaKLE/+1fgOXXrJayNOBhLKWzEQWo0ENowXw266zo637KM
        aXW/fW9d2JJomqXSJsznFdOlcFaJsNk=
X-Google-Smtp-Source: ABdhPJyvJ5BbUsOfaVih65hisofJARz8d3Vvabvgfc0ZukrcGbm0Cic8ztmE048fQGzz0SaSgRp/ZA==
X-Received: by 2002:a17:90b:1e4f:: with SMTP id pi15mr3681619pjb.231.1634183913427;
        Wed, 13 Oct 2021 20:58:33 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id c64sm937355pga.40.2021.10.13.20.58.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:58:33 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 43/49] x86/doublefault: Use C entry code
Date:   Thu, 14 Oct 2021 11:58:29 +0800
Message-Id: <20211014035836.18401-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 12 ++----------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0a1a55c8207e..57559d810785 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -575,16 +575,8 @@ SYM_CODE_START(\asmsym)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
-
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index c57606948433..931b689f464c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -415,6 +415,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
-- 
2.19.1.6.gb485710b

