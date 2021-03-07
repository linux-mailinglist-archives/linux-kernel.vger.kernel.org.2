Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1C32FE79
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 03:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhCGC0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 21:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCGC0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 21:26:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36595C06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 18:26:34 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so12725978ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lt1/9JTwfyg5MlGxotiAzxizfTr7MWqSxJd8m5gWyQ4=;
        b=mAp/jMjt+wykUF9v0ykgFLz6PTNOpNQM9blQ9DF7bZde2jZfA00XCsQgtKBfTSlYce
         tSoUerIqxJ2owjF0hHWIN2ZZ4xL89n2gPFU8CmPLG4iOzFcUwlgwVsRIeFyzmReMrPlE
         fjvVZ/rACyvd4pvKigRLg+U1cqjAv9utGPsBMmPuEF1GqWxf+eGcj/FICqg2HzY4Wq79
         5pXBVeoOJfrssd+SuaOUABEegepSZFmpQiwUogTQ4l0YW8csCQr0WlBgLQQmv28qWkW0
         CXxKHRXmlBQ3XZOSxLhDLgG3PQHZVaY+hDiwjewWjWTFrbgLgQKj0VGKMa7QtmVIKYc0
         I24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lt1/9JTwfyg5MlGxotiAzxizfTr7MWqSxJd8m5gWyQ4=;
        b=NRH2yJtuj+Ia8+qA7/GjyBFqw1fdBpySEri8IGjbrdlYo/GnhW9ZGfKWtNF8jwESYy
         qCKrn7+WxPORbuDWLPimNIFslcEZKjxvY1F5Un/wJXDBjSvEpFAfzsqsxLIPCIGIfZKo
         d5Hm8MK2iWwt9TxmHH6PniEo0XNAkINImBYGbnPmr7gmfV9Rh2iorT5GMf5ASIZwQ+yF
         RgBHdfIdX2HNWnVS4re+Ok93tYPq3uTmtvCa4MNVCFff925thkVO2KL7LogHxmj+7IHD
         slA6IVHZfG8S+gEGZFqJbCCWUaH4ge1sGBgTIxerGpwU0+ZC8wpSBpcGL8BReqPcB0CA
         qfTQ==
X-Gm-Message-State: AOAM531/XNsreTP//TOa2/EtiIhjP4Dlv5bG8615wYSxeOW5r3iXf/wK
        65R06J+EcDpTZl2jI9wUSHBVgDtMimcECOPGe2FR/Q==
X-Google-Smtp-Source: ABdhPJx8IoQDh6tDArpeRCCsLfc89KTCbSDAKu2HG3fXgbu3oeb40U29dutBzbfy3rP8PChF3CqMv51puBcOXIeNaRY=
X-Received: by 2002:a17:906:444d:: with SMTP id i13mr8726833ejp.170.1615083992065;
 Sat, 06 Mar 2021 18:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20210305120851.255002428@linuxfoundation.org>
In-Reply-To: <20210305120851.255002428@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 7 Mar 2021 07:56:21 +0530
Message-ID: <CA+G9fYs98KrYbhoWM3RzSPEe5-nQWZO0cYUqT5a4X3e9AvD+iA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/41] 4.9.260-rc1 review
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

On Fri, 5 Mar 2021 at 18:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.260 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 07 Mar 2021 12:08:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.260-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.260-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: e118f9b98b963e03939869e5953a52351352f216
git describe: v4.9.259-42-ge118f9b98b96
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.259-42-ge118f9b98b96

No regressions (compared to build v4.9.259)

No fixes (compared to build v4.9.259)


Ran 39259 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
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
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sysctl
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-zram
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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-firmware
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* libhugetlbfs
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* network-basic-tests
* kvm-unit-tests
* ltp-open-posix-tests
* kselftest-vm
* kselftest-kexec
* kselftest-x86

--=20
Linaro LKFT
https://lkft.linaro.org
