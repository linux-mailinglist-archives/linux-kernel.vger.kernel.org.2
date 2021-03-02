Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B6832A4A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446476AbhCBKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349591AbhCBKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:42:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A2EC0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:39:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h10so24483675edl.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1ICLiqXq+tV4cupqdEJe1awTHsiicMzPeqP1HbdaGGE=;
        b=ZiaiNjSdUKa+PpaODsNvhg0V14fn7QkfVat6rGMzPoG4p4a8OglAyHcVCa8lQ4GR8A
         NpXEMjXcOmO0cUhsYkJkBSj+CzpUmjj7TnZFdertYVEhl4e3d7wMnIHx60va8T77caVV
         8r3WpXxHJ3jiA5h6WvcoG/fMVRxLwFD3LGxEw3fcOq9/i5d1CJ22N0ZgzViWq8FW39o4
         0yhB2wDdkJ75JTEq6iJykAMAbKYAi/Z/sgDCJzD6K2JoJldIrF+es9lM9HVBE9diutxr
         mp5uSh3kHjJGAorSVbBOsGOTUJQxckB9jsiK9WlXThQiaBGFiG/GGBDuecMFwNZ1yebc
         zWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ICLiqXq+tV4cupqdEJe1awTHsiicMzPeqP1HbdaGGE=;
        b=cTZdFopOuN1tvJS22ib5bb9x9evx/hR+y+p/y+o+IQPFqMyJZztb5gt22+DLmvfkq2
         Dl3mLkYKJ9RNrrvKLi5XbX3XsiN1+M5U89PskJzzET/1zFS7o7p4jVOyYvLWWPP9RUP9
         u/opomCbXwJSoQkEeRg3UESn9lAGzlYYRRCE84scpx8dSTGzW5mnymTbYQSSGC60Q7DX
         yvWkKSE4BWS1SyQ0mpODyd3cP3bYF+24U8JuHEgVTaJZJRUnNNP9i1i9DmsqYnM10TJt
         U7IEfm12x4fx0zk6u2glPCsnQYjQjXeCRCUx/hwZ/FuH98Yb5/eaTjvDLlDdfRGBhde3
         ofIw==
X-Gm-Message-State: AOAM531jRAXvR93z8wXZkeMK1tL9yCGgKL3j1WaRjbRpS0LJeZa9TpjX
        z/v6aqjvhKY6aIva6JXaf5p7WulKNvu0qEdkqU3HxA==
X-Google-Smtp-Source: ABdhPJw2tEHtmKZfTJR+DrfbJOE+591gfRtPzaAoB6PSf5+8p/AfbZK6iH94T356k6WZqdKXdChYTmXySntr6PGomPM=
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr20362354edd.78.1614681580716;
 Tue, 02 Mar 2021 02:39:40 -0800 (PST)
MIME-Version: 1.0
References: <20210301193544.489324430@linuxfoundation.org>
In-Reply-To: <20210301193544.489324430@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Mar 2021 16:09:29 +0530
Message-ID: <CA+G9fYs+tDGcOA8xJrkgOAdENg+tDSWeK1J9UvbR9fzo3bV6CQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/246] 4.19.178-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
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

On Tue, 2 Mar 2021 at 01:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.178 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Mar 2021 19:35:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.178-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


[For the record]

Results from Linaro=E2=80=99s test farm.
Regressions detected on 4.19.178-rc2 for below listed devices and configs.


Build error:
---------------
include/linux/icmpv6.h: In function 'icmpv6_ndo_send':
include/linux/icmpv6.h:70:2: error: implicit declaration of function
'__icmpv6_send'; did you mean 'icmpv6_send'?
[-Werror=3Dimplicit-function-declaration]
   70 |  __icmpv6_send(skb_in, type, code, info, &parm);
      |  ^~~~~~~~~~~~~
      |  icmpv6_send
cc1: some warnings being treated as errors

Summary
------------------------------------------------------------------------

kernel: 4.19.178-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 0e2d946bd3c89bee5a98375b218dcf9c2d3d5f50
git describe: v4.19.177-247-g0e2d946bd3c8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.177-247-g0e2d946bd3c8

Regressions (compared to build v4.19.177)
------------------------------------------------------------------------

arm:
  build:
    * gcc-10-allnoconfig
    * gcc-10-axm55xx_defconfig
    * gcc-10-clps711x_defconfig
    * gcc-10-footbridge_defconfig
    * gcc-10-imx_v4_v5_defconfig
    * gcc-10-integrator_defconfig
    * gcc-10-ixp4xx_defconfig
    * gcc-10-mini2440_defconfig
    * gcc-10-mxs_defconfig
    * gcc-10-nhk8815_defconfig
    * gcc-10-orion5x_defconfig
    * gcc-10-pxa910_defconfig
    * gcc-10-s3c6400_defconfig
    * gcc-10-tinyconfig
    * gcc-10-vexpress_defconfig
    * gcc-8-allnoconfig
    * gcc-8-axm55xx_defconfig
    * gcc-8-clps711x_defconfig
    * gcc-8-footbridge_defconfig
    * gcc-8-imx_v4_v5_defconfig
    * gcc-8-integrator_defconfig
    * gcc-8-ixp4xx_defconfig
    * gcc-8-mini2440_defconfig
    * gcc-8-mxs_defconfig
    * gcc-8-nhk8815_defconfig
    * gcc-8-orion5x_defconfig
    * gcc-8-pxa910_defconfig
    * gcc-8-s3c6400_defconfig
    * gcc-8-tinyconfig
    * gcc-8-vexpress_defconfig
    * gcc-9-allnoconfig
    * gcc-9-axm55xx_defconfig
    * gcc-9-clps711x_defconfig
    * gcc-9-footbridge_defconfig
    * gcc-9-imx_v4_v5_defconfig
    * gcc-9-integrator_defconfig
    * gcc-9-ixp4xx_defconfig
    * gcc-9-mini2440_defconfig
    * gcc-9-mxs_defconfig
    * gcc-9-nhk8815_defconfig
    * gcc-9-orion5x_defconfig
    * gcc-9-pxa910_defconfig
    * gcc-9-s3c6400_defconfig
    * gcc-9-tinyconfig
    * gcc-9-vexpress_defconfig

mips:
  build:
    * gcc-10-allnoconfig
    * gcc-10-ar7_defconfig
    * gcc-10-ath79_defconfig
    * gcc-10-bcm63xx_defconfig
    * gcc-10-e55_defconfig
    * gcc-10-rt305x_defconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-ar7_defconfig
    * gcc-8-ath79_defconfig
    * gcc-8-bcm63xx_defconfig
    * gcc-8-e55_defconfig
    * gcc-8-rt305x_defconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-ar7_defconfig
    * gcc-9-ath79_defconfig
    * gcc-9-bcm63xx_defconfig
    * gcc-9-e55_defconfig
    * gcc-9-rt305x_defconfig
    * gcc-9-tinyconfig

qemu-arm64-kasan:
  ltp-cve-tests:
    * cve-2019-8912

sparc:
  build:
    * gcc-10-allnoconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig

x86:
  build:
    * build_process

s390:
  build:
    * gcc-10-allnoconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig

arm64:
  build:
    * clang-10-allnoconfig
    * clang-10-tinyconfig
    * clang-11-allnoconfig
    * clang-11-tinyconfig
    * clang-12-allnoconfig
    * clang-12-tinyconfig
    * gcc-10-allnoconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig

x86_64:
  build:
    * gcc-10-allnoconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig

i386:
  build:
    * gcc-10-allnoconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--=20
Linaro LKFT
https://lkft.linaro.org
