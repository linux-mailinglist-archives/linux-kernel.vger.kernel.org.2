Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD753222AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhBVXfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBVXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:35:35 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3871C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:34:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t25so11241553pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aGtlO+Dz7yVUmkI3Co2PA5lgXO9HqMIvVWvf4gq7KQI=;
        b=071yftra7QY3zhCvXyo66KrrDk9e1gpgyK4nulzhJVovIapet7fKWcQJvriAYbIyy5
         RiebNrdIqYRYwVZoStAfjJJgYAQPUngf7tD3/rj4C9l5qIrK18aBCOn/PvKUFt8H4sX3
         pLFM2omWwpO1+ZzpZ913lHMJiwmdCJEwd62IMRTUFz8H7TgV+cPDrhnlTyRkYt/XIGa8
         OCQZH6usD09BAlcXsMsjcW+LZZ6jtOf8C9ysiGErwZkCtVwKGZ9LA6wODABOJzJR8WwF
         q+4Jv5WH61mjqZsafXO/OupiHhI/KgB4D/5uLSt4RUD1mvMvgy5DNf8ewbzKavDG3XR6
         z2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGtlO+Dz7yVUmkI3Co2PA5lgXO9HqMIvVWvf4gq7KQI=;
        b=dIxNi/5/mYYjkH9+AED7OOOzvbauxEXuBtbm5adGlwx26lIp7I2br4ojKSKM/VLUdh
         ckAnE5pAF9lxhk8UaZTb0k+iIsB8T5aQwcOW0vxMSvMkmgQUrTTY4qjeZ9VpZ6XVVKC1
         UYQs0eXOnYVjgvB7Jl8vGRx0F0FMCl8tazyuUDsEtFuA9aslQ+a+P7KPfm0VJJ5LKKS+
         nJIk0P7SUSwRwEGUq5lPBxKUQvZJqci1F52UGMASNQ6H8aCbpKemAwqQ/07uqD3krWVp
         FJV86sHnFPPuEFRUabgV2EeeTR48baVpG4ncKMOxlC+ezbnMYuAutO2qL/HuyXV5q9u7
         1qmA==
X-Gm-Message-State: AOAM532YqtQZt11E+lU6gCUrc5mcGSYclsbK2engE0YHsIOBUkYrsN4a
        KsmKxrjmfXRMaEI/+1oHITJVQx1LBawzdw==
X-Google-Smtp-Source: ABdhPJzRc/DqqKaxH/6EiCc3PbPVrCxjn0t0qy/H/gB5i3YjRugT/vvnKkMSqRt7KgNc0F18CFdjdQ==
X-Received: by 2002:a05:6a00:2296:b029:1b6:6972:2f2a with SMTP id f22-20020a056a002296b02901b669722f2amr23565395pfe.69.1614036893829;
        Mon, 22 Feb 2021 15:34:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c1::1999? ([2620:10d:c090:400::5:d2d3])
        by smtp.gmail.com with ESMTPSA id k69sm20082698pfd.4.2021.02.22.15.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 15:34:53 -0800 (PST)
Subject: Re: 5.11 regression: "ia64: add support for TIF_NOTIFY_SIGNAL" breaks
 ia64 boot
To:     Sergei Trofimovich <slyich@gmail.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210222230519.73f3e239@sf>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
Date:   Mon, 22 Feb 2021 16:34:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222230519.73f3e239@sf>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/21 4:05 PM, Sergei Trofimovich wrote:
> Hia Jens!
> 
> Tried 5.11 on rx3600 box and noticed it has
> a problem handling init (5.10 booted fine):
> 
> INIT: version 2.98 booting
> 
>    OpenRC 0.42.1 is starting up Gentoo Linux (ia64)
> 
> mkdir `/run/openrc': Read-only file system
> mkdir `/run/openrc/starting': No such file or directory
> mkdir `/run/openrc/started': No such file or directory
> mkdir `/run/openrc/stopping': No such file or directory
> mkdir `/run/openrc/inactive': No such file or directory
> mkdir `/run/openrc/wasinactive': No such file or directory
> mkdir `/run/openrc/failed': No such file or directory
> mkdir `/run/openrc/hotplugged': No such file or directory
> mkdir `/run/openrc/daemons': No such file or directory
> mkdir `/run[   14.595059] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   14.599059] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> I suspect we build bad signal stack frame for userspace.
> 
> With a bit of #define DEBUG_SIG 1 enabled the signals are SIGCHLD:
> 
> [   34.969771] SIG deliver (gendepends.sh:69): sig=17 sp=60000fffff6aeaa0 ip=a000000000040740 handler=000000004b4c59b6
> [   34.969948] SIG deliver (init:1): sig=17 sp=60000fffff1ccc50 ip=a000000000040740 handler=000000004638b9e5
> [   34.969948] SIG deliver (gendepends.sh:69): sig=17 sp=60000fffff6adf90 ip=a000000000040740 handler=000000004b4c59b6
> [   34.973948] SIG deliver (init:1): sig=17 sp=60000fffff1cc140 ip=a000000000040740 handler=000000004638b9e5
> [   34.973948] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   34.973948] SIG deliver (gendepends.sh:69): sig=17 sp=60000fffff6ad480 ip=a000000000040740 handler=000000004b4c59b6
> [   34.973948] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> Bisect points at:
> 
> commit b269c229b0e89aedb7943c06673b56b6052cf5e5
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Oct 9 14:49:43 2020 -0600
> 
>     ia64: add support for TIF_NOTIFY_SIGNAL
> 
>     Wire up TIF_NOTIFY_SIGNAL handling for ia64.
> 
>     Cc: linux-ia64@vger.kernel.org
>     [axboe: added fixes from Mike Rapoport <rppt@kernel.org>]
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
> index 64a1011f6812..51d20cb37706 100644
> --- a/arch/ia64/include/asm/thread_info.h
> +++ b/arch/ia64/include/asm/thread_info.h
> @@ -103,6 +103,7 @@ struct thread_info {
>  #define TIF_SYSCALL_TRACE      2       /* syscall trace active */
>  #define TIF_SYSCALL_AUDIT      3       /* syscall auditing active */
>  #define TIF_SINGLESTEP         4       /* restore singlestep on return to user mode */
> +#define TIF_NOTIFY_SIGNAL      5       /* signal notification exist */
>  #define TIF_NOTIFY_RESUME      6       /* resumption notification requested */
>  #define TIF_MEMDIE             17      /* is terminating due to OOM killer */
>  #define TIF_MCA_INIT           18      /* this task is processing MCA or INIT */
> @@ -115,6 +116,7 @@ struct thread_info {
>  #define _TIF_SINGLESTEP                (1 << TIF_SINGLESTEP)
>  #define _TIF_SYSCALL_TRACEAUDIT        (_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP)
>  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
> +#define _TIF_NOTIFY_SIGNAL     (1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
>  #define _TIF_MCA_INIT          (1 << TIF_MCA_INIT)
> @@ -124,7 +126,7 @@ struct thread_info {
> 
>  /* "work to do on user-return" bits */
>  #define TIF_ALLWORK_MASK       (_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SYSCALL_AUDIT|\
> -                                _TIF_NEED_RESCHED|_TIF_SYSCALL_TRACE)
> +                                _TIF_NEED_RESCHED|_TIF_SYSCALL_TRACE|_TIF_NOTIFY_SIGNAL)
>  /* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT */
>  #define TIF_WORK_MASK          (TIF_ALLWORK_MASK&~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
> 
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index 6b61a703bcf5..8d4e1cab9190 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -171,7 +171,8 @@ do_notify_resume_user(sigset_t *unused, struct sigscratch *scr, long in_syscall)
>         }
> 
>         /* deal with pending signal delivery */
> -       if (test_thread_flag(TIF_SIGPENDING)) {
> +       if (test_thread_flag(TIF_SIGPENDING) ||
> +           test_thread_flag(TIF_NOTIFY_SIGNAL)) {
>                 local_irq_enable();     /* force interrupt enable */
>                 ia64_do_signal(scr, in_syscall);
> 
> which looks benign, but it enables a bit of conditional
> TIF_NOTIFY_SIGNAL handling I don't understand.
> 
> Can you help me get what is the interaction between
> TIF_NOTIFY_SIGNAL and TIF_SIGPENDING for
> simple processes without io_uring use case?
> 
> I wonder if it's ia64_do_signal()' generates a signal
> delivery when it should not.

Can you test:

https://marc.info/?l=linux-ia64&m=161187407609443&w=1

with the addition mentioned here:

https://marc.info/?l=linux-ia64&m=161187470709706&w=1

if needed?

-- 
Jens Axboe

