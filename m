Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7D309340
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhA3JXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbhA3JVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:21:08 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31152C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 22:44:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rv9so16167932ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 22:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NwtwwDl8Ln1YLoP2vDO3Z4Vm2x/tAqnYx6rKhiaNtsQ=;
        b=CrbAazJypYVO8QgW5ZXE0Xuv/HAg1OEKIjv7xNgdt/VQFQqMlXToXE/Wyu4ZRXQ0hr
         hhj6R6r1ApByWXDyTg+FNW8MZjJT4ENlMZBmyL0fEiqE4/teuYBV/Qw6r/NiIhGeYT16
         kjhs7PgROatxsQpR0A5TrxJ+VxvOtGq0PV+sjp98tm1tk2kN1rCOjfatTEHr0OgC44Vb
         pe0bGK4NSPJ4/UDHChPfP6F3oQl16S4lZXNkeUF+zJU4+TdC/WsBqn6yHTeE8RKS8Zc6
         bjBRB66d6wNYntwdWITt01LGpYdhscUn5wenhKBAtw2LAVOuV66j9YahgSCW7CRB9Pp1
         031Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NwtwwDl8Ln1YLoP2vDO3Z4Vm2x/tAqnYx6rKhiaNtsQ=;
        b=JCUvd30W9I3LJ8lWjdXwDSQ5WVAxgm2vhsHTXdz3qHv0q83z0c/4QyJK9j1VD9b69m
         P2uuOrJg22s8rZIZIs9VODbIMbNOh4FhDHyQKG770ImMTscDQsHOmc2I16v65hWNRfte
         GVQjk1bmGp1CCSsliXbbjtWm9KaYfzIjQi/hNurg8eDduAOicWy9c/GchvVx+vSJpoWf
         y0U/DL9+KRZpqkRmuITAmgjILKT0EcFBOiBpOF0aG+oEUtfAW+QNRPTXcgm24Y6DGIlQ
         Gcirb7wldJr9jN66OCLyOKzS0jVtHdHmww42bp4HXLt2lrFVZz3X2z0eloVPF2bzFNMr
         61/g==
X-Gm-Message-State: AOAM531iFyv/2385mjNU20Po78v817mB2NDw65lbwzeujUmwNC9p0o2A
        74OYtIHIZPNcJXnRDo7TR6QldTzdS5mh00vVhYnbiQ==
X-Google-Smtp-Source: ABdhPJwa/UcIf2ScdiIrr3rUauZfX9NDgqhonlmagm/I78EV+mDZrfN1L+OhUjerN4lgm2OhqbWKi9PjvLwIRQFKVNk=
X-Received: by 2002:a17:906:a153:: with SMTP id bu19mr8071858ejb.287.1611989058333;
 Fri, 29 Jan 2021 22:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20210129105913.476540890@linuxfoundation.org>
In-Reply-To: <20210129105913.476540890@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 30 Jan 2021 12:14:06 +0530
Message-ID: <CA+G9fYvDRVrYm5rEEEY+vc98CTf_KDnwWU31392xcw+AzTVrag@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/50] 4.14.218-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 at 16:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.218 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 31 Jan 2021 10:59:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.218-rc1.gz
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

kernel: 4.14.218-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 672a9e33037fec508dabec093d006a08ef8b749e
git describe: v4.14.217-51-g672a9e33037f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.217-51-g672a9e33037f

No regressions (compared to build v4.14.217-38-g57121d407faa)

No fixes (compared to build v4.14.217-38-g57121d407faa)

Ran 39115 total tests in the following environments and test suites.

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

Test Suites
-----------
* build
* linux-log-parser
* igt-gpu-tools
* install-android-platform-tools-r2600
* kvm-unit-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* fwts
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* v4l2-compliance
* ltp-containers-tests
* ltp-open-posix-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
