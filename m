Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654B45D3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbhKYDrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhKYDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:45:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2DC061746
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:42:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so19434218edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHPissG71QpvjrT6a3/2z8N7PuL+tihvv/52XC6h0hM=;
        b=Mqt0hWNJBdAGUwO5EiRFaA1swINTcew/kHOPQsio8jlCmfc/UjdLvpDuEhFFoGUB+1
         czJL0RS6/0Iz98IrrBZQhxJ39ab6vWfxB8dA6Y2FTemn553lkRn5kkyUeUcRUgXWt0k9
         qviBnDohCCk9I5e6c7J25aFNrGZ3i7D6v1SJmufiCFw0m0bLCBDSYnFmpSDNTjqj2jrS
         YqKt97Ob9i723DjMZ5X00OO8DvJGDyygKb/arEVY26sIQvVPY6mjrySz+wX67+OV1TGg
         fpCkmWLrKbEQRgh+7/cBfgG9d3tfqNII2+MVI5O5fFQkRVhoOeoJbinemMCCS6EQRJWD
         ynug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHPissG71QpvjrT6a3/2z8N7PuL+tihvv/52XC6h0hM=;
        b=bWpqeWkA9TiNTM/Swydbt4Gd9nYNWATsyovwTSBolHMdtwIrQPUTH3c0Tn9i0VFZwT
         dKiD0aSdhtS2d1dmiB4kFQJtGQXU8PGA1WpSsFfN0cxKprmddHC2WyldIArMiQoer/WV
         Jqs02EVYi4d1sTUGed88pgmLO/wwyt3So/uLq+ChoEGWuoqQT6Cju/62jUb24HrSGRoP
         rjO0BhVDlMzSSk2vWNYG32pVW4sdcuBWF2hy0/3+mv05sWJSBhG3cemhNcaswjw4xSg7
         QV1xzifEvzbBmyjf4OIeSrszSQaaVuFvAcUcMX8QJ5gSlpmW7eyeowl8jcs8tp08y6vp
         hRiQ==
X-Gm-Message-State: AOAM531Sc8yIxC0ZxlsgK/n2B1C2ZNgsvAwLMbtf0jFt9BhsygP9Zv46
        zIwt4p2DZIuzRNAn6A1L/961FIYvvDPgFWWZR6WfJQ==
X-Google-Smtp-Source: ABdhPJzBoQfr2ga+waKUthRWdr+KyjBxa+4oYyKD2T9uCcZ3xbhbqXPSXXRKip2atA44sUHOLjbG3hog6TSiCK+cjBc=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr26479472ejb.69.1637811724433;
 Wed, 24 Nov 2021 19:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20211124115710.214900256@linuxfoundation.org>
In-Reply-To: <20211124115710.214900256@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Nov 2021 09:11:53 +0530
Message-ID: <CA+G9fYu83b6_dJ8GOUTcsoUvkZdVWz9Q458f0vsRfXS7pdbXqQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/251] 4.14.256-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        f.fainelli@gmail.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, pavel@denx.de, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 at 17:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.256 release.
> There are 251 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Nov 2021 11:56:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.256-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


FYI,
New warnings on Linux 4.14.256-rc1 on arm and arm64 (defconfig+7) with gcc-11.

drivers/soc/tegra/pmc.c: In function 'tegra_powergate_power_up':
drivers/soc/tegra/pmc.c:423:1: warning: label 'powergate_off' defined
but not used [-Wunused-label]
  423 | powergate_off:
      | ^~~~~~~~~~~~~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
