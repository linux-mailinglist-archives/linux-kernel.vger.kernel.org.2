Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A7538C98E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhEUOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:54:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhEUOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:54:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F5B7AC11;
        Fri, 21 May 2021 14:53:07 +0000 (UTC)
Date:   Fri, 21 May 2021 16:53:06 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Use NN for max_namespaces if MNAN is zero
Message-ID: <20210521145306.ld7jc6alchimyzny@beryllium.lan>
References: <20210521144734.90044-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521144734.90044-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 04:47:34PM +0200, Daniel Wagner wrote:
> NVMe 1.4 states that MNAN might be zero, in which case we should
> evaluate NN to get the number of supported namespaces.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---

Forgot to mention: During testing dynamically adding namespaces it was
possible to trigger the WARNINGs in the nvme_parse_ana_log(). Initially
the subsystem started with 8 namespaces and during runtime another 8
namespaces was added.

 WARNING: CPU: 3 PID: 3990 at ../drivers/nvme/host/multipath.c:464 nvme_parse_ana_log+0x15f/0x180 [nvme_core]
 Modules linked in: nls_utf8 isofs af_packet iscsi_ibft iscsi_boot_sysfs rfkill intel_rapl_msr iTCO_wdt intel_pmc_bxt iTCO_vendor_support dcdbas(XX) intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel nls_iso8859_1 nls_cp437 vfat fat xfs kvm irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper pcspkr mgag200 joydev drm_kms_helper cec rc_core syscopyarea sysfillrect sysimgblt fb_sys_fops ipmi_ssif mei_me mei igb lpc_ich i2c_algo_bit dca ipmi_si ipmi_devintf ipmi_msghandler button drm fuse btrfs libcrc32c xor raid6_pq sr_mod cdrom sd_mod hid_generic usbhid uas usb_storage lpfc(OEXX) nvmet_fc nvmet configfs ehci_pci ehci_hcd nvme_fc ahci nvme_fabrics libahci nvme_core crc32c_intel libata usbcore scsi_transport_fc megaraid_sas t10_pi wmi sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod msr efivarfs
 Supported: Yes, External
 CPU: 3 PID: 3990 Comm: kworker/u82:4 Kdump: loaded Tainted: G           OE  X    5.3.18-56-default #1 SLE15-SP3
 Hardware name: Dell Inc. PowerEdge R630/0CNCJW, BIOS 2.11.0 11/02/2019
 Workqueue: nvme-wq nvme_scan_work [nvme_core]
 RIP: 0010:nvme_parse_ana_log+0x15f/0x180 [nvme_core]
 Code: 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 48 83 c4 08 b8 ea ff ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3
 RSP: 0018:ffffa59f495cbca0 EFLAGS: 00010283
 RAX: 0000000000000010 RBX: ffff98bacb7bd470 RCX: 0000000000000028
 RDX: 0000000000000001 RSI: ffffa59f495cbce0 RDI: ffff98bacb7bd470
 RBP: 0000000000000030 R08: 0000000000000001 R09: 0000000000000228
 R10: ffff98c2b1caaa10 R11: 000000000001d900 R12: 0000000000000040
 R13: 0000000000000000 R14: ffffffffc02a9000 R15: ffff98c2b1caaa00
 FS:  0000000000000000(0000) GS:ffff98c2ff840000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055a303a6a5e0 CR3: 00000006e820a004 CR4: 00000000001706e0
 Call Trace:
  nvme_mpath_add_disk+0x81/0x100 [nvme_core]
  nvme_validate_ns+0x3d4/0x900 [nvme_core]
  nvme_scan_work+0x155/0x2d0 [nvme_core]
  process_one_work+0x1f4/0x3e0
  worker_thread+0x2d/0x3e0
  ? process_one_work+0x3e0/0x3e0
  kthread+0x10d/0x130
  ? kthread_park+0xa0/0xa0
  ret_from_fork+0x35/0x40


