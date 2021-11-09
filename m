Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E0D44AB59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbhKIKWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:22:41 -0500
Received: from mail-eopbgr1300059.outbound.protection.outlook.com ([40.107.130.59]:31613
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239572AbhKIKWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeURL/OPaDZA5ENZ/mVDZosCJizUL+93A414DbWwGKST9XxD2yq85W96w7Xg4YdWSaeOfHy9zunFTKnr5JZXHtaRQWqK5bA324O6v9mZlghxDMSTMjYhfL0EaiGYGVznkUtQGRALcFlluUE9J4IDKxgs1zdpHDFU0cOnnzA3MTsJHoG64ia7gSPfwVpU+qSRZ+L49OuIEQ1MsduRTZecbmhzGictoTM9R9KynzOIHUuxebKEJrzlnbg3FMV45UbsJKJlTbph1gEGK7o9ZmYPCsKKNx5mXxX+q9gG2sXTUQ92kUEn0fv6hLmE6hp4n2n1oiQNHutUEdV2EPzbDEJMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhuaVjy0tnudU3n5uWF+HUvyCWUZDcref036B4bVZvo=;
 b=QR7QgZMf6VQA/VUTKIIPEDn9p45UGIlQlTDPwvl69xZLxfq/w+1rK1hAoTzaUQVImGUiwvWOygozIb32SO7cxiaDFWXV1z+YhK2+YiYUkPTQhkk87XX5+rPpxAQK56oc7Ts7n56arcbUKs8v4qVpO6BMl4xHpKLLfxspVVrgLVwwQZknurhFy3IV+vrLXhauRWiZc3eQlMvl37JAZLqUbCDxdltuKllGZlUo+CFGdJODBS0pbjUCEQlta1UQdQTTjIaEn5pzKSuhAYkvNwcHvAVt28YDi/5az854vNg4KrX0v/xl/dcDPw1fkimufCRix1RGTn/vTsw9t+mcflfQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhuaVjy0tnudU3n5uWF+HUvyCWUZDcref036B4bVZvo=;
 b=YEBoCfkg1sgQiSZMdzgOMXzNKvBWANz0CbUPBtp1d/ZmsnIz9qSWTmHaj2CAPO0iiXUDpCGktTVG/8/A+ajEJDWH0peUN7+LEQuuYaDMG/sJHbNTcFEeEjNut5zqMF+FV7tJbcyRtgmZ1QN9XBKv9aycpYLzfYlMisqraKW+rxY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KL1PR02MB5219.apcprd02.prod.outlook.com (2603:1096:820:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 10:19:48 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 10:19:48 +0000
From:   Qihang Hu <huqihang@oppo.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qihang Hu <huqihang@oppo.com>
Subject: [PATCH v3] usb: gadget: composite: Show warning if function driver's descriptors are incomplete.
Date:   Tue,  9 Nov 2021 18:19:36 +0800
Message-Id: <20211109101936.397503-1-huqihang@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To KU1PR02MB2536.apcprd02.prod.outlook.com
 (2603:1096:802:22::12)
MIME-Version: 1.0
Received: from localhost.localdomain (58.252.5.71) by HK2PR0302CA0024.apcprd03.prod.outlook.com (2603:1096:202::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.8 via Frontend Transport; Tue, 9 Nov 2021 10:19:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69705f4a-948e-4ef8-4668-08d9a36a7575
X-MS-TrafficTypeDiagnostic: KL1PR02MB5219:
X-Microsoft-Antispam-PRVS: <KL1PR02MB52195CA606877C0CB4280971B0929@KL1PR02MB5219.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9d2T738o4ySzZaSoBy1qZUkLX2mPV/y87O7qcLc3gHrk5MW6SNDo0X7bZU2tLSUeq1VEEIG4kku1YLIEjuH948d85YdWIUooPJ5fDYqaoDrDmthoY6/KLFeUSO95MIuWbgh3izQIcamvFFsIaK31GoLdAU1VFG5p6FC0aUjFXbbT75juRAHDZj3wSIK7b8O3SD/pyz/I7swVxavS3x+T2o5FqmIl4dzpyXe0iWePt5Bnk+BO0k0UuRQfnFOaM3uKAcTD9e1xfBZNwz3qu1ijbaP70z+pE0hwuFUOVE741gSyCP647hMntAtIKUSgwW7/FdNI5YtRgFl+1NBviAGhiqSWlM+K81qz8rGah2u3MoIxASUdzwibum/iS7ZBoh00k4JqCt+eYXnriNXKmlLY3WoRrIOG/sDZM00585fBUdUkIjoe3vRmkIWGnpN2XzpDacTmZ33PCeyqaax6Ii965mwaFQMRh4apKEBkmG/HWzz1GKzJS0wGU/r6TV+qrPpTKMy5l0B+VFEdfp4Ts2neaR0uCXV/aQe6O7T29CuBY2n2dznNOAOfQfTBe8UIgvzNHm8AyKyHFezFQU0s3r0Uh2sIL3R5dzFRk/xy7QJ1WfSQ9hApW3BcLv+V05rL1mdIKMwiY9VMKHMWdHq+nJLSqBvvosWqjwu1pktneBEoTReGh1vNTK7ZON3g3pF97gjx/BI4pI59QjrJmFJGEmlxD012e86Uk4lRh+y3ksuWnPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(956004)(2616005)(2906002)(6512007)(66946007)(26005)(186003)(83380400001)(36756003)(6666004)(4326008)(52116002)(6506007)(5660300002)(6486002)(8936002)(316002)(1076003)(38100700002)(508600001)(66476007)(66556008)(8676002)(86362001)(38350700002)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sr433Gt4EtLsu5oROd0+49ib/9GyImFWPxS2E9ZeaGfLAy9WrNijOUX0k38T?=
 =?us-ascii?Q?hc4D8eS/CGOajDDeiYtSfobTQnxGVjl7KflaJ4VX/H3250PM7o+az2k/ICWz?=
 =?us-ascii?Q?e78r7irrw/PNDW9cxSmr6USq0T74hHI7Mdyn1YgW9g8o/b0zEJdlkXCZIb+r?=
 =?us-ascii?Q?6aRqNUm5G1Vet4dSEZusQGFJjGUyzSTm13ViiSkN5WjUd3rZc3FeMCMitJDi?=
 =?us-ascii?Q?5l72itTwm+jBKnk1JHVqYmjfDIyOGUnAOa9rdTyilB+cl8ImElc+TqlqvHpD?=
 =?us-ascii?Q?VU3ug1GbccNPR2BaqS4Y038TQJFFKIZvxBPRVDk6XAI0e50QtprVJmpLeA04?=
 =?us-ascii?Q?ZO0dtasAQ5xavjDCcq2LXGZyQWuwTPfjiA0D252y/qn3s3w6Yj0ylDO5kVgT?=
 =?us-ascii?Q?6pPUHZIobf6cHmW6YysDQSowgH+a7XtODn1TmfG4nUHnMG8quQMvVy/Hh/kf?=
 =?us-ascii?Q?o6O2HEQBlhNI+MCkRnf5xKHFLWmkAbuAQ9+mVNIUfplm6fmALPfCxGwNENUb?=
 =?us-ascii?Q?Rtk64sltggqG8p9XTwtcEyd28P/QiO54xD+3gyl5YuW4zoABL4EvGdKXphQ/?=
 =?us-ascii?Q?D1Wui3QDJmFLjColn9M0NDknDALh4tl7PlVSNT6W7qMN41kS6zQZX8+SjXRa?=
 =?us-ascii?Q?U7s/keYAvqJSHqi9zRVue7RJuHWBNh5ivZC3fPzOhy4E3PGj/9kq108moxG6?=
 =?us-ascii?Q?0XtOoHUiO5flAQ3UC07igqQ1DSQ/3goyK1sQU9HIrQAz1U+7xqBOK/E4KWoK?=
 =?us-ascii?Q?PjoIFj9drEMKIePAhmR843prU4LGajQlKJPYO8F5e8xq5CqbAjPXBWFyxEZ9?=
 =?us-ascii?Q?9sS4h8Ox597KaWdhcq+yHuEkqdE+jcVhMlaXzRL1Z4QGMUDg3/JoYwmDu/1S?=
 =?us-ascii?Q?OBdShsxhbu8k++CA5Od/YhkWH0ANMBOdw7jNNLK6sM0s2UainNp0ZSe69YHW?=
 =?us-ascii?Q?Ee0kVMVhCVzuL/svi1RH+eq3WugVrU/hc4pXhtdzPZU6yYPc1lhJYuyMtAf6?=
 =?us-ascii?Q?Ae78C9CaEDVuT0OKwvOD/NRlhF02+BlZQLAKP6lswl6D9+XaOEvc/gaLa4uT?=
 =?us-ascii?Q?NWZ0lSyJ8gd0Yf5m74x8KBP//nn6wvbMufT3QYYYo28CukZ/q+S0bvIE8yPk?=
 =?us-ascii?Q?+prr/nQRQ95Lv+VqIiJ4AfRBfvU7fdek2r6Yp/z9naGGfsl94t67DmYrFOld?=
 =?us-ascii?Q?OSnoXlHUq2MXuntQbeKHiCH8RTzlHj2r6DhJQDWNl+p4LITV6K306n0lnEap?=
 =?us-ascii?Q?hOZ+c+q7tQotSub8PzYlfTNZhQWyOonvnTRYibofPHm3idECEvVY2kZ2/c1E?=
 =?us-ascii?Q?gzONSwXya6FgC683dUDlUB8JJ3ur5RrnukJZ2XWEtSIWLDBBinPjyfai6FzH?=
 =?us-ascii?Q?j4dMkPdwFKDJDcJc75w4MQXhzqPnG+c8+XUZ/8kcn5/eZ8/1zsl3fXm7S9dz?=
 =?us-ascii?Q?WiqXBULQ2pfiHzUUV+C1ob/cRft8yZjP7PANJ/lLzEdzLktV0jh5UJ8GOmrs?=
 =?us-ascii?Q?9p0qhEXb8rUmxSZ9CRjSognyHzOPI9lv9VakjH3hEjx0i2JFP13cemH7yTeY?=
 =?us-ascii?Q?hHv7ufhAGbnx3pj4GwXDAAvdwqqX/ifqJ5TTUNJqHhY4UPEedRHtY+/vJvKb?=
 =?us-ascii?Q?7Y9jNil/KFa1/LbTtjW7Abg=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69705f4a-948e-4ef8-4668-08d9a36a7575
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 10:19:48.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0fUdTwUwzKYuce1UCKhbJHWLXx8mBoxJwVF7BoU+/n+qt67nh6AZ7jWu5p2SR2Ux5ZsS91Nz+m14GfGOHx99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB5219
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the config_ep_by_speed_and_alt function, select the corresponding
descriptor through g->speed. But some unsound function drivers may
not support the corresponding speed. So, we can directly display
warnings instead of panicking the kernel. At the same time, it
indicates a problem with the function in the warning message.

Signed-off-by: Qihang Hu <huqihang@oppo.com>
---
Changes in v2:
-Add warning message

Changes in v3:
-Change commit log
-Delete extra blank lines
-Modify 'incomplete_desc' to bool type
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

