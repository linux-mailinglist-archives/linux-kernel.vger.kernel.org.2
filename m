Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953644BE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhKJKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:14:30 -0500
Received: from mail-eopbgr1300077.outbound.protection.outlook.com ([40.107.130.77]:62720
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229653AbhKJKO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:14:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7HnsCtLI57/JDbOajNqdWScKFw4VTff38odfrVHXBD2lpX7m8HWvcsRjW6ze6j24kISkBZmBB4AKWjkr8kNep454nh0CVQVAvpgJZU0bQD8EbSiDb4ZFdN/9m3YunE2Ne76kRzz4C8CwyUbb3hKwrJK8+tYMaQmyP7DrnzrgzX4sEo7lKMdNLb49qFCe1qjw93eIIUA2LAmvwpnRBJpD5+rD8Z+vSui3X1w58wEI/LY4MCvPP2Sb1pHV+OXQg3o0I2clV0UbbIFc9mGcWtBY0z/FwWcRk+mSf59Z5q9lX7TuGaZQ5ORqfDG1JqFhxSwMexFvoZ8vnMt3SmzeKcwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf9YX7+LobWIHxO2o4hDIdr/QY0Ijru0boZevFfkcT0=;
 b=TFhSkyF6St4PDwYQczFAGerAmc9x3O7hd/EaC5YRvGiIK4WaORp2eBNT91d/6+edOKVJVQSJr3dOchGF09q4b4Rw+1ZjCffAWWQFGd9pArXcZFIhziTaB8OfjZfXKTcMncwzmZAoq4DNOyC9kKobQDYih3Jiy21FFnCYJjmauDkCJoC4Q3ThBbCtcMFKHd3fgfjjaPW5Uc9LZ7HVeYo6Gam72y5uO2O0hijCadtYEWfA7HSW9ChMAnj2NoKpJphEc++aPeeM4f+LmqmTYZzMM5XnvAzbt8Y3zJRC2sgOKEAg7Bnucgtr2Qm3a17GZCzr/BLu3bmEPvN6BEiGx+Dj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf9YX7+LobWIHxO2o4hDIdr/QY0Ijru0boZevFfkcT0=;
 b=AuTDprsf+iTfdkPPRLMtSJkxZDvQwsooEiqvY7It8tazb6hPB18GWm97vQizcJ0vL5ptCbewJIj97RiyH/VqkjwvyuFRqYZofzLX0HLvrCrtJbugRlQ3msrPnMacFFdPh9dyAsVp5ecmit0d+hRHzEFTtip7emvD0H3TtU6NPr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KU1PR02MB2390.apcprd02.prod.outlook.com (2603:1096:802:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 10:11:38 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 10:11:38 +0000
From:   Qihang Hu <huqihang@oppo.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qihang Hu <huqihang@oppo.com>
Subject: [PATCH v4] usb: gadget: composite: Show warning if function driver's descriptors are incomplete.
Date:   Wed, 10 Nov 2021 18:11:29 +0800
Message-Id: <20211110101129.462357-1-huqihang@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To KU1PR02MB2536.apcprd02.prod.outlook.com
 (2603:1096:802:22::12)
MIME-Version: 1.0
Received: from localhost.localdomain (58.252.5.71) by HK2PR04CA0047.apcprd04.prod.outlook.com (2603:1096:202:14::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 10:11:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7d537c-4639-4097-129e-08d9a4327bb1
X-MS-TrafficTypeDiagnostic: KU1PR02MB2390:
X-Microsoft-Antispam-PRVS: <KU1PR02MB2390F6A319CF793BD4DB56D5B0939@KU1PR02MB2390.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGHYCYufBbcb1XKuWqt2PcwJfAbrijcBkFmKbGqCGjWyqp88o6mt9vMCEqdKbFf5CmMGpG4wPtzSAhL+E2ODwwWS/B/ptNtQuUFi8gWQYNmZqCUZtezzLjenbBqwNL7rAvAHYmhCJXgPSSk/BHNI3rY+7zI/H5uNpgE2Hch+f/y6rYt51gb4NMjWRPj+wz9r0TczDFLh4uPCP5SOWw44PR4ucDwTm4kkE/GuZEbDpDYPGBU6oD8Jxv8LAhDesZnfcPAFwWd9atlXjmEtF6TS1QdPad2N18NnSdWLFFovNFiQZrkqOaryQmRb2hx78YLy2vsJwEbKNXats6c/NjJ0Y+jUG2McykaKQ5MJB4VXkPYTPoIjNxaMb4GHQqilFYX/zSKHyE/wnCLcqpyWklq192xdElEEB8tlK9bpQIlg1kkYkp4TUA5DbsNeJmmPPB0H5EWMt1GD+33b0HX4/N2PSCBRCLSA+dM25IvOKJYafBDYRS39a8S5P0a+BhexNFLks7U7qyBfb65kG7lsVuDsOthX66wGdhzqT2BsXE73HU4vxKCTlYVzG8my9YF4WBHTt3M25dLLFjHo6hUvAacFTyQ/jq4A8Kie0i1j18RvnyIe8VG1OtJ3gOOSwqzDnupeUfUJXL3dS1FkHNTK0SA1WXbodnoJtcZ1xN+0stF5itdk4Bw5CI6Yau3PsQNw95oQfGmer0uHpOZ8LP+KirBSA8PJ0GwiXD5YYL5r6XNHpcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(83380400001)(38100700002)(66556008)(66946007)(66476007)(508600001)(956004)(2616005)(8936002)(107886003)(6666004)(4326008)(26005)(1076003)(6506007)(2906002)(52116002)(186003)(86362001)(36756003)(5660300002)(8676002)(316002)(6486002)(6512007)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+pAENdC0b7QeSu95EBPk1LUk0jcQ76cD5lVp6KFA8IxZ4wfkLX42wHhzBkbf?=
 =?us-ascii?Q?/wSQSISp0DcI4YXp52WcVHMDVaFTfbiyT6gMXDtjvKzJVXqUn+abx4wMraUZ?=
 =?us-ascii?Q?rzOdEUw9u1kJ2bAA3hyVWFLCq2sp2c6eKfUHG191gzFmnMka5ND2oqRwTw7l?=
 =?us-ascii?Q?BM6V8n4U0nssYYh1vNC2KFcKyqmY1UIe1UgnyOF9BZ6zZNJTuDq0zDoVJT/T?=
 =?us-ascii?Q?ppeldRXts+S46/ormbeG89m+ZUmQRT3aHpwnCxFod9T6EzjyNVSW/8NqRZQx?=
 =?us-ascii?Q?3UV65QTa4Xt7/WalMGLAeVsG86SmlKBUzQu8TGy+26X53duerwEEJEh/TXZC?=
 =?us-ascii?Q?hacebZfpFHNEj46Me4pkLu4ZfeRxA0s1TSE6ZxrjidGr7f0b0TIKJodnhXgj?=
 =?us-ascii?Q?J+1DgQ11WuImBYxORFphQkjf4nZ9leOvfL5SMByBbguQKUWT5zxOF2RzG8uo?=
 =?us-ascii?Q?h2SFFWmxTPNY3N4cXipCVTAl0dXQwx4ioyZDY4ntRi6UA3DDLCI+yK4p/jmd?=
 =?us-ascii?Q?ybpm09T80tgCJRKsg+rC5JdwEhEM+zVtdS1ux6gHB0wRmzW+zzVwkRA4nOF2?=
 =?us-ascii?Q?Ah/hwQjHJRFfAbs5EMqQziPY1iPalstWXzX9bwVFVB9tL+dFNkWLWtlyYfRV?=
 =?us-ascii?Q?6kEm4WLYJnvp5Ao4CpyIHKlZv9noHXJKVEAhN+QHMUXI+1uT6XnI+VRJg1ku?=
 =?us-ascii?Q?Xm2mF+dKpOkUoo9f344lDEn0GDtwRGTF88/qUqPjwhER1CHsfcNsFfh6eFH+?=
 =?us-ascii?Q?TEgoOnClo58memw+vYDj6ftzDT4UWUaNSSeE9WTATyrtyTgCCYrVR1nBYjal?=
 =?us-ascii?Q?Vuq1F/uQu8XZxGfoLnEY9t6I6vL/7PNhe001Af4JwA96Qua+SbmDMgTgaR0J?=
 =?us-ascii?Q?pPzuT0A/RuIW3/ho8Mj4AiB7YbBU6O4SF8N7JSTCr3F1bzmmUaQIklb+NS+o?=
 =?us-ascii?Q?Y/93ZbjgulQtMaPNqeefuXymW11G/nTlDAI8f/6j5uNWXJkUS45akocBcl/R?=
 =?us-ascii?Q?uPta72bNoI9oqRb9zm/ErEZv/QnPB27mB0gZ2bhDX0KvKzgeyPNn8VxviswD?=
 =?us-ascii?Q?idYYZh/hvY7z7Hk/0eXPpEoAX/YCmVgwL9ZiHaajUCZqgLIZnhDcxhEUUpab?=
 =?us-ascii?Q?Og4CE3AL5vbHHjVBl/h46n47361Ayw5GMtDGFwUDbUa4GbSkVYsClikrjnVf?=
 =?us-ascii?Q?lB5VT/k+9++X1+yGREA9aKHr6GBS7RjC8r0UvVH13CFwT0aEwCDhQRkyOYS0?=
 =?us-ascii?Q?jkZmNTN7+Kwe8itp1qOt5xWvdRchHDL9KLxvAGopLkPECFKCeqK4nYoOf0Ny?=
 =?us-ascii?Q?FZI4nzxkMpVcNBlZXiBI7x/L0kERDyPISWMQjmMWNB4WzBiMjdrRZeIUe61D?=
 =?us-ascii?Q?FbOwI15SITGRDJZ7HCOC5gYT1QN3XEaVYOwUhj6XY59sGWblT44IjwkkVXCK?=
 =?us-ascii?Q?KXGhDDEAzVmKI3phVhqJldPpBU3ny6L5IjIxqPeUL2icc4ElreNHzQ9di8lr?=
 =?us-ascii?Q?0rGwgU7Tf4lhFbOo1W2RKtIz7HLoUF4V4Wb/BKu+ZsjZZtwj/x9IfWSNJN69?=
 =?us-ascii?Q?AZB2HO3WPQJmc3NdE2M/HYnQ0/N5bF3u00/lboN19/A8uLcNhhbJH7qxLMhA?=
 =?us-ascii?Q?BfuvCb75od0VD+dCe04A+ig=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7d537c-4639-4097-129e-08d9a4327bb1
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 10:11:38.3096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgoMedzx8mqTsjEcOF3SdK4vx2jY2xBhbiRpaY/BirOusJ7zzImPg0a6XYgvXDP28YA2Ks1VP6xYML/ZGcTIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR02MB2390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the config_ep_by_speed_and_alt function, select the corresponding
descriptor through g->speed. But some legacy or not well designed
function drivers may not support the corresponding speed. So, we can
directly display warnings instead of causing kernel panic. At the
same time, it indicates the reasons in warning message.

Signed-off-by: Qihang Hu <huqihang@oppo.com>
---
Changes in v4:
-Change commit log

Changes in v3:
-Change commit log
-Delete extra blank lines
-Modify 'incomplete_desc' to bool type

Changes in v2:
-Add warning message
---
 drivers/usb/gadget/composite.c | 39 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 72a9797dbbae..cb9c7edf9bbf 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -159,6 +159,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 	int want_comp_desc = 0;
 
 	struct usb_descriptor_header **d_spd; /* cursor for speed desc */
+	struct usb_composite_dev *cdev;
+	bool incomplete_desc = false;
 
 	if (!g || !f || !_ep)
 		return -EIO;
@@ -167,28 +169,43 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 	switch (g->speed) {
 	case USB_SPEED_SUPER_PLUS:
 		if (gadget_is_superspeed_plus(g)) {
-			speed_desc = f->ssp_descriptors;
-			want_comp_desc = 1;
-			break;
+			if (f->ssp_descriptors) {
+				speed_desc = f->ssp_descriptors;
+				want_comp_desc = 1;
+				break;
+			}
+			incomplete_desc = true;
 		}
 		fallthrough;
 	case USB_SPEED_SUPER:
 		if (gadget_is_superspeed(g)) {
-			speed_desc = f->ss_descriptors;
-			want_comp_desc = 1;
-			break;
+			if (f->ss_descriptors) {
+				speed_desc = f->ss_descriptors;
+				want_comp_desc = 1;
+				break;
+			}
+			incomplete_desc = true;
 		}
 		fallthrough;
 	case USB_SPEED_HIGH:
 		if (gadget_is_dualspeed(g)) {
-			speed_desc = f->hs_descriptors;
-			break;
+			if (f->hs_descriptors) {
+				speed_desc = f->hs_descriptors;
+				break;
+			}
+			incomplete_desc = true;
 		}
 		fallthrough;
 	default:
 		speed_desc = f->fs_descriptors;
 	}
 
+	cdev = get_gadget_data(g);
+	if (incomplete_desc)
+		WARNING(cdev,
+			"%s doesn't hold the descriptors for current speed\n",
+			f->name);
+
 	/* find correct alternate setting descriptor */
 	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
 		int_desc = (struct usb_interface_descriptor *)*d_spd;
@@ -244,12 +261,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 			_ep->maxburst = comp_desc->bMaxBurst + 1;
 			break;
 		default:
-			if (comp_desc->bMaxBurst != 0) {
-				struct usb_composite_dev *cdev;
-
-				cdev = get_gadget_data(g);
+			if (comp_desc->bMaxBurst != 0)
 				ERROR(cdev, "ep0 bMaxBurst must be 0\n");
-			}
 			_ep->maxburst = 1;
 			break;
 		}
-- 
2.25.1

