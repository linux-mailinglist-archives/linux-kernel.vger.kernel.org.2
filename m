Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE01305F44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhA0PP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235442AbhA0POm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:14:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 255022076E;
        Wed, 27 Jan 2021 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611760437;
        bh=+sxh0lPPz8rLlADxthyJQ70o2uTxhwpXT3eywgtij+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rK/Uy29+kgTXuPWCRKTTjVGfxFAXCM6Znu77LioMr06mawDSNjWqPKuebWtOuKFf4
         xmw8p8jv2Sh7NmgxeDEKhyDVYpuoZFR1AmyLl0LzVEWBITgmqtj/yTFPMyfzH8zhot
         TKWcAZKldRBrkWKfQc6AEDuxWyCcG1oXXX+mGcUiy+cGOs8R1lwK3idpW5rgIIEZeo
         e33FSZv1FpkV29nXCPrV/OtDXfzbcDXHA1Cbh0kjUK9QYRIjEPXhEaNhSgLI4lDVXj
         FTs9FyK0ZscGhJb6rg7zdYeqoVjppk+Idayi7YPiT3hwH4BpLI3C1EWnmSAfIAiFHx
         DHWNVJEoTEtpQ==
Date:   Thu, 28 Jan 2021 00:13:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kprobes broken since 0d00449c7a28
 ("x86: Replace ist_enter() with nmi_enter()")
Message-Id: <20210128001353.66e7171b395473ef992d6991@kernel.org>
In-Reply-To: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolay,

On Wed, 27 Jan 2021 15:43:29 +0200
Nikolay Borisov <nborisov@suse.com> wrote:

> Hello,
> 
> I'm currently seeing latest Linus' master being somewhat broken w.r.t
> krpobes. In particular I have the following test-case:
> 
> #!/bin/bash
> 
> mkfs.btrfs -f /dev/vdc &> /dev/null
> mount /dev/vdc /media/scratch/
> 
> bpftrace -e 'kprobe:btrfs_sync_file {printf("kprobe: %s\n", kstack());}'
> &>bpf-output &
> bpf_trace_pid=$!
> 
> # force btrfs_sync_file to be called
> sleep 2
> xfs_io -f -c "pwrite 0 4m" -c "fsync" /media/scratch/file5
> 
> kill $bpf_trace_pid
> sleep 1
> 
> grep -q kprobe bpf-output
> retval=$?
> rm -f bpf-output
> umount /media/scratch
> 
> exit $retval
> 
> It traces btrfs_sync_file which is called when fsync is executed on a
> btrfs file, however I don't see the stacktrace being printed i.e the
> kprobe doesn't fire at all. The following alternative program:
> 
> bpftrace -e 'tracepoint:btrfs:btrfs_sync_file {printf("tracepoint:
> %s\n", kstack());} kprobe:btrfs_sync_file {printf("kprobe: %s\n",
> kstack());}'
> 
> only prints the stack from the tracepoint and not from the kprobe, given
> that the tracepoint is called from the btrfs_sync_file function.

Thank you for reporting!

If you don't mind, could you confirm it with ftrace (tracefs)?
bpftrace etc. involves too many things. It is better to test with
simpler way to test it.
I'm not familer with the bpftrace, but I think you can check it with

# cd /sys/kernel/debug/tracing
# echo p:myevent btrfs_sync_file >> kprobe_events
# echo stacktrace > events/kprobes/myevent/trigger
 (or echo 1 > options/stacktrace , if trigger file doesn't exist)

Could you also share your kernel config, so that we can reproduce it?

> 
> I started bisecting this and arrived at the following commit:
> 
> 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> 
> FWIW the following series is applied on the kernel I was testing:
> https://lore.kernel.org/lkml/159870598914.1229682.15230803449082078353.stgit@devnote2/
> 
> but it's still broken.

Peter, would you have any idea?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
