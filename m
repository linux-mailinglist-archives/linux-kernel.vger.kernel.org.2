Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC48420A67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhJDLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:55:24 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:8518
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhJDLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F32prVOmQ3yco1UI1VM1eSMx3GEMLvUQgIvBBLUw5hQ71+0ku0g0Aq/FYh6FudC7kLneizFPHwZfmYV80lPE852+Losr5hw3EWXIztpDJDL3G/LqGl0V0GnBZWEvf/833SSimmtcTjwXG7DcjKeviqzUoUJRhL5JdVc08G2Pkwsc3t5D/cXZb39DvoEOYq46f7bERFEvtlzgLby+bmZAtm8Jq62hh7cHv29TK4LTwtfCYwLYs4ubYfO0Ndz+m8cBPhmR7+An+psjrpPaJMOhIHLykd1BpTN3XWy2v3pqKhdgr7VpIqeff3EwgtJp44NHSSNc6MWxjbA1FSHTqwg0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IOePKcY+Atw0JBgmH2GgKemmSxwGxfhmxzmY+2kch4=;
 b=C9qQnhFd96W2Ranv1mGBRe6oOdC0l9/SQUN/BykI+eP6O2piv2c8fFGB5UwIdsKTgXc9PzkAlLzHnZrElyO8NxIhvp1dS/F/FE69SyHxOanFW8jp3h0tI0lrh06jiHyYCj3T+lfVR9BoZ4rDDrFualSgn8mqW7IDdpYELh0jSWWvV4u8ReDtUGNo1H3qL77GtUNPxLx/QwjzUuPoFsdUs5tT8nCGbwEmcoJp0Zrrd3tF6s7uaSK4GD8YbIkKIKz3e+7EsyFzFKO/ZNUrljBoR8natneTeYb4IkwcFkvCKjBpnzwpvlArNj5UwLltddtrLWi6B1F1ZyFuWuDYo2/7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IOePKcY+Atw0JBgmH2GgKemmSxwGxfhmxzmY+2kch4=;
 b=P/lYlVPVS9aUhbKfCwyAKv/RDBMIlAsVxt9bmmP0BIkNwAkVkdDEQnMQm9Aca9SYHU7R9ZaWFkU2W8ZQotshwxVOKm9fwzEBdHurboMbr8rOFw1+EHy+WO4QcmHAis6idajtd/w286l8MOXEmhbs9HaN4Xvp5XzGjVW4OqRIS3g=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4894.eurprd04.prod.outlook.com (2603:10a6:803:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 11:53:31 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::e948:b382:34fc:c923%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 11:53:31 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     leoyang.li@nxp.com, youri.querry_1@oss.nxp.com,
        ioana.ciornei@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] soc: dpio: fix cleanup on error
Date:   Mon,  4 Oct 2021 14:53:23 +0300
Message-Id: <20211004115323.7454-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0109.eurprd07.prod.outlook.com
 (2603:10a6:207:7::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
Received: from fsr-ub1864-101.ea.freescale.net (92.120.5.2) by AM3PR07CA0109.eurprd07.prod.outlook.com (2603:10a6:207:7::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11 via Frontend Transport; Mon, 4 Oct 2021 11:53:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f3e109b-7180-4c67-73df-08d9872d9625
X-MS-TrafficTypeDiagnostic: VI1PR04MB4894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4894D5B359B811C64AD739EBECAE9@VI1PR04MB4894.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDMd2zGjngrAKWZJqXkelESMTw059/qlIyzfz2A2XuV/MA75ItBMTEE+yy88ZepKDQ/IdDm9IruKBLALKY8EztvsksYkdTlIECfVYLrxcFlOE3iinI3pNuVmHdjbojtPquPOseUcNEtFZ/NZdV+V0q8z1ZFLL6sQrOV5Zbuiu8X0KivSJhhOo2NpXIQSuMVw2tW5K9vDNUXXVUcXGOi4r0v6JyEdH5NSk6VUW7um2OqNXpmJWdYFVN2s/dDDHHYE97VeR/m54YSURhqSZjerwjhsVGf7vro+xSbwwX+a6fzck3mQU4xsae+ww+TlHf+JeezNXpGhYQzZxyCdKUG1n3T8gMqKdu6n/7QByNi0n/Lr1RD4WfH0onIjMe1xDDQEB/lbWwKd5x+UrS/ijneepYSZ8CEI8knWRAhN5jlTWIVfla66/TNGzXKPV/CYqYUF3kkQ+ki6MSQvBTA19lw79mMcZu6aJgrELBkb22F9dq2myzjT24i487BHhRsYW0PqMdmeok64Vrsw+LeAUEpCh69PnSPLAskSxuAnnJQMnWrSh/1q5e0YxQN0YvbSZdMXr1Ajf66selzMtpslieltz8Yke5PisV9MoXAwgNjYvF5/835FDsqvm/3Dfp16Uak7hF8Q6NcEbc07MTjptSB9XB7HTsqZBlou6OpRtZD1kyACZBrf3mmtE7836lTMdXEzEQDJNlQRVJhJNpkJJMRC/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(4326008)(83380400001)(5660300002)(52116002)(316002)(2616005)(6486002)(956004)(6506007)(508600001)(186003)(8676002)(66476007)(66946007)(36756003)(86362001)(6666004)(2906002)(1076003)(44832011)(8936002)(38350700002)(26005)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpWJFkvFUbLbrRl1SL/I2Ek3vwogIf6cl+MjPftRslBqWv4kcUzh7bYwr8J2?=
 =?us-ascii?Q?/jnEI5LTdWxqyVI/n85++/rffe+XT/q6YgyzAlRI+VQVBfyYfpPpa1ncHISa?=
 =?us-ascii?Q?nJnLzt3zNcyFEIW1oSt6AwCArRnL+IrssERj7Kxz8UMPpgHD1HbG8bTOEamF?=
 =?us-ascii?Q?1xDg05wqw0kof3GA19rbaOysYRdI71y3cvwvrHQBjIVdwMi/1sj9Izkz5ZTc?=
 =?us-ascii?Q?lGJe4NHFMl849Z268BLf2VhQX481SYhD3M6xt6fRduDBSqONMKaSyShsUMMk?=
 =?us-ascii?Q?XtZdA43dxpFaUrR3oQGPJ/M+NoWWn1RA1g/0X5/SfnxvQgXzQxoj7xxaHU6Q?=
 =?us-ascii?Q?rZNfaGhgbyBlRG6ci3ExZ5JCg7VGqocoWwaM538W3XQ9SHlfEoo/MFjZdPnL?=
 =?us-ascii?Q?75oL7QLxAUPtoofNcOB8fa4NjzIB070I6CuZAPgYr4rPnOq9u4unKh+1ItSK?=
 =?us-ascii?Q?d053h5xABGWbS2fkeUNyKtuERRtbDZ838HLA/dLwhdApfq8oqJRBnvj5ZT+m?=
 =?us-ascii?Q?OeKgRvCR7pGrOUcpHazfcxK0QeXV/1g4n+xK6sTajuOKYvJKczyUQKowGKyZ?=
 =?us-ascii?Q?WNnst+0Is3brfsoQg2VRbn8ezxozj1AXRWOQZUWgs640z06LeGw4RaFfqqWU?=
 =?us-ascii?Q?Ob+Vyg5IISBMeLUNJoxXkvw4ndcUbFhowT1CvBCYI986MidDpQ54O3VqxoDx?=
 =?us-ascii?Q?3Kz+UbtwQvi+zMD7In6wpW6ryC49QLVsJ56oO5GpLEuOy6ifteSHo7G8MzSx?=
 =?us-ascii?Q?UyAtkvwgwVEJwMgjumLUZRD6tSwH2RzDR8tcWJyZNVHczGvfiCUuoohAiUY0?=
 =?us-ascii?Q?EXMzOQd7t8pnQq/iXEm+NCCSOQ0mouTYLbWA+hUxGL8aiE6fvTEGCft0cbpv?=
 =?us-ascii?Q?OtwEd9DctIr/duI35+w2C4v8af5diVXpINuGkmoPzgCB9uXfnSJgbSI0mAQi?=
 =?us-ascii?Q?5DykjaCH/619M+CMhFZmTrZOxm4VxsYyjkCdZa60x4QCtLtzw0Z87+dWA9yd?=
 =?us-ascii?Q?XXuA8/T+qsPAMasvL/riH2BnHI8raksh1UqpRMVbIwGtlCQsKUOSAR1xsUCy?=
 =?us-ascii?Q?bf5orZC6weMk3BrT+ofc0gR1gQ5oMtquoy5GV/zg9JPwl3x0A3ov8+fXcVZk?=
 =?us-ascii?Q?g7BNktT9MwELuRvufD0pA3SJ+aIyCtFK8zwX7zlASl3i0+grxPKkJfvPoLvH?=
 =?us-ascii?Q?33PXDD+YO13AecnfSy4y0z5h9qhJ/MH/LOhIjC5G+lW+vqdzP3bqlYqpbwKv?=
 =?us-ascii?Q?uH6EYldvW62R7gO8zeRcVxSXeLTH20gc13aOClnTNRH33l6U4CXbmhT7yiRc?=
 =?us-ascii?Q?9URIpAUiCIyHNxoWxjhJx2bf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3e109b-7180-4c67-73df-08d9872d9625
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 11:53:31.4099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEt0dhr2/Vv359ZTeBzXiYuxdn9f29dz8HFPRT9AkVOf0xu0MlIN8x7qwptyqi+hLWPmrVUArOnq2QpMYSxztg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpaa2_io_service_register() adds an element to a linked list but
doesn't remove it on the error path, leading to the below kasan
use-after-free splat. Fix it.

==================================================================
BUG: KASAN: use-after-free in dpaa2_io_service_register+0xb8/0x1d4
Write of size 8 at addr ffff05d2b13af028 by task kworker/u32:2/151

CPU: 9 PID: 151 Comm: kworker/u32:2 Not tainted 5.14.0-rc1-00222
Hardware name: NXP NXP LX2160ARDB Platform, BIOS EDK II Apr 16 2021
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x2a4
 show_stack+0x1c/0x30
 dump_stack_lvl+0x68/0x84
 print_address_description.constprop.0+0x74/0x2b8
 kasan_report+0x1e0/0x24c
 __asan_store8+0xa8/0xd0
 dpaa2_io_service_register+0xb8/0x1d4
 dpaa2_eth_probe+0x93c/0x21cc
 fsl_mc_driver_probe+0x3c/0x80
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 driver_probe_device+0xf8/0x1e0
 __device_attach_driver+0x120/0x190
 bus_for_each_drv+0xec/0x15c
 __device_attach+0x168/0x250
 device_initial_probe+0x18/0x24
 bus_probe_device+0xec/0x100
 deferred_probe_work_func+0xe8/0x130
 process_one_work+0x3b8/0x650
 worker_thread+0xa4/0x72c
 kthread+0x1f8/0x210
 ret_from_fork+0x10/0x18

Allocated by task 1192:
 kasan_save_stack+0x2c/0x60
 __kasan_kmalloc+0x90/0xb4
 dpaa2_eth_probe+0x830/0x21cc
 fsl_mc_driver_probe+0x3c/0x80
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 driver_probe_device+0xf8/0x1e0
 __device_attach_driver+0x120/0x190
 bus_for_each_drv+0xec/0x15c
 __device_attach+0x168/0x250
 device_initial_probe+0x18/0x24
 bus_probe_device+0xec/0x100
 device_add+0x570/0xca0
 fsl_mc_device_add+0x360/0x8f0
 fsl_mc_obj_device_add+0x140/0x16c
 dprc_scan_objects+0x2c4/0x480
 dprc_probe+0x48/0x17c
 fsl_mc_driver_probe+0x3c/0x80
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 device_driver_attach+0x70/0xf0
 bind_store+0xf8/0x160
 drv_attr_store+0x50/0x6c
 sysfs_kf_write+0x94/0xb0
 kernfs_fop_write_iter+0x19c/0x264
 new_sync_write+0x1c4/0x2bc
 vfs_write+0x30c/0x390
 ksys_write+0xc4/0x170
 __arm64_sys_write+0x48/0x60
 invoke_syscall+0x60/0x190
 el0_svc_common+0x84/0x130
 do_el0_svc+0x88/0xa4
 el0_svc+0x24/0x34
 el0t_64_sync_handler+0xa8/0x130
 el0t_64_sync+0x198/0x19c

Freed by task 1192:
 kasan_save_stack+0x2c/0x60
 kasan_set_track+0x2c/0x40
 kasan_set_free_info+0x2c/0x50
 __kasan_slab_free+0xdc/0x140
 kfree+0xd4/0x360
 dpaa2_eth_probe+0x11b4/0x21cc
 fsl_mc_driver_probe+0x3c/0x80
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 driver_probe_device+0xf8/0x1e0
 __device_attach_driver+0x120/0x190
 bus_for_each_drv+0xec/0x15c
 __device_attach+0x168/0x250
 device_initial_probe+0x18/0x24
 bus_probe_device+0xec/0x100
 device_add+0x570/0xca0
 fsl_mc_device_add+0x360/0x8f0
 fsl_mc_obj_device_add+0x140/0x16c
 dprc_scan_objects+0x2c4/0x480
 dprc_probe+0x48/0x17c
 fsl_mc_driver_probe+0x3c/0x80
 really_probe.part.0+0xec/0x480
 __driver_probe_device+0xd4/0x180
 device_driver_attach+0x70/0xf0
 bind_store+0xf8/0x160
 drv_attr_store+0x50/0x6c
 sysfs_kf_write+0x94/0xb0
 kernfs_fop_write_iter+0x19c/0x264
 new_sync_write+0x1c4/0x2bc
 vfs_write+0x30c/0x390
 ksys_write+0xc4/0x170
 __arm64_sys_write+0x48/0x60
 invoke_syscall+0x60/0x190
 el0_svc_common+0x84/0x130
 do_el0_svc+0x88/0xa4
 el0_svc+0x24/0x34
 el0t_64_sync_handler+0xa8/0x130
 el0t_64_sync+0x198/0x19c

The buggy address belongs to the object at ffff05d2b13af000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 40 bytes inside of
 1024-byte region [ffff05d2b13af000, ffff05d2b13af400)
The buggy address belongs to the page:
page:0000000091873dc7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22313a8
head:0000000091873dc7 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
raw: 0bfffc0000010200 0000000000000000 dead000000000122 ffff05d1000028c0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff05d2b13aef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff05d2b13aef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff05d2b13af000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff05d2b13af080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff05d2b13af100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - corrected commit msg

 drivers/soc/fsl/dpio/dpio-service.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 7351f3030550..b42367eb1653 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -278,10 +278,20 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
 	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
 
 	/* Enable the generation of CDAN notifications */
-	if (ctx->is_cdan)
-		return qbman_swp_CDAN_set_context_enable(d->swp,
-							 (u16)ctx->id,
-							 ctx->qman64);
+	if (ctx->is_cdan) {
+		int ret;
+
+		ret = qbman_swp_CDAN_set_context_enable(d->swp, (u16)ctx->id,
+							ctx->qman64);
+		if (ret) {
+			spin_lock_irqsave(&d->lock_notifications, irqflags);
+			list_del(&ctx->node);
+			spin_unlock_irqrestore(&d->lock_notifications,
+					       irqflags);
+
+			return ret;
+		}
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dpaa2_io_service_register);
-- 
2.17.1

