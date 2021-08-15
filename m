Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BE43EC619
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhHOAFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:05:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB8C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 17:04:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d11so25134738eja.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D0JZ/4CFrMQnflzHYWmUqwXbahD2FdrCYTGEQUEz/N8=;
        b=vHbrwW3F1f+Pu6XkjnMvG4JNcM5+L1fablWUCH1mRVaDdX1SEaYzJC0XO0r1Afm+Pr
         O1CJPEEfGsHP/7/2zGw/kynePnLuaepkRzHtvq9Rcu3NCz/oqGdA+3NUacogsIb7StUx
         LiNAOjoP5qw7cX4mnenjUg27KvPQDnC2j7yVcbdTTXjkqOR6+cM8Ed0QyIeJlN6lLjG9
         9a8oxALAkcQT/XXkPsGSCZkyWIe7KCoya9Vvg5ZSKSWJQB5S+Kx//zmoFW5y7uOS36U8
         AyOWtYPxLiFOs60+0UE508f/kq5/8525dvBdlmo3cW/dc/kpCP0Lbukv87nvYrXAvmSl
         jxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D0JZ/4CFrMQnflzHYWmUqwXbahD2FdrCYTGEQUEz/N8=;
        b=ar0bqcpe3IylRAje3HfeYT9n64uXv/yYYAHd9uOYher0hknm4+z/oGPfIt5uC4PYiZ
         i/RrJEE9vo83n7+mwd5BhPplBVCaISboMlnVc/BAv0VolAZW9cvz+kn/OKQcfqs3rpJX
         NqytEFNs/VaOaIc+o4wQIs2ad4BhYDJER1fwu+oV6RXEMg2DO1zmdUvLyo/VwQjKAEUy
         6Kb8tDLfqsbv5KPAQDUrUjCbwK3KE0AEeL64oLaaV9ZlpulOEd4PI8VXCl9WCBxho/Bu
         14QDyTdI8rbI1SqHfQdQASYGwby6E4QZnNhHtq2EcxILiYEIfy93ZzZr2lYZ7DL7jgKy
         xEdw==
X-Gm-Message-State: AOAM530Tvv9vLAMZOHA53t6G/H6BJX5ONZXdAQ0lCkW9AnFy7JSq8t54
        fbxgJ8TEvMAzZd8PRmBQVJEKQA2SF6XaICuUyQo=
X-Google-Smtp-Source: ABdhPJxObEEtiPl1IHsWzV33POZADPWPx2Axvra4LhipYgTw4OKRl74JMKvyZzKp7/eJkvSBkhC44q83kOuMed7Ts+0=
X-Received: by 2002:a17:906:c316:: with SMTP id s22mr9355198ejz.39.1628985875014;
 Sat, 14 Aug 2021 17:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <202108141955.XlQXw3y4-lkp@intel.com> <YRfGfcwxFR0L/e77@kroah.com> <CAHp75VdzjsqnwprykT8phofnkUit8087Tz87YuhaZ8dAuExaqQ@mail.gmail.com>
In-Reply-To: <CAHp75VdzjsqnwprykT8phofnkUit8087Tz87YuhaZ8dAuExaqQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 15 Aug 2021 12:04:24 +1200
Message-ID: <CAGsJ_4wzoSLpaPzgQh5k-zwbJEBgN3ckM_MpGz-72ayCeT6aMQ@mail.gmail.com>
Subject: Re: [driver-core:driver-core-testing 28/31] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the
 function bitmap_equal() to the variable .init.data:initcall_level_names
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 5:18 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 14, 2021 at 4:36 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Aug 14, 2021 at 07:03:00PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> > > head:   3b35f2a6a625126c57475aa56b5357d8e80b404c
> > > commit: 291f93ca339f5b5e6e90ad037bb8271f0f618165 [28/31] lib: test_bitmap: add bitmap_print_bitmask/list_to_buf test cases
> > > config: xtensa-randconfig-r004-20210814 (attached as .config)
> > > compiler: xtensa-linux-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=291f93ca339f5b5e6e90ad037bb8271f0f618165
> > >         git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> > >         git fetch --no-tags driver-core driver-core-testing
> > >         git checkout 291f93ca339f5b5e6e90ad037bb8271f0f618165
> > >         # save the attached .config to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > >> WARNING: modpost: vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the function bitmap_equal() to the variable .init.data:initcall_level_names
> > > The function bitmap_equal() references
> > > the variable __initdata initcall_level_names.
> > > This is often because bitmap_equal lacks a __initdata
> > > annotation or the annotation of initcall_level_names is wrong.
> > >
> > > The below error/warnings are from parent commit:
> > > << WARNING: modpost: vmlinux.o(.data+0x1a86d8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:__setup_str_initcall_blacklist
> > > << WARNING: modpost: vmlinux.o(.data+0x1a87c8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:__setup_str_initcall_blacklist
> > > << WARNING: modpost: vmlinux.o(.data+0x1a8948): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:__setup_str_initcall_blacklist
>
> > Barry, can I get a fix for this?
>
> Max already pointed out, but I guess you were not in Cc list, that
> it's a GCC bug in his opinion, but GCC people don't ack it.
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

I really don't understand what is going on here. My understanding is
this report has nothing to do with the
new commit and it doesn't report any valid place where kernel code is wrong.

with xtensa gcc 11.1 which is the one i can easily download from here
after google:
http://kernel.c3sl.ufpr.br/pub/tools/crosstool/

i could somehow reproduce this kind of very odd section mismatch
report from bitmap:
$ ./build-xenta.sh
  ...
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(.text.unlikely+0x4d64): Section mismatch
in reference from the function bitmap_equal() to the variable
.init.rodata:__setup_str_initcall_blacklist
The function bitmap_equal() references
the variable __initconst __setup_str_initcall_blacklist.
This is often because bitmap_equal lacks a __initconst
annotation or the annotation of __setup_str_initcall_blacklist is wrong.

...
WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0):
Section mismatch in reference from the (unknown reference) (unknown)
to the variable .init.data:bitmap2
The function (unknown)() references
the variable __initdata bitmap2.
This is often because (unknown) lacks a __initdata
annotation or the annotation of bitmap2 is wrong.
...

But after reverting my commit, it is *still* there:

$ git revert 2069b8b9ce8b758e015ce49225b1fedac4accd9c
[scheduler e158c85c6ccc] Revert "lib: test_bitmap: add
bitmap_print_bitmask/list_to_buf test cases"
 1 file changed, 150 deletions(-)

$ ./build-xenta.sh
...
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(.text.unlikely+0x4d64): Section mismatch
in reference from the function bitmap_equal() to the variable
.init.rodata:__setup_str_initcall_blacklist
The function bitmap_equal() references
the variable __initconst __setup_str_initcall_blacklist.
This is often because bitmap_equal lacks a __initconst
annotation or the annotation of __setup_str_initcall_blacklist is wrong.
...
WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0):
Section mismatch in reference from the (unknown reference) (unknown)
to the variable .init.data:bitmap2
The function (unknown)() references
the variable __initdata bitmap2.
This is often because (unknown) lacks a __initdata
annotation or the annotation of bitmap2 is wrong.

  Kernel: arch/xtensa/boot/boot-elf/../Image.elf is ready
  GEN     Module.symvers

>
> --
> With Best Regards,
> Andy Shevchenko

Thanks
Barry
