Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF97438FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJYHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 03:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhJYHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 03:03:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFEC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:01:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e138so12311672ybc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hr7GZHPs5kzgI3NKND9VqbT5+Q1RiKFimhwymV7wts=;
        b=Fx2zbcmzJ61i+jjoue5TCxEFkDxSrugchN3epwCFp/UAFW7ncNGVU9ZKDsnUFh1SJx
         eLEMXgjUksFoKXZITuB9O3rIm1SPVLjfxm5UzrTyB1XD4gcjPde1id86QbPp1BqNa9tE
         2HWFK4OZ24bXwz1g9yCmnmhejDfPEyzcJLC0U+mCGlJr399uRE8DAm9+HLgphl/HLggZ
         OtTMchlAqJHB6CEQJPMEIdWLSDxatnbnbcaGQn77Ff331BfOBnzloPQS88kl6bXKd3So
         QElDZQdHbMEyBeD7NdH4u6txSeC/pgzgI6zNDBvPer3UxiJwXglh//7jl3Xkp2famT1Z
         sVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hr7GZHPs5kzgI3NKND9VqbT5+Q1RiKFimhwymV7wts=;
        b=sIe27arpA9t1397sCYeQCLtyNxexFglpTqBFJizhVE1eN7W9wbxq0tw/IZDDw5R5Yr
         NZqRKtlhB348z+bzJR/H9IgFtw/zOw8nDZd9Ty0ZSqU4Kd7Y3vKshvrCLFANjIlQhrzW
         u/DhN+WacKOPR7IkkUIpF3a8kUaDCaNUrMH7aRXgxzqONaS11Y/erSO4PZn+YHr1uAtP
         SR9X0tN6YZmYIjGZs6XpaNmI0izxJaHvmD5cNWffL5+BSpffxiXoRoPshZ6gpJNMxfhJ
         hgTKc3IDRYtTpN/yF6AiliMcn3D3MddlhEgH0T8uzwNw2/JNLvkuNq1U6IJpILR8+yPu
         Cl9A==
X-Gm-Message-State: AOAM530wdlg77bd75bVU8Fg/MafM75X369DnKv0Y4K6/buat2UCH5IfD
        YPl4N2dmcqvZA62K72WNf5rscl1NjA+NivW2tuVD6XVqenICJIcr
X-Google-Smtp-Source: ABdhPJzBK3nS9K7viqiTyaV7ImQNOx35R0A1tIiOOvb1huTDlpOVVAv34/stl7A+i2OZPIA4FE9QTjqIIKul1eXXvk8=
X-Received: by 2002:a9d:3c3:: with SMTP id f61mr12160302otf.196.1635144962084;
 Sun, 24 Oct 2021 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b3586105cf0ff45e@google.com> <YXX3e1i/f2uvMDm0@B-P7TQMD6M-0146.local>
In-Reply-To: <YXX3e1i/f2uvMDm0@B-P7TQMD6M-0146.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Oct 2021 08:55:51 +0200
Message-ID: <CACT4Y+bV-Fe+nX2pWf2+M0mwvQYM394uAAo2efdDqnvCWxyxKA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in z_erofs_lz4_decompress
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     syzbot <syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com>,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 02:17, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi,
>
> On Sat, Oct 23, 2021 at 07:25:20PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    60e8840126bd Add linux-next specific files for 20211018
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=125932af300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4bd44cafcda7632e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d8aaffc3719597e8cfb4
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com
> >
> > erofs: (device loop4): z_erofs_lz4_decompress_mem: failed to decompress -4100 in[4096, 0] out[9000]
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:227 [inline]
> > WARNING: CPU: 1 PID: 9895 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
>
> If you fuzz compressed data, that is what you'd expect..

Hi Gao,

If you mean this is not a kernel bug, then the code should not use WARN.
WARN if for kernel bugs and is recognized as such by all testing
systems and humans.

Please fix it to use pr_err. If it's intended for the end user, pr_err
can also give a meaningful message and no stack trace (which is I
assume only huge clutter in this case).


> Thanks,
> Gao Xiang
>
> > Modules linked in:
> > CPU: 1 PID: 9895 Comm: kworker/u5:3 Not tainted 5.15.0-rc5-next-20211018-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: erofs_unzipd z_erofs_decompressqueue_work
> > RIP: 0010:z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:230 [inline]
> > RIP: 0010:z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
> > Code: e9 03 80 3c 11 00 0f 85 8c 0a 00 00 41 56 48 8b 7d 00 45 89 e9 89 d9 48 c7 c2 20 eb fb 89 48 c7 c6 40 ed fb 89 e8 ee 5d 85 05 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 08 5f 48 89 ca 48
> > RSP: 0018:ffffc90001b3f718 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: ffffffffffffeffc RCX: 0000000000000000
> > RDX: ffff8880795b3a00 RSI: ffffffff815ef308 RDI: fffff52000367ed3
> > RBP: ffffc90001b3f858 R08: 0000000000000063 R09: 0000000000000000
> > R10: ffffffff815e90de R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000002328 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2ef25000 CR3: 000000002b3f7000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  z_erofs_decompress_pcluster.isra.0+0x1389/0x2450 fs/erofs/zdata.c:977
> >  z_erofs_decompress_queue fs/erofs/zdata.c:1055 [inline]
> >  z_erofs_decompressqueue_work+0xe0/0x170 fs/erofs/zdata.c:1066
> >  process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
> >  worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
> >  kthread+0x405/0x4f0 kernel/kthread.c:327
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
