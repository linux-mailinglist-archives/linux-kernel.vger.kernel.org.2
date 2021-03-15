Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AF33B3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCONQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:16:32 -0400
Received: from mail-eopbgr1320107.outbound.protection.outlook.com ([40.107.132.107]:45806
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231308AbhCONQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:16:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSDqiEVt8UwKHvzKCC9l+lE031lGhhUQpyKG0VgIMH2ZvewV0D/MPbBiwL5XQibJvi8Fogjcck8CIh4RHtaGh2pY+4xfAxiLcFWS5vO3OczYY4Ma2c5dkYSjXFcpGR8soH1OHN29CGkBfhBMJgP9jJ6wfFcxBJ4X345n2OQJv7NPJaB4ACvBCRhCgo+hG715AIrgYRSlq5eatYTRe/t7wEvvT14iV0R+TJTUH+HcH43/xwa02vXUZBm4GnSMveDdUfRgO/OutQmD05G3RRjrcD8PoBA/5y+nil4sPyqfVJoJNrphcfjMxg8evSeUatETKZRCRP0wyyZAJdhYS9xO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1US6AxnB33GRpq/aZ09YGep9gsm+usomAEZJwfnVrDs=;
 b=HBrz+zmitqBjI5EW2jAPILPvmgcjRvAhCIKKJA2iiZAARb5FJ1od1ZTkJdChgtJWrfDPf8+2li1RN86yTULi41stTPYeOqv+ir3/WwcX2+EtVKKidoDbiaKUUnmBdUd2T1E8w4ygxux/1ItPvneqApVyXjnaCSGiLvXcK9fBOJpvFe3kP52zpGZj1qqZLwjcFFfnvpZGqkvZM3e78UB7u2mzX69In1lpkvGg2FZFDx/uABgjHb8uqAPYuYKJ+YSchLVwkEnUX1rkYdVD5RqtvBrz/oibsOG36L0cbWQpToy1Xu3LiaHaP3LYL11v6r7f8U4+/2eXUo9io1ZtDuyoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tsinghuau.onmicrosoft.com; s=selector1-tsinghuau-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1US6AxnB33GRpq/aZ09YGep9gsm+usomAEZJwfnVrDs=;
 b=bQoY0s1RmwU2aLgqRMrQAMLKSWXQXjyDvz8j9VLlze312iAUaPgS+gYrq8S/JW0ONh2g0e2Kh8moubzrl1vuNJdcSiMQxxAgMIHEEc0nIAylj3yiqfZ0/rlZKhBHXVj0XmPMArlAqSui0bmpexViZegYk/Kwcmwbhp3KP/DJE7o=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=zenithal.me;
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10)
 by HK0PR03MB3795.apcprd03.prod.outlook.com (2603:1096:203:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11; Mon, 15 Mar
 2021 13:16:11 +0000
Received: from HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05]) by HK0PR03MB3795.apcprd03.prod.outlook.com
 ([fe80::8492:e28e:e777:6d05%6]) with mapi id 15.20.3955.011; Mon, 15 Mar 2021
 13:16:11 +0000
Date:   Mon, 15 Mar 2021 21:16:08 +0800
From:   "Hongren Zheng (Zenithal)" <i@zenithal.me>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matt mooney <mfm@muteddisk.com>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usbip: tools: add usage of device mode in usbip_list.c
Message-ID: <YE9eGOCU7vJJQ6D5@Sun>
References: <YE9Vyrs+Z8MusjDM@Sun>
 <YE9Wo8QZ/0XU8Mzq@Sun>
 <YE9dbrWjL5DZ8Hm8@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9dbrWjL5DZ8Hm8@Sun>
X-Operating-System: Linux Sun 5.10.19-1-lts
X-Mailer: Mutt 2.0.5 (da5e3282) (2021-01-21)
X-Originating-IP: [2402:f000:6:6009::11]
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HK0PR03MB3795.apcprd03.prod.outlook.com
 (2603:1096:203:3c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2402:f000:6:6009::11) by HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 13:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 490fd711-6e3c-4d29-84a0-08d8e7b48091
X-MS-TrafficTypeDiagnostic: HK0PR03MB3795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR03MB3795528CC136665A07C8F001BC6C9@HK0PR03MB3795.apcprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wuv5d0FLNlnxxUhdWB9Hbebzj1NO2vrTEb8ID2r9GHGuIbibGvynXU5UjvEHC0kyUztWEuNy6+KdsQhFz1HdMxNjw7GQHnMul/XFWBLR5QWGkO0MkG6pkqr8sjBV0A2aol3B2TvJDgiyL2dcIMrLL93/WDdK2pbIhCnlfXxi2NCWoLuSYH93kkpSDWJZlgjfKMwkeFKLbIimkIhFKHtfPS/5ULM3SRPE/h7nbaf74/CZ4ROOjqho2HFBxAXIR6PXgu5pu5/9MhU+SS+vKq7YpUmjlwV9muxhSWoZf1g3g/+TrHvCQLeLgivUm60PcZyRA1Pdfi4k4ho9zdJZzvRhFSQjz830lseGsLfPn6cDXroiTogkhQuKWBzk8pneEwEJJeEQtbWw27aL3M1RBXdkJnQGUsA58uPBRhz0KdER9FvJDBLNu/CfEqvX0NeGHbMSfsd3w6gbUJeos4xQjwoMMVAV251/kHo5oP1OrPPcijcVkmFUlhHKZx/B+Tdl1iwal0MZ8s73eoJu11lMoaVX3XomBsryEtTw1fEwMxX8XJuktmaG93vUIi5jJFFDn8GPAkDS+dOwrqXzmwaOuI5uiGaMXXvPvufGUD6dl1yXNiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39830400003)(376002)(136003)(396003)(366004)(346002)(9686003)(6486002)(4744005)(186003)(4326008)(86362001)(5660300002)(2906002)(6496006)(52116002)(16526019)(8936002)(66946007)(83380400001)(478600001)(66556008)(8676002)(316002)(110136005)(33716001)(66476007)(786003)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ew2OzLRV2Nj0gVXBR6zk+iAvGHc/X0yS7ZUkWSFz5yTgzHfQ/vS57KCo2Shr?=
 =?us-ascii?Q?kGCiVH9z+UtcXxr0Rby6piZRbAp9OBCOSb5lbasSz1g5pFTfcOEd3G/fW7St?=
 =?us-ascii?Q?mXWdoJbWGu3SVnPtFQLyBE2k2GN1nDwW/avsMUmtEOn34Twee4ZLsAYIz27v?=
 =?us-ascii?Q?ZVw+YQPRAsuI3uUN1dIy+4b/hdBqvnCIOoiEqAkmmY5wUwNjHJk55e7he/n9?=
 =?us-ascii?Q?/Yqqxv530okD83HbYG8psGiTxKkqTQ5x0qs2fHMns8qzF8k66+fy9j0lo6Oq?=
 =?us-ascii?Q?+olQFAznBzGY3meIuZKiPONmpf/T42iNmUFbDcthCxUHURrSklMK9Cbg5yDl?=
 =?us-ascii?Q?ue2xDEUb0BYLDpDhd178BDl5htKqomBzBbRaBaOUi981n02EbiASQOZgbGFW?=
 =?us-ascii?Q?YslTSbyRz8CBJgaEd8n1xaeeph2e0TuUrlb/+IcsWb3j8MymLS/cHXXa+pXh?=
 =?us-ascii?Q?o0xgLHrdy7+pA6rNw6ZVFAb9k9sLEBkKxLypgIU2HjnBlcFPrJnk3l5K4KdE?=
 =?us-ascii?Q?FxAKjUGZ3t8FyRbd+44qbQ9XMllAN1rX9fogPRtnn9YBKQ3Ux7nYGr86/Zkd?=
 =?us-ascii?Q?BToF+wgowxMDM3C7HSv4PPFBMS0HpwKFKuvLz60Y7XJwUhUGp5gLd/p0n5g7?=
 =?us-ascii?Q?6/xnsMnDZaOc6jdsv+lvOG4dgH0eKo9C38wlb+pMVJxJSpG+MhVbgNBcu2lH?=
 =?us-ascii?Q?zHxcWGIockswcRN/vDMYHS+XiEaRdBU6OXwHwQB8O/h4t8Xytw1gOKYH5qF6?=
 =?us-ascii?Q?fWQNVczAnO1G8p/Xgki/MPhpyj8gB2BLKWj0M7TzbqblQZqxws1rMGw9uCHt?=
 =?us-ascii?Q?U83hSEfbWEV1I7lP7BLEgZc948PPBLazzAcYET56cPlr4nwmokA4Bus4x2pv?=
 =?us-ascii?Q?srKgRzplbESNvwLqAOe8S+0FnXusPrCchYkcsWgmDojCVj5cp6UCL1mQwzLp?=
 =?us-ascii?Q?A6ObNIe8Dpewfz8K8IfdkR4fcPgosZ6+lNRi7p41Gum7qyzOZZg3flE1MBLy?=
 =?us-ascii?Q?ATKiz5yJcEsvV+zdJfoW1b2Y5QNlKE6ianFUB+zZOUVxaXYAr6y1RzLvlVXg?=
 =?us-ascii?Q?VAPEQ7QdlkECrMT5ovBkJdEn3j9uNCoqNAE1OPNLDdFZ4Q7+J643uOQYfDjB?=
 =?us-ascii?Q?kLzuKe3Jq98lDfkWC4aNwzquQfPm+sesWZBmcmb4/DlxA82D0jHddswezHO1?=
 =?us-ascii?Q?K49MY4JyD9HwPPkejU4fsw8aKOjEC+LQZ7bVwb/JqDKhyJxvm4AF3s3i+JZa?=
 =?us-ascii?Q?Q25EzzDAv9we1W6xE7A1Cv8hqZwVDQca7C2aq7tdJVtvDi0p8PU6d2gr7QJ+?=
 =?us-ascii?Q?HPDVb6aD6FeYx+YzUQ6I2DCzS580qQhvVrqeKCRLqZYpdw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 490fd711-6e3c-4d29-84a0-08d8e7b48091
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 13:16:11.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL4Jtn7L9wot2KgTh9fYgs0wcqtavhVRuiOQfP0QGpXPKtP2RZkoM5dV8DgcXzRH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option '-d/--device' was implemented in 'usbip list' but not
shown in usage. Hence this commit adds this option to usage.

PATCH v2:
Add signed-off-by line

Signed-off-by: "Hongren Zheng (Zenithal)" <i@zenithal.me>
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

