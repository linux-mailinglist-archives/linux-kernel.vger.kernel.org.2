Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFEF3D0CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbhGUKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhGUJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:51:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:30:04 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w14so1749133edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YmKAu6pikxHl7GzDzhAFFQ7A4Rj7cfag8yxs2GUbOH0=;
        b=RxqaTore1jFbUcUe6rW8GXjzpy2fg9SbFgp1rbHv6nQo9yvAS/ZBE4fqfvDGT6zmeq
         vZdVaiCznPgDC8Vmk4DuFIvXQ+rX9aVQA7M6U3cCYaALMcDY9QENO8V0kxaBe7VblrvI
         qQo9F6P4ZVbWy8cEY60aF6QoPBk7lZSl9wy6Dcn5LIXgSjx/UGnUEvAcPK5LA8zssP9f
         tI4NVbrxfEaRvTLglGcBuhbIoYRXa9C7C1sYftz52te4SrnopqZCXAMOlxG5n9WZNXjl
         nFJItf1PIeL3wqTJYoV9F3n9t4pFB6s2qtSQ/nRilTqTNjh4Y/Y0qtl9EYcGn4aCOdS/
         8qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YmKAu6pikxHl7GzDzhAFFQ7A4Rj7cfag8yxs2GUbOH0=;
        b=F+q7tHG6Y8mkD3gp60M52oyhAf4FJIxzBPMsP1KuO0epfmQ1X3LV7u3Ok6yJcznBTf
         VrLM5klSTw4EFQVwcmhvAYYFL+c4FiLENFUV0vsgKmltdHo8wVpAlMAx1S3iJSLJ85/D
         XrDFMr7vrv2xJwjkaRFIQNYtDH57vP6NdZGSCIie73ugXOtbxMpw8peQl55ImGIOj38N
         uqLQbvMYvfRv7LsdDfxcIXgS+huFAC4r9naEK8VcpjIhNW6T4zolF5h93+78bpWBKyNJ
         0eNLTaeJSkv3XLk9TEeb/QvuxNQ34ss3ou988pKXoPCjpznFBstbXZmA2K+kMg8oiVBm
         Kbog==
X-Gm-Message-State: AOAM533rSl+ARn79YAHaHU7hTpJXRvSbYMfODZ3RL5/sZYDqrkn3WXyU
        tCK3duWSZ3yrm47UQsMLZDpDYFsHMWrh1ss12owU9w==
X-Google-Smtp-Source: ABdhPJxfS9FpxGbS3lEkz0KD/K2JXWR/18PuQ4JFvUNn7OLrLWjVf8OMliTM0ABMMGncEX6LY2vTZFYuwELVKem20aY=
X-Received: by 2002:a05:6402:4386:: with SMTP id o6mr7878135edc.239.1626863403329;
 Wed, 21 Jul 2021 03:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144940.288257948@linuxfoundation.org>
In-Reply-To: <20210719144940.288257948@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Jul 2021 15:59:51 +0530
Message-ID: <CA+G9fYt7PavdDfqEmf_xRXoRAJ1a5kMKf3N_h1KhauBeTBJguQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/245] 4.9.276-rc1 review
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

On Mon, 19 Jul 2021 at 20:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.276 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jul 2021 14:47:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.276-rc1.gz
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

## Build
* kernel: 4.9.276-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-4.9.y
* git commit: 04afcb7e33f59d83d1e1bf39a8c0d9bbe6df454c
* git describe: v4.9.275-246-g04afcb7e33f5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.y/build/v4.9.2=
75-246-g04afcb7e33f5

## Regressions (compared to v4.9.275-185-g85e806546048)
No regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## No fixes (compared to v4.9.275-185-g85e806546048)

## Test result summary
 total: 58298, pass: 45562, fail: 520, skip: 10368, xfail: 1848,

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 24 total, 24 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 14 total, 14 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 14 total, 14 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-android
* kselftest-bpf
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
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-lkdtm
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
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
* kselftest-timens[
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
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
