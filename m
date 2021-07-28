Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD73D8569
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 03:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhG1Bca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 21:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234493AbhG1Bc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 21:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627435947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kf5aUfsANGKBoZwHiIJy34leYH8aHIuAfY+f1HX0vi8=;
        b=hOpcyx/t9/QEeAk9v4EaHgkZikHOtBpKwGBy2hgQKHgO0UjuVJGZTERYcyIHyc+hlnbNG6
        +YgPymOzLzN0O1KVczx2rf6LnWLRZbESALQd50JLU3VkJRWpnVYJWUxK/rN4JTCODwBaAR
        jCJlrt42JkUyhUh8WZvCkAasjiaxz94=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-sPXii0CDPk-vF-aDa27GrQ-1; Tue, 27 Jul 2021 21:32:26 -0400
X-MC-Unique: sPXii0CDPk-vF-aDa27GrQ-1
Received: by mail-lf1-f70.google.com with SMTP id t10-20020a056512208ab029037e853a8057so216745lfr.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 18:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kf5aUfsANGKBoZwHiIJy34leYH8aHIuAfY+f1HX0vi8=;
        b=eu/wnAJmrlJrL/VWAmgK6MJvROsi+wBAMVP0s818J4YOm76BkhbI++PiaBN65rTf47
         6RqDoMqIjuiJELpAAFG6x7nBKO3W9KxjzQDNhadvssSnkhEioiNflnNBStLpI2IBnEYo
         GBuOinR2HBfKHZDwSq5asZHVL1Bh8Ns6FIg51ltxC+JOlXk+v/rgLS1ypASHJi+hiWkb
         n9CrLMhsb+cRdI8tPdAWpvSZwZuc9pLQ+r8q7xWZdIMIoir34s+fua/tyy5edqRU0ML9
         Wo3n/p9jRpxk1lrROU81aFoZhghswiW/pYmophgNb7qiE0njJ6BnfcuIhSNLz5oWwG8P
         7xnQ==
X-Gm-Message-State: AOAM533R5XUzNJEsjy9y/tx/R2vPyv5Mc1NF+zhAqGOf9gnTzW676n3Q
        gzbyYwcvDEFSxftvv1mhjdI3kV9ChS7cMtO1/7k94FmJwTJAOJNbN6GAyDuISg9IhAer32hTSBr
        wMUGTIzh73DzC+qDvXo2bISmaXtOHHwplLTx6nP9Y
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr17792646ljk.489.1627435944394;
        Tue, 27 Jul 2021 18:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykFYilZJ2GcF6ouX3vcGwfM+Hskq6tfweIJmhp9Yv8JcjVZgcMTXPVL1ESbZYm6VaP6gLAx2EBoAE5N087UTU=
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr17792637ljk.489.1627435944184;
 Tue, 27 Jul 2021 18:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <YPd7IGFZrsTRfUxE@T590> <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590> <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
 <YPklDMng1hL3bQ+v@T590> <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590> <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590> <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590> <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
In-Reply-To: <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Wed, 28 Jul 2021 09:32:17 +0800
Message-ID: <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 3:51 PM John Garry <john.garry@huawei.com> wrote:
>
> On 23/07/2021 11:21, Ming Lei wrote:
> >> Thanks, I was also going to suggest the latter, since it's what
> >> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
> >> indicative of where the slowness most likely stems from.
> > The improvement from 'iommu.strict=0' is very small:
> >
>
> Have you tried turning off the IOMMU to ensure that this is really just
> an IOMMU problem?
>
> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> disabling for kernel drivers).

Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
on this issue.

And from fio log, submission latency is good, but completion latency
is pretty bad,
and maybe it is something that writing to PCI memory isn't committed to HW in
time?

BTW, adding one mb() at the exit of nvme_queue_rq() doesn't make a difference.


Follows the fio log after passing iommu.passthrough=1:

[root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring
10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
--iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16
--filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1
--rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=1538MiB/s][r=394k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3053: Tue Jul 27 20:57:04 2021
  read: IOPS=393k, BW=1536MiB/s (1611MB/s)(15.0GiB/10001msec)
    slat (usec): min=12, max=343, avg=18.54, stdev= 3.47
    clat (usec): min=46, max=487, avg=140.15, stdev=22.72
     lat (usec): min=63, max=508, avg=158.72, stdev=22.29
    clat percentiles (usec):
     |  1.00th=[   87],  5.00th=[  104], 10.00th=[  113], 20.00th=[  123],
     | 30.00th=[  130], 40.00th=[  135], 50.00th=[  141], 60.00th=[  145],
     | 70.00th=[  151], 80.00th=[  159], 90.00th=[  167], 95.00th=[  176],
     | 99.00th=[  196], 99.50th=[  206], 99.90th=[  233], 99.95th=[  326],
     | 99.99th=[  392]
   bw (  MiB/s): min= 1533, max= 1539, per=100.00%, avg=1537.99,
stdev= 1.36, samples=19
   iops        : min=392672, max=394176, avg=393724.63, stdev=348.25, samples=19
  lat (usec)   : 50=0.01%, 100=3.64%, 250=96.30%, 500=0.06%
  cpu          : usr=17.58%, sys=82.03%, ctx=1113, majf=0, minf=5
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=3933712,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=1536MiB/s (1611MB/s), 1536MiB/s-1536MiB/s
(1611MB/s-1611MB/s), io=15.0GiB (16.1GB), run=10001-10001msec

Disk stats (read/write):
  nvme1n1: ios=3890950/0, merge=0/0, ticks=529137/0, in_queue=529137,
util=99.15%
[root@ampere-mtjade-04 ~]#
[root@ampere-mtjade-04 ~]# taskset -c 80
~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
--iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16
--filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1
--rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=150MiB/s][r=38.4k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3062: Tue Jul 27 20:57:23 2021
  read: IOPS=38.4k, BW=150MiB/s (157MB/s)(1501MiB/10002msec)
    slat (usec): min=14, max=376, avg=20.21, stdev= 4.66
    clat (usec): min=439, max=2457, avg=1640.85, stdev=17.01
     lat (usec): min=559, max=2494, avg=1661.09, stdev=15.67
    clat percentiles (usec):
     |  1.00th=[ 1614],  5.00th=[ 1631], 10.00th=[ 1647], 20.00th=[ 1647],
     | 30.00th=[ 1647], 40.00th=[ 1647], 50.00th=[ 1647], 60.00th=[ 1647],
     | 70.00th=[ 1647], 80.00th=[ 1647], 90.00th=[ 1647], 95.00th=[ 1647],
     | 99.00th=[ 1647], 99.50th=[ 1663], 99.90th=[ 1729], 99.95th=[ 1827],
     | 99.99th=[ 2057]
   bw (  KiB/s): min=153600, max=153984, per=100.00%, avg=153876.21,
stdev=88.10, samples=19
   iops        : min=38400, max=38496, avg=38469.05, stdev=22.02, samples=19
  lat (usec)   : 500=0.01%, 1000=0.01%
  lat (msec)   : 2=99.96%, 4=0.03%
  cpu          : usr=2.00%, sys=97.65%, ctx=1056, majf=0, minf=5
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=384288,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=150MiB/s (157MB/s), 150MiB/s-150MiB/s (157MB/s-157MB/s),
io=1501MiB (1574MB), run=10002-10002msec

Disk stats (read/write):
  nvme1n1: ios=380266/0, merge=0/0, ticks=554940/0, in_queue=554940, util=99.22%

