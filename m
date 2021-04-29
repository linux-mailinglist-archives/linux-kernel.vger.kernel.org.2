Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029336E837
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhD2Jvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbhD2Jvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:51:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62FC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:50:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so8883359wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMnTOjGiinXKPDNvtmHqxGJ4wlHQc4ruIORGjuq+Kuo=;
        b=FESoJHwPuaSIHHw4j34VRZkd0AELXl1NY9fZVj1VSCaN5rwoerExtseA6cUOS46FVK
         NJwZonIQ68c/LHlc+lhSrcN7XHWD0h/ki4vmUnpOGzutA5mstvEPsJdxWLNlVuFXs6YZ
         rOPVGie0wdlndbZ6x59fQThQ6NFY0gXsHCmPgcq5nWD6JemrQrqDTWTcyaUu1nFgjkkT
         ddrLbhmrpE0gM/SIaCteuXzhNZ/cGH3dGrhYCkHhfJ1oUcsh4CQj60dX2AiPLukTXS55
         +qNEk9j/RAemWRsU15mThwM8p1TQeja1SBzdtI5CC0YTSQOaQkd4FDDxVXTCY7ZDTTIC
         1amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMnTOjGiinXKPDNvtmHqxGJ4wlHQc4ruIORGjuq+Kuo=;
        b=brefDBVfxjf7qH7323Uf+QIw9PKLj4c0YTRf/qgpgbfQXR5rQrBDC37DAm7K2x+oT8
         Igey8L/bsMwloXvg7Scv7mBVKu9+fcfIy+UzXmfaqwUISnvddpXGORlfXvN+Mx0TI8/9
         3MHdYu6uosrKl8jS8W1IYOSuGfECfJDpZDfARLDNRuIlJliIkyDbEywtEJjFcFdOs5/W
         WRmCksk3BFTQOG7gwscfIWU45HZ4TPdqOQggIsC3woNUhQTbg/b6CZamqmMxMzwrcSTd
         5ZnslDccWMoI5/wBiAXa7+XvC4ROMEQXil5gMHkNTS6mo52wQHfqDq4s53ycy2Y+wyn2
         bK5A==
X-Gm-Message-State: AOAM53063JxRJuFhwxkMrnHXhdKVvgakYTPfLZHRRwkUNrS6aAD59Ios
        8NpxQQdvgxCFPOwLmwoLs6I=
X-Google-Smtp-Source: ABdhPJzQeQusIKkAweDx0CMfOIO6cQUG1Q3nmbktKqZQp3EBs5shhey+dJolqv8lYVdA9fqO9MmqGg==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr9340790wmh.109.1619689835092;
        Thu, 29 Apr 2021 02:50:35 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.132.80])
        by smtp.gmail.com with ESMTPSA id g10sm8118315wmq.25.2021.04.29.02.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 02:50:34 -0700 (PDT)
Subject: Re: [syzbot] WARNING in percpu_ref_switch_to_atomic_rcu (2)
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+842c825a3ade3fb904bf@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000053287805c1095c9d@google.com>
 <20210429093859.2059-1-hdanton@sina.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <839f6bce-101d-a971-ad17-61e02f5007a2@gmail.com>
Date:   Thu, 29 Apr 2021 10:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210429093859.2059-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/21 10:38 AM, Hillf Danton wrote:
> On Wed, 28 Apr 2021 07:40:31 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    57fa2369 Merge tag 'cfi-v5.13-rc1' of git://git.kernel.org..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=173e8725d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c37352b2923ef305
>> dashboard link: https://syzkaller.appspot.com/bug?extid=842c825a3ade3fb904bf
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135f0c7dd00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+842c825a3ade3fb904bf@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> percpu ref (free_ioctx_reqs) <= 0 (0) after switching to atomic
> 
> Is it ctx->refs leak?
> 
>> WARNING: CPU: 0 PID: 9966 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x3e4/0x4a0 lib/percpu-refcount.c:196
>> Modules linked in:
>> CPU: 0 PID: 9966 Comm: kworker/u4:4 Not tainted 5.12.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: events_unbound call_usermodehelper_exec_work
>> RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x3e4/0x4a0 lib/percpu-refcount.c:196
>> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 ba 00 00 00 48 8b 44 24 08 4c 89 e2 48 c7 c7 80 05 c2 89 48 8b 70 e8 e8 cb 7c fb 04 <0f> 0b e9 3b ff ff ff 48 c7 c7 a4 27 c6 8d e8 39 a9 ee fd e9 19 fd
>> RSP: 0018:ffffc90000007e28 EFLAGS: 00010282
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ffff88803c80b880 RSI: ffffffff815c3fc5 RDI: fffff52000000fb7
>> RBP: ffff888027181980 R08: 0000000000000000 R09: 0000000000000000
>> R10: ffffffff815bcd5e R11: 0000000000000000 R12: 0000000000000000
>> R13: 0000607f46081cc0 R14: 0000000000000007 R15: 0000000000000002
>> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000300 CR3: 0000000012084000 CR4: 00000000001506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <IRQ>
>>  rcu_do_batch kernel/rcu/tree.c:2559 [inline]
>>  rcu_core+0x74a/0x12f0 kernel/rcu/tree.c:2794
>>  __do_softirq+0x29b/0x9f6 kernel/softirq.c:559
>>  invoke_softirq kernel/softirq.c:433 [inline]
>>  __irq_exit_rcu kernel/softirq.c:637 [inline]
>>  irq_exit_rcu+0x134/0x200 kernel/softirq.c:649
>>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>>  </IRQ>
>>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
>> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:27 [inline]
>> RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
>> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
>> Code: f0 4d 89 03 e9 f2 fc ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 40 00 <65> 8b 05 29 07 8e 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
>> RSP: 0018:ffffc9000b2f78d0 EFLAGS: 00000293
>> RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
>> RDX: ffff88803c80b880 RSI: ffffffff816465bf RDI: 0000000000000003
>> RBP: 0000000000044664 R08: 0000000000000000 R09: ffffffff901948b7
>> R10: ffffffff816465b5 R11: 0000000000000000 R12: 0000000000000000
>> R13: dffffc0000000000 R14: ffffffff8bf92b90 R15: 0000000000002192
>>  __seqprop_raw_spinlock_sequence include/linux/seqlock.h:276 [inline]
>>  timekeeping_get_delta kernel/time/timekeeping.c:252 [inline]
>>  timekeeping_get_ns kernel/time/timekeeping.c:386 [inline]
>>  ktime_get_with_offset+0x1f5/0x500 kernel/time/timekeeping.c:872
>>  ktime_get_boottime include/linux/timekeeping.h:94 [inline]
>>  ktime_get_boottime_ns include/linux/timekeeping.h:163 [inline]
>>  copy_process+0x350f/0x71a0 kernel/fork.c:2226
>>  kernel_clone+0xe7/0xab0 kernel/fork.c:2500
>>  kernel_thread+0xb5/0xf0 kernel/fork.c:2552
>>  call_usermodehelper_exec_work kernel/umh.c:172 [inline]
>>  call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:158
>>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
>>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
>>  kthread+0x3b1/0x4a0 kernel/kthread.c:292
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> Before finding an answer to the question above, spot a chance to add a line
> in bid to restore the old behavior - reinit completion, otherwise refs cannot
> make much sense in terms of race that ctx goes home without waiting for its
> refs to drop down to ground.

I'd highly encourage you to add understandable descriptions
because this one doesn't make any sense. Why you add it?

Even more curious, is it io_uring related? Because the repro
does only aio, as well as the error happened in aio, see
free_ioctx_reqs()

> 
> +++ x/fs/io_uring.c
> @@ -1085,6 +1085,7 @@ static void io_refs_resurrect(struct per
>  	if (!got)
>  		wait_for_completion(compl);
>  	percpu_ref_resurrect(ref);
> +	reinit_completion(compl);
>  	if (got)
>  		percpu_ref_put(ref);
>  }
> 

-- 
Pavel Begunkov
