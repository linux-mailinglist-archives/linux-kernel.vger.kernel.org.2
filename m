Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267C5459DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhKWI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:29:53 -0500
Received: from mail-hk2apc01hn2225.outbound.protection.outlook.com ([52.100.182.225]:32376
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231240AbhKWI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:29:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo1JP9WUTlqcZmMPGiB/Noj8v2SR1voQLcb6yZY51ksDX4/8U0rvQGboSyb6unCHiIwsNbtTVEiddkHnFsESl3/Vc1Ghi8QLxqjcrTA0K8ZND/69TMqGeNVka6b2RriapJyf9LNPxzxJwi7SUD4a0Tv9SiibMjVt3XCLRF34A+hqCEovru3eDbUcmSB4eeAdAozapmwyqGJs8z3+zZSN/kA8NWlh+o4pdQPXTYdTYMpOhD0PnSxwqXSFQUEfoVCbPVT6HmsZjFhtwXPtM9W1n1kokd7F8Trjy+kK2gcJL71oAZHiKMlgdURjKcpLa4vCasjce57KPO43FT25JLxzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqfRfCqm53bnLTX3DSc8cmf9BBQhlHGGJ+nKhKq9yNw=;
 b=OrNmhWxyTLldl07XCkwtc740O0HPGcjz1OWLUjDnWfa1pxjDm1F06ErFmwLQPOdOXV7BUMXaaqvc4vszXt2PDeJKSqUI7cfp2vaan9Gp5WWV0L34MurM7O0Gk2hTK5+CogH5vWz0MYfF6nzmkWSZJsr/UfSfXJmar6FaPlSNCDaa+8vn5DQ4hfEH8XK35v6DCIBaknrue5NE9RET/zmzq50jPutUdRFSBpaVGSi37GnyNsDEnI6jQyOfDQ1t/TbGLtxpL0k/v45PPaPF9H5qAS8l9a9x8QiGWZvbhfKbU7U70y4Mt2rHooBPqGtCL+Lx1zbXttNH00WPNg1OzREnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqfRfCqm53bnLTX3DSc8cmf9BBQhlHGGJ+nKhKq9yNw=;
 b=rmMho6hyAjw4f70QoGGy6xd4KfjlQn6S4z2MRcfjuVse6tvsazxQPQVTyXyjb/WAAwycBUaE9wLaqqq8EyLe/XDqT0crc8nIocaWBqiC15kfG5S1Fw++wXxyzZv2jZn2Rtv70Q4T2OYfUn4UmnXBR0ilmIucYwXkOVB8X1h4pxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com (2603:1096:203:7e::13)
 by HK0PR02MB2929.apcprd02.prod.outlook.com (2603:1096:203:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 08:26:38 +0000
Received: from HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397]) by HK0PR02MB3379.apcprd02.prod.outlook.com
 ([fe80::5dc7:5288:fb7f:6397%5]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 08:26:38 +0000
From:   Mingjie Zhang <superzmj@fibocom.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingjie Zhang <superzmj@fibocom.com>
Subject: [PATCH v2] USB: serial: option: add Fibocom FM101-GL variants
Date:   Tue, 23 Nov 2021 16:26:34 +0800
Message-Id: <20211123082634.21498-1-superzmj@fibocom.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HK0PR02MB3379.apcprd02.prod.outlook.com
 (2603:1096:203:7e::13)
MIME-Version: 1.0
Received: from localhost (117.22.252.78) by HK2PR02CA0181.apcprd02.prod.outlook.com (2603:1096:201:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 08:26:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 002eac03-604b-4cbe-eb91-08d9ae5af7ff
X-MS-TrafficTypeDiagnostic: HK0PR02MB2929:
X-Microsoft-Antispam-PRVS: <HK0PR02MB29290D4CA42CE87FDCEC5592CA609@HK0PR02MB2929.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NsLZbAHa3/WWz/F7HiqjbBojFAggF7rsBbcs0/T+3AHG+Kk8A/dqX0hBSXrW?=
 =?us-ascii?Q?+4CmasSXsBoBziIMMmjt1ky/f4CnQgH3PWmKEl+85/XzssXQvaUq11TxCHKb?=
 =?us-ascii?Q?l56CV9qk4M6qNYOyLSUGdeP4jBF9NwjSGzTgxIeOze3hHgReAKQh+Hh7dcIS?=
 =?us-ascii?Q?JqHETlz3Oyg+s/7G6AN1WvXHzx3RB/qwHACzVkrTzhCoyIRzwKQPJlIa8ED6?=
 =?us-ascii?Q?rd0yZGn7+8OgVH59m1l3qOeuLPuxrIcbD23DXj1uHQ6zF49LMZM420jeIgal?=
 =?us-ascii?Q?PxIxYCL/PYNV4xIkVlFLrPH+6DmE3uG9UzISFt8Ex85GhZJcIp1vjHQjDoR7?=
 =?us-ascii?Q?2jcZrZzyxaiqm9qNjA0Rrh/mlAwcfKjCtFOMD4mLvrWjwDWWvmXlNu/VQ8V5?=
 =?us-ascii?Q?Q9qWP4EqJTDJQ+dcNVZkke6zub1YK+THdFPPaepPO1w9vGeVKQQB39SEHl9v?=
 =?us-ascii?Q?KABVaaRu4LyJgIkoALZJomGamh1H75AKS2bzjI60W+2sOGSWGUvqQgDPxrgJ?=
 =?us-ascii?Q?FnwqhkG/+eF55K60goeaHz+KMj2BBT/J8wRbFvCfzePoR7i8yYQvfGsYXKp1?=
 =?us-ascii?Q?uqnT9MHS1+5Bo79UfTUFnuxdIQBVrpvT3Diy8da+LjMV7SfRMXDD02RAoTmj?=
 =?us-ascii?Q?fWltQsvocPJI2yPDI/1SkXTpE1opEaQl8TgJhVMuWdHeQxRR6knABf2kkoF5?=
 =?us-ascii?Q?/NScZc9AWBKHH9TrKAoMxhHQyhAhoxylsV6UAlkjei9VxDkTnkA84bSaVh1T?=
 =?us-ascii?Q?94WLF9gRWCKnYBo7tb/LBT6wKSILJGI4sfV/m6aFJ7XGGJIC+0uXA+OagU4p?=
 =?us-ascii?Q?LW+26jXJDr1EVHY3zdGqCSHu1Wqez/RPY/4HhPMuge0NrAotBvne+bKYKy6W?=
 =?us-ascii?Q?vL2WpESwZYVxFaSfMGzQtBci+E2H3ouEMPNHief63zz6EOghYMXxyzNMjKkV?=
 =?us-ascii?Q?C+/Rn45G9q0CiuJeYa7MedTo3OCXoL+2fPWVIJgMm/yklESzwkfzy0GGbCfE?=
 =?us-ascii?Q?aKNxWPDd73kfwE7uchhdwHVwHNCcDroUO/TLlJJRnEKRvV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:HK0PR02MB3379.apcprd02.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(66946007)(107886003)(6666004)(83380400001)(4326008)(38100700002)(316002)(86362001)(1076003)(5660300002)(66556008)(66476007)(186003)(2616005)(6916009)(52116002)(956004)(508600001)(8936002)(6486002)(6496006)(36756003)(2906002)(38350700002)(8676002)(26005)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4mXt61JWPcMqDTJsqjA0ecLgG+TIGoX/rBqODhJcG1irj5tqRR1Ura2OSTa?=
 =?us-ascii?Q?PK4fXBGkEDMY/1YlM58ra4irBJk+OGFgks1G/TjqAKpO/ou8yOJkwkphcPU2?=
 =?us-ascii?Q?DTD0uyEFYroleXVNxIfIp5oFK/UHD3VNEOf3ytvEQlkR6tNL2dWVJjUWSIgD?=
 =?us-ascii?Q?baVh1zktCgXbEs9Hl7zYXLPd2xL722d7kqG7szcGO1e9whgJDxESe0tjXTBI?=
 =?us-ascii?Q?VrdaO6ZMKAP/IZZdyym8YO7GVPx7/ni7QMtUaP3mSVazXDqtoWzLmo3iRIU/?=
 =?us-ascii?Q?MVYmcgtiBzOnlPGa8aNGtBFF32H4HKCZHVTtiKc4ZnFNBUOue7VuPFRr4A3O?=
 =?us-ascii?Q?oXqCic2EJi4hIgIsN+Gqlc/e7ZrUo2vgxtI3bbjO374pjEJNkntkGRHyIwzn?=
 =?us-ascii?Q?ouMl/pe+i5nrYFJ8m6aZvKgzDbMuGSVqDwew8Lvu42TiTkyYI54EyKiOA56S?=
 =?us-ascii?Q?96X6P9J8vhXrNFwkaqwBe3XC1g2AP7f6ASfTxxZzhvoAB7NpVZ3GhNGMAW2F?=
 =?us-ascii?Q?fftwSv6cYUhTHlrXvW7yRFrYoxjsLeg6RbsF9CwSl8gsKPmYly9FaEn2lI1L?=
 =?us-ascii?Q?0bxvvwI/G8oZMZr3FIhqAoVCwaMDFL/TKgndyhx8sN5fzSLJ4KaEGuXFtE/l?=
 =?us-ascii?Q?h3FYnsJqoYVEcIXVNGCUps+9IQ2n3U01FUBUQwJfozUIQgOqXaxU16B3Vp0N?=
 =?us-ascii?Q?YYACeQKzZE9y3yEIi8vuQ6LBS/cdB21CSg36gKe8jyVlZdUIiG7Tyrmj7wFI?=
 =?us-ascii?Q?ajjYnG29ybC/VN9EdoKbZCsX9VftVdZzRETXc8F4sr6SrnpR5LqcD5NdUgEU?=
 =?us-ascii?Q?ePr3wZQHYItANyZD5Iryb382bgKoHn2sUaeOBZ5fAy6G6ck8nNCQc3NmD5Fp?=
 =?us-ascii?Q?PiPCesSbfjnaDe0uPVOzOj3X5K1cVxygko6hWKDBd3CSoAbl+FhiNHBmizZk?=
 =?us-ascii?Q?M5D7I94JSdZPFd4JhFSXe/ntcxLQuxD0eLHlrNgyzp4uOAKl/RDB6aTbTM3S?=
 =?us-ascii?Q?uny1QshGScwKToh88YaQ9AJmO47FknDNQluR8ErctRFYDb3ByEhmzqM5XFXc?=
 =?us-ascii?Q?n3ujlUk8LrNihelpKwCj5q8U9wfuxScnIxc3kzHNVvqknWCdG3uGzQoPeDkU?=
 =?us-ascii?Q?GJcUn/AWYFU+jaIPukqa62UT6gLbQvbu8mjq5gEUVPfR1Si/vonzgvs7RZqC?=
 =?us-ascii?Q?sdZYkk1UCzAZ/jNddEWFSNj9yblDbTLhm8fQp+TOOScgJN3D/SBnQmvDLp6l?=
 =?us-ascii?Q?K7shrqDAHNhF/lM09ygLktCDtpeKe4tomduh1F2N1Nj4YkXBkeugHBORSsug?=
 =?us-ascii?Q?BVm5huYDVzUq3KNIXddjMJBv509a4QCey1LRmuk7MjkA56aLvTbv0doacmlM?=
 =?us-ascii?Q?aYr2o2NR9L367zkmTB+5q/O6RL6yc7IyYFfsvO0p1xH7/0s0s66pv9uL7WWX?=
 =?us-ascii?Q?nvAGfe0PGVV62rdF1nm73vpCgqLUYqCWxe11aiBFnVE2EFYdDV4g5SX+nJul?=
 =?us-ascii?Q?TDAfyT1A6LxttNcr4/D9NxzJQCw7cjwi3iayy2mp5T8EuG+vOPL75cD/HhOt?=
 =?us-ascii?Q?BtC6ZyWBNGRj2154bMeECF0wI+ZAs2PGIgTj2Kgh+WdFA1tHGL0xvWykEdTn?=
 =?us-ascii?Q?P6IFscEHL0IDauPUfkvkRO4=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002eac03-604b-4cbe-eb91-08d9ae5af7ff
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3379.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:26:38.2308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vx413zq1kpzFs3n3YsssP+fbH5TVDGMTS86FYIBZuMeBUVP2IQgmitNFVIDn3OCpgAQBCQfonhiJdhRhpWeKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB2929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the USB serial option driver support for the Fibocom
FM101-GL Cat.6
LTE modules as there are actually several different variants.
- VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(with
  adb interfaces for /Linux/Chrome OS)
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

0x01a2: mbim, tty, tty, diag, gnss

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

0x01a4: mbim, diag, tty, adb, gnss, gnss

Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
---
Changes in v2:
  - Add the description of the corresponding interface
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 29c765cc8495..8ef8d588d007 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2074,9 +2074,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
 	  .driver_info = RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
-- 
2.25.1

