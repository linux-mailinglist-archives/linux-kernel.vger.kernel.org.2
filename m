Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238743CAEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGOVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhGOVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:52:24 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD300C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:49:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso7727740oty.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y1dOBgdQ3hrMd+YVDQYEcotLu5Ehk6yTJpr5uXkQiOs=;
        b=iQM8Bbsa6+s5E31gAFFr7UnEL02zPynbH+oJVKIfdE/w5PXSRGOY5IpTLQB36/Rue3
         CfnUUmeBKhb7NhQ3u62Etz6zwZdiHR0EW3+vFtPtH6tPeAUS/BVGSKStPXwfyriIoPc6
         dNg+UvgqHkp/Cbjsip5RQ0LdueHIubC+AActWEJN3EbJi0s6f1rhqseKLZ1E9zlZiqZK
         Qunf5j3kS6fHQ2oXf/arN2PbmT9vTAmJ0jrSL48OKe1EFXdVx39qh07e6ly3fjvFXFY5
         JYvR0v5Mmz4Z6oOXocxoY4mJ+SPgxrXLnpx2EXiSgZKPO8va5XWG3CogmbUUj9cLl9R/
         X8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y1dOBgdQ3hrMd+YVDQYEcotLu5Ehk6yTJpr5uXkQiOs=;
        b=EVTYhNtIqS5r4S0/lyC4iNIkGcf6V5+8q+uyt0AReh22NjURwvI8PEp8+PXYAs7q1s
         56UwbOg+M13sIENA12u0yE497wiGMP5q/V7YM/Ft+rLrabIHD6ONz3MzPxtWD1Kresva
         PEZrMHCAcVn0WVQihgWCO6JA5ImXjMuvuL8+Los7ihb2P8ek73mggIeCPkwirX273E2b
         PtIkNp/iyl++DbsdusXhANHt+ZbQmHx+5R9dAmNcBZsWpalq5kRCR0sBxzjF4TdVJGfL
         zbkF0VnWaDCRnazBEO3lYTLGN30O8tf+q8tFAuv7AdNgbQYMAwmBm0APdlZev9qBOm9J
         jIKQ==
X-Gm-Message-State: AOAM530+FJ1U5bZrTyoGS/mv5WzglHa1IZ5ta4mknLJIfHUArVTPC+cF
        ns9VuNLbqL6kREI7WklATX8vmqOwHnq1b1Q4I/U/PQ==
X-Google-Smtp-Source: ABdhPJwrWuaKEX9nwRs+pv2yfk6eK+BGu8O2umTt+v/GV+qUh7yeiLdmOcKZ392NOumnyeV9/q+YC9bv7rYcQkx2hIo=
X-Received: by 2002:a9d:3e06:: with SMTP id a6mr5463289otd.50.1626385769016;
 Thu, 15 Jul 2021 14:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210715182551.731989182@linuxfoundation.org>
In-Reply-To: <20210715182551.731989182@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 15 Jul 2021 16:49:16 -0500
Message-ID: <CAEUSe7_+8fQZ=1+jcxJVTRw0DYttGmR-aBdobZ0GWYQi3Vg97w@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/242] 5.12.18-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        linux- stable <stable@vger.kernel.org>, svens@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 15 Jul 2021 at 13:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.12.18 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jul 2021 18:21:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.12.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build regressions have been found on this release candidate (and on 5.13-rc=
).

## Regressions (compared to v5.12.17)
* s390, build
  - clang-10-allnoconfig
  - clang-10-defconfig
  - clang-10-tinyconfig
  - clang-11-allnoconfig
  - clang-11-defconfig
  - clang-11-tinyconfig
  - clang-12-allnoconfig
  - clang-12-defconfig
  - clang-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig
  - gcc-8-tinyconfig
  - gcc-9-allnoconfig
  - gcc-9-defconfig
  - gcc-9-tinyconfig
  - gcc-10-allnoconfig
  - gcc-10-defconfig
  - gcc-10-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[...]
> Sven Schnelle <svens@linux.ibm.com>
>     s390/signal: switch to using vdso for sigreturn and syscall restart
[...]

Our bisections pointed to this commit. Reverting it made the build pass aga=
in.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
