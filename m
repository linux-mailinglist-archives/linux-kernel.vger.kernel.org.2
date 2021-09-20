Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5D412762
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhITUlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:41:12 -0400
Received: from mail-db8eur05on2135.outbound.protection.outlook.com ([40.107.20.135]:24737
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232731AbhITUjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+8lf/RZJfqla4X9GF/CbUW8uA98HIGgq72hGFv9CGSNdRihvHTqffHw5XDaivEoX/ULMrSpYTAEdfPNs2b4iaDUpnNQycedv0wnBrubOh1kCB9llBEcmgzvi9rKtERoRVCSgsRzpBM6P5HzSflZ5ElhRNz+fTHQoc0yKmVslFlkDFr53BpHqQlfDHdVaS7ILXhQQWd6raUY1+RIbR2/lFN84KnyFE2dPstIYWCq9RL4jjuiIohE3UvJNrnU5fwJxORr/s4QURikAd2xz3avMO8zHTJlTzbEPwMf1FX5VmQKdASeTuvvymGs5Yp9M4jkCl5kv1/p5mHuPMa5t+MA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F+cj+POpNjoFJCMI9cPmrZgde9cuV6SyBmRnot18Yww=;
 b=nmHq5WE/mLwj1SWS83SWDZgvhFayNL/hWDXaf2UD6m+yGmZiar3JQK7UjybwZnSWZ41pyRXNdETQZJfzWqTq2Ty4yc60WqdvGiLR4CoyN3cvdV1ypc2pD7FS5cPmfWD5dGixyYgHv4MBvv9fAG4mrK4XnyTBSRexbxVBmcBQeCQh2rkpE2mFkiYdBs66m4EhcQgUcswSvPns/wBDwJHi4QjJQuh63KZ3iEUxXIBCH5lQpq7Qjn9DwJXRRTMqCxqFb/ZF3VQOCnOOgem9LCNqOSs2xxehwMmNIT79rDW03aeoS1+NhiShpxhoXUrQeiPcl/XHh99JBMw4gNB2u3+0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+cj+POpNjoFJCMI9cPmrZgde9cuV6SyBmRnot18Yww=;
 b=SZ005dyHQ35KyhkO5SEQg4oD6EK6ycZuoE6VX64pkArptnfWIoetvLdeFxKTn5bpcPQipMPQyrfBORTelD7kd/sW8wH1FqjLib/wUGtC7CiH5gFN6vhXHv+BE+hExy01s6eZ39KkOX9yo6Qt1D38sMoNQ0JhHJHw8bchMVAtzY4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7018.eurprd02.prod.outlook.com (2603:10a6:10:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 20:37:41 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4500.019; Mon, 20 Sep 2021
 20:37:41 +0000
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH] ARM: dts: at91: tse850: the emac<->phy interface is rmii
Organization: Axentia Technologies AB
Message-ID: <ea781f5e-422f-6cbf-3cf4-d5a7bac9392d@axentia.se>
Date:   Mon, 20 Sep 2021 22:37:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::48)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by HE1P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 20:37:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9a6a7d4-38bd-4bd8-aca3-08d97c767e2f
X-MS-TrafficTypeDiagnostic: DB9PR02MB7018:
X-Microsoft-Antispam-PRVS: <DB9PR02MB701887352C780C68BE57B2AFBCA09@DB9PR02MB7018.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uASsMdZIvGlR8ZvM4fy38frsRDHf3H0m9eojz69Vmhas1rAW2th408aJSkETh+OyBpbqI9g4/XSIeicfJ2fdLP0xgr6LXIPYv1lQKlTtVbmACcQzTeG2q5B0hO/2A+gBLXpKBHzxWIMXkR1eUkl1H6yMud8LkUOCcwSwUkcaQDshRDJj6QC2tM96n02iBGHz9oY9zgtbsOx7Uf9rHCoNQ8YbaV1i9Y/yLHAOFaUoGM/Hi+E/wTwH5nG2VJpFYHtXH2mVCEwxhEWPWk003KHpqomBuBepiSgICiSyKVMBLg4pGoOjvFH0qFXCNiE/JDpdSiK57UDWcpPbDaDdhn+NuUKuOHOXm8A/S8UKKKaWNoyclkf7tWnBADfXGl1IaQ3a0ZjXOVA/zZKeVwerjd/yZ3a8xkg0MN6CmSTxq+ZpnWzGz+z5bivcOCDv29uOaDUndsaX9YJrSRCOVbannohPR00K0LOsbdk33R7iEG02Q3/bZ8AKP01gi3u9yeKvetVoO9V1dsxfsENyBx1s8aR9HW7ZKMsKBSlnza/A+hq+u/8f2luzjyk8Hb+NuK2qs+EqArHT9EReWEqETVFuAGgZ94uF2uX3WuEB5OMC1IEf95Y4GSjXBzTPq0ayZotfLwC0HSWc/Bz5VFNwv9SfwT8GPOdhc1dFK8tr55PtuYoOgxTlqpAwNvHRpylsPSkA09kBSoJLyK/ymn5WVxAgJmyxqp5MlXgNYYPbE46lsRn5LPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(346002)(376002)(366004)(396003)(38100700002)(316002)(26005)(956004)(2906002)(83380400001)(5660300002)(6486002)(4326008)(8676002)(186003)(36756003)(508600001)(2616005)(8936002)(31686004)(4744005)(66946007)(86362001)(6916009)(66476007)(54906003)(66556008)(16576012)(36916002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUwvc0Vib0hET3MweFp1VjRLSXNpeUNhdGRxWkJROVJlK0VWQlBtTTlKaVNM?=
 =?utf-8?B?REZCM09mc2Y4QzVoNzlCdlNGYTVXamxaMks5ZGZENlM3WDhqQTlFTXA3SDVZ?=
 =?utf-8?B?OG50WU00ZDdaTEdXZlh3YlVPR2d4VHc0bUxkYlR4NmNOdGRHU0dPM2sxYWo4?=
 =?utf-8?B?b29EeVFVLzU2cGlVYTZUekFXbng5RnJNdW5mbWZ6V1lMQzhGL1hzNG9oWDJB?=
 =?utf-8?B?UklxY01Xc3Q5Z0s3Z01tRi9Mcld2TVFWbFNacndMeGhBYXE5Z0dXZ1pOclhq?=
 =?utf-8?B?aHNDM0tYVDE2NmlnTG5hSmFqdm42aVZHanhRQXFwa0RmQmcveUFqVTRKUXBE?=
 =?utf-8?B?aFlxTW95ZERFUkMrQlYwY2xTM1dKZVExM3NKVE93VEozR1ZaQ3c0MTR1TkhC?=
 =?utf-8?B?Y1lhaFkrRlA1YW9Xc1hMeDN1c2FMditDYXNHRnRQZDdsUEo2T3hua3ROTlpV?=
 =?utf-8?B?M3RSb1UyTktHaHVTNmMyV3FNdmhIOHJKZDNNUGVicU5zMEx2S0lZMXlLTHk1?=
 =?utf-8?B?TFVEUEtSaVBzaTYrOFdPTXU3ekRtdzE3QjhUMEdwbWIydEw1ZXpFaDhLL0Zo?=
 =?utf-8?B?dVpVb2E4YXF4U0o4RGd0WEVuYmZWVis4eE52d1dRT2VCTzdvUm8yUmp2bmYx?=
 =?utf-8?B?TGVabE9kbWowc2kvOG13WmJ2NDJIMStrOUczamVpK1J3OGRFQnlueWc3S3NR?=
 =?utf-8?B?YXlkVEJYTjVsRjdUMHlTWXlhTSsxRENxQnlTZkFweGREWnNDRW1qNnQrb2tN?=
 =?utf-8?B?SkYrY3AzS2FHZDVrVGExMkNwWDlkWVV1OTBpcmxxUXFHTWRKNUt3b0I2a01k?=
 =?utf-8?B?Mm5vS3BiQldXdjk5NDNyT2hoNUFkcFlSZEpieGloVzl6aDBpeUxKL1U0NVRP?=
 =?utf-8?B?dm5zc0FYd0t1L0p0YVVoOExKTlVjazlhbVNLKzVKTU5LRGZSSmtXa2pZamN3?=
 =?utf-8?B?RWdaUmpROGNXWHE3Nk9uRE5CM09RN3hOdnhUbkw1ZHJtbStCbzVuc0VDejho?=
 =?utf-8?B?OVpUTFZOamJ2M2RPeVVUTWpQSUd1TXRjYzYzS01zbnIxSHZOVHo3eFNhTHBu?=
 =?utf-8?B?ZkxqUTJFcnpWc0pjV1NlWllQc3dvYURGLzBsL1NYUjdjMzliMktWZ2REdmcy?=
 =?utf-8?B?QUd0WloySGc2ZGVxWGhUSFFLL2t5bUNBM0NYenZqUk1YYVcwcWljbEsrTzRX?=
 =?utf-8?B?Ym9XMnFIU3RJZmZISUgzdWMwUDJYWXh5ajVxWnZZVEVxMTZIMmsvL0FaQXNC?=
 =?utf-8?B?MW9MMkdIZ2dTV3QxOFlBMWwxR1ZQSmp1Vms4SlROTVlyMXcyMURhWDdJSmc4?=
 =?utf-8?B?cHNjQlg0R3hpYUVCUnVpOXZ0bzNNOW9NMkZHS2txdi8vb3kwYTlYd3Y2Vkd0?=
 =?utf-8?B?dlN4OHNoMHBaTk0zaVZLTDA4Vk5xRWN4QlhJQVc1bDJrMVFsMmtwbVh4MTkx?=
 =?utf-8?B?cTd6TkZOSWM2YnNzSVlDbUoycWNzQWNwSlp4VTZYM1FucHRuejJFK3hvL2VY?=
 =?utf-8?B?blhWYWxRa1pmZHE0ZTJQM2FndEoyK0RrVU43TlVoVHJSRGZ5bkNLUjlKZDRH?=
 =?utf-8?B?QjNjUTZlWm1YMWZybTU5bjhXWG5FWkN5bjQ5bFlUMTJHV01kSFNLdDQ5Snht?=
 =?utf-8?B?OUIzYkd0UFRkNHBEWjVra2pDbjlFUEw2bG9JVmZuSnVpb05qeSt6SjNUbjZH?=
 =?utf-8?B?dlFKWStVb0ZPdnRpeXB4R3g3RUowdk1zVWRZT0t2RDcrNjNkVGFZdC8wYTJm?=
 =?utf-8?Q?8DncD9jLMWGqwaB80N+x/hsZ8xZC7xbwm5BRqW1?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a6a7d4-38bd-4bd8-aca3-08d97c767e2f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 20:37:41.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibkK8eyNGoV2m0kkVbmJG+AtMg4l11UcdaWPGpGFpr2qCY68ipPjZNUTISWxqNoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d5ff443099cdf29a34128a6440e8debd71202aaa Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>

This went unnoticed until commit 7897b071ac3b ("net: macb: convert
to phylink") which tickled the problem. The sama5d3 emac has never
been capable of rgmii, and it all just happened to work before that
commit.

Fixes: 21dd0ece34c2 ("ARM: dts: at91: add devicetree for the Axentia TSE-850")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 3ca97b47c69c..7e5c598e7e68 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -262,7 +262,7 @@
 &macb1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rmii";
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.20.1

