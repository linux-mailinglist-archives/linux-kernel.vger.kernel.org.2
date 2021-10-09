Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E911427B6D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhJIPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhJIPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:43:38 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9420C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 08:41:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c29so10761381pfp.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=0gQT1wDNziElgFccRviJGzaeuhF8bzANmDqRrn7eERw=;
        b=6eF0EPdFNDsqwF05KLJBzQZIXqTbjSrF/+ogFX2DV19hbeyYOOb8Ar8FGLdrtptK5T
         giTmLcHnCQJcVLYwWn3tv6SjAIvmIG1NJnhPY+lbkEs3BXzJbNDmPYFdEm8pASl6LcY3
         B9VVtF+Pf0mEDmGa5S3qkQClOcnlE8m6xvJPqvwkP91TXQljbNhZ6S4bctF28NfPkJiO
         N0/jpNId9M3H/wWx2l8khCtNC3o1pDzuAIllN2sIgPl6KDpdB3eDN2ZzoFt+/6MgU4Ko
         veIgQ8gvhZfxIkGRagM4/tpFeEQlX2xw0zLSyVJ1IbPnnWfmHd+7r40cqexSWlt7heEr
         LjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=0gQT1wDNziElgFccRviJGzaeuhF8bzANmDqRrn7eERw=;
        b=W4atnFfJ91dhKFzdAFRuLoouiR/Z1O2LppGHw0K7iHXSTrH73xkB9azpbV4bu38MUX
         kWagkpNbfyymJ4DVtBEt6e1ppiouwQbcVYQIaZgYsgVhjF1fRTXOjP7Sxmi2HsXDtk3j
         9DV5lFYjxJmepEOt7sDo7tQ/BTsyfKyDFo1YNhaY0/lkq14ZEmd7Yzj93Oa9so2YN5H8
         j9Ws6AEqxINXGom2ugdNXkirgdBAO0WTqdFMEM6Ohv2h5WcyZUJVu72BOOZwES06oETk
         Js8nls3Ybsa1Y84vYHbBDHoiirJDvxXd9TMlPYX9F18eiCMKn6oSvS6/raTzI0IL48BM
         uBvQ==
X-Gm-Message-State: AOAM533XWZuJSt9ko23lVrN6H4hrT8HMDp7BDE9RDK2+yNrHkdG3znIq
        oVmJ4Gi3ipcf6oZqi0bXVqRwvCpZFSPAxg==
X-Google-Smtp-Source: ABdhPJwotUF7gJqBKy6Z/80gjOF943OgJqU4wLfmFLwu6aHzRApgRBXwzM6qE+CBXW5RTEgn0Kmgsg==
X-Received: by 2002:a65:6158:: with SMTP id o24mr10132170pgv.141.1633794097133;
        Sat, 09 Oct 2021 08:41:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e9sm2611981pjl.41.2021.10.09.08.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:41:36 -0700 (PDT)
Date:   Sat, 09 Oct 2021 08:41:36 -0700 (PDT)
X-Google-Original-Date: Sat, 09 Oct 2021 08:41:26 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Fixes for 5.15-rc5
In-Reply-To: <mhng-26107d68-d2af-46eb-a8a4-43c1496a9ef4@palmerdabbelt-glaptop>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8bd1a7b1-4ed8-4da1-b2eb-96b189dbadea@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Oct 2021 21:38:14 PDT (-0700), Palmer Dabbelt wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
>
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.15-rc5
>
> for you to fetch changes up to 3ef6ca4f354c53abf263cbeb51e7272523c294d8:
>
>   checksyscalls: Unconditionally ignore fstat{,at}64 (2021-10-07 17:16:28 -0700)
>
> ----------------------------------------------------------------
> RISC-V Fixes for 5.15-rc5
>
> * A pair of fixes (along with the necessary cleanup) to our VDSO, to
>   avoid

Sorry, that should be something more like

   * A pair of fixes (along with the necessory cleanup) to our VDSO, to
     avoid a locking during OOM and to prevent the text from overflowing 
     into the data page.

> * A fix to checksyscalls to teach it about our rv32 UABI.
> * A fix to add clone3() to the rv32 UABI, which was pointed out by
>   checksyscalls.
> * A fix to properly flush the icache on the local CPU in addition to the
>   remote CPUs.
>
> ----------------------------------------------------------------
> Alexandre Ghiti (1):
>       riscv: Flush current cpu icache before other cpus
>
> Palmer Dabbelt (4):
>       Merge remote-tracking branch 'palmer/riscv-vdso-cleanup' into fixes
>       RISC-V: Include clone3() on rv32
>       Merge remote-tracking branch 'palmer/riscv-clone3' into fixes
>       checksyscalls: Unconditionally ignore fstat{,at}64
>
> Tong Tiangen (3):
>       riscv/vdso: Refactor asm/vdso.h
>       riscv/vdso: Move vdso data page up front
>       riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for write killable
>
>  arch/riscv/include/asm/syscall.h     |  1 +
>  arch/riscv/include/asm/vdso.h        | 18 ++++++++----
>  arch/riscv/include/uapi/asm/unistd.h |  3 +-
>  arch/riscv/kernel/syscall_table.c    |  1 -
>  arch/riscv/kernel/vdso.c             | 53 ++++++++++++++++++++++--------------
>  arch/riscv/kernel/vdso/vdso.lds.S    |  3 +-
>  arch/riscv/mm/cacheflush.c           |  2 ++
>  scripts/checksyscalls.sh             |  6 ++--
>  8 files changed, 56 insertions(+), 31 deletions(-)
