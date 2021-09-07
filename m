Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0929402B93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbhIGPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbhIGPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:18:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD080C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:17:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q3so6023566plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u64q+16LLofhw5SfECFg76yJoP8u1505r3mOS1kpj6k=;
        b=AUeCKEHoYndbk72c+t1PTWtWB9PyaIMHE6ZgSzrjm2jUC8pbc/RJQfpEGjHtSOEX1x
         SpIVEe4IQavDCmflgNGfT3IoFW06EMnvgaRMb9eO22lCpfou89aWBMrpoCrQUzCBuKKw
         iqNkaduJKXmAXMvSToy1QyW9vYjjX7ahtDpXpbM3OcjXhhb1joM5mMs3GzhE/5pcllq6
         wlm7Mx3HgeR9Fzbf/juLskuAwuaJnYnD1nNmbJjJpGG6Rh5LG2lwGXhugmZizHU0tr0+
         rLBWo3AVSoJ+3gcPLhRDF2mGxMWKQehmvN2i1sKBgi1xOJmzpZvQLFkX9XOgxo18N8QJ
         A1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u64q+16LLofhw5SfECFg76yJoP8u1505r3mOS1kpj6k=;
        b=qekO9QxEOcrBErBy1F8cou3sckmZXFJn49U8Jp4ovHVH7fx8z4rRVzWntaBdOuf1iZ
         NG/sPPSTI0jUwejZ4lx3Oq+6w0HWXBkmjuzqtt77W8+QVmiVcIBezfhjMSOJQMWguk0z
         Rw8b4P12GubfDl/jKbpwnlxCIiAiwGU7Uf3iTbuu/p6tK7z9rksGy4Y0lGTer5yZQn6r
         ydDObS6IFseLycvF1ihVgVw1zLD1ddXVWOMRbPS4gO1zT4EwtgQW02mxegaWnDxoUbm8
         7kCdO5WaNp7NOyR9YfcPXwcmbIibpzzTXwkmHEmumZSPolXl6VLQxMdBfr9A+PPIVmRG
         yc6w==
X-Gm-Message-State: AOAM530Z9coOHqsDQbwRUczXzovwXlIFuiUQmzhuzEl19vKVNlPhPyWS
        YhFt0IGHaErZTkpmF4FhesAOjw==
X-Google-Smtp-Source: ABdhPJw9NAqeS6LaW5EqIxuW/T9hvUAMMYXOBi4+xW0hoDHqSn+6Y/FwNTFcpNEM7mlJFtrMF5o3Bg==
X-Received: by 2002:a17:90b:38cd:: with SMTP id nn13mr5051208pjb.108.1631027857576;
        Tue, 07 Sep 2021 08:17:37 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n21sm11072589pfo.61.2021.09.07.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:17:36 -0700 (PDT)
Date:   Tue, 7 Sep 2021 15:17:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: BUG: spinlock bad magic in synchronize_srcu
Message-ID: <YTeCjNJgWKW+KOyT@google.com>
References: <CACkBjsZ55MKvOBGYJyQxwHBCQOTP=Lz=yfYwJtdOzNiT59E38g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsZ55MKvOBGYJyQxwHBCQOTP=Lz=yfYwJtdOzNiT59E38g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1AauK3Op9WjrF8tZOM0r76XOGMrvgK65e/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1ZMVJ2vNe0EiIEeWNVyrGb7hBdOG5Uj3e/view?usp=sharing
> Similar bug report:
> https://groups.google.com/g/syzkaller-bugs/c/JMQALBa9wVE/m/_Wp1KGYzBwAJ
> 
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> 
> BUG: spinlock bad magic on CPU#3, syz-executor/11945
>  lock: 0xffff88813dd00040, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 3 PID: 11945 Comm: syz-executor Not tainted 5.14.0+ #13
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:105
>  spin_bug kernel/locking/spinlock_debug.c:77 [inline]
>  debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
>  do_raw_spin_lock+0x6c/0xc0 kernel/locking/spinlock_debug.c:114
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
>  _raw_spin_lock_irqsave+0x40/0x50 kernel/locking/spinlock.c:162
>  srcu_might_be_idle kernel/rcu/srcutree.c:767 [inline]
>  synchronize_srcu+0x33/0xf0 kernel/rcu/srcutree.c:1008
>  kvm_mmu_uninit_vm+0x18/0x30 arch/x86/kvm/mmu/mmu.c:5585


Likely a known bug[*], KVM doesn't check the return of init_srcu_struct() in
kvm_page_track_init() and explodes when referencing the bad struct.

https://lkml.kernel.org/r/1630376040-20567-1-git-send-email-tcs_kernel@tencent.com

>  kvm_arch_destroy_vm+0x225/0x2d0 arch/x86/kvm/x86.c:11277
>  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1060 [inline]
>  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4486 [inline]
>  kvm_dev_ioctl+0x7c7/0xc00 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4541
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
