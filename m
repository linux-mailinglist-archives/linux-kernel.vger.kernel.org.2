Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2211F44625A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhKEKvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:51:38 -0400
Received: from mail-eopbgr1310087.outbound.protection.outlook.com ([40.107.131.87]:62144
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230003AbhKEKvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTN9OexH4/ZyQ5lPUGEMp8x71lVNDnzLkmmMp7QH2eRWCg0GapkNk4rsb7adBKCSuhSE5BpYI8K9xFoQkBIM76CW118UxaROF6HMuvVduOXFBC7od0Kk3GEiI7QNT/+3LmHoIrhzU3M4M8pc4nOvZy82jYUpWLuVH/732ZdQxzFUhFYFXMXHY9d9QbdtqCfCeCZoqDIeamVzNbivv2/0twPr5Fa1vI7XI2LeT3oXw3cWf8jzSdu1XtcRpynxjmhqXf/sqEFS2dE2X8JGaG25Zfd2AAon5nlabqB8VdNyoPu8CUWFKlUkhSZcPmmVXsqjti75Hpf/B/PsW69kPa3PBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nK6os3UMZWfNl0Osr+kzUfqs+PhpfpaZ4udEVWMkPJU=;
 b=gzzmYOXdzz4Xguuo7evy8e7qS3cb/dFS7B4lXDFRdL2H9XB+k8i3Dp6FstFI/b0zG4/e6T4UdmVIgtXqMfO70qfqttZ+il4VxSoVrNPA8pFzeT8ZAMS6qH+gpiR7XlFOQTGaZPJHSewur5ulT/Q9/scBda//o7W/3N9BA4CA1nInL31eKycKe61e3ZlWicQ7slnZFXlUJsopjXJPxsGtaIz/4zjVjuOZ2uuGybNaj5Cb2L8AO/bZZFrdcGJBNrHLVBQhc0yf3JFt12M29HlCeNl0jhAWZyUkD/WIWAxqtpdWvinTEAxbNwzRetS+Rh/RsALwbRJlMFKjy/xWWW1uGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nK6os3UMZWfNl0Osr+kzUfqs+PhpfpaZ4udEVWMkPJU=;
 b=YOoCADV70IcMcxWPARcpfh7B0YI4AWbjcAkAZ5L2eXhJ7Je0bUNdoE6vKACwTCM2F+wRSOYdVme8Qe2hOPgK9an5WnPkUXp89pvh5SzXypRAQbqKL49U25eG1xSGFhxP4W2xaoC41eyAf2RNPJrv7czX9cgmvTMLI5vq5jJAnpw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KL1PR02MB5186.apcprd02.prod.outlook.com (2603:1096:820:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 5 Nov
 2021 10:48:51 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 10:48:51 +0000
From:   Qihang Hu <huqihang@oppo.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qihang Hu <huqihang@oppo.com>
Subject: [PATCH v2] usb: gadget: composite: Fix null pointer exception
Date:   Fri,  5 Nov 2021 18:48:40 +0800
Message-Id: <20211105104840.159533-1-huqihang@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To KU1PR02MB2536.apcprd02.prod.outlook.com
 (2603:1096:802:22::12)
MIME-Version: 1.0
Received: from localhost.localdomain (58.255.79.103) by HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.1 via Frontend Transport; Fri, 5 Nov 2021 10:48:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07899ad8-ebdc-43bd-534e-08d9a049dae8
X-MS-TrafficTypeDiagnostic: KL1PR02MB5186:
X-Microsoft-Antispam-PRVS: <KL1PR02MB51868B35F0CD8EC5AF8C4497B08E9@KL1PR02MB5186.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 102dhH0NFJTpKLbunV0Ft+V3PA802yOWiH8GXvjfnTpTN3CM4bexAckICd7PTYzkmxymAgxPM1PTCelykFuRJf4pyiBGVIIX0WriWL4TzTQFSgai5sghY2rEZgolhRh23Fp+/TRwHUpYnULF6VP32Oyc7sglsxOjtzmwJgc1QmBXa81jj83Rg1xzBJ+5HNdEnFpAsUHz2Ph6E0Cg8S+hXxyW5UvhhawT0zKahmAk7R5wrgSwpRD6tUp0Xi8DspVY4NBzBGhEjZ57JC/KO6dLZz8Qccw3UGaQzBy4jIMhhaqXREn9roD+gj7irkZ+zJcT1Zxrs3NfrpFpq7uK0YnMDap4zBxG/U+JyMjfPzhlYO3zB23HYi1oKeazZDJW5KgySxCqOCT/NnMoxlc0vxCX7QIV2PEz2Ou9Cyu38/Z4hU7y70YV2ws2sPDhfHtxpwGVeqfzXcQqCaI1s7dqXITX4dC9lMt/I8rYEmjg3ZYNBKh5ttDzZot6rQAjJxTmP2tgHRNlY7CymqtYbD2rs5xj+728VumBmLHlx884NQCUxtgrxyHojcTn8DYavnNwR8CyvZ5sxxWLaO1sVV/Unw7rUFeCtkz6lA+lNAAIW8Mqm2qZr7+2AmuZtS68R9T5m/JiyV6p94CDOaTOfG8LN/yGsJMbuuGBLLL3k40v5kVyZcOqAauHh0sxmYDQ3Snc7XgPgfUtrcMIJPbwvF2S25Wt7DCr9h/HGNrXaoNT6sh0Ttg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(8936002)(66476007)(5660300002)(2616005)(186003)(6486002)(66556008)(2906002)(4326008)(6666004)(508600001)(26005)(6506007)(86362001)(66946007)(83380400001)(36756003)(52116002)(107886003)(316002)(1076003)(8676002)(38100700002)(38350700002)(6512007)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oMRBAjgAjdkfF+exmdMJf35K0i7rEDvL+UpzDJKZ04DDl9y84QXPvtqSpPl0?=
 =?us-ascii?Q?+zwcIMiO8ZK8nypVpyQAvOOaNgI7KcK/11IuA61yptOF6yQxoZzm9h2S+loL?=
 =?us-ascii?Q?uAfJPLyZfmGsPH/7n6NEYkCm0A/Ry8pdctL2Y/EvccXnpuY2d0OV20k28Wau?=
 =?us-ascii?Q?eLYzPAItK0VXIGE6hF1Re4cowB/ZJ/o00PIXchJocBe26e3Al2BvyOYqcHbc?=
 =?us-ascii?Q?MKDH4iIwrZ4a1i3IbXzroqtAJDjnH47ymWcDPw5R7qxp99cUXofuxbWQcw+I?=
 =?us-ascii?Q?B1cnsWSENpdXxGp0J3cKy2Hp7V7RdP4PpG7r7hilyrIaxEUGiNxSNl/TVqIJ?=
 =?us-ascii?Q?cSsC289FCG7a5oyFGc16nKKTGVLe4DRnc9WQs53oq5Uy50xyLxuygje4Q7ZO?=
 =?us-ascii?Q?cKSTHXCotkJPlzkw3PTwi7MSiton+Cl07TVqJEYRORh7jfdjGGTYp0VFrcz/?=
 =?us-ascii?Q?joiUGbGuJMAdvmbbHLHURlXDhvp/9Lw8sJ0PyDzu27ZEEU042MmKUipN8o6s?=
 =?us-ascii?Q?+yjMbhH4TWoG43RDVWRJtWoCnIMrDw4ZvIGWo8Tb2hBDIoKKl3YBXXQsM8fT?=
 =?us-ascii?Q?ZWzThTSnSoRWTvRfgPoJGqFfndmnXp+RtuoUY0tFjt6P+dRoJBcUpxWt5wib?=
 =?us-ascii?Q?T41iVK9AlOdUbs2C6gAwlQc2DIk85W0LOcx6rtPh/rbvBM7e8oe0xU9behV5?=
 =?us-ascii?Q?ITuiusoEDX6PUHG5jLP+Qzgny3VhxxSe88ywvQVfX792TtnZuk8YorX/TU7q?=
 =?us-ascii?Q?rydCJV37qPlQBQM7ynZRMtc9jCnLQwvEIToVuXqtVScwRv/I542It+K/N1Lq?=
 =?us-ascii?Q?eqWUfoQW0M4xMe7SecDu+3X7AmO6Sb58Q1D1JtYn3bg0gdU6surZXPfukg9I?=
 =?us-ascii?Q?uVVqZ0KF6VM2yDdz0Zj6sfyXwdVeHCiVwq2hiuuw9NEOTWQCK3k1UkXilzQ6?=
 =?us-ascii?Q?sCd5ExVNDFTNh+PvhnuDJOvbIrIaWPLFkuCRpztEbRkHVF3yOQwUSKuimWkx?=
 =?us-ascii?Q?cXhje69ju9eBXD758v5Q6sSzM4gW6PWg8+UtKBqW+p5ujpJYFVgXx1W3KJic?=
 =?us-ascii?Q?6nX4n6G+nhooyxvwMdRT+u7znuryYzmG4yQdL153H9F+P1pBfMjkhn15sdf3?=
 =?us-ascii?Q?s4ty7+f4zYqamhxpxytgokij0e/WKKcJcli9K1/m6Z5p7doeqGbMHwmSHsl3?=
 =?us-ascii?Q?O64Ru/3+SP9mLBBZ92BLCyfXg6OTxUqtEWTks5sqxyIHDBctQ8F0+XmTmmaH?=
 =?us-ascii?Q?c7Xvi607O5k/g3gOhuiTA256yUZljcvIHo3lDUr3WU5o83Tpq4aqdJo9vdPE?=
 =?us-ascii?Q?8h1Pg+eHlOBG0+ZXD+94UQi3y8dkW7bpG0Q4j6+08PbeYPo3kp0P7cAl867i?=
 =?us-ascii?Q?aaCUDuZSXhciAXO/qH2PrTa+z5j/WKmxDAGRY6GWrNyWdBxyyIk6tbeZf1Vt?=
 =?us-ascii?Q?95XfgbLmoFb5pDM4TLcfTokDPTY5NukvOeeGfc6FMgJmLx/9ylAYljEqrk4S?=
 =?us-ascii?Q?OWFWxMWffysyR54I4tk1JQND41AKgSy/cfEE8+KM/guQYapRQJ0sLbaZIPTE?=
 =?us-ascii?Q?xftNwhy43KjxWEpfbF6QRrP1UQo5F2Q0ZUKZ+GgfXIE6IicQ+0LIdbyg131h?=
 =?us-ascii?Q?b7FPkKa2aeYG1dVdspZycN0=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07899ad8-ebdc-43bd-534e-08d9a049dae8
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 10:48:51.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEcC1APNJokesGizOv3ngfclj6OI+rNpb+K5EZcIcKsqEWzJ1vVwh37cQEPW881E2Cla/Si5yEIXcnFnZ1TzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5186
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the config_ep_by_speed_and_alt function, select the corresponding
descriptor through g->speed, but the function driver may not
support the corresponding speed. So, we need to check whether the
function driver provides the corresponding speed descriptor when
selecting the descriptor.

[  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
[  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
[  237.712487]  kUnable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  237.712493]  kMem abort info:
[  237.712498]  k  ESR = 0x96000006
[  237.712504]  k  EC = 0x25: DABT (current EL), IL = 32 bits
[  237.712510]  k  SET = 0, FnV = 0
[  237.712515]  k  EA = 0, S1PTW = 0
[  237.712520]  kData abort info:
[  237.712525]  k  ISV = 0, ISS = 0x00000006
[  237.712530]  k  CM = 0, WnR = 0
[  237.712536]  kuser pgtable: 4k pages, 39-bit VAs, pgdp=000000020ef29000
[  237.712541]  k[0000000000000000] pgd=000000020ef2a003, pud=000000020ef2a003, pmd=0000000000000000
[  237.712554]  kInternal error: Oops: 96000006 [#1] PREEMPT SMP
[  237.722067]  kSkip md ftrace buffer dump for: 0x1609e0
[  237.787037]  kWorkqueue: dwc_wq dwc3_bh_work.cfi_jt
[  237.854922]  kpstate: 60c00085 (nZCv daIf +PAN +UAO)
[  237.863165]  kpc : config_ep_by_speed_and_alt+0x90/0x308
[  237.871766]  klr : audio_set_alt+0x54/0x78
[  237.879108]  ksp : ffffffc0104839e0

Signed-off-by: Qihang Hu <huqihang@oppo.com>
---
Changes in v2:
-Add warning message
---
 drivers/usb/gadget/composite.c | 40 +++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 72a9797dbbae..746b34cf0310 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -160,6 +160,9 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 
 	struct usb_descriptor_header **d_spd; /* cursor for speed desc */
 
+	struct usb_composite_dev *cdev;
+	int incomplete_desc = 0;
+
 	if (!g || !f || !_ep)
 		return -EIO;
 
@@ -167,28 +170,43 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
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
+			incomplete_desc = 1;
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
+			incomplete_desc = 1;
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
+			incomplete_desc = 1;
 		}
 		fallthrough;
 	default:
 		speed_desc = f->fs_descriptors;
 	}
 
+	cdev = get_gadget_data(g);
+	if (incomplete_desc != 0)
+		WARNING(cdev,
+			"%s doesn't hold the descriptors for current speed\n",
+			f->name);
+
 	/* find correct alternate setting descriptor */
 	for_each_desc(speed_desc, d_spd, USB_DT_INTERFACE) {
 		int_desc = (struct usb_interface_descriptor *)*d_spd;
@@ -244,12 +262,8 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
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

