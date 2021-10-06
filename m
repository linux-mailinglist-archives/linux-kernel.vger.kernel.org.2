Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBDC423D81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhJFMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238105AbhJFMQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pO4PlWo7HtXIXRFXm7PKxdfb4eUPK7D//T+BQxzSe24=;
        b=fJghp4H/qO7SBgimY/3foOUzjNNtIXQQNzfj37y+RjBl4nPTCseuxr09aWB4OeILaa2qlo
        tM2TD9ldlCSkJryMKKaLZXGKpTratR/pCN+8Byk+focCanj8AZPBj7sYE4X4CTl0hEEIGu
        SLXuIyl1EnukZKJWCfQmn2HLzdfNQ7U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-krujt2cHNvqXNNrvYUTMDA-1; Wed, 06 Oct 2021 08:14:36 -0400
X-MC-Unique: krujt2cHNvqXNNrvYUTMDA-1
Received: by mail-io1-f69.google.com with SMTP id j7-20020a0566022cc700b005d65f61a95fso1943862iow.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 05:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pO4PlWo7HtXIXRFXm7PKxdfb4eUPK7D//T+BQxzSe24=;
        b=MOs16OPvqVGzIUJnWo4kKnzDXSkrSwoC9ECra1j0x63ZeHSMhqQx9450M2brxFRCTA
         NU9OstDbRLJXAnOgGKWLctJEiz2oXQYbW1zA+UZPltPTxiYV2PEFzcAOUeJpJWLYPKQI
         12Gt4eLixfIR0SyX1xZlrK4C4C9U7EFJQwx1/yWdKyk5Ea1Y1K2w0hOglzMxWLyiGH85
         O4bO5VnMlKQZZ+kEbqUed4Wv38YeTbpWTqNGpUb7qwInkaHy0XYF6gc6EQVCO1zoYNo2
         NjjMBwoWCNHpo2NfKhveWoioDJBJA+33E6Tci9E/ZBxFYtQCRnsNux0DWIeeoXQR35n2
         dRng==
X-Gm-Message-State: AOAM531EGpIx6efwPEFaAxA6bNA++p0n8+HvtxKRsaFBVv7wamG8KGKZ
        jiJZ6AXePJG/gdpL1U6UsaOIJpjA16rK91l3KounT4lHZmmnaYjjgQ2mtei/fo/CJEVyIdv8RTC
        offxaKMof7wanc8SPSujRImfv
X-Received: by 2002:a02:998a:: with SMTP id a10mr6959461jal.23.1633522475345;
        Wed, 06 Oct 2021 05:14:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUzM5RufE+kX+JI2YU2VehZCyjN0dYG5quERcJmLyHP4rvBAFs45Zc48/UnZnKXY676Eimsw==
X-Received: by 2002:a02:998a:: with SMTP id a10mr6959444jal.23.1633522475012;
        Wed, 06 Oct 2021 05:14:35 -0700 (PDT)
Received: from [172.16.0.19] ([172.87.10.244])
        by smtp.gmail.com with ESMTPSA id a5sm13238251ilf.27.2021.10.06.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 05:14:34 -0700 (PDT)
Message-ID: <cf8bc8dd-8e16-3590-a714-51203e6f4ba9@redhat.com>
Date:   Wed, 6 Oct 2021 07:14:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: WARNING in __set_page_dirty
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, agruenba@redhat.com,
        cluster-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        akpm@linux-foundation.org, Linux MM <linux-mm@kvack.org>
References: <CACkBjsbEcdArgkRDy0QVegPoDCUPNGDikPCa_hBprEQb-6TThQ@mail.gmail.com>
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <CACkBjsbEcdArgkRDy0QVegPoDCUPNGDikPCa_hBprEQb-6TThQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/21 3:50 AM, Hao Sun wrote:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1Tqtv5Qcx5LDPwnv7b2uJS2bilqpGfipG/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
> inode_to_wb include/linux/backing-dev.h:283 [inline]
> WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
> account_page_dirtied mm/page-writeback.c:2452 [inline]
> WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
> __set_page_dirty+0x50b/0x6e0 mm/page-writeback.c:2500
> Modules linked in:
> CPU: 0 PID: 19902 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:inode_to_wb include/linux/backing-dev.h:283 [inline]
> RIP: 0010:account_page_dirtied mm/page-writeback.c:2452 [inline]
> RIP: 0010:__set_page_dirty+0x50b/0x6e0 mm/page-writeback.c:2500
> Code: fc ff ff e8 d7 0a f1 ff 49 8b 87 a8 01 00 00 be ff ff ff ff 48
> 8d 78 70 e8 a2 42 de 02 85 c0 0f 85 18 fc ff ff e8 b5 0a f1 ff <0f> 0b
> e9 0c fc ff ff e8 a9 0a f1 ff 48 89 ef e8 f1 ea d8 00 48 8b
> RSP: 0018:ffffc90003e7bd08 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffea000083a140 RCX: 0000000000000000
> RDX: ffff88810e1b8000 RSI: ffffffff814686ab RDI: ffffffff853ccbb6
> RBP: ffff88800ce0bec8 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc90003e7bbb8 R11: 0000000000000003 R12: ffff8881100ecc98
> R13: ffff8881045ac000 R14: 0000000000000293 R15: ffff88800ce0bec8
> FS:  00007f72d08c8700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000003 CR3: 000000001a0a6000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
> PKRU: 55555554
> Call Trace:
>   mark_buffer_dirty+0x1d4/0x2b0 fs/buffer.c:1108
>   gfs2_unpin+0x74/0x460 fs/gfs2/lops.c:111
>   buf_lo_after_commit+0x6b/0x80 fs/gfs2/lops.c:750
>   lops_after_commit fs/gfs2/lops.h:49 [inline]
>   gfs2_log_flush+0x9ba/0x1050 fs/gfs2/log.c:1108
>   gfs2_sync_fs+0x3c/0x50 fs/gfs2/super.c:644
>   sync_fs_one_sb+0x40/0x50 fs/sync.c:81
>   iterate_supers+0xa7/0x130 fs/super.c:695
>   ksys_sync+0x60/0xc0 fs/sync.c:116
>   __do_sys_sync+0xa/0x10 fs/sync.c:125
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x200008ca
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 98 4a 2a e9 2c b8 b6 4c 0f 05 <bf> 00
> 00 40 00 c4 a3 7b f0 c5 01 41 e2 e9 c4 22 e9 aa bb 3c 00 00
> RSP: 002b:00007f72d08c7ba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200008ca
> RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
> RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
> R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
> R13: 000000000000000c R14: 000000000000000d R15: 00007ffe4f7c7800
> 
Hi,

This is a long-standing problem we've known about for years, and there
has been a long-standing discussion about it. I've made some attempts to
fix it, but none have been satisfactory. Some people in the upstream
community insist there should be a 1:1 correspondence between inodes
and address spaces (which is the root of the problem), but there seems
to be no documentation to back that up. What we do know well is this
scenario, which does indeed make that assumption. While we ponder the
problem, it seems to cause no harm unless you have lockdep set, so it's
never been our highest priority to fix.

Regards,

Bob Peterson
GFS2 File System

