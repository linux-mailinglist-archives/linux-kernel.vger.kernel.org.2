Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E413C31B4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 06:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhBOFHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 00:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhBOFHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 00:07:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 21:06:22 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o63so3560067pgo.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 21:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0JNo8KDNRF3sOLFqLCUQYjhGDWGinpOOLzMT+a8/sRc=;
        b=u9xzY7L8xMCmn7nOByLdAykfogHAmHc+JuEOoHvfQX8Jn0AUR+6JdhI90rfnPUR71Z
         IV4xR4ChnX4iGQxq3l2EX9VZ3k+kqhihC4WyEopHbyZvF4sLSPxUieU4Ep5QTFCHUJnN
         xzTuGJca+GCV1oWi66L8e4BP8BaZa3u2AY68tQ13uAyQt5+kTUd3JW9E9PN/YPCAczeo
         g49IzZsa2wUNY0RrqH/WW9Fd1KKJj3endiTb4/94cDsc3VJuIKuJJvm4mC2HBfQDOdV1
         xMp55TQBkFFGscES2wSxzFDdcWNz2OTcLyq4MK2RkUxf1Edlv9fFgDSMSNpT2w7D9AUG
         q1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0JNo8KDNRF3sOLFqLCUQYjhGDWGinpOOLzMT+a8/sRc=;
        b=aRk8dm93QyPzSRiGuY5OlkSSxpn821bLQmFFjQ8Kpvh5G9y40KC8ITsi2SMz/NivKB
         /w4ysP27B911+UtWGXAKlunH4DyTtl6uIMjd9X/lLGq+ivvKaNSvdXbVrWPpe/OCgCMp
         z0KKUsJ/NN9f1s2zbVGjZQBaBkGsEKwceyg9Em2M/TPNGk7ujrh4w/FB6tWx+whHgpRT
         wpZd7cnMADaq/oI5qfs6tcJryFFDr8vrCUHCc+L6EKDoy5JQ8JB8i8ZjcL4fgIrqTF1j
         PTgxXTaW70bDYHdvWj88mBADebO8jAad+v7IgAMrP905R47jK8VToYZc1vBEQ3pntI2o
         8Zaw==
X-Gm-Message-State: AOAM533HQJZvJ7HuADCmYvnMvBTkVFZ89OIklPcjPnEm7lR2/VuKdZji
        1RPUVOhHubyA7HfDgyVA6z2h/Q==
X-Google-Smtp-Source: ABdhPJyfwCvN/Qq9Yz8JTBRq1DrnKQ85AJLBs7JLObWbnOqMq3C7+DDAjAiPntKO/ItmH41nM3jjXA==
X-Received: by 2002:aa7:9a46:0:b029:1db:57ba:5e2 with SMTP id x6-20020aa79a460000b02901db57ba05e2mr13723818pfj.5.1613365582085;
        Sun, 14 Feb 2021 21:06:22 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id o189sm16506384pfd.73.2021.02.14.21.06.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2021 21:06:20 -0800 (PST)
Date:   Mon, 15 Feb 2021 10:36:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: [GIT PULL] Remove oprofile and dcookies for v5.12
Message-ID: <20210215050618.hgftdmfmslbdrg3j@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iqkn3rhr2d3hqgpk"
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iqkn3rhr2d3hqgpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git tags/oprofile-removal-5.12

for you to fetch changes up to be65de6b03aa638c46ea51e9d11a92e4914d8103:

  fs: Remove dcookies support (2021-01-29 10:06:46 +0530)

----------------------------------------------------------------
Remove oprofile and dcookies support

The "oprofile" user-space tools don't use the kernel OPROFILE support any more,
and haven't in a long time. User-space has been converted to the perf
interfaces.

The dcookies stuff is only used by the oprofile code. Now that oprofile's
support is getting removed from the kernel, there is no need for dcookies as
well.

Remove kernel's old oprofile and dcookies support.

----------------------------------------------------------------
Viresh Kumar (18):
      arch: alpha: Remove CONFIG_OPROFILE support
      arch: arm: Remove CONFIG_OPROFILE support
      arch: arc: Remove CONFIG_OPROFILE support
      arch: hexagon: Don't select HAVE_OPROFILE
      arch: ia64: Remove CONFIG_OPROFILE support
      arch: ia64: Remove rest of perfmon support
      arch: microblaze: Remove CONFIG_OPROFILE support
      arch: mips: Remove CONFIG_OPROFILE support
      arch: parisc: Remove CONFIG_OPROFILE support
      arch: powerpc: Stop building and using oprofile
      arch: powerpc: Remove oprofile
      arch: s390: Remove CONFIG_OPROFILE support
      arch: sh: Remove CONFIG_OPROFILE support
      arch: sparc: Remove CONFIG_OPROFILE support
      arch: x86: Remove CONFIG_OPROFILE support
      arch: xtensa: Remove CONFIG_OPROFILE support
      drivers: Remove CONFIG_OPROFILE support
      fs: Remove dcookies support

 Documentation/RCU/NMI-RCU.rst                      |    3 +-
 Documentation/admin-guide/kernel-parameters.txt    |   14 -
 Documentation/kbuild/makefiles.rst                 |    1 -
 Documentation/process/magic-number.rst             |    1 -
 .../translations/it_IT/process/magic-number.rst    |    1 -
 .../translations/zh_CN/process/magic-number.rst    |    1 -
 MAINTAINERS                                        |   11 -
 arch/Kconfig                                       |   32 -
 arch/alpha/Kconfig                                 |    1 -
 arch/alpha/Makefile                                |    1 -
 arch/alpha/oprofile/Makefile                       |   20 -
 arch/alpha/oprofile/common.c                       |  189 ---
 arch/alpha/oprofile/op_impl.h                      |   55 -
 arch/alpha/oprofile/op_model_ev4.c                 |  114 --
 arch/alpha/oprofile/op_model_ev5.c                 |  209 ---
 arch/alpha/oprofile/op_model_ev6.c                 |  101 --
 arch/alpha/oprofile/op_model_ev67.c                |  261 ---
 arch/arc/Kconfig                                   |    1 -
 arch/arc/Makefile                                  |    2 -
 arch/arc/oprofile/Makefile                         |   10 -
 arch/arc/oprofile/common.c                         |   23 -
 arch/arm/Kconfig                                   |    1 -
 arch/arm/Makefile                                  |    2 -
 arch/arm/configs/bcm2835_defconfig                 |    1 -
 arch/arm/configs/cns3420vb_defconfig               |    1 -
 arch/arm/configs/corgi_defconfig                   |    1 -
 arch/arm/configs/imx_v4_v5_defconfig               |    1 -
 arch/arm/configs/keystone_defconfig                |    1 -
 arch/arm/configs/multi_v5_defconfig                |    1 -
 arch/arm/configs/mv78xx0_defconfig                 |    1 -
 arch/arm/configs/mvebu_v5_defconfig                |    1 -
 arch/arm/configs/omap1_defconfig                   |    1 -
 arch/arm/configs/omap2plus_defconfig               |    1 -
 arch/arm/configs/orion5x_defconfig                 |    1 -
 arch/arm/configs/pxa_defconfig                     |    1 -
 arch/arm/configs/qcom_defconfig                    |    1 -
 arch/arm/configs/socfpga_defconfig                 |    1 -
 arch/arm/configs/spitz_defconfig                   |    1 -
 arch/arm/configs/vexpress_defconfig                |    1 -
 arch/arm/oprofile/Makefile                         |   14 -
 arch/arm/oprofile/common.c                         |  132 --
 arch/hexagon/Kconfig                               |    1 -
 arch/ia64/Kconfig                                  |    1 -
 arch/ia64/Makefile                                 |    1 -
 arch/ia64/configs/bigsur_defconfig                 |    1 -
 arch/ia64/include/asm/hw_irq.h                     |    1 -
 arch/ia64/include/asm/perfmon.h                    |  111 --
 arch/ia64/include/uapi/asm/perfmon.h               |  178 --
 arch/ia64/include/uapi/asm/perfmon_default_smpl.h  |   84 -
 arch/ia64/kernel/palinfo.c                         |   41 -
 arch/ia64/kernel/perfmon_default_smpl.c            |  297 ----
 arch/ia64/kernel/perfmon_generic.h                 |   46 -
 arch/ia64/kernel/perfmon_itanium.h                 |    2 +-
 arch/ia64/kernel/perfmon_mckinley.h                |  188 ---
 arch/ia64/kernel/perfmon_montecito.h               |  270 ----
 arch/ia64/oprofile/Makefile                        |   10 -
 arch/ia64/oprofile/backtrace.c                     |  131 --
 arch/ia64/oprofile/init.c                          |   28 -
 arch/microblaze/Kconfig                            |    1 -
 arch/microblaze/Makefile                           |    2 -
 arch/microblaze/oprofile/Makefile                  |   14 -
 arch/microblaze/oprofile/microblaze_oprofile.c     |   22 -
 arch/mips/Kconfig                                  |    3 +-
 arch/mips/Makefile                                 |    1 -
 arch/mips/configs/fuloong2e_defconfig              |    1 -
 arch/mips/configs/ip32_defconfig                   |    1 -
 arch/mips/configs/lemote2f_defconfig               |    1 -
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/configs/rs90_defconfig                   |    1 -
 arch/mips/include/asm/mach-loongson2ef/loongson.h  |    9 -
 arch/mips/loongson2ef/fuloong-2e/irq.c             |    2 +-
 arch/mips/loongson2ef/lemote-2f/irq.c              |    1 -
 arch/mips/oprofile/Makefile                        |   18 -
 arch/mips/oprofile/backtrace.c                     |  177 --
 arch/mips/oprofile/common.c                        |  147 --
 arch/mips/oprofile/op_impl.h                       |   41 -
 arch/mips/oprofile/op_model_loongson2.c            |  161 --
 arch/mips/oprofile/op_model_loongson3.c            |  213 ---
 arch/mips/oprofile/op_model_mipsxx.c               |  479 ------
 arch/parisc/Kconfig                                |    1 -
 arch/parisc/Makefile                               |    2 -
 arch/parisc/oprofile/Makefile                      |   10 -
 arch/parisc/oprofile/init.c                        |   23 -
 arch/powerpc/Kconfig                               |    1 -
 arch/powerpc/Makefile                              |    2 -
 arch/powerpc/configs/44x/akebono_defconfig         |    1 -
 arch/powerpc/configs/44x/currituck_defconfig       |    1 -
 arch/powerpc/configs/44x/fsp2_defconfig            |    1 -
 arch/powerpc/configs/44x/iss476-smp_defconfig      |    1 -
 arch/powerpc/configs/cell_defconfig                |    1 -
 arch/powerpc/configs/g5_defconfig                  |    1 -
 arch/powerpc/configs/maple_defconfig               |    1 -
 arch/powerpc/configs/pasemi_defconfig              |    1 -
 arch/powerpc/configs/pmac32_defconfig              |    1 -
 arch/powerpc/configs/powernv_defconfig             |    1 -
 arch/powerpc/configs/ppc64_defconfig               |    1 -
 arch/powerpc/configs/ppc64e_defconfig              |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/powerpc/configs/ps3_defconfig                 |    1 -
 arch/powerpc/configs/pseries_defconfig             |    1 -
 arch/powerpc/include/asm/cputable.h                |   20 -
 arch/powerpc/include/asm/oprofile_impl.h           |  135 --
 arch/powerpc/include/asm/spu.h                     |   33 -
 arch/powerpc/kernel/cputable.c                     |   67 -
 arch/powerpc/kernel/dt_cpu_ftrs.c                  |    2 -
 arch/powerpc/oprofile/Makefile                     |   19 -
 arch/powerpc/oprofile/backtrace.c                  |  120 --
 arch/powerpc/oprofile/cell/pr_util.h               |  110 --
 arch/powerpc/oprofile/cell/spu_profiler.c          |  248 ---
 arch/powerpc/oprofile/cell/spu_task_sync.c         |  657 --------
 arch/powerpc/oprofile/cell/vma_map.c               |  279 ----
 arch/powerpc/oprofile/common.c                     |  243 ---
 arch/powerpc/oprofile/op_model_7450.c              |  207 ---
 arch/powerpc/oprofile/op_model_cell.c              | 1709 --------------------
 arch/powerpc/oprofile/op_model_fsl_emb.c           |  380 -----
 arch/powerpc/oprofile/op_model_pa6t.c              |  227 ---
 arch/powerpc/oprofile/op_model_power4.c            |  438 -----
 arch/powerpc/platforms/cell/Kconfig                |    5 -
 arch/powerpc/platforms/cell/Makefile               |    1 -
 arch/powerpc/platforms/cell/spu_notify.c           |   55 -
 arch/powerpc/platforms/cell/spufs/run.c            |    6 +-
 arch/powerpc/platforms/cell/spufs/sched.c          |    5 -
 arch/powerpc/platforms/cell/spufs/spufs.h          |    1 -
 arch/s390/Kconfig                                  |    1 -
 arch/s390/Makefile                                 |    3 -
 arch/s390/configs/debug_defconfig                  |    1 -
 arch/s390/configs/defconfig                        |    1 -
 arch/s390/oprofile/Makefile                        |   10 -
 arch/s390/oprofile/init.c                          |   37 -
 arch/sh/Kconfig                                    |    1 -
 arch/sh/Makefile                                   |    1 -
 arch/sh/configs/espt_defconfig                     |    1 -
 arch/sh/configs/migor_defconfig                    |    1 -
 arch/sh/configs/r7780mp_defconfig                  |    1 -
 arch/sh/configs/r7785rp_defconfig                  |    1 -
 arch/sh/configs/rsk7201_defconfig                  |    1 -
 arch/sh/configs/rsk7203_defconfig                  |    1 -
 arch/sh/configs/rts7751r2d1_defconfig              |    1 -
 arch/sh/configs/rts7751r2dplus_defconfig           |    1 -
 arch/sh/configs/sdk7786_defconfig                  |    1 -
 arch/sh/configs/se7206_defconfig                   |    1 -
 arch/sh/configs/sh03_defconfig                     |    1 -
 arch/sh/configs/sh7724_generic_defconfig           |    1 -
 arch/sh/configs/sh7763rdp_defconfig                |    1 -
 arch/sh/configs/sh7770_generic_defconfig           |    1 -
 arch/sh/configs/shx3_defconfig                     |    1 -
 arch/sh/oprofile/Makefile                          |   16 -
 arch/sh/oprofile/backtrace.c                       |   80 -
 arch/sh/oprofile/common.c                          |   64 -
 arch/sparc/Kconfig                                 |    1 -
 arch/sparc/Makefile                                |    1 -
 arch/sparc/configs/sparc64_defconfig               |    1 -
 arch/sparc/oprofile/Makefile                       |   10 -
 arch/sparc/oprofile/init.c                         |   87 -
 arch/x86/Kconfig                                   |    1 -
 arch/x86/Makefile                                  |    3 -
 arch/x86/include/asm/nmi.h                         |    1 -
 arch/x86/kernel/cpu/perfctr-watchdog.c             |   11 +-
 arch/x86/oprofile/Makefile                         |   12 -
 arch/x86/oprofile/backtrace.c                      |  127 --
 arch/x86/oprofile/init.c                           |   38 -
 arch/x86/oprofile/nmi_int.c                        |  780 ---------
 arch/x86/oprofile/op_counter.h                     |   30 -
 arch/x86/oprofile/op_model_amd.c                   |  542 -------
 arch/x86/oprofile/op_model_p4.c                    |  723 ---------
 arch/x86/oprofile/op_model_ppro.c                  |  245 ---
 arch/x86/oprofile/op_x86_model.h                   |   90 --
 arch/xtensa/Kconfig                                |    1 -
 arch/xtensa/Makefile                               |    1 -
 arch/xtensa/configs/audio_kc705_defconfig          |    1 -
 arch/xtensa/configs/generic_kc705_defconfig        |    1 -
 arch/xtensa/configs/smp_lx200_defconfig            |    1 -
 arch/xtensa/configs/xip_kc705_defconfig            |    1 -
 arch/xtensa/kernel/stacktrace.c                    |    2 +-
 arch/xtensa/oprofile/Makefile                      |   10 -
 arch/xtensa/oprofile/backtrace.c                   |   27 -
 arch/xtensa/oprofile/init.c                        |   26 -
 drivers/oprofile/buffer_sync.c                     |  591 -------
 drivers/oprofile/buffer_sync.h                     |   22 -
 drivers/oprofile/cpu_buffer.c                      |  465 ------
 drivers/oprofile/cpu_buffer.h                      |  121 --
 drivers/oprofile/event_buffer.c                    |  209 ---
 drivers/oprofile/event_buffer.h                    |   40 -
 drivers/oprofile/nmi_timer_int.c                   |  157 --
 drivers/oprofile/oprof.c                           |  286 ----
 drivers/oprofile/oprof.h                           |   50 -
 drivers/oprofile/oprofile_files.c                  |  201 ---
 drivers/oprofile/oprofile_perf.c                   |  328 ----
 drivers/oprofile/oprofile_stats.c                  |   84 -
 drivers/oprofile/oprofile_stats.h                  |   33 -
 drivers/oprofile/oprofilefs.c                      |  300 ----
 drivers/oprofile/timer_int.c                       |  122 --
 fs/Makefile                                        |    1 -
 fs/dcookies.c                                      |  356 ----
 include/linux/dcookies.h                           |   69 -
 include/linux/oprofile.h                           |  209 ---
 init/Kconfig                                       |    2 +-
 kernel/sys.c                                       |    1 -
 usr/include/Makefile                               |    2 -
 199 files changed, 8 insertions(+), 15569 deletions(-)
 delete mode 100644 arch/alpha/oprofile/Makefile
 delete mode 100644 arch/alpha/oprofile/common.c
 delete mode 100644 arch/alpha/oprofile/op_impl.h
 delete mode 100644 arch/alpha/oprofile/op_model_ev4.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev5.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev6.c
 delete mode 100644 arch/alpha/oprofile/op_model_ev67.c
 delete mode 100644 arch/arc/oprofile/Makefile
 delete mode 100644 arch/arc/oprofile/common.c
 delete mode 100644 arch/arm/oprofile/Makefile
 delete mode 100644 arch/arm/oprofile/common.c
 delete mode 100644 arch/ia64/include/asm/perfmon.h
 delete mode 100644 arch/ia64/include/uapi/asm/perfmon.h
 delete mode 100644 arch/ia64/include/uapi/asm/perfmon_default_smpl.h
 delete mode 100644 arch/ia64/kernel/perfmon_default_smpl.c
 delete mode 100644 arch/ia64/kernel/perfmon_generic.h
 delete mode 100644 arch/ia64/kernel/perfmon_mckinley.h
 delete mode 100644 arch/ia64/kernel/perfmon_montecito.h
 delete mode 100644 arch/ia64/oprofile/Makefile
 delete mode 100644 arch/ia64/oprofile/backtrace.c
 delete mode 100644 arch/ia64/oprofile/init.c
 delete mode 100644 arch/microblaze/oprofile/Makefile
 delete mode 100644 arch/microblaze/oprofile/microblaze_oprofile.c
 delete mode 100644 arch/mips/oprofile/Makefile
 delete mode 100644 arch/mips/oprofile/backtrace.c
 delete mode 100644 arch/mips/oprofile/common.c
 delete mode 100644 arch/mips/oprofile/op_impl.h
 delete mode 100644 arch/mips/oprofile/op_model_loongson2.c
 delete mode 100644 arch/mips/oprofile/op_model_loongson3.c
 delete mode 100644 arch/mips/oprofile/op_model_mipsxx.c
 delete mode 100644 arch/parisc/oprofile/Makefile
 delete mode 100644 arch/parisc/oprofile/init.c
 delete mode 100644 arch/powerpc/include/asm/oprofile_impl.h
 delete mode 100644 arch/powerpc/oprofile/Makefile
 delete mode 100644 arch/powerpc/oprofile/backtrace.c
 delete mode 100644 arch/powerpc/oprofile/cell/pr_util.h
 delete mode 100644 arch/powerpc/oprofile/cell/spu_profiler.c
 delete mode 100644 arch/powerpc/oprofile/cell/spu_task_sync.c
 delete mode 100644 arch/powerpc/oprofile/cell/vma_map.c
 delete mode 100644 arch/powerpc/oprofile/common.c
 delete mode 100644 arch/powerpc/oprofile/op_model_7450.c
 delete mode 100644 arch/powerpc/oprofile/op_model_cell.c
 delete mode 100644 arch/powerpc/oprofile/op_model_fsl_emb.c
 delete mode 100644 arch/powerpc/oprofile/op_model_pa6t.c
 delete mode 100644 arch/powerpc/oprofile/op_model_power4.c
 delete mode 100644 arch/powerpc/platforms/cell/spu_notify.c
 delete mode 100644 arch/s390/oprofile/Makefile
 delete mode 100644 arch/s390/oprofile/init.c
 delete mode 100644 arch/sh/oprofile/Makefile
 delete mode 100644 arch/sh/oprofile/backtrace.c
 delete mode 100644 arch/sh/oprofile/common.c
 delete mode 100644 arch/sparc/oprofile/Makefile
 delete mode 100644 arch/sparc/oprofile/init.c
 delete mode 100644 arch/x86/oprofile/Makefile
 delete mode 100644 arch/x86/oprofile/backtrace.c
 delete mode 100644 arch/x86/oprofile/init.c
 delete mode 100644 arch/x86/oprofile/nmi_int.c
 delete mode 100644 arch/x86/oprofile/op_counter.h
 delete mode 100644 arch/x86/oprofile/op_model_amd.c
 delete mode 100644 arch/x86/oprofile/op_model_p4.c
 delete mode 100644 arch/x86/oprofile/op_model_ppro.c
 delete mode 100644 arch/x86/oprofile/op_x86_model.h
 delete mode 100644 arch/xtensa/oprofile/Makefile
 delete mode 100644 arch/xtensa/oprofile/backtrace.c
 delete mode 100644 arch/xtensa/oprofile/init.c
 delete mode 100644 drivers/oprofile/buffer_sync.c
 delete mode 100644 drivers/oprofile/buffer_sync.h
 delete mode 100644 drivers/oprofile/cpu_buffer.c
 delete mode 100644 drivers/oprofile/cpu_buffer.h
 delete mode 100644 drivers/oprofile/event_buffer.c
 delete mode 100644 drivers/oprofile/event_buffer.h
 delete mode 100644 drivers/oprofile/nmi_timer_int.c
 delete mode 100644 drivers/oprofile/oprof.c
 delete mode 100644 drivers/oprofile/oprof.h
 delete mode 100644 drivers/oprofile/oprofile_files.c
 delete mode 100644 drivers/oprofile/oprofile_perf.c
 delete mode 100644 drivers/oprofile/oprofile_stats.c
 delete mode 100644 drivers/oprofile/oprofile_stats.h
 delete mode 100644 drivers/oprofile/oprofilefs.c
 delete mode 100644 drivers/oprofile/timer_int.c
 delete mode 100644 fs/dcookies.c
 delete mode 100644 include/linux/dcookies.h
 delete mode 100644 include/linux/oprofile.h

--iqkn3rhr2d3hqgpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJgKgFKAAoJENK5HDyugRIc1gYP/ROYSSb+uowCh2by2B946w0o
hYYpdAPN67QzvMwSSW7P7KyIJ66knZ+3vy/0Qn/+FIxW/8wJdZRh6x2siiVyqF65
Ol+BVWUtM0d3gRiDs6fRRlrGOkgHCLfIftVJFUfnY++S2LLjgTMZ1jMEKjw/U91v
MOZ0+J9iQTrfMhuNYptmT8wh7gWv2yFKM1JRF6FcMINtyK7ZG6nrxLUbF4LWE6QV
U9uyKkdO0UBFX/Cuz0e61Z/fm4BN+3Yv9KEriAyu9l81k3DxB8Ajs15wfK5+3juF
MGJGi/qPL0f/bf3Anp3RC1pkaMNet+esoSqm4LNuskwZmP52aXx4OPvbt2Wh8+30
vofkrNPxO1mzZi1y2Q/Y1w5Fcu6iNQr31zjbO1DOXs2Uhs0zObqJY8ikF8nIm875
QJ9E/dObMwmWAwv1ntAJRgCOm+qjEGgcZF2KMDXY9kWyGNl2gjmqxxcBKhKTAXBf
8Z15Gxk3KcpRxJkLrA21bt6unI4O25KdzwkhjMkQy5yNdmk7+RoBNAIaw01Xs8Me
m2yrUrGXxCuOR0C2oWvNHKdvG78krQgjpa27ditbZNrkX5kQuraUEjkqw0BizypH
3n+mqOzFwhTxb8hbNI+lWScc2Lx+WhO7LLW9GSkOhKPyxPY8kxEqwn97UxyhJZ0n
FDAa/L6F6az13Tb098wP
=OWG+
-----END PGP SIGNATURE-----

--iqkn3rhr2d3hqgpk--
