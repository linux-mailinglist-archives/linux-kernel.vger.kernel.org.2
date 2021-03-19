Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADCC34190F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCSJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCSJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:59:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:59:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so8234424pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akYide/UYlopY2H9qw9/b5SLCouXQae329RPzn276ZY=;
        b=bONEnCzZdEoloMGEr3gtCTmDnHTO9VleRRX8pFx79W49qC59d9nXkgIqgDfPY7brpM
         nXPhy5qC6eB9JiB27FYdhbeHgX/HN8oo6xRuFE4FsTPCHFv5eimM289G1si1n3RGZMwz
         aXG8jCP/BI3B5JTrB9MEN2D47Nn1+AP0IDEV6NEvVu2JHBfmiDK+XeK3ytT/lGT6iHZo
         fa5zOZlfOrP8kMQXkZScFlRdvR6v5OuMTaf+j2jde6iv6INNqNU9L2z/SMGebyD8g8Nj
         TPjOuCMsMVuhVcmJN78jOd1/SD7OhhWQxc4Jh1P1Pd2CR98Kr8zS3MdrBOPE6MtMBfDj
         G5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akYide/UYlopY2H9qw9/b5SLCouXQae329RPzn276ZY=;
        b=ilHWvSdsg6pwdeVOKcfQdnLgBBsiQguBnVzWZTuMyzm7kI/c/FuEghqDVU/hlc68Zr
         HgRqbsklIqc18cXiZmLISnADCZ5py82Umj3PTzeZOc7p5OSH1VA4yCL5QIpmTEeitSmb
         tFyLhTw8Pr6Pw4soDRvGhDuYtaM45wshzyvQ7rKdBaT3wxIiCan2fqOMa7VdEg4h9hpH
         AC6kWN2vnhVETzFGWob6ooHPzKaGBb7lYA1hcicDpMgL6qVJNzocuSLqn16ZN9iclKHs
         ZJjP6ON371TNxHD+WfdGlDP8gJz1Z0wsOmrTPxcDJlwtuJIa7P4kCUZGwbmAmoZxe8ho
         2Ghg==
X-Gm-Message-State: AOAM5337G1dU5575Zt7FplhHzDJXPly3y4TJruqlK4v0uBjG0Hte8jf9
        6Tbc3xoNT4c8fKB36S+EMHrpSx9bOkIeu++UhBA=
X-Google-Smtp-Source: ABdhPJzR+6h9MG/RbdjM7J9hTMHkREGVqQJJv9MfEF8zt3rjVuaJTqf+1LH6YcW4NZgPnEoJLaeVK0c3fFgcbE3XQzc=
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id
 u8-20020a170902c808b02900e64204f62fmr14049309plx.0.1616147970729; Fri, 19 Mar
 2021 02:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <202103191641.GBWuxxaN-lkp@intel.com>
In-Reply-To: <202103191641.GBWuxxaN-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 11:59:14 +0200
Message-ID: <CAHp75VfAmSTSFscK2wfRy1qT_ekyE6KODjAttEkoCKgW42VgFA@mail.gmail.com>
Subject: Re: include/linux/unaligned/be_byteshift.h:41:19: error: redefinition
 of 'get_unaligned_be16'
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:49 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Linus,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8b12a62a4e3ed4ae99c715034f557eb391d6b196
> commit: de8860b1ed4701ea7e6f760f02d79ca6a3b656a1 iio: magnetometer: Add driver for Yamaha YAS530
> date:   10 weeks ago
> config: m68k-randconfig-r034-20210318 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de8860b1ed4701ea7e6f760f02d79ca6a3b656a1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout de8860b1ed4701ea7e6f760f02d79ca6a3b656a1
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/iio/magnetometer/yamaha-yas530.c:35:
> >> include/linux/unaligned/be_byteshift.h:41:19: error: redefinition of 'get_unaligned_be16'

Yeah, same comment as per previous similar report.


-- 
With Best Regards,
Andy Shevchenko
