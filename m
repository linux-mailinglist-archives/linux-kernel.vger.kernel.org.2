Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CDD4311EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJRIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231241AbhJRIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634544640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnA8MT7Ob7mouhURX5ILzvC+8q8KXDeeRzqixSKJ+uA=;
        b=Uwp/nzhSVjYgEDRxoujbjJ9Sn51xYC032GEIo7veDcW4Wa8C9q4gd79PYaM7grtoif9gEa
        FYO6uu2CqImV5eeK1+M4XZ1owA5WmCjI0/VnDAWOM5NIMAtRcI5JhslbPphP9OZXfwAHDj
        3Dk+BoLJ0Mv8qHAblbJtD8b7bFPHlQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-3QKG_GpgPTazUOWgI06a2Q-1; Mon, 18 Oct 2021 04:10:36 -0400
X-MC-Unique: 3QKG_GpgPTazUOWgI06a2Q-1
Received: by mail-wr1-f72.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso8539017wri.17
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZnA8MT7Ob7mouhURX5ILzvC+8q8KXDeeRzqixSKJ+uA=;
        b=aE19KcVDzCPJsdQIuU7meNX1J6orV/1MXcfr5A/Jfhe240EtRc+zPI9SjmyDsOFgNZ
         b5Iuauqd+E2KHnXvUcHc6364yamphxQthlNR2McLlcFMIdaWsddeeQOKDr2fXm8/6NjL
         rPTMvm2UvI7iWEVwAjIib2QtGZBB4mWUF1CROG6Msu5I1sjUHDPsuNJm0y36a+U5S6f/
         hBzaMjshAL2MQtQxrkYoqKfs/ETKTC+sG3FzZchICYc/YGrmhzRKUwnN+RnxR94lBlaO
         WS+XVnkbZQkpQVpbqp8gcwCAkQLtzEp3+A+cvekZ6H1bZ++HkGeZfVmHCtY7WAzRaKs5
         IpHA==
X-Gm-Message-State: AOAM5330zwwSLa2VaL19BP+Z8nhME5kcoXkv48vm1u+0xziSae1DBXTP
        bodhl6qKUGBljj32VKIYSk4DxTmhcjhiMUUjbhNwkAC90D/y3PaoGBxvJ21H7Nre+rcA/zYDZEu
        ZaKxEGZNJNE7r7qDYCH4xAmFR
X-Received: by 2002:a7b:c941:: with SMTP id i1mr19076439wml.40.1634544634444;
        Mon, 18 Oct 2021 01:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys7AKTvt1sd3OfotWFKwlEqxQaCwgs8GD6T6IHHiLlMwMTYqxzxbTwkxrYbPh+Wj/xFUiUmQ==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr19076412wml.40.1634544634225;
        Mon, 18 Oct 2021 01:10:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x24sm18729227wmk.31.2021.10.18.01.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 01:10:33 -0700 (PDT)
Message-ID: <817cc5a7-9ca9-0749-1df6-c14f82b1c621@redhat.com>
Date:   Mon, 18 Oct 2021 10:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [syzbot] WARNING: kmalloc bug in kvm_page_track_create_memslot
Content-Language: en-US
To:     syzbot <syzbot+d9c9b7cff3d4ec7a589e@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <00000000000017f90605ce9ad95d@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <00000000000017f90605ce9ad95d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: WARNING: kmalloc bug in memslot_rmap_alloc

On 18/10/21 08:42, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d999ade1cc86 Merge tag 'perf-tools-fixes-for-v5.15-2021-10..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=161ab644b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=d9c9b7cff3d4ec7a589e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fcdc34b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14785d34b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d9c9b7cff3d4ec7a589e@syzkaller.appspotmail.com
> 
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6533 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 6533 Comm: syz-executor711 Not tainted 5.15.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
> Code: 01 00 00 00 4c 89 e7 e8 ad 18 0d 00 49 89 c5 e9 69 ff ff ff e8 60 91 d0 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 4f 91 d0 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 36
> RSP: 0018:ffffc900011ef6e8 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff88807a7e8000 RSI: ffffffff81a646c1 RDI: 0000000000000003
> RBP: 0000000000400dc0 R08: 000000007fffffff R09: ffff8880b9d32a0b
> R10: ffffffff81a6467e R11: 000000000000003f R12: 00000000e0000000
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffffc900011ef950
> FS:  0000000000000000(0000) GS:ffff8880b9d00000(0063) knlGS:0000000056d512c0
> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> CR2: 000055ad809529a0 CR3: 000000001ae94000 CR4: 00000000003526e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   kvmalloc include/linux/mm.h:805 [inline]
>   kvmalloc_array include/linux/mm.h:823 [inline]
>   kvcalloc include/linux/mm.h:828 [inline]
>   kvm_page_track_create_memslot+0x50/0x110 arch/x86/kvm/mmu/page_track.c:39
>   kvm_alloc_memslot_metadata arch/x86/kvm/x86.c:11501 [inline]
>   kvm_arch_prepare_memory_region+0x350/0x610 arch/x86/kvm/x86.c:11538
>   kvm_set_memslot+0x172/0x1a40 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1592
>   __kvm_set_memory_region+0xc1c/0x13d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1755
>   kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1776 [inline]
>   kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1788 [inline]
>   kvm_vm_ioctl+0x520/0x23d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4363
>   kvm_vm_compat_ioctl+0x288/0x350 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4588
>   __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
>   do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>   __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>   do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>   entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf7e67549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000ff89659c EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000004020ae46
> RDX: 00000000200001c0 RSI: 00000000ff8965f0 RDI: 00000000f7f0a000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> ----------------
> Code disassembly (best guess):
>     0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
>     4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
>     a:	10 06                	adc    %al,(%rsi)
>     c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    10:	10 07                	adc    %al,(%rdi)
>    12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    16:	10 08                	adc    %cl,(%rax)
>    18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
>    1c:	00 00                	add    %al,(%rax)
>    1e:	00 00                	add    %al,(%rax)
>    20:	00 51 52             	add    %dl,0x52(%rcx)
>    23:	55                   	push   %rbp
>    24:	89 e5                	mov    %esp,%ebp
>    26:	0f 34                	sysenter
>    28:	cd 80                	int    $0x80
> * 2a:	5d                   	pop    %rbp <-- trapping instruction
>    2b:	5a                   	pop    %rdx
>    2c:	59                   	pop    %rcx
>    2d:	c3                   	retq
>    2e:	90                   	nop
>    2f:	90                   	nop
>    30:	90                   	nop
>    31:	90                   	nop
>    32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
>    39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

