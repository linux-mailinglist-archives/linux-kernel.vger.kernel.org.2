Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A216F3DA9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhG2RDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2RDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:03:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3BC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:03:18 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 190so6615726qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+9RlETG4GxBzPp9bZfvoU9VutvLI+kwHiPjEprkujJY=;
        b=s1q7mr6OfbRAfPTTeGKwE9qI69Wj0McEEs5h9sFPCUu+qKfzR6nQAf+2RhQrDvBi9a
         wzlGyPGQWU5s4J2kwu8Ft6vRclU4H8YcOEJ5gyIcFzZ6ajEcsilCZI2Hbe7RLKZfWCea
         Zx0Upc1P+nxHU3I/4hUqXryajDAi8YGn3wEqa7PZdAkSK5SygHFGsoZecV70+4PslvDx
         pybHNFC3lj4C+r63rTWDh0JSlUQLoK+TxzU0VuSHQT2OXiPdsQQ4ePr7EAkpxWC6ZxgB
         6EgP2SmKDDnXIb+pHEAPlTX1toQx+br3qujYAYA1DPyxj7i7p7djzwr/fWYkTnE25naR
         iaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+9RlETG4GxBzPp9bZfvoU9VutvLI+kwHiPjEprkujJY=;
        b=G9jhG5yMZy5HVVs13tigvprz6ycy4ZroATPP2pLv10Xe6r052fl4EKnaRUa1AIiIid
         5lk+puqqYE+YD3ubK6mW+tTXGYERXgFOjX0nAmfvsoIXBQ2JGRyvzYM6PBh4ZWkQtkTL
         RWzSk2Z9Q6NzHp/Qn6RJf0hKb8b2JqQJLIUbi9HhNsAZfsL+uSsUh8isiJ66DX5i9/SS
         iHclErEsIiSRW3+2bGvdaYjEvOWfnsKCCdFOT82iuNnMKdjVJDjy0d2QUG4c9FigPew9
         YRftfyb8r9CiBNuai2pzPcneBwuXDWW4l2zJffd2PXjPP/Iy/T/p60VvAXu/3xeEBzeX
         713Q==
X-Gm-Message-State: AOAM531dQ00MeXmvw356/sq1X8PM7bFlWbnxhLG9T5Ij8KUUUmNObm38
        pfx+0oPMB9ttL5uI3cWFxdM=
X-Google-Smtp-Source: ABdhPJxThFgQ9gRULGVVDYuJ2r3rc5qHxpkhorL3Ra1d1DlL0FuzMc7lmcPzzyHRDSiMkk7Zd89Gkg==
X-Received: by 2002:a37:a5c4:: with SMTP id o187mr6243457qke.179.1627578197742;
        Thu, 29 Jul 2021 10:03:17 -0700 (PDT)
Received: from fedora ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id j3sm1956993qka.96.2021.07.29.10.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:03:17 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Thu, 29 Jul 2021 13:03:15 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     rppt@kernel.org, bp@alien8.de, tglx@linutronix.de, x86@kernel.org,
        pjones@redhat.com, konrad@kernel.org, george.kennedy@oracle.com,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] iscsi_ibft: fix crash due to KASLR physical memory
 remapping
Message-ID: <YQLfU4gzvAJYvBmx@fedora>
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

One part that I think you are saying but just want to double-check is
that the isa_bus_to_virt() virtual addresses it returns - those are
different every boot when KASLR is enabled, right?

