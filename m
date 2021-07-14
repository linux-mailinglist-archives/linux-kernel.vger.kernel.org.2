Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336EB3C91BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhGNUGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGNTzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 15:55:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AFC08E89B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:46:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s18so3585661pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+SP2qwBUBEhY6IAZuttgDWFmbqTQqYebB9+KCj6SoU=;
        b=tk4J9e1ySYOMaMY1jOkm4AFYeX/ymWT3jrzU+nYmQNlF5xTI5VGfWDm3HKJjIJMdCv
         6w8OFdfCklhMkBkGw0cmxVq+ZHmbqkfbfQoX/VsLjJrwRrIvbiKPAJV3it4fv1jd2a4W
         rLDS2oNaXALaYX7cQmdxuvmYSBAof0nOhVg7Vf1KK5JB4QIs7VIWnNWXoUtKI96vfXdr
         4VFepr/Wy5wrdgDpXil6dVIQPDROrQ1GaT2h250lqcQqAHjrKQNr60ZFuuBfFHPLa/nO
         RnaDxP/86UE6FRN+29ti9y0YI0G8jOW6vc3mxEx3KxM/gaaA2e5jbDohezfysBsvBEfB
         iGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+SP2qwBUBEhY6IAZuttgDWFmbqTQqYebB9+KCj6SoU=;
        b=TVkyLdnkwR5w18uLdqsrKuQ+pAL+6exeWB6q16GpY52MES0ex09slSew7+ns8Wy7f3
         FfUxHNTaN0MMPzlbviYoBsKsVGz3JatcKb8YgIZbMw7Xm2Oc94esGXTip9/Krdjl1WuH
         5GIyUsaihEbo4K049rmPkEJ1MgHyhsCHmCLKp5gxcvfCcYTt0Xj5RD8rV+f9GA4OS71y
         Uk7cCDkKKIJL/bC19VQYxbOsdOjP3xZ9/4eOZKDdp/POzG4znG1ErU1MiaL92vOUoDq4
         EcRA+7Bw41gVXBNXBse2HJB8co6TKHZGtsHt+EN6CHU0HBiIHgLfdor1O5TehpNYSh27
         UI7g==
X-Gm-Message-State: AOAM533CipxDjQbkmEboOU2XWn7eXynR5TkypfQ4Tz1dIdQfZeu0XFuU
        9hjfjHsKTnlX9K9jYmFRoP77BjDYgw5ajT/8sPk=
X-Google-Smtp-Source: ABdhPJySsdcwZ3z5Mrg8UZ2vJE401uuDyGbgAsJQ68uIutzFbQg0M3sD0FfqRuuccr03WACQOJc1yDNxvc65Xun982k=
X-Received: by 2002:a63:5a5b:: with SMTP id k27mr11266870pgm.74.1626291962577;
 Wed, 14 Jul 2021 12:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <202107150148.RpWnKapX-lkp@intel.com>
In-Reply-To: <202107150148.RpWnKapX-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jul 2021 22:45:26 +0300
Message-ID: <CAHp75Vfu1rhUV+SOq2ikFWd2G6x9j3BT6OLPhPcf8VZE5Umeqw@mail.gmail.com>
Subject: Re: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking
 address of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
To:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Nick. Nick, any recommendations on how to fix this in the best
possible way?

On Wed, Jul 14, 2021 at 8:58 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   8096acd7442e613fad0354fc8dfdb2003cceea0b
> commit: e927e1e0f0dd3e353d5556503a71484008692c82 v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
> date:   5 months ago
> config: mips-randconfig-r004-20210714 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8d69635ed9ecf36fd0ca85906bfde17949671cbe)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e927e1e0f0dd3e353d5556503a71484008692c82
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e927e1e0f0dd3e353d5556503a71484008692c82
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_pix_format_mplane' may result in an unaligned pointer value [-Waddress-of-packed-member]
>                            mp->width, mp->height, &mp->pixelformat,

This seems unsolvable without copying a value.

> >> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]

Why is it packed in the first place? Is it used on unaligned addresses
in other structures? But even so, why should it matter?

> >> drivers/media/v4l2-core/v4l2-ioctl.c:353:5: warning: taking address of packed member 'dataformat' of class or structure 'v4l2_meta_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
>                            &meta->dataformat, meta->buffersize);

Ditto.

-- 
With Best Regards,
Andy Shevchenko
