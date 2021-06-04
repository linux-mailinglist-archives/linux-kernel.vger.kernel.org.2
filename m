Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2524139C3B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhFDXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:12:22 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45842 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFDXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:12:20 -0400
Received: by mail-oi1-f181.google.com with SMTP id w127so11301590oig.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 16:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=du6aRGfX4SI86kYShqUWR1TDu1w5UdQuTWF6MyIxIRY=;
        b=NbrraKsJQeXPFVM7Eorm2jhGhe/xf/js0Fuy/gLvHQA/P57w7ccteCjE4aGRLEnr2Z
         dlI0ptIoyfAJutgfWZj13qCquhp/o/It7Ky8uQ7O3DJLqdIOrDHVDKXEn5BBxLwtz76j
         pRYW3LQAEXydTU36si0M/QHWzem//g1AG6lmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=du6aRGfX4SI86kYShqUWR1TDu1w5UdQuTWF6MyIxIRY=;
        b=PMlKh/l/X2iNsxPQsqt1E/m3rkj7u2O2BjSyNsS+JH3C6mRZh0LG9g6pWJxBtiS1Sz
         z3SuRrz8Be0fQQM0NIgOJmFmmWIp0g4dwAT+87dKnCZ6TlFHifzHfyMBH6lSwbudk29G
         rxWKe7DHY1PIWZHIKA24HWeC0YIAfqhHoqpr8UnvaTs2fhYwSqN/zE2JEmL1bbrGdEi3
         Emgcfg0Ry/c04RZvnl5w5Lz6gEdXp4WjrXumEHLvN4w4BRVswt5a0snzOTmLhiRmOfzt
         2qNjcEavVR2nHP9g8G4HUOoU1Xo5jPkKyLEiwSDiegLy9nve0x8m3Q/KUUb+AjpSbtvv
         Oneg==
X-Gm-Message-State: AOAM533LkOoGJ/TCkn4K+Md3vK3gVtlp3ZOxurkT+UV/TYSWxb/NplhM
        CMirxn9vGGiEZtaX4E/GS9vbUGfx/0Ew19To6oYbdg==
X-Google-Smtp-Source: ABdhPJzshQRhetJ7fG/nA9zbn3qMtWPZUUgQnF9azZgf7YfHohZsKcLRZN75T8UorNN3FrOy5Y8IGzU4bgnYkfqaWUg=
X-Received: by 2002:aca:654d:: with SMTP id j13mr12631266oiw.125.1622848161433;
 Fri, 04 Jun 2021 16:09:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 23:09:21 +0000
MIME-Version: 1.0
In-Reply-To: <202106050612.FyaqyhTf-lkp@intel.com>
References: <20210604212752.3547301-1-swboyd@chromium.org> <202106050612.FyaqyhTf-lkp@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 23:09:21 +0000
Message-ID: <CAE-0n50aeyb4g8f4aGhFWB4JFNue__CL8OPM0m3bUdEhMV1UCw@mail.gmail.com>
Subject: Re: [PATCH] i2c: core: Disable client irq on reboot/shutdown
To:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2021-06-04 16:01:32)
> Hi Stephen,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on 8124c8a6b35386f73523d27eacb71b5364a68c4c]
>
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/i2c-core-Disable-client-irq-on-reboot-shutdown/20210605-052848
> base:   8124c8a6b35386f73523d27eacb71b5364a68c4c
> config: nios2-randconfig-s031-20210604 (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/2fb1417bc9d82a335db5ed8a1446be74bffae440
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Stephen-Boyd/i2c-core-Disable-client-irq-on-reboot-shutdown/20210605-052848
>         git checkout 2fb1417bc9d82a335db5ed8a1446be74bffae440
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=nios2
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/i2c/i2c-core-base.c: In function 'i2c_device_shutdown':
> >> drivers/i2c/i2c-core-base.c:631:3: error: implicit declaration of function 'disable_irq'; did you mean 'disable_srat'? [-Werror=implicit-function-declaration]

Must need interrupt.h, which I must have got implicitly somehow.

>      631 |   disable_irq(client->irq);
>          |   ^~~~~~~~~~~
>          |   disable_srat
