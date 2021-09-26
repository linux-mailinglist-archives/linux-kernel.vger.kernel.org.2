Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB264189C0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhIZPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhIZPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0627C061714
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v19so10556564pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/NE5qvIR/iM2cbkxYQqRyI1AJKusxAtRH4lB48AN88E=;
        b=AzvcpspmT8kpREyKb18mysl5tP1xyzDZbXCWFKCIiMoB93rAb86dvhIUFrYtJ0EXWJ
         0yaR05OWvrJPVWoLWIGYimWYa/ao1YhTlVcf7SElkqkywTDLF9mQHBh1LKIiGBKAdQjF
         PtSbVNuna4BPt94kp2wJccpFvj2sqzGdgUr6qHrg/ux2B67TjmoJ26vm4L8/qSxgv/rc
         wdO1qj9lMHVLycLMGUeHswXFR1Bk1qodl+47irCavfZ6dFCzZP2B7zXIhyFfgYaCNpsb
         41OZEi0S4ELdEDKAHQW65kD2C7/K0Hr2cNUDy9ACZed+MfZirEcKuS0VEBMNJTG3bRBO
         nHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/NE5qvIR/iM2cbkxYQqRyI1AJKusxAtRH4lB48AN88E=;
        b=UGNtzF/hbSPy8UV7kJjepl/cjs79JJx4m1v2CwggkuG8GqTQqMhG5cArDIMhYOiFnL
         285MFCMUf1skGET1VoYDqwxHJcFT4SyLnTyLyqWWHEy8duIVqwp5fDzQNh8ZPtTIjL4A
         cpMWH2e7OrqmhEHyyR8DNG7781k713fU75i+baZqaVRSfoND6YLNyLBgNx2O1K7UpE/Q
         xgqKkZnFCf9sWcla2nPRY1q2b/8c5qzRPNWzhgDRitug9roFPA7FI8A6hEUsOk9E++Ne
         aDDfAm/XN5S6KTgFSiDUxu/kLGmQAld/SUIVcnmNdasvTOArSBig8764E0arWKFOTSJ1
         NLVA==
X-Gm-Message-State: AOAM533NWwY7HC4hGjh+FKxh+7UTpp6aQxHqQNf5YHCNHGNqYoLGyHvQ
        pNhO1KPGemJWnuefwYKpbuc740ITA/la9g==
X-Google-Smtp-Source: ABdhPJxyCTN4YFgRiFAeEJEUHspZRa2pdag2ckiBsQ7x4+XsQbRAYOp4EONhhtBELyWB0HRSK16HSA==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr7234172pjt.153.1632669013957;
        Sun, 26 Sep 2021 08:10:13 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id x9sm15046345pfo.172.2021.09.26.08.10.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:13 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 14/41] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Sun, 26 Sep 2021 23:08:11 +0800
Message-Id: <20210926150838.197719-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
functionality.  It will enlarge the size:

size arch/x86/entry/entry_64.o.before:
   text	   data	    bss	    dec	    hex	filename
  17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.before:
.entry.text                      5528      0
.orc_unwind                      6456      0
.orc_unwind_ip                   4304      0

size arch/x86/entry/entry_64.o.after:
   text	   data	    bss	    dec	    hex	filename
  26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.after:
.entry.text                      8200      0
.orc_unwind                     10224      0
.orc_unwind_ip                   6816      0

But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
enlarge the final text size.

The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.

It is prepared for converting the whole error_entry into C code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index dd453a8e7317..757e7155670e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,6 +322,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -967,8 +970,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

