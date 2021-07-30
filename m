Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A23DC11A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhG3Wdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhG3Wdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:33:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293C4C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=BQTjsw+UIinxocEC0qr+MREl4u9UoUD4PRqQWjNAf6g=; b=uVkpEhPwZ9nMb9q0lUYb6Sx8/M
        XlxPAf5zdS6PbrxsyyFxbzD9mUJhd2UTCPVrN3Kl1CRpxswEVPEGmjcV2jdDxcI0wG8e6g2tLuTjF
        PUnbqRwwNgI0Fy47fbpINfQYcsJCCG4d+JVBSk66YkIljbRDsSsYhJVETDYtovBpaIL1e5qop+Rv6
        I7wvbXVhXdT8rlDVAMjEYBT4wjM+J/mfrwI0KlLrP9Gp7QDIjwUGZQ/A8s2o8dGzIikbEVC3Ujadw
        cASyGPgsuLw7sPrcKzV9AgYohpfWkOmbhV2KKcTTdqKqdDgVfDllQZpE0mQCAIDOsuYlFJqeJ1FGt
        3yBjM7Ww==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9b4b-00AR4y-Ak; Fri, 30 Jul 2021 22:33:45 +0000
Subject: Re: drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1046:11: error: use of
 undeclared identifier 'pm_suspend_target_state'
To:     kernel test robot <lkp@intel.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
References: <202107301618.ENDZx6ZW-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6662aaa4-f1da-56bf-08c4-9af562bb61cd@infradead.org>
Date:   Fri, 30 Jul 2021 15:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202107301618.ENDZx6ZW-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 1:17 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
> commit: 91e273712ab8dd8c31924ac7714b21e011137e98 drm/amdgpu: Check pmops for desired suspend state
> date:   3 days ago
> config: x86_64-randconfig-a002-20210730 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c49df15c278857adecd12db6bb1cdc96885f7079)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91e273712ab8dd8c31924ac7714b21e011137e98
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 91e273712ab8dd8c31924ac7714b21e011137e98
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1046:11: error: use of undeclared identifier 'pm_suspend_target_state'
>                            return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>                                   ^
>    1 error generated.


A patch has been posted and accepted.

https://lore.kernel.org/lkml/CADnq5_PPYtdb17WLtgjeS3THXBeHw_DyMKueZ4LP8cVS1G8Tcw@mail.gmail.com/

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
