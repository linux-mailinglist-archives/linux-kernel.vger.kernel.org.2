Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DD33CB0FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhGPDOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhGPDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:14:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:11:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s18so12027962ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student-cerritos-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=glNO2PUmrGtJw3esP1XUx4uN57NDYiuLSGwdyXUkipw=;
        b=hh9SfkPisqM15nqfeIuNKMDsj5Pe/TsIt1Hkh40281lbxLTocGDeYetMMssApWx9yD
         uLPjDW5vGWIsokh4oKNxNiSCFgCnPoJ4Uay6dkXHLoAfLdfZQ9xJlWiVPWOOnKDlWuC4
         R9F3/I8jFKgar0j3uEGxHxI7iIJ3lc8BD8J+1uRsiSpi+TySAwKsUULLz5YAIG8OMZDf
         smqAbxCxFSvkZ5tde/SBHyce1lFKWYb6X1Bl/mryLwzLZ6t4Q8vVZZ0KxUjYrewlCYBA
         ExHGxh+HWTSh+Nrl0jMq5RTzZgGV/2LWMKtbqOiXhvoGuMj9BXp+o2uZjt1W/rC0nEN1
         QeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=glNO2PUmrGtJw3esP1XUx4uN57NDYiuLSGwdyXUkipw=;
        b=PSLyvdbpGb/8fY0EttlQPCslJxUKPKX+qG0e4nnM1D5c/FT5eY1nZtx3SBNuHfVF8d
         DT93ih4fjQzNpnepTBaA5bnrmgYs/C98bvXxYfO9DGdyQgsYgnXY++FmSCrcEMcpWIrn
         RGWK4dsBKpMZ+JX533sRdAtO+1bicgEntcPFEeK9HYhhEbzYgV3TTGBg6jL2TK8gEXsM
         yv60YbhnGSn7I0zJRO++nKa3lsdGP4M6MCQreLqNc4+B8AvQva711/irG4L7qNM0MJtn
         ksYm/u23j2bxxVMe6tkJNyZrqLjDKDHTRTBqbYWypa4LRy2GqY5drFhXRHk5DObQ/Aqd
         +HBw==
X-Gm-Message-State: AOAM532SKQgNmPPpFQZFDCeHJXhSNxM4Alx5UCqCYVpbZ0OXT14FZXcN
        DhpVYtps47zkfbAcTb9gTQLJqcnh2NJctcbmQzU0TA==
X-Google-Smtp-Source: ABdhPJwiP8nX+D79pxC0iYGGE0OZRvV8iPrVowFtXe9t5wq+lcSJOgNBNzeJBHccjqH2Ywc6hx2DJtikAjubIm7Iv7Q=
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr6927918ljg.251.1626405103352;
 Thu, 15 Jul 2021 20:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <9b5902665dcc4c0fca7546987303e348d8657f59.1626383424.git.apark0006@student.cerritos.edu>
 <202107161046.heIVRW8r-lkp@intel.com>
In-Reply-To: <202107161046.heIVRW8r-lkp@intel.com>
From:   Amy Parker <apark0006@student.cerritos.edu>
Date:   Thu, 15 Jul 2021 20:11:32 -0700
Message-ID: <CAPOgqxHndN+3J-C7+38vLedhN2bhAasW9JRxf-rvt7gvVhD1rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] swap led_brightness from enum to typedef
To:     kernel test robot <lkp@intel.com>
Cc:     pavel@ucw.cz, kbuild-all@lists.01.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah - I see there was an issue with header files not being properly updated.

Check back for another patch resolving this.


On Thu, Jul 15, 2021 at 7:15 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Amy,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.14-rc1 next-20210715]
> [cannot apply to pavel-linux-leds/for-next wireless-drivers-next/master wireless-drivers/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Amy-Parker/leds-change-led_brightness-definition-from-enum-to-typedef/20210716-052140
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd9c7df94c1b23feacd54112f33ad95d93f64533
> config: m68k-buildonly-randconfig-r006-20210715 (attached as .config)
> compiler: m68k-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/b14a971f1045205d49d9d001f33d33afdd8208f9
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Amy-Parker/leds-change-led_brightness-definition-from-enum-to-typedef/20210716-052140
>         git checkout b14a971f1045205d49d9d001f33d33afdd8208f9
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/md/bcache/ drivers/media/v4l2-core/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/media/v4l2-core/v4l2-flash-led-class.c:15:
> >> include/media/v4l2-flash-led-class.h:18:1: warning: useless type name in empty declaration
>       18 | led_brightness;
>          | ^~~~~~~~~~~~~~
>
>
> vim +18 include/media/v4l2-flash-led-class.h
>
>     14
>     15  struct led_classdev_flash;
>     16  struct led_classdev;
>     17  struct v4l2_flash;
>   > 18  led_brightness;
>     19
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Amy Iris Parker
Please refer to me using she/her pronouns.
CIS Major
Dual Enrollment with WHS co2025
