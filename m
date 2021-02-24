Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016CE32375B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhBXGXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 01:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhBXGXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614147713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z57+CG+M9Eh23TG6DAPI/lxAHjPDjJOX3QFONzYVNs8=;
        b=LOfgjN2+KbtRxbycFpDKYCvxfhc0kk27K4GVjOGDCEEg1MUFmzD7ueKH+BtoREG199hjj4
        isYf9zxttmRdKy9RyzYpjPJpWZDlcZ6VfhnzDhwhLSA22+1Eoib0smOnYjjW1Y1KO4EtlQ
        +PZq/ye/QMmAGfoigpeQv8t8HRFhZKc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-KAzce362MFmZwuPiVwBGhQ-1; Wed, 24 Feb 2021 01:21:48 -0500
X-MC-Unique: KAzce362MFmZwuPiVwBGhQ-1
Received: by mail-il1-f200.google.com with SMTP id y11so778006ilc.18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z57+CG+M9Eh23TG6DAPI/lxAHjPDjJOX3QFONzYVNs8=;
        b=dqH4zmZ4XFFZ7GsngqQhMnubN3tA8EVuFfCVa0AEzpzMLWV6B3c14EQWACHWq0uAsm
         3X4HQLcagF8tAT7Qb6Cs7AE2YaaN8l04zsF7d0312832nPCMU0PEQhs9I8AmUZW1FiWG
         8q/UNBM15CZj3FlCl9viIBUAbMP2XiestHLLr6vJKWWS3FOSUPwZ2tjYxpQHJwSYc4Gp
         7+EXvmSwVJSuhbdqLgam+1nKB9Q2kxXDTPMe+DRERUABalbUtzoihdKcoOY2To0uTvhs
         lxD+wdw9nd1Z9Hki0rmf0wqTOS8ZKVT1kIcrVPldHj9LbkgcjPOJQVfJ41f4igOikVme
         nZHQ==
X-Gm-Message-State: AOAM532kBaqOuOfc++SXX7/oZ8bCd0Z0bybJUDUw3yrg6VltBPGC020k
        6MDnIfhacInwu3ccrVUhqUj8iKSuyqUS7Yj6fdzjaG1vIqRjyvX0ubBNKWLdCDkcXCLQ5hUaV0h
        8VxtFS11PQ0YBr2dTUYKsLRisNVHMPgtFxH2nakQs
X-Received: by 2002:a92:4a07:: with SMTP id m7mr14860726ilf.51.1614147707274;
        Tue, 23 Feb 2021 22:21:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUE5E17/IqjMXLGNS9EuvKkA8xztrgsqBgHsdr/nHmPGVY9UC2nPPWkLzwnuL/BqCfevMiurSupd6wZLFyzYE=
X-Received: by 2002:a92:4a07:: with SMTP id m7mr14860697ilf.51.1614147707031;
 Tue, 23 Feb 2021 22:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20210223174153.72802-1-saeed.mirzamohammadi@oracle.com>
In-Reply-To: <20210223174153.72802-1-saeed.mirzamohammadi@oracle.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 24 Feb 2021 14:21:35 +0800
Message-ID: <CACPcB9dgH34bSd2WzOF3aJAx4VMH=iY4X_KZ2Lanh99ycObBiQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] kernel/crash_core: Add crashkernel=auto for vmcore creation
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     linux-doc@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@kernel.org>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:45 AM Saeed Mirzamohammadi
<saeed.mirzamohammadi@oracle.com> wrote:
>
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
> different kernel distributions and different archs based on their
> needs.
>
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
>  .../admin-guide/kernel-parameters.txt         |  6 ++++++
>  arch/Kconfig                                  | 20 +++++++++++++++++++
>  kernel/crash_core.c                           |  7 +++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 75a9dd98e76e..ae030111e22a 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,7 +285,8 @@ This would mean:
>      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>      3) if the RAM size is larger than 2G, then reserve 128M
>
> -
> +Or you can use crashkernel=auto to choose the crash kernel memory size
> +based on the recommended configuration set for each arch.
>
>  Boot into System Kernel
>  =======================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e3cdb271d06..a5deda5c85fe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -747,6 +747,12 @@
>                         a memory unit (amount[KMG]). See also
>                         Documentation/admin-guide/kdump/kdump.rst for an example.
>
> +       crashkernel=auto
> +                       [KNL] This parameter will set the reserved memory for
> +                       the crash kernel based on the value of the CRASH_AUTO_STR
> +                       that is the best effort estimation for each arch. See also
> +                       arch/Kconfig for further details.
> +
>         crashkernel=size[KMG],high
>                         [KNL, X86-64] range could be above 4G. Allow kernel
>                         to allocate physical memory region from top, so could
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 24862d15f3a3..23d047548772 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -14,6 +14,26 @@ menu "General architecture-dependent options"
>  config CRASH_CORE
>         bool
>
> +config CRASH_AUTO_STR
> +       string "Memory reserved for crash kernel"
> +       depends on CRASH_CORE
> +       default "1G-64G:128M,64G-1T:256M,1T-:512M"
> +       help
> +         This configures the reserved memory dependent
> +         on the value of System RAM. The syntax is:
> +         crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +                     range=start-[end]
> +
> +         For example:
> +             crashkernel=512M-2G:64M,2G-:128M
> +
> +         This would mean:
> +
> +             1) if the RAM is smaller than 512M, then don't reserve anything
> +                (this is the "rescue" case)
> +             2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> +             3) if the RAM size is larger than 2G, then reserve 128M
> +
>  config KEXEC_CORE
>         select CRASH_CORE
>         bool
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 825284baaf46..90f9e4bb6704 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,7 @@
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/kexec.h>
>
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>         if (suffix)
>                 return parse_crashkernel_suffix(ck_cmdline, crash_size,
>                                 suffix);
> +#ifdef CONFIG_CRASH_AUTO_STR
> +       if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +               ck_cmdline = CONFIG_CRASH_AUTO_STR;
> +               pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +       }
> +#endif
>         /*
>          * if the commandline contains a ':', then that's the extended
>          * syntax -- if not, it must be the classic syntax
> --
> 2.27.0
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>

Thanks for help pushing the crashkernel=auto to upstream
This patch works well.

Tested-by: Kairui Song <kasong@redhat.com>


--
Best Regards,
Kairui Song

