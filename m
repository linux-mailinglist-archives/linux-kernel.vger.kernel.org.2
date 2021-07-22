Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DBA3D234A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhGVLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhGVLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626956646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PNUMBIoKiTHP4boPOQZVF1stCUzaAWoNvFJ+6lFEdSY=;
        b=hmAdy7l/H1tlkorivEQNFrtV1V3fh/QETJmvOO9pfPfMgwVkFg1Q0bPf11PQIJuIHEdrEm
        KAoniVMyquq5ADsxjIj0aJMnBDTxRe0/8YdY4favpBEVGEIDBFGz4QYRRtktQSHdvtF0pq
        CVQl9lsyitfpPdX4qDJe5LD7b/BQohg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-VWoFs3HlMwi1pjdXpSzqxQ-1; Thu, 22 Jul 2021 08:24:02 -0400
X-MC-Unique: VWoFs3HlMwi1pjdXpSzqxQ-1
Received: by mail-io1-f69.google.com with SMTP id h7-20020a6bb7070000b0290525efa1b760so3877361iof.16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PNUMBIoKiTHP4boPOQZVF1stCUzaAWoNvFJ+6lFEdSY=;
        b=L7kJYATHRvoGFMsuv7+pddIdj+4bz47W+LnQ8dBhCDPjhxBdcs6lzrrF8IY23anYQC
         zEZdW89J6JNdUYRZzPEQSuquWT9UqUSZpzMn26QIkMUGkrThGbswnuewIaYhgqi0kfEJ
         UuH30x6adrimx/8zjFbE51SoEsTlH0nvpL9cyI3AbqtfKqm8pN6260oDaL/GJLm1/g7v
         thVYp8hrpOFQUe4o4t1vgq6Kqp7AAslam7GjJnpL4NxOZf9TYpen0rNuvIw2UwMQaOXn
         YOT9nKon2LjZHzIykme6whH23k+r6vlCoXAHA2K7/vXKYG4EDMhOgDc/3mBaLgWjUepl
         fbSA==
X-Gm-Message-State: AOAM530mdi9AMiLuJj8aCK/Sn6VE+MqSsszPfSXYyDgeDitJxOuZ1Toz
        plExgzBS4AbIlY8Tm0Ho8JAjTqgkYdHoes+q4ElGE1J3NWo9q1zYeJRTz7BcLzAsrDVpa9MC/s0
        d/kgEFFRjeuVHBgWHIE+t1YPT
X-Received: by 2002:a5e:d918:: with SMTP id n24mr7463888iop.173.1626956642221;
        Thu, 22 Jul 2021 05:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVBSy8WCEdHA3cqvPmllOZN4/0DCHIGKfFVrYEtJSBF5pcKElQxtnVJNiyCCpLyKCpo0yjKw==
X-Received: by 2002:a5e:d918:: with SMTP id n24mr7463877iop.173.1626956642062;
        Thu, 22 Jul 2021 05:24:02 -0700 (PDT)
Received: from [172.16.0.19] (209-212-39-192.brainerd.net. [209.212.39.192])
        by smtp.gmail.com with ESMTPSA id m1sm16298446iok.33.2021.07.22.05.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 05:24:01 -0700 (PDT)
Subject: Re: [syzbot] WARNING in __set_page_dirty
To:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
References: <000000000000b25bb805c798a1a5@google.com>
 <20210721145801.8ca097bc1d9ad3d0018517bd@linux-foundation.org>
From:   Bob Peterson <rpeterso@redhat.com>
Message-ID: <79cd82dd-2aab-6a9a-8981-17c0b7787f5f@redhat.com>
Date:   Thu, 22 Jul 2021 07:24:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721145801.8ca097bc1d9ad3d0018517bd@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 4:58 PM, Andrew Morton wrote:
> (cc gfs2 maintainers)
>
> On Tue, 20 Jul 2021 19:07:25 -0700 syzbot <syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d936eb238744 Revert "Makefile: Enable -Wimplicit-fallthrou..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1512834a300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b998c1afc13578
>> dashboard link: https://syzkaller.appspot.com/bug?extid=0d5b462a6f07447991b3
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+0d5b462a6f07447991b3@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 inode_to_wb include/linux/backing-dev.h:283 [inline]
>> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 account_page_dirtied mm/page-writeback.c:2435 [inline]
>> WARNING: CPU: 0 PID: 8696 at include/linux/backing-dev.h:283 __set_page_dirty+0xace/0x1070 mm/page-writeback.c:2483
>> Modules linked in:
>> CPU: 0 PID: 8696 Comm: syz-executor.0 Not tainted 5.14.0-rc1-syzkaller #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
>> RIP: 0010:inode_to_wb include/linux/backing-dev.h:283 [inline]
>> RIP: 0010:account_page_dirtied mm/page-writeback.c:2435 [inline]
>> RIP: 0010:__set_page_dirty+0xace/0x1070 mm/page-writeback.c:2483
>> Code: a8 01 00 00 be ff ff ff ff 48 8d 78 70 e8 0a bf 8c 07 31 ff 89 c3 89 c6 e8 3f af d8 ff 85 db 0f 85 ac f7 ff ff e8 f2 a7 d8 ff <0f> 0b e9 a0 f7 ff ff e8 e6 a7 d8 ff 4c 8d 75 08 48 b8 00 00 00 00
>> RSP: 0000:ffffc90000e578a0 EFLAGS: 00010093
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: ffff888013d71c40 RSI: ffffffff819cdfce RDI: 0000000000000003
>> RBP: ffffea0001de0240 R08: 0000000000000000 R09: ffff888019819e07
>> R10: ffffffff819cdfc1 R11: 0000000000000000 R12: 0000000000000293
>> R13: ffff888078a38c90 R14: ffff888019819e00 R15: ffff888019819c58
>> FS:  0000000000000000(0000) GS:ffff88802ca00000(0063) knlGS:0000000009b20380
>> CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
>> CR2: 00007fd805161390 CR3: 000000004c16a000 CR4: 0000000000150ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   mark_buffer_dirty+0x49a/0x5e0 fs/buffer.c:1108
>>   gfs2_unpin+0x123/0xd10 fs/gfs2/lops.c:111
>>   buf_lo_after_commit+0x140/0x210 fs/gfs2/lops.c:750
>>   lops_after_commit fs/gfs2/lops.h:49 [inline]
>>   gfs2_log_flush+0x162b/0x2940 fs/gfs2/log.c:1108
>>   do_sync+0x5ab/0xcd0 fs/gfs2/quota.c:967
>>   gfs2_quota_sync+0x2e2/0x660 fs/gfs2/quota.c:1310
>>   gfs2_sync_fs+0x40/0xb0 fs/gfs2/super.c:711
>>   __sync_filesystem fs/sync.c:39 [inline]
> Seems that gfs2_unpin() is running mark_buffer_dirty() against a bh
> which is attached to a non-upto-date page.
>
Hmm. That mark_buffer_dirty has been there since 2007, so this will 
require some analysis.
A reproducer would be helpful, since we've never seen this before.

Bob Peterson


