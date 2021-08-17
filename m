Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A206E3EEB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhHQLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:16:28 -0400
Received: from ni.piap.pl ([195.187.100.5]:42548 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhHQLQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:16:27 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTPSA id 4BED2C3EDF39
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:15:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 4BED2C3EDF39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1629198950; bh=GwxveQNDYU2usoFMn4ojYyu87HyBEZqmF70lbkcXNJw=;
        h=From:To:Subject:Date:From;
        b=aKj28XjdJ6PbjncMoyhB609rLn8PwiryqhBDzLgygTIyX4LOE+HAXhu5YBohrj3Sc
         /zLSU/hmHbMWN9IyQlFsYi1KikcSe38xy89OaQ6BTiiziZgm4QVJ4lbp92n6BtyInC
         19TZJHjje5Uh4BpNggLaoXX4T3G2DNzUeSsliwh0=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] v5.13.8 kernel NULL pointer dereference on SD card removal
Sender: khalasa@piap.pl
Date:   Tue, 17 Aug 2021 13:15:49 +0200
Message-ID: <m35yw4e2ze.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 165609 [Aug 17 2021]
X-KLMS-AntiSpam-Version: 5.9.20.0
X-KLMS-AntiSpam-Envelope-From: khalasa@piap.pl
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=pass header.d=piap.pl
X-KLMS-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c, {Tracking_marketers, three}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;piap.pl:7.1.1;t19.piap.pl:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2021/08/17 08:25:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2021/08/17 07:21:00 #17050387
X-KLMS-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps someone could use this. TIA.

Mounted an EXT4FS SD card (apparently). Removed the USB readed (with the
card) from the machine. Core i7 CPU, x86-64. Fedora normal kernel.

Now mounting:
usb 3-14: new high-speed USB device number 34 using xhci_hcd
usb 3-14: New USB device found, idVendor=3D05e3, idProduct=3D0738, bcdDevic=
e=3D 0.01
usb 3-14: New USB device strings: Mfr=3D3, Product=3D4, SerialNumber=3D5
usb 3-14: Product:  USB3 Reader
usb 3-14: Manufacturer: Genesys
usb-storage 3-14:1.0: USB Mass Storage device detected
scsi host8: usb-storage 3-14:1.0
scsi 8:0:0:0: Direct-Access     Generic  STORAGE DEVICE   FT01 PQ: 0 ANSI: 6
scsi 8:0:0:1: Direct-Access     Generic  STORAGE DEVICE   FT01 PQ: 0 ANSI: 6
sd 8:0:0:0: Attached scsi generic sg4 type 0
sd 8:0:0:1: Attached scsi generic sg5 type 0
sd 8:0:0:1: [sdf] 31116288 512-byte logical blocks: (15.9 GB/14.8 GiB)
sd 8:0:0:1: [sdf] Write Protect is off
sd 8:0:0:1: [sdf] Mode Sense: 21 00 00 00
sd 8:0:0:1: [sdf] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 8:0:0:0: [sde] Attached SCSI removable disk
 sdf: sdf1 sdf2
sd 8:0:0:1: [sdf] Attached SCSI removable disk
EXT4-fs (sdf2): recovery complete
EXT4-fs (sdf2): mounted filesystem with ordered data mode. Opts: (null). Qu=
ota mode: none.

Then removing:
usb 3-14: USB disconnect, device number 34
blk_update_request: I/O error, dev sdf, sector 25832 op 0x1:(WRITE) flags 0=
x3000 phys_seg 1 prio class 0
Buffer I/O error on dev sdf2, logical block 157, lost async page write
blk_update_request: I/O error, dev sdf, sector 29368 op 0x1:(WRITE) flags 0=
x3000 phys_seg 1 prio class 0
Buffer I/O error on dev sdf2, logical block 599, lost async page write
blk_update_request: I/O error, dev sdf, sector 29752 op 0x1:(WRITE) flags 0=
x3000 phys_seg 3 prio class 0
Buffer I/O error on dev sdf2, logical block 647, lost async page write
Buffer I/O error on dev sdf2, logical block 648, lost async page write
Buffer I/O error on dev sdf2, logical block 649, lost async page write
JBD2: Error while async write back metadata bh 157.
Aborting journal on device sdf2-8.
blk_update_request: I/O error, dev sdf, sector 1597440 op 0x1:(WRITE) flags=
 0x800 phys_seg 1 prio class 0
Buffer I/O error on dev sdf2, logical block 196608, lost sync page write
JBD2: Error -5 detected when updating journal superblock for sdf2-8.
JBD2: Error while async write back metadata bh 599.
JBD2: Error while async write back metadata bh 647.
JBD2: Error while async write back metadata bh 648.
udisksd[7311]: Cleaning up mount point /run/media/* (device 8:82 no longer =
exists)
systemd[1]: run-media-*.mount: Deactivated successfully.
JBD2: Error while async write back metadata bh 649.

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 2 PID: 279 Comm: kworker/2:1H Not tainted 5.13.8-200.fc34.x86_64 #1
Hardware name: ASUS All Series/Z87-PLUS, BIOS 2103 08/15/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:sbitmap_get+0x75/0x190
Code: 85 80 00 00 00 41 8b 57 08 85 d2 0f 84 b1 00 00 00 45 31 e4 48 63 cd =
48 8d 1c 49 48 c1 e3 06 49 03 5f 10 4c 8d 6b 40 83 f0 01 <48> 8b 33 44 89 f=
2 4c 89 ef 0f b6 c8 e8 4a f7 ff ff 83 f8 ff 75 58
RSP: 0000:ffffac8ac0353d58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff955706c6a030
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff9555809b8c6c
R10: 0000000000000008 R11: 0000000000000008 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000000 R15: ffff955706c6a030
FS:  0000000000000000(0000) GS:ffff955c8fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000003b298a006 CR4: 00000000001706e0
Call Trace:
 scsi_mq_get_budget+0x1a/0x110
 __blk_mq_do_dispatch_sched+0x1b4/0x2d0
 ? __switch_to_xtra+0x111/0x500
 __blk_mq_sched_dispatch_requests+0x129/0x180
 blk_mq_sched_dispatch_requests+0x30/0x60
 __blk_mq_run_hw_queue+0x2d/0x60
 process_one_work+0x1ec/0x380
 worker_thread+0x53/0x3e0
 ? process_one_work+0x380/0x380
 kthread+0x127/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
Modules linked in: nls_utf8 isofs ib_core vfat fat uas usb_storage pl2303 c=
dc_acm tun intel_rapl_msr snd_hda_codec_hdmi snd_hda_codec_realtek i915 snd=
_hda_codec_generic ledtrig_audio intel_rapl_common snd_hda_intel i2c_algo_b=
it drm_kms_helper x86_pkg_temp_thermal snd_intel_dspcfg intel_powerclamp sn=
d_intel_sdw_acpi snd_hda_codec coretemp snd_hda_core rapl ftdi_sio joydev i=
ntel_cstate snd_hwdep snd_seq mei_hdcp snd_seq_device intel_uncore snd_pcm =
mei_me snd_timer at24 snd soundcore cec i2c_i801 mei e1000e mxm_wmi wmi_bmo=
f lpc_ich i2c_smbus drm fuse ip_tables raid1 crct10dif_pclmul crc32_pclmul =
crc32c_intel ghash_clmulni_intel video wmi
CR2: 0000000000000000
---[ end trace 17813201f8776546 ]---
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
