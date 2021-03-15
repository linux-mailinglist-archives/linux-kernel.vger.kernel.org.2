Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC6F33C7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhCOUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:42:39 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:23194
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230423AbhCOUmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asPLilE8U8IhOfl+1j1Ed64oGkbHo+SeVR1UAHUXaQbeqE98AmF3JkWEFsb54RY/q9+PzQh8shuvxP8lS43fZam2yy4QWtj6KQ9OKhNRx+7HRzdJqMDMaNwlrAvR/FYPgfZQXxSvxL24fpDod3BmK8jd5vr2EVNLc0x5qfjUddngrzFgJ5WMxR3sIf+Co2sATlS3akS8tj0bU5OCQ4FQjjsoz7jYyDToLvNw4rzY96PynY4swwx5bQZZaNbPbSPkgu3i9SQp/BIEIUu2pQ6k7ektP0AzPetxjEie5j6FYJ2IwLEfEg07F2i7sFGgUvGBYCzuyimHDogFzO7UID7Niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiRCKO3dsR4/XXD0+YTzkQ0KxQ6gkdAohAnE/L8rUB0=;
 b=O8crq3bUsxTDC8oDcxbzUf3BMFPnX4zLTUpTX0oy6pgrysDuXBZ4nWF470wVm6LLL+Aqk5I0VQtl2071ZfaiAGnpUxwsfroV4GGmzUz/6iCqH44TV7IMU7WOtwiJKE8SJ9/V9jB/obAe2bmI5MMBAGNS70iyTrQyiUCM4Ko8rU3+GMxZAUnibthXy4+8VwL2Y3sPuCdzJu/fYzkVxCQOQ/g7jggsgxphGbl6eR5SFYxfv1EcoSE2+SUnvsOuCTRcAm+fq4FbGflSsnCmHDWtmCTLPXph/vv5lOJEn6HP4NAdFioEAMMG+cjz2rDdCk/8wEtUqi4VrUZ4rI1L15VNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiRCKO3dsR4/XXD0+YTzkQ0KxQ6gkdAohAnE/L8rUB0=;
 b=p/CqYam2glAAW+VnBHo0Tp2bZubugOrgqj6YLjxPTs9Mg31xRNtAIhxzj5utsMJxuChova3SAeVoEryU3fvQxXohjNE88ep9Xab2JzUzernut6nOhRVIcdeUsCnfP9khBq5DiJnGjpSzwmaW6av5Gj9OsBlCAIbUxGvwNm/OcPA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3282.apcprd03.prod.outlook.com (2603:1096:203:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.13; Mon, 15 Mar
 2021 20:41:55 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 20:41:55 +0000
Date:   Tue, 16 Mar 2021 04:41:46 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] usbip: tools: add usage of device mode in usbip_list.c
Message-ID: <YE/GivuHyW1Ol3xP@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE/FaQxejKplWwyL@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: SJ0PR03CA0314.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::19) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by SJ0PR03CA0314.namprd03.prod.outlook.com (2603:10b6:a03:39d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 20:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0886f24c-22e1-472e-bf61-08d8e7f2c5a3
X-MS-TrafficTypeDiagnostic: HK0PR03MB3282:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB328276D468FFC7298B6218F2BC6C9@HK0PR03MB3282.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTpEXORP/Qff5Hn/WbUXGhueRSnivlUy8QPqiZ41lb5kC2Tj/tUqgVE5SYI99RnAs5eoZ/G2B5abBuOuohWyWWpDlt0uyuwfVT07RK7Vly3DlOyVkudaVHm7ItW3lwtgQ+Yu8etv5+/DaB5+QTULiwk8cOFYMRhpgiI4Bl5RKtW9isSZomdkZxR+VyCsyIszjqctFSTEjBfMBj29Qbg5EKksmmTitzA0jSWvWMUhSiXM9id0/B8r13QVTfB6ZmkzeweEHJw0uyZdHTYMUkjXKBTc5Z4BWV7PNmdMQBOyppMsJOEhznDxxkUDToJp7Mr+vjN9ZHTl508wjYpX7xGX3EF9381esORnmXgaeh7D8H3YRmrkbs22H++kBASFxkLnpQBoK5UIIooS6vOZZ9lVohQ2KKcJDVeeRcShiiGaF3nBPPQzpnM7ao4bN3AQFAarBG1fXIvK67iagSA7MBDVqOgORYJc9CkxGuCOHW96qB55L/a6XGWhLie60wjjkJ0chy+wVG0JWABGK7JlcAiEoD2VEUKLAas7nyoP4HabJHEnE4ER7e5AFHqratPgvZeO58U2+sNiNhXoH7EUhl3JDTHy9l1pAgu0o1fMKDEdRwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39830400003)(396003)(376002)(366004)(136003)(346002)(4744005)(16526019)(66476007)(4326008)(6666004)(5660300002)(52116002)(2906002)(9686003)(110136005)(33716001)(316002)(83380400001)(86362001)(8936002)(478600001)(786003)(66946007)(66556008)(8676002)(6496006)(186003)(6486002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qG3HeTZMe1NDX1U0Y0p1MvHwkx01OCOGsu59Yi52WkJKInly6FR2WjwiYH07?=
 =?us-ascii?Q?eO/adCe1nOa/myC1yQ0NqRlTh1RvcFaxl0Z2QiEi1EESeHUQMPWw2j/guY7V?=
 =?us-ascii?Q?63mA0lWuaNho06zVhdhZgK3S5VhxLW6G/ZzoJUudRi4qIoUvVecwzVD8KwcV?=
 =?us-ascii?Q?GDPJXtEHTrPJ+e0d85MV3HClAAMyBTjzIN+CIoqt1gOGtBxXC6hwni2sPijg?=
 =?us-ascii?Q?ZCE/3BCPUa6bLtvJAvRdet0LI6nTq+ajzIZfZ5z6/RJNqWogR3Q2Xj5hvEsX?=
 =?us-ascii?Q?aeGeLaeu5wT9ax0W17nFHt6dAxdSd+Xg5yXQxGuHht7BnEocmKH/tdc8MhgA?=
 =?us-ascii?Q?Md5HG2dxeppKUghK7z7HZzCrCkTPBX9oRS3AVMQ7PJrNUO59f02iexMfRgkj?=
 =?us-ascii?Q?RcKW74dmLQsRjruBGs55y+NBirEijQyOpLVLqqmevG7qRnyTKhqPP5PwLAvx?=
 =?us-ascii?Q?qi9VGN22hdhaV7MqTgr52/sLYuDJngdZofoaY97bAoo85xB3t/r2hDSna8nt?=
 =?us-ascii?Q?gTemW/ncbNEhkNoBFp7pkN4vqOUTVFkrbESwY8Bqmemz8FuSSEvt5om8CZVW?=
 =?us-ascii?Q?mHrePYeUs3t6kzPBePpDlAq3mE6k8ekSBy73cg6urXdRGlwwcbulBeYpEiBe?=
 =?us-ascii?Q?AwGZyu05qPbcUbPYt8VQ1PcK6j6U2SxsWRoDfrkk+85jIoMN11+Vbyt/J4Jk?=
 =?us-ascii?Q?8yqKnIKy4YkDIGuFWAQfSFhANP1YQ5Wv1myOZIxVAJHK6V69zAeI8pE5gxqc?=
 =?us-ascii?Q?lYqH85o4IDtkorOBHxV3geq6Q8ctmz1+i1W5meZq+wQ5PKd7aJJ062Mw+Bhc?=
 =?us-ascii?Q?OlNNMOYiD1OQVViu77vor7pJSczDy8vysd4Q/s15vE2PSQmdnvd/OuOJBSvg?=
 =?us-ascii?Q?KK81QgeaPUPkbgA8yM/R32F/Q3Ut9ZUwwYTywhl+yc5Wja8e0W54G5mAuNcX?=
 =?us-ascii?Q?DYBg+xkKAI+1tyGMra2sfbkSmTbksMpdvpJphc10L1m2TfZdkn+iiQT60ZPV?=
 =?us-ascii?Q?uiifbBE110V0AoP/m0+EqSWaM6EgTbPoqhJWNQfn3Pai/CfX0Je9u5jRNfLm?=
 =?us-ascii?Q?DRMfdlvMkU2yhf35TPl9XnuiGV06LMZBhNP2gnqMkw/niJvBP5coF25chxH5?=
 =?us-ascii?Q?Y22tM6PRSprFuNPQj1TMstSOAfm/AYmVZBTorHa1Rbgh5KNy+v/oCOSrS+qo?=
 =?us-ascii?Q?Ce9VOBr2XKG8BmxaMy7rj3oO4lFW7FNWQmsg458j4X3kNoMmKD2xts+ZOOZt?=
 =?us-ascii?Q?ezFEp1u/+TDOaVa3a4+NMGEnl6xqUV6X29pGQXqoowDSR9+lqkCPn46uRDr5?=
 =?us-ascii?Q?Nti4B3pJJlIOoH688iGaUjlc5f27gdtu/uKSzc7QxHGfRw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 0886f24c-22e1-472e-bf61-08d8e7f2c5a3
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 20:41:55.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry15aAo0g5p1RRZ7PM9XBYudlXFmOu8hEYmcvuN+P19k42dVZrVCSU/QJkIK/VYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option '-d/--device' was implemented in 'usbip list' but not
shown in usage. Hence this commit adds this option to usage.

Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 tools/usb/usbip/src/usbip_list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

PATCH v2:
    Add signed-off-by line

PATCH v3:
    Move patch changelog after the marker line
    Remove nickname in signed-off-by line

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

