Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9638CA11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhEUP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhEUP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 376ED60698;
        Fri, 21 May 2021 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621610828;
        bh=y0/BKPJwQLkNi3YAcK0p7D1L9xBZFof1RF/D30J9cTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E70Kqbt68unJFcXvSfnVm4cXes1iIVtvo8/iEaXyo9JkZ/jKPdzTe6KYiTz+6Z9IA
         D/Vu5HDnQyUENgWh5tAnPjHkP4A/w7PoPwtK6yT1FpXHnheB2GTUWHQEX+VDQiRahH
         PI6J1OWBsoUDsV5uZvp9QgVwfe5prBqgja3A7jOOdz8rIgC0H0h3hXchlwkObkx3/5
         PRDjxNsNDz1b4T5hpWeZPmTWKt7pl4Ai9qrvYUsHitO/+ACW00jGGAkfyKt6pQB1KB
         BToRgyjWmsgkhGx61Tw+F2vehmzxnhhvN2ZvtW1oy8FXgjW0sH7W1lKzoy82X/ZmOa
         gHC9lgBXLF2FA==
Date:   Sat, 22 May 2021 00:27:02 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210521152702.GB29013@redsun51.ssa.fujisawa.hgst.com>
References: <20210521144734.90044-1-dwagner@suse.de>
 <20210521145306.ld7jc6alchimyzny@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521145306.ld7jc6alchimyzny@beryllium.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 04:53:06PM +0200, Daniel Wagner wrote:
> On Fri, May 21, 2021 at 04:47:34PM +0200, Daniel Wagner wrote:
> > NVMe 1.4 states that MNAN might be zero, in which case we should
> > evaluate NN to get the number of supported namespaces.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> 
> Forgot to mention: During testing dynamically adding namespaces it was
> possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
> the subsystem started with 8 namespaces and during runtime another 8
> namespaces was added.

The controller is required to have a non-zero MNAN value if it supports
ANA: 

  If the controller supports Asymmetric Namespace Access Reporting, then
  this field shall be set to a non-zero value that is less than or equal
  to the NN value.

>  WARNING: CPU: 3 PID: 3990 at ../drivers/nvme/host/multipath.c:464 nvme_parse_ana_log+0x15f/0x180 [nvme_core]
>  Modules linked in: nls_utf8 isofs af_packet iscsi_ibft iscsi_boot_sysfs rfkill intel_rapl_msr iTCO_wdt intel_pmc_bxt iTCO_vendor_support dcdbas(XX) intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel nls_iso8859_1 nls_cp437 vfat fat xfs kvm irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper pcspkr mgag200 joydev drm_kms_helper cec rc_core syscopyarea sysfillrect sysimgblt fb_sys_fops ipmi_ssif mei_me mei igb lpc_ich i2c_algo_bit dca ipmi_si ipmi_devintf ipmi_msghandler button drm fuse btrfs libcrc32c xor raid6_pq sr_mod cdrom sd_mod hid_generic usbhid uas usb_storage lpfc(OEXX) nvmet_fc nvmet configfs ehci_pci ehci_hcd nvme_fc ahci nvme_fabrics libahci nvme_core crc32c_intel libata usbcore scsi_transport_fc megaraid_sas t10_pi wmi sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod msr efivarfs
>  Supported: Yes, External
>  CPU: 3 PID: 3990 Comm: kworker/u82:4 Kdump: loaded Tainted: G           OE  X    5.3.18-56-default #1 SLE15-SP3
>  Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS 2.11.0 11/02/2019
>  Workqueue: nvme-wq nvme_scan_work [nvme_core]
>  RIP: 0010:nvme_parse_ana_log+0x15f/0x180 [nvme_core]
>  Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3
>  RSP: 0018:ffffa59f495cbca0 EFLAGS: 00010283
>  RAX: 0000000000000010 RBX: ffff98bacb7bd470 RCX: 0000000000000028
>  RDX: 0000000000000001 RSI: ffffa59f495cbce0 RDI: ffff98bacb7bd470
>  RBP: 0000000000000030 R08: 0000000000000001 R09: 0000000000000228
>  R10: ffff98c2b1caaa10 R11: 000000000001d900 R12: 0000000000000040
>  R13: 0000000000000000 R14: ffffffffc02a9000 R15: ffff98c2b1caaa00
>  FS:  0000000000000000(0000) GS:ffff98c2ff840000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055a303a6a5e0 CR3: 00000006e820a004 CR4: 00000000001706e0
>  Call Trace:
>   nvme_mpath_add_disk+0x81/0x100 [nvme_core]
>   nvme_validate_ns+0x3d4/0x900 [nvme_core]
>   nvme_scan_work+0x155/0x2d0 [nvme_core]
>   process_one_work+0x1f4/0x3e0
>   worker_thread+0x2d/0x3e0
>   ? process_one_work+0x3e0/0x3e0
>   kthread+0x10d/0x130
>   ? kthread_park+0xa0/0xa0
>   ret_from_fork+0x35/0x40
