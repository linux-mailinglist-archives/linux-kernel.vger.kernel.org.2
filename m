Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C73C7D95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 06:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhGNEgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:36:43 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:51696 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNEgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:36:42 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 16E4XeBV011184
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:33:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 16E4XeBV011184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1626237220;
        bh=Jfxt3oskZcOMrnIPssmXfdXIhxmTXhY6vaQReBzh+Mk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8/KiIcubEC8gPj6FFM2VgTopzGCxI84sg/YDGeC+L0vA2qVZWlVnO4QIiKizSMzB
         D/rb8qYxZaO+CdnMNt7H0Q7Sr1B1VZJTlocS47IbF062kLGcUvrMaHldLWw7rJU8QL
         SU2MBdoz+HSgYeN+seU3Ng6RO5kATLWMpdqTUmnAhSNtmEf90dc2rn8sk77r0oDpS6
         MXhJKqONVR29HpujHyNPhk7UZsV45az0zT6SU9LhD035TaYlrK7x/VTvaBGakt9Ypy
         C6u/YBIEcv0HDqBtXjC40ss5Z+RaY+PbbqPDeM5ZQsoyQJ4JR3CYF3vwDloQQpvxu+
         RJH04YlxUQWlg==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso932850pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 21:33:40 -0700 (PDT)
X-Gm-Message-State: AOAM530H4/sgpIb5PQcuN1oKhQ7NVO41Arh8CT1MM7qcd6vFGergmWHb
        D6S5oS81YqY3Fb11PNaQVu2XO0rrgidjIcePka0=
X-Google-Smtp-Source: ABdhPJzZNrTC1BGrrz+AM2LG+qFznTejrIJbLLdrcmZdPufmJUHdOMbfQ82DtAKB7QIZQ1HrgOlDhhtVtt05YVQ1ShI=
X-Received: by 2002:a17:90a:a383:: with SMTP id x3mr1826943pjp.87.1626237219662;
 Tue, 13 Jul 2021 21:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <c4d2f929-9a1f-d816-5a24-e2bf8a64fa8f@i-love.sakura.ne.jp>
In-Reply-To: <c4d2f929-9a1f-d816-5a24-e2bf8a64fa8f@i-love.sakura.ne.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 14 Jul 2021 13:33:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT4Jznx5_Tr8jWbdcmJ6zwqAoF9Jcvn89a5+wsGNd9G1Q@mail.gmail.com>
Message-ID: <CAK7LNAT4Jznx5_Tr8jWbdcmJ6zwqAoF9Jcvn89a5+wsGNd9G1Q@mail.gmail.com>
Subject: Re: [5.14-rc1] kbuild: stdout from cmd should not be discarded
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:40 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit 174a1dcc96429efc ("kbuild: sink stdout from cmd for silent build")
> confuses users by sending prompt messages from
>
>   scripts/kconfig/conf -s --syncconfig
>
> to /dev/null before start waiting for response to prompt messages
> when building with "make -s". Reverting that commit fixes this problem.


Thanks for catching this.

Instead of reverting it,
I'd like to fix the syncconfig part.

https://patchwork.kernel.org/project/linux-kbuild/patch/20210714042349.219199-1-masahiroy@kernel.org/


> ----------
> $ make
>   SYNC    include/config/auto.conf.cmd
> *
> * Restart config...
> *
> *
> * General setup
> *
> Compile also drivers which will not load (COMPILE_TEST) [N/y/?] n
> Local version - append to kernel release (LOCALVERSION) []
> Automatically append version information to the version string (LOCALVERSION_AUTO) [N/y/?] n
> Build ID Salt (BUILD_SALT) []
> Kernel compression mode
> > 1. Gzip (KERNEL_GZIP)
>   2. Bzip2 (KERNEL_BZIP2)
>   3. LZMA (KERNEL_LZMA)
>   4. XZ (KERNEL_XZ)
>   5. LZO (KERNEL_LZO)
>   6. LZ4 (KERNEL_LZ4)
>   7. ZSTD (KERNEL_ZSTD)
> choice[1-7?]: 1
> Default init path (DEFAULT_INIT) []
> Default hostname (DEFAULT_HOSTNAME) [(none)] (none)
> Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
> System V IPC (SYSVIPC) [Y/n/?] y
> POSIX Message Queues (POSIX_MQUEUE) [Y/n/?] y
> General notification queue (WATCH_QUEUE) [Y/n/?] y
> Enable process_vm_readv/writev syscalls (CROSS_MEMORY_ATTACH) [Y/n/?] y
> uselib syscall (USELIB) [Y/n/?] y
> Auditing support (AUDIT) [Y/n/?] y
> Preemption Model
>   1. No Forced Preemption (Server) (PREEMPT_NONE)
>   2. Voluntary Kernel Preemption (Desktop) (PREEMPT_VOLUNTARY)
> > 3. Preemptible Kernel (Low-Latency Desktop) (PREEMPT)
> choice[1-3?]: 3
> Core Scheduling for SMT (SCHED_CORE) [N/y/?] (NEW) ^Cmake[2]: *** [scripts/kconfig/Makefile:77: syncconfig] Interrupt
> make[1]: *** [Makefile:626: syncconfig] Interrupt
> make: *** [Makefile:735: include/config/auto.conf.cmd] Interrupt



-- 
Best Regards
Masahiro Yamada
