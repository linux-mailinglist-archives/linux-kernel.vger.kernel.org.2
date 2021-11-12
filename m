Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9B44EC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhKLRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhKLRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:44:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A860C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:42:05 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id o14so8994702plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5zpnUZR87InWsjVK87Ebfvs79sDxPj/XEBkb6Bvf2bw=;
        b=P+aw25rpbJvxIbeKltgszkAIjKBgGEene0chJtO7iz7mUKCwFQ9QRv6bil7KCZ2a9T
         XH2iSp92ZmjLV4CvlknKWkT+3ymp4C2pz4H9HF0EJfYvsqNOSmfyfGmIvSNwg8me2nG5
         dAu734huBp7OYFbQ0K+dzzSYrkGrjni6uolq7lpoKSkZE3RZl9vlOLNgoLNJBQV0J2TP
         NLR/sf2vC9cH7X6XtF8hS+SVSzLw5NRLzDcwABzpYq2PU5382UMnZYvIMSWlImmaTdjG
         a4slaQbzYyhsMY0ZGizIhfMAGA4tY3+3j/nv+JASm09IKh9v/1TGAQO0otZuif/GEzxs
         ZxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5zpnUZR87InWsjVK87Ebfvs79sDxPj/XEBkb6Bvf2bw=;
        b=QJN60LAVguSN3rtJ+P3PhO6r0/12WCCIF07LV6ipTBKZRO/7jdcN0yDQkRaKEzIyFi
         66TDIXBzod8TQQ/uQf/DJxXWmpMhoT12DwaOKXi+MEsgMlK7OPiKmR0R/dneE6cC6UbF
         kmAeR4Gkb2jRxoZ+BOKSj2OFKLrNWXYST7hHvwzocMElDTKnkOZ85w6xNxqh5mioG8Bi
         wUz1EaJ5ztBSG8mjHYkT0UkKjX7rrAvPCBe/gEYyUZ94zhJB58+jE6neG+2AY7XtLbDS
         uJaHcif/4a5R2Me2M2LqCMve9c3mYwPLW+xH0JEFFJsK9Wa1nWVwETxlaQnxFi3DsTGz
         hwCw==
X-Gm-Message-State: AOAM532LY1F8PYYczu3b0qhTWGkndLjDW3Rm1EyJJducOPbu3IhIgX6I
        p23ZT0x3jVboEmyuvoiV5DLIhcqqs2sqYA==
X-Google-Smtp-Source: ABdhPJxenXaWigePtVWDZEW8cgEyTL1slKGAUYg1vDts7g4InymcxQ87PqpbtmErNKJDYxOc2toEOQ==
X-Received: by 2002:a17:90a:db81:: with SMTP id h1mr39219875pjv.46.1636738924217;
        Fri, 12 Nov 2021 09:42:04 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i10sm7327858pfe.180.2021.11.12.09.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:42:03 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:42:03 -0800 (PST)
X-Google-Original-Date: Fri, 12 Nov 2021 09:42:02 PST (-0800)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.16 Merge Window, Part 1
In-Reply-To: <mhng-109b0503-bc7c-4da8-8621-28aec8d9df59@palmer-ri-x1c9>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-33397cc1-0e32-4947-983a-0cf6e63dcb94@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 09:32:15 PST (-0800), Palmer Dabbelt wrote:
> The following changes since commit 3f2401f47d29d669e2cb137709d10dd4c156a02f:
>
>   RISC-V: Add hypervisor extension related CSR defines (2021-10-04 04:54:55 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-mw1
>
> for you to fetch changes up to ffa7a9141bb70702744a312f904b190ca064bdd7:
>
>   riscv: defconfig: enable DRM_NOUVEAU (2021-10-27 14:36:09 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.16 Merge Window, Part 1
>
> * Support for time namespaces in the VDSO, along with some associated
>   cleanups.
> * Support for building rv32 randconfigs.
> * Improvements to the XIP port that allow larger kernels to function
> * Various device tree cleanups for both the SiFive and Microchip boards
> * A handful of defconfig updates, including enabling Nouveau.
>
> There are also various small cleanups.

I forgot to send along my conflict resolutions:

    diff --cc arch/riscv/Kconfig
    index dcd7afcd98ef,a34c531be4e7..821252b65f89
    --- a/arch/riscv/Kconfig
    +++ b/arch/riscv/Kconfig
    @@@ -62,8 -62,6 +62,7 @@@ config RISC
      	select GENERIC_SCHED_CLOCK
      	select GENERIC_SMP_IDLE_THREAD
      	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
     +	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
    - 	select HANDLE_DOMAIN_IRQ
      	select HAVE_ARCH_AUDITSYSCALL
      	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
      	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
    diff --cc arch/riscv/Makefile
    index 9247407b95d6,7f19b784e649..5927c94302b8
    --- a/arch/riscv/Makefile
    +++ b/arch/riscv/Makefile
    @@@ -137,16 -136,3 +136,13 @@@ zinstall: install-image = Image.g
      install zinstall:
      	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
      	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
     +
    - archclean:
    - 	$(Q)$(MAKE) $(clean)=$(boot)
    -
     +PHONY += rv32_randconfig
     +rv32_randconfig:
     +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/32-bit.config \
     +		-f $(srctree)/Makefile randconfig
     +
     +PHONY += rv64_randconfig
     +rv64_randconfig:
     +	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/riscv/configs/64-bit.config \
     +		-f $(srctree)/Makefile randconfig
    
Sorry if anything else went off the rails, being on the new computer has 
be a bit off kilter.  I think I got all my PGP stuff sorted out 
yesterday.

>
> ----------------------------------------------------------------
> Dimitri John Ledkov (1):
>       riscv: set default pm_power_off to NULL
>
> Heinrich Schuchardt (1):
>       riscv: defconfig: enable DRM_NOUVEAU
>
> Kefeng Wang (1):
>       riscv/vdso: Drop unneeded part due to merge issue
>
> Krzysztof Kozlowski (11):
>       dt-bindings: mmc: cdns: document Microchip MPFS MMC/SDHCI controller
>       riscv: dts: microchip: drop duplicated nodes
>       riscv: dts: microchip: fix board compatible
>       riscv: dts: microchip: drop duplicated MMC/SDHC node
>       riscv: dts: microchip: drop unused pinctrl-names
>       riscv: dts: microchip: use vendor compatible for Cadence SD4HC
>       riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
>       riscv: dts: sifive: fix Unleashed board compatible
>       riscv: dts: sifive: drop duplicated nodes and properties in sifive
>       riscv: dts: microchip: add missing compatibles for clint and plic
>       riscv: dts: sifive: add missing compatible for plic
>
> Palmer Dabbelt (3):
>       Merge remote-tracking branch 'palmer/riscv-vdso-cleanup' into for-next
>       Merge tag 'for-riscv' of https://git.kernel.org/pub/scm/virt/kvm/kvm.git into for-next
>       Merge tag 'riscv-sifive-dt-5.16' of git://gitolite.kernel.org/pub/scm/linux/kernel/git/krzk/linux into for-next
>
> Randy Dunlap (1):
>       riscv: add rv32 and rv64 randconfig build targets
>
> Tong Tiangen (1):
>       riscv/vdso: Add support for time namespaces
>
> Vineet Gupta (1):
>       riscv: mm: don't advertise 1 num_asid for 0 asid bits
>
> Vitaly Wool (1):
>       riscv: remove .text section size limitation for XIP
>
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml        |   1 +
>  arch/riscv/Kconfig                                 |   1 +
>  arch/riscv/Makefile                                |  10 +
>  .../dts/microchip/microchip-mpfs-icicle-kit.dts    |  18 +-
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  |  40 +---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |   2 +-
>  .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  10 +-
>  .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |   7 +-
>  arch/riscv/configs/32-bit.config                   |   2 +
>  arch/riscv/configs/64-bit.config                   |   2 +
>  arch/riscv/configs/defconfig                       |   7 +-
>  arch/riscv/include/asm/page.h                      |   2 +
>  arch/riscv/include/asm/pgtable.h                   |   6 +-
>  arch/riscv/include/asm/syscall.h                   |   1 +
>  arch/riscv/include/asm/vdso.h                      |  13 +-
>  arch/riscv/include/asm/vdso/gettimeofday.h         |   7 +
>  arch/riscv/kernel/head.S                           |  12 +
>  arch/riscv/kernel/reset.c                          |  12 +-
>  arch/riscv/kernel/syscall_table.c                  |   1 -
>  arch/riscv/kernel/vdso.c                           | 261 +++++++++++++++++----
>  arch/riscv/kernel/vdso/vdso.lds.S                  |   6 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S                |  10 +-
>  arch/riscv/mm/context.c                            |   8 +-
>  arch/riscv/mm/init.c                               |   7 +-
>  24 files changed, 311 insertions(+), 135 deletions(-)
>  create mode 100644 arch/riscv/configs/32-bit.config
>  create mode 100644 arch/riscv/configs/64-bit.config
