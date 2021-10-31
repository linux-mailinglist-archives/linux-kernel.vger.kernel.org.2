Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5F044116F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 00:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhJaXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 19:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJaXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 19:21:50 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565D1C061746
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 16:19:18 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d6so10201161qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 16:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=PUwVOgF3iqhh9XXg1Q2T+QedNlG9uGi/p8Zh/U78VhE=;
        b=PNiFaGo4/HmrFjb1nTJerGH8lnv2vus3yVTZ2sCWLCK3fDYtsKm4onFb6+QIgDBDTg
         rng9AxTIhp3itrm57B5erOUMYTCUuzJxA2IyNi/ac0qkvhLtDhlbyi+mlmK5f05jODln
         +anYtIm8cJb48oWEtHzj2Qao0Cys8l+hhZfKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=PUwVOgF3iqhh9XXg1Q2T+QedNlG9uGi/p8Zh/U78VhE=;
        b=C6sftA6T8L7XoMSHdCJYKxdfluNdnRnF+bgHGMNx5a9tpKjfcEl0r+8L+QU89e255g
         lYgMzsJrDf7vUK9jqlAMmMMHiXE8mKtWsyRsNd4VeG8j85VpsmTGBIL3OtyXM69meIU4
         aXR6IlioMfIsX4CEmaZAzrHo1hFdfxnpo6hT69DibxsrNKdxEFAEUP5e6ritcU33fS05
         QHutlgx8vQI5CCUwEogBKnkBbtKw8w4kBEiDsMHLxNay+sEIgQdzue6ibQiniRqlCRBc
         01e9YMfxZVIJIUaaXIaWMd/0F+BJFSJqLK+2IubTJBAJZC+14j8W6uEFp7A7TmqZuKSs
         FTaA==
X-Gm-Message-State: AOAM530fcRVC3vV7AH7GKROcudbhePpJD9BBJ+3EVJlVKQI1csbtbhMp
        DhsTQrt8IBzhlaVcFjnY13DxJv9zFppxQmbU
X-Google-Smtp-Source: ABdhPJz5GDIyL5jZ59zB5o5j8dA4Ud0wCFkGak9gGxRV56KcnE3LosqRxDNsaRnidStN59StC8whtw==
X-Received: by 2002:ad4:5e8d:: with SMTP id jl13mr24922062qvb.61.1635722356729;
        Sun, 31 Oct 2021 16:19:16 -0700 (PDT)
Received: from WARPC (pool-70-106-225-116.clppva.fios.verizon.net. [70.106.225.116])
        by smtp.gmail.com with ESMTPSA id t4sm9592177qkp.42.2021.10.31.16.19.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 16:19:16 -0700 (PDT)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: kernel 5.15 does not boot with 3ware card (never had this issue <= 5.14) - scsi 0:0:0:0: WARNING: (0x06:0x002C) : Command (0x12) timed out, resetting card
Date:   Sun, 31 Oct 2021 19:19:12 -0400
Message-ID: <006a01d7cead$b9262d70$2b728850$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfOrHtQ7dw+5hwzQUSCiXXnGDbBmA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Issue: 5.15 hangs at boot (hangs when trying to initialize the 3ware card,
have not had this issue with any prior 5.x kernel 5.(0-14).

Arch: x86_64
Kernel: 5.15
Distribution: Debian testing
Note: Upgraded from 5.14.8 to 5.15, the diff between the two .config's is
posted below, thoughts?

dmesg snippet:
-------------------------------
[8.0574191 loop: module loaded
[8.0575251 the cryptoloop driver has been deprecated and will be removed in
in Linux 5.16
[8.057809] LSI 3uare SAS/SATA-RAID Controller device driver for Linux
v3.26.02.000.
[8.3369831 tc: Refined TC clocksource calibration: 3699.999 MHz
[8.3371911 clocksource: tsc: mask: Oxffffffffffffffff max_cycles:
Ox6aaaa900000, max_idle_ns: 881590498719 ns
[8.3375551 clocksource: Switched to clocksource tsc
( ... )
[9.097964] 3u-sas: scsiO: AEN: INFO (0x04:0x0053): Battery capacity test is
overdue:.
[9.201986] scsi host: 3w-sas
[9.305954] 3u-sas: scsi0: Found an LSI 3ware 9750-2414e Controller at
Oxfb760000, IRQ: 45.
[9.6179701 3u-sas: scsi0: Firmuare FH9X 5.12.00.016, BIOS BE9X 5.11.00.007,
Phys: 28.
[30.498007] scsi 0:0:0:0: WARNING: (0x06:0x002C) : Command (0x12) timed out,
resetting card
[71.4419581 scsi 0:0:0:0: WARNING: (0x06: 0x002C): Command (0x0) timed out,
resetting card.

--

Full configs:
https://installkernel.tripod.com/5.14.txt
https://installkernel.tripod.com/5.15.txt

Diff between 5.14 and 5.15 .config files-- could it be something to do with
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y?

-CONFIG_PRINTK_NMI=y
+CONFIG_ARCH_NR_GPIO=1024
-CONFIG_X86_SYSFB=y
-CONFIG_FIRMWARE_MEMMAP=y
-CONFIG_DMIID=y
-CONFIG_DMI_SYSFS=y
-CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
-CONFIG_BLK_SCSI_REQUEST=y
-CONFIG_BLK_DEV_BSG=y
+CONFIG_BLK_DEV_BSG_COMMON=y
+CONFIG_BLOCK_HOLDER_DEPRECATED=y
+CONFIG_AF_UNIX_OOB=y
+CONFIG_FIRMWARE_MEMMAP=y
+CONFIG_DMIID=y
+CONFIG_DMI_SYSFS=y
+CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
+CONFIG_SYSFB=y
+CONFIG_SCSI_COMMON=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_PTP_1588_CLOCK_OPTIONAL=y
+CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
-CONFIG_MANDATORY_FILE_LOCKING=y
+CONFIG_NETFS_STATS=y
+CONFIG_NTFS3_FS=y
+CONFIG_NTFS3_LZX_XPRESS=y
+CONFIG_SMB_SERVER=y
+CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN=y
+CONFIG_SMBFS_COMMON=y
-CONFIG_TRACE_IRQFLAGS_SUPPORT=y

Thanks,

Justin.

