Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882443D7000
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhG0HJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhG0HJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C22B261163;
        Tue, 27 Jul 2021 07:09:51 +0000 (UTC)
Date:   Tue, 27 Jul 2021 09:09:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [brauner:for-next 2/2] move_mount_set_group_test.c:3:10: fatal
 error: sched.h: No such file or directory
Message-ID: <20210727070948.gttmybwi4t65jysp@wittgenstein>
References: <202107270722.I0nMrn8E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202107270722.I0nMrn8E-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 07:48:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git for-next
> head:   8374f43123a5957326095d108a12c49ae509624f
> commit: 8374f43123a5957326095d108a12c49ae509624f [2/2] tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest
> config: openrisc-randconfig-s031-20210726 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 10.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?id=8374f43123a5957326095d108a12c49ae509624f
>         git remote add brauner https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
>         git fetch --no-tags brauner for-next
>         git checkout 8374f43123a5957326095d108a12c49ae509624f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash -C tools/testing/selftests install
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> move_mount_set_group_test.c:3:10: fatal error: sched.h: No such file or directory
>        3 | #include <sched.h>

I can fix this up in my tree directly, Pavel. No need to resend.

Thanks!
Christian
