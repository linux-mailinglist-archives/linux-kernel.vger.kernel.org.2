Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF042D10C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJNDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhJNDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72038C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so3197220plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHTmw7YlwsetcQqUDZxwbA1uvypN4kSXs4ZQdaQ6gxg=;
        b=bw1EbPtKc/zXoOQrxnbqIPnPlbbskgOzpZ5C1ADkXHm914KTHYkgQW/vKyS0+sGkQt
         lvJ8PsbDKrcEdJtlN28QYxsv45guhNUrVVfT/fxaJM3LpNCrQsF7UXjBA62VYtTbm4JN
         iJRjIfB75tMG+Epvj9Td6UN+NSdPIPhSZQBGUVc/dE8T56+xpv6IFYqm0tFYgvjdQt2q
         9Hu9qb7JHLIQZfiHMiYjxl7WOEdwvWMxpnEmcsLR7AfRvI8P8uDMyD3O/oN0G2U33scY
         7+TI1/FuEpi2EJmBKuSb1eHIzuS+PTVQWNLsY3Ap6lHSpEViXeLSHjXI7YTy/DdsywDA
         5tDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHTmw7YlwsetcQqUDZxwbA1uvypN4kSXs4ZQdaQ6gxg=;
        b=UdWQeuiHHy3zv696dTJW+PISDFcvo9YFlbHFUH7CN8vWRHy2GECAfQ0NOf/UMk90RF
         WA3QHPpuJEG4E3JIm9NuEaVPUZraiBLWnKGrdx6Khk79G8w4vCkpILcjpJ5TSxbmGrgu
         7VgWExbhaglh3vOOqjShebL9yd5tPv4DGmSrSDsL3fmky5+7IZRADWg8moeaa3IDyaKW
         SMHnih6Es3i/Gmp82CzEp6O+6aekDYwabP2bN9sfO01CIys4lR2YigNxCpuoLqnTKdX1
         l/+Y6vrGyaiEmTvfARMAXkOhStUv4hbAF4+o7iS7aWeQpUDANgC2ZXNu20QnoGqMzej5
         CkEA==
X-Gm-Message-State: AOAM532SA1jjjE2cf5CC8uTV9+vSWRBSzxQcr6MoZmHXOZodPanSfIDe
        JD3bBmVV6IW2MOr11ySVWK2cHzRyAms=
X-Google-Smtp-Source: ABdhPJzCQCHVRrHqupLysY6cI7pnOVRuWMhMWXrxrkwuUWjmQNDPiQr7a1TcxId4/F7cjGPlP2ja/A==
X-Received: by 2002:a17:90a:650:: with SMTP id q16mr17958322pje.72.1634182558820;
        Wed, 13 Oct 2021 20:35:58 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d15sm7200221pjw.4.2021.10.13.20.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 20/49] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Thu, 14 Oct 2021 11:33:43 +0800
Message-Id: <20211014033414.16321-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
index 1af28027a138..1ec87d9e685d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -975,8 +978,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

