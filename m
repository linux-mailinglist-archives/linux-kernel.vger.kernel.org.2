Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A180D341900
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCSJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCSJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:57:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:57:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so2711350ply.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASJMW6scRGdDPaxrraLcWwaKe31/1z+RKDFUJFFWtbE=;
        b=UG2HGyH7w2FE5tAZv1zqGqlEcDPQJAB1Ch9dDuXgL4MVWZREHEoils1+2zs8Rzp3x8
         A/GApl1OPPqP4Q9cDMw0sy48UMWzIzopSHj6qDkEJWjiJW3Og/mojXuYK02NtmiTuX+i
         iIde2KPIz6VorgdIvYb9K4dAsM36QgwqTNnJicWnvDIXUef89NnK+SaiAHDu1WnKpgL1
         b52EGc22XTjbYm94HyQ6JGz7a2VWTYqQFwRtEwGP32rY9TnDyoV2Z5uTcP3nyMxA4w40
         xHKN8L0aPY8HYsoXZakJcQNCESmLzZ4EcL/VOCuvw3/cOUCb6FsQJ5zc3rNU0fB5/WVc
         csWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASJMW6scRGdDPaxrraLcWwaKe31/1z+RKDFUJFFWtbE=;
        b=cVJxqoZZ/Hu9RpYN9deCKv5ZYW2jStpft9uaLrFUmwaUtWTbA/4jZdoANhalDLXQK7
         85Z2Teb9B7bGRBtznYdIU0cjFlJgemQJtaEkJcCas7Xyzl8n8NJT7C+GK9P/U7aQei5U
         lauzO/u8a6vqksQZ88O9e++D+0hnsAIyjyO+8S2qsyetv1u2xgP6ffAeis7zOjp+DSWp
         U+TvtELuR/teLlWpX17cJdVpFZsUCpHHDU/bRyCQfMBSgEJwe6Y9uziBk0pat12JJCFf
         JmXkXwvCUahZNAq49Wwpb426v0ecOPXbyj0OS4AzfhrQvrPCV9at5mESF90XIeRb2//t
         bUaw==
X-Gm-Message-State: AOAM5317ldhvjgpNYylvrKqkCqfqbVViuB09L8pbMO92K/A2IE+EMQGd
        FG/CB0hK41cUYM1Gm73AdvoJgfnSd+3A8ARiXPM=
X-Google-Smtp-Source: ABdhPJx9byxFnl5x8/MIuCMAipr1QMVdKi/S2blW5N+g6+8VclWkCkttaH8wH3Rdn84kWtmn1OPnX6sKEYsBNoNYAM0=
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id
 u8-20020a170902c808b02900e64204f62fmr14044687plx.0.1616147878694; Fri, 19 Mar
 2021 02:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <202103191536.9cD1TuQQ-lkp@intel.com>
In-Reply-To: <202103191536.9cD1TuQQ-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 11:57:42 +0200
Message-ID: <CAHp75Vchoe2Z00ODh_AWos3Chfa1AoQMjZw7aD=5cGsTFtK7hQ@mail.gmail.com>
Subject: Re: include/linux/unaligned/be_byteshift.h:46:19: error: redefinition
 of 'get_unaligned_be32'
To:     kernel test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:05 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Linus,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b12a62a4e3ed4ae99c715034f557eb391d6b196
> commit: de8860b1ed4701ea7e6f760f02d79ca6a3b656a1 iio: magnetometer: Add driver for Yamaha YAS530
> date:   10 weeks ago
> config: m68k-randconfig-s032-20210318 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-277-gc089cd2d-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de8860b1ed4701ea7e6f760f02d79ca6a3b656a1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout de8860b1ed4701ea7e6f760f02d79ca6a3b656a1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/build_bug.h:5,
>                     from include/linux/bitfield.h:10,
>                     from drivers/iio/magnetometer/yamaha-yas530.c:22:

Isn't it fixed already somewhere?

...

> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>    Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
>    Selected by
>    - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
>    - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC

This one though is interesting.
Cc Takashi and Mark.

-- 
With Best Regards,
Andy Shevchenko
