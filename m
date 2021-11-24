Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764845C77A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbhKXOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356235AbhKXOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:36:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B11CC044483
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 05:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ysgUIgE8N4V/O9rt7wlOvYKdbD8v6/TW3kFhD5P/SUE=; b=hkAdUBrzpTdAUNhhYwFDlr88Dm
        g52YwTjnt8dVf0iPnKesXKi7+tPokAJDmhx8J1wb0mIzv/iRsdERoIEOrm18mWR8QiL9pjTQl41LD
        fSP+D78CUso75mRZVVI33kDTOQhogDr2siXwnziGp0sllMDRNORK9wO9XeuH34DhveA8N8s2sDnnH
        6yLTwbjsA0tT4stSh45FQCjtk8HmzGwLIs6GbgwOaSA/sX63PtABsm8RgNq/Xwx4JYpe2HB0KF3U7
        yuYOsaRQlsYEIr/HRLP3Z7BbEFldCTdNXCubCjZWrJTyaHyNzns8gXOFppQIagdODxf3wwO2+2Kk4
        GC9omHYg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpsIz-004ryo-O0; Wed, 24 Nov 2021 13:27:21 +0000
Date:   Wed, 24 Nov 2021 05:27:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mcgrof-next:20211123-sysctl-cleanups 41/41]
 kernel/kprobes.c:52:1: error: function declaration isn't a prototype
Message-ID: <YZ49uVqN1WHx7H40@bombadil.infradead.org>
References: <202111241540.e3ukBGer-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111241540.e3ukBGer-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:01:56PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211123-sysctl-cleanups
> head:   c18add41d859b4feec081eab6cfd624a5642973d
> commit: c18add41d859b4feec081eab6cfd624a5642973d [41/41] kprobe: move sysctl_kprobes_optimization to kprobes.c
> config: sparc-randconfig-r002-20211123 (https://download.01.org/0day-ci/archive/20211124/202111241540.e3ukBGer-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=c18add41d859b4feec081eab6cfd624a5642973d
>         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>         git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
>         git checkout c18add41d859b4feec081eab6cfd624a5642973d
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=sparc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/key.h:17,
>                     from include/linux/cred.h:13,
>                     from include/linux/sched/signal.h:10,
>                     from include/linux/rcuwait.h:6,
>                     from include/linux/percpu-rwsem.h:7,
>                     from include/linux/fs.h:33,
>                     from include/linux/huge_mm.h:8,
>                     from include/linux/mm.h:717,
>                     from include/linux/kallsyms.h:13,
>                     from include/linux/ftrace.h:12,
>                     from include/linux/kprobes.h:28,
>                     from kernel/kprobes.c:23:
>    include/linux/sysctl.h: In function 'register_sysctl_mount_point':
>    include/linux/sysctl.h:270:1: error: expected ';' before '}' token
>      270 | }
>          | ^
>    kernel/kprobes.c: At top level:
>    kernel/kprobes.c:52:1: error: return type defaults to 'int' [-Werror=return-type]
>       52 | kprobe_sysctls_init() do { } while (0)

Fixed. Thanks.

  Luis
