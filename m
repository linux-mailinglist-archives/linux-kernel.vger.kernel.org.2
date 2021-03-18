Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366DB3407FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhCROe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhCROem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:34:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E9FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:34:42 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t4so2192218qkp.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9P1ao6toWArEDXhVPzBQlm+hipiV6rECWCdZqkLfmg=;
        b=Mb4zlDV5nxx6ZzQmQoL6InxaNiD6vsznXLAVzWpxsIp9+9+37xvHuAoBJ22jsSgGff
         kSgLBPW9GDLhV/eVGtwgJlAFQhijc65S/yjqMo5DiLlrfKnZI6bLZrGqW+zAELg739zq
         UizI4xGjr+zCwNw/6/QyNcTjoVQ+dq3cDRtVInOBvdqMJ3RsBVGk5WudeLRphwc5H7yB
         fgpEJ8NRMyY16V/sNzsd8jz7OJ30DNAFRYcZCOrQJ9BOQYTgf5qzT31evbJUGrDzD+NP
         zQCdU8RV5VB21IV0uEw2qHh1Dg7RdiN1poEJkV5PqOVMUHoLw91e3j5Chx3ucb1z3aSC
         ouvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9P1ao6toWArEDXhVPzBQlm+hipiV6rECWCdZqkLfmg=;
        b=Q/bHV7+/NBzaBCkz8M9Bl6gzm9V+iFHnizfvwkh4io0g51S3V5wqq1mb9t9E6WqzVs
         abpBIV/j+0PqQF+zGWNKJs0mRh1Rf7jkpYQ2A7U998uQDjF/NuoUPzocNC2OswU3HNSo
         kRLveFqHP8V2tezYgxGiAQEu8pRftC8cCBS1ZbfmO4DKQjEGQFR5dICyNCUxfrfuy4nu
         Gq8xGTipBHaYFuMjpaddrIi8c7w7Nkl9PPUqz8W+giVE7vagYPF8pGafuEjJ5Z71rgtq
         W6ZdHSGYEYh4WakPjaQ9J37kjvNlWCufw1qLLtNmXCd3hvxtcUbNPfgoYNcyPiU2ddXl
         O16A==
X-Gm-Message-State: AOAM533whmlWw0j9YG52686EabWM164Hv/MKr8dFb7Mb947PevHTp0kN
        0aYNunoCoITdDCa0FlHb1ojVOx4/GEqTiVWu4Q7yDQ==
X-Google-Smtp-Source: ABdhPJzEyx6+HFdVSkLJJ6i06IJ87zYMxAGqhNO0hQ7jyzt4zIjjJrJNYktNaCPrI7oCtxf7JgaiwdxuM6mVl4749nU=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr4661018qko.424.1616078081595;
 Thu, 18 Mar 2021 07:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk> <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <795597a1-ec87-e09e-d073-3daf10422abb@ghiti.fr> <f9318e58-5d3f-f548-3dbf-a5cb87406a94@codethink.co.uk>
 <CACT4Y+bYDU-4MYotLfqgkGpz487aC8xQ0dqaNLwf76d1yyF-Vw@mail.gmail.com> <a0449f4a-4d54-6f38-1bc3-7c5170d24b86@codethink.co.uk>
In-Reply-To: <a0449f4a-4d54-6f38-1bc3-7c5170d24b86@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 15:34:29 +0100
Message-ID: <CACT4Y+aEAs2zrTY453mK2UgtaG=-eOyXyWU0PBSybmP+sc809A@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 5:55 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > On Fri, Mar 12, 2021 at 9:12 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> >>> Still no luck for the moment, can't reproduce it locally, my test is
> >>> maybe not that good (I created threads all day long in order to trigger
> >>> the put_user of schedule_tail).
> >>
> >> It may of course depend on memory and other stuff. I did try to see if
> >> it was possible to clone() with the child_tid address being a valid but
> >> not mapped page...
> >>
> >>> Given that the path you mention works most of the time, and that the
> >>> status register in the stack trace shows the SUM bit is not set whereas
> >>> it is set in put_user, I'm leaning toward some race condition (maybe an
> >>> interrupt that arrives at the "wrong" time) or a qemu issue as you
> >>> mentioned.
> >>
> >> I suppose this is possible. From what I read it should get to the
> >> point of being there with the SUM flag cleared, so either something
> >> went wrong in trying to fix the instruction up or there's some other
> >> error we're missing.
> >>
> >>> To eliminate qemu issues, do you have access to some HW ? Or to
> >>> different qemu versions ?
> >>
> >> I do have access to a Microchip Polarfire board. I just need the
> >> instructions on how to setup the test-code to make it work on the
> >> hardware.
> >
> > For full syzkaller support, it would need to know how to reboot these
> > boards and get access to the console.
> > syzkaller has a stop-gap VM backend which just uses ssh to a physical
> > machine and expects the kernel to reboot on its own after any crashes.
> >
> > But I actually managed to reproduce it in an even simpler setup.
> > Assuming you have Go 1.15 and riscv64 cross-compiler gcc installed
> >
> > $ go get -u -d github.com/google/syzkaller/...
> > $ cd $GOPATH/src/github.com/google/syzkaller
> > $ make stress executor TARGETARCH=riscv64
> > $ scp bin/linux_riscv64/syz-execprog bin/linux_riscv64/syz-executor
> > your_machine:/
> >
> > Then run ./syz-stress on the machine.
> > On the first run it crashed it with some other bug, on the second run
> > I got the crash in schedule_tail.
> > With qemu tcg I also added -slowdown=10 flag to syz-stress to scale
> > all timeouts, if native execution is faster, then you don't need it.
>
> I have built the tools and got it to start.
>
> It would be helpful for the dashboard to give the qemu version and
> how it was launched (memory, cpus etc)

Hi Ben,

syzbot will show info about qemu version/args in "VM info" column then
this commit is deployed (should happen by tomorrow);
https://github.com/google/syzkaller/commit/4a3131941837f1fab321bcdfcac13ac4fb480684
