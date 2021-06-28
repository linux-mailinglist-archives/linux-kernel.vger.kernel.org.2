Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506943B59AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhF1HYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1HYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:24:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:22:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so24242995edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fLevKGyKsL/QHSVOWSX2ed+rnP6iWO2F5BhWoqNsJUQ=;
        b=R+imHsL4sTyaWI/a7Oy+8j0lXmFQxTxESsNwX5fluj273zPw7TRxA481CoqsKyYULM
         ZaWX1IgtHXkF04QOu8jz0BOFMmEvzekxfKRvBvdo1UQAJhQ1oDorwgPRpljoeGKU36Jx
         N+vrz+JHR5EbOHErv4GGJnKC3NE/yE9Kb8h4AHLHYTndRw1izcKIr7h3hcE41OqLD+kX
         0ZwnOGm4WUhqQyR90RHMy9c4sYYjRT6UUXYY2fCmvdhScFi+6MjhAJmFJ/IWmIE8TBNB
         8jlNwi8UaPKSzoTpyaOlFSreI1msl0y6Pfss/9UX4cK2IO/LRKvsH+qW+0RkhSO2jMLe
         /+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=fLevKGyKsL/QHSVOWSX2ed+rnP6iWO2F5BhWoqNsJUQ=;
        b=hr1r4nNUffESbKcnQKsAtSbz7r26On3PbPaSX2gfXg5mn+WjyVoIJPUkDTKWs8GmM5
         RerkqgaP38hN2diG/rrAWVeTfVqlKYQFbyh4Twvd7BzGc31OYtaw6sRGRqUD93hIIwhr
         344yxkEh4jw8Mg1ED5yV24W0ctizgyonS9rf/Lr0NupuqW0lOYJE3m5wy9y34ZC793eu
         CH4KlqXCAUOZ/skPvUQ6ZWieq0suKa9cCQAiQmOyIH502eYFEAZa7JeVn3Qlly4XO02G
         dyGgj7982Vg4gGlSPuMJcPJ6887vtwnFWs7HsCS8Q6/JytXXrvxaBMkqKAjwgilmvd83
         5NaA==
X-Gm-Message-State: AOAM533yx1x9Mq66yu3KZFK7RZ41UWNyVBsZbnBHY8RY8tAnW3g0cdO2
        RelgyLn92TnUtV5canIW/kWKgNWZiIk=
X-Google-Smtp-Source: ABdhPJw9e6yWyz2pILeNpoiRvV/2C1gI89zIuLsMCJPfOzvc4xTyP0TyDCiGq1V+30rc1/orgprZrg==
X-Received: by 2002:aa7:c618:: with SMTP id h24mr23583767edq.89.1624864936440;
        Mon, 28 Jun 2021 00:22:16 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id j1sm8995638edl.80.2021.06.28.00.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 00:22:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 09:22:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/asm changes for v5.14
Message-ID: <YNl4piFBCfvmGgEK@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/asm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2021-06-28

   # HEAD: 41f45fb045bcc20e71eb705b361356e715682162 x86/asm: Make <asm/asm.h> valid on cross-builds as well

Changes for this cycle:

 - Micro-optimize and standardize the do_syscall_64() calling convention
 - Make syscall entry flags clearing more conservative
 - Clean up syscall table handling
 - Clean up & standardize assembly macros, in preparation of FRED
 - Misc cleanups and fixes

 Thanks,

	Ingo

------------------>
H. Peter Anvin (1):
      x86/regs: Syscall_get_nr() returns -1 for a non-system call

H. Peter Anvin (Intel) (8):
      x86/asm: Have the __ASM_FORM macros handle commas in arguments
      x86/asm: Add _ASM_BYTES() macro for a .byte ... opcode sequence
      x86/asm: Use _ASM_BYTES() in <asm/nops.h>
      x86/entry: Unify definitions from <asm/calling.h> and <asm/ptrace-abi.h>
      x86/entry: Reverse arguments to do_syscall_64()
      x86/syscall: Unconditionally prototype {ia32,x32}_sys_call_table[]
      x86/syscall: Maximize MSR_SYSCALL_MASK
      x86/entry: Split PUSH_AND_CLEAR_REGS into two submacros

Ingo Molnar (1):
      x86/asm: Make <asm/asm.h> valid on cross-builds as well


 arch/x86/entry/calling.h          |  45 ++-------
 arch/x86/entry/common.c           |   2 +-
 arch/x86/entry/entry_64.S         |   4 +-
 arch/x86/include/asm/asm.h        |  27 +++---
 arch/x86/include/asm/nops.h       |  24 ++---
 arch/x86/include/asm/syscall.h    |  13 ++-
 arch/x86/kernel/cpu/common.c      |  12 ++-
 arch/x86/kernel/head_64.S         |   6 +-
 arch/x86/kernel/ptrace.c          |   2 +-
 arch/x86/kernel/signal.c          |   4 +-
 tools/arch/x86/include/asm/asm.h  | 193 ++++++++++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/nops.h |  24 ++---
 12 files changed, 262 insertions(+), 94 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/asm.h
