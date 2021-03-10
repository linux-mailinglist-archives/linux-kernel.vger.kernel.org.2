Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954743334AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhCJFBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:01:30 -0500
Received: from mail-eopbgr680082.outbound.protection.outlook.com ([40.107.68.82]:30790
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229624AbhCJFBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or006i59peqevS0XdIlJJrd2WvwVf75fdNhB/B0n8lkzgAW7bg0VAmGFxvTGehzBk4aGjUGZcgImJrIGDgXAlwA101UoLz8QNZM10kuikN5px2jB/1yv2y5DdJ2z7P5n/RinXQi2DjiIbbyTy4VDsDg6dXjaE691Uq8fwysWmn7igiQyoVZlfqSordsqhRSRX5yokKRMxsyZPSxid+QF1gfEtgX6126f9BGZ6jF5nt+FKCdz1bKuXu4ujUQvNt5qMlxML4yqjlTohCQvYrr+hyXzWTI7UyBuvJRSLrdnvsN0oM6OPUkb4dr2wx8xiBkIOEhMwM3vXk0uUYHxvDev9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBimJZQG4cbOAhkQXTmsvmkg8cmhi0Iegx46zA9gcQ8=;
 b=BSQAVZGQNcl7Ck+QTEk1SoiIgRPDJ8WqAuGsaS0xbuTKXLHQ2pHFpKvvb2I1XBA1rUuLvTetDzyFNH9pmP5+5niBj4mH04Pop/+UhB4z8BhHVmq5YX2GzleoWtjW/ED5N4F/vjdBmgS9Bb4ZAfPBM2SNqUP6mcHgG1gPRNTnVPWaBdD9nhTjZKa/uSO6BBt9CGcAyTDczF/7k31ljivfmrXPKdAOUJJgjP+YZGsG7zBqx2qATp6VZMC3k8QrIh85yTOkshQkZ0E47AfndJbnLV0MvVb9OQAhlehXAKwqzLlHHUQPaUDzdgDFR99DGKSRRcTZ/3d7rrkOfiZ7KmxDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBimJZQG4cbOAhkQXTmsvmkg8cmhi0Iegx46zA9gcQ8=;
 b=WcrxmAUh3cuTgxaRw4nsR6hiUPcqhkQMMbKocwLiz3ZbQeoAiow1xqeBdMHS6Ys1Wiu0Z3rA0rYT8QtKArRh0LIo4dhMmdSnd5oEHaZqpNcTM7eCOueujU+nJABrXifTQ2/QifzGVNu8h52jJoFZB73oSpxRM/ROAczCILM49iY=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB2006.namprd11.prod.outlook.com (2603:10b6:903:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Wed, 10 Mar
 2021 05:01:01 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3890.037; Wed, 10 Mar 2021
 05:01:01 +0000
From:   quanyang.wang@windriver.com
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        quanyang.wang@windriver.com
Subject: [PATCH] drm: xlnx: call pm_runtime_get_sync before setting pixel clock
Date:   Wed, 10 Mar 2021 12:59:45 +0800
Message-Id: <20210310045945.3034364-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BYAPR06CA0062.namprd06.prod.outlook.com (2603:10b6:a03:14b::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 05:00:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38eefc85-b33b-45af-c940-08d8e3817f3d
X-MS-TrafficTypeDiagnostic: CY4PR11MB2006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB2006B02AFDC4D0BCC716AE4DF0919@CY4PR11MB2006.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJJY4PrfQGHePli40xdhhbd0N4EZAVre+IQpeltabwRdcewqWaRWO6NeISbPX1oNTTeNNFhciSJXdyR0sOuoOkCOty3PkEM4R25zKT/ToJXKoHI74c+y1XZxDC5jyCr0iPJ/lc+sfP17cp7xF5fESJcvMgHKvcH6iZVRE6G90TiLFxJPlIDWAKLzBKmRFHMdpAvwArxD4Fg3Ufr0awS0gsPBPbyArNj96Q8GC7PDBtSZfA2ZfnjjLZwXIr0XRNFp7wciCrFjNCZufB6Nd8yVXFEO7mnzD6jSBKuewYLOjInDj8ZuXMEpcL21rWEYaz8UxB+l702xNSUO7v3ZeD2OhwxZcakKipxwgeG3jVrp0es/NepDdITHMIA0mFjl8CNvHd4qkoeoCCdKlrtPyNTfOmHhDXFyfB70heevY2xKy55oI4qEjMt9/WeE2/W6wIBopwZSlqGnWo4vrtI8walWfRrR2CFGsUFA/In+FpqyBJLlRKSErP3OwyPYtYVbuJisRq3vS8sNaaO3vPiKToQa+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(52116002)(2616005)(86362001)(6486002)(956004)(83380400001)(2906002)(26005)(16526019)(186003)(8676002)(6636002)(66556008)(36756003)(9686003)(6506007)(1076003)(4326008)(8936002)(316002)(5660300002)(107886003)(478600001)(6512007)(110136005)(66946007)(6666004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dZcjvwH8gqeV3rWF5WHYRy3ONhnQqDkEScT5gO6bKgqnMPlC79E+rCRT6HdQ?=
 =?us-ascii?Q?nAeZNCeqV4K5PN2rktb7CvTnYA3ApkJblua/voBGlacNIB1BYAF4eh6LlZfR?=
 =?us-ascii?Q?V7VnoV4dofvYFJJamix/Z9BijDs05MNVjpB2vHegLbxczVkIWWid17IIVCa+?=
 =?us-ascii?Q?U8dQNKpErSQ1zh+EoRdXgMQvx7Boy7kp1AoGuGeJB3jYhAGhMPpdFhDIwVHh?=
 =?us-ascii?Q?1tTvzPMWOqZC7rIMjulKgPq0aHfvG0zyJnMFPH6IL3nEp0+PF16sdXHn3TUP?=
 =?us-ascii?Q?CjS44zvSqMsF4bxtVG2ZnqlV2U65mxrkbfjqev4Svx4NYRc7F5ixNT0/a1qf?=
 =?us-ascii?Q?Pyvg7Rrzw4HdVO3OTZZmpfPFO5l1QnZFPA0S+ZFWiQwadk58JRWHw+ki/L0U?=
 =?us-ascii?Q?DoVP/k3KbTSQIZqZ+d/cS3w1l7zCBmpdXvO/hmq4680B3mpZujGpalT7z5A3?=
 =?us-ascii?Q?VAH7VtnlTx+3IkIdaBJprICTH7azw/xiuSdQRucSYKh2WYab6ZY3zKQztwju?=
 =?us-ascii?Q?OrT5RR2FAOrS9jVr7fkPZWrQzXoZAyE5uNMvyXq0/56WZMijeK2W3I9mu8nN?=
 =?us-ascii?Q?HJrriSjfOEWaqlFE/KBCenbGw6PxyuJLoS9Xtt9dfrUdMbIf1w5gMN+uJl3v?=
 =?us-ascii?Q?AhOZ6y8AGbDhc5nuJyR/YXVLpVW6r7xdFEDrD7QaJ8BSA9ad3QFxGIZEXHwn?=
 =?us-ascii?Q?6EALPnnUsY5Dz3NkQdmhkkgsENRYuOTofREXii1Jb2L4FqBd8wWCWt7qbQZv?=
 =?us-ascii?Q?7Ir4aXcG3Hgykirt/0zlNRHtrNEWH57QYMzTTuqd9EKOS0ix0Ck+wC6lK0WG?=
 =?us-ascii?Q?Q9xGek0VPytOx1slDZL83PHW3SWaUPpylykSUalpbkPHI9JtlXEzpg4SKQJa?=
 =?us-ascii?Q?E4Eg8O+1WxDxZqMQzrkbz8adO2sEva0GeJO7sE/Bocf5X26UKaB/iyyVKNJI?=
 =?us-ascii?Q?dZZfqseTIiEVFid2jyNehAaXCfudibekjBDc5IFZ5/KMmfn2NpRd1oEPINnb?=
 =?us-ascii?Q?UQAlsJsrh647o/B1qjQOSiWSDOHZHuMvB555LUNpCx6QipiQq+eByKbrHNYG?=
 =?us-ascii?Q?pf8tKhMI9s2cg6vCGvQR0WLDM227wi2XtwoMkEz8oO8ir/dZ0vBWcgjFrtTy?=
 =?us-ascii?Q?zs9Db9EkfrWrRAUbawV+hLGLxHwbRy0052iwu9o8TxO/x4cJYoONhmF3vBUd?=
 =?us-ascii?Q?HDXLJ8maM241z1uSvt6wEShWZGDUktV4QrukdXr7zmAMCK3BahspC3Cc7UsJ?=
 =?us-ascii?Q?Ao+ZcKRLsFlOGLcnoHRuaKnbkvqsqxArwGQc9MojrNTzPwmibOIzs58BTCnP?=
 =?us-ascii?Q?wXSlHmu7+x/5F4sRzB+oAbj9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eefc85-b33b-45af-c940-08d8e3817f3d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 05:01:01.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGqGwcry0o4rKn4QrcO8EAoJPA3G2ukuTaFbX3DUvdgIHmRExsflrVv/TX7rTivpkURz4JRLHq7LgGwRrzY+rmTl34KNk/ATcgMutQMypRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The Runtime PM subsystem will force the device "fd4a0000.zynqmp-display"
to enter suspend state while booting if the following conditions are met:
- the usage counter is zero (pm_runtime_get_sync hasn't been called yet)
- no 'active' children (no zynqmp-dp-snd-xx node under dpsub node)
- no other device in the same power domain (dpdma node has no
		"power-domains = <&zynqmp_firmware PD_DP>" property)

So there is a scenario as below:
1) DP device enters suspend state   <- call zynqmp_gpd_power_off
2) zynqmp_disp_crtc_setup_clock	    <- configurate register VPLL_FRAC_CFG
3) pm_runtime_get_sync		    <- call zynqmp_gpd_power_on and clear previous
				       VPLL_FRAC_CFG configuration
4) clk_prepare_enable(disp->pclk)   <- enable failed since VPLL_FRAC_CFG
				       configuration is corrupted

From above, we can see that pm_runtime_get_sync may clear register
VPLL_FRAC_CFG configuration and result the failure of clk enabling.
Putting pm_runtime_get_sync at the very beginning of the function
zynqmp_disp_crtc_atomic_enable can resolve this issue.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 148add0ca1d6..909e6c265406 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1445,9 +1445,10 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
 	int ret, vrefresh;
 
+	pm_runtime_get_sync(disp->dev);
+
 	zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
 
-	pm_runtime_get_sync(disp->dev);
 	ret = clk_prepare_enable(disp->pclk);
 	if (ret) {
 		dev_err(disp->dev, "failed to enable a pixel clock\n");
-- 
2.25.1

