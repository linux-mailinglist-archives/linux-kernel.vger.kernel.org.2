Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397C23EC40B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhHNRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbhHNRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:16:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2037C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:15:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso20697761pjy.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X89ku5IDylZ1zwbfbGJrUBVg0+UG1yM+AcWfc0AL66w=;
        b=gBCrblHim1HHYufy0bB0YT8bU/AcwW0zmJYoIgHaFn2hDS5DYT0RV7fTzwF+1ij3WP
         BU7mnp58yA6B0PAlbCwUH1bcI0RdNUGVpHsw0kSc3YqEPFQWttK/hm2JQClb8QUnEBuK
         Mr3ITxtSUiQwxZZMfZnKDF1btrS+hT31QdKgPyUwVk0H/5G+IblAcKR1feOtpxYlwJjs
         EEbNgIL4pkN9LDxwz2HyhZdD4U3fsN8BfdNhabJaLlM0seCblplq0G9e9m1GAtjZpbN9
         OjPnOkokHN28HZaX+9+Qs6E/9l0nhOdFpCtnwChoyE0n/7OESW/p2gHVOvf02v7nvnYM
         WqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X89ku5IDylZ1zwbfbGJrUBVg0+UG1yM+AcWfc0AL66w=;
        b=iYWaO6jjOslavVLtGsfi8xnnec6ikV9uQF8H5IIFVnkZu/MZ/BCEYa98+joM5/a6Bi
         sqVfn4m+TXS3cWinu+S/aqmF5xCFFGduUalmaLBGJBVpG8/rg2GZ0oRzsrALQ4Uwg/Yb
         D9RoRjdg1lw0QgW06sSQzAbOL83aZRv8Ry+I2aECS8A8hfe4+nD5uIUl0ik9++p4u3GY
         a34579oWiawApigeM0lJZFz2OSE7wmTWWM39ILQicHG1Y6yQNq3F+UL7h6eD8Orx+1JW
         qxZcDWom8drNKrwAFaFADhpJT9cKcyfpcI6kQ5yxMoPYU+q2iak/RRylnz+YYY+NTGo5
         EXAw==
X-Gm-Message-State: AOAM5323zACJBByds993iULp7c4+i83vO4d1rJzyNpKbaRTT8iJ9Y+FS
        cGguS7DQf2vczbb8DqcG+w4pSvILhn+BFzq/lT0=
X-Google-Smtp-Source: ABdhPJyEtMF43bku7aItmMVxzEbSZMzxMtKXnE+6NZSsH1ZTVrR0LI9cGIWC+nmqtqsyvUJr8ACi2I95deLsTn9Z8RY=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr7896925pfi.7.1628961358161; Sat, 14 Aug
 2021 10:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <202108141955.XlQXw3y4-lkp@intel.com> <YRfGfcwxFR0L/e77@kroah.com>
In-Reply-To: <YRfGfcwxFR0L/e77@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 20:15:21 +0300
Message-ID: <CAHp75VdzjsqnwprykT8phofnkUit8087Tz87YuhaZ8dAuExaqQ@mail.gmail.com>
Subject: Re: [driver-core:driver-core-testing 28/31] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the
 function bitmap_equal() to the variable .init.data:initcall_level_names
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 4:36 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Aug 14, 2021 at 07:03:00PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > head:   3b35f2a6a625126c57475aa56b5357d8e80b404c
> > commit: 291f93ca339f5b5e6e90ad037bb8271f0f618165 [28/31] lib: test_bitmap: add bitmap_print_bitmask/list_to_buf test cases
> > config: xtensa-randconfig-r004-20210814 (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=291f93ca339f5b5e6e90ad037bb8271f0f618165
> >         git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> >         git fetch --no-tags driver-core driver-core-testing
> >         git checkout 291f93ca339f5b5e6e90ad037bb8271f0f618165
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> WARNING: modpost: vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the function bitmap_equal() to the variable .init.data:initcall_level_names
> > The function bitmap_equal() references
> > the variable __initdata initcall_level_names.
> > This is often because bitmap_equal lacks a __initdata
> > annotation or the annotation of initcall_level_names is wrong.
> >
> > The below error/warnings are from parent commit:
> > << WARNING: modpost: vmlinux.o(.data+0x1a86d8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:__setup_str_initcall_blacklist
> > << WARNING: modpost: vmlinux.o(.data+0x1a87c8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:__setup_str_initcall_blacklist
> > << WARNING: modpost: vmlinux.o(.data+0x1a8948): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:__setup_str_initcall_blacklist

> Barry, can I get a fix for this?

Max already pointed out, but I guess you were not in Cc list, that
it's a GCC bug in his opinion, but GCC people don't ack it.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

-- 
With Best Regards,
Andy Shevchenko
