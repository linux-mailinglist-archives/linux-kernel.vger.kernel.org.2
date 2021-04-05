Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F202354725
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbhDET3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 15:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240126AbhDET3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 15:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B74F7613B8;
        Mon,  5 Apr 2021 19:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617650949;
        bh=bzUPKzJcAzUg9135K6PV+zAgO5dxTzilLlIATkvx7n4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D57OXMd1INCX2QACLpD55GFCuYZcdVEyDUM09lWQVt8GFP/AD8WkymG9ULOw/DgTN
         jgRAlVKhOfrjEUvPAcYO9Suc+zHB9ZS10g8kxL2wcjWGpP2SlxL26B7iH7AH7G+XMN
         JQ93CHNYKjnf0lt15lZZWbe272uweWiI4mbzyQdY=
Date:   Mon, 5 Apr 2021 12:29:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: lib/test_kasan_module.c:25:6: warning: variable 'unused' set
 but not used
Message-Id: <20210405122908.a478d97cdc9495638e61b566@linux-foundation.org>
In-Reply-To: <202104050216.HflRxfJm-lkp@intel.com>
References: <202104050216.HflRxfJm-lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2021 02:16:25 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Andrey,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2023a53bdf41b7646b1d384b6816af06309f73a5
> commit: 5d92bdffd2d53f98de683229c0ad7d028703fdba kasan: rename CONFIG_TEST_KASAN_MODULE
> date:   6 weeks ago
> config: arm-randconfig-r024-20210404 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d92bdffd2d53f98de683229c0ad7d028703fdba
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5d92bdffd2d53f98de683229c0ad7d028703fdba
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/test_kasan_module.c: In function 'copy_user_test':
> >> lib/test_kasan_module.c:25:6: warning: variable 'unused' set but not used [-Wunused-but-set-variable]
>       25 |  int unused;
>          |      ^~~~~~

Fair enough ;)

--- a/lib/test_kasan_module.c~a
+++ a/lib/test_kasan_module.c
@@ -22,7 +22,7 @@ static noinline void __init copy_user_te
 	char *kmem;
 	char __user *usermem;
 	size_t size = 10;
-	int unused;
+	int __maybe_unused unused;
 
 	kmem = kmalloc(size, GFP_KERNEL);
 	if (!kmem)
_

I guess we could test the copy_*_user return values are as expected,
but that isn't the point?
