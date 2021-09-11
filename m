Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D909407435
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbhIKAhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhIKAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:37:52 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A32C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ukec83Yorxqkz3Sh/vP4gQNgST8n+BEhXQfvY2aVSkE=; b=vSBykRiURyO8poBSnKdWIbrkrw
        uZ1m9IUYHtFz206Xak4wKe3LqRkRF+CPNHp2HCs2C75FblmjA7pVNh5rc+7jmYcFZ4ID1UNNoHf+F
        ENZoXIxO+zzPLTNW2Dknpyhv9g6mwmd8fujJR74txiS39VyCxn4iPSxuN9zdgbsg4i/FEeanFMjiR
        ONzJqSr9n1acG+is/hFft4R1XimQO7BkPO3mlwHkgTFE/4WbCNxGz3PF5IKYOGKoIvy2xSER5W4fU
        Cr2cWfJES1M5hol3sy65F8GvjaWXXfTM8QGT0er12Qhh8FhS6KfS6rf1g61kvesllmGJsnV2ebTNj
        9OvgniUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOr0X-00E4uh-EZ; Sat, 11 Sep 2021 00:36:37 +0000
Date:   Fri, 10 Sep 2021 17:36:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [mcgrof-next:20210908-firmware-builtin-v4 11/11]
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:
 Error: file not found:
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin
Message-ID: <YTv6Fc+dYkCCKrzD@bombadil.infradead.org>
References: <202109101753.3JVYU3r5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109101753.3JVYU3r5-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 05:17:02PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210908-firmware-builtin-v4
> head:   1c69d6a17750179d68bcaf6b16f9a08d2e475989
> commit: 1c69d6a17750179d68bcaf6b16f9a08d2e475989 [11/11] test_firmware: add support for testing built-in firmware
> config: riscv-allyesconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=1c69d6a17750179d68bcaf6b16f9a08d2e475989
>         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>         git fetch --no-tags mcgrof-next 20210908-firmware-builtin-v4
>         git checkout 1c69d6a17750179d68bcaf6b16f9a08d2e475989
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S: Assembler messages:
> >> drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5: Error: file not found: drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin

I cannot reproduce the build issue. In fact I had to disable
DRM_ROCKCHIP as it was failing to compile. After that all was good.

  Luis
