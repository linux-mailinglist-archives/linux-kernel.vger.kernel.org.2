Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8805B334544
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCJRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCJRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:38:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C1C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:38:23 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so40299945ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okV++VFxVSFyAERp8JdbnLcbQt5jDIvaux7uTpycWNY=;
        b=qBemZ4JHjSlP1msVG5z66KEhDBsStg25FgSoIPAXuJMTQjjx6hdY3APMV3MjWA1djV
         tlbdeAPJd16zyumDX1HSElzgZfjNRLxYC4Sv40i9rJ2YX/EXVcx7m3MSbzX6HObxxcT0
         Y3QLgxUGWToiRJ1ixU+CgP7nBuvg8W3DCxJwTHpYV1AgHJxgaV7D+b18iq74Sc3bjbfK
         iBH188WxGP/T9/hpYY2c2/bxHeY/J50rHcMAmv1GWi9HB5x13gRGVKbjsskK49EgAPLO
         /VYN3cIhUrWSRaF3MZD7nvtPkqVRuGOQ7YyH5wOftpNuJ6w8/G7FJ/YmJTrGy+Q8JvNM
         mKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okV++VFxVSFyAERp8JdbnLcbQt5jDIvaux7uTpycWNY=;
        b=EYLPJdd9B7da6LpwCujBF94t1aTqnT1PEBghdcIvVk7ijMcCkqpZaAnPWGYjtBCQ2W
         JDoUJqFSjrHq3wnfwVIiE6B1H8gQckvr6PkywTe5LgQxjaqJrw1t4lDsCtFT9OLmQdUj
         PJOrGkQ4k2jCwgIXNqk3VdXx2l9b0YjXbiGEBhxTKHgSySwnwhCNVstj+U/0YBmLxQ9A
         fSNloAqTQoslJNC0RSsVSoHJnyMzTTX594/4kocXGV1dxPAn49PyMf+KMNhx/cjOi1dB
         mPoLt41tJVurZKUyUhl+49BR3GmP3T/aD4V9mTECXl9ajNTtbSltjtX5uh/dn2By3qtq
         tpJg==
X-Gm-Message-State: AOAM5339Nu8ExrvxJJdMz+8qP+i7EiKHiDownlFGljCG/UqanU+NHFcS
        9BBtLiBvb22bnaVuHpkqtuMkQvtrZEooCo7VUUqIug==
X-Google-Smtp-Source: ABdhPJzcR1BVT4oayP9E7SdgOQDg9FkHjMIuiCm2oG++v/DxNaO3ew1DPo2i++wCyrjHoK66vb0bK/qwkMoYPDFo0HY=
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr4854165ejo.247.1615397901839;
 Wed, 10 Mar 2021 09:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20210310132321.948258062@linuxfoundation.org>
In-Reply-To: <20210310132321.948258062@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Mar 2021 23:08:10 +0530
Message-ID: <CA+G9fYuydf-g2FPOtP9LAX-4zY3EF64Bx0OQjbjn=a4V+0=eLA@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/49] 5.10.23-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Elder <elder@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 at 18:54, <gregkh@linuxfoundation.org> wrote:
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> This is the start of the stable review cycle for the 5.10.23 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Mar 2021 13:23:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.23-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building stable rc 5.10 for arm64 the build failed due to
the following errors / warnings.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
drivers/net/ipa/gsi.c:1074:7: error: use of undeclared identifier
'GENERIC_EE_CHANNEL_NOT_RUNNING_FVAL'
        case GENERIC_EE_CHANNEL_NOT_RUNNING_FVAL:
             ^
1 error generated.
make[4]: *** [scripts/Makefile.build:279: drivers/net/ipa/gsi.o] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> Alex Elder <elder@linaro.org>
>     net: ipa: ignore CHANNEL_NOT_RUNNING errors

Build log link,
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/1086862412#L210

-- 
Linaro LKFT
https://lkft.linaro.org
