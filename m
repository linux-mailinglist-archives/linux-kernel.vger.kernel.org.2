Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90320383A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhEQQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245697AbhEQQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:39:13 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87382C09C124
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:43:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t7so5153157qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpwxqREUy7ZeE/q9KBgH9prhaRfEbTg15gcbCdch4sk=;
        b=wPcyIQdb6L6RNeArvXK/uwluH0pzcyAL8Aqij4tYmSicv0ugqA8kc0c1vkWlRSw9HD
         kQwp//GzznxbjURrATi75vC8qO9PjX6OCjthLjKsnydVNqxEqf3e+1cTKKHoRDGcGWPv
         fOzmIzfFrxp6gvyq0RAuobhupEv0R4/q6Oaai7QIFe4V1lcc1P/Q6pHE11LChac3HMdF
         yda4N2qFUv/CphPoic4G30/bY3uUYJzwAM6zmoCUj8syPdlpefxsFB/2Me74BEa9WIQO
         MMedIHxaxrpX6l076PK4OiNtA3hGmU1Cn6TXp2NRq6FY1wvU30gUANfMZjE8UKa2by1Z
         6m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpwxqREUy7ZeE/q9KBgH9prhaRfEbTg15gcbCdch4sk=;
        b=kIuMtJqAlZFz6bjk3wHu0U/uh/pqSWzOrFsI7AWzSt6Mv8nXANfst5EO3JjoacGv1e
         4kvm3XzstnLJDthWtNigoPYWG1ELmMK+X0DTT6hb+DjRTyffpenhpNwXlpQNI7LGSDgo
         7zvXfvDXOLs0+S2ne8UYIC2M6ZBR9LfNxoiOvN3PO5B4Rkg7vsaqv8Nlhf+ddEyM0x5b
         LYNNqMteH9rvYvP+8qsFSt+x7mph7H8LGKT1vBDA/0LIrNuxrKbTNEp4g7ctUxp/B5MP
         b0hJDQpRpgJNMReVCUJ672mg/izDjJUnEp33hUs7MnYXWncBrgY7yvc8eEZ0UIYuiEvO
         WNYA==
X-Gm-Message-State: AOAM5336A4O6n2UFaAMo30a9Es1F7WR5KdxrM4QUb66DR/Lw9vXcl39d
        0jQbydhyc/Oi27tgHXdStkp9eVNoWTSnLyjo6l6vDw==
X-Google-Smtp-Source: ABdhPJz4M51L12IN2jSsEKmY7vORLRZl8ZEZji/O7ODhRvj5zpW2uVnQHLDOpExGgw04gxs51m8VSuLlvKUEDrdbq4A=
X-Received: by 2002:ac8:518a:: with SMTP id c10mr162925qtn.66.1621266213535;
 Mon, 17 May 2021 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b3d89a05c284718f@google.com> <YKJTNcpqVN6gNIHV@hirez.programming.kicks-ass.net>
 <CACT4Y+bucS5_6=rcEEpe+t8p_m3PQVzU5U+u+++ZSVG8E9zzmg@mail.gmail.com>
In-Reply-To: <CACT4Y+bucS5_6=rcEEpe+t8p_m3PQVzU5U+u+++ZSVG8E9zzmg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 17:43:22 +0200
Message-ID: <CACT4Y+Z8VjfOU=eR-ijhkXJJuZLM4NC+ui5ce0R=OH6WVWwB1w@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __perf_install_in_context
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>
Cc:     syzbot <syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Mon, May 17, 2021 at 2:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, May 17, 2021 at 1:28 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 17, 2021 at 03:56:22AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    18a3c5f7 Merge tag 'for_linus' of git://git.kernel.org/pub..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1662c153d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b8ac1fe5995f69d7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0fb24f56fa707081e4f2
> > > userspace arch: riscv64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0fb24f56fa707081e4f2@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 8643 at kernel/events/core.c:2781 __perf_install_in_context+0x1c0/0x47c kernel/events/core.c:2781
> > > Modules linked in:
> > > CPU: 1 PID: 8643 Comm: syz-executor.0 Not tainted 5.12.0-rc8-syzkaller-00011-g18a3c5f7abfd #0
> > > Hardware name: riscv-virtio,qemu (DT)
> >
> > How serious should I take this thing? ARM64 and x86_64 don't show these
> > errors.
>
> +riscv mainters for this question
> Is perf on riscv considered stable?

Another perf/riscv64 warning just come in:
https://syzkaller.appspot.com/bug?extid=30189c98403be62bc05a
