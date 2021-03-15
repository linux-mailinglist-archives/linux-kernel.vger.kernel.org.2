Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9D33B303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCOMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:44:52 -0400
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:6349
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhCOMo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwTMVZB1YeKd4JjdQu6JOTBr9Njzj1RX2salErx7r1/4Wis6tt9+iJ9OxCaxUletb2zCp3maG0jV8R9vNUhR9EA9Lz+AYySyYyOtsT5I/cN26Q5Er2AZ2JWfid1rhH7m8ZrvCIup2X5OlbTVpojHqkjdAiw4y1mu84EgZ6qlnB9emaTCLDd2vbThjc0Uk6CMMz2j8/M5AeA+I8eU0f7Ri9pfeMs0eClShUG931vLOMEWzSVH2cNNzQzx5iDg/1QSkNaYT38y50d/Gqeh8TvyP51VvCAEHdmiQ9/hxnjCquWYd9Tvyw6ljvdd6bTSJrVR0Mty7UponSt8urI/ltx60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arjh0DHu4B+iH+LBtY6oIJz4X5LwdNg10NJQ8iDnZQ0=;
 b=FkILI/0YXoTF8bGPAOzRZ65+0fUyNJvyVmba7yW6P03h1TezoL5AsFWmpDwRgValWWhhUzpw4fK+HqMR90zFiUpbZtiwqGDhN11dB6b868PEV0MMHPPsICEc+9X7T+UvW+HfV0SbdkA95dXPw5jjykZf23mPQcRfwtOlXFUtrps5cE08QEQLwDbNxCtFKCTGB8Y9DZlgl7FheXDezeusb4xAmuYqi2r2TNzmGGuUgJFr7UJY0tPcEVWnx0/KUu7bh+ukBH+6RhQYhCBs3T/E14moe+2/gZAK1CHmbamQa6efvdbk12B8hhzq6U6gM/fo4Ke6yVatr9qxn80sBPDAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arjh0DHu4B+iH+LBtY6oIJz4X5LwdNg10NJQ8iDnZQ0=;
 b=jctYIV2Xok4r+e/jov55LhfwcK+u9VrUYB7hrQnO1ddIwTvOnMvLqvRF9Vu8TfmxMeWawipKkOrnuWu/zE42kYYRS+cqXX/fWrcR6SfQzgE7X85XjgcaTDWhDtCvI8SFjCZ+49RjsknEVi44VZZL9evNF1bUsSdy+ylnjjVLoEg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3554.apcprd03.prod.outlook.com (2603:1096:203:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Mon, 15 Mar
 2021 12:44:24 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 12:44:24 +0000
Date:   Mon, 15 Mar 2021 20:44:19 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usbip: tools: add usage of device mode in usbip_list.c
Message-ID: <YE9Wo8QZ/0XU8Mzq@Sun>
References: <YE9Vyrs+Z8MusjDM@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9Vyrs+Z8MusjDM@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: HK2PR04CA0087.apcprd04.prod.outlook.com
 (2603:1096:202:15::31) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by HK2PR04CA0087.apcprd04.prod.outlook.com (2603:1096:202:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 12:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa974c9-ca91-4438-46c6-08d8e7b00fc1
X-MS-TrafficTypeDiagnostic: HK0PR03MB3554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB3554E20115B0899F3EDC15CCBC6C9@HK0PR03MB3554.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CYvskFLKWPfvPXkCA8qVqWVBiylv9urwT+l9RM02HjPc9uLrO29UvISQ9ObRiRhSXNZypTSzN6UWYo/C2ePwEmMwDnC2/tcEW+RczqKdIwgdeqztCaOFC+CF5JgW0r5NI/cVfWWU16lgXtkxkgZF3aCG35JAQ1N6qMAzyTzqLFzUqecaY8n5qSftTNe1OojM3gu3pbro91/vnH0hwgFVap6mN6SJz+x1Iq4LEKlQb0Q7T+acg5O+Wvq0dB8uKElvXiAj7LNq0/qf4rJZsO5JOAy6/lkFbKEW42sUhy+5qEROiTDaP1cGLrK8GBWkppfPA4nZP0t+QqKf+nE74a5ggKAH+XzEzB2+e7y4m/oILE5DTn1qkjZsy7e8v/P5Orp5zFBwv07M4VEV+w1tXodJsNPRIVTWv61NBpDip1l0LNFi5DXWpG2Yua2/2txxyhS/3Ee495mGQzmMd58XomvMYLnjhMoRfTb0vJeyrE+gg4L7mNi7szKFjYigoGD6PBmqix9ftKQXi9WuO3Rq6CHsvEFprRJQIgKwWXweC3GWlV2PjJtom/piIVos6x1ww5WADL50J2LwYyClHChQIUHbI2AXqaMHtcjvnzP3pZVHq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(346002)(39830400003)(396003)(376002)(136003)(5660300002)(4326008)(316002)(110136005)(83380400001)(6666004)(786003)(2906002)(4744005)(6486002)(8936002)(16526019)(186003)(86362001)(33716001)(52116002)(6496006)(478600001)(8676002)(66556008)(66946007)(66476007)(9686003)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XLzjA6TWsRkoUYimw+QkcEHzD1YOthNse33S4BJrZdAGkYcJZ8eu1rkg7a4K?=
 =?us-ascii?Q?gGZtaGOQBTGfK82R775R6oauNn+VjATF8RZoLLqXjhBxPb7HcaISoBbZp/S7?=
 =?us-ascii?Q?RecMnH29TTmXRYbIyUyHIXQG0omcRf1TDydmKaJqrGKRaj2bmxaKk95EJQNn?=
 =?us-ascii?Q?bHPN1cJw/09bjk7CRLSLobEcX+idM2Be1rqW8CVZeEoRpUaCULzdCEh3wyqw?=
 =?us-ascii?Q?V6yivgVOTWnRE9KkGTPd4+gE+hpyLWJP+WgjvjYj6wjn+Z63Sflvea7Fdn8P?=
 =?us-ascii?Q?3TwYq4K8jxZAZbfJs5aRlMzYrJKlrvCo1clh/SeeHnk1OtIREnrMi7Bft98W?=
 =?us-ascii?Q?ZX3rVJ5ZkEsXhOBz3sgv01AMbyMZlsSkZyo1S4E9RhuqZaW3whnLewRcGEEg?=
 =?us-ascii?Q?m1he5ya7jN8NjkTjW42dvFFcKF15HS1OkWeQ1KbqO8E/HbwcUi8HsyBGP+54?=
 =?us-ascii?Q?HnFOyBdKimsBHp5te4zZG8eeqBUJ1CIiO5W99PyFd9RlZj4vsQLrK5ugfomZ?=
 =?us-ascii?Q?dmEb8pSmMmsqRefWga4zdBoPr7D3RkYmixA0QVpvshorAALbF5zT0fc+creJ?=
 =?us-ascii?Q?TKuAtjk9rspYTCY7tw4KqeEAXbmeOshh4dgKGoqxDrKh0YAtskYvlBtiTe+g?=
 =?us-ascii?Q?yYb8HorZFQdBYJpWhFADaJcT4z2CoOTxzuAkBFyZLVdq5pBQdbNHV55Yt9+J?=
 =?us-ascii?Q?RRubfuuGE6cmKko3Q2mpvSNUvGWnJr2DDSlLLUNougiqo2l2Y/J4UVDn+p2E?=
 =?us-ascii?Q?v/ZV0o4mD1Lyo5Kpxcwu1qGis7QSo9QAJCt66f7I69j4n5EgwVFAks1PYNOK?=
 =?us-ascii?Q?vcSZz89JIZYOkdlsOjhPY39cPjccSORKFS0/nIefVcPeG1fZDzPFEIOQVBoc?=
 =?us-ascii?Q?K4LNXbhAGXKooBkfqa+RxXIO5glisX+YhzIiRgtFOG5p0NfsVHu0GQq4kzKY?=
 =?us-ascii?Q?YVOg2Y8+zt7SRSnKiwydIsLN/3ES9+3BcURK2ehRrG8dG/3yY5hedBxyDYdx?=
 =?us-ascii?Q?beLwkIKfLe12wuBcKnOMvv+bC3sZMxwVDiMcFGHdfdgCykAibQlT5iNCZyAX?=
 =?us-ascii?Q?zXzy/A8WHQ4HTwix9VxM4GJPxQftxgZ78hzr04S8xLAiMrCpkhJZW0rKOGnV?=
 =?us-ascii?Q?1b3wYRj72erDdTA+V7lTIUyDQ89/TP9+oE588eICahcLZYr+hbHhcoKdBv/+?=
 =?us-ascii?Q?SymDsaYHjed4Xv16sx6MyWdnLkc0Gk1rRpow77vIsT3k+C/N2wlcGqJNIK6K?=
 =?us-ascii?Q?vnBl/NjZLBeraLJvhlLHIMknjC6qkhxokTOWVfT3Nu94hRf2I1bp2vIBdTO7?=
 =?us-ascii?Q?SijHcw1Z3mR0XpEOrdzQrM8mMELuOZZT8f7HGaQ6D92XPw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa974c9-ca91-4438-46c6-08d8e7b00fc1
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:44:24.2501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5NQpNX/u521FEp2QyRrxFPR9V8mUEM+1R0rw5udfRvheXxf08RV1D6P5roLLsjJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3554
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option '-d/--device' was implemented in 'usbip list' but not
shown in usage. Hence this commit adds this option to usage.
---
 tools/usb/usbip/src/usbip_list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/src/usbip_list.c b/tools/usb/usbip/src/usbip_list.c
index 8625b0f514ee..3d810bcca02f 100644
--- a/tools/usb/usbip/src/usbip_list.c
+++ b/tools/usb/usbip/src/usbip_list.c
@@ -33,7 +33,8 @@ static const char usbip_list_usage_string[] =
 	"usbip list [-p|--parsable] <args>\n"
 	"    -p, --parsable         Parsable list format\n"
 	"    -r, --remote=<host>    List the exportable USB devices on <host>\n"
-	"    -l, --local            List the local USB devices\n";
+	"    -l, --local            List the local USB devices\n"
+	"    -d, --device           List the local USB gadgets bound to usbip-vudc\n";
 
 void usbip_list_usage(void)
 {
-- 
2.30.1

