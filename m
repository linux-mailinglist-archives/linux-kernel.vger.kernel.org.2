Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D3D3EC329
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhHNOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhHNOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:21:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C7C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:20:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d11so23640834eja.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K9ySd9QwI6Z0DGa9QcEVatnWGOcz3I37bgjjX3gmx6I=;
        b=L9IlHQ+qB/66KM0MdYN2ZqoRDKXabFjTQP+DBxHGIbdkigrvYsIl8Sp07/+Jnwo9oL
         +JwrUEVftn93SY9f1XI/s03yyYnqvZElfdwewLQKDmzqfqxXWK9P5h39TPaNU/gWumMt
         FCwijn+eJKv0CxmhO2/UfROINR1uysHvdBttnnP326AcuNjN90/B/7AMOzqobQtttQP/
         5malFJyC9gQ/Vaz50zMrfkdNGfZlT4rKYHLSuvWU0ad5Imx1HZmatFbSfsekhcs/D6qo
         Kpwcn45EAFxgVVCnO04sb664Q4hcu84i53yduhjbm8GD9s5IffBbMAwEWugTI0WGJEkd
         sBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K9ySd9QwI6Z0DGa9QcEVatnWGOcz3I37bgjjX3gmx6I=;
        b=Pk4PAVow9kZewxQLkCv7Q3UIdYxGDWVvuxlW9+Iq3o8dlMzgYu0kdFnQzydIcg5ljY
         XrPvV9luw5OhGMhcNErAZAsyRC0JLOCuZ8LjMELpKcnbZhktBAxSNcr6l1ElNV4vldVp
         +2as6rdKfprCi+31FfoSv5ma8oUKrjpyMFpRA+or10Lj2R3MGXgQqCajzr6DyjB/Qrdv
         Fzg3tb23/l3A9ueWxwtMlvyIQdGX7PmrxfUdqdtc/iQZF4p/O4kfRC/kGGp5hpM4HHLW
         83zxHDnWUczWOKMxAqCEEZu1YHrWV2lAWocFN3O/qBFWRAHuFn43vHWYYVGrxY0SHyPo
         +iug==
X-Gm-Message-State: AOAM531h+mEVx3VbbfeATy8ddgppLxF79nL+gpB0qbv46F0D2mKosBrf
        qq0A4vL/+RY1rMDZgj/hbNMsqnn/jVVIkZE0QVT+FQ==
X-Google-Smtp-Source: ABdhPJy/dA2HG2sCNZFB1hxWMxjiUlAE/p/R2JXEAIjY/KxHahEjCerW9BiPGgimhwLJqJbbTb9u7DS+3nUsTMuKubY=
X-Received: by 2002:a17:907:2110:: with SMTP id qn16mr7610522ejb.170.1628950852514;
 Sat, 14 Aug 2021 07:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210813150520.718161915@linuxfoundation.org>
In-Reply-To: <20210813150520.718161915@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 14 Aug 2021 19:50:41 +0530
Message-ID: <CA+G9fYtsfaaS7jasRmi=D8CO5z7bttSy3gYZg4ZTa5R4dwiYOw@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/25] 4.4.281-rc1 review
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

On Fri, 13 Aug 2021 at 20:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.281 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Aug 2021 15:05:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.281-rc1.gz
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
* kernel: 4.4.281-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.4.y
* git commit: 82678f26470c11cf26eb8a91e303b47fde424a40
* git describe: v4.4.279-38-g82678f26470c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.y/build/v4.4.2=
79-38-g82678f26470c

## No regressions (compared to v4.4.280-26-g26378ad308bb)

## No fixes (compared to v4.4.280-26-g26378ad308bb)

## Test result summary
total: 51670, pass: 41488, fail: 264, skip: 8792, xfail: 1126

## Build Summary
* arm: 97 total, 97 passed, 0 failed
* arm64: 24 total, 24 passed, 0 failed
* i386: 13 total, 13 passed, 0 failed
* mips: 36 total, 36 passed, 0 failed
* sparc: 9 total, 9 passed, 0 failed
* x86_64: 14 total, 14 passed, 0 failed

## Test suites summary
* fwts
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
* ssuite
* v4l2-compliance

--
Linaro LKFT
https://lkft.linaro.org
