Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382AD40BC66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhINX63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 19:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhINX62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 19:58:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:57:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23-20020a17090a591700b001976d2db364so893630pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=bomggq+VAUyQOixNv6iOorIV6zevLQAUWkTpP0/EssI=;
        b=Gj3Fm5kafmrFLIK6rOPUq12kIPgjh0E4qek0od1Rgucf6CWegBCY2MK7LsMtxcDuV5
         NXKxKKWjChym+SGhTet7J1JVsYZrkQ9frG8vv1J4XhTJjKByUeSeWEuU8cfX0QL21+79
         rHmXxFVTdYomBgYEOtUtIogfnAmfRF4wCXAWF4TwB8KtSqhR/yVP/vUXFAOAbU0Qld7F
         mWl33KY8ayVQ3o2Au7ZmOzJbZ8YzRKjKLV7RP5xydMor9bHEgGTnFMDgZ+ZlC5W/42om
         moBZTKXT39+I6ap/8tzE7JfAdgU4alqJ6B3JUR5XIgQBTeYr2HCqEbJLGgEVu1scWkLn
         2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=bomggq+VAUyQOixNv6iOorIV6zevLQAUWkTpP0/EssI=;
        b=6miLmtatQWfAjoYqdtzGTZyED/anuJAjOTpWUCyw2GtfrzfukDBsq6nKq4mXx+7gCO
         c73EoAQ/qG3KDFwhfBENFXq8UEbTiWrcadDYLmDx4u/Jsm+ODjECNzZM/PicurRmqEsw
         6BBvp3V8HdmtZSh+MecNeigYJDOMweQPR1tC1LYmO3ohHbty8HuWLQkRpSb7mLQOZvih
         h5quT2KmaNrfOHO/YeKr2InPbhGSraAqHfXshepd8mjhe5SkRZVvEztN/HS331PEoWCj
         QG02M4/meikgRVDU5ZXEL4yAXEyGb6TetmyAhnpVobk0E4B8SIp7oFpx0a/1NIL4/sxE
         8UGw==
X-Gm-Message-State: AOAM530tXH53qPoEJooyfIupdYK5HdkKoPXKU6azfvVzCWIylfe1hEcL
        UKw/6D04tvrn0p12E9cVnygLPA==
X-Google-Smtp-Source: ABdhPJxpSN7sRxZ2O2qACDi5Vcg/ddva/wol2AwcIHfnssmtpTdUssZuAMMEBdzueEr7z7YYn0r5Mg==
X-Received: by 2002:a17:90b:4ac2:: with SMTP id mh2mr4993147pjb.70.1631663829841;
        Tue, 14 Sep 2021 16:57:09 -0700 (PDT)
Received: from [2620:15c:17:3:22e5:69e1:debc:7973] ([2620:15c:17:3:22e5:69e1:debc:7973])
        by smtp.gmail.com with ESMTPSA id u16sm8724000pfn.68.2021.09.14.16.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:57:08 -0700 (PDT)
Date:   Tue, 14 Sep 2021 16:57:08 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
cc:     Takashi Iwai <tiwai@suse.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [Bluetooth]  99c23da0ee:
 WARNING:at_mm/page_alloc.c:#__alloc_pages
In-Reply-To: <20210907051215.GC7504@xsang-OptiPlex-9020>
Message-ID: <812dab5c-845d-df58-2752-abea7c07890@google.com>
References: <20210907051215.GC7504@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, kernel test robot wrote:

> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 99c23da0eed4fd20cae8243f2b51e10e66aa0951 ("Bluetooth: sco: Fix lock_sock() blockage by memcpy_from_msg()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: trinity
> version: trinity-x86_64-b1a0aef9-1_20210901
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [ 160.917499][ T1854] WARNING: CPU: 0 PID: 1854 at mm/page_alloc.c:5365 __alloc_pages (mm/page_alloc.c:5365 (discriminator 1)) 
> [  160.946051][ T1854] Modules linked in: vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci af_key ieee802154_socket ieee802154 mpls_router ip_tunnel hidp bnep rfcomm bluetooth ecdh_generic ecc rfkill can_bcm can_raw can crypto_user ib_core nfnetlink scsi_transport_iscsi atm sctp ip6_udp_tunnel udp_tunnel libcrc32c bochs_drm sr_mod drm_vram_helper drm_ttm_helper ttm cdrom drm_kms_helper sg intel_rapl_msr ppdev syscopyarea intel_rapl_common sysfillrect crc32c_intel sysimgblt ata_generic rapl fb_sys_fops ata_piix joydev drm libata ipmi_devintf ipmi_msghandler serio_raw i2c_piix4 parport_pc parport ip_tables
> [  161.141077][   T26] audit: type=1326 audit(1630935829.264:14): auid=4294967295 uid=65534 gid=65534 ses=4294967295 subj==unconfined pid=1806 comm="trinity-c3" exe="/bin/trinity" sig=9 arch=c000003e syscall=8 compat=0 ip=0x7f37162c4597 code=0x0
> [  161.307984][ T1854] CPU: 0 PID: 1854 Comm: trinity-c2 Not tainted 5.14.0-rc7-01816-g99c23da0eed4 #1
> [  161.339614][ T1854] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [ 161.394398][ T1854] RIP: 0010:__alloc_pages (mm/page_alloc.c:5365 (discriminator 1)) 

I believe this was subsequently fixed by

commit 0771cbb3b97d3c1d68eecd7f00055f599954c34e
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Sep 3 15:27:31 2021 -0700

    Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg

since we no longer need to do the very large kmalloc().

> [ 161.418858][ T1854] Code: e2 4c 89 f6 e8 aa 15 fc ff 65 ff 0d 63 48 cf 7d e9 2a ff ff ff e8 99 7d fb ff 48 89 c7 e9 9c fe ff ff 81 e5 00 20 00 00 75 96 <0f> 0b eb 92 a9 00 00 08 00 75 67 89 e9 80 e1 7f a9 00 00 04 00 0f
> All code
> ========
>    0:	e2 4c                	loop   0x4e
>    2:	89 f6                	mov    %esi,%esi
>    4:	e8 aa 15 fc ff       	callq  0xfffffffffffc15b3
>    9:	65 ff 0d 63 48 cf 7d 	decl   %gs:0x7dcf4863(%rip)        # 0x7dcf4873
>   10:	e9 2a ff ff ff       	jmpq   0xffffffffffffff3f
>   15:	e8 99 7d fb ff       	callq  0xfffffffffffb7db3
>   1a:	48 89 c7             	mov    %rax,%rdi
>   1d:	e9 9c fe ff ff       	jmpq   0xfffffffffffffebe
>   22:	81 e5 00 20 00 00    	and    $0x2000,%ebp
>   28:	75 96                	jne    0xffffffffffffffc0
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	eb 92                	jmp    0xffffffffffffffc0
>   2e:	a9 00 00 08 00       	test   $0x80000,%eax
>   33:	75 67                	jne    0x9c
>   35:	89 e9                	mov    %ebp,%ecx
>   37:	80 e1 7f             	and    $0x7f,%cl
>   3a:	a9 00 00 04 00       	test   $0x40000,%eax
>   3f:	0f                   	.byte 0xf
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2    
>    2:	eb 92                	jmp    0xffffffffffffff96
>    4:	a9 00 00 08 00       	test   $0x80000,%eax
>    9:	75 67                	jne    0x72
>    b:	89 e9                	mov    %ebp,%ecx
>    d:	80 e1 7f             	and    $0x7f,%cl
>   10:	a9 00 00 04 00       	test   $0x40000,%eax
>   15:	0f                   	.byte 0xf
> [  161.512454][ T1854] RSP: 0018:ffffbbaf83d37c08 EFLAGS: 00010246
> [  161.539026][ T1854] RAX: 0000000000000000 RBX: 0000000000000cc0 RCX: 0000000000000000
> [  161.583000][ T1854] RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040cc0
> [  161.609763][ T1854] RBP: 0000000000000000 R08: ffffffff8471ffc0 R09: ffff9ed200ea89c0
> [  161.656719][ T1854] R10: 0000000000000000 R11: 00007ffffffff000 R12: ffffbbaf83d37d20
> [  161.684122][ T1854] R13: 000000000000000b R14: 00000000004f6ac9 R15: 0000000000000000
> [  161.727409][ T1854] FS:  00007f37161b6740(0000) GS:ffff9ed53fc00000(0000) knlGS:0000000000000000
> [  161.745554][ T1854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  161.789302][ T1854] CR2: 00007f37157312b8 CR3: 0000000154e9a000 CR4: 00000000000006f0
> [  161.817919][ T1854] DR0: 00007f371434b000 DR1: 0000000000000000 DR2: 0000000000000000
> [  161.874890][ T1854] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> [  161.902698][ T1854] Call Trace:
> [ 161.944436][ T1854] kmalloc_order (mm/slab_common.c:955) 
> [ 161.966240][ T1854] kmalloc_order_trace (mm/slab_common.c:972) 
> [ 161.988118][ T1854] sco_sock_sendmsg (include/linux/slab.h:596 net/bluetooth/sco.c:737) bluetooth
> [ 162.030120][ T1854] sock_sendmsg (net/socket.c:704 net/socket.c:724) 
> [ 162.056656][ T1854] sock_write_iter (net/socket.c:1058) 
> [ 162.078882][ T1854] do_iter_readv_writev (fs/read_write.c:741) 
> [ 162.118490][ T1854] do_iter_write (fs/read_write.c:866 fs/read_write.c:847) 
> [ 162.138544][ T1854] vfs_writev (include/linux/fs.h:3052 fs/read_write.c:940) 
> [ 162.171294][ T1854] ? hrtimer_start_range_ns (kernel/time/hrtimer.c:1154) 
> [ 162.192943][ T1854] ? __hrtimer_get_remaining (kernel/time/hrtimer.c:1322) 
> [ 162.230859][ T1854] ? do_setitimer (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:212 include/trace/events/timer.h:304 kernel/time/itimer.c:237) 
> [ 162.251016][ T1854] do_writev (fs/read_write.c:982) 
> [ 162.280764][ T1854] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 162.298878][ T1854] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [  162.331832][ T1854] RIP: 0033:0x7f37162cdf59
> [ 162.349433][ T1854] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 6f 0c 00 f7 d8 64 89 01 48
> All code
> ========
>    0:	00 c3                	add    %al,%bl
>    2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>    9:	00 00 00 
>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   11:	48 89 f8             	mov    %rdi,%rax
>   14:	48 89 f7             	mov    %rsi,%rdi
>   17:	48 89 d6             	mov    %rdx,%rsi
>   1a:	48 89 ca             	mov    %rcx,%rdx
>   1d:	4d 89 c2             	mov    %r8,%r10
>   20:	4d 89 c8             	mov    %r9,%r8
>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>   28:	0f 05                	syscall 
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	retq   
>   33:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f41
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	retq   
>    9:	48 8b 0d 07 6f 0c 00 	mov    0xc6f07(%rip),%rcx        # 0xc6f17
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> [  162.429292][ T1854] RSP: 002b:00007ffc74a95298 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> [  162.453593][ T1854] RAX: ffffffffffffffda RBX: 0000000000000014 RCX: 00007f37162cdf59
> [  162.497636][ T1854] RDX: 000000000000001e RSI: 000055b96b698320 RDI: 0000000000000169
> [  162.520927][ T1854] RBP: 0000000000000014 R08: 0000000000000400 R09: 0000000001000000
> [  162.564817][ T1854] R10: ffffffffffff0001 R11: 0000000000000246 R12: 0000000000000002
> [  162.587472][ T1854] R13: 00007f3714c72058 R14: 00007f37161b66c0 R15: 00007f3714c72000
> [  162.630811][ T1854] ---[ end trace a634beb86ece7ca4 ]---
> [  198.902990][  T261] Kernel tests: Boot OK!
> [  198.903051][  T261]
> [  200.249722][  T261] /lkp/lkp/src/bin/run-lkp
> [  200.249784][  T261]
> [  270.268687][  T261] RESULT_ROOT=/result/trinity/300s/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/99c23da0eed4fd20cae8243f2b51e10e66aa0951/8
> [  270.268749][  T261]
> [  277.519811][  T261] job=/lkp/jobs/scheduled/vm-snb-138/trinity-300s-debian-10.4-x86_64-20200603.cgz-99c23da0eed4fd20cae8243f2b51e10e66aa0951-20210906-120449-bf95sv-8.yaml
> [  277.519874][  T261]
> [  325.311473][  T261] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/trinity/300s/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/99c23da0eed4fd20cae8243f2b51e10e66aa0951/8, TMP_RESULT_ROOT: /tmp/lkp/result
> [  325.311538][  T261]
> [  325.515703][  T261] run-job /lkp/jobs/scheduled/vm-snb-138/trinity-300s-debian-10.4-x86_64-20200603.cgz-99c23da0eed4fd20cae8243f2b51e10e66aa0951-20210906-120449-bf95sv-8.yaml
> [  325.515767][  T261]
> [  346.131401][  T261] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-snb-138/trinity-300s-debian-10.4-x86_64-20200603.cgz-99c23da0eed4fd20cae8243f2b51e10e66aa0951-20210906-120449-bf95sv-8.yaml&job_state=running -O /dev/null
> [  346.131464][  T261]
> [  346.383711][  T261] target ucode:
> [  346.383751][  T261]
> [  346.483104][  T261] Seeding trinity based on x86_64-rhel-8.3
> [  346.483300][  T261]
> [  346.598046][  T261] 2021-09-06 13:42:21 chroot --userspec nobody:nogroup / time trinity -q -q -l off -s 1655450980 -x get_robust_list -x remap_file_pages -N 999999999
> [  346.598109][  T261]
> [  346.706352][  T261] Trinity 2019.06  Dave Jones <davej@codemonkey.org.uk>
> [  346.706413][  T261]
> [  346.780455][  T261] shm:0x7f37163a7000-0x7f3722fa3d00 (4 pages)
> [  346.780495][  T261]
> [  346.864391][  T261] [main] Marking syscall get_robust_list (64bit:274 32bit:312) as to be disabled.
> [  346.864453][  T261]
> [  346.979437][  T261] [main] Marking syscall remap_file_pages (64bit:216 32bit:257) as to be disabled.
> [  346.979499][  T261]
> [  347.061458][  T261] [main] Couldn't chmod tmp/ to 0777.
> [  347.061519][  T261]
> [  347.137864][  T261] [main] Using user passed random seed: 1655450980.
> [  347.137904][  T261]
> [  347.211100][  T261] Marking all syscalls as enabled.
> [  347.211365][  T261]
> [  347.301646][  T261] [main] Disabling syscalls marked as disabled by command line options
> [  347.301706][  T261]
> [  347.406841][  T261] [main] Marked 64-bit syscall remap_file_pages (216) as deactivated.
> [  347.406904][  T261]
> [  347.501523][  T261] [main] Marked 64-bit syscall get_robust_list (274) as deactivated.
> [  347.501563][  T261]
> [  347.593825][  T261] [main] Marked 32-bit syscall remap_file_pages (257) as deactivated.
> [  347.593887][  T261]
> [  347.686765][  T261] [main] Marked 32-bit syscall get_robust_list (312) as deactivated.
> [  347.686827][  T261]
> [  347.818655][  T261] [main] 32-bit syscalls: 426 enabled, 3 disabled.  64-bit syscalls: 352 enabled, 91 disabled.
> [  347.818719][  T261]
> [  347.901583][  T261] [main] Using pid_max = 32768
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.14.0-rc7-01816-g99c23da0eed4 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation
> 
> Thanks,
> Oliver Sang
> 
> 
