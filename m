Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706C3EC7B7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhHOGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhHOGgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C73DD60E97;
        Sun, 15 Aug 2021 06:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629009356;
        bh=iG8/1uEQnuQbL8AOB0uEcrxM/IfJQ2MTmeufhIsvyNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mrk2vSog7dvb+xd/oMDBPgZBP6nuqDJKGXA3UavmmJoDUley2nmkCClKOO4/rNXdg
         f+g/UKfaBSqsKLuAuHgNPv8Njt5D8OxrsoaJOWqkATWWqGXMLgkSO3AD8ZWIYeGrxf
         rnObwmxvB3RMg9E6zDpMg+uduvsxKDlLnUYImOHM=
Date:   Sun, 15 Aug 2021 08:33:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [driver-core:driver-core-testing 28/31] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x156c): Section mismatch in reference from the
 function bitmap_equal() to the variable .init.data:initcall_level_names
Message-ID: <YRi1J5iL9kdL5+Ng@kroah.com>
References: <202108141955.XlQXw3y4-lkp@intel.com>
 <YRfGfcwxFR0L/e77@kroah.com>
 <CAGsJ_4y+f1emWzRH5mX-t_1=PcY-uMe70n79WRacmmVM5UCUTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4y+f1emWzRH5mX-t_1=PcY-uMe70n79WRacmmVM5UCUTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2021 at 03:27:04PM +1200, Barry Song wrote:
> On Sun, Aug 15, 2021 at 1:36 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
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
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > Barry, can I get a fix for this?
> 
> Hi Greg,
> As I replied to Andy, this warning has nothing to do with my commit as my
> commit doesn't call the involved functions at all.
> 
> It has been there for more than one year. but i still send a patch for
> this issue
> over here:
> https://lore.kernel.org/lkml/20210815032132.14530-1-21cnbao@gmail.com/T/#u
> 
> Note this patch is not fixing the latest commits. It is a general
> patch for bitmap.

Ah, ok, nevermind, I missed that.

greg k-h
