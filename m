Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02D3112FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBETTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 14:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhBETR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:17:28 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A807C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:58:47 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id l14so4160168qvp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37a+50jHTum46YhneroEs89QRdYxVAM04dENJyujd8g=;
        b=lq+TxZTQanVL/my5p/nG0eiT/zkux+zqpiIfpfq1XfY3Egtqk1E/JOrRHC95W1rngi
         e+qI3H2FlinWC9ZB5nUwZkWEfvuSHWIsXv7vfQvVDfnr0DMqOeJd2Dkn/aXUe+actqUU
         NKjhUIliuRJQJIf/wcJSUugGyZvK3El+dGXzxhXMBegJYH8sm42i+2TV3ZEywr3oEU7K
         nBlzKGRNqmtEy5wvjmmZyofucVXvILOyplSf4Y8XU4/iUeoKVC33ampLkjHE1Tm5H4j4
         vCHNRxhYXxBGLd3He1pQ4WZUhtfIA7o4VxifHYllM6zAVC2P2eYf77ubUSFjMDS82Enw
         h0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37a+50jHTum46YhneroEs89QRdYxVAM04dENJyujd8g=;
        b=EOJFETioNGFPUiPbEO2Fa4+jXEh8XSGdMwSS/t7+/SyNDuR0mloApPz5+vSbQrpWse
         FxwGU+XXjNPQSyuqNiMyuEXG5iXQi25Q8ljPS214d9Hoze6IdAqi0LAKJfV+GsIHRFf6
         Rone+kbPmYeNI6cKwTjfqjfrEUecnBN2Yw1cKk+zYt5ARQKefTbVCO56iveuAPNzzsiT
         hZ89erd4dKQtJ5WwsQziqv1aGaYk+tgvri7e+ShHk1g2P3Be7cvcWoNvRuqiOO70pdJm
         8QhGUQEaUGXTT9fa8yoExj2MFOnHQQIpC0uJgoSR54qbgIAYGBqH2F1wILDSO7J3rNAo
         936Q==
X-Gm-Message-State: AOAM530ciD1kJZOVIV1bEOVT04lXaWbm1EgonXwlbZBVPl/R5cizZFgV
        twteg2/K05X7rjyOyt5bAR478EtfFOmG5g==
X-Google-Smtp-Source: ABdhPJzUqZra72aGceaJHGo0cMOCk5FIfWt5qki18puWwYygJ7OoHev2lwgrzM/tECkIP6BJbqPWsg==
X-Received: by 2002:ad4:5606:: with SMTP id ca6mr6363094qvb.1.1612558726272;
        Fri, 05 Feb 2021 12:58:46 -0800 (PST)
Received: from debian-vm ([189.120.76.30])
        by smtp.gmail.com with ESMTPSA id p12sm9381823qtw.27.2021.02.05.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:58:45 -0800 (PST)
From:   Igor <igormtorrente@gmail.com>
X-Google-Original-From: Igor <igor>
Date:   Fri, 5 Feb 2021 17:58:42 -0300
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org
Subject: Re: [PATCH 5.4 00/32] 5.4.96-rc1 review
Message-ID: <YB2xguYy7Xuf6F6j@debian-vm>
References: <20210205140652.348864025@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205140652.348864025@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 03:07:15PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.96 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 07 Feb 2021 14:06:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Compiled and booted on my system(x86_64).
No dmesg regressions so far.

Tested-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>

Best regards
---
Igor Matheus Andrade Torrente

> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.4.96-rc1
> 
> Peter Zijlstra <peterz@infradead.org>
>     workqueue: Restrict affinity change to rescuer
> 
> Peter Zijlstra <peterz@infradead.org>
>     kthread: Extract KTHREAD_IS_PER_CPU
> 
> Josh Poimboeuf <jpoimboe@redhat.com>
>     objtool: Don't fail on missing symbol table
> 
> Bing Guo <bing.guo@amd.com>
>     drm/amd/display: Change function decide_dp_link_settings to avoid infinite looping
> 
> Jake Wang <haonan.wang2@amd.com>
>     drm/amd/display: Update dram_clock_change_latency for DCN2.1
> 
> Michael Ellerman <mpe@ellerman.id.au>
>     selftests/powerpc: Only test lwm/stmw on big endian
> 
> Revanth Rajashekar <revanth.rajashekar@intel.com>
>     nvme: check the PRINFO bit before deciding the host buffer length
> 
> lianzhi chang <changlianzhi@uniontech.com>
>     udf: fix the problem that the disc content is not displayed
> 
> Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
>     ALSA: hda: Add Cometlake-R PCI ID
> 
> Brian King <brking@linux.vnet.ibm.com>
>     scsi: ibmvfc: Set default timeout to avoid crash during migration
> 
> Felix Fietkau <nbd@nbd.name>
>     mac80211: fix fast-rx encryption check
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com>
>     ASoC: SOF: Intel: hda: Resume codec to do jack detection
> 
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>     scsi: fnic: Fix memleak in vnic_dev_init_devcmd2
> 
> Javed Hasan <jhasan@marvell.com>
>     scsi: libfc: Avoid invoking response handler twice if ep is already completed
> 
> Martin Wilck <mwilck@suse.com>
>     scsi: scsi_transport_srp: Don't block target in failfast state
> 
> Peter Zijlstra <peterz@infradead.org>
>     x86: __always_inline __{rd,wr}msr()
> 
> Arnold Gozum <arngozum@gmail.com>
>     platform/x86: intel-vbtn: Support for tablet mode on Dell Inspiron 7352
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: touchscreen_dmi: Add swap-x-y quirk for Goodix touchscreen on Estar Beauty HD tablet
> 
> Tony Lindgren <tony@atomide.com>
>     phy: cpcap-usb: Fix warning for missing regulator_disable
> 
> Eric Dumazet <edumazet@google.com>
>     net_sched: gen_estimator: support large ewma log
> 
> ethanwu <ethanwu@synology.com>
>     btrfs: backref, use correct count to resolve normal data refs
> 
> ethanwu <ethanwu@synology.com>
>     btrfs: backref, only search backref entries from leaves of the same root
> 
> ethanwu <ethanwu@synology.com>
>     btrfs: backref, don't add refs from shared block when resolving normal backref
> 
> ethanwu <ethanwu@synology.com>
>     btrfs: backref, only collect file extent items matching backref offset
> 
> Enke Chen <enchen@paloaltonetworks.com>
>     tcp: make TCP_USER_TIMEOUT accurate for zero window probes
> 
> Catalin Marinas <catalin.marinas@arm.com>
>     arm64: Do not pass tagged addresses to __is_lm_address()
> 
> Vincenzo Frascino <vincenzo.frascino@arm.com>
>     arm64: Fix kernel address detection of __is_lm_address()
> 
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     ACPI: thermal: Do not call acpi_thermal_check() directly
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "Revert "block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT""
> 
> Lijun Pan <ljp@linux.ibm.com>
>     ibmvnic: Ensure that CRQ entry read are correctly ordered
> 
> Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>     net: switchdev: don't set port_obj_info->handled true when -EOPNOTSUPP
> 
> Pan Bian <bianpan2016@163.com>
>     net: dsa: bcm_sf2: put device node before return
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/arm64/include/asm/memory.h                    |  10 +-
>  arch/arm64/mm/physaddr.c                           |   2 +-
>  arch/x86/include/asm/msr.h                         |   4 +-
>  block/blk-core.c                                   |  11 +-
>  drivers/acpi/thermal.c                             |  55 +++++---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   3 +
>  .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   2 +-
>  drivers/net/dsa/bcm_sf2.c                          |   8 +-
>  drivers/net/ethernet/ibm/ibmvnic.c                 |   6 +
>  drivers/nvme/host/core.c                           |  17 ++-
>  drivers/phy/motorola/phy-cpcap-usb.c               |  19 ++-
>  drivers/platform/x86/intel-vbtn.c                  |   6 +
>  drivers/platform/x86/touchscreen_dmi.c             |  18 +++
>  drivers/scsi/fnic/vnic_dev.c                       |   8 +-
>  drivers/scsi/ibmvscsi/ibmvfc.c                     |   4 +-
>  drivers/scsi/libfc/fc_exch.c                       |  16 ++-
>  drivers/scsi/scsi_transport_srp.c                  |   9 +-
>  fs/btrfs/backref.c                                 | 157 +++++++++++++--------
>  fs/udf/super.c                                     |   7 +-
>  include/linux/kthread.h                            |   3 +
>  include/net/tcp.h                                  |   1 +
>  kernel/kthread.c                                   |  27 +++-
>  kernel/smpboot.c                                   |   1 +
>  kernel/workqueue.c                                 |   9 +-
>  net/core/gen_estimator.c                           |  11 +-
>  net/ipv4/tcp_input.c                               |   1 +
>  net/ipv4/tcp_output.c                              |   2 +
>  net/ipv4/tcp_timer.c                               |  18 +++
>  net/mac80211/rx.c                                  |   2 +
>  net/switchdev/switchdev.c                          |  23 +--
>  sound/pci/hda/hda_intel.c                          |   3 +
>  sound/soc/sof/intel/hda-codec.c                    |   3 +-
>  tools/objtool/elf.c                                |   7 +-
>  .../powerpc/alignment/alignment_handler.c          |   5 +-
>  35 files changed, 348 insertions(+), 134 deletions(-)
> 
> 
