Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842153D87A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhG1GFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234041AbhG1GFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:05:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DAF60F9E;
        Wed, 28 Jul 2021 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627452322;
        bh=5Ry1wv0hqUqZU/gtw8GhD3jHbSEyngkpHnrEtNAw+0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IX6zJFIA+uyJAL+yFFCNl2B6ANpHXJqqDNO7X6OBV1cJnu+qWZrX0amhaGh/N5Hxr
         kCyL8laNHHUqhK+8116DTOUJsB9s+yH2R3tCXSx09ZyUcBwtDnXwdXyLah5JDfCwah
         6431AjZNxOxQUM5/UUlQGjwrMxNduO3ueXSYO3wsxGMt7QkB8EgsOFCC6Aku1j/7zc
         AhtQPZnLSwwEadPJ4XA8nKzSmAFHFSOn0rLProS4iTP6CQ1KWq2Ru68ScGmsPKhYqk
         jRw13TYtcm+XWTmfjqUJmGl2xsQZiXPndxp5+kpZJdJGNFo4CFp19cIj46HWrcrtms
         wbRFDFIH73yKg==
Date:   Wed, 28 Jul 2021 09:05:16 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YQDznBi5NuTIKd+x@kernel.org>
References: <20210727111446.119561-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727111446.119561-1-mlombard@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 27, 2021 at 01:14:46PM +0200, Maurizio Lombardi wrote:
> Starting with commit a799c2bd29d19c565f37fa038b31a0a1d44d0e4d
> memory reservations have been moved earlier during the boot process,
> before the execution of the Kernel Address Space Layout Randomization code.
> 
> setup_arch() calls the iscsi_ibft's find_ibft_region() function
> to find and reserve the memory dedicated to the iBFT; this function
> also saves a (virt) pointer to the iBFT table for later use.

              ^ virtual
 
> The problem is that if KALSR is active, the physical memory gets
> remapped somewhere else in the virtual address space and the pointer is
> no longer valid, this will cause a kernel panic when the iscsi driver tries
> to dereference it.

Please drop "this patch" and use imperative language, e.g. "Fix this bug
by..."
 
> This patch fixes the bug by saving the address of the physical location
> of the ibft; later the driver will use isa_bus_to_virt() to get
> the correct virtual address.
> 
> It will also simplify the code by renaming find_ibft_region()
> to reserve_ibft_region() and removing all the wrappers.
> 
> [   37.764225] iBFT detected.

It is better to put the crash report close to the problem description as it
actually shows how the issue is manifested.

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
> v2: fix a comment in linux/iscsi_ibft.h
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  arch/x86/kernel/setup.c            | 10 -------
>  drivers/firmware/iscsi_ibft.c      | 10 +++++--
>  drivers/firmware/iscsi_ibft_find.c | 48 +++++++++++-------------------
>  include/linux/iscsi_ibft.h         | 18 +++++------
>  4 files changed, 32 insertions(+), 54 deletions(-)

-- 
Sincerely yours,
Mike.
