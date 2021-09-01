Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCC3FE04B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbhIAQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhIAQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:48:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34A5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:47:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 6so75184oiy.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbfCjSBwignzsfCO1uRjwOAA6KxwOZtphxHrmz+1Gu0=;
        b=R7ufEstAB7Hk31VQUuC8TGoHWJagans6L5oHz6Nfb5EVwqWhqk+b5r5WMMKw3/RcHs
         TrEdqBCEjOzDH6m5auWpy1j/mXEJklid13yfhnguQufb936GLCvIyvbtv4kUhRhOoGO+
         9lPtlPUnz/+mLzwvRdLHSoeekeWQqJlAeQyWqsKeuAyRjn48Gpr0nNDOV26W6UaiM17g
         LY3n+Vy2+4UqCJYCFU2dRwZgEnhSgFAURl0B9ceFcVxLPjfn8k2bDtwoHaFuLVDgB7Yl
         UsuIIiZrk+0TI7d19AgoKioHNqF7d3axrtVjtwEgFSJ4niX0SZ+Ze0zXPkkEyi49jEVt
         qwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qbfCjSBwignzsfCO1uRjwOAA6KxwOZtphxHrmz+1Gu0=;
        b=ZPk4qZC3EhBgRMWX7yyV5SCsLE+HwVp8ineXmGD1i8fWkFu44GXRxJki07JZ4PftIn
         X+0fzQMVodLY1idH4Ueqbj7LNMlmBuhRIhXow+0o1tf26rZEZCS4hmirLBqu07rzZN0M
         8srVmwKNl9vX44YaSnKgRpg+EtIin2ed/OKVBN7GXMJK2RzvDck5YbBh5EffH+a1IG0C
         i05XI4yo2pHc2DPwMwu+NNJTIS2XI6C+pozo8dXXOtv17YocV/nHRVAYYfxSoOdYVpUQ
         MnZ3iiiGGyKD9xE1UvGA7SHdKarvAbCxSo7H04mxn01D93dLsUPFU1pmVJqvwuXtLPfR
         poGg==
X-Gm-Message-State: AOAM530CnhjAbNmMhJrVZFVqzaYwTQMK9brTycuP76M9rF1tu4Pt+9Jr
        XazB60Ix1/yldjU6IkXSIQ4=
X-Google-Smtp-Source: ABdhPJzdlTLWWtmbFGLIUnyGadFumsp85MqI5rNlEwrp2tLKFgqhteHQs+ZTL+PkufASUGVvcfYCUg==
X-Received: by 2002:aca:1717:: with SMTP id j23mr361682oii.43.1630514845197;
        Wed, 01 Sep 2021 09:47:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm84452oix.7.2021.09.01.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:47:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Sep 2021 09:47:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     rppt@kernel.org, bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <20210901164722.GA2100627@roeck-us.net>
References: <20210729135250.32212-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729135250.32212-1-mlombard@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:52:50PM +0200, Maurizio Lombardi wrote:
> Starting with commit a799c2bd29d1
> ("x86/setup: Consolidate early memory reservations")
> memory reservations have been moved earlier during the boot process,
> before the execution of the Kernel Address Space Layout Randomization code.
> 
> setup_arch() calls the iscsi_ibft's find_ibft_region() function
> to find and reserve the memory dedicated to the iBFT and this function
> also saves a virtual pointer to the iBFT table for later use.
> 
> The problem is that if KALSR is active, the physical memory gets
> remapped somewhere else in the virtual address space and the pointer is
> no longer valid, this will cause a kernel panic when the iscsi driver tries
> to dereference it.
> 
> [   37.764225] iBFT detected.
> [   37.778877] BUG: unable to handle page fault for address: ffff888000099fd8
> [   37.816542] #PF: supervisor read access in kernel mode
> [   37.844304] #PF: error_code(0x0000) - not-present page
> [   37.872857] PGD 0 P4D 0
> [   37.886985] Oops: 0000 [#1] SMP PTI
> [   37.904809] CPU: 46 PID: 1073 Comm: modprobe Tainted: G               X --------- ---  5.13.0-0.rc2.19.el9.x86_64 #1
> [   37.956525] Hardware name: HP ProLiant DL580 G7, BIOS P65 10/01/2013
> [   37.987170] RIP: 0010:ibft_init+0x3e/0xd42 [iscsi_ibft]
> [   38.012976] Code: 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 83 3d e1 cc 7e d7 00 74 28 48 c7 c7 21 81 1b c0 e8 b3 10 81 d5 48 8b 05 cc cc 7e d7 <0f> b6 70 08 48 63 50 04 40 80 fe 01 75 5e 31 f6 48 01 c2 eb 6e 83
> [   38.106835] RSP: 0018:ffffb7d288fc3db0 EFLAGS: 00010246
> [   38.131341] RAX: ffff888000099fd0 RBX: 0000000000000000 RCX: 0000000000000000
> [   38.167110] RDX: 0000000000000000 RSI: ffff9ba7efb97c80 RDI: ffff9ba7efb97c80
> [   38.200777] RBP: ffffffffc01c82be R08: 0000000000000000 R09: ffffb7d288fc3bf0
> [   38.237188] R10: ffffb7d288fc3be8 R11: ffffffff96de70a8 R12: ffff9ba4059d6400
> [   38.270940] R13: 000055689f1ac050 R14: 000055689df18962 R15: ffffb7d288fc3e78
> [   38.307167] FS:  00007f9546720b80(0000) GS:ffff9ba7efb80000(0000) knlGS:0000000000000000
> [   38.351204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.381034] CR2: ffff888000099fd8 CR3: 000000044175e004 CR4: 00000000000206e0
> [   38.419938] Call Trace:
> [   38.432679]  ? ibft_create_kobject+0x1d2/0x1d2 [iscsi_ibft]
> [   38.462584]  do_one_initcall+0x44/0x1d0
> [   38.480856]  ? kmem_cache_alloc_trace+0x119/0x220
> [   38.505554]  do_init_module+0x5c/0x270
> [   38.526578]  __do_sys_init_module+0x12e/0x1b0
> [   38.548699]  do_syscall_64+0x40/0x80
> [   38.565679]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fix this bug by saving the address of the physical location
> of the ibft; later the driver will use isa_bus_to_virt() to get
> the correct virtual address.
> Simplify the code by renaming find_ibft_region()
> to reserve_ibft_region() and remove all the wrappers.
> 
> v2: fix a comment in linux/iscsi_ibft.h
> v3: fix the commit message
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

In addition to the x86 build failures, arm64:allmodconfig fails to build as
well.

Building arm64:allmodconfig ... failed
--------------
Error log:
drivers/firmware/iscsi_ibft.c: In function 'ibft_init':
drivers/firmware/iscsi_ibft.c:868:29: error: implicit declaration of function 'isa_bus_to_virt' [-Werror=implicit-function-declaration]
  868 |                 ibft_addr = isa_bus_to_virt(ibft_phys_addr);
      |                             ^~~~~~~~~~~~~~~

ISCSI_IBFT now depends on ISA thanks to this patch.
If that is intentional, it should be declared in Kconfig.

Guenter
