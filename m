Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE33CA043
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhGOOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:10:36 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:24740
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231247AbhGOOK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUr1t7P///tNUAQdr4fhG8qXSqLoq4DzsMKGQaxC363gT3VcEormo3v/nBIEMkMVw+AqCVoJCHEW+Q5hGl9/lElidsNgDHqvVi/eh1DAM5xzhlzbWirXTJQ/NKGDHNO6rOEcsSBRvHZsJMWEpscuUWMxZYjmlPpPD2Q98jiC/4rpIKnNiPjIaPh17mjinffANd2lVkOeAYbzB98xOJROSN97TaKHk2px8wnQMBtzpjEbdOgtFjw5yGvImS39w/Qql5ne8mJfcPmRK56S0wMTTq58rxXwcTLPkefeLW7JC2Rx5CPHVPi7xr5j82jC60XRG+9u9xF8X0MhiTkF+tln/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieDP4sUWzGqiKsKTDYEjgo+RYphQFLC9xEKo34SB7vg=;
 b=h9GCFIGsDQyfu8gTBvJRUYD8IwLDAkOk7QIDy3ef6fd55ZNKWWKs4LAVwVLkry4SDGoVRKWVJzHpx9x9jmXVsC9ZXmBE4iU5CRGLMBdTEMtTq2vz4FQY36HasdebkIyjQaFYqXkWqadd9ZFe0gv4KB/eiEHKX+eBO894wYw8dOees6RxodRt9Vaouq6bPrx2syN8m7AmCtzx2wCVZ2ngR8o/MMvOy/iVwVkC06WpZAe4DednQkBJ/cK8ESYbyN7qBH2c58ERXoPdeeIE0NyEz4isS+qLdZQ74xwDihyY8ZBa4D8nV8C2Wcy0973ANrJYbENFt/e8nbzvO2OlYG4eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieDP4sUWzGqiKsKTDYEjgo+RYphQFLC9xEKo34SB7vg=;
 b=c3Az9svBtiNGMdB9TYszsioJzpthmrHG7/6Iw+351rU3obP+dK5Kv5bCI3/6tSmMVQo7W6ezGQBAUsmpH76HkgIRycMxLUw5YVZ6od0no2+IXoKwDXG/p9in5sgqhGQQRdb/kld4HatwjYv90vM6VJziPyUTONsnf3/3IqjVkaI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB2973.eurprd04.prod.outlook.com (2603:10a6:802:10::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 14:07:34 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::c424:7608:b9e8:f09f%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 14:07:34 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 8/8] bus: fsl-mc: fix mmio base address for child DPRCs
Date:   Thu, 15 Jul 2021 17:07:18 +0300
Message-Id: <20210715140718.8513-8-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::11) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM4PR0101CA0043.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Thu, 15 Jul 2021 14:07:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8034b684-ef81-449f-d8b6-08d94799e4d6
X-MS-TrafficTypeDiagnostic: VI1PR04MB2973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB29739913322EA2A5DA99A306EC129@VI1PR04MB2973.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duQPUAMr/pOHaJs+xKKvtxpBHs6EPyov6Hyw3rI1vSwJrivX8n3opBheoLcr+yUmWZ83vhbM0MO6TUDE9jpNY8ae3UEp+gXra7L1IeGm9AnJW7mg0Mqgq915yMVUu/vEN22+FT8KFy+4+5LqdOZMO2w/3E8HdOAfMtlTy6PLTv3hEH5Z5rgxgLPIjVnfcTcVNe3iJkJ89eSmz6Ep1bMfTRUwFapZQQe4STiLCHsdzYqiW5L5X6w8hkuqoqYR9rxq7UaxTEHf2ERgKjSMW8FVp505KmKQYVtq0O84tt8qTQAg1LAGrFoculQcicW6DDHsTXC+aGrpojc2+bCuKSNN0j1CgDU7NJphiUVKyVFWdcS1idEOU/GvLYh3WWIvxBBtVsqR2PV01iVD1rHxKRzDK2GkGx054hZ9hDavkMq/QJJR43EPsvPYPL0cZOHhwEpbDWCXBDwZD+9abAQW370z7vjkh2LaW+Iki0ZXdMrJNpUN/HCyPx1dbgILFegrTk27V0Eb0MY87XMTXToMEc/XDWKDF1celGn+slGIMKIUPt8XGN+RP9MmGG9s6kS0qwMn11ifJpfMVdYAXoK4XFJg+RIGjm8gzPdirIweSfgS6Z9k9KsmiSO5i8HVddOujfggsmXUc+7lhF5EmLkFJHEXISbbEqyeYCnor45XlY9zlvKna5E49RaoHbG3yiJN7f+Tap/p8lhZ3xDWfO7aaByC8mCIVLp0OX5E72/bdPp9A0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(66476007)(66556008)(2616005)(956004)(66946007)(6666004)(6512007)(4326008)(83380400001)(86362001)(478600001)(26005)(9686003)(36756003)(1076003)(52116002)(6486002)(6506007)(38100700002)(316002)(8676002)(2906002)(186003)(5660300002)(8936002)(38350700002)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iq19v7yj+e6qut9IGVQmIGbrS7xiqQlvjY2BOekBg/OuNzpPHJXXxF5TaD+Z?=
 =?us-ascii?Q?SJRCuh8jATwvCpR3R7kk4Phc3caOybhoZjvAdgo48G7XevP3OJCCNxVhsdZd?=
 =?us-ascii?Q?aEMLLsjDRO1NePvWmRvIeTPbx8GrLTa4IGrjKT0BMafKT1VFuqYz/4uFVBqJ?=
 =?us-ascii?Q?PCT96QtZEvkKXJFV//h1GV+GDBeoAlBKJpI01BHEg3jRXJMpN3gIPHYo0oZ1?=
 =?us-ascii?Q?t7TmNYPUH0A+QklTj/ku9GRjarIGw2KytR6IsR8ODzVWRqtVIwLnhNg/dmLy?=
 =?us-ascii?Q?xKDzGYNbK/vhpkYqQpfZl93YXkHgvzNz1QlJwlWBczk6fHCq5OCIP00E5EJo?=
 =?us-ascii?Q?/vVXIBvNai5F0XYZ/D4JeFLPCv7TqEdlJEFIyU8EPCqa4FCwc9U7u76v9tuF?=
 =?us-ascii?Q?Fhnvgb/oC+YF+CKc/SrZciRnzk6J2ywAOJNlQfI7e/ibKyjE/Xu+HWMKt10K?=
 =?us-ascii?Q?Bt58YGLpRqr+cJxEGoz4cO+MwABp/kiPUxwyfGCBoryQckdd3ynInhizZghy?=
 =?us-ascii?Q?Vj/2iguQ5FN9Mno3XS4w7Gnli3ihXDvp7Gp470BeqlOZasbnTmK2rLuu3hok?=
 =?us-ascii?Q?mjXOXOmZ29R4Aai0bXgslxaLFL2iJtakl/FX0h10QHZZ15x7MX3Jda8R0OYf?=
 =?us-ascii?Q?c7PePg0hIe9lVERZU3cJC3g3GMeKBPEfu2KcIl1hW5XMz2iJrjHhWBCSoni9?=
 =?us-ascii?Q?6dLcCrvMFAmSpKZPCmZM0iBFn7ryWR/11qa/exdNLnDBnUvj1dsqgLt+WCz+?=
 =?us-ascii?Q?eATZYBN/5QylXWh056sRHiXrRWq2GcJEieZxJ9fYdV0cCxmjoOmmqRvQMlix?=
 =?us-ascii?Q?HSR3pgcfz8+JaniXEeqzb/yUzZJm74UG/5zNMyUCkZDy/ohuFQQIt7fZfQbL?=
 =?us-ascii?Q?ZF8z7uDlo0HH3iyxJta83Tuh6W3LLDPDKy10jTVDu8xo56YaUCqdBFXWIqOn?=
 =?us-ascii?Q?T4CExqqmgRzss4aVh4vxMdI1qIz9KzB8pQytuirCKMoyT/0aiMWPWCl1+NCg?=
 =?us-ascii?Q?J+s50DrUUU0ORstClHhkgQIJnBeb8vWSBXstlbOH2oTWJXW6Zbu+3FM5CIuz?=
 =?us-ascii?Q?GHd/ZZwMnc6LJKe7xNZexKkWR85juulhZ6+mKTVwmk2+yKhXktlkFMeztvbu?=
 =?us-ascii?Q?e6nCwM3mjPXRLWxu2Hwb0mq959Y2C/OWObb5zSIrIb+pSi9ChzFeTGeKctCL?=
 =?us-ascii?Q?foGjQqaGeafrXdHBWn7Bo68vZMQRAt8rWeOMp2ABp8TX4+2RT8hagzqsO0z+?=
 =?us-ascii?Q?18/wzQ6OVExw7djWGmMGc3LLq4LZll58qWGXUUhm4oi0tNQlkMbRHRz9Cs/O?=
 =?us-ascii?Q?l6kEtCl/kP1zgZT2ljnbbWXD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8034b684-ef81-449f-d8b6-08d94799e4d6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 14:07:34.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdf8Q8hnKxbn48YkgB+dvPIseQ42Wh65izBoJZ/DxCoq95BTM1yCAK79uiJBrDeH6gcDJQ4SFV90R2muP/jfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Some versions of the MC firmware wrongly report 0 for register base
address of the DPMCP associated with child DPRC objects thus rendering
them unusable. This is particularly troublesome in ACPI boot scenarios
where the legacy way of extracting this base address from the device
tree does not apply.
Given that DPMCPs share the same base address, workaround this by using
the base address extracted from the root DPRC container.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 31595017d207..6273f782d0f2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -69,6 +69,8 @@ struct fsl_mc_addr_translation_range {
 #define MC_FAPR_PL	BIT(18)
 #define MC_FAPR_BMT	BIT(17)
 
+static phys_addr_t mc_portal_base_phys_addr;
+
 /**
  * fsl_mc_bus_match - device to driver matching callback
  * @dev: the fsl-mc device to match against
@@ -704,14 +706,30 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
 		 * If base address is in the region_desc use it otherwise
 		 * revert to old mechanism
 		 */
-		if (region_desc.base_address)
+		if (region_desc.base_address) {
 			regions[i].start = region_desc.base_address +
 						region_desc.base_offset;
-		else
+		} else {
 			error = translate_mc_addr(mc_dev, mc_region_type,
 					  region_desc.base_offset,
 					  &regions[i].start);
 
+			/*
+			 * Some versions of the MC firmware wrongly report
+			 * 0 for register base address of the DPMCP associated
+			 * with child DPRC objects thus rendering them unusable.
+			 * This is particularly troublesome in ACPI boot
+			 * scenarios where the legacy way of extracting this
+			 * base address from the device tree does not apply.
+			 * Given that DPMCPs share the same base address,
+			 * workaround this by using the base address extracted
+			 * from the root DPRC container.
+			 */
+			if (is_fsl_mc_bus_dprc(mc_dev) &&
+			    regions[i].start == region_desc.base_offset)
+				regions[i].start += mc_portal_base_phys_addr;
+		}
+
 		if (error < 0) {
 			dev_err(parent_dev,
 				"Invalid MC offset: %#x (for %s.%d\'s region %d)\n",
@@ -1150,6 +1168,8 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
+	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
+
 	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
 				 mc_portal_size, NULL,
 				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
-- 
2.17.1

