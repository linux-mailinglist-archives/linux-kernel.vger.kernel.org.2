Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83316446809
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhKERrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhKERrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:47:15 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:44:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z206so11675172iof.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BAvTYlN34MwtLZhoSfou7Oo61tqPXkuuD65bRBYs5xM=;
        b=hfIG4b12lIL/jMqoa1lJ0GKa0rN1v5lWhtQM1UbqL9TTXcjNhtO11CqonGudsXOQuk
         81cbka/1Y1k25Mr82gEBLTpY83kSzaLrbd2SQHAfPBqasW2fi3qGMa22ua8ZQL+XwdSD
         lk4FFZdHNblAhXoiAx0h7027O1mYiCdvlwvTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BAvTYlN34MwtLZhoSfou7Oo61tqPXkuuD65bRBYs5xM=;
        b=pusGQrJahIjkd92TWvQzi9V0ZoTD+K208Z9/KdKTzipBjfepJxrumLni0NbjcV0jaG
         saD8HaYoy3FErc4duj3+y146wn9xgBKjXgag6Cx70+3nNFyBoPHXsXqkXPXquudD4fOT
         Q6/tJahUbXtK0AfOsYepKHSmH9Wkrf7dKfcObK6Yar6Xhm1++9hwHXFt4l0sRmx/7Qyz
         IWStqwpXsMZpZmXnhOSgHfVVoFQbU0qJFUuvWFoKRl1S6hOYigw0ZtXmmxH95pc70HSZ
         yEm4Rt/R4QmIejjkpg+eXDKuw2HAdzx6B41xHL7iVNh5aWAAyetmx0UGF5xfBf7/7L7M
         0yvw==
X-Gm-Message-State: AOAM5307JFijqK1X34Q7d+iBPciOvZDZ7GQe6ouuoN0K06uzTBkyKqox
        InlTYwzozYUW6oEiIWv0ZnvCzBSUlwnWgA==
X-Google-Smtp-Source: ABdhPJw6bkoYE/ETos8mKiaiZDqub9R0yPhr9Z/27eMulr5fnOAC+6ra8INA6pFjkoijVeK6zGW5Aw==
X-Received: by 2002:a05:6602:2b89:: with SMTP id r9mr516808iov.32.1636134275004;
        Fri, 05 Nov 2021 10:44:35 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id c4sm4221982ioo.48.2021.11.05.10.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 10:44:34 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h2so10174205ili.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 10:44:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a85:: with SMTP id k5mr22708036ilv.27.1636134274312;
 Fri, 05 Nov 2021 10:44:34 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 5 Nov 2021 10:44:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
Message-ID: <CAD=FV=UKyJLhDEKxhqrit16kvLfi+g0DyYKL6bLJ35fO7NCTsg@mail.gmail.com>
Subject: RT_GROUP_SCHED throttling blocks unthrottled RT tasks?
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a strange behavior that I _think_ is a bug. I'm hoping that
some of the scheduling experts can tell me if I'm just
misunderstanding or if this is truly a bug. To see it, I do this:

--

# Allow 1000 us more of RT at system and top cgroup
old_rt=$(cat /proc/sys/kernel/sched_rt_runtime_us)
echo $((old_rt + 1000)) > /proc/sys/kernel/sched_rt_runtime_us
old_rt=$(cat /sys/fs/cgroup/cpu/cpu.rt_runtime_us)
echo $((old_rt + 1000)) > /sys/fs/cgroup/cpu/cpu.rt_runtime_us

# Give the 1000 us to my own group
mkdir /sys/fs/cgroup/cpu/doug
echo 1000 > /sys/fs/cgroup/cpu/doug/cpu.rt_runtime_us

# Fork off a bunch of spinny things
for i in $(seq 13); do
  python -c "while True: pass"&
done

# Make my spinny things RT and put in my group
# (assumes no other python is running!)
for pid in $(ps aux | grep python | grep -v grep | awk '{print $2}'); do
  echo $pid >> /sys/fs/cgroup/cpu/doug/tasks
  chrt -p -f 99 $pid
done

--

As expected, the spinny python tasks are pretty much throttled down to
0 in the above (they get 1 ms out of 1 second).

However, _the bug_ is that the above basically causes all _other_ RT
things in my system to stop functioning. I'm on an ARM Chromebook
(sc7180-trogdor) and we communicate to our EC on a "realtime" thread
due to SPI timing requirements. The above commands appear to starve
the EC's communication task and (as far as I can tell) other RT tasks
in the system.

Notably:

a) My EC comms slow to a crawl (eventually one gets through).

b) "top" shows stuff like this:

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+
COMMAND
  179 root     -51   0       0      0      0 R 100.0   0.0   0:31.79
cros_ec_spi_hig
  180 root     -51   0       0      0      0 R  95.2   0.0   0:50.19
irq/169-chromeo
  184 root     -51   0       0      0      0 R  95.2   0.0   0:13.24
spi10
  221 root      -2   0       0      0      0 R  95.2   0.0   0:50.57
ring0

c) If I give my spinny tasks just a little bit more time than 1 ms
then I get a hung task.


When I'm testing the above, the non-RT stuff in the system continues
to work OK though. I can even go in and kill all my python tasks and
the system returns to normal.

I tried gathering some tracing. One bit that might (?) be relevant:

 cros_ec_spi_hig-179     [000] d.h5  1495.305919: sched_waking:
comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
 cros_ec_spi_hig-179     [000] d.h6  1495.305926: sched_wakeup:
comm=kworker/4:2 pid=5232 prio=120 target_cpu=004
          <idle>-0       [001] d.H5  1495.309113: sched_waking:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
          <idle>-0       [001] d.H6  1495.309119: sched_wakeup:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
 cros_ec_spi_hig-179     [000] d.h5  1495.309336: sched_waking:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
 cros_ec_spi_hig-179     [000] d.h6  1495.309341: sched_wakeup:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
          <idle>-0       [001] d.H5  1495.312137: sched_waking:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
          <idle>-0       [001] d.H6  1495.312142: sched_wakeup:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
 cros_ec_spi_hig-179     [000] d.h5  1495.312859: sched_waking:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006
 cros_ec_spi_hig-179     [000] d.h6  1495.312870: sched_wakeup:
comm=sugov:6 pid=2658 prio=-1 target_cpu=006

My best guess is that there's some bug in the scheduler where it just
loops constantly picking an unthrottled RT task but then incorrectly
decides that it's throttled and thus doesn't run it.

Most of my testing has been on the chromeos-5.4 kernel, but just in
case I tried a vanilla v5.15 kernel and I could reproduce the same
problems.


Anyway, if I'm just doing something stupid then I appologize of the
noise. If the above should work and you need me to gather more logging
/ try any experiments, I'm happy to do so.

Thanks!

-Doug
