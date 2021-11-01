Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE463441DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhKAQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhKAQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:14:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86CC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:12:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id f5so17565152pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lGSWghScOuxTWgzWd2REsYsZNCb3Vm8pXEbjEINr9W8=;
        b=IQVY0j6f9vJNgbw3p8f8G0lWeKKzWCk8oI61DLj1HbBZSqEos0ILMzwQjItZlTTtYD
         n0Ur8yBmP6mV4CVJQkUCMecd92ioBJN3Lpc5gviDsUvZy58mJk/RoPEm+CdW3p5ad22e
         NqBBqSMvCWjrj9iJqgyMoJcfPRw8KVzDppnyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lGSWghScOuxTWgzWd2REsYsZNCb3Vm8pXEbjEINr9W8=;
        b=uSFwJW7LI6P4n3Jo9sFMYs5CmptzmowXPOlQojRncCbu/D40mQ3WDovKHEZNuNQxf5
         C2+BTrDmBxSDuTmHHBsArMWcyRipS7THinxuBEcXm62mkR/x9XbOJOWvCtaTBS4dTizw
         BM2IxnHPmNeg1mFbybPJDiGvHViOvlW2xAn7/4poTv5doNuv+Zvg76zoX1qoKLEwYJZ+
         /XZutpBTNE/YkaKmVsn7FrS1nnXB/FClBluJ6uIXQeCT2S4Cc7VZcTsUQbuBuMyyWqWF
         04E3ynBcTSUl0IvvRDMQ9XQh0EAq9c5NzhqlDnNrT48kLuRYcxZ4baUglrki/SX0pH2m
         G/Wg==
X-Gm-Message-State: AOAM533oCRuQ5hK47KQPogHOhickT05490+kH56KYVCpyPK/NU1knabf
        eITi7CFFovJrQR64pELxf5jAmA==
X-Google-Smtp-Source: ABdhPJxXtXZiFwFH24Ip5tCXCEnMIYIzgj2RYveHZ24ZYnjsIX1lQWvA/Xg5Jorh9z044EerEIW7rA==
X-Received: by 2002:a63:bf4a:: with SMTP id i10mr23010601pgo.196.1635783122176;
        Mon, 01 Nov 2021 09:12:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa5sm4475196pjb.53.2021.11.01.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:12:01 -0700 (PDT)
Date:   Mon, 1 Nov 2021 09:12:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [GIT PULL] cpu-to-thread_info update for v5.16-rc1
Message-ID: <202111010908.CA1B15CFDA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this cpu-to-thread_info update for v5.16-rc1. Since I've
tended to carry other cross-architecture changes in the past, and mpe
wanted a stable topic branch for powerpc for this, I carried Ard's PR.
Since it was a stable topic branch and I wanted to capture Ard's summary,
it also includes an explicit Merge commit; please let me know if that
shouldn't be done in the future. This has been in -next for most of the
last cycle, and has been Acked by all the arch maintainers.

Thanks!

-Kees

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cpu-to-thread_info-v5.16-rc1

for you to fetch changes up to d9f2a53f64a6fcae994457e64a7124d2a3efd323:

  Merge tag 'pr-move-task-cpu-to-ti' of git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git (2021-09-30 10:36:44 -0700)

----------------------------------------------------------------
cpu-to-thread_info update for v5.16-rc1

Cross-architecture update to move task_struct::cpu back into thread_info
on arm64, x86, s390, powerpc, and riscv. All Acked by arch maintainers.

Quoting Ard Biesheuvel:

"Move task_struct::cpu back into thread_info

 Keeping CPU in task_struct is problematic for architectures that define
 raw_smp_processor_id() in terms of this field, as it requires
 linux/sched.h to be included, which causes a lot of pain in terms of
 circular dependencies (aka 'header soup')

 This series moves it back into thread_info (where it came from) for all
 architectures that enable THREAD_INFO_IN_TASK, addressing the header
 soup issue as well as some pointless differences in the implementations
 of task_cpu() and set_task_cpu()."

----------------------------------------------------------------
Ard Biesheuvel (7):
      arm64: add CPU field to struct thread_info
      x86: add CPU field to struct thread_info
      s390: add CPU field to struct thread_info
      powerpc: add CPU field to struct thread_info
      sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
      powerpc: smp: remove hack to obtain offset of task_struct::cpu
      riscv: rely on core code to keep thread_info::cpu updated

Kees Cook (1):
      Merge tag 'pr-move-task-cpu-to-ti' of git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

 arch/arm64/include/asm/thread_info.h   |  1 +
 arch/arm64/kernel/asm-offsets.c        |  2 +-
 arch/arm64/kernel/head.S               |  2 +-
 arch/powerpc/Makefile                  | 11 -----------
 arch/powerpc/include/asm/smp.h         | 17 +----------------
 arch/powerpc/include/asm/thread_info.h |  3 +++
 arch/powerpc/kernel/asm-offsets.c      |  4 +---
 arch/powerpc/kernel/smp.c              |  2 +-
 arch/riscv/kernel/asm-offsets.c        |  1 -
 arch/riscv/kernel/entry.S              |  5 -----
 arch/riscv/kernel/head.S               |  1 -
 arch/s390/include/asm/thread_info.h    |  1 +
 arch/x86/include/asm/thread_info.h     |  3 +++
 include/linux/sched.h                  | 13 +------------
 kernel/sched/sched.h                   |  4 ----
 15 files changed, 14 insertions(+), 56 deletions(-)

-- 
Kees Cook
