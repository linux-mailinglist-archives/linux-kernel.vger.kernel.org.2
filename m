Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC898418A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhIZQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhIZQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 12:32:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF928C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:30:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 24so22308004oix.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgTVTVyKTCId8BddyM/UIU5f5RopTrQf6ZhPx7QN2YQ=;
        b=lxElJf8peiV3NEF3z5qQa9YcmdqK8qlnZ6awMpKUNDiMgjqR3sy74jA87Gg7fS83MN
         qWMAfT2myauB3S/EhpVS7alL2uFjlMY54oUi+DkJmLbYtzr5YBV+5Rq438WZb+BXypLr
         WmqCtecPEx4rUiBlMT4vp5IBYp/PKFju9OLPulVL3HdAC8XlE2RroyY5R0BR9A9TNjy8
         FDAKp/nibAEDDdScJwraaqceehLKYN+DJWQGzV+OPDN3qJ2rA9uNYaWuqVh1j9se+LMx
         8ZDowqZHDm8t70TibdrbbkRELY6N/KjucFT908kZXDX+mY5kNwW4Z5zYACo6B6o+DLpJ
         PFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgTVTVyKTCId8BddyM/UIU5f5RopTrQf6ZhPx7QN2YQ=;
        b=5aTpm4lm9SFSp+8bwgatXpZi8GXIlnfrJYp5x5WTAKDvI/AsEc6ONO9iQBtwd9vx+O
         RIP29IUMeptjSxhdVjs03Y4rnEsbLmdAgAoQ22MLTqC7isFL2fw2BiHMPMR8jURwCSp5
         8Es8MjkkqHrswt022ObhC4978z9v4Hai7ViQWXGzJUA0+TneZgJ8LD3ZmSW+8P0Ej5OV
         ESrRPBKwIDaRlIXi8hxWTF6sSt2vnaNkMfHq+UX6IEY/nPPYqd4rv+8saEnM9iiOIJh0
         CMGa7oCE6RxK/8axzyycuiyoQ4xCZnKj8aWLUbmFNXwm1y1S9DJQdY8C7O6FxAcqyT2f
         opXg==
X-Gm-Message-State: AOAM53040IdJhli6JsxHMY9jxKqt/M/fAYLkuCEE13AHpsJ2nsUQN3XA
        p+D2E2ZBiE3qWVbjbCOYYU9k4A==
X-Google-Smtp-Source: ABdhPJyATSNRhp4p1xWzpcxyX9T0sFW6xI9BTOV8Cmkj6n/bfoO3MF5z0Lfqky0KNOSubd2SfGLzuw==
X-Received: by 2002:aca:1b09:: with SMTP id b9mr9208666oib.55.1632673839281;
        Sun, 26 Sep 2021 09:30:39 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.73.83])
        by smtp.gmail.com with ESMTPSA id d26sm3356907oij.49.2021.09.26.09.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 09:30:38 -0700 (PDT)
Subject: Re: [PATCH 5.14 00/98] 5.14.8-rc2 review
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, stable@vger.kernel.org
References: <20210925120755.238551529@linuxfoundation.org>
 <ec21dcf7-705a-8748-1c06-030a70c17d08@linaro.org>
Message-ID: <be688053-fa8f-f420-94e5-4a50bc6da2ac@linaro.org>
Date:   Sun, 26 Sep 2021 11:30:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ec21dcf7-705a-8748-1c06-030a70c17d08@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/26/21 11:17 AM, Daniel Díaz wrote:
> Hello!
> 
> On 9/25/21 7:14 AM, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.14.8 release.
>> There are 98 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Mon, 27 Sep 2021 12:07:36 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.14.8-rc2.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.14.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Results from Linaro's test farm.
> No regressions on arm64, arm, x86_64, and i386.

Actual results from Linaro's test farm for 5.14.8-rc2.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.14.8-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.14.y
* git commit: d5486defd573c843da1a39733c64d9bf57119c47
* git describe: v5.14.7-99-gd5486defd573
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.14.y/build/v5.14.7-99-gd5486defd573

## No regressions (compared to v5.14.7)

## No fixes (compared to v5.14.7)

## Test result summary
total: 87988, pass: 73157, fail: 1108, skip: 12669, xfail: 1054

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 289 total, 277 passed, 12 failed
* arm64: 39 total, 39 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 38 total, 38 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 51 total, 51 passed, 0 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 30 total, 30 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x15: 1 total, 0 passed, 1 failed
* x86: 1 total, 1 passed, 0 failed
* x86_64: 39 total, 39 passed, 0 failed

## Test suites summary
* fwts
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest-android
* kselftest-arm64
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
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-vm
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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
* ltp-hugetlb-tes[
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
* prep-inline
* rcutorture
* ssuite
* v4l2-compliance


Sorry about the confusion. Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
