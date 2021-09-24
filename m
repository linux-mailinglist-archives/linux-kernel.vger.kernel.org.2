Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FCA416B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 07:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbhIXGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhIXGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:01:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234ADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:59:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so7059241pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 22:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8p2GDhUEcWRPomZMh4hnXGZQSPROou5FNFUE/6Z7XNs=;
        b=hu0GUgYMSxCGS3d/nz4es6JF5GhGa6GYd8gqS3gJlce3SwWURqNLza6o9KP6S2PF53
         2r/gtNdbaaStWI5436G5xXBEL1JjNwrOPK50rWOOEaqSyyDc8t65paBMCLh0x75DX1bZ
         zCDeskBmNnseSPRHYaU26sxp3Fwj5f59mueKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8p2GDhUEcWRPomZMh4hnXGZQSPROou5FNFUE/6Z7XNs=;
        b=ZyIGrUFr8Mq2y+7rdehZqGPHKjY9ixSJur0joesqvBMERhTv/cJTQKOjMGXTMQHcZ2
         hQQMlkx6pSQ1DySSd88mP4+nsslr2uo7oYX4+y3posQ3gcKCh+FKlwgxrwTlpzTt942o
         AjslGj+/dcp62YHaXy6NiZQiuZTF3ouZMar2d89DP0K37OlVA363eztgG5lr+Psl8OMg
         Wz5jmSiZkvsOU2JKC43xoJngDCbamP+A0JJ/Pa7T7v8LkKw3ZsL5wVF0DsovInefkDFw
         DM0LH/wBGH+i7/wW14VrOsrhS7gRvmsAEtk5Oekl0ku+Ibvh6fKxF0oTHyfpU8jzelJC
         Nifg==
X-Gm-Message-State: AOAM532dkSYijYiPN6m3a7Pbp2wuFvoGVdrt9lPtN+ovCpvDhyhSGC9U
        9RoB47qoYfvoiYmg2bkBdokHQcMCllCTKQ==
X-Google-Smtp-Source: ABdhPJwSne78xKpXWR2MdgVgCnh3GwedXeE0BttcTmfTsCQlAxyAbanWu4xD5IhRLBP0N6OIjNAOqQ==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr151177pja.71.1632463186533;
        Thu, 23 Sep 2021 22:59:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l128sm7586461pfd.106.2021.09.23.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 22:59:45 -0700 (PDT)
Date:   Thu, 23 Sep 2021 22:59:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/6] per signal_struct coredumps
Message-ID: <202109232234.135BF1325@keescook>
References: <87v92qx2c6.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v92qx2c6.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:08:09PM -0500, Eric W. Biederman wrote:
> Current coredumps are mixed up with the exit code, the signal handling
> code and with the ptrace code in was they are much more complicated than
> necessary and difficult to follow.
> 
> This series of changes starts with ptrace_stop and cleans it up,
> making it easier to follow what is happening in ptrace_stop.
> Then cleans up the exec interactions with coredumps.
> Then cleans up the coredump interactions with exit.
> Then the coredump interactions with the signal handling code is clean
> up.
> 
> The first and last changes are bug fixes for minor bugs.

I haven't had a chance to carefully look through this yet, but I like
the sound of it. :)

Do we have any behavioral tests around this? The ptrace tests in seccomp
don't explicitly exercise the exit handling. Are there regression tests
for "rr"? They're usually the first to notice subtle changes in ptrace.

What I couldn't tell from my quick skim: does this further change the
behavior around force_sig_seccomp()? Specifically the "am I single
threaded?" check:

        case SECCOMP_RET_KILL_THREAD:
        case SECCOMP_RET_KILL_PROCESS:
        default:
                seccomp_log(this_syscall, SIGSYS, action, true);
                /* Dump core only if this is the last remaining thread. */
                if (action != SECCOMP_RET_KILL_THREAD ||
                    (atomic_read(&current->signal->live) == 1)) {
                        /* Show the original registers in the dump. */
                        syscall_rollback(current, current_pt_regs());
                        /* Trigger a coredump with SIGSYS */
                        force_sig_seccomp(this_syscall, data, true);
                } else {
                        do_exit(SIGSYS);
                }
                return -1; /* skip the syscall go directly to signal handling */

I *think* the answer is "no", in the sense that coredump_wait() is still
calling zap_threads() which calls zap_process(). Which now seem like
should have opposite names. :) And therefore inducing a coredump will
still take out all threads. (i.e. after your series, no changes need to
be made to seccomp for it.)

-Kees

-- 
Kees Cook
