Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E937C076
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhELOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:43:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230445AbhELOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:43:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7779EADD7;
        Wed, 12 May 2021 14:42:30 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Daniel Wagner <dwagner@suse.de>,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: [PATCH v2] nvmet: Reset ns->file when open fails
Date:   Wed, 12 May 2021 16:42:28 +0200
Message-Id: <20210512144228.103396-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the ns->file value to NULL also in the error case in
nvmet_file_ns_enable().

The ns->file variable points either to file object or contains the
error code after the filp_open() call. This can lead to following
problem:

When the user first setups an invalid file backend and tries to enable
the ns, it will fail. Then the user switches over to a bdev backend
and enables successfully the ns. The first received I/O will crash the
system because the IO backend is chosen based on the ns->file value:

static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
{
	[...]

	if (req->ns->file)
		return nvmet_file_parse_io_cmd(req);

	return nvmet_bdev_parse_io_cmd(req);
}

Reported-by: Enzo Matsumiya <ematsumiya@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
changes v2:
  - fix types mixup
    Reported-by: kernel test robot <lkp@intel.com>


We saw the backtrace with following (test) configuration:

 nt00:/var/crash/2021-03-22-16:13 # nvmetcli ls /
 o- / ......................................................................................................................... [...]
   o- hosts ................................................................................................................... [...]
   o- ports ................................................................................................................... [...]
   | o- 1 .................................................. [trtype=tcp, traddr=192.168.0.134, trsvcid=4420, inline_data_size=16384]
   |   o- ana_groups .......................................................................................................... [...]
   |   | o- 1 ..................................................................................................... [state=optimized]
   |   o- referrals ........................................................................................................... [...]
   |   o- subsystems .......................................................................................................... [...]
   |     o- nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c ......................................... [...]
   o- subsystems .............................................................................................................. [...]
     o- nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c  [version=1.3, allow_any=1, serial=6e91a39f356a26ee]
       o- allowed_hosts ....................................................................................................... [...]
       o- namespaces .......................................................................................................... [...]
         o- 1 ...................................... [path=/dev/nvme0n1, uuid=1c681585-01ec-48db-b772-9d103c8d47a3, grpid=1, enabled]


 nvmet: creating controller 2 for subsystem nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c for NQN nqn.2014-08.org.nvmexpress:uuid:9b9f4d56-59f6-cbf6-2e26-969777c12e5f.
 BUG: kernel NULL pointer dereference, address: 0000000000000012
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 1 PID: 444 Comm: kworker/1:1H Kdump: loaded Tainted: G               X    5.3.18-24.52-default #1 SLE15-SP2
 Hardware name: VMware, Inc. VMware7,1/440BX Desktop Reference Platform, BIOS VMW71.00V.15401161.B64.2001021853 01/02/2020
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:nvmet_file_submit_bvec+0x3f/0x130 [nvmet]
 Code: 00 53 44 89 c5 48 89 fb 48 83 ec 30 48 8b 77 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 48 8b 07 48 8b 76 50 80 38 01 <48> 8b 76 28 0f 84 c6 00 00 00 4c 8b 6e 20 31 f6 49 89 c8 48 89 d1
 RSP: 0018:ffffa111c0353c98 EFLAGS: 00010202
 RAX: ffff8bf7069d7f30 RBX: ffff8bf706a00008 RCX: 0000000000001000
 RDX: 0000000000000001 RSI: ffffffffffffffea RDI: ffff8bf706a00008
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000100 R12: ffff8bf706a000c0
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8bf706a00008
 FS:  0000000000000000(0000) GS:ffff8bf73fc80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000012 CR3: 000000012a394001 CR4: 00000000003606e0
 Call Trace:
  nvmet_file_execute_io+0x1ae/0x270 [nvmet]
  nvmet_tcp_try_recv_pdu+0x364/0x710 [nvmet_tcp]
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  nvmet_tcp_io_work+0x6d/0xa90 [nvmet_tcp]
  process_one_work+0x1f4/0x3e0
  worker_thread+0x2d/0x3e0
  ? process_one_work+0x3e0/0x3e0
  kthread+0x10d/0x130
  ? kthread_park+0xa0/0xa0
  ret_from_fork+0x35/0x40
 Modules linked in: nvme_fabrics nvmet_tcp nvmet configfs af_packet ip_set nfnetlink iscsi_ibft iscsi_boot_sysfs rfkill x_tables bpfilter vmw_vsock_vmci_transport vsock fuse nls_iso8859_1 nls_cp437 vfat fat intel_rapl_msr intel_rapl_common sb_edac crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd nvme glue_helper nvme_core joydev pcspkr vmw_balloon vmxnet3 button ac i2c_piix4 vmw_vmci btrfs libcrc32c xor hid_generic raid6_pq usbhid sr_mod cdrom sd_mod ata_generic vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix ehci_pci drm crc32c_intel uhci_hcd serio_raw ahci libahci ehci_hcd vmw_pvscsi usbcore libata sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod efivarfs [last unloaded: ip_tables]
 Supported: Yes, External
 CR2: 0000000000000012

Enzo was not able reproduce it reliable so we can't really say if the
patch fixes the crash he saw. But I figured ns->file should be set
back to NULL.

 drivers/nvme/target/io-cmd-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 715d4376c997..27430d44ef23 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -51,7 +51,9 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = ns->file;
+		ns->file = NULL;
+		return PTR_ERR(ret);
 	}
 
 	ret = nvmet_file_ns_revalidate(ns);


 drivers/nvme/target/io-cmd-file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 715d4376c997..7fdbdc496597 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,9 +49,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
-		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = PTR_ERR(ns->file);
+		pr_err("failed to open file %s: (%d)\n",
+			ns->device_path, ret);
+		ns->file = NULL;
+		return ret;
 	}
 
 	ret = nvmet_file_ns_revalidate(ns);
-- 
2.29.2

