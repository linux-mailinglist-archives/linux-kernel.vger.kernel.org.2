Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE7414941
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhIVMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhIVMoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:44:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CD69610A0;
        Wed, 22 Sep 2021 12:42:47 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:42:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/9] fork: pass worker_flags to copy_thread
Message-ID: <20210922124245.m4gucclabgyijqei@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-3-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:11PM -0500, Mike Christie wrote:
> We need to break up PF_IO_WORKER into the parts that are used for
> scheduling and signal handling and the part that tells copy_thread to
> treat it as a special type of thread during setup. This patch passes the
> worker_flags to copy_thread, so in the next patch we can add new worker
> flags that function can see.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  arch/alpha/kernel/process.c      | 2 +-
>  arch/arc/kernel/process.c        | 2 +-
>  arch/arm/kernel/process.c        | 3 ++-
>  arch/arm64/kernel/process.c      | 3 ++-
>  arch/csky/kernel/process.c       | 3 ++-
>  arch/h8300/kernel/process.c      | 3 ++-
>  arch/hexagon/kernel/process.c    | 2 +-
>  arch/ia64/kernel/process.c       | 3 ++-
>  arch/m68k/kernel/process.c       | 2 +-
>  arch/microblaze/kernel/process.c | 2 +-
>  arch/mips/kernel/process.c       | 2 +-
>  arch/nds32/kernel/process.c      | 3 ++-
>  arch/nios2/kernel/process.c      | 2 +-
>  arch/openrisc/kernel/process.c   | 3 ++-
>  arch/parisc/kernel/process.c     | 3 ++-
>  arch/powerpc/kernel/process.c    | 2 +-
>  arch/riscv/kernel/process.c      | 2 +-
>  arch/s390/kernel/process.c       | 3 ++-
>  arch/sh/kernel/process_32.c      | 2 +-
>  arch/sparc/kernel/process_32.c   | 2 +-
>  arch/sparc/kernel/process_64.c   | 2 +-
>  arch/um/kernel/process.c         | 3 ++-
>  arch/x86/kernel/process.c        | 2 +-
>  arch/xtensa/kernel/process.c     | 2 +-
>  include/linux/sched/task.h       | 2 +-
>  kernel/fork.c                    | 3 ++-
>  26 files changed, 37 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
> index a5123ea426ce..6005b0dfe7e2 100644
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -235,7 +235,7 @@ release_thread(struct task_struct *dead_task)
>   */
>  int copy_thread(unsigned long clone_flags, unsigned long usp,
>  		unsigned long kthread_arg, struct task_struct *p,
> -		unsigned long tls)
> +		unsigned long tls, u32 worker_flags)

After I unified all of those calls across all arches I think we should
start thinking about a way to maybe have a substruct
struct copy_thread
or something to encompass this information that gets passed to
copy_thread() instead of individual arguments.
struct copy_thread
would just contain the information all the arches need and nothing more.
That's better than passing all of
struct kernel_clone_args
imho. But that's a separate cleanup I had in mind for a while and is
unrelated to your patch.
I think it's fine to do it this way for now.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
