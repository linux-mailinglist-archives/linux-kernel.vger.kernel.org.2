Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8342E4114C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbhITMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhITMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:45:56 -0400
Received: from frontdoor.pr.hu (frontdoor.pr.hu [IPv6:2a02:808:3:101:250:56ff:fe8e:1370])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:44:29 -0700 (PDT)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
        by frontdoor.pr.hu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <zboszor@pr.hu>)
        id 1mSIem-0005qw-TT; Mon, 20 Sep 2021 14:44:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
        s=pr20170203; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xi0MaFgwW7XGMRxwnKLjcQk427/vxnhnQBUFr75WspI=; b=EVKz7RDVOMui0qUyirpeCIIKQ8
        WdIWW8Y94z+g4jOSUBBLKTRd5nkZyjFCkLwHLmRYDy6GMSJTduJMuWi4ztTGCYK1b2TWeq3ShCOhS
        PCqYgwCrW4xLBAnH8JKLeMrXP3KI4qqbBc61JmvPxSQNIj//SN0z4A+PhEIh2wUuB8TqOIJ2unzR7
        y1xhYzYZ2S2K/Y4G+JuUS1gVBAWiJqrttnRrxyNioNTzYQH1an/cVJpz/pivln8pn4NwutmEadSZS
        a9e06UpqmnrX3s0WtilUShRIdgXCRAnMigybyZfqI61XEv+2B4q69+xiWuUDR09PqkDAN/4J6u24d
        MPPqZbsA==;
Received: from host-87-242-33-29.prtelecom.hu ([87.242.33.29] helo=localhost.lan)
        by mail.pr.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zboszor@pr.hu>)
        id 1mSIei-00011F-QX; Mon, 20 Sep 2021 14:44:22 +0200
From:   zboszor@pr.hu
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?= 
        <zboszor@gmail.com>
Subject: [PATCH] pinctrl-intel: Fix NULL pointer dereference
Date:   Mon, 20 Sep 2021 14:44:16 +0200
Message-Id: <20210920124416.7063-1-zboszor@pr.hu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.1 (------)
X-Scan-Signature: 123237abfafbe34d1fffac85ccaf8f59
X-Spam-Tracer: backend.mail.pr.hu -6.1 20210920124422Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zoltán Böszörményi <zboszor@gmail.com>

On an Elkhart Lake based POS hardware prototype, I got this Oops:

[    1.587455] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.587460] #PF: supervisor read access in kernel mode
[    1.587461] #PF: error_code(0x0000) - not-present page
[    1.587462] PGD 0 P4D 0
[    1.587465] Oops: 0000 [#1] SMP NOPTI
[    1.587467] CPU: 3 PID: 345 Comm: systemd-udevd Not tainted 5.15.0-rc2 #1
[    1.587470] Hardware name: Insyde ElkhartLake/Type2 - Board Product Name1, BIOS F340V030(F340-030) 08/27/2021
[    1.587471] RIP: 0010:strcmp+0xc/0x20
[    1.587476] Code: 06 49 89 f8 48 83 c6 01 48 83 c7 01 88 47 ff 84 c0 75 eb 4c 89 c0 c3 0f 1f 80 00 00 00 00 31 c0 eb 08 48 83 c0 01 84 d2 74 0f <0f> b6 14 07 3a 14 06 74 ef 19 c0 83 c8 01 c3 31 c0 c3 66 90 48 85
[    1.587478] RSP: 0018:ffffbc4f4031bc68 EFLAGS: 00010246
[    1.587480] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffbc4f4031bc40
[    1.587482] RDX: 0000000000000000 RSI: ffffffffc00b7c3f RDI: 0000000000000000
[    1.587483] RBP: ffffffffc00bb0e0 R08: ffff945184f98d90 R09: ffff945184f98d90
[    1.587484] R10: ffff94518c24fd00 R11: 0000000000000000 R12: ffffffffc00b9be0
[    1.587485] R13: 0000000000000000 R14: 00007f9dfe55836b R15: ffffbc4f4031be60
[    1.587487] FS:  00007f9dfe186c00(0000) GS:ffff945307f80000(0000) knlGS:0000000000000000
[    1.587488] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.587490] CR2: 0000000000000000 CR3: 000000010ec26000 CR4: 0000000000350ee0
[    1.587491] Call Trace:
[    1.587495]  intel_pinctrl_get_soc_data+0x62/0xb0
[    1.587500]  intel_pinctrl_probe_by_uid+0xe/0x30
[    1.587502]  platform_probe+0x54/0xb0
[    1.587507]  really_probe+0x1f2/0x3f0
[    1.587509]  ? pm_runtime_barrier+0x43/0x80
[    1.587512]  __driver_probe_device+0xfe/0x180
[    1.587514]  driver_probe_device+0x1e/0x90
[    1.587516]  __driver_attach+0xc0/0x1c0
[    1.587518]  ? __device_attach_driver+0xe0/0xe0
[    1.587519]  ? __device_attach_driver+0xe0/0xe0
[    1.587521]  bus_for_each_dev+0x75/0xc0
[    1.587525]  bus_add_driver+0x12b/0x1e0
[    1.587527]  driver_register+0x8f/0xe0
[    1.587529]  ? 0xffffffffc00be000
[    1.587531]  do_one_initcall+0x41/0x1d0
[    1.587535]  ? kmem_cache_alloc_trace+0x179/0x290
[    1.587539]  do_init_module+0x5c/0x260
[    1.587542]  __do_sys_init_module+0x12e/0x1b0
[    1.587545]  do_syscall_64+0x59/0x80
[    1.587549]  ? exc_page_fault+0x72/0x150
[    1.587551]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    1.587555] RIP: 0033:0x7f9dfe3f1fbe
[    1.587557] Code: 48 8b 0d 5d 2e 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2a 2e 0e 00 f7 d8 64 89 01 48
[    1.587558] RSP: 002b:00007ffc6d730128 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[    1.587560] RAX: ffffffffffffffda RBX: 00005622cd061ae0 RCX: 00007f9dfe3f1fbe
[    1.587562] RDX: 00007f9dfe55836b RSI: 00000000000073c1 RDI: 00007f9dfe08c010
[    1.587563] RBP: 00007f9dfe08c010 R08: 00007f9dfe0ee000 R09: 0000000000000000
[    1.587564] R10: 000000000000e791 R11: 0000000000000246 R12: 00007f9dfe55836b
[    1.587565] R13: 0000000000000000 R14: 0000000000000007 R15: 00005622cd061ae0
[    1.587567] Modules linked in: pinctrl_elkhartlake(+)
[    1.587570] CR2: 0000000000000000
[    1.587572] ---[ end trace 57cca7635b10fc01 ]---

It's probably a firmware bug, so be overly protective:
* check whether struct intel_pinctrl_soc_data **table is NULL
  before dereferencing it, and
* check that none of the arguments to strcmp() are NULL

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 85750974d182..5d4c5dff166d 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1608,8 +1608,11 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		const void *match = device_get_match_data(&pdev->dev);
 
 		table = (const struct intel_pinctrl_soc_data **)match;
+		if (!table)
+			return ERR_PTR(-ENODEV);
+
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (adev->pnp.unique_id && table[i]->uid && !strcmp(adev->pnp.unique_id, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
@@ -1622,6 +1625,9 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 			return ERR_PTR(-ENODEV);
 
 		table = (const struct intel_pinctrl_soc_data **)id->driver_data;
+		if (!table)
+			return ERR_PTR(-ENODEV);
+
 		data = table[pdev->id];
 	}
 
-- 
2.31.1

