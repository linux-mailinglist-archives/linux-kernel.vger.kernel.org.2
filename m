Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF81A3EE941
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhHQJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:15:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47024 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhHQJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:15:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD5891FF24;
        Tue, 17 Aug 2021 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629191666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVsRjsoXmspxYY65hJbg/rp8bqOQPmWQWVfeYk2Ftz0=;
        b=zBY5e70mWEG1RAIzrt+E+IHrCcnMntIn70QJVbpjmYTG3GuTqSMivNtxGpVLvQ3Pb91OSZ
        HMLI5QhH3swldYaC379BW8rYSGvIjNC07/zFijbXEBg+30hAgKRvBE6VHgs8ZHXAAQAfT4
        8ZhyfiyBqDXnea6X/AUXCmFyjtOrN3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629191666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVsRjsoXmspxYY65hJbg/rp8bqOQPmWQWVfeYk2Ftz0=;
        b=djIu/4rWI9m9AVE9IV4PBmw0LADwpnDTnhA821+KQiMcrmkrigEW7J5a18E9k5VPTtiO8V
        f3ua1ZUjBosQEVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E57AB13DF8;
        Tue, 17 Aug 2021 09:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j0P9NPF9G2EFTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 09:14:25 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     Sven Eckelmann <sven@narfation.org>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        brouer@redhat.com, cl@linux.com, efault@gmx.de,
        iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>
References: <2666777.vCjUEy5FO1@sven-desktop>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8d64511e-0717-46a3-bbd2-9a4fead79df9@suse.cz>
Date:   Tue, 17 Aug 2021 11:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2666777.vCjUEy5FO1@sven-desktop>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 2:27 PM, Sven Eckelmann wrote:
>> mm, slub: convert kmem_cpu_slab protection to local_lock
>>
>> Embed local_lock into struct kmem_cpu_slab and use the irq-safe versions
>> of local_lock instead of plain local_irq_save/restore.  On !PREEMPT_RT
>> that's equivalent, with better lockdep visibility.  On PREEMPT_RT that
>> means better preemption.
> [...]
> 
> Looks like this change breaks booting when 64BIT+LOCK_STAT is enabled on 
> x86_64:
> 
>     general protection fault, maybe for address 0xffff888007fcf1c8: 0000 [#1] NOPTI
>     CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.0-rc5+ #7

faddr2line points to slab_alloc_node(), namely this:

                if (unlikely(!this_cpu_cmpxchg_double(
                                s->cpu_slab->freelist, s->cpu_slab->tid,
                                object, tid,
                                next_object, next_tid(tid)))) {

pahole looks like this:

struct kmem_cache_cpu {
        local_lock_t               lock;                 /*     0    56 */
        void * *                   freelist;             /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        long unsigned int          tid;                  /*    64     8 */
        struct page *              page;                 /*    72     8 */
        struct page *              partial;              /*    80     8 */

        /* size: 88, cachelines: 2, members: 5 */
        /* last cacheline: 24 bytes */
};

I had a hunch and added a padding between lock and freelist,
which made the problem indeed go away. Now I don't know if LOCK_STAT
has some bug that makes it write past the local_lock (guess not) or if
it's some result of the false sharing, which I would have expected to be
only a perf issue, not a correctness issue.
Anyway it's a good idea to have the data in the same cache line so I guess
I'll enforce a cacheline boundary between lock and the data?

>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>     RIP: 0010:kmem_cache_alloc+0x81/0x180
>     Code: 79 48 00 4c 8b 41 38 0f 84 89 00 00 00 4d 85 c0 0f 84 80 00 00 00 41 8b 44 24 28 49 8b 3c 24 48 8d 4a 01 49 8b 1c 00 4c 89 c0 <48> 0f c7 4f 38 0f 943
>     RSP: 0000:ffffffff81803c10 EFLAGS: 00000286
>     RAX: ffff88800244e7c0 RBX: ffff88800244e800 RCX: 0000000000000024
>     RDX: 0000000000000023 RSI: 0000000000000100 RDI: ffff888007fcf190
>     RBP: ffffffff81803c38 R08: ffff88800244e7c0 R09: 0000000000000dc0
>     R10: 0000000000004000 R11: 0000000000000000 R12: ffff8880024413c0
>     R13: ffffffff810d18f4 R14: 0000000000000dc0 R15: 0000000000000100
>     FS:  0000000000000000(0000) GS:ffffffff81840000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff888002001000 CR3: 0000000001824000 CR4: 00000000000006b0
>     Call Trace:
>      __get_vm_area_node.constprop.0.isra.0+0x74/0x150
>      __vmalloc_node_range+0x5a/0x2b0
>      ? kernel_clone+0x88/0x390
>      ? copy_process+0x1ac/0x17e0
>      copy_process+0x768/0x17e0
>      ? kernel_clone+0x88/0x390
>      kernel_clone+0x88/0x390
>      ? _vm_unmap_aliases.part.0+0xe9/0x110
>      ? change_page_attr_set_clr+0x10d/0x180
>      kernel_thread+0x43/0x50
>      ? rest_init+0x100/0x100
>      rest_init+0x1e/0x100
>      arch_call_rest_init+0x9/0xc
>      start_kernel+0x481/0x493
>      x86_64_start_reservations+0x24/0x26
>      x86_64_start_kernel+0x80/0x84
>      secondary_startup_64_no_verify+0xc2/0xcb
>     random: get_random_bytes called from oops_exit+0x34/0x60 with crng_init=0
>     ---[ end trace 2cac18ac38f640c1 ]---
>     RIP: 0010:kmem_cache_alloc+0x81/0x180
>     Code: 79 48 00 4c 8b 41 38 0f 84 89 00 00 00 4d 85 c0 0f 84 80 00 00 00 41 8b 44 24 28 49 8b 3c 24 48 8d 4a 01 49 8b 1c 00 4c 89 c0 <48> 0f c7 4f 38 0f 943
>     RSP: 0000:ffffffff81803c10 EFLAGS: 00000286
>     RAX: ffff88800244e7c0 RBX: ffff88800244e800 RCX: 0000000000000024
>     RDX: 0000000000000023 RSI: 0000000000000100 RDI: ffff888007fcf190
>     RBP: ffffffff81803c38 R08: ffff88800244e7c0 R09: 0000000000000dc0
>     R10: 0000000000004000 R11: 0000000000000000 R12: ffff8880024413c0
>     R13: ffffffff810d18f4 R14: 0000000000000dc0 R15: 0000000000000100
>     FS:  0000000000000000(0000) GS:ffffffff81840000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff888002001000 CR3: 0000000001824000 CR4: 00000000000006b0
>     Kernel panic - not syncing: Attempted to kill the idle task!
>     ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> 
> This was tested in qemu-system-x86_64 (from Debian Bullseye) with
>     
>     cat > .config << "EOF"
>     # CONFIG_LOCALVERSION_AUTO is not set
>     # CONFIG_SWAP is not set
>     # CONFIG_CROSS_MEMORY_ATTACH is not set
>     # CONFIG_UTS_NS is not set
>     # CONFIG_TIME_NS is not set
>     # CONFIG_PID_NS is not set
>     # CONFIG_COMPAT_BRK is not set
>     # CONFIG_SLAB_MERGE_DEFAULT is not set
>     # CONFIG_RETPOLINE is not set
>     # CONFIG_X86_EXTENDED_PLATFORM is not set
>     # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
>     # CONFIG_X86_MCE is not set
>     # CONFIG_X86_IOPL_IOPERM is not set
>     # CONFIG_MICROCODE is not set
>     # CONFIG_MTRR_SANITIZER is not set
>     # CONFIG_RELOCATABLE is not set
>     # CONFIG_SUSPEND is not set
>     # CONFIG_ACPI is not set
>     # CONFIG_DMIID is not set
>     # CONFIG_VIRTUALIZATION is not set
>     # CONFIG_SECCOMP is not set
>     # CONFIG_STACKPROTECTOR is not set
>     # CONFIG_BLK_DEV_BSG is not set
>     # CONFIG_MQ_IOSCHED_DEADLINE is not set
>     # CONFIG_MQ_IOSCHED_KYBER is not set
>     # CONFIG_BINFMT_ELF is not set
>     # CONFIG_BINFMT_SCRIPT is not set
>     # CONFIG_COMPACTION is not set
>     # CONFIG_STANDALONE is not set
>     # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>     # CONFIG_BLK_DEV is not set
>     # CONFIG_INPUT_KEYBOARD is not set
>     # CONFIG_INPUT_MOUSE is not set
>     # CONFIG_SERIO is not set
>     # CONFIG_LEGACY_PTYS is not set
>     # CONFIG_LDISC_AUTOLOAD is not set
>     CONFIG_SERIAL_8250=y
>     CONFIG_SERIAL_8250_CONSOLE=y
>     # CONFIG_HW_RANDOM is not set
>     # CONFIG_DEVMEM is not set
>     # CONFIG_HWMON is not set
>     # CONFIG_HID is not set
>     # CONFIG_USB_SUPPORT is not set
>     # CONFIG_VIRTIO_MENU is not set
>     # CONFIG_VHOST_MENU is not set
>     # CONFIG_X86_PLATFORM_DEVICES is not set
>     # CONFIG_IOMMU_SUPPORT is not set
>     # CONFIG_MANDATORY_FILE_LOCKING is not set
>     # CONFIG_DNOTIFY is not set
>     # CONFIG_INOTIFY_USER is not set
>     # CONFIG_MISC_FILESYSTEMS is not set
>     # CONFIG_SYMBOLIC_ERRNAME is not set
>     CONFIG_FRAME_WARN=1024
>     # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
>     CONFIG_DEBUG_KERNEL=y
>     CONFIG_LOCK_STAT=y
>     # CONFIG_FTRACE is not set
>     # CONFIG_X86_VERBOSE_BOOTUP is not set
>     CONFIG_UNWINDER_FRAME_POINTER=y
>     # CONFIG_RUNTIME_TESTING_MENU is not set
>     CONFIG_64BIT=y
>     EOF
>     
>     make ARCH=x86_64 olddefconfig
>     make ARCH=x86_64 all
>     
>     qemu-system-x86_64 -nographic -kernel arch/x86/boot/bzImage -append console=ttyS0
> 
> Here is the bisect log:
> 
>     # bad: [4b358aabb93a2c654cd1dcab1a25a589f6e2b153] Add linux-next specific files for 20210813
>     # good: [36a21d51725af2ce0700c6ebcb6b9594aac658a6] Linux 5.14-rc5
>     git bisect start 'HEAD' 'v5.14-rc5'
>     # good: [204808b2ca750e27cbad3455f7cb4368c4f5b260] Merge remote-tracking branch 'crypto/master'
>     git bisect good 204808b2ca750e27cbad3455f7cb4368c4f5b260
>     # good: [2201162fca73b487152bcff2ebb0f85c1dde8479] Merge remote-tracking branch 'tip/auto-latest'
>     git bisect good 2201162fca73b487152bcff2ebb0f85c1dde8479
>     # good: [41f97b6df1c8fd9fa828967a687693454c4ce888] Merge remote-tracking branch 'staging/staging-next'
>     git bisect good 41f97b6df1c8fd9fa828967a687693454c4ce888
>     # good: [797896d32d52af43fc9b0099a198ef29c2ca0138] Merge remote-tracking branch 'userns/for-next'
>     git bisect good 797896d32d52af43fc9b0099a198ef29c2ca0138
>     # bad: [5c7e12cc3d39b5cfc0d1a470139e4e89f3b147ed] arch: Kconfig: fix spelling mistake "seperate" -> "separate"
>     git bisect bad 5c7e12cc3d39b5cfc0d1a470139e4e89f3b147ed
>     # bad: [3535cf93a31ecd8595744881dbbda666cf61be48] add-mmap_assert_locked-annotations-to-find_vma-fix
>     git bisect bad 3535cf93a31ecd8595744881dbbda666cf61be48
>     # bad: [ac90b3dacf327cecda9f3dabc0051c7332770224] mm/debug_vm_pgtable: use struct pgtable_debug_args in PGD and P4D modifying tests
>     git bisect bad ac90b3dacf327cecda9f3dabc0051c7332770224
>     # good: [3a7ac8f97abde2d6ec973a00a449c45b9642a15a] mm, slub: do initial checks in ___slab_alloc() with irqs enabled
>     git bisect good 3a7ac8f97abde2d6ec973a00a449c45b9642a15a
>     # good: [1c84f3c916405dc3d62cfca55fb2a84de9d7f31e] mm, slub: fix memory and cpu hotplug related lock ordering issues
>     git bisect good 1c84f3c916405dc3d62cfca55fb2a84de9d7f31e
>     # bad: [6ac9c394652dbba1181268cb09513edbd733685c] mm/debug_vm_pgtable: introduce struct pgtable_debug_args
>     git bisect bad 6ac9c394652dbba1181268cb09513edbd733685c
>     # good: [35a6f4bcf4ad9c8c0208ea48044539a952859b3a] mm, slub: make slab_lock() disable irqs with PREEMPT_RT
>     git bisect good 35a6f4bcf4ad9c8c0208ea48044539a952859b3a
>     # good: [03e736e3ca2c0a48822609a89ffa0329f4eb5aae] mm, slub: use migrate_disable() on PREEMPT_RT
>     git bisect good 03e736e3ca2c0a48822609a89ffa0329f4eb5aae
>     # bad: [3f57fd12e8b7eb77412623c347566fb83ec5e764] mm, slub: convert kmem_cpu_slab protection to local_lock
>     git bisect bad 3f57fd12e8b7eb77412623c347566fb83ec5e764
>     # first bad commit: [3f57fd12e8b7eb77412623c347566fb83ec5e764] mm, slub: convert kmem_cpu_slab protection to local_lock
> 
> I haven't checked what part of the change is actually causing the problem
> 
> Kind regards,
> 	Sven
> 

