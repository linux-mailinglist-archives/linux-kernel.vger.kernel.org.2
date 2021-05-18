Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2D386FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbhERC0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbhERC0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:26:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBCEC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:24:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v4so6447251qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1pcxeTxktnWb7itUTJJU+RGnfRqqQqV/87xSfJwDA9A=;
        b=hjp/sDNkWcXptm6urQpQyVi1GPTplJ9xxHRLYZAFr6KiCGjWcaXXX2t05PlFRsL/gX
         0s8qm+aH4HSJdXUqvZQHMntNSfor4JwRKOxdkTZwVN/0JgnDBfklUzb2Kh8/Yd5EONdU
         WFYaqtqfi81qloSZDXM9ZEooARXiwu2IqqA8vYJ/QQGisrvcuofmPeiZKydraiEbg48J
         9u5y1ODW1cNpL9+2ktvojxd8QeSa861cnpVMxOGQwK18PQ7xCLHMqi0s+uVDqnv5XW9t
         leP/Jj8GgWQazRnwYsLF/CBQVlAEfBOCFMGd7YSC3zSKmZ3Jjb0qWKxzHeAyaP+FDUZE
         hJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1pcxeTxktnWb7itUTJJU+RGnfRqqQqV/87xSfJwDA9A=;
        b=oN+EpHyB/ZBI7B9iw/CACd0vsJqSZfl7Il43gfd8GN/tPHT7J3ZykPiXDCpBUMev9x
         nG9fj3r2m7fHgxM0Iam7qEZ2J5RU0fk8y7zHoV8KWUM35mUWIyflXwdaw+ziWSF1JhVW
         lEGdNt+X+d4qg3W+vA2HnmMVEbrKD4E/8G1xYO8O9nPuMA6QP1/01TR2fCxr+yeqdPXH
         ib8xhi64tlxnhWWcyfWD/Kjn2rX0cUDkNtnkqXqle7LSv++EObftIWNBCprr402Yr+Ub
         UAF7JzE/jW0chtsXoGIsgmFRTEfIV4rRR5GYX4jHo2FAX/wXKKI6qaobKhH5RWBSCKmb
         L/UA==
X-Gm-Message-State: AOAM532zl6CSBOSygmk1yHUo8KyP2iVdQ+ZNvntcyuN1fUzbbORA+dCK
        FX++WcV08nE0/5aJk+40VM0=
X-Google-Smtp-Source: ABdhPJxj7+KgP7kl1zGDTKIIx3zHRPokparptWq0RxyNrE9/yPxEcayJhoy2wT6I7CBaxOdgsdbTeg==
X-Received: by 2002:a05:622a:44:: with SMTP id y4mr2534112qtw.258.1621304684934;
        Mon, 17 May 2021 19:24:44 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m128sm848236qkf.134.2021.05.17.19.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 19:24:44 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id B81C327C0054;
        Mon, 17 May 2021 22:24:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 17 May 2021 22:24:43 -0400
X-ME-Sender: <xms:aiWjYJwCOkDvJ6i02ZMJj5c1cjdOHwMOB-Kiew5MMA5LJlvc-738Kw>
    <xme:aiWjYJRg0W5nLWhWFM7GkP5TtToKygfrFf0HrdFbL3Idz82jbWe1ZLX2qcdwHvBdu
    GWRYkVYo334Tk7_DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiiedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepudejtdduudevheeltdekhedvkeegtddtjeeffffgjeegfeetkeeuueejhfdu
    gedunecuffhomhgrihhnpehgohhoghhlvghsohhurhgtvgdrtghomhenucfkphepudefud
    druddtjedrudegjedruddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:aiWjYDVvu6MT7Eri_0qqx6mT3QMlPbw0uo_MNjBJVaSqnn9C3SCT7Q>
    <xmx:aiWjYLhjd9w3PcnSONYl6Kbskf05lM3flqvzz_JiK4oc1wH2YrsAVQ>
    <xmx:aiWjYLCJUNw1iNCN5Xs9GWGJn7911pI80o-VR4d3xBSdLlezckzDPg>
    <xmx:ayWjYG_I1WQE-k9Sh61RbIT_1aHL0JdNj3-_9NAU9g9tx_kKwlQOGxVoA4o>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 22:24:42 -0400 (EDT)
Date:   Tue, 18 May 2021 10:24:24 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Silencing false lockdep warning related to seq lock
Message-ID: <YKMlWIPMLFU0vzF6@boqun-archlinux>
References: <CAJWu+orW9PA7m_s5LHhQv-bEO0xFq7n+9-fznd79boKkmQUR6g@mail.gmail.com>
 <YKHvUkxpytzSewEC@boqun-archlinux>
 <YKMd99hE78xdUkQk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKMd99hE78xdUkQk@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 09:52:55PM -0400, Joel Fernandes wrote:
> Hi Boqun,
> Thanks for the reply. See below:
> 
> On Mon, May 17, 2021 at 12:21:38PM +0800, Boqun Feng wrote:
> [...]
> > > After apply Laurent's SPF patchset [1] , we're facing a large number
> > > of (seemingly false positive) lockdep reports which are related to
> > > circular dependencies with seq locks.
> > > 
> > >  lock(A); write_seqcount(B)
> > >   vs.
> > > write_seqcount(B); lock(A)
> > > 
> > 
> > Two questions here:
> > 
> > *	Could you provide the lockdep splats you saw? I wonder whether
> > 	it's similar to the one mentioned in patch #9[1].
> 
> Sure I have appended them to this email. Here is the tree with Laurent's
> patches applied, in case you want to take a look:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4
> 
> Yes, the splat is similar to the one mentioned in that patch #9, however the
> first splat I appended below shows an issue with lockdep false positive -
> there is clearly problem with lockdep where it thinks following sequence is
> bad, when in fact it is not:
> 
>     init process (skipped some functions):
>     exec->
>      flush_old_exec->
>       exit_mmap ->
>         free_pgtables->
>           vm_write_begin(vma) // Y: acquires seq lock in write mode
>              unlink_anon_vmas // Z: acquires anon_vma->rwsem
> 
>     exec->
>     load_elf_binary->
>       -> setup_arg_pages
>         -> expand_downwards (in the if (grow <=) block)
>            mm->page_table_lock // X
>            vm_write_begin(vma) // Y: acquires seq lock
> 
>     exec->
>      do_execve_file->
>        ->get_user_pages
>          -> handle_pte_fault
>           -> anon_vma_prepare
>               -> acquire anon_vma->rwsem  // Z
>               -> acquire mm->page_table_lock // X
> 
>     If vm_write_begin ever had to wait, then it could lockup like this if following happened concurrently:
>     Acquire->TryToAcquire
>     Y->Z
>     X->Y
>     Z->X
> 
>     But Y can never result in a wait since it is a sequence lock. So this is
>     a lockdep false positive.
> 
> > 
> > *	What keeps write_seqcount(vm_seqcount) serialized? If it's only
> > 	one lock that serializes the writers, we probably can make it
> > 	as the nest_lock argument for seqcount_acquire(), and that will
> > 	help prevent the false positives.
> 
> I think the write seqcount is serialized by the mmap_sem in all the code
> paths I audited in Laurent's patchset.
> 
> I am not sure how making it nest_lock argument will help though? The issue is
> that lockdep's understanding of seqcount needs to relate seqcount readers to

The thing lockdep will not report deadlock for the following sequences:

	T1:
	lock(A);
	lock_nest(B, A);
	lock(C);

	T2:
	lock(A);
	lock(C);
	lock_nest(B, A);

because with the nest_lock, lockdep would know A serializes B, so the
following case cannot happen:

	CPU 0			CPU 1
	============		============
	lock_nest(B,A);
				lock(C);
	lock(C);
				lock_nest(B, A);

becaue either CPU 0 or CPU 1 will already hold A, so they are
serialized. So nest_lock can solve part of the problem if all the
writers of vm_seqcount are serialized somehow.

Yes, seqcount writers cannot block each other, however, they are
supposed to be seralized with each other, right? So if we have the
reason to believe the above two CPUs case can happen, though it's not
a deadlock, but it's a data race, right?

I think the proper fix here is to annotate vm_seqcount with the correct
locks serializing the writers.

Regards,
Boqun

> seqcount writers when considering deadlocks. Unless there's a seqcount reader
> involved in the mix, lockdep should just shutup, no? And we don't want it to
> shutup incase there is a real locking issue.
> 
> Appending splats:
> Here is the first splat (which I analuzed above as X, Y, Z):
> 
> [    1.177766] ffff984c36357070 (&anon_vma->rwsem){+.+.}, at: unlink_anon_vmas+0x79/0x1a0
> [    1.179061]
> [    1.179061] but task is already holding lock:
> [    1.180024] ffff984c363520e0 (&vma->vm_sequence){+.+.}, at: exit_mmap+0x96/0x160
> [    1.181207]
> [    1.181207] which lock already depends on the new lock.
> [    1.181207]
> [    1.182543]
> [    1.182543] the existing dependency chain (in reverse order) is:
> [    1.183769]
> [    1.183769] -> #2 (&vma->vm_sequence){+.+.}:
> [    1.184731]        expand_downwards+0x21a/0x390
> [    1.185485]        setup_arg_pages+0x193/0x220
> [    1.186264]        load_elf_binary+0x3d8/0x1570
> [    1.187017]        search_binary_handler.part.0+0x56/0x220
> [    1.187942]        __do_execve_file+0x680/0xb60
> [    1.188695]        do_execve+0x22/0x30
> [    1.189318]        call_usermodehelper_exec_async+0x159/0x1b0
> [    1.190259]        ret_from_fork+0x3a/0x50
> [    1.190933]
> [    1.190933] -> #1 (&(&mm->page_table_lock)->rlock){+.+.}:
> [    1.192067]        _raw_spin_lock+0x27/0x40
> [    1.192763]        __anon_vma_prepare+0x5e/0x180
> [    1.193532]        handle_pte_fault+0x97c/0x9d0
> [    1.194284]        __handle_mm_fault+0x172/0x1f0
> [    1.195049]        __get_user_pages+0x322/0x840
> [    1.195804]        get_user_pages_remote+0x9f/0x290
> [    1.196609]        copy_strings.isra.0+0x1d3/0x360
> [    1.197401]        copy_strings_kernel+0x2f/0x40
> [    1.198160]        __do_execve_file+0x568/0xb60
> [    1.198915]        do_execve+0x22/0x30
> [    1.199547]        call_usermodehelper_exec_async+0x159/0x1b0
> [    1.200492]        ret_from_fork+0x3a/0x50
> [    1.201173]
> [    1.201173] -> #0 (&anon_vma->rwsem){+.+.}:
> [    1.202104]        __lock_acquire+0xe1a/0x1930
> [    1.202837]        lock_acquire+0x9a/0x180
> [    1.203520]        down_write+0x20/0x60
> [    1.204152]        unlink_anon_vmas+0x79/0x1a0
> [    1.204886]        free_pgtables+0x89/0x190
> [    1.205575]        exit_mmap+0x96/0x160
> [    1.206210]        mmput+0x23/0xd0
> [    1.206775]        do_exit+0x33b/0xb10
> [    1.207405]        do_group_exit+0x34/0xb0
> [    1.208081]        __x64_sys_exit_group+0xf/0x10
> [    1.208852]        do_syscall_64+0x47/0xb0
> [    1.209529]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [    1.210443]
> 
> Here are some more splats that could be related:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.4.109-lockdep-13764-g4f6fee83851c #1 Tainted: G     U  W
> ------------------------------------------------------
> chrome/1627 is trying to acquire lock:
> ffff8881468c76d8 (&vma->vm_sequence#3){+.+.}, at: do_user_addr_fault+0x9c4/0xba1
> 
> ffff8881468e2bd0 (&(&mm->page_table_lock)->rlock){+.+.}, at: expand_downwards+0x50f/0xaaa
> 
> 
> 
>        _raw_spin_lock+0x3c/0x70
>        sync_global_pgds_l4+0x127/0x2c3
>        register_die_notifier+0x17/0x2b
>        int3_selftest+0x4f/0xca
>        alternative_instructions+0xf/0x14f
>        check_bugs+0x155/0x1e5
>        start_kernel+0x648/0x706
>        secondary_startup_64+0xa5/0xb0
> 
>        _raw_spin_lock+0x3c/0x70
>        pgd_free+0x71/0x1be
>        __mmdrop+0xbd/0x29d
>        finish_task_switch+0x527/0x6ad
>        __schedule+0x117e/0x397d
>        preempt_schedule_irq+0x94/0xf8
>        retint_kernel+0x1b/0x2b
>        __sanitizer_cov_trace_pc+0x0/0x4e
>        unmap_page_range+0x1427/0x1888
>        unmap_vmas+0x15f/0x2a0
>        exit_mmap+0x21b/0x395
>        __mmput+0xaf/0x2e6
>        flush_old_exec+0x463/0x640
>        load_elf_binary+0x5f7/0x1ef1
>        search_binary_handler+0x17d/0x4fb
>        load_script+0x759/0x840
>        search_binary_handler+0x17d/0x4fb
>        exec_binprm+0x15a/0x549
>        __do_execve_file+0x8da/0xeef
>        __x64_sys_execve+0x99/0xa8
>        do_syscall_64+0x111/0x260
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>        __lock_acquire+0x25a3/0x5cc0
>        lock_acquire+0x28a/0x34c
>        expand_downwards+0x6b0/0xaaa
>        do_user_addr_fault+0x9c4/0xba1
>        page_fault+0x34/0x40
> 
> Chain exists of:
>  Possible unsafe locking scenario:
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&mm->page_table_lock)->rlock);
>                                lock(pgd_lock);
>                                lock(&(&mm->page_table_lock)->rlock);
>   lock(&vma->vm_sequence#3);
> 
> 3 locks held by chrome/1627:
>  #0: ffff8881468e2c78 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault+0x318/0xba1
>  #1: ffff888123d64ba0 (&anon_vma->rwsem){++++}, at: expand_downwards+0x1c1/0xaaa
>  #2: ffff8881468e2bd0 (&(&mm->page_table_lock)->rlock){+.+.}, at: expand_downwards+0x50f/0xaaa
> 
> CPU: 1 PID: 1627 Comm: chrome Tainted: G     U  W         5.4.109-lockdep-13764-g4f6fee83851c #1
