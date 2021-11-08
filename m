Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E83449A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhKHQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhKHQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:54:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BCBC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JjeVTK+2GkBI0UCReLB90PqNbIgTpIsOIfrOXgVKgGU=; b=h9v8qKQFNF8m1EhXvqMzlq6S/w
        QHtY/1ENrdUYR4A1lRNOqEws+yi5Z+Dr54+v0DayEcV5+tsVIesVcI/RCsIC4IXb6udWc80H92kYe
        JUXK0AD7pu12MmcaPxVETsiBkSONm8bv+5BLHGFHQK7r+zSpbxKAnqczIyC/hAxvtTdFobXKc87KN
        yUwly/oZ2ph3RmUKEoPnilgkPnxR3BvHKrl7eA1F3YQlGjdiXEYpsWuS41TudCbKDHMEsPxXd+RL8
        UtFHpk+g5TYoyU+97K3s2EomVjYXZQnJE6wx9ZrCcq5Mc42zRqui1EGWb+dL664OUOalwwF1DY2WS
        jb5RiAWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk7ra-00H0nj-1E; Mon, 08 Nov 2021 16:51:18 +0000
Date:   Mon, 8 Nov 2021 08:51:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [mcgrof-next:20210916-firmware-builtin-v2 14/14]
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:13:
 error: Could not find incbin file
 'drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin'
Message-ID: <YYlVhm0ybuirMI//@bombadil.infradead.org>
References: <202111080124.Dyl8aeOd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111080124.Dyl8aeOd-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:37:31AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20210916-firmware-builtin-v2
> head:   f69194f4bcf5b301f2d169b2f036c0da4b642e53
> commit: f69194f4bcf5b301f2d169b2f036c0da4b642e53 [14/14] test_firmware: add support for testing built-in firmware
> config: arm-randconfig-r004-20210929 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=f69194f4bcf5b301f2d169b2f036c0da4b642e53
>         git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
>         git fetch --no-tags mcgrof-next 20210916-firmware-builtin-v2
>         git checkout f69194f4bcf5b301f2d169b2f036c0da4b642e53
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:13: error: Could not find incbin file 'drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin'
>        .incbin "drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin"
>                ^

I used the latest test branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211020-firmware-builtin

And I can't reproduce there, that build fails for another reason though:

ld.lld: error: undefined symbol: _printk
>>> referenced by io-acorn.o:(.text+0x38) in archive
>>> arch/arm/mach-rpc/built-in.a
make: *** [Makefile:1183: vmlinux] Error 1
make: Target '__all' not remade because of errors.

  Luis
