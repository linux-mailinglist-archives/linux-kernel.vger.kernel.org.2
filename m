Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5C429711
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhJKSri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJKSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 14:47:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF2CC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:45:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so77186117lfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pchvvATNbk/8sMncxiiN9k1TbKkT0wEgMkyPDBPDVzw=;
        b=ZncLCafilGU3tbBlGe8oY8z+FbwIimNfmXZZByooJEci9fFTSwKdArncsKw0Qshi8D
         KUpWqOvO9gwSUGOkYntqxbZ5uY/378EDzdvVljc7P218vvcRQl141QmwGP1NZqjygjn2
         qTDD1XoKtPOGVPzZ/yu7BWYrh61VhQVN9t80SAc2PH7kkmBUw47GZFUeNtAtR2cro51C
         IK4Clulz6aKBfwIw+qLiCzEQ5HX7K4AEq9yqGzf6P9iQX6pfnLu5K/1vb+DEUll/JqHU
         wAuPIpLrX+GI+ul2LzPFqkoPCqK0SkA30vJfHL2tLuW6F7RqCJJwB26bnUTq6EHJLRTu
         vkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pchvvATNbk/8sMncxiiN9k1TbKkT0wEgMkyPDBPDVzw=;
        b=0uGUksPlSeX5V68PYb/i8B1m7CXFD5GZEruaXNWOiRkLLj9l2eV0xTlwymKg2Ngc73
         pYE4K8Qep3DibzyXDmTpz9mnsRyEIaFqfbOdZPBO17X42oAUslJ5DjJbOyTx8ZQDIiNt
         OzaWHQZeuRbpwcYZ7/zSKKVzFjT8IoSnL7cd576FEMChsjTMTDlG95q30FDMjuuE2plj
         KLgl4iqtiaProBsQL4Qc99b75+vdkf46ffSwYFXAMu6u5TtShO6Pn6WIaDrMHbUXdIDB
         fSESO55rTKTRiSR5jZCC7IZqhFl1gIvuT1tiUXCMDZ1B4PH4VMBexin20OgtnDrVa2UG
         dn1g==
X-Gm-Message-State: AOAM5316JQOVdTjg2chrbFzo/ZZ5f9EIzTrAG4q5XITXIx/44HYD+K3O
        +Vd6iCBEoq3Y3XpRWli+HlwfSdPPgU+VP9/fxiIZDkkj7q0isg==
X-Google-Smtp-Source: ABdhPJxnc6NOysL6L51/L6pRT+8yki6z66uJ0eFrosskIU82EVx0kymz+KCrsBNJrLmnl+Nto7Jm2+yNPsnf45Rc4gs=
X-Received: by 2002:a05:6512:1103:: with SMTP id l3mr14202886lfg.550.1633977934045;
 Mon, 11 Oct 2021 11:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <163369609308.636038.15295764725220907794.stgit@devnote2> <163369614818.636038.5019945597127474028.stgit@devnote2>
In-Reply-To: <163369614818.636038.5019945597127474028.stgit@devnote2>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Oct 2021 11:45:22 -0700
Message-ID: <CAKwvOdkdPHN0Y5GwTPUeaZyjtBttWrfoeLvQJFaJrfOHAtxkHg@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: clang: Do not relay on lr register for stacktrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 5:29 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Currently the stacktrace on clang compiled arm kernel uses the 'lr'
> register to find the first frame address from pt_regs. However, that
> is wrong after calling another function, because the 'lr' register
> is used by 'bl' instruction and never be recovered.
>
> As same as gcc arm kernel, directly use the frame pointer (x11) of
> the pt_regs to find the first frame address.

Hi Masami,
Thanks for the patch. Testing with ARCH=arm defconfig (multi_v7_defconfig)

Before this patch:

$ mount -t proc /proc
$ echo 0 > /proc/sys/kernel/kptr_restrict
$ cat /proc/self/stack
[<0>] proc_single_show+0x4c/0xb8
[<0>] seq_read_iter+0x174/0x4d8
[<0>] seq_read+0x134/0x158
[<0>] vfs_read+0xcc/0x2f8
[<0>] ksys_read+0x74/0xd0
[<0>] __entry_text_start+0x14/0x14
[<0>] 0xbea38cc0

After this patch:
$ mount -t proc /proc
$ echo 0 > /proc/sys/kernel/kptr_restrict
$ cat /proc/self/stack
[<0>] proc_single_show+0x4c/0xb8
[<0>] seq_read_iter+0x174/0x4d8
[<0>] seq_read+0x134/0x158
[<0>] vfs_read+0xcc/0x2f8
[<0>] ksys_read+0x74/0xd0
[<0>] __entry_text_start+0x14/0x14
[<0>] 0xbeb55cc0

Is there a different way to test/verify this patch? (I'm pretty sure
we had verified the WARN_ONCE functionality with this, too.)

If I change from CONFIG_UNWINDER_ARM=y to
CONFIG_UNWINDER_FRAME_POINTER=y, before:

# cat /proc/self/stack
[<0>] stack_trace_save_tsk+0x50/0x6c
[<0>] proc_pid_stack+0xa0/0xf8
[<0>] proc_single_show+0x50/0xbc
[<0>] seq_read_iter+0x178/0x4ec
[<0>] seq_read+0x138/0x15c
[<0>] vfs_read+0xd0/0x304
[<0>] ksys_read+0x78/0xd4
[<0>] sys_read+0xc/0x10

after:
# cat /proc/self/stack
[<0>] proc_pid_stack+0xa0/0xf8
[<0>] proc_single_show+0x50/0xbc
[<0>] seq_read_iter+0x178/0x4ec
[<0>] seq_read+0x138/0x15c
[<0>] vfs_read+0xd0/0x304
[<0>] ksys_read+0x78/0xd4
[<0>] sys_read+0xc/0x10
[<0>] __entry_text_start+0x14/0x14
[<0>] 0xffffffff

So I guess this helps the CONFIG_UNWINDER_FRAME_POINTER=y case? (That
final frame address looks wrong, but is potentially yet another bug;
perhaps for clang we need to manually store the previous frame's pc at
a different offset before jumping to __entry_text_start).

Also, I'm curious about CONFIG_THUMB2_KERNEL (forces CONFIG_UNWINDER_ARM=y).

before:
# cat /proc/self/stack
[<0>] proc_single_show+0x31/0x86
[<0>] seq_read_iter+0xff/0x326
[<0>] seq_read+0xd7/0xf2
[<0>] vfs_read+0x93/0x20e
[<0>] ksys_read+0x53/0x92
[<0>] ret_fast_syscall+0x1/0x52
[<0>] 0xbe9a9cc0

after:
# cat /proc/self/stack
[<0>] proc_single_show+0x31/0x86
[<0>] seq_read_iter+0xff/0x326
[<0>] seq_read+0xd7/0xf2
[<0>] vfs_read+0x93/0x20e
[<0>] ksys_read+0x53/0x92
[<0>] ret_fast_syscall+0x1/0x52
[<0>] 0xbec08cc0

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

so likely this fixes/improves CONFIG_UNWINDER_FRAME_POINTER=y? Is that correct?

>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm/kernel/stacktrace.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index 76ea4178a55c..db798eac7431 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -54,8 +54,7 @@ int notrace unwind_frame(struct stackframe *frame)
>
>         frame->sp = frame->fp;
>         frame->fp = *(unsigned long *)(fp);
> -       frame->pc = frame->lr;
> -       frame->lr = *(unsigned long *)(fp + 4);
> +       frame->pc = *(unsigned long *)(fp + 4);
>  #else
>         /* check current frame pointer is within bounds */
>         if (fp < low + 12 || fp > high - 4)
>

-- 
Thanks,
~Nick Desaulniers
