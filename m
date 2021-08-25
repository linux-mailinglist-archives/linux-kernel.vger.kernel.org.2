Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247B3F710A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbhHYIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhHYIV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:21:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B8F3610F7;
        Wed, 25 Aug 2021 08:20:39 +0000 (UTC)
Date:   Wed, 25 Aug 2021 10:20:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [smfrench-smb3-kernel:pr/65 143/143] fs/ksmbd/smb2pdu.c:5640:6:
 warning: variable 'user_ns' is used uninitialized whenever 'if' condition is
 true
Message-ID: <20210825082037.iuy5gndi4n2uyep7@wittgenstein>
References: <202108251550.SXFHPzdJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202108251550.SXFHPzdJ-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 03:14:01PM +0800, kernel test robot wrote:
> tree:   git://github.com/smfrench/smb3-kernel.git pr/65
> head:   4b499755e1024f97e75411920a404b357af6e153
> commit: 4b499755e1024f97e75411920a404b357af6e153 [143/143] ksmbd: fix lookup on idmapped mounts
> config: hexagon-randconfig-r041-20210824 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d26000e4cc2bc65e207a84fa26cb6e374d60aa12)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/smfrench/smb3-kernel/commit/4b499755e1024f97e75411920a404b357af6e153
>         git remote add smfrench-smb3-kernel git://github.com/smfrench/smb3-kernel.git
>         git fetch --no-tags smfrench-smb3-kernel pr/65
>         git checkout 4b499755e1024f97e75411920a404b357af6e153
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=hexagon 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report but this is outdated and requires a patch that
sits in David Sterba's for-next tree. So this is safe to ignore.
Feels like this probably should only go to the authors, kbuild-all and
clang-built-linux lists similar to what the intel built bot does.
Otherwise this generates a lot of unneeded noise. Just my 2 cents.

Christian
