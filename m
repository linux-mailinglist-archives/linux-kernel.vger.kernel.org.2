Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7C35D9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242539AbhDMIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:17:11 -0400
Received: from mail-oln040092073034.outbound.protection.outlook.com ([40.92.73.34]:49742
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241675AbhDMIRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqvk1m+g8HSYN/nSz2HXCWjecI3ztf7Fhmohh3SICQwPCnUHCjRbvuMAneNEP7MQDO+W8W1hBFwwKHB8hAd3cGhLBikfnTPuri6F4irRbv2cXfbg1hJyWGtzJcKsixvwytJLMGd6gd5A6BjZPT15j5FDm6jO1cm+n9vnvGOPDsUXgWACbLduVDq36pqtAHPNAwqa3H4+b32jIekgqPVixhAqQ0WTpEsoU6+NDBaj2lphxk4UQiutzKMR1V0KjLkWCy7R8H3PVhWQw329WAG3njG7NbJR2HL5+1750atU6QqSiaN5OD9npIrA6THTIEAplcx8+SWi24vjf/h3bGNGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4AWzqTzAG2rdZpscGGBKR9wvYLK3+R5Gv6kXYJeSKU=;
 b=Nh6XBF3VCSEUrGpE0OTtqo7TB4qYU1DxLGNQaRa/lEb+gFVBJYNr1JC2TDiIC8IAvdzzO+/Y+vpz0ifRW0BkWUUJXoYwzx+aDieF+SDr/v6aTxHSSElc0K3n825Q9RuIXhpcReMRrGqwhfWULIPQfNtUL5O9H038zmm2iEKjIUKag2/XH2I3OKl0BhUATvpdkujPtK3HSbgPROh91mE3JlgFt3PUcOSF4nMou4h5TCZfQLECN6gWkui8DwsjT+Taa32BaAPGnceABNyqqj0fV2aT0LLFuWsMr9mLKNEX+VRSZzHAkc5RhUCsJoncRRvqALV9p5FGa46cyzzWExfU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4AWzqTzAG2rdZpscGGBKR9wvYLK3+R5Gv6kXYJeSKU=;
 b=dYXQYjtHNshrTJiee3aa0Vnh6G+o4yJUmGeqKkmK97guJE9C8ftch6mOvKeUkhEyhGXuyeQRHn5kSb0Wc378BpRfsZPiKbt2C2ffWk+wseh5LxbTcapsuHaRuuUYXW8wFhcfEJ64hxyxxZesOt800pIdpOxnyZuZSmA/oVEn2LXhI/4XMIz0FgmQx6+AWfu3BVvhGx+wmWq+Ge3fkz/trGKoG6GVHOz5NVDHCyKkCacca7hqXreSJ9FfSE/cdbc40bekcMLTogbRRm9j7HhImI86fvYoVw8td3eW4SpxMBDhdbuJfYjfstDlOjQuAQ2D03aqRxZIFQR+4ruIMltVYg==
Received: from VI1EUR04FT048.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4c) by
 VI1EUR04HT172.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::161)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 08:16:48 +0000
Received: from AM0PR01MB4259.eurprd01.prod.exchangelabs.com
 (2a01:111:e400:7e0e::42) by VI1EUR04FT048.mail.protection.outlook.com
 (2a01:111:e400:7e0e::259) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Tue, 13 Apr 2021 08:16:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B23A13BA061885BDCE1480CA385425818C984A31AE2FF9521B59CF3408CDE234;UpperCasedChecksum:70D87F1691DAC5600AEA4C6E5B8EC8E6B6842D7315D8752C560680AE24E9DEB7;SizeAsReceived:7354;Count:44
Received: from AM0PR01MB4259.eurprd01.prod.exchangelabs.com
 ([fe80::18c2:36c1:2595:c74d]) by AM0PR01MB4259.eurprd01.prod.exchangelabs.com
 ([fe80::18c2:36c1:2595:c74d%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 08:16:48 +0000
Date:   Tue, 13 Apr 2021 10:16:37 +0200
From:   Mikko Talikka <mikko.talikka@live.com>
To:     gregkh@linuxfoundation.org
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: adv_pci_dio: remove whitespace
Message-ID: <AM0PR01MB42597C4CAA1B9E51D4AE3D5E974F9@AM0PR01MB4259.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [O2lj88HIoQl/6mJFuY0h/mQi1ZD8XrGS]
X-ClientProxiedBy: PR0P264CA0218.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::14) To AM0PR01MB4259.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:6f::27)
X-Microsoft-Original-Message-ID: <YHVTZcSChScebk1j@localhost.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (89.172.40.255) by PR0P264CA0218.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 08:16:47 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5e0fdc2e-39ce-4687-4de1-08d8fe547bb0
X-MS-TrafficTypeDiagnostic: VI1EUR04HT172:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DP87mcKzggo4HtEbX0V4gQ5XQc1IYPrahceaYhLt7gFP+fa/bCRjKqdJd3dGO2Jap1xtHHjWD2R/4ogeTbs/gcK9hnBdpLrVYmKMOtXX2qoxXBI3Rd964tXhh2vEogBLx3Nkwxb+rbkYobE/jsm9rg5J278fmDSmRbulLnk1CL8SRde+fATEuW01h7KbGtOseVFDUZkWBTL86q2ZTGaww7Z3QqShNUPH/1P3YGTmFmsW4uOgyS+z2SDTDGmdn4KG47YhFBFFPsCgo7Ew6tjxnX3uwjf20VtF4A2APAtxGQrZZTRS38L5Rg9apovvzJQSHtUgKSHJq42cczoQi8XCSHcE2aflU1Ja/DnSNjM7VoYRQ65to48ASaoGV5luQBOvbOPzrU5a5CC7QhEiEWNq3g==
X-MS-Exchange-AntiSpam-MessageData: W1fMrc6GxpHm48epRelJ2o2NjecJIXZJdC212jRYuK2xaeuaWWNne2QaPuz9WLLXaV7Yplk6LWPcEj54Epo83wiybY0xJ8jt+++88Hg55c/thdR+NWcl6Zg91ESznP9nwUJkRyai5D9MWg5gqkU3bg==
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0fdc2e-39ce-4687-4de1-08d8fe547bb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 08:16:48.3632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT048.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT172
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed checkpatch.pl warning:

CHECK: Blank lines aren't necessary before a close brace '}'
+
+               }

Signed-off-by: Mikko Talikka <mikko.talikka@live.com>
---
 drivers/staging/comedi/drivers/adv_pci_dio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/adv_pci_dio.c b/drivers/staging/comedi/drivers/adv_pci_dio.c
index 8e222b6ff2b4..54c7419c8ca6 100644
--- a/drivers/staging/comedi/drivers/adv_pci_dio.c
+++ b/drivers/staging/comedi/drivers/adv_pci_dio.c
@@ -604,7 +604,6 @@ static int pci_dio_auto_attach(struct comedi_device *dev,
 						? pci_dio_insn_bits_di_w
 						: pci_dio_insn_bits_di_b;
 			s->private	= (void *)d->addr;
-
 		}
 	}
 
-- 
2.30.2

