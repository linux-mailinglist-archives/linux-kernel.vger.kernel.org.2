Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81243345F27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCWNNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCWNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:12:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC6EC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:12:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bx7so23368622edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=At6h9HtAYwuTLdFKM+x4/s3wdVsIXqAsMlQ2fxYmR7s=;
        b=MEGaRfOqiUXFg1gyN6PYOqm3baosznFEqmNMBIizpK+bTWqFMhGsUAOdbED+Nw56C9
         SqJP2TMtKZjkhKPcQ8LfqyLQs0xd7AUhNIH1zAUzI1GCaZiaPujEevtxgT+QBm+NOYQ+
         kiP4m8v041+PkpNrhUupFpY2wkyWsxm03k/7bIOx5yI3wFrEtK4NJ41A4/DUfoiqV6hS
         nM2BgPzEUJ2EeuBFTiAIfY8EGLcy8Zp6i3ARm3H8ZUJZ1bVomczDik6LODxeXwU0Y8D5
         TFf7tJjbf18kyDnrmwOuhGXL9D3m73HZkTkOTBRUO4vlMNuI3iXF7vr+tVJLaBivofdK
         6tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=At6h9HtAYwuTLdFKM+x4/s3wdVsIXqAsMlQ2fxYmR7s=;
        b=efwz0ffZTrHeazsm6qcGNMxead5xYQ42nmyEEReQSovgrH3CDjqtlM+oqF9qODQrJV
         RYaV+aqAp8fHJ/TxfpxZjuZSrXQe3RLTfiuT9KVh4YH7laD4B7wFds1Dscsw8F+0kU/y
         I7A2hjdIMr1LIs8XACQY1K5d+0v9Dpe7aSxSbkxYdLpjlcMViXC2OuhvSJsRBbDllylw
         VvJ9Eq5oXveNjOsUXRjBabBqJ09B3hEGb3Em/Nqu8IXJOAIFHeT+HBGTVGOTN8JOJ7wj
         6gLvHE7+f1j84pGSODuRdX2hr29bo88PYkg4KCEz3MbJvR8TPP7if4QGqr0GDhZ7cVrE
         DWTw==
X-Gm-Message-State: AOAM531//NsqZGuqvXwJvJq4LZ1/QB2H8yyRf5QPg1ldNBdp+soqJrWV
        nuCdxvVWQSSDF0YXa+VHvk6BSkx8Elp3s4t6/yxkxw==
X-Google-Smtp-Source: ABdhPJzye5mE/iiUFqCn0X6hjoWPxPhCFuBkmO+oH48JgDTQXOUBKyn3CNzYbabRiR2Yb6a2SxRyFDf5ldEeprQWw10=
X-Received: by 2002:aa7:d287:: with SMTP id w7mr4511774edq.23.1616505149911;
 Tue, 23 Mar 2021 06:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210322121920.399826335@linuxfoundation.org>
In-Reply-To: <20210322121920.399826335@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Mar 2021 18:42:17 +0530
Message-ID: <CA+G9fYt-d+NQyL=8TrL-Pnc8zZ5Sno=3nAN=G10iuird8qpU7Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/25] 4.9.263-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 at 18:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.263 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Mar 2021 12:19:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.263-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.9.263-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git branch: linux-4.9.y
git commit: ee852ebcc01fee023a18f1ed0e34afc29b3f11d0
git describe: v4.9.262-26-gee852ebcc01f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.262-26-gee852ebcc01f

No regressions (compared to v4.9.262)

No fixes (compared to v4.9.262)

Ran 49031 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- nxp-ls2088-64k_page_size
- powerpc
- qemu-arm-debug
- qemu-arm64-clang
- qemu-arm64-debug
- qemu-arm64-kasan
- qemu-i386-debug
- qemu-x86_64-clang
- qemu-x86_64-debug
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- s390
- sparc
- x15 - arm
- x86_64
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* kselftest-
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-intel_pstate
* kselftest-kvm
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* v4l2-compliance
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kvm-unit-tests
* ltp-fs-tests
* network-basic-tests
* perf
* kselftest-kexec
* kselftest-vm
* kselftest-x86
* ltp-open-posix-tests
* ltp-syscalls-tests
* fwts
* rcutorture
* igt-gpu-tools
* ssuite
* kselftest-vsyscall-mode-native-
* kselftest-vsyscall-mode-none-

--=20
Linaro LKFT
https://lkft.linaro.org
