Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05813A0197
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhFHSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:54:37 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44951 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhFHSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:48:33 -0400
Received: by mail-ej1-f50.google.com with SMTP id c10so34231046eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9rLQJhNwowgUH5qn2d/6rawlhJslNX08LVgR1AXk/Y=;
        b=Ttd70NFKeWLtk9YzA6vnRM3q4SBEOb8SG1Ot6V8gOIonraUAhzMpICfr7RGO6CgYl6
         q0praKM8UQD7AO6T9EUBO0JsYeQAODFDuTfUjQ8qRmBJ5sdIz3yxD7C6cev3BaJ2GFbz
         oORYl2lsEVzOd3Zfuv9tn+b4R1Qa+q89E4KeZObisVFFdnzvjbSzoBhn/aehYKzb0x1X
         Pj/2GQgaaeaMP/nsb3uqcTBrsKUyFPk4XXZb5/6Dhz7SD3b+0I9/IYzhDgUzFLIjwJW0
         O/OvZOkOBPeHPkZIT2jFWt2Po7447MuAYMb9bcEd+5fvkQ6FvFiiVLTrl6Wyv/QyuUCD
         eSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9rLQJhNwowgUH5qn2d/6rawlhJslNX08LVgR1AXk/Y=;
        b=mjl/Z0RVDU2/+U7Tqi/qsa0WTCOl4NUJ1QU+O99i3U3eHTWGCnqp6k7VN7fqTQuYqg
         G8QH6G4LOXbt4jWs7umfPUkJJjFElWSLam3v3RDCV5bwopYe9MxKLamHNn7lfAT9mdcX
         IqhP05nh+WkCfe3WSGyAFBlbILCuSpc1CWlt+ACBPmljuud7Ao5fpUoF3uffa4hlTzXE
         NNQGQxnR2Fnf20NbRfFOqfbnQ6NEpCwOUhWnM1a85Xtro20AFqFPW0ukNdjjgJGsqEHT
         /54JcRkcFF8lisEre4tpVkEXYjrc3a8jB6fdHJx0Os6Dt1jwBz5RkgZus1M6D/MoI9Ey
         M0QA==
X-Gm-Message-State: AOAM533WG4Ug5kbcDeDkXIWCx2X3/eV63eoj25LgNRnwuHVibMeD9lyS
        DeqYiueeWb0HpQt7MATh5aXdMyhdQbSJrsir2CG0HA==
X-Google-Smtp-Source: ABdhPJxHcaek0VALuIjuQpmEqsmb5L2rvgJA/6sLy4W0yYlT1gGdDMFuke3UuV+avIprR0fyd6fYid/IvCWfLZ7+5t0=
X-Received: by 2002:a17:906:8318:: with SMTP id j24mr24739511ejx.375.1623177927896;
 Tue, 08 Jun 2021 11:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210608175932.263480586@linuxfoundation.org>
In-Reply-To: <20210608175932.263480586@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Jun 2021 00:15:15 +0530
Message-ID: <CA+G9fYu3URCR6_ZL+KPYFEOVL4f=8TjjyFncmvoLuYrR_YR3=A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/58] 4.19.194-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marex@denx.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <festevam@gmail.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Ludwig Zenz <lzenz@dh-electronics.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 at 00:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.194 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jun 2021 17:59:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.194-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following patch caused arm dtb build failure on 4.19

> Marek Vasut <marex@denx.de>
>     ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
Error: /builds/linux/arch/arm/boot/dts/imx6q-dhcom-som.dtsi:414.1-12
Label or path reg_vdd1p1 not found
Error: /builds/linux/arch/arm/boot/dts/imx6q-dhcom-som.dtsi:418.1-12
Label or path reg_vdd2p5 not found
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.lib:294:
arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb] Error 1

Reported-by:  Linux Kernel Functional Testing <lkft@linaro.org>

build url:
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/1328891505#L477

Config:
https://builds.tuxbuild.com/1tg0YjTz4ow5CkHv0bzTc05pVs5/config

--
Linaro LKFT
https://lkft.linaro.org
