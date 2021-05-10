Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36224379684
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhEJRzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhEJRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:55:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB6C061760
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:54:24 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so25855481ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uxDDskVd8yPhLUA4OUYRxmOdB7NJo1UMRxyXj9tE2ew=;
        b=v79g2WeOkfQYHp0bxTaxMsFXm0XCHRQ+lfeIZ8Pfljo/jKJhJW9MXCacOxpPAmc14K
         seD+PpsJshYT7b79rXCfa+1VxenehA1RcWgTNNeL7PrVQ6C//EVG9iqyYDQCLetefort
         f3P5XYv+TChBXE0i/wUuefi3pRFE+Wd4u0cCI9ZM15wJjMoTf+8xASeMxL4j1as7Yw7z
         QV8TL7uh2zw+qL8Q1bqY2AQnwSAADW9aLL6DddDB0PjhE83kEEbNVHXjWbOz+BGkCDv4
         MEqO22Kleg+Ab5tWJ+05PTGgy7xOZvUtMjc+3Mx+WjH/eA43eagcQfUIhrYsCDuwa/F1
         FR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uxDDskVd8yPhLUA4OUYRxmOdB7NJo1UMRxyXj9tE2ew=;
        b=hqLRtFxsnFO4/fdwFaRoXUY/mCWNAX4yzcu6wFkkBaidF8ZIVQMdmDqZJcmwyY/FBx
         JyG0UOBfuGv+iFhLTZ5Ley0PfdshgYEXwV3aoWFCtp0fP4ww1/2hI7zEx3+P7b0S5HCS
         Zq0Q4rWpAYmYuKT4MNzBktk+Fj5hwMEQvYr7gZyAoZPAS3UbjNUrLAWGwMxnRYvRt2R3
         8d5OaUcjjgl85tq6VK8OjNZbX2w172HOjXBcglXo557aNOXj3nHa2QBAGiYy+KzIIvDc
         ioQUeNVJn/wH1fXdFHn/5FuMgWEYx3Rl3pwd97N02KTYLaXn5397J8s2JgOtdhDJ0YI9
         3DmQ==
X-Gm-Message-State: AOAM531SJAURhQ0MZ78Ut97N/Pz9ysHUlTgomEfhq7rQ4KMWyRJF2Qtj
        UTPEfx1QcWsL9wRlKkeCNerdzn2CD0GeHAWzaSmoRHuha1UEKGoT
X-Google-Smtp-Source: ABdhPJyVT4av+Gitz6piMDlZi4RtW4oM8c9kehsLsgZIDmz3LEzUseffiyD4Wav4feeeiI24kObuY1nea7i1+s45wH4=
X-Received: by 2002:a17:906:17cc:: with SMTP id u12mr26777505eje.170.1620669262641;
 Mon, 10 May 2021 10:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
In-Reply-To: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 May 2021 23:24:11 +0530
Message-ID: <CA+G9fYvnM6rd2Sd7WdQmb-GFRF8y+QG1J3ocJOQKV0V0g=PofQ@mail.gmail.com>
Subject: Re: Linux 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 at 03:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So two weeks are over, and the merge window is closed.
< trim >
> The merge log is obviously woefully inadequate, with the diffstat
> summary kind of showing why:
>
>   12015 files changed, 631309 insertions(+), 246239 deletions(-)
>
> it really is a fair amount of stuff, all over the place.
>
> Go test,

Results from Linaro=E2=80=99s test farm.
Regressions detected.

Summary
------------------------------------------------------------------------
kernel: 5.13.0-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
git branch: master
git commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
git describe: v5.13-rc1
Test details: https://qa-reports.linaro.org/lkft/linux-mainline-master/buil=
d/v5.13-rc1

Regressions (compared to build v5.12)
------------------------------------

Regression on TI BeagleBoard-X15 arm32 bit platform as the device was not a=
ble
to detect SATA drive.

Which is fixed by Tony Lindgren but this is yet to get into the mainline tr=
ee.

"
Naresh Kamboju <naresh.kamboju@linaro.org> reported that Beaglebone-X15
does not detect sata drives any longer after dra7 was flipped to boot with
device tree data only. Turns out we are now missing the sata related quirk
flags in ti-sysc that we used to have earlier.

Fixes: 98feab31ac49 ("ARM: OMAP2+: Drop legacy platform data for dra7 sata"=
)
Fixes: 21206c8f2cb5 ("ARM: OMAP2+: Drop legacy platform data for omap5 sata=
")
Link: https://lore.kernel.org/regressions/CA+G9fYtTN6ug3eBAW3wMcDeESUo+ebj7=
L5HBe5_fj4uqDExFQg@mail.gmail.com/
"
ref:
https://lore.kernel.org/linux-arm-kernel/20210507112857.12753-1-tony@atomid=
e.com/


## Test result summary
 total: 63780, pass: 53717, fail: 1047, skip: 8782, xfail: 234,

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 194 total, 194 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* dragonboard-410c: 1 total, 1 passed, 0 failed
* hi6220-hikey: 1 total, 1 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* juno-r2: 1 total, 1 passed, 0 failed
* mips: 45 total, 45 passed, 0 failed
* parisc: 9 total, 9 passed, 0 failed
* powerpc: 27 total, 27 passed, 0 failed
* riscv: 21 total, 21 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 18 total, 18 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x86_64: 28 total, 28 passed, 0 failed

## Test suites summary
* fwts
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
* rcutorture
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
