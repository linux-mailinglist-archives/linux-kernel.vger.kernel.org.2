Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E254380A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhENNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhENNOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:14:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 077EC61574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620998007;
        bh=SmwYCABWe6UtJJQITJQgDO4TF8ussa7o7rcyJCcW3jM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jzEKKT97yHy83+VE5A7eBpx5qmSengX4EKGR7h6fuEqV0+IsUVoGsayvpOe4l0Ylz
         jW6IF4qdOhb+VzyyZIXvzp7pB3iwjvOPnqGudTxhwFZZ8lalNCZpRMFgc3WIADa0Ex
         YP93iD0pPuj75X7RDJtzmBdfH1GAnJbBSQfVeDj8XREJ/Fox2TfCJlgeWzSoGmv5c+
         5KKPlMOxa8kYibsyZSw97vtd60WyxMeXSlJ0tso7qgLkCK7Bx6XLCebAWIuofVRHbA
         MPcc6a/O3yCtxVtkU0QoChj+6D99SgSqkS88Y8DFSpxlMI+LeF1c5ktfbeq1JkjEUD
         qBAi/egw2RaLw==
Received: by mail-ej1-f51.google.com with SMTP id t4so44685478ejo.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 06:13:26 -0700 (PDT)
X-Gm-Message-State: AOAM531UqK67jPs/OnF8J8Dc/RTKbgZTk7gtwwGfDY+CkyRJFqz7XKFq
        8iT7NrnVLH98idb85s+JB36IstGX2sSUgnGdK0k=
X-Google-Smtp-Source: ABdhPJyJFYlQHxYwJwW1HWQkWIt4FmFQw2iVqFqpHi7k1yurIHr7dHKncO5nHW8f2uUpXjRHUD/uNNhdFYJEq9epAcs=
X-Received: by 2002:a17:907:9729:: with SMTP id jg41mr18509480ejc.385.1620998005643;
 Fri, 14 May 2021 06:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <202105082122.yrF7ploN-lkp@intel.com>
In-Reply-To: <202105082122.yrF7ploN-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 May 2021 09:13:13 -0400
X-Gmail-Original-Message-ID: <CAJKOXPcbDkuDpq3YCgKVW-9eUTJDymO1icb6BNnwzx3=9BRR8Q@mail.gmail.com>
Message-ID: <CAJKOXPcbDkuDpq3YCgKVW-9eUTJDymO1icb6BNnwzx3=9BRR8Q@mail.gmail.com>
Subject: Re: ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko]
 undefined!
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 at 09:30, kernel test robot <lkp@intel.com> wrote:
>
> Hi Krzysztof,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   dd860052c99b1e088352bdd4fb7aef46f8d2ef47
> commit: 7a69a6f68da5084e7f42df18bbc3b38f3785cccf mfd: omap-usb: Depend on COMMON_CLK to fix compile tests
> date:   5 months ago
> config: mips-randconfig-c023-20210508 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a69a6f68da5084e7f42df18bbc3b38f3785cccf
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7a69a6f68da5084e7f42df18bbc3b38f3785cccf
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> >> ERROR: modpost: "rt_sysc_membase" [drivers/watchdog/rt2880_wdt.ko] undefined!

I sent a fix for this one.

Best regards,
Krzysztof
