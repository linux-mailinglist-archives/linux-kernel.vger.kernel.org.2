Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B1433014
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhJSHty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhJSHtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:49:49 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943FC061749
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:47:36 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so1238461ott.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZIp5y20MTLUX/wuWPcFL6uTZh+zoI77h3dAGydOu8xA=;
        b=vXlzQB/zVj1oGRzM8bgVZ+LNTlaXx1CvSlpO+BKpQ5Y4HQTaEskLg6uWtWVjSI14sA
         oZeOhP92ZHJZhcXhErorWBi40nkLKqIrcE0TGEjZYGF6am1axjqTEsIoXU6s6yS9k5+C
         PKvlKqY2VzlmlO4xwpN/kN+4MK1G9/JLrj9u+W1JhgGT0HfGATk1w7dv3OSdOHWyFAJX
         jRy9cWr6kJvBv+oPth5B02OJLPLYCf6ttgAahLRbxvXfkAQWuElYo4hBMRGh4jkgIdra
         tc4K3myjL9wPCahlREXnLUj2Zz10Xn9+yggi91pdq9MJ1Quc1zXUplxbtTE5XItnd3KW
         Vgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZIp5y20MTLUX/wuWPcFL6uTZh+zoI77h3dAGydOu8xA=;
        b=MXyt50qbthhCdcvMqaHGllaN66V+GmaQ4KaLk9b9CH24Yy8LjZFHqttidQTrXdkz+i
         5vGUr2iEs+p0MRUSMrbMjFN4l3kq/gGKnX3npigOJZC2501RYTGLFBVgZZMYkC8mjMfV
         vqa7BvJWvZEmnmC3UzB8bvwKugbNWNaslFxwKTriSdJFPrU4zup98WMQ8+6pqqJhyEmV
         ee5Gz1ffEvNiseTxlaFbCsPr+PZZekEVJeyc2d5XBLPuxX8cZsc6DU7aYRyN+NUmq0XA
         XmvNBFHPzN/7plbtiaMwxhkHx/Z1NZRYeVfMcVmMn34YKvyUT54AIPS/yIi24Tjv3vQ5
         KXww==
X-Gm-Message-State: AOAM532hzLNMhs0LU914a9rFhxul+rvViDCfxsrLPMJuz2WuGmCpncg1
        5EiaKY9JwF0OhyMrq6qk07cWs0jCCg1DUJVnmmwJrA==
X-Google-Smtp-Source: ABdhPJyF3q5Fyl4/SI7GH3gFF++NnJe0H55v5pAfYvt6+j+25IMh4X0/XM/iuG+o9YjZDMencCp3S5/FdqYg4PKEJCQ=
X-Received: by 2002:a05:6830:4011:: with SMTP id h17mr4042422ots.208.1634629656070;
 Tue, 19 Oct 2021 00:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211018143033.725101193@linuxfoundation.org>
In-Reply-To: <20211018143033.725101193@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 Oct 2021 13:17:23 +0530
Message-ID: <CA+G9fYsQpWaxEij6cAnvthCBpk9YC-wGtJE9Kd1b+=2p0532XA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/49] 4.19.213-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 at 20:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.213 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Oct 2021 14:30:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.213-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.213-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 30fdb0bbff04f8d763c2252764a13735ce7a6641
* git describe: v4.19.211-63-g30fdb0bbff04
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.211-63-g30fdb0bbff04

## No regressions (compared to v4.19.212-51-g6332251ed7a3)

## No fixes (compared to v4.19.212-51-g6332251ed7a3)

## Test result summary
total: 81108, pass: 66428, fail: 530, skip: 12173, xfail: 1977

## Build Summary
* arm: 129 total, 129 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 29 total, 29 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 21 total, 21 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kselftest-android
* kselftest-arm64
* kselftest-arm64/arm64.btitest.bti_c_func
* kselftest-arm64/arm64.btitest.bti_j_func
* kselftest-arm64/arm64.btitest.bti_jc_func
* kselftest-arm64/arm64.btitest.bti_none_func
* kselftest-arm64/arm64.btitest.nohint_func
* kselftest-arm64/arm64.btitest.paciasp_func
* kselftest-arm64/arm64.nobtitest.bti_c_func
* kselftest-arm64/arm64.nobtitest.bti_j_func
* kselftest-arm64/arm64.nobtitest.bti_jc_func
* kselftest-arm64/arm64.nobtitest.bti_none_func
* kselftest-arm64/arm64.nobtitest.nohint_func
* kselftest-arm64/arm64.nobtitest.paciasp_func
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers
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
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-net
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
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
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* packetdrill
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
