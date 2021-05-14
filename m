Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9375138140E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhENXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:06:36 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com ([40.107.15.135]:26606
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230371AbhENXG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:06:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTgw3UKz84QUTZTRyKv71y5XuFR/fZZqxzKx2m7WrPYQxfQZ6hoeIq9zrIFWzFkQL4OJbMC1eB59GV1zjrFW7sdvVCtVSeargYEvWRByL04NS5QEMV34tmM0d8jBDF1Ogt/Iim4+diG8XSC4SqQHGVjHmrJaX1zdhRseCANGsW1dF53wiFhXi7XWkYdaodxgTI5OlMr1SANNmCUN67Tib5+zqNykw7uI41i7QNv4/CiRdDUkyTs58HpLmQuitmQu4mIIesBUK7jcWRpewf6xLbCLEn2FUKJ5eq6UxOW7dus6k9qYEt4MGZ+HJFPQNvHkrM9i2A6rQ8GX5sXNPUd4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLj2UnzjpxQSPa9QTq8kUmfi7+FNx2bkZAmUWfkhnzc=;
 b=LWeT/EWdibomDaVRBO8nOojo3Tw8KARIx2N5V8NU2h6dsYOmCrNWbqG0LottQYq3JZ7f8ZEupbcRKsevolrgoRbkHBKu4+IlW8Pp2z5BrN8Lbr02sYhGkY9x3vVDigQvbyPZnLyKVvK83HRNjbhlZjjLJ6VaOa8KUd035tS9Ij11yStguPMw2+rOe2ThjTs6RttkmCt2zxsiNt4BvouGL84ut9e/3cBjuwh2NoTN+lZhbzypSNGdvjVMhl9qzEqD3fdsQbAIsH2OdDoBEd7bk+sa1e7E65ra4RyWXN73YKe36o3orYcN9HV/AZq234Y+615kaRxFg5H103Ix8yBiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=isep.ipp.pt; dmarc=pass action=none header.from=isep.ipp.pt;
 dkim=pass header.d=isep.ipp.pt; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=myisepipp.onmicrosoft.com; s=selector2-myisepipp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLj2UnzjpxQSPa9QTq8kUmfi7+FNx2bkZAmUWfkhnzc=;
 b=sw22+IA01wi/4+AS9XZPHUjPpE6ZDeMG/B+W3nKXmiPn71CP5nRLIRL3rYao3v6Qr96w8mK0CfuHnwdePB7YMpnEgzcVMV7sieVqyiqmcPMNnDRs2mjxSbE2FRmzF67nD6EsyFycY3X3qekaCxUUOYpZTOwB70cAAxlEZtavqkQ=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=isep.ipp.pt;
Received: from AM6PR04MB4823.eurprd04.prod.outlook.com (2603:10a6:20b:10::27)
 by AM6PR04MB5783.eurprd04.prod.outlook.com (2603:10a6:20b:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 23:05:14 +0000
Received: from AM6PR04MB4823.eurprd04.prod.outlook.com
 ([fe80::3c5a:27ef:fda1:1530]) by AM6PR04MB4823.eurprd04.prod.outlook.com
 ([fe80::3c5a:27ef:fda1:1530%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 23:05:14 +0000
From:   clrrm@isep.ipp.pt
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A1udio=20Maia?= <clrrm@isep.ipp.pt>
Subject: [PATCH] staging: rtl8192u: Fix variable shadowing warning
Date:   Sat, 15 May 2021 00:04:59 +0100
Message-Id: <20210514230459.15752-1-clrrm@isep.ipp.pt>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2001:818:eb48:b500:fb6a:ad7e:1216:96b9]
X-ClientProxiedBy: PR0P264CA0185.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::29) To AM6PR04MB4823.eurprd04.prod.outlook.com
 (2603:10a6:20b:10::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hyperion.lan (2001:818:eb48:b500:fb6a:ad7e:1216:96b9) by PR0P264CA0185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 23:05:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2373ef72-2651-42b3-bc90-08d9172cbbae
X-MS-TrafficTypeDiagnostic: AM6PR04MB5783:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5783E8195599598BBA84B78BFA509@AM6PR04MB5783.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12Sh5xjk8F+D37gyj0OCcXJfhFTaWZa1WUMbfMoMvJz8hWohsvEKqjAjXOia+bekM9Ee+hx1az8A2AHJglxqwC7thac3zxo70X94CJqLw0+76bJ1YVVFsx0OBi2nUhTRp/Nr5/pttGAgs4XsCwmYl65XaEJtcvlg0B6eDoA2BZ/+ka6gzYAFJEgUWLbbDuUXc8ucJ/Bot6YzKoeDIgTvSMS/DvLjC/Qs03CUtppc5tsxVFPi8iBjvXenQSB8J7aXUyYhcIz3BfrYgri0yNKp6WU7KHYt8eNNqY3JTTs1uf7fGtsVnXVWsEChl50d5aRI2fQhIyWfoTIrMgErYhmt8GbNGBCsIiuKmbRD9W5lv5sstwV7uYOLMsdmrBdi6nJ7tCaiRRMNiYSHAwY7itmrwcrwHgObXdYXD52y8seKXKRsZPQ7+8bvIBgtoiwt0Alql08umicJ1bdWbwEr2DwIMogXWmVzxm2k0pESpN4ftI7Nye5BcZWEjoJAoCYSEAW3pZZlcuQvYaGL2Njlq4LejO5zyrZHaiC9evPHFwaKOUbBUCSqhICLU2bMRL1gVgRNwRfN6vgKIneaWFivWW5/eu6+uPQBgs6aT4rMk3FKB9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4823.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39840400004)(376002)(366004)(66556008)(2616005)(316002)(107886003)(66476007)(786003)(6486002)(66946007)(52116002)(8936002)(5660300002)(8886007)(6506007)(8676002)(4326008)(1076003)(478600001)(6916009)(86362001)(6666004)(2906002)(38100700002)(6512007)(83380400001)(9686003)(66574015)(16526019)(186003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDM1dTJodjhLSk1majlnUm5Lc1M2d1I4ZkpoZnZ6UXAxTE1nbUNZREk4VzJp?=
 =?utf-8?B?Szl5Y1N5dHY5bFIyUTJXWHIxQ2M5MEN0TTE1T3hCWDlnV2REdEhLMGlaSStN?=
 =?utf-8?B?RHFNMFBkajJGTXlXREhaMXNVNzJQUStHSDJQa3puNDFrS0kyTktGUjZUYXJX?=
 =?utf-8?B?djdKdnlCNjJZVXBqa0lUcVNDd2xLQ2l2RU96UndOOCtVWXo3bEMxTWNYU09D?=
 =?utf-8?B?YlZuZjBBMExFWVM4L3lrbUNhSFVvdFNvVHZYd1d6UkVyeXk5TDhKNkRNMnBO?=
 =?utf-8?B?QW9uUUdoaXJRbUZ6a3ZZMXVlWjd1RkxlalJUMGdTNFNCbElCeCtKa25qczlp?=
 =?utf-8?B?UmFXWlJZcDFvTzYxT2lxaUMyd3ZZYkRUaHhPcWdMR2tSbDhhU21NS3JnTkwv?=
 =?utf-8?B?MjVBcXVUQ3NtdC9SaE5iVUR2TWVydXU2V2xxdDZlNmZCbjdQY3c2WTZDVDdu?=
 =?utf-8?B?UERpRlg4ajRjNW8vYVZxRlowQTNzNlZ2WDZqTWU0SE5sYTlQN1hSNUh1ajVU?=
 =?utf-8?B?WmZaVUxPV2ZveGJic2hMNFhLTmlyUkFVZnVudEJEWlI0eGJRcS9CcW9GNi9y?=
 =?utf-8?B?Wlp1MjZuMzBGWVcxa0pEakhVR3RteGxzR3lkREw0eG1uMjV2MFRWdkxkMmd4?=
 =?utf-8?B?SmVXTXZUVHQyTkdVU1dvNmVvMjZMSXgrbDFXOEduZ2lPZWdSV0Vya1cwY0ZZ?=
 =?utf-8?B?N3pIdnlTWHoraDlEUGpYUnR5dUtFejZLeWtyTW1YNU1WYnpRdU5NVzNVSzNS?=
 =?utf-8?B?bFlaM2xRYjRTTVY0V0REazZvSDlISFprVVg3NzVlTUtXMkhvZ2pqQTB1bzBK?=
 =?utf-8?B?S08yaE9tKzlqSGFFbHhDZE5qSHFzaU9MdEpjRnRBUno2c05lTC8xY0JJWlZi?=
 =?utf-8?B?VkM2OS93U3pRK0cxa1RGODF5Mzc4Y2dVaDg5V2wwdjJKQU9LNGhYMHVWak9x?=
 =?utf-8?B?blJkRDVDMHBiUVFLMzcxV0cvdXhIN1RXUnVRbHhJQVhzMDRqMWVmV1V2SzR2?=
 =?utf-8?B?RDFWRURnOFVKajhNcEZCNXRmVGR0SHU2ODBSUEVWaS83T24yWjNIWWNXNnJy?=
 =?utf-8?B?ZXRWZDhJcDNmR2hBWU9udFlJVjJSeWw0Z0IwTzZyMXVyd1o5VVUvWEpiMmtj?=
 =?utf-8?B?RmVteUE5OE1nd0diMmZxYXMxamxpUHNUdWtvb3J1Qmd5VGtTYlRXTkVBTjI1?=
 =?utf-8?B?Q0tzc1hoYWdJRWJFeVdoVDd4S1pzUkYzZ0xnMGwrS3drWHBsK21iV21tVllq?=
 =?utf-8?B?YTJxUFJveGxkYTJhdW84WFFydmhlWVJ3TitXYW54UkdhaWN2bVN4MzhndENR?=
 =?utf-8?B?UE9qQ2hjb3J0WnNkNlFzUm9IV1dpMDVHU2tURWp1YkF1Wis4SXFFcjhzcCtI?=
 =?utf-8?B?T1MzaXE0TE1iY294aHF6K01OdkdPNWp1WDJYYmZWalczK0VkbzdXSkN1eExX?=
 =?utf-8?B?cmwzWG9YcUFhNEIxcXRkRTVXM3hMbEtvRVlwT1RtMU54YTVxaHBuVEtjUWsw?=
 =?utf-8?B?TDJiRk9JRHE1VVptempEeUNvazZNOHVzTkFlSXBuN1NVM0EwTHJpRjNkakgv?=
 =?utf-8?B?WEU1bGNjczJpRVk1MUc1ZmVwYXNEcEI5U0RibnFibXE2ZXVuNXVJK2NrdGxP?=
 =?utf-8?B?YWhpdVdYTnN2Z2FLVFpNd1YyT0hxelNpQmRlSndGM0R4QVBBVTcxRWdnWHNt?=
 =?utf-8?B?NFRFdk1Mbk9jcHM3NVRmSHFESWJ2b1NLeEt4NXhhbHpsdE1GQVdoWWZRdHdv?=
 =?utf-8?B?dEFiZXcrYkNCVkZJQldwcjBUbFpiVDRWS1pHVktZUC9PVEEvcWluZ1dGd3cw?=
 =?utf-8?B?L2FqcUdWWVpsQnZVdllUeUtRSnNYRENmeEVHNDRFbENmNHZOK0ZwNTVsbUQ0?=
 =?utf-8?Q?x3bp4piFuBY3j?=
X-OriginatorOrg: isep.ipp.pt
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373ef72-2651-42b3-bc90-08d9172cbbae
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4823.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 23:05:14.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a60a629-e61f-430c-9c63-266653b2b899
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTtmaHTYJcIt8QVIS2j8zJO3HG6pLvvt7p2sgPL24JSZT6xHO526Kqn2Q0fz5umxhLmX9phD9y4toKCS5HiATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5783
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cláudio Maia <clrrm@isep.ipp.pt>

Fixes the following sparse warnings:

drivers/staging/rtl8192u/r8192U_core.c:2306:21: warning: symbol 'i' shadows an earlier one
drivers/staging/rtl8192u/r8192U_core.c:2254:13: originally declared here
drivers/staging/rtl8192u/r8192U_core.c:2371:29: warning: symbol 'i' shadows an earlier one
drivers/staging/rtl8192u/r8192U_core.c:2254:13: originally declared here

Signed-off-by: Cláudio Maia <clrrm@isep.ipp.pt>
---
 drivers/staging/rtl8192u/r8192U_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 932b942ca1f3..db26edeccea6 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2303,8 +2303,6 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 	/* set channelplan from eeprom */
 	priv->ChannelPlan = priv->eeprom_ChannelPlan;
 	if (bLoad_From_EEPOM) {
-		int i;
-
 		for (i = 0; i < 6; i += 2) {
 			ret = eprom_read(dev, (u16)((EEPROM_NODE_ADDRESS_BYTE_0 + i) >> 1));
 			if (ret < 0)
@@ -2368,8 +2366,6 @@ static int rtl8192_read_eeprom_info(struct net_device *dev)
 			priv->EEPROM_Def_Ver = 1;
 		RT_TRACE(COMP_EPROM, "EEPROM_DEF_VER:%d\n", priv->EEPROM_Def_Ver);
 		if (priv->EEPROM_Def_Ver == 0) { /* old eeprom definition */
-			int i;
-
 			if (bLoad_From_EEPOM) {
 				ret = eprom_read(dev, (EEPROM_TX_PW_INDEX_CCK >> 1));
 				if (ret < 0)
-- 
2.17.1

