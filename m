Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F126230F54B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhBDOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:44:40 -0500
Received: from mail-eopbgr60093.outbound.protection.outlook.com ([40.107.6.93]:15546
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236765AbhBDOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8/9urRPFlf3/OP3j+6DMVeg2qgrwgukNwtKhZk0ggRMZJmt67Es9p026VqSqBmj5Cj97uRyDpaHko3PlwacVzrKO9/LoobnQvv8r7E6d6Nnm5GGgTrIGcI13Hp4/F4IPKzPqdSIYhYuB6/rHvjOi7vRFj/kWUP7clhG1svTectDmQbAsAEJNro7d79bxDCfs7JmDmX4WDP5DkBgYWh1cgRkbPOiQUwQhQZesFvMu/t/WF2cre5VoKtPbYjD3+tvQZrXzdF/YXgojJ0eMJ/UPQ5JC0bnJ7GpMqpsCV7ia8bp0WhK016vVdtVduSQgNH21avBiEqsS33AX/OpqLSxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDyisx5GKNuYiaZx3bcN5ZL8eCRJewgkWWNpmsbdMM4=;
 b=TVSH5c3PNnEq5zgNAtS1S+tvsL/FSmdV5+7C8Jl0uGfLeTHIN0f1dP937F0JW4xkA9oJ0u/msnG951bCsibSLe/Uz4u9ivWPZJu2Oi6MxLdp/HpvzKoD7hb3BHyD9lH8OTzE8Hz2S3c9Cn2Zdk+9kXFnEt5i9Q/GiSKeMutkudpcgdiFJBIDT+EAYNvxzBF/kigvoYkWtpHEvQ/vXDdyEPBtcseftrAW0mXSigyf0K7yza45DoJ6clw4KJ2PuFQqWarmGflWl4BOEZvNN1aAkPUki7cVjnRey2rJ+QfaY9t49veKE+9VOBzJs6awe1tINADYQhuUGM6l8XUXKHtncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDyisx5GKNuYiaZx3bcN5ZL8eCRJewgkWWNpmsbdMM4=;
 b=Yl+/k7FNvXKwdwtydeiU4qF82t9R90DS5PdXevfBiU3mxb4Kp3RZNjYgrfdnYvLhAA0SPRkv5I625TuSn8OGswWN1/Eo/OcQhcOdg2UdLQlnCXcJmE2SzVi/mmy4lpwypsgu63S5H0GxeSsP1fNpFKV5Tto7TXTzWuG99sjQ56M=
Received: from AM6P193CA0079.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::20)
 by DB9P190MB1052.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Thu, 4 Feb
 2021 14:38:08 +0000
Received: from VI1EUR04FT048.eop-eur04.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::a2) by AM6P193CA0079.outlook.office365.com
 (2603:10a6:209:88::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Thu, 4 Feb 2021 14:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; vger.kernel.org; dkim=fail (no key for
 signature) header.d=schleissheimer.de;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 VI1EUR04FT048.mail.protection.outlook.com (10.152.29.3) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 4 Feb 2021 14:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=schleissheimer.de; s=dkim1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=jDyisx5GKNuYiaZx3bcN5ZL8eCRJewgkWWNpmsbdMM4=;
        b=VvuzQrUvsBAd0pg1VEx3us8RxCwTtHGVVKyKtFUjYoBKE0C9+B3W00WeYaVFggz4sL80KoKKkiu1oE73iG82HzhluZ3t2MwjDbdfc4bYGaJbxgdQ9t6u235AfVn1uI2tqzofRrBMDoHTLNTkRjkf8RzVr56D2IaQDOwBHg5IKyw=;
Received: from [192.168.10.165] (port=41976 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1l7flk-00042E-2E; Thu, 04 Feb 2021 15:38:04 +0100
X-CTCH-RefID: str=0001.0A782F20.601C06CC.00BB,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] leds: lp50xx: add setting of default intensity from DT
Date:   Thu,  4 Feb 2021 14:38:03 +0000
Message-Id: <20210204143803.28140-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e658d1fc-4b1c-4111-8833-08d8c91a7d49
X-MS-TrafficTypeDiagnostic: DB9P190MB1052:
X-Microsoft-Antispam-PRVS: <DB9P190MB10526DCE900B5C72B17B609186B39@DB9P190MB1052.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r82eXmcUOwfJwx2tP6QY5GwTy5SzJ4/iAei0FxG5FQ+g/xdix+QsLRFuXBgWgQ2dF2QYgFjQtftpVFiRym/f7rmjt2A2MTwhWoXqncG4LcEG5n8BPcjXWm7jeXRSi5ouNMEtFrcHBcFyQNsbsRM6pzkUxwyllwBbUk892A+TwBRM2w0g9KzdX0kfRhvm5i5Hzu9oTmSrM8rQe0/goDCOATqaOok7axVkEp2Am49xN7Pp9Vqkx15vNy2T8nVkBYsZ3pAEI5vIg3JBhop7LbYlj956HilCRQQ7+QXv8MPli0XM9WHMBu5tHux5qO++02kwTSmH9HNBSU+BnpKlfWBy+MLfVMxbUdDOyEauvM4XjliQJ81Vypm8oICRoJy/bcLrEhrwSJfAmhJj+fNDGBzH2FngiHPLntn0h5+Hu20kLyQ0KWfAuqiKvG9tLJlTG2QVXItltzzW8ZHOJ8KNI5rwWOhthV6URmL+WSAmErvpu2v5s1IeikKYMOfbrojQ3rEQpsJnmm3EPRckKzV7/eiuFPTQQcSErywis2g7eLvlzNuAsVVFCmyL1jKyHJZtxE1dst5na9Q3y1AGCvQZQxvFUYwi0BWg34G5zMCDfe+J4sgJpN5Kyq/59LFc6kkhhSlGAloHY69ufBuyfr2wmwgnJ/bQyGXDZz+9iDJqpWMHHMk=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:www.schleissheimer.de;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39840400004)(46966006)(36840700001)(7636003)(4326008)(356005)(8676002)(36860700001)(1076003)(70586007)(186003)(70206006)(2906002)(54906003)(5660300002)(7696005)(83380400001)(36756003)(8936002)(9786002)(109986005)(336012)(478600001)(426003)(2616005)(82310400003)(47076005)(26005)(316002)(266003);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 14:38:08.0449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e658d1fc-4b1c-4111-8833-08d8c91a7d49
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT048.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1052
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use a multicolor-led together with a trigger
the led needs to have an intensity set to see something.
The trigger changes the brightness of the led but if there
is no intensity we actually see nothing.

This patch adds the ability to set the default intensity
of each multi-led node so that it is turned on from DT.
If no intensity is given the led will be initialized
with full intensity.

Part 1 updates the documentation.
Part 2 removes an unused variable.
Part 3 sets the initial intensity to full.
Part 4 reads the default intensity from DT

changes in v1
 - fix dt_binding_check errors

changes in v2
 - sets default intensity to full
 - adds the property to the multi-led node

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 drivers/leds/leds-lp50xx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 79bc071c31fb..e8aa36c7e963 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -504,6 +504,24 @@ static int lp50xx_probe_dt(struct lp50xx *priv)
 			num_colors++;
 		}
 
+		if (fwnode_property_count_u32(child, "default-intensity")
+			== num_colors) {
+
+			int j, def_int[LP50XX_LEDS_PER_MODULE];
+
+			ret = fwnode_property_read_u32_array(child,
+				"default-intensity", def_int, num_colors);
+			if (ret) {
+				dev_err(&priv->client->dev,
+					"Cannot read default-intensity: %d\n",
+					ret);
+				goto child_out;
+			}
+
+			for (j = 0; j < num_colors; j++)
+				mc_led_info[j].intensity = def_int[j];
+		}
+
 		led->priv = priv;
 		led->mc_cdev.num_colors = num_colors;
 		led->mc_cdev.subled_info = mc_led_info;
-- 
2.17.1

