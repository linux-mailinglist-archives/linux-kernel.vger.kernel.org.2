Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B76306A79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhA1BgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhA1BfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:35:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5376364DD9;
        Thu, 28 Jan 2021 01:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611797658;
        bh=hkfwMyUePB25Ov+rGyYFrPJg3dzl4fvcpbHGBoZBbJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VvLzofCuqNcY9yWDxlCUBOsQ4cAcP6qaVplK5qC2QRgkAVzIxDOtDQW6nOCorgkX6
         B3ulzCZuLN/fT0xdsKAe6lYxvf+CYuMToyi+Xup28RWnMtxKOAaT/fmIP5SdrzQOgw
         yz/Sc38Jxdyd32U9x3oT4F/FULBJx5cvLinFPgXmXiq232Zq7RK6wVnPF0j4OFI36W
         0q93HC1aQb2HBFTqMFOxZYzTJIw/LxCmYk1NiraoVUrmUzkfaplVhKlxGyaRz4eJ9d
         H0dEVcW9abKEnzahjRNVAev3S3iEj8+TMFY1reJ4xpLdEJIsDRTwOFGpaZeO94s2t0
         iPunQco+4JvFw==
Date:   Thu, 28 Jan 2021 10:34:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
In-Reply-To: <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
        <20210128001353.66e7171b395473ef992d6991@kernel.org>
        <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
        <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 19:57:56 +0200
Nikolay Borisov <nborisov@suse.com> wrote:

> 
> 
> On 27.01.21 г. 17:24 ч., Masami Hiramatsu wrote:
> > On Thu, 28 Jan 2021 00:13:53 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> >> Hi Nikolay,
> >>
> >> On Wed, 27 Jan 2021 15:43:29 +0200
> >> Nikolay Borisov <nborisov@suse.com> wrote:
> >>
> >>> Hello,
> >>>
> >>> I'm currently seeing latest Linus' master being somewhat broken w.r.t
> >>> krpobes. In particular I have the following test-case:
> >>>
> >>> #!/bin/bash
> >>>
> >>> mkfs.btrfs -f /dev/vdc &> /dev/null
> >>> mount /dev/vdc /media/scratch/
> >>>
> >>> bpftrace -e 'kprobe:btrfs_sync_file {printf("kprobe: %s\n", kstack());}'
> >>> &>bpf-output &
> >>> bpf_trace_pid=$!
> >>>
> >>> # force btrfs_sync_file to be called
> >>> sleep 2
> >>> xfs_io -f -c "pwrite 0 4m" -c "fsync" /media/scratch/file5
> >>>
> >>> kill $bpf_trace_pid
> >>> sleep 1
> >>>
> >>> grep -q kprobe bpf-output
> >>> retval=$?
> >>> rm -f bpf-output
> >>> umount /media/scratch
> >>>
> >>> exit $retval
> >>>
> >>> It traces btrfs_sync_file which is called when fsync is executed on a
> >>> btrfs file, however I don't see the stacktrace being printed i.e the
> >>> kprobe doesn't fire at all. The following alternative program:
> >>>
> >>> bpftrace -e 'tracepoint:btrfs:btrfs_sync_file {printf("tracepoint:
> >>> %s\n", kstack());} kprobe:btrfs_sync_file {printf("kprobe: %s\n",
> >>> kstack());}'
> >>>
> >>> only prints the stack from the tracepoint and not from the kprobe, given
> >>> that the tracepoint is called from the btrfs_sync_file function.
> >>
> >> Thank you for reporting!
> >>
> >> If you don't mind, could you confirm it with ftrace (tracefs)?
> >> bpftrace etc. involves too many things. It is better to test with
> >> simpler way to test it.
> >> I'm not familer with the bpftrace, but I think you can check it with
> >>
> >> # cd /sys/kernel/debug/tracing
> >> # echo p:myevent btrfs_sync_file >> kprobe_events
> >> # echo stacktrace > events/kprobes/myevent/trigger
> >>  (or echo 1 > options/stacktrace , if trigger file doesn't exist)
> > 
> > Of course, also you have to enable the event.
> >  # echo 1 > events/kprobes/myevent/enable
> > 
> > And check the results
> > 
> >  # cat trace
> > 
> > 
> >> Could you also share your kernel config, so that we can reproduce it?
> > 
> 
> I've attached the config and indeed with the scenario you proposed it
> seems to works. I see:
> 
>        xfs_io-20280   [000] d.Z.  9900.748633: myevent:
> (btrfs_sync_file+0x0/0x580)
>           xfs_io-20280   [000] d.Z.  9900.748647: <stack trace>
>  => kprobe_trace_func
>  => kprobe_dispatcher
>  => kprobe_int3_handler
>  => exc_int3
>  => asm_exc_int3
>  => btrfs_sync_file
>  => do_fsync
>  => __x64_sys_fsync
>  => do_syscall_64
>  => entry_SYSCALL_64_after_hwframe

Hmm, then there might be a problem in bpftrace or ebpf (need more info).
At least kprobes itself isn't broken.
I guess they check "in_nmi()" and skip such event?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
