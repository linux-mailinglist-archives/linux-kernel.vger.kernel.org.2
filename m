Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112593EC6DB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 05:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbhHOD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhHOD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:27:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DF5C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:27:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cq23so3897047edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1I31bPTWK5wuJTQPwHbt2ClA+rvrrEVj/Bd+LldpDs=;
        b=iB6NbZfjVgvfFozKMEq/pqlCV5NvI6JLXGWFadihUnvNz72rml/RQuaTzp1QCpzejo
         faX34k3cDsY5UOMvd+j2nBrnHK5MmHrYJS/a/QZni6LJYi8FDIMkP21/S70pxp+muM8E
         DjigKbYk8Wre1zf3TswBnZNMfODKwg6vK2Vd5yt8cgtvlQPprBH+subtTzaIbA/GBDrt
         EUh3vdR77nwSyA97HDmZOtTbjEFCQXNmPCpxP9aciuQl6kdqCKVCcJKywXW5kYX91DVc
         7jPNJfPyBiJfk99yCzlZdgwheg79NihF79hY16tSZ2OhmD7SbMSuForxxh5oHCjaERuZ
         P4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1I31bPTWK5wuJTQPwHbt2ClA+rvrrEVj/Bd+LldpDs=;
        b=pD8AzbTOb3NPkhSdFOnRmTTaNZRg4BwRdu2ZuWypfvgsQfqvioD8X+GO5Zq80A/p7u
         Q0r9q8vAzeGbgBvLzvxgneC1J47IXRGFyZwi/TK7KTrguIt3y6dcNi3Khc1AGM9/kNMd
         Unw8bav0oWEYgExWctH0ZbTxpTg/DlAqeMVIG79uUionABAnntPA7/GdfYdN1SyrHrhm
         Dg4eQcYCh0FYnNR0iTnE/s4M8IRtEaptGRCQZVF8HEbHNaiBviwxbM5xtZSdqLAKrI8n
         uX3IRxh6UKf+JpOz6k2MWAdSampgKA5ijzHvlC6lMK11wl8Aj4We/dSxzto+RGToWaEm
         dSKQ==
X-Gm-Message-State: AOAM530paVvoXkTEl5dW708b41Q1etY7qEqfhN/2WnLyqjh71jQbEGUu
        SUGduDHvAyqPvli0Cl+kL747/5fULT2l4G4H7Ig=
X-Google-Smtp-Source: ABdhPJyx81bZuaceSZKyp6p1j/NmW3aYa7p62yjWeU9ndTQMr7XIzo6nuwEIp5kaI1wbqiANIBbIIcI1yXVCTqte/9o=
X-Received: by 2002:aa7:c585:: with SMTP id g5mr12122453edq.340.1628998035789;
 Sat, 14 Aug 2021 20:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <202108141955.XlQXw3y4-lkp@intel.com> <YRfGfcwxFR0L/e77@kroah.com>
In-Reply-To: <YRfGfcwxFR0L/e77@kroah.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 15 Aug 2021 15:27:04 +1200
Message-ID: <CAGsJ_4y+f1emWzRH5mX-t_1=PcY-uMe70n79WRacmmVM5UCUTw@mail.gmail.com>
Subject: Re: [driver-core:driver-core-testing 28/31] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the
 function bitmap_equal() to the variable .init.data:initcall_level_names
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 1:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
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
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> Barry, can I get a fix for this?

Hi Greg,
As I replied to Andy, this warning has nothing to do with my commit as my
commit doesn't call the involved functions at all.

It has been there for more than one year. but i still send a patch for
this issue
over here:
https://lore.kernel.org/lkml/20210815032132.14530-1-21cnbao@gmail.com/T/#u

Note this patch is not fixing the latest commits. It is a general
patch for bitmap.

>
> thanks,
>
> greg k-h

Thanks
Barry
