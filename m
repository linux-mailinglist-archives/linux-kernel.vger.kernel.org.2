Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159FB45062C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKOOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:02:17 -0500
Received: from mail-sgaapc01hn2220.outbound.protection.outlook.com ([52.100.164.220]:5527
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231860AbhKOOCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm0OQ145zXZL2j6jtHYe2NP7hl2HeStvyRBYv9tznjlOEx4K6AGuQqtUQaG/8aJ+HrUTQgAgh4lwbxOX36aUz8HK7aCXBYzoYD6YqTVi/GJKqVkg6jnXOjb+ZJlZodoVxb6ELCW4xI1NMY92DKOEBh6vrd7S+gNpaT/tdPtba0R4xRwbo45arDUrzsLKIjyFEDT/y9KBiUD0kIwGzhQWqVyMcTvEG5HoVssduw/LNiYyd21M/ZIY90aErBreUQ4y/OQsP81Ix3evofwY/bITHGX2gYT/o7t0wiiv0HHkm9xCDuHqVnWI2Y/ojTcxMVUTOnZmWOC1eR138HFW2jNFRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9KHj0Tysl00Y8VuldYQLKS2vSPhJapqlUjK/epLuGU=;
 b=fIFIKTyy4L1k+ZAb49bvT5LhRQ9xQbERr6pBH5hENsWg7ekl51FUlt5SycHWoXj2GTm2kccnFvB5TUudm9FBprgW2qIa9dRJ0Hg9Z1uBPlRg1XGRF1Fa1K8CSy/BuIQn2BmlvUZRn/WDmjrPAkSvpt4rB/q+9pUbgPKECGYrEuHIFFYfqDlLuQmBmKZ8d75znO5bRHgYG08AHQvXlbcb7/yGbHqTVWONTABxRX5syqiyt+zReXdOS3uLTQrqGPxGdK4BRV6NlfkabnmenVFmTPIyPhJvhRUMajGVRQYrCYtG9r1tVub5Zqbf35JoJ4JqxWIcsahklYoQZplFC+GocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9KHj0Tysl00Y8VuldYQLKS2vSPhJapqlUjK/epLuGU=;
 b=jMuUy3PZ9FkNSfwN7S3h40RecdKO/NeYQWYtbi/ty3H5LhhTTEOwn0OPnUgAHa7Gma86xZMfNgRKXjWsLLBjmXI/M4fjlzClWBz1ZF5GP5Q+dB/jSrUXLSY5kpfevhfiic28K5TsF+mjGyh7LGV6XkfMRbjnaum7DycwF4FwSkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com (2603:1096:203:7e::13)
 by HKAPR02MB4402.apcprd02.prod.outlook.com (2603:1096:203:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 13:59:13 +0000
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397]) by HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 13:59:13 +0000
From:   Mingjie Zhang <superzmj@fibocom.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingjie Zhang <superzmj@fibocom.com>
Subject: [PATCH] USB:serial:option:add Fibocom FM101-GL variants
Date:   Mon, 15 Nov 2021 21:59:06 +0800
Message-Id: <20211115135906.52702-1-superzmj@fibocom.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::20) To HK0PR02MB3379.apcprd02.prod.outlook.com
 (2603:1096:203:7e::13)
MIME-Version: 1.0
Received: from localhost (124.89.89.114) by HK2P15301CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend Transport; Mon, 15 Nov 2021 13:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bb5892a-8a9c-4d94-1215-08d9a8401aef
X-MS-TrafficTypeDiagnostic: HKAPR02MB4402:
X-Microsoft-Antispam-PRVS: <HKAPR02MB4402729DED334606AA724739CA989@HKAPR02MB4402.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1kVs7rIz7aWsXd2UgsYO8YlD2ixY9ElCYLeDmoLFsIl/3QIVXUQiJZKarQZO?=
 =?us-ascii?Q?t6CSncADOULGbB1dM/34Vf4G243Ngq85MGAJuAddWhcAUjNcCg0j8JBPyLUs?=
 =?us-ascii?Q?jzHWYBCdM+6zfOpRDn/YWwB06BjczXJEzDw87wXm+vLzslO3fPdJXYxdywTm?=
 =?us-ascii?Q?EbmusiBoqIp7i8/uoGBZpX3YTdBBtwAfURSfCuaEhNmt5yA1YNmtwJE+1SAf?=
 =?us-ascii?Q?mWYH5KfO2BvOqLSiqaq5h/J+Vafoex0TEw5W/tttBPeVXWylD4dn+WBDZpCG?=
 =?us-ascii?Q?7AXyY7skJxLKNymZObszPvMnSEfmPtCGSiW9CXZvl1rPIJfEqngYfnaJd1cS?=
 =?us-ascii?Q?gmNKLm7VRaiFa5YU6j/w9q9+0jKEu4MUYiX556EZRlVDlN2gTdPYd7WvBOZI?=
 =?us-ascii?Q?uinQjtXrY2V+D16y9EfyETVXuhr20Xf1Mc33ZOgye9pwpC5JMzUnNmW5sVjg?=
 =?us-ascii?Q?joXvO6wJllxafjJlaqInSyYRy+n4OktwTG05bicK2CFgQpZu2ngiMfZIMAfK?=
 =?us-ascii?Q?cLsmx4EYKEUcqYKW+eVB8IgOzcY4HuCrEQjtLL7dd2ir2vHEHg4obkdd2nU+?=
 =?us-ascii?Q?ODrP2lyXm7qhM2EfR922RARowvNC62sv5mA7w8gkxzEAh4KzuwTuASDQwNWT?=
 =?us-ascii?Q?LehoMoT9x+AmC3VSl5gCXhAAwYdlIlCA1WFEFW9LeM3UJ1pi6gMu/HmsNRtc?=
 =?us-ascii?Q?YhxbxmG12ddIj9gmY4ErGUIOcSwyBiRA9Iko3NIu7Mvu7Etp/tdIWJ4rBGy1?=
 =?us-ascii?Q?Q/ZJ5z4lDIRhIvn7nMlsyhu1Xav8iRat/W6xvOB2Fu80tUERt39aNv4e/+3J?=
 =?us-ascii?Q?VQNRlQPw2wH9jQzIDaT/FVbWznjzQE+GvwfNfOXEbbQl/t/JV5fMNEUTkNpm?=
 =?us-ascii?Q?TCxf3CZHeGWY1OvcRImohQ986D3vBbkWcYuxnhPDvJd489Elk98HTkIchW6R?=
 =?us-ascii?Q?5xetCDVEvzB+LunCSGdgtobbIQU9+HxfUxRjzLQxuTFbLgTaDor3JlOcTl03?=
 =?us-ascii?Q?OUTnSxoTDn6YIX2HMTNGnCWmXRME5jB3i8TmZGr7Jl8z8Sc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:HK0PR02MB3379.apcprd02.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(6666004)(2616005)(508600001)(186003)(36756003)(956004)(66556008)(66476007)(6916009)(83380400001)(1076003)(66946007)(86362001)(38350700002)(4326008)(26005)(6486002)(38100700002)(6496006)(2906002)(5660300002)(8676002)(8936002)(52116002)(316002)(107886003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5+akj6rWQxcc6Os1bMkfkA7rK8blh60/jaE2SBVK3/lwE+yzXjCy1BqfZNXS?=
 =?us-ascii?Q?M08SeVwEJ5LvKE0vrCMbFYbAEUYPf+O3RUBkbZfitgm5VwsY0t/GjN3/u3h6?=
 =?us-ascii?Q?8MuxpcTnjsYragsiu8IZCr/qwyym4P6r2xk7FMJVgH4t7p1DaAmb12jMp0Di?=
 =?us-ascii?Q?o7FXmMlxl9rqHoq/NaKwGB5swzFHqBp3aZGMLVVfD9y2nXHRJB0tHIaEc9b0?=
 =?us-ascii?Q?SoD7I2U3QUNRSQ9+3fwR64Fhii2FkoCAHFms05pqVreU3V6Ubs4n+P5JwGgQ?=
 =?us-ascii?Q?JGFkCs7/KFUCdiSvrlNlePWHoJk6jS8dRTNzyqub/vkLNN5Ktc8MRS7kAZQA?=
 =?us-ascii?Q?uheoFWtyMYyhJFRH9+6TiOzYuB7FywI+I+vOQovmLAIBj86H3t4NVetrZHHl?=
 =?us-ascii?Q?MYynb64qtX/FyBbIIalTRllq5qHCA4HLdXijSjcnJJZQacyTz4L5EoDPT9WW?=
 =?us-ascii?Q?meFecJ6RdXP/wlkxDoxKN9k4+IwxxCQqlhAevzO4aZ4sthiQwsOLaq0V+WsU?=
 =?us-ascii?Q?ge72HFGc/2gc7he+7sGFum8jD1tWO0qwsUtL3fpDA/WmlHmzOv8FuXLrozmg?=
 =?us-ascii?Q?iEXFQ7blEFQH+63I+OtoXEHQqDMMFV16pGwbN6N45t88nVxXjFb75UkMUzhb?=
 =?us-ascii?Q?PdLHtEuZAsDgPVpKfwMHP9x9HbVuRUEZaTDz74My5jlGmcLdRLGjzcPjMi65?=
 =?us-ascii?Q?V0o3J6P0REwE/nHN0OpI4MCKgkj7JWGeOqfQ0ASNSFou9qgjF/IcMVFM8QLI?=
 =?us-ascii?Q?GG4tBo4IGFm3kdJU4NaBrz2X9TexEb8O5ZV4Clpbhj0LZqZmAifD8kKpB0YX?=
 =?us-ascii?Q?1QihgNJcDE4EA5HIrq+OsejsEVhYPm1W6bdGqWqrURlnzX6xv0Y1asinpkya?=
 =?us-ascii?Q?XM3HFAruMejDq2cHINxe6ETjltf42MRBnL66HLFO6Ekb1guhe/9PCOlK/qsP?=
 =?us-ascii?Q?DBCtfQZ6Kbf1sgnz5cicXw0t24ozsjaJFGp9UvryArmnBa/bRwN6dCq6FQ5O?=
 =?us-ascii?Q?O3qdwZM1aLVjEbLrLG17tAzXUYcYLL65VxmynSmw8D2KxgvG6qtdkGeSKpzQ?=
 =?us-ascii?Q?DqIZY2EnSi4zdaF9H00VqFjN7D78bEf28JMp1yoGEdpjN3Ti/9dh+J8RPg6z?=
 =?us-ascii?Q?TEtL0Vln1hJ9LHx0AeLd7z32mGB4nqVtBLCSCi+eJLOKvqk95ssw1zxK4PZY?=
 =?us-ascii?Q?PC3KyNCX8GOhahgeHlVj9UAuw7WCtjPwenMmm7cgXAiA7jt/CWYiQtOXcSC9?=
 =?us-ascii?Q?sjnJ4Vb0PBvroyM4A6qcgb/rJyd3958ltVD1LM+vDmwYDMw8KtE3bFonht+q?=
 =?us-ascii?Q?qhA34kJgNKJVUkX4NkqGvlQf8H9UNxpZpQ3HvfZ+U96MsjOWpKpr+4kWlNJm?=
 =?us-ascii?Q?YgBtti2Q9T2XRwyt1SG5oG35psFXhmFeW/rj5wUhF84vi7KKnOQhxMYaawE4?=
 =?us-ascii?Q?XFdPG1SylPqZ5zEFsaAvyZFLK50CxyanTqAYcpBZFW3Hn0fgDPn1NofyeSq1?=
 =?us-ascii?Q?dP47/T9XKRLh+1YXH3dumribwnOxQTVu1o0rG0D9dGNB2JD6xCBDJzw/1WqU?=
 =?us-ascii?Q?XUZicZKIyn69bg+R0mowL2txm8OFVcUcT7NE9/2VBa+ul01sndbxg6/JmnvW?=
 =?us-ascii?Q?/ZsXUj7JnZMpjjrdO5m1LfQ=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5892a-8a9c-4d94-1215-08d9a8401aef
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 13:59:13.3923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+Fam+xobmu0rbcQE55wd9dQy3TCS0mv3qmW7xmjgEMOm/O9VU1/354ga1It4MNQB46wzOfTrF94CvIpHwT53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR02MB4402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the USB serial option driver support for the Fibocom
FM101-GL Cat.6
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(adb interface)
- VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
  MBIM interfaces for /Linux/Chrome OS)

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=86bffe63
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=2cb7 ProdID=01a4 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=86bffe63
C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..8f5c98a75429 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2081,6 +2081,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff) },			/* Fibocom FM101-GL (laptop adb) */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.25.1

