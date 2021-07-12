Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4813C5CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhGLNK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhGLNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:10:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2AC0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:07:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hr1so34493930ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qkkW7DZ67mzoAamz+YIVSt7JvYQY7Z5zd7I/5Xo8WOg=;
        b=aU2/4IRRrURZKw/NwMgXH2zrDrfQw64BB3vwlHQwXUsYUWXy+YBcVUefyOKJwTJ3/F
         P0iZDGWUg4E+tRvcEFyAJuslwoBKOZ6QBGhhX/1ZJOzVqpuOu+/d89fFisLXfmyZAysy
         wzqV2EpaGUujV2WQz2LZ+IPqOaLBtRr6R634dkRMtKzSiyUAykXDBeSPB+56obPwWNvV
         lMaVcTsmDGXJCIRgzA09aVEbR2vd9C4dz3UIhonsfYP8yE0vH+Wb5ZdZT8yru15NiUfk
         rsPfJMn3DU7VXObA6BoCwd7ChG1rb9zuOSfSncMYonGP962IRKuLP95JVwnz0O4MAjUJ
         A5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qkkW7DZ67mzoAamz+YIVSt7JvYQY7Z5zd7I/5Xo8WOg=;
        b=QHnv0IE+VXFFP3VF8zb8p0sfyJ8yagsEFzxuoWUSqyiRIgBevgzlQl7m8Ped0G70qd
         5s8OlSuDsdrynXiB5+DZnZHytWIW/GuZ6kCJOHJr1uM6K92u4/wGq0MP8hg8sCjwBAJK
         kGj/M8tVLgXBIOED+uKj/CCeiL0AFZKsj9jCKTmxpBzSspLQ8+P6+3EM98qOewF+nMec
         E3Qe563yYvZtZwKAJ+LEoZZBdD397MgoHfqZ+zPycO/mb3ElQCbsDSoEEKCGZlW73fuT
         v2WlkbWGzwmPy5tgNqtY2GpsPzHPuCa6FMhkd4KGIvEr7GWN6NujU4XdKQFJPOheL4sk
         Vlfg==
X-Gm-Message-State: AOAM530jEaRAPOwLgfvbmQnZbc9s+D3gGAKiASBGDJZa9kc7P9VO4SbY
        UPbNop/LMRu2Z2IiDcb65YFMaW4sBAt5I6HgmgYUfQ==
X-Google-Smtp-Source: ABdhPJzOiydqZEYFmQm+4OEyqqTs5V+r5oZm9chpBuQdmuBEdhncaVT/innE0yiDRfNNM3mO9L4pBISb4OMMkpouQIs=
X-Received: by 2002:a17:907:7b9f:: with SMTP id ne31mr1554663ejc.133.1626095258066;
 Mon, 12 Jul 2021 06:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060659.886176320@linuxfoundation.org>
In-Reply-To: <20210712060659.886176320@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 12 Jul 2021 18:37:26 +0530
Message-ID: <CA+G9fYu6+hex77zTHTCopRvSVpCfxPjLydEL3Ew+92poZkncSw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/348] 5.4.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>, nathanl@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 at 11:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.132 release.
> There are 348 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Jul 2021 06:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.

Regressions found on powerpc:

 - build/gcc-10-cell_defconfig
 - build/gcc-8-defconfig
 - build/gcc-10-defconfig
 - build/gcc-9-defconfig
 - build/gcc-9-maple_defconfig
 - build/gcc-8-maple_defconfig
 - build/gcc-8-cell_defconfig
 - build/gcc-10-maple_defconfig
 - build/gcc-9-cell_defconfig

The following patch caused build warnings / errors on powerpc.

> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/stacktrace: Fix spurious "stale" traces in raise_backtrace_ip=
i()


Build error:
------------
arch/powerpc/kernel/stacktrace.c: In function 'raise_backtrace_ipi':
arch/powerpc/kernel/stacktrace.c:248:5: error: implicit declaration of
function 'udelay' [-Werror=3Dimplicit-function-declaration]
  248 |     udelay(1);
      |     ^~~~~~
cc1: all warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

steps to reproduce:
-------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch powerpc --toolchain gcc-10
--kconfig defconfig


build log link,
https://builds.tuxbuild.com/1vChzZyzmKmQCN2cLMtRBR5kbdI/

--
Linaro LKFT
https://lkft.linaro.org
