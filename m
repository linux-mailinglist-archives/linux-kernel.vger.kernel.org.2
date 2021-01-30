Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D364309153
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 02:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhA3BoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 20:44:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhA3BZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 20:25:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC2C364E00;
        Sat, 30 Jan 2021 01:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611969907;
        bh=T42vQQnHO3/8n4KuyGLEALdluT/J2taSOFlIP8OqNsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZJS22IlosZEI9m8pKO6iRShcu1QsbhsxOYntickTZbq5RIFT8je4JNofqvmYq8+M
         Im0QTLFfr9/UriCoUyUJ9n6NkFslFFIJOVo5rCHF/ESwgq6yiZzasZ8d87lpJVHprP
         onuswM4FcPjA9nv27hUumAcGa2BeJXwJZh71s/4MjbMI1SZM1TfO+31BCKuNgE8PMM
         XaxwVI1NjeGAgLt4fwyjfyOjPJqDu5Kgn8sjjRHMkITc8SIiH4bBvpCaeFtgKqVtmd
         u40+cmCwHfAedZabvPTFwPfEvCoKOkqjgKGgwssKIf3/FKfjD5wbkThxor3Ov6vvt6
         4Iz0tXldTPFjQ==
Date:   Fri, 29 Jan 2021 18:25:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from
 `arch/arm64/kernel/ftrace.o' being placed in section `.eh_frame'
Message-ID: <20210130012505.GA2709570@localhost>
References: <202101300946.OtCDTkmd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101300946.OtCDTkmd-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 09:21:49AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bec4c2968fce2f44ce62d05288a633cd99a722eb
> commit: b3e5d80d0c48c0cc7bce56473672f4e6e1210910 arm64/build: Warn on orphan section placement
> date:   5 months ago
> config: arm64-randconfig-r013-20210130 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 275c6af7d7f1ed63a03d05b4484413e447133269)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3e5d80d0c48c0cc7bce56473672f4e6e1210910
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b3e5d80d0c48c0cc7bce56473672f4e6e1210910
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    aarch64-linux-gnu-ld: warning: -z norelro ignored
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/main.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/version.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/do_mounts.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/do_mounts_rd.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/do_mounts_initrd.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/initramfs.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/calibrate.o' being placed in section `.eh_frame'
>    aarch64-linux-gnu-ld: warning: orphan section `.eh_frame' from `init/init_task.o' being placed in section `.eh_frame'

https://lore.kernel.org/lkml/20210130004650.2682422-1-nathan@kernel.org/

Cheers,
Nathan
