Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F541427C85
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 20:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJISLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 14:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJISLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 14:11:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E6C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 11:09:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x7so47284959edd.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FIaFka5X6iyYe0F/eWqoylqOPQEwje3SRInyQYgDF4Y=;
        b=ijw4Kt918r/OfIyvsp0wwrf70KlpyMKfubntAgdqBCxtnHFz6G1123QjxrGs1sUtgT
         Bw261897+B1b+hgomAYXeHu6oJrC/sgGSjo2lL5a8Lfh1x8Nt2iVq4SoTGfZ5o4CcsYK
         Lai1TVabkLi0PFD80aDpcKuTdLqiD1897hrd9HypXkJi4AelZAa32a41Z4iszVWiiYnP
         ZsoWbi/db2wABpqF2Ng2O0G/ebkA/1xbN9lxdCHFyozCO8wccRNurbHHUvINKAwvqtCF
         4PTC+hlcALP725tVQDy756hpY9GLeXY7v9/TMVn7NP9+Ah7DCN/AJ5IqrbQLj5NRBX91
         Q5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FIaFka5X6iyYe0F/eWqoylqOPQEwje3SRInyQYgDF4Y=;
        b=6mhbD+nuz5o0oakCNxBnKB1H15sAM72xF3+z5sBOHe+a8bzcqDgnQHZr+a/j0PNQ2p
         damVvG02G1eKxEqrLjWnacceYD3nkPwh+MDGncNRakxANHkpidHEZxjJ4h+EkhEb34qL
         rZyQMSi3J1CFi2U0+s5t7ZYpspS4sH72hjKjUCBEsLv48xB04bFNJIAALEsJQ0TSMkfU
         W9uSFZUsmcpNWESGFp1sh8/Lk2eKt5PPDZSjY69S1jeNdrltN+nIDcwvUN1krjXXoszy
         23VEZX1xqaJhWwcL3YS81e0Jsvl/jKPxQuA1pPtnV3CHzgXOzJeHfD9K37J69vScI35w
         Ajjw==
X-Gm-Message-State: AOAM531qcUtSZMAAB0XLgW6ngoiiL9ExcNeFjIh/xoy9t8G3IUoyU0hB
        OBy+2nYH4IfxycThgjt0+s5I42BWH8rB8emasGmCmLfIUQ2SGA==
X-Google-Smtp-Source: ABdhPJxEVdQpR8anq26O6qkMpSmwU/kLCHzGXcr3chPdzyYX3xQtbuulzt6pZ+cn6ArWPjoQaBNZ/GFlR0Mpqqnbq1Y=
X-Received: by 2002:a17:906:c7c1:: with SMTP id dc1mr13707830ejb.6.1633802976553;
 Sat, 09 Oct 2021 11:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211008112713.515980393@linuxfoundation.org>
In-Reply-To: <20211008112713.515980393@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 Oct 2021 23:39:25 +0530
Message-ID: <CA+G9fYtdr2v5ZKr+N2x1BtkvTyfPHLEgU2gJgVGyHsr9SA-xAg@mail.gmail.com>
Subject: Re: [PATCH 4.4 0/7] 4.4.288-rc1 review
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

On Fri, 8 Oct 2021 at 16:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.288 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 10 Oct 2021 11:27:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.288-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.4.288-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.4.y
* git commit: c9a8123a0640ee5387d3cd085463889b75d686f2
* git describe: v4.4.287-8-gc9a8123a0640
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
87-8-gc9a8123a0640

## No regressions (compared to v4.4.286-2-ga123b2f4737a)

## No fixes (compared to v4.4.286-2-ga123b2f4737a)

## Test result summary
total: 55614, pass: 44506, fail: 262, skip: 9502, xfail: 1344

## Build Summary
* arm: 256 total, 256 passed, 0 failed
* arm64: 66 total, 66 passed, 0 failed
* i386: 33 total, 33 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 48 total, 48 passed, 0 failed
* sparc: 24 total, 24 passed, 0 failed
* x15: 1 total, 1 passed, 0 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 34 total, 34 passed, 0 failed

## Test suites summary
* fwts
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
* kselftest-membarrier
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
* perf
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
