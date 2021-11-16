Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7BB452913
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbhKPEU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245635AbhKPEUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:20:22 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D35C200E6C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:13:15 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id l19so18639740ilk.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RylitkTtnBHc/Lo8gM0trwtbuaJL6rG5rKwCgLIAZE=;
        b=GgkuvFc7y5u16M9Tf9hD6iE7JLwnvhiZGpRHrmBZn2AYkMs4PdA69bg34XN6bG+Twh
         ugPsT+vThoA5y5QgRBt82R9szKSBZIblNbVDt1Ib138qL30JNgOPVZB2Jl4AR3dleunI
         eenShhNMA5uHx00GX6iLVR2OxL3UhTJsMDLn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RylitkTtnBHc/Lo8gM0trwtbuaJL6rG5rKwCgLIAZE=;
        b=E4nL0gFtg/+Sam80Li2g/07sttZieDHp21pnXvnrik0ujnyGCjgRaDY8+rbv07MSaP
         RyIDUsFWo8QPICT6S+5ZkBroc/5tW1jLODThW4FsFmQKJHOFWoJc67KxHauVMXaq1O0f
         cPm4qZiL/HTkwlLVwIRVSEtuP31Btfv3AdaOTLmzZw51wRgQhwB8JWBi8HO+u/+POwY0
         iZwkNp7ZGWK8qs3spGwwfiEhKYZBzE4Qx6JQSRxDPjP7FIqViYDqbNK6eYzYQytJFUFE
         w1ZDNq/RjwA0++8+ci6wFIe/x0vmj69OAUab2H/Td9wpK3oZFtSJS+UB6m0cp5hpxBmc
         vmZg==
X-Gm-Message-State: AOAM532372pNwSDw1wSI2UUrx6IruzF+XDFh4zDN9GXqHHaLBMVinhB+
        Zba2Dasi1FGvS1XCJ/5HyLQd9WkV58s+EQ==
X-Google-Smtp-Source: ABdhPJyq5TZgV6wOOlFLgrUVfDNj8loezoKV4G8+ZROzNga7I+fVJ6aE6MfxpRiLkEoe8+caEW/zng==
X-Received: by 2002:a05:6e02:1487:: with SMTP id n7mr1937029ilk.252.1637025194594;
        Mon, 15 Nov 2021 17:13:14 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id ay13sm4743731iob.37.2021.11.15.17.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 17:13:14 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id m9so23979463iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 17:13:14 -0800 (PST)
X-Received: by 2002:a05:6638:190f:: with SMTP id p15mr2378516jal.82.1637025193783;
 Mon, 15 Nov 2021 17:13:13 -0800 (PST)
MIME-Version: 1.0
References: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
In-Reply-To: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Nov 2021 17:13:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X35OW+YRvspk=M-W+qcLObCxzGc7dJsvAZSXSyCZsv1Q@mail.gmail.com>
Message-ID: <CAD=FV=X35OW+YRvspk=M-W+qcLObCxzGc7dJsvAZSXSyCZsv1Q@mail.gmail.com>
Subject: Re: RT_GROUP_SCHED throttling blocks unthrottled RT tasks?
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 5, 2021 at 10:44 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> I'm seeing a strange behavior that I _think_ is a bug. I'm hoping that
> some of the scheduling experts can tell me if I'm just
> misunderstanding or if this is truly a bug. To see it, I do this:
>
> --
>
> # Allow 1000 us more of RT at system and top cgroup
> old_rt=$(cat /proc/sys/kernel/sched_rt_runtime_us)
> echo $((old_rt + 1000)) > /proc/sys/kernel/sched_rt_runtime_us
> old_rt=$(cat /sys/fs/cgroup/cpu/cpu.rt_runtime_us)
> echo $((old_rt + 1000)) > /sys/fs/cgroup/cpu/cpu.rt_runtime_us
>
> # Give the 1000 us to my own group
> mkdir /sys/fs/cgroup/cpu/doug
> echo 1000 > /sys/fs/cgroup/cpu/doug/cpu.rt_runtime_us
>
> # Fork off a bunch of spinny things
> for i in $(seq 13); do
>   python -c "while True: pass"&
> done
>
> # Make my spinny things RT and put in my group
> # (assumes no other python is running!)
> for pid in $(ps aux | grep python | grep -v grep | awk '{print $2}'); do
>   echo $pid >> /sys/fs/cgroup/cpu/doug/tasks
>   chrt -p -f 99 $pid
> done
>
> --
>
> As expected, the spinny python tasks are pretty much throttled down to
> 0 in the above (they get 1 ms out of 1 second).
>
> However, _the bug_ is that the above basically causes all _other_ RT
> things in my system to stop functioning. I'm on an ARM Chromebook
> (sc7180-trogdor) and we communicate to our EC on a "realtime" thread
> due to SPI timing requirements. The above commands appear to starve
> the EC's communication task and (as far as I can tell) other RT tasks
> in the system.
>
> Notably:
>
> a) My EC comms slow to a crawl (eventually one gets through).
>
> b) "top" shows stuff like this:
>
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
> COMMAND
>   179 root     -51   0       0      0      0 R 100.0   0.0   0:31.79
> cros_ec_spi_hig
>   180 root     -51   0       0      0      0 R  95.2   0.0   0:50.19
> irq/169-chromeo
>   184 root     -51   0       0      0      0 R  95.2   0.0   0:13.24
> spi10
>   221 root      -2   0       0      0      0 R  95.2   0.0   0:50.57
> ring0
>
> c) If I give my spinny tasks just a little bit more time than 1 ms
> then I get a hung task.
>
>
> When I'm testing the above, the non-RT stuff in the system continues
> to work OK though. I can even go in and kill all my python tasks and
> the system returns to normal.
>
> I tried gathering some tracing. One bit that might (?) be relevant:
>
>  cros_ec_spi_hig-179     [000] d.h5  1495.305919: sched_waking:
> comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
>  cros_ec_spi_hig-179     [000] d.h6  1495.305926: sched_wakeup:
> comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
>           <idle>-0       [001] d.H5  1495.309113: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H6  1495.309119: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h5  1495.309336: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h6  1495.309341: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H5  1495.312137: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>           <idle>-0       [001] d.H6  1495.312142: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h5  1495.312859: sched_waking:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>  cros_ec_spi_hig-179     [000] d.h6  1495.312870: sched_wakeup:
> comm=sugov:6 pid=2658 prio=-1 target_cpu=006
>
> My best guess is that there's some bug in the scheduler where it just
> loops constantly picking an unthrottled RT task but then incorrectly
> decides that it's throttled and thus doesn't run it.
>
> Most of my testing has been on the chromeos-5.4 kernel, but just in
> case I tried a vanilla v5.15 kernel and I could reproduce the same
> problems.
>
>
> Anyway, if I'm just doing something stupid then I appologize of the
> noise. If the above should work and you need me to gather more logging
> / try any experiments, I'm happy to do so.

I spent a little more time here and:

a) Managed to come up with a test case that makes it easy for anyone
to reproduce the problem themselves.

b) Managed to come up with a short patch that "fixes" this problem for me.

Since I had a potential fix, I posted this as a patch. Maybe we can
move the discussion to my post of that patch, which will hopefully
show up at:

https://lore.kernel.org/r/20211115170241.1.I94825a614577505bd1a8be9aeff208a49cb39b3d@changeid

...oddly that patch isn't showing up (?). It should be "[PATCH]
sched/rt: Don't reschedule a throttled task even if it's higher
priority". If it's not there tomorrow, I can try to repost again.

-Doug
