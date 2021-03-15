Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B724233AD7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCOIcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:32:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:50688 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCOIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:31:25 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLidD-000G6o-WC; Mon, 15 Mar 2021 09:31:20 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLidD-000FZ1-Qu; Mon, 15 Mar 2021 09:31:19 +0100
Subject: Re: [PATCH v2] bpf: Fix memory leak in copy_process()
To:     qiang.zhang@windriver.com, ast@kernel.org, andrii@kernel.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
References: <20210315081847.16180-1-qiang.zhang@windriver.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc15c3e3-2892-c285-13cd-1356bdce8f59@iogearbox.net>
Date:   Mon, 15 Mar 2021 09:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210315081847.16180-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26108/Sun Mar 14 13:05:46 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 9:18 AM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>

Hello Zqiang, please resend this patch with bpf@vger.kernel.org in Cc, so it
actually reaches the rest of BPF community for review, thanks!

> The syzbot report a memleak follow:
> BUG: memory leak
> unreferenced object 0xffff888101b41d00 (size 120):
>    comm "kworker/u4:0", pid 8, jiffies 4294944270 (age 12.780s)
>    backtrace:
>      [<ffffffff8125dc56>] alloc_pid+0x66/0x560
>      [<ffffffff81226405>] copy_process+0x1465/0x25e0
>      [<ffffffff81227943>] kernel_clone+0xf3/0x670
>      [<ffffffff812281a1>] kernel_thread+0x61/0x80
>      [<ffffffff81253464>] call_usermodehelper_exec_work
>      [<ffffffff81253464>] call_usermodehelper_exec_work+0xc4/0x120
>      [<ffffffff812591c9>] process_one_work+0x2c9/0x600
>      [<ffffffff81259ab9>] worker_thread+0x59/0x5d0
>      [<ffffffff812611c8>] kthread+0x178/0x1b0
>      [<ffffffff8100227f>] ret_from_fork+0x1f/0x30
> 
> unreferenced object 0xffff888110ef5c00 (size 232):
>    comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
>    backtrace:
>      [<ffffffff8154a0cf>] kmem_cache_zalloc
>      [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0
>      [<ffffffff8154a809>] alloc_empty_file+0x69/0x120
>      [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0
>      [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140
>      [<ffffffff81559218>] create_pipe_files+0x138/0x2e0
>      [<ffffffff8126c793>] umd_setup+0x33/0x220
>      [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0
>      [<ffffffff8100227f>] ret_from_fork+0x1f/0x30
> 
> after the UMD process exits, the pipe_to_umh/pipe_from_umh and tgid
> need to be release.
> 
> Fixes: d71fa5c9763c ("bpf: Add kernel module with user mode driver that populates bpffs.")
> Reported-by: syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>   v1->v2:
>   Judge whether the pointer variable tgid is valid.
