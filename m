Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCC3214C1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBVLHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:07:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59274 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBVLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:06:58 -0500
Received: from [192.168.0.20] (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8243D344;
        Mon, 22 Feb 2021 12:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1613991969;
        bh=G5i5yHdBw/r30i6OGm9771V2dodofqqfJfxOb5Hwa14=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tFrSXmDqqFWkH+SDCXFObMcmF61c0dMXVYOosxIgJ+9aWcRkU6CmG4IujQ7Y0p9RO
         mGG6R1v/u8CBZU/o7bkPNrTdUskI1HPXXJiAvwLR6b4hyGCCmhW0Jz0F2I24dVlA1D
         pm5RpPfiXB+5iaoCrI+b5DCca7BJMrzo5M0+xFjg=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH] scripts/gdb: document lx_current is only supported by x86
To:     Barry Song <song.bao.hua@hisilicon.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, jan.kiszka@siemens.com
Cc:     linux-kernel@vger.kernel.org, linuxarm@openeuler.org
References: <20210221213527.22076-1-song.bao.hua@hisilicon.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 WZw01QYHU/GUV/zHJSFk
Organization: Ideas on Board
Message-ID: <eac66671-f083-379a-c7b0-04b783e32d63@ideasonboard.com>
Date:   Mon, 22 Feb 2021 11:06:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210221213527.22076-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry

On 21/02/2021 21:35, Barry Song wrote:
> lx_current depends on the per_cpu current_task which exists on x86 only:
> 
> arch$ git grep current_task | grep -i per_cpu
> x86/include/asm/current.h:DECLARE_PER_CPU(struct task_struct *, current_task);
> x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
> x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
> x86/kernel/cpu/common.c:DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
> x86/kernel/cpu/common.c:EXPORT_PER_CPU_SYMBOL(current_task);
> x86/kernel/smpboot.c:	per_cpu(current_task, cpu) = idle;
> 
> On other architectures, lx_current() will lead to a python exception:
> (gdb) p $lx_current().pid
> Python Exception <class 'gdb.error'> No symbol "current_task" in current context.:
> Error occurred in Python: No symbol "current_task" in current context.
> 
> To avoid more people struggling and wasting time in other architectures,
> document it.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/dev-tools/gdb-kernel-debugging.rst |  2 +-
>  scripts/gdb/linux/cpus.py                        | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/gdb-kernel-debugging.rst b/Documentation/dev-tools/gdb-kernel-debugging.rst
> index 4756f6b3a04e..1586901b683c 100644
> --- a/Documentation/dev-tools/gdb-kernel-debugging.rst
> +++ b/Documentation/dev-tools/gdb-kernel-debugging.rst
> @@ -114,7 +114,7 @@ Examples of using the Linux-provided gdb helpers
>      [     0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
>      ....
>  
> -- Examine fields of the current task struct::
> +- Examine fields of the current task struct(supported by x86 only)::
>  
>      (gdb) p $lx_current().pid
>      $1 = 4998
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 008e62f3190d..f382762509d3 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -156,6 +156,13 @@ Note that VAR has to be quoted as string."""
>  
>  PerCpu()
>  
> +def get_current_task(cpu):
> +    if utils.is_target_arch("x86"):
> +         var_ptr = gdb.parse_and_eval("&current_task")
> +         return per_cpu(var_ptr, cpu).dereference()
> +    else:
> +        raise gdb.GdbError("Sorry, obtaining the current task is not yet "
> +                           "supported with this arch")

I've wondered in the past how we should handle the architecture specific
layers.

Perhaps we need to have an interface of functionality to implement on
each architecture so that we can create a per-arch set of helpers.

or break it up into arch specific subdirs at least...


>  class LxCurrentFunc(gdb.Function):
>      """Return current task.
> @@ -167,8 +174,7 @@ number. If CPU is omitted, the CPU of the current context is used."""
>          super(LxCurrentFunc, self).__init__("lx_current")
>  
>      def invoke(self, cpu=-1):
> -        var_ptr = gdb.parse_and_eval("&current_task")
> -        return per_cpu(var_ptr, cpu).dereference()
> +        return get_current_task(cpu)
>  

And then perhaps we simply shouldn't even expose commands which can not
be supported on those architectures?

Is it easy to disable this command if it's not supportable on the
architecture?

Presumably you are working on non-x86, have you investigated adding this
support for your architecture (arm/arm64?)?

The fact you have run the command implies it would be useful for you ?


>  LxCurrentFunc()
> 


-- 
Regards
--
Kieran
