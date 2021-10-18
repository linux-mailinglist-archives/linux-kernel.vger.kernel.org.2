Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A184430F52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhJREpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhJREpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:45:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDBC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:43:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso13581201pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=O1HDXDwI+rJYQtb5YdIwkxX51aNOFH8gMOgY3rE7DwM=;
        b=q0gWLweEOxJ/GhW7aN3zHx5bkjL8btdXQJhgVFIgnWsfydqVLb3196a3jztwpzp8uK
         /lB0RtG5xv0yPg7PTEvL2lTIj3UmG6XZu5RRjgIFSBDhjUH6okv3isFGHAni4jeVJohc
         f2BFUNvtIPd91OUy3rh3U1JlmqhdJhF70En1Uumj8TaAP8YlmMwzPzomJ7SpomNSJUao
         uER+lpzTFgMlh0mCgGlt0IK+ntX5BqPra/yAiLJ29Pijn+AZ0NOiADEI6IzwW3XQ6sNi
         I/ck3y0XwWthDyoGbRZHAmAxJEnBIjpctQDRmA5HRFwjCUWjCgg+J8WeqJuUG+DaZm6+
         cKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=O1HDXDwI+rJYQtb5YdIwkxX51aNOFH8gMOgY3rE7DwM=;
        b=IRB+DROOC5+RhRcc8rJ0n9v8LIJKKN1/xSDmdXvlsihCmoiegadHEsAVhl8lQGF4ng
         Y+U2u+/oSTlbeWH6ZiNGORu3EoaHceLJTbVWEiWaogXQeM49hLlAZmVER6qxMQrja335
         2l0tj+TPVQfXC9mVtk2AN2NWJz0zWn9552X7ooRQag8SeRKfI9IovjN55l22ldoYrmug
         RDw0DlBkcPQxMg9gjAIbT+P/MNDj4SrKcdiza0ig+UZQd5uJQD9p1Pl5Jb8Xc9NACSrC
         ix47eAtKpFNNVTTqoMIML7wtEgzZQVDVoNqyWV+MCVf3Ku6aKFBQ3yUI14TrWlsysDYn
         hRnw==
X-Gm-Message-State: AOAM5319qSWQ751XxuKxGJvpIghHbxtWZn9klygLJFchqreunIzWS1Np
        +nTDllms7VwzSAV3r1wTrlA=
X-Google-Smtp-Source: ABdhPJyCSBZ4GYUtu/7NRyXx9/d/Lji8g5hExHmrBK8R9ipT3XTElK7b9yQn9oiM+1njwOmVe3sdhQ==
X-Received: by 2002:a17:90a:5502:: with SMTP id b2mr45797799pji.154.1634532221829;
        Sun, 17 Oct 2021 21:43:41 -0700 (PDT)
Received: from [172.18.2.138] ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id h3sm12405583pfv.166.2021.10.17.21.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 21:43:41 -0700 (PDT)
Subject: Re: WARNING in __init_work
To:     Hao Sun <sunhao.th@gmail.com>, Hillf Danton <hdanton@sina.com>,
        hch@infradead.org, willy@infradead.org
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, syzkaller-bugs@googlegroups.com
References: <CACkBjsZfAZpOFeYC8mQ03r_JB_eF-dNMEkXf3LNji7_CgOCF2Q@mail.gmail.com>
 <20210907074432.3711-1-hdanton@sina.com>
 <CACkBjsYsxNqkup1FQkP4eMzxZ_xNgifPx+gFxEo0gnBUYPp1PQ@mail.gmail.com>
From:   Zqiang <qiang.zhang1211@gmail.com>
Message-ID: <d242861c-5c41-0d1b-3f71-43f50e5a3b68@gmail.com>
Date:   Mon, 18 Oct 2021 12:43:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsYsxNqkup1FQkP4eMzxZ_xNgifPx+gFxEo0gnBUYPp1PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/10/14 上午10:38, Hao Sun wrote:
> Hillf Danton <hdanton@sina.com> 于2021年9月7日周二 下午3:44写道：
>> On Tue, 7 Sep 2021 09:22:03 +0800 Hao Sun wrote:
>>> When using Healer to fuzz the latest Linux kernel, the following crash
>>> was triggered.
>>>
>>> HEAD commit: 27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04'
>>> git tree: upstream
>>> console output:
>>> https://drive.google.com/file/d/1M5oyA_IcWSDB2XpnoX8SDmKJA3JhKltz/view?usp=sharing
>>> kernel config: https://drive.google.com/file/d/1ZMVJ2vNe0EiIEeWNVyrGb7hBdOG5Uj3e/view?usp=sharing
>>> C reproducer: https://drive.google.com/file/d/1AtDNXl8XEBfglKXsKsAH2NuXBcrp8Zp9/view?usp=sharing
>>> Syzlang reproducer:
>>> https://drive.google.com/file/d/1R_XD_cyMNS0Q_SGSqomRy_LIClOrd-gI/view?usp=sharing
>>>
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>> Thanks for reporting it.
>>
>>> ODEBUG: object ffffc9000073cda0 is NOT on stack ffffc90005f34000, but annotated.
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 2 PID: 27648 at lib/debugobjects.c:548
>>> debug_object_is_on_stack lib/debugobjects.c:545 [inline]
>>> WARNING: CPU: 2 PID: 27648 at lib/debugobjects.c:548
>>> __debug_object_init+0x224/0x520 lib/debugobjects.c:607
>>> Modules linked in:
>>> CPU: 2 PID: 27648 Comm: syz-executor Not tainted 5.14.0+ #13
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>>> RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:545 [inline]
>>> RIP: 0010:__debug_object_init+0x224/0x520 lib/debugobjects.c:607
>>> Code: 84 ca fe ff ff 83 c0 01 4c 89 f6 48 c7 c7 f8 b0 3c 85 89 05 7e
>>> c2 56 06 65 48 8b 04 25 40 70 01 00 48 8b 50 20 e8 05 9b f5 01 <0f> 0b
>>> e9 9e fe ff ff 89 05 87 4d e3 03 e9 c4 fe ff ff 48 c7 c7 e0
>>> RSP: 0018:ffffc9000073ccf0 EFLAGS: 00010282
>>> RAX: 0000000000000050 RBX: ffff88810cf2f398 RCX: 0000000000000100
>>> RDX: 0000000000000000 RSI: ffffffff812cf85c RDI: 00000000ffffffff
>>> RBP: ffffffff88868538 R08: 0000000000000000 R09: 0000000000000001
>>> R10: ffffc9000073cc80 R11: 0000000000000005 R12: 0000000000000203
>>> R13: 0000000000054450 R14: ffffc9000073cda0 R15: ffff88807dd264f0
>>> FS:  0000000002ad0940(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00000000005061ec CR3: 0000000100da5000 CR4: 0000000000750ee0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> PKRU: 55555554
>>> Call Trace:
>>>   <IRQ>
>>>   __init_work+0x3f/0x50 kernel/workqueue.c:519
>>>   synchronize_rcu_expedited+0x26a/0x460 kernel/rcu/tree_exp.h:847
>> Given wait_event() in synchronize_rcu_expedited(), it is no good to come
>> in a rcu context.
>>
>>>   bdi_remove_from_list mm/backing-dev.c:938 [inline]
>>>   bdi_unregister+0x97/0x270 mm/backing-dev.c:946
>>>   release_bdi+0x4a/0x70 mm/backing-dev.c:968
>>>   kref_put include/linux/kref.h:65 [inline]
>>>   bdi_put+0x47/0x70 mm/backing-dev.c:976
>>>   bdev_free_inode+0x59/0xc0 fs/block_dev.c:819
>>>   i_callback+0x24/0x50 fs/inode.c:224
>>>   rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>>>   rcu_core+0x2d6/0x9f0 kernel/rcu/tree.c:2743
>>>   __do_softirq+0xe9/0x561 kernel/softirq.c:558
>>>   invoke_softirq kernel/softirq.c:432 [inline]
>>>   __irq_exit_rcu kernel/softirq.c:636 [inline]
>>>   irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
>>>   sysvec_apic_timer_interrupt+0x9e/0xc0 arch/x86/kernel/apic/apic.c:1097
>>>   </IRQ>
>>>   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
>>> RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
>>> Code: 65 48 8b 14 25 40 70 01 00 81 e1 00 01 00 00 a9 00 01 ff 00 74
>>> 0e 85 c9 74 35 8b 82 34 15 00 00 85 c0 74 2b 8b 82 10 15 00 00 <83> f8
>>> 02 75 20 48 8b 8a 18 15 00 00 8b 92 14 15 00 00 48 8b 01 48
>>> RSP: 0018:ffffc90005f37b78 EFLAGS: 00000246
>>> RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000000
>>> RDX: ffff888109448000 RSI: ffffffff8212a28c RDI: ffffc90005f37d30
>>> RBP: 0000000000000006 R08: 0000000000000d40 R09: ffff8880165fc5e0
>>> R10: ffffc90005f37cd0 R11: 0000000000000003 R12: 0000000000000375
>>> R13: ffff888107597b40 R14: ffffc90005f37d30 R15: ffff8880174b0ea0
>>>   tomoyo_domain_quota_is_ok+0xac/0x150 security/tomoyo/util.c:1092
>>>   tomoyo_supervisor+0x228/0x7f0 security/tomoyo/common.c:2089
>>>   tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
>>>   tomoyo_path_permission+0xa0/0xf0 security/tomoyo/file.c:587
>>>   tomoyo_path_perm+0x22f/0x2d0 security/tomoyo/file.c:838
>>>   tomoyo_path_symlink+0x43/0x70 security/tomoyo/tomoyo.c:199
>>>   security_path_symlink+0x48/0x80 security/security.c:1164
>>>   do_symlinkat+0x75/0x120 fs/namei.c:4274
>>>   __do_sys_symlink fs/namei.c:4301 [inline]
>>>   __se_sys_symlink fs/namei.c:4299 [inline]
>>>   __x64_sys_symlink+0x3a/0x40 fs/namei.c:4299
>>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> RIP: 0033:0x46a597
>>> Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
>>> 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 58 00 00 00 0f 05 <48> 3d
>>> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007ffd09085778 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000046a597
>>> RDX: 0000000000000000 RSI: 00000000004e40f9 RDI: 00007ffd09085810
>>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000014
>>> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>>> R13: 0000000000000000 R14: 00007ffd09085810 R15: 00007ffd090857cc
>>> ----------------
>>> Code disassembly (best guess):
>>>     0: 65 48 8b 14 25 40 70 mov    %gs:0x17040,%rdx
>>>     7: 01 00
>>>     9: 81 e1 00 01 00 00    and    $0x100,%ecx
>>>     f: a9 00 01 ff 00        test   $0xff0100,%eax
>>>    14: 74 0e                je     0x24
>>>    16: 85 c9                test   %ecx,%ecx
>>>    18: 74 35                je     0x4f
>>>    1a: 8b 82 34 15 00 00    mov    0x1534(%rdx),%eax
>>>    20: 85 c0                test   %eax,%eax
>>>    22: 74 2b                je     0x4f
>>>    24: 8b 82 10 15 00 00    mov    0x1510(%rdx),%eax
>>> * 2a: 83 f8 02              cmp    $0x2,%eax <-- trapping instruction
>>>    2d: 75 20                jne    0x4f
>>>    2f: 48 8b 8a 18 15 00 00 mov    0x1518(%rdx),%rcx
>>>    36: 8b 92 14 15 00 00    mov    0x1514(%rdx),%edx
>>>    3c: 48 8b 01              mov    (%rcx),%rax
>>>    3f: 48                    rex.W%
>>>
>> Move releasing of bdi to workqueue work to make it safe to sync rcu.
>>
>> Only for thoughts now.
>>
>> +++ x/mm/backing-dev.c
>> @@ -959,10 +959,11 @@ void bdi_unregister(struct backing_dev_i
>>          }
>>   }
>>
>> -static void release_bdi(struct kref *ref)
>> +static void bdi_release_workfn(struct work_struct *work)
>>   {
>> -       struct backing_dev_info *bdi =
>> -                       container_of(ref, struct backing_dev_info, refcnt);
>> +       struct backing_dev_info *bdi;
>> +
>> +       bdi = container_of(work, struct backing_dev_info, release_work);
>>
>>          if (test_bit(WB_registered, &bdi->wb.state))
>>                  bdi_unregister(bdi);
>> @@ -971,6 +972,16 @@ static void release_bdi(struct kref *ref
>>          kfree(bdi);
>>   }
>>
>> +static void release_bdi(struct kref *ref)
>> +{
>> +       struct backing_dev_info *bdi;
>> +
>> +       bdi = container_of(ref, struct backing_dev_info, refcnt);
>> +
>> +       INIT_WORK(&bdi->release_work, bdi_release_workfn);
>> +       queue_work(system_unbound_wq, &bdi->release_work);
>> +}
>> +
>>   void bdi_put(struct backing_dev_info *bdi)
>>   {
>>          kref_put(&bdi->refcnt, release_bdi);
> Hi,
>
> This issue can still be triggered repeatedly on the latest Linux kernel.
>
> HEAD commit: 64570fbc14f8 Linux 5.15-rc5
> git tree: upstream
> kernel config: https://drive.google.com/file/d/1em3xgUIMNN_-LUUdySzwN-UDPc3qiiKD/view?usp=sharing
>
> ODEBUG: object ffffc90000007bc0 is NOT on stack ffffffff8b600000, but annotated.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:548
> debug_object_is_on_stack lib/debugobjects.c:542 [inline]
> WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:548
> __debug_object_init.cold+0x21d/0x29a lib/debugobjects.c:607
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc5 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:548 [inline]
> RIP: 0010:__debug_object_init.cold+0x21d/0x29a lib/debugobjects.c:607
> Code: 00 48 8d 7b 20 48 89 fa 48 c1 ea 03 80 3c 02 00 74 05 e8 2a 7d
> be f8 48 8b 53 20 4c 89 e6 48 c7 c7 80 3b e4 89 e8 22 42 f2 ff <0f> 0b
> e9 cf bc e6 fa 4c 89 e0 48 c1 e8 03 80 3c 18 00 74 08 4c 89
> RSP: 0018:ffffc900000079f0 EFLAGS: 00010282
> RAX: 0000000000000050 RBX: ffffffff8b6bc640 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8b6bc640 RDI: fffff52000000f30
> RBP: ffffffff8b6bc640 R08: 0000000000000050 R09: 0000000000000000
> R10: 0000000000000005 R11: ffffed100c7c57f8 R12: ffffc90000007bc0
> R13: 1ffff92000000f4c R14: ffffffff90472c30 R15: ffffffff90472c38
> FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555556100c48 CR3: 00000000279c8000 CR4: 0000000000350ef0
> Call Trace:
>   <IRQ>
>   __init_work+0x2d/0x50 kernel/workqueue.c:519
>   synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
>   bdi_remove_from_list mm/backing-dev.c:938 [inline]
>   bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
>   release_bdi+0xa1/0xc0 mm/backing-dev.c:968
>   kref_put include/linux/kref.h:65 [inline]
>   bdi_put+0x72/0xa0 mm/backing-dev.c:976
>   bdev_free_inode+0x11e/0x220 block/bdev.c:408
>   i_callback+0x3f/0x70 fs/inode.c:226
>   rcu_do_batch kernel/rcu/tree.c:2508 [inline]
>   rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
>   __do_softirq+0x1d7/0x93b kernel/softirq.c:558
>   invoke_softirq kernel/softirq.c:432 [inline]
>   __irq_exit_rcu kernel/softirq.c:636 [inline]
>   irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
>   sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
>   </IRQ>
>   asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:717
> Code: 1b 51 88 f8 e9 6f fe ff ff e8 11 51 88 f8 e9 3d fe ff ff e8 17
> 31 fd ff cc cc cc cc cc cc cc eb 07 0f 00 2d 47 99 50 00 fb f4 <c3> 0f
> 1f 40 00 41 54 be 08 00 00 00 53 65 48 8b 1c 25 40 f0 01 00
> RSP: 0018:ffffffff8b607e28 EFLAGS: 00000206
> RAX: 000000000006117b RBX: 0000000000000000 RCX: ffffffff8932d572
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed100c7c6542
> R10: ffff888063e32a0b R11: ffffed100c7c6541 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffff8d6d8590 R15: 0000000000000000
>   default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
>   cpuidle_idle_call kernel/sched/idle.c:194 [inline]
>   do_idle+0x3f9/0x570 kernel/sched/idle.c:306
>   cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
>   start_kernel+0x47a/0x49b init/main.c:1141
>   secondary_startup_64_no_verify+0xb0/0xbb
> ----------------
> Code disassembly (best guess):
>     0: 1b 51 88              sbb    -0x78(%rcx),%edx
>     3: f8                    clc
>     4: e9 6f fe ff ff        jmpq   0xfffffe78
>     9: e8 11 51 88 f8        callq  0xf888511f
>     e: e9 3d fe ff ff        jmpq   0xfffffe50
>    13: e8 17 31 fd ff        callq  0xfffd312f
>    18: cc                    int3
>    19: cc                    int3
>    1a: cc                    int3
>    1b: cc                    int3
>    1c: cc                    int3
>    1d: cc                    int3
>    1e: cc                    int3
>    1f: eb 07                jmp    0x28
>    21: 0f 00 2d 47 99 50 00 verw   0x509947(%rip)        # 0x50996f
>    28: fb                    sti
>    29: f4                    hlt
> * 2a: c3                    retq <-- trapping instruction
>    2b: 0f 1f 40 00          nopl   0x0(%rax)
>    2f: 41 54                push   %r12
>    31: be 08 00 00 00        mov    $0x8,%esi
>    36: 53                    push   %rbx
>    37: 65 48 8b 1c 25 40 f0 mov    %gs:0x1f040,%rbx
>    3e: 01 00%


Hello  Christoph

This is the details of the test, Hope it helps you


