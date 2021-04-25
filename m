Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0662536A5A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 10:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDYIMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:11:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 01:11:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o16so60421066ljp.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzq9HXAbCoZF4vaOa3LxjFprwie4inewuwzkmcmmlvI=;
        b=JhrxrJCoT7Az58VSgrI2h6UqvjsXkKapMX0JYgoAGzHm7wrz0PuH/pN7ZOcScF1EQC
         eHV/9s7ppBBFpiBnTH4Ll8PZ/14wFMunhCc1bw5ilPOE/9lCMstDrjpCkIpvGoxA/I1H
         uwpzLX+/FV0j7PCUSMQA16PVSpu47ca14cMtGwQ4jF0D33I5t4gos+DTc6JUiFgNWUj7
         /I4T03qDuExLu198vruwgkBk1FI4UispF28VckwG9TDwEXb3OjbK3lLGfQNERQxA/uP2
         HHtCprrZJxfS6Y/SasMQGakHZB7BS/kglS/LyXdKrCNM2obQpybUtNFjTopQC4YdbJui
         yfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzq9HXAbCoZF4vaOa3LxjFprwie4inewuwzkmcmmlvI=;
        b=c735BkIquiU/6vf4xNJjLWElypDeapUJDi7KbO8tDSa7Y7GKQU3ZfpgvlAJUPV6Ev8
         CNQUknW4uiEoYavAdrHWe2KguvCGZ3cGWo8pGw6GBgv1YH27EQ1nQwm19OcNiEF50FLE
         ySrTJIR4f9wF0FdX32vK3ZBrTHdJEzheBrUWlx1gQJ3MH0a3Mn40/oXjviYMe2dGGKB/
         pJp4FXomfCh8zbZsTsIHMNy2zFA01hXu0sQ2c3UkAxtE02erRaAkGfLS+WapWXlu1G8J
         xZVJuJ5cTTv3T7Jyafxp5Pshb5YImgk19Q3ATYEq7MWr2oN9NSm6Sgsf+cXqUq6mUAPk
         +EGw==
X-Gm-Message-State: AOAM530thNyn43Gz5ugZFc8Zc5WsLdeFGkF7MdHo+NPXoYRVWZL8N3p7
        YA4Lo2Fwpx3ZgIWL0g3N9nxTNw==
X-Google-Smtp-Source: ABdhPJzo9MzYnGZFGtzT21UqoCIOEXqHzMVx+zkpkthEJiWRXSSHEK0yGtkbrTlauf4Z04LLgcE7zg==
X-Received: by 2002:a2e:9e84:: with SMTP id f4mr8844060ljk.151.1619338277405;
        Sun, 25 Apr 2021 01:11:17 -0700 (PDT)
Received: from localhost.localdomain (ti0005a400-2280.bb.online.no. [80.212.253.245])
        by smtp.gmail.com with ESMTPSA id a5sm1038906lfg.115.2021.04.25.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 01:11:16 -0700 (PDT)
From:   Odin Ugedal <odin@uged.al>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odin Ugedal <odin@uged.al>
Subject: [PATCH 0/1] sched/fair: Fix unfairness caused by missing load decay
Date:   Sun, 25 Apr 2021 10:09:01 +0200
Message-Id: <20210425080902.11854-1-odin@uged.al>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR: Read the patch msg first; hopefully it makes sense. Feel free
to cc more relevant people, and (as I am pretty new to this) feedback
is highly appreciated!

I thought it was smart to split the discussion of the patch and the issuse, so
here is some (wall of text, sorry) discussion around it:

This patch fixes an extremely strange edge case, discovered more or less by
accident, where the fairness of the cfs scheduler get skewed quite
extensively. This often leads to two cgroups who are supposed to get
share cpu time 50/50, instead getting something like 90/10 or
even 99/1 (!!) in some rare cases (see below for example). I find this
edge case quite interesting, especially since I am able to so easily
reproduce it on all machines and all (4.8+) kernels.

The issue can be easily reproduced on all kernels 4.8+, and afaik. most
"container runtimes" are affected. I do believe that I have wondered about
this issue earlier, but not actually understood what was causing it. There
is really (afaik.) no way to find the issue from userspace without using
a tracing tool like bpftrace. I am _sure_ this affects real production
environments _everywhere_, at least those running the normal container/using
cgroup tools together with cpu pinning; but verifying that the
fairness is skewed is quite hard, or more or less impossible in such cases,
especially when running multiple workloads simultaneously. I did inspect some
of my production servers, and found a set of this on multiple cgroups.

It _is_ possible to read '/proc/sched_debug', but since that list only prints
the cfs_rq's from "leaf_cfs_rq_list", the cfs_rq's we are _really_ looking for,
are missing; making it look like the problem isn't becuase of cfs.

I think the current patch is the best way solve the issue, but I will happily
discuss other possible solutions. One could also just "don't" propagate the
load to the task_group, but I think the current implementation on that part
is the correct way to do it. This is at least my best solution to avoid adding
logic to a "hotter" path that also would require more logic.

The only thing I am thinking a bit about is if the cfs_rq (or one of its ancestors) is
throttled. In case the cfs_rq->throttled==1, I don't think we currently can skip, since
it only adds to the leaf_list in case (cfs_rq->nr_running >= 1), and the same applies for
(cfs_rq->throttle_count >= 1), since we cannot guarantee that it will be added again. Will
this code however interfere with the throttling mechanism? I have tested inserting new procs
to throttled cgroups (or children cgroups of throttled ones) with the patch applied,
and it works as I expect it to do (but other people might have more insight). 

Also, another solution may be to don't add the load before the task is actually
enqueued, avoiding this issue all together. But is that better (I assume that will
be more in the "hot path", and require quite a bit more code)?

There may definetly be a better solution to this that I still haven't found, and that
other more experienced kernel devs see right away. :)


Also feel free to suggest additions/wording of the patch
message and title, and/or the comment in the code to make it more clear.

This issue was introduced in 4.8, so all stable (4.9+) releases should probably
get this (the final solution at least), or?



Below is various ways/scripts to reproduce - sorry this is so long (and
sorry for bash in general), but thought people might be interested in them:

note: due to the nature of the issue, the "lost" load is different each time, so
the values change each time, and sometimes/often end up at ~50/50; but my testing
shows that it keep happening almost every time:


Example on cgruoup v1. Often results in 60/40 load:
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18026 63.0  0.0   3676   100 pts/7    R+   13:09   0:06 stress --cpu 1
root       18036 36.6  0.0   3676   100 pts/7    R+   13:09   0:04 stress --cpu 1
--- bash start
CGROUP_CPU=/sys/fs/cgroup/cpu/slice
CGROUP_CPUSET=/sys/fs/cgroup/cpuset/slice
CPU=0

function run_sandbox {
  local CG_CPUSET="$1"
  local CG_CPU="$2"
  local CMD="$3"

  local PIPE="$(mktemp -u)"
  mkfifo "$PIPE"
  sh -c "read < $PIPE ; exec $CMD" &
  local TASK="$!"
  sleep .1
  mkdir -p "$CG_CPUSET"
  mkdir -p "$CG_CPU"
  tee "$CG_CPU"/cgroup.procs <<< "$TASK"

  tee "$CG_CPUSET"/cgroup.procs <<< "$TASK"

  tee "$PIPE" <<< sandox_done
  rm "$PIPE"
}

mkdir -p "$CGROUP_CPU"
mkdir -p "$CGROUP_CPUSET"
tee "$CGROUP_CPUSET"/cpuset.cpus <<< "0" 
tee "$CGROUP_CPUSET"/cpuset.mems <<< "0" 

run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-1" "stress --cpu 1"
run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-2" "stress --cpu 1"

read # click enter to cleanup
killall stress
sleep .2
rmdir /sys/fs/cgroup/cpuset/slice/
rmdir /sys/fs/cgroup/cpu/slice/{cg-1,cg-2,}
--- bash end

Example on cgroup v2 with sub cgroup (same as described in commit message),
where both should get 50/50, but instead getting 99% and 1% (!!).

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1

(in case of systemd on vg v2- make sure some slice/scope is delegated(?)/use
cpusets, otherwise systemd will fight you)
--- bash start
CGROUP_CPU=/sys/fs/cgroup/cpu/slice
CGROUP_CPUSET=/sys/fs/cgroup/cpuset/slice
CPU=0

function run_sandbox {
  local CG_CPUSET="$1"
  local CG_CPU="$2"
  local CMD="$3"

  local PIPE="$(mktemp -u)"
  mkfifo "$PIPE"
  sh -c "read < $PIPE ; exec $CMD" &
  local TASK="$!"
  sleep .01
  mkdir -p "$CG_CPUSET"
  mkdir -p "$CG_CPU"
  tee "$CG_CPU"/cgroup.procs <<< "$TASK"

  tee "$CG_CPUSET"/cgroup.procs <<< "$TASK"

  tee "$PIPE" <<< sandox_done
  rm "$PIPE"
}

mkdir -p "$CGROUP_CPU"
mkdir -p "$CGROUP_CPUSET"
tee "$CGROUP_CPUSET"/cpuset.cpus <<< "0" 
tee "$CGROUP_CPUSET"/cpuset.mems <<< "0" 

run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-1" "stress --cpu 1"
run_sandbox "$CGROUP_CPUSET" "$CGROUP_CPU/cg-2" "stress --cpu 1"

read # click enter to cleanup
killall stress
sleep .2
rmdir /sys/fs/cgroup/cpuset/slice/
rmdir /sys/fs/cgroup/cpu/slice/{cg-1,cg-2,}
--- bash end



For those who only want to run docker stuff:
(on cgroup v1, you must use systemd driver)
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        9291 60.1  0.0   7320    96 pts/0    R+   13:18   0:07 /usr/bin/stress --verbose --cpu 1
root        9388 45.5  0.0   7320    96 pts/0    R+   13:18   0:04 /usr/bin/stress --verbose --cpu 1
--- bash start
docker run --cpuset-cpus=0 --rm -it an-image-with-stress
docker run --cpuset-cpus=0 --rm -it an-image-with-stress
--- bash end


Here is a bpftrace script that can show what is happening (again. sorry for bash,
but bpftrace only allow constants as array indexes as of now, so this is the best I can do).
This script also needs bpftrace v0.13 (not released as of now, so currently you have
to compile master) or newer.


--- bash start
PROBE='kfunc:sched_group_set_shares{
  printf("cgroup: %s/%s\n",
    str(args->tg->css.cgroup->kn->parent->name),
    str(args->tg->css.cgroup->kn->name));
  printf(
"cpu  load.weight  avg.load_avg  removed.load_avg  removed.nr  removed.on_list  tg_load_avg_contrib  tg->load_avg\n"
);
}'
for i in $(seq 0 $(($(nproc)-1))); do
    PROBE="$PROBE""$(sed "s/cpu_nr/$i/" <<<' kfunc:sched_group_set_shares{
    printf("%-4d %-12llu %-13llu %-17llu %-11d %-16d %-20llu %d\n",
    cpu_nr,
    (args->tg->cfs_rq[cpu_nr])->load.weight,
    (args->tg->cfs_rq[cpu_nr])->avg.load_avg,
    (args->tg->cfs_rq[cpu_nr])->removed.load_avg,
    (args->tg->cfs_rq[cpu_nr])->removed.nr,
    (args->tg->cfs_rq[cpu_nr])->on_list,
    (args->tg->cfs_rq[cpu_nr])->tg_load_avg_contrib,
    args->tg->load_avg.counter
    );
}')"
done
PROBE="$PROBE"'kfunc:sched_group_set_shares{
  printf("\n");
}'

bpftrace -e "$PROBE"
--- bash end


When running the bpftrace script when the sub cgroup example is running, and
executing (just setting the weight of the cgroup the same value as before, no change):

--- bash start
tee /sys/fs/cgroup/slice/cg-1/sub/cpu.weight <<< 1
tee /sys/fs/cgroup/slice/cg-2/sub/cpu.weight <<< 10000
tee /sys/fs/cgroup/slice/cg-1/cpu.weight <<< 100
tee /sys/fs/cgroup/slice/cg-2/cpu.weight <<< 100
--- bash end

the output is:

--- output start
Attaching 6 probes...
cgroup: cg-1/sub
cpu  load.weight  avg.load_avg  removed.load_avg  removed.nr  removed.on_list  tg_load_avg_contrib  tg->load_avg
0    1048576      1023          0                 0           1                1034                 1662
1    0            0             0                 0           0                0                    1662
2    0            0             0                 0           0                0                    1662
3    0            628           628               1           0                628                  1662

cgroup: cg-2/sub
cpu  load.weight  avg.load_avg  removed.load_avg  removed.nr  removed.on_list  tg_load_avg_contrib  tg->load_avg
0    1048576      1023          0                 0           1                1023                 1830
1    0            0             0                 0           0                0                    1830
2    0            0             0                 0           0                0                    1830
3    0            807           807               1           0                807                  1830

cgroup: slice/cg-1
cpu  load.weight  avg.load_avg  removed.load_avg  removed.nr  removed.on_list  tg_load_avg_contrib  tg->load_avg
0    6347         5             0                 0           1                5                    593
1    0            0             0                 0           0                0                    593
2    0            0             0                 0           0                0                    593
3    0            5             0                 0           0                588                  593

cgroup: slice/cg-2
cpu  load.weight  avg.load_avg  removed.load_avg  removed.nr  removed.on_list  tg_load_avg_contrib  tg->load_avg
0    58642371     57263         0                 0           1                57909                58665
1    0            0             0                 0           0                0                    58665
2    0            0             0                 0           0                0                    58665
3    0            75615         0                 0           0                756                  58665

--- output end

We can clearly see that both cg-1/sub and cg-2/sub have removed.nr==1 on cpu 3,
and therefore still contribute to the tg->load_avg. Since removed.on_list==0, the load would
never be "cleaned" up unless a new task starts on that cpu, but due to the cpuset, that would not
be the case. slice/cg-1 and slice/cg-2 also have load attached to cpu 3 that isn't removed (but
the patch will properly decay the load on them as well). 

With this path, all of these examples just end up sharing cpu time in a fair 50/50 way, as expected.

Odin Ugedal (1):
  sched/fair: Fix unfairness caused by missing load decay

 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.31.1

