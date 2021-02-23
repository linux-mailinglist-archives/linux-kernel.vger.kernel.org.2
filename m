Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502DE322A26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhBWL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhBWL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:56:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E76C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 03:53:55 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id u20so33427685ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1XOwOWySZhnZCTnQyRrSazspBdCpbP9dpG2ed8fKOxw=;
        b=TUGjxLj9zQKKyGhe9FncpHrnFvNeWzLVP1BTUJbC5aTuqLBzWOOUzb0y+Younghy4Q
         eg9wf8J1GVYEygj4sBbFN2U2i6e+qha4IMpg+JtQi67M+27CD61wmSsLg44jxWfQv46m
         99Bd5zbVnWqZd+xFTEq1AG91V7rIF4W98BLRn2RmfEWDpWiR8+hPH0r37CohvNANe8rt
         E+3hJGsSRs4f6hO1MCjDhckCF6T3P04n7xKweaK76cT9lGIaAKZFlCzWyOjdBN2BcWHw
         WCIlXlMd7emfCcJhnkJKtOihpfCIhnFG9MuZVijGZMIOzhMD1tTx0//KdRMESa4HF7Zc
         oOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XOwOWySZhnZCTnQyRrSazspBdCpbP9dpG2ed8fKOxw=;
        b=PJY0+OjURq0tBN8vfslsuM4BEu+B71Y/BQHt9feAA2vdZ7zkCiusG9JHpu4p0qjVAK
         cOq0gsltmb7TKOYIemF2YFS96WP8VNDwtoTLQlBC1rMQP0e5+vRv312bwevR2pUbnRpr
         bAfufDhxye3Eynw2/laHvPvSOl1798vMJct2tEnOEhGhrZr7D4Ywd1habc/sDq/Kipmv
         PVIyFDWAIoc4A2tbvuWP2jNNP3SLnBOc+lIrG/HHsHatCfKLsYNeGqmlyo4kG5iBWRNW
         yHhYaVrQoAnkv7uQ42yz//cVlGghBXW9CH0bEsZkl2Jf0ajB0A4KD9tX3LrRhEM7Wlmc
         KVzw==
X-Gm-Message-State: AOAM530XpuapwLK1EJdrVmaCnpPDnW9SUo68Qpo/XLJtp4sY3CbNdjAM
        bOf7vCxcuf1kljUfSS0fWtxpItdkfhoLwCrYWNLeTQ==
X-Google-Smtp-Source: ABdhPJzzE4J/Ubge/VwImZiHNoYnxpZw76CeFnGlu4atJGD+ebLgzFB4eTccwXTVdmw3LKxiUMoiNyiUqND3pc/ghHU=
X-Received: by 2002:a17:906:d8ca:: with SMTP id re10mr25954018ejb.18.1614081232795;
 Tue, 23 Feb 2021 03:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20210222121027.174911182@linuxfoundation.org>
In-Reply-To: <20210222121027.174911182@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Feb 2021 17:23:40 +0530
Message-ID: <CA+G9fYv87zpv5xL1S8V=m9j=JGhf-J=vyxi4U_r2pb2y_=P29w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/57] 4.14.222-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.222 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Feb 2021 12:07:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.222-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.14.222-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5d849f076141b32ff58f296e2db48960d320954a
git describe: v4.14.221-58-g5d849f076141
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.221-58-g5d849f076141

No regressions (compared to build v4.14.221)

No fixes (compared to build v4.14.221)

Ran 41786 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-64k_page_size
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- sparc
- x15 - arm
- x86_64
- x86-kasan
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* fwts
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* v4l2-compliance
* kselftest-android
* kselftest-bpf
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
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
* kselftest-vm
* kselftest-x86
* kselftest-zram
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* perf
* kvm-unit-tests
* rcutorture


--
Linaro LKFT
https://lkft.linaro.org
