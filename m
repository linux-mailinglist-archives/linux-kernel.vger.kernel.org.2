Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF8388741
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhESGHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhESGHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:07:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:05:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so13919142edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 23:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b4n3FlKW7YIc3dvGbilNwpaRS/YJiUnY2dFyBHgbF2Q=;
        b=gcOquhgBMwcDRr42vwg3518aEIxgR7yeoLznbDUfRpZ9JI+xxFsQhpDbXolMZzT6AM
         AXc8PsI9kqZE4nAMpfIyXcu2822agdnjOFyhrF0RRskE/Dg8BYMAe4kbTX7P6pWtvAor
         vuoNZiYPnkwiTeq0PiKBCCYI/0Cja3xvEHZZ3nufngcJoiTNnfqwgl7ykpW0j7EXudPc
         PVwv44csSKF0TagjMU4TQOV0ngDd8tzLAyS4L0jfjA+uGbVuSGFUtEujbehz5Mxneoen
         +S4qhyn6NIynpeu3rrGOWUkC3z2qxYvsmLV16xh8pVnnauUjdRCj/WVcRP8r0tE6xYK2
         niPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b4n3FlKW7YIc3dvGbilNwpaRS/YJiUnY2dFyBHgbF2Q=;
        b=UxL0u3uSxJbFAlNA/9GohVWBxyBwe7eGt3xyn9uFxD47PWmAIeLkbLQL2vToZmDJjR
         E9GZjsgn5lCnI/nJg9phnchMzrrRj6W0pce0NuruPQBAOH/Rxxbk3dUnT3nSY6hdl2hx
         nO1uz7TjT9nXuYuyGfgNlGIBNONYVtnvYCFUWg+S2MpXpKvoL366Dl+cpkZcQBEz8YVz
         67I/l8DVDXJ5IJOiECmeTRwBrBzHrGxg7pIrwhqA5LHUJWo9LfI7pOX7XQ6jTiFD1eDL
         qa8+KJXGHubgIYtdBUyw9ek//EDE5JUcUlz5n7S8dSpP4C5CcrcbrH4n12hsLJ20PK44
         7ImQ==
X-Gm-Message-State: AOAM532gRAOJyUQpCwVWUgisCoQob8zmRvyQuazCrci/8dIDKY1Fngi1
        XKMe2+2+M3UpNzCeD+WhA0f3JCD8TPPBaxX8/o37JQ==
X-Google-Smtp-Source: ABdhPJw18b8QGnurwy1mCc+ILGAXXiC3SKgW45YmSx+pGD8Z37c/RoetsEJqE6ITXfb6Jr055dbZlY8p9yz7yADML6Q=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr12029329edx.52.1621404348159;
 Tue, 18 May 2021 23:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210518135831.445321364@linuxfoundation.org>
In-Reply-To: <20210518135831.445321364@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 May 2021 11:35:36 +0530
Message-ID: <CA+G9fYvXGoKUnJ=3AC5qC408UwRzvHkLyp71RiYx_xmMqZX7tg@mail.gmail.com>
Subject: Re: [PATCH 5.12 000/363] 5.12.5-rc2 review
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

On Tue, 18 May 2021 at 19:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.12.5 release.
> There are 363 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 May 2021 13:57:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.12.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Report on 5.12.5-rc2,

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.12.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git branch: linux-5.12.y
* git commit: d9d51f8654b9d778683fc4322957017a7afe7d6f
* git describe: v5.12.4-364-gd9d51f8654b9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.12.y/build/v5.12=
.4-364-gd9d51f8654b9


--
Linaro LKFT
https://lkft.linaro.org
