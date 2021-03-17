Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51AA33F256
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhCQOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:11:40 -0400
Received: from mout01.posteo.de ([185.67.36.65]:41140 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhCQOLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:11:07 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0F760160062
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615990265; bh=s3z9EHQm+skGjH4T/ySJBr9iV6C573AC1EVShMyb7LM=;
        h=Date:From:To:Cc:Subject:From;
        b=rF+uj9JPK/cKGfIKKWCaJklbS3VdiB500vv4G6E7Y3KFWw1MdiWyS+L/KxpPgukNG
         79R+VtkUAqgBm3Mh6DsNCP3oV5hgvxYjeOxwp3v3RLnex52Qmj47qJGYmjoL0SaIhY
         1N8oY8QiCMlYER68K0hpF2lK7lctLQoScvScs+vf99J5DZxs40tFg42ySVB4U0+t5T
         ULL4muFhmI6nDEV4sDwzGyXWIkh6ro8OnLDWIDIMI+1DWPwlzKnpDxVHFczEihD/Vz
         yQRnlUERPdvfpF7pHBwKKzAfMsDm3xZqeRbWSJLmFcpImICiPWYy5t2WJqLn7FbJgU
         VadQs9A1sTKPw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F0sWr07Gvz6tmv;
        Wed, 17 Mar 2021 15:11:03 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:11:02 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH] w1: w1_therm: fix possible NULL pointer dereference
Message-ID: <YFIN9lfBuSzhZjrN@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit function callbacks, read_bit, write_bit, touch_bit and triplet
are an optional implementation in the master drivers. The ds1wm driver
for example does not implement them. If the generic touch_bit is called,
the w1_read_bit and w1_write_bit functions are used, which just call
the implementations of the master driver without checking if they are
implemented at all. In earlier versions of the w1_therm slave driver
none of the bit functions were used. Now read_powermode calls the
touch_bit function which results in a NULL pointer dereference if the
master is the ds1wm driver.

[   17.069073] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   17.070786] #PF: supervisor instruction fetch in kernel mode
[   17.072487] #PF: error_code(0x0010) - not-present page
[   17.074159] PGD 0 P4D 0
[   17.075800] Oops: 0010 [#1] PREEMPT SMP PTI
[   17.077415] CPU: 1 PID: 1032 Comm: w1_bus_master2 Tainted: G           O      5.10.9-vanilla-standard #1
[   17.080621] Hardware name: Default string Default string/CXC-BT-JERO, BIOS S1.61.1.0# 09/17/2018
[   17.083899] RIP: 0010:0x0
[   17.085528] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[   17.087205] RSP: 0018:ffffb05b401d3cc8 EFLAGS: 00010046
[   17.088898] RAX: ffff8fba4175b408 RBX: ffff8fba4175b000 RCX: 00000003f9646356
[   17.090597] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8fba43a450e8
[   17.092293] RBP: ffffb05b401d3ce0 R08: 0000000000000368 R09: ffff8fbb57c294b0
[   17.093980] R10: 000000000000020c R11: 000000000000023e R12: 0000000000000202
[   17.095642] R13: ffff8fba4175b0e8 R14: ffff8fba4175b000 R15: 7a00000013db673b
[   17.097284] FS:  0000000000000000(0000) GS:ffff8fbb57c80000(0000) knlGS:0000000000000000
[   17.100468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.102067] CR2: ffffffffffffffd6 CR3: 00000001e2c0c000 CR4: 00000000001006e0
[   17.103670] Call Trace:
[   17.105225]  w1_read_bit+0x28/0xa0 [wire]
[   17.106754]  w1_touch_bit+0x30/0x40 [wire]
[   17.108238]  read_powermode+0xbc/0x100 [w1_therm]
[   17.109702]  w1_therm_add_slave+0x94/0x140 [w1_therm]
[   17.111166]  w1_attach_slave_device+0x20f/0x320 [wire]
[   17.112629]  w1_slave_found+0xb3/0xc0 [wire]
[   17.114093]  ds1wm_search+0x254/0x5f0 [ds1wm]
[   17.115542]  ? w1_master_attribute_store_add+0xd0/0xd0 [wire]
[   17.116984]  ? w1_master_attribute_store_add+0xd0/0xd0 [wire]
[   17.118367]  w1_search_devices+0x39/0x48 [wire]
[   17.119751]  w1_search_process_cb+0x5f/0x100 [wire]
[   17.121125]  w1_process+0x15c/0x190 [wire]
[   17.122490]  ? w1_process_callbacks+0x90/0x90 [wire]
[   17.123864]  kthread+0x145/0x170
[   17.125199]  ? kthread_create_worker_on_cpu+0x40/0x40
[   17.126517]  ret_from_fork+0x22/0x30
[   17.127798] Modules linked in: lm75 w1_therm rtc_ds1307 sc4_i2c_devices(O) sc4_spi_devices(O) wb_i2cocores(O) i2c_ocores w1_smem wb_sysmod(O) robot_imager(O) ltc2640(O) wb_1wire(O) wb_spi(O) wb_uart(O) wb_ddr2(O) wb_dma(O) wb_supervisor(O) smi(O) ds1wm wire intel_rapl_msr intel_rapl_common intel_soc_dts_thermal intel_soc_dts_iosf intel_powerclamp input_leds robot_wb_adapter(O) wishbone_core(O) coretemp usbhid at24 iTCO_wdt pwm_lpss_platform pwm_lpss
[   17.136035] CR2: 0000000000000000

This patch changes it back to use of the w1_read_8 function. This one
uses the read_byte function provided by the master driver.

This is tested against a 1-wire ds1wm bus master with two w1_therm slaves.

Fixes: 2f6055c26f19 (w1: w1_therm: Fix conversion result for negative temperatures)
Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 drivers/w1/slaves/w1_therm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 976eea28f268..98608e71917b 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1415,11 +1415,11 @@ static int read_powermode(struct w1_slave *sl)
 		if (!reset_select_slave(sl)) {
 			w1_write_8(dev_master, W1_READ_PSUPPLY);
 			/*
-			 * Emit a read time slot and read only one bit,
+			 * Emit a read time slot and read a byte,
 			 * 1 is externally powered,
 			 * 0 is parasite powered
 			 */
-			ret = w1_touch_bit(dev_master, 1);
+			ret = w1_read_8(dev_master) ? 1 : 0;
 			/* ret should be either 1 either 0 */
 		}
 	}
-- 
2.30.2

