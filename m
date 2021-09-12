Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D1407B27
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 02:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhILAtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 20:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhILAte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 20:49:34 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F0C061757
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 17:48:21 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id t2-20020a4ae9a2000000b0028c7144f106so2039174ood.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VnOnqsSWD31QyEGDrq96azBZ0UWU9luvvX/xRrPvWyQ=;
        b=IIja/gHreXaIG9rsnGbH+VslLedKuVXACi5x9CaX+rKlWTiucNMAC8nMo1RmCQbZJO
         PxMULR3jaqPXx/Ez+ksEQyw2EAtbbPYsYybOxfWfqtbSmnpaGjZJDT6T7V+Jgcz2N0WU
         xV1RuFwMS2yyGL5vI4vojTQgjCUuB7zsYJP3nJ95SjL6nXo1In78OXILWhYaXa6TrSAY
         v1MFYfUgj8vWfjmfd2fSxCNJGJ+yJ24o1YUFDV7v+ERpPfoBVSSDzl4ZAlrX3zne0Xs2
         CU7+NwGNhbkDNdR/MOJCWETf1AgMXfYjDd2UztKgGXMCUTjX3w7U8OlYUfQF4NOqV7Hp
         juLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VnOnqsSWD31QyEGDrq96azBZ0UWU9luvvX/xRrPvWyQ=;
        b=SG0QmrDS4mvZLG6cJ+PouIM8bJrW8zsxk19wYULQrMBu9zhmYEBdOnv9x7asD6EIc2
         frPawH5TOMGswXoHzBFG6bexgE9TFVugw8+8Q1kK/OpsaqjkuVjmq6fkb3LWV5NJS3bT
         GlZfEtrx1KtlQKszHoChVu1TzwadCL75CFK8NzHNGOSfmG3mQe5ElUJ0jSmP2V3f20ii
         rsGL8kM7jRjZYEGd/5F5zmk7zFncTkrjDbD8QFfIFhX9y9lesWI8a1DsVJH0MKfQ4CC5
         lj66B7PFc/+b+AIUVS3iZYY97Rec3i5nCu6w11r5xRttD0X2sl9OopsAPn4njmkx4Hm3
         yXbw==
X-Gm-Message-State: AOAM532V/aK5IeGKPlFheoBQo7Q5IAdGqDRxXQ9GoWjrG0saRU2OZmPT
        GgJXjhB/PaIctKw9o8CiWjdVYw==
X-Google-Smtp-Source: ABdhPJzmoP5worguyCqqr4J4kkp8LNFwNxyrvv4riCinHkpcLPUPby0er4x6O7MlcgJbzJl0c0+M9g==
X-Received: by 2002:a4a:b64b:: with SMTP id f11mr3908008ooo.18.1631407700530;
        Sat, 11 Sep 2021 17:48:20 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.73.83])
        by smtp.gmail.com with ESMTPSA id v4sm751961ott.72.2021.09.11.17.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 17:48:20 -0700 (PDT)
Subject: Re: [PATCH 5.13 00/22] 5.13.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20210910122915.942645251@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Message-ID: <9bcd24f5-cc7b-0685-d1d8-0dbacef537f1@linaro.org>
Date:   Sat, 11 Sep 2021 19:48:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910122915.942645251@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 9/10/21 7:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.13.16 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Sep 2021 12:29:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.13.16-rc1
* git: ['https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git', 'https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc']
* git branch: linux-5.13.y
* git commit: 7f37731955338b3af99536b085718d0ea73fdd16
* git describe: v5.13.15-23-g7f3773195533
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.13.y/build/v5.13.15-23-g7f3773195533

## No regressions (compared to v5.13.15)

## No fixes (compared to v5.13.15)

## Test result summary
total: 89607, pass: 74925, fail: 1092, skip: 12638, xfail: 952

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 289 total, 289 passed, 0 failed
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
* ltp-fs_perms_simple-test[
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
* rcutorture
* ssuite
* v4l2-compliance


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
