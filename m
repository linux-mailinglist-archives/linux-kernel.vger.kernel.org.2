Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B27319960
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBLE63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBLE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:58:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48370C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=EHdx8vpL8lPg+Q3lHAssGQvxLalw1uiETsQ2PjnsMqg=; b=NrHYpohTkPNAvhA0t1rCGBsNSI
        sqru8pkcgeMz3e1pxhNHXOOJ0k11uQRHa0Uw5+oWBQhPwlPMD15CXMHk2z686VGz3JU8g0Kwr+UnO
        z8f3i8pBblHpgS5BfWW+IWOCJyd3y97KiIC/qYnMjxz0XDkMNZITOoYbCsNyEnvdUYoebQQzqFOUm
        FRWBzwNYe8aX53z8Qs+uDGZ6Pr+23qx4070akAZCTXPyn39F5kPjh2wuR6NTbLFQRyFmN9Jzy+QlM
        h2Ixu3P0LvfR5TlAKkQvRScau08v8f6ui7sAfXd/N/94eM8TfaMCd2D1M/1TZm4hkfpf7zV4oSy0Q
        dzJkpPWg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAQWO-0003WU-AF; Fri, 12 Feb 2021 04:57:36 +0000
Subject: Re: sdhci.c:undefined reference to `mmc_can_gpio_cd'
To:     kernel test robot <lkp@intel.com>, Haibo Chen <haibo.chen@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202102111735.d8yOO8H8-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e11b661-5a11-0c04-b070-2b47a99f0539@infradead.org>
Date:   Thu, 11 Feb 2021 20:57:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <202102111735.d8yOO8H8-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 1:44 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
> commit: e65bb38824711559844ba932132f417bc5a355e2 mmc: sdhci: do not enable card detect interrupt for gpio cd type
> date:   11 months ago
> config: powerpc-randconfig-r032-20210210 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e65bb38824711559844ba932132f417bc5a355e2
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e65bb38824711559844ba932132f417bc5a355e2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/op-msg.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/op-reset.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/op-rfkill.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/op-state-get.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/stack.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/wimax/debugfs.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/bat_algo.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/bat_iv_ogm.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/bitarray.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/fragmentation.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/gateway_client.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/gateway_common.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/hard-interface.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/hash.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/log.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/main.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/netlink.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/originator.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/routing.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/send.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/soft-interface.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/tp_meter.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/translation-table.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/batman-adv/tvlv.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/core.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/netlink.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/af_nfc.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/rawsock.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/llcp_core.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/llcp_commands.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/llcp_sock.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/core.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/data.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/lib.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/ntf.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/rsp.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/hci.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/nci/spi.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/core.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/hcp.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/command.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/llc.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/llc_nop.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/nfc/hci/llc_shdlc.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/vmw_vsock/af_vsock.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/vmw_vsock/af_vsock_tap.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/vmw_vsock/vsock_addr.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/mpls/mpls_gso.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_main.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_framereg.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_device.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_netlink.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_slave.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_forward.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `net/hsr/hsr_debugfs.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/argv_split.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/bootconfig.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/bug.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/cmdline.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/cpumask.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/dec_and_lock.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/decompress.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/decompress_unlzma.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/dump_stack.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/extable.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/fdt.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/fdt_ro.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/fdt_rw.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/fdt_wip.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/flex_proportions.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/idr.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/ioremap.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/is_single_threaded.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/klist.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/kobject.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/kobject_uevent.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/logic_pio.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/memcat_p.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/plist.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/radix-tree.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/ratelimit.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/rbtree.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/seq_buf.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/sha1.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/show_mem.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/siphash.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/string.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/timerqueue.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/vsprintf.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: warning: orphan section `.ctors.65435' from `lib/xarray.o' being placed in section `.ctors.65435'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_alloc_host':
>    (.text+0x25d0): undefined reference to `mmc_alloc_host'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_free_host':
>    (.text+0x2ce4): undefined reference to `mmc_free_host'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_get_cd':
>    sdhci.c:(.text+0x10894): undefined reference to `mmc_gpio_get_cd'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_check_ro':
>    sdhci.c:(.text+0x119a8): undefined reference to `mmc_can_gpio_ro'
>    powerpc-linux-ld: sdhci.c:(.text+0x119f0): undefined reference to `mmc_gpio_get_ro'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_set_card_detection':
>>> sdhci.c:(.text+0x11f50): undefined reference to `mmc_can_gpio_cd'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_remove_host':
>    (.text+0x1271c): undefined reference to `mmc_remove_host'
>    powerpc-linux-ld: (.text+0x12c9c): undefined reference to `mmc_remove_host'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `__sdhci_add_host':
>    (.text+0x13564): undefined reference to `mmc_add_host'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_request_done':
>    sdhci.c:(.text+0x17540): undefined reference to `mmc_request_done'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_thread_irq':
>    sdhci.c:(.text+0x187d4): undefined reference to `mmc_detect_change'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_start_signal_voltage_switch':
>    (.text+0x1a608): undefined reference to `mmc_regulator_set_vqmmc'
>    powerpc-linux-ld: (.text+0x1a7e8): undefined reference to `mmc_regulator_set_vqmmc'
>    powerpc-linux-ld: (.text+0x1a9c8): undefined reference to `mmc_regulator_set_vqmmc'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_setup_host':
>    (.text+0x1c3d8): undefined reference to `mmc_regulator_get_supply'
>    powerpc-linux-ld: (.text+0x20fe0): undefined reference to `mmc_gpio_get_cd'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_finish_command':
>    sdhci.c:(.text+0x273f4): undefined reference to `mmc_command_done'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_irq':
>    sdhci.c:(.text+0x28e4c): undefined reference to `sdio_signal_irq'
>    powerpc-linux-ld: sdhci.c:(.text+0x29d4c): undefined reference to `mmc_request_done'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_set_power':
>    (.text+0x2b560): undefined reference to `mmc_regulator_set_ocr'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_set_ios':
>    (.text+0x2bd04): undefined reference to `mmc_detect_change'
>    powerpc-linux-ld: (.text+0x2d884): undefined reference to `mmc_regulator_set_ocr'
>    powerpc-linux-ld: drivers/mmc/host/sdhci.o: in function `sdhci_abort_tuning':
>    (.text+0x2ec4c): undefined reference to `mmc_abort_tuning'
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for MMC_SDHCI
>    Depends on MMC && HAS_DMA
>    Selected by
>    - AKEBONO && PPC_47x
>    WARNING: unmet direct dependencies detected for MMC_SDHCI_PLTFM
>    Depends on MMC && MMC_SDHCI
>    Selected by
>    - AKEBONO && PPC_47x
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Fixed in powerpc (some future/next branch) by:

commit 665d8d58761cba41147fe7e98e2ceed1cbf603a2
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Mon Feb 1 12:25:03 2021 +1100

    powerpc/akebono: Fix unmet dependency errors
    
    The AKEBONO config has various selects under it, including some with
    user-selectable dependencies, which means those dependencies can be
    disabled. This leads to warnings from Kconfig.


-- 
~Randy

