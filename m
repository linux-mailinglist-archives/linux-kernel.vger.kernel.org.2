Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEF3CAEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhGOVoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGOVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:44:02 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F665C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:41:08 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id e203-20020a4a55d40000b029025f4693434bso1912354oob.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMBQraJZ8ntzei2ZnzEdJIwNKS8v1nqFRnGgzFn5jLg=;
        b=Hl40AXoN0MfB1Bmre9spKLSxvGC/k7hlLhxzwR9IA3WoVhMtQNf4cLfIWIH2iYUbd5
         dD6qfSPyJeUCC9XnR1PSloBrqGbgczUNFL/1BXAlQbF4WJIfMU3UwG8LsZ5zFTIkPFfK
         7q9YjzQmWJQv/MfIaUhjPqaQMe/eElohbLFljVbNm1TabV/PUZL6hkxjCm5KNoFockTT
         ws/dd6mox8ffJVCZyfNeAXC1y+LTxBP1sFiMSiGxSvo6iolVbsJ9llN2XjuUxYfYh5Yl
         GW0XFautBsPZKYA8zUQ0yR0ZFZbGPH+99feIPSJPqQUGy3WNgsTlSgz8onTjMi+7gfg/
         iu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMBQraJZ8ntzei2ZnzEdJIwNKS8v1nqFRnGgzFn5jLg=;
        b=IoqnElI0CyZtl/e68zx24twRi193jrx0Am6hvlvmaN9T+f21AjbZWUhkOqdjnU5YTs
         UWcLKJ5785y9b1rVDZSOQsIkA5dAX98/luRu/b7Fr0douCMN0b0YJHCyzIMT5MyTfxxf
         V0aMRGrmBIDOYyz69WfTVenMeEYOmCMZDXvYnCNmRqbMS2WD9SIeS6Y5RIRnlE98rc9C
         2+0PQoLRFRNtc9GVYRcUxihbOTZEIZRGyt6iw0JfnC8vYNgrG6vz59mZdBfiakYtdREe
         0+lEi5YWDhBnDA0zKgUM+y21Sx4CRMiGrKBiooey/YM8SWC11S5meA93FmX4R8dfqqmq
         49wg==
X-Gm-Message-State: AOAM532CMw+8q9J0naevj2duJmvWHKawTzCg+WR68TSICzqo8o1QGOOj
        IFtIDZddZryvEQzk8Y3UOu5rgeXP/otK2ixBb2DQbg==
X-Google-Smtp-Source: ABdhPJw6wtdsZHT8j9lcIYWdhOvddAbbFMURjjuBNKz43pm8WcexZKYIUi1HkW4yKK35LxewMG5TUUYL5390DLDVOL4=
X-Received: by 2002:a4a:18c2:: with SMTP id 185mr5085275ooo.6.1626385267576;
 Thu, 15 Jul 2021 14:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210715182613.933608881@linuxfoundation.org>
In-Reply-To: <20210715182613.933608881@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 15 Jul 2021 16:40:55 -0500
Message-ID: <CAEUSe7-HX=WrpXfcfnBUAjvEMGvraWv5hXwSgXqfUM4X1KarFg@mail.gmail.com>
Subject: Re: [PATCH 5.13 000/266] 5.13.3-rc1 review
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

On Thu, 15 Jul 2021 at 14:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.13.3 release.
> There are 266 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jul 2021 18:21:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.13.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build regressions have been found on this release candidate (and on 5.12-rc=
).

## Regressions (compared to v5.13.2)
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
