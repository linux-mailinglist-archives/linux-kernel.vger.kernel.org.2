Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3498382C81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhEQMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhEQMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:47:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD24C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:46:25 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id z1so2985063qvo.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=US7LpJWCwtTmFe0Y8kLTeXtbSfCIEwq3UZFrYiM9u4c=;
        b=SxM/7RVHpba+L5Xt5BhFbsOC3V88HhUnMKoyePQGE6WaILJzZDs+jWlR7fhVDQ5XoR
         B9cWducwqElS89loGL8jnaLV88WhUg1mcik87unj2Zk1abJFRr1v70rv5senetfLqJjW
         MJIYokWCm/v8sQldUk0uExPs8VQHs2hi53wxXAedDRZ/yDaosI96UTWsk7CZHeWRdYz8
         OeuEO0EGu5TJSKVG+IO8bhzp6ZMi6N5CJI1BjV/JKHo8OZlDGJFi7abdDlbLfb3HfKLY
         8rGTLw+ZYed+2hcAJTTBVwkCmUgOcPumTd8uJOF7CMXLqfNZQT3YufAAedU6ctJ0kB/v
         wE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US7LpJWCwtTmFe0Y8kLTeXtbSfCIEwq3UZFrYiM9u4c=;
        b=mu2fhsVf+xxOZV2Juhkga3+Hq+LqIdvCbHRy7k49zNLgYiVCXjsUYiwLvQgiSOPJUM
         k/fzLdUr+bOb1jIja58qHoA0Q2OtIfvvFzOQsf/j+BXG4aCj219KDNg30jlwjnb7kcAg
         fQYvLmqBoOCZsdkreWWkSnV0h2YHZ1HQeQeya7wvcXN6SEULIxhVvW/itXeTGDlnblJQ
         F39gDNljyztSIW30EmG5apC158PuacRu3kztQCcnlFI2sYUUYvHwrmQ/PijgLteDbfCa
         SBbioUdEf0HX/OKF+1fSnIwPp9MlqUFoL1lJ8+RP4491xptc4wOxa4aGzhAxomsgtaIb
         WMvQ==
X-Gm-Message-State: AOAM530UXE1t3xAbqe67ag8wpacaUSLCfBhc6AROkCuUu/0rzYha3fCi
        TfKU5imtWXYvl0kZfvly9Y2rNDXKecy4wTYxlxmezg==
X-Google-Smtp-Source: ABdhPJytLMaCWze97hp4sqs2640skpJNc9pqDB3xaTeoD8HOdx//AFSEpd4TYu6tRlbapl/3Thh/UDKpTCU/BJkFYVw=
X-Received: by 2002:a05:6214:1705:: with SMTP id db5mr19714811qvb.13.1621255584959;
 Mon, 17 May 2021 05:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b3d89a05c284718f@google.com> <YKJTNcpqVN6gNIHV@hirez.programming.kicks-ass.net>
In-Reply-To: <YKJTNcpqVN6gNIHV@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 14:46:13 +0200
Message-ID: <CACT4Y+bucS5_6=rcEEpe+t8p_m3PQVzU5U+u+++ZSVG8E9zzmg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __perf_install_in_context
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     syzbot <syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        andrii@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        kpsingh@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 1:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 17, 2021 at 03:56:22AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    18a3c5f7 Merge tag 'for_linus' of git://git.kernel.org/pub..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1662c153d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b8ac1fe5995f69d7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0fb24f56fa707081e4f2
> > userspace arch: riscv64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 8643 at kernel/events/core.c:2781 __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
> > Modules linked in:
> > CPU: 1 PID: 8643 Comm: syz-executor.0 Not tainted 5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
> > Hardware name: riscv-virtio,qemu (DT)
>
> How serious should I take this thing? ARM64 and x86_64 don't show these
> errors.

+riscv mainters for this question
Is perf on riscv considered stable?
