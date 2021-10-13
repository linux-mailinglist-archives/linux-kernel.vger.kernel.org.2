Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C817942BFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhJMMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:31:12 -0400
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:34500
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233368AbhJMMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:31:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEog+YjDElGAzTFs0//1TNL60mJvwviEvnMXA4slaBh1FUu90/2tgvYqyg9J15FHe11ViPs6Be48CnEK4Mw7BxqAEvjwh9+8Gj4/qadChDIUYIeU0erH2HHJtfiaeBirlhbc6SWb2IFgcPeji8kAQgLSLaeh3bzmSIO03AZ/Wv1YD/vLrVS0QfC1MUTOBkBWNy3vLJCwtiQi/0pygY7Y1D1PMYjzRYteivLQhYcznD0CBoM8rnf9XrrkCaq9pTU5TBW6E6azzO6uXGqQ6gTvaKSWpmJpp6NOI/JdZon2dQOGV8g4TNqgXkPHxCQAkzWLnHSdl4NWbRCAOX3qPRmbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbUTW+Txltp/cb/9tBvfra3CthFdNhyBuRTj7I0ShKA=;
 b=bPGt034DkkXLdjg5kKaH78y6ECxZgHskPEH3NgwEZk3DcxJ9XMMWPu80IylU+y9PDInl1sRmQZqdUHyxynuH6Ow6jNmaJI3OKd+xXCaybqjtDY27qkeAFEFENL8TAepLGiXyMXPNN/lf2YaJ4k8uxmnGyorc/DLiPB1KPGuby6Svn/dMy7Xf2+nqDa1uH+OxnrZvp0izO3xNEq1ZmEf16Qor+hXD8wujlWYq5PwXSYlRisnyVyGaBUsjw25eQN4P3PsiWTX+9G7YXrWaTb4nJ4tkSwuTxvgTwPdGNag4t9NxmE4V1smCFmd5ooPTJuGbRcZIZED0EbcYz4+ktU3Wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbUTW+Txltp/cb/9tBvfra3CthFdNhyBuRTj7I0ShKA=;
 b=cHj6h+Z1YbdIqwPePLQS/qYnV1LKWcYDz910ihoKgIuusvfVytpkSeD4TTdY+FAJz9/LQgQpVxDST19Q0hZhyCgEMJzmjcRVN7UJ/TqnGl7Y0wirWDHuyghlOdCy6Jauco+nV0MjkJC2e/R2kuJZktp7arZUx02gUNXgZIBhM6o=
Received: from SV0P279CA0071.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::22)
 by AM0PR0102MB3570.eurprd01.prod.exchangelabs.com (2603:10a6:208:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 12:29:05 +0000
Received: from HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::1b) by SV0P279CA0071.outlook.office365.com
 (2603:10a6:f10:14::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Wed, 13 Oct 2021 12:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 HE1EUR01FT060.mail.protection.outlook.com (10.152.0.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Wed, 13 Oct 2021 12:29:04 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Wed, 13 Oct 2021 14:28:15 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2] usb: core: hub: improve port over-current alert msg
Date:   Wed, 13 Oct 2021 14:27:15 +0200
Message-Id: <20211013122715.883365-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Oct 2021 12:28:15.0131 (UTC) FILETIME=[CB8596B0:01D7C02D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 20ba3840-aa14-4be5-45f7-08d98e450bb3
X-MS-TrafficTypeDiagnostic: AM0PR0102MB3570:
X-Microsoft-Antispam-PRVS: <AM0PR0102MB3570EAF7C4B7DB71A9B972FFF9B79@AM0PR0102MB3570.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Zf7xP7MFr1zTKC9wRyNPfxOCFR7Ah4IwyMzDh7P9XljFyu9qzOJT2jnPHrgsgZoWIa8x7iCyBjnjoOW4PXxNJaPvFbXKKKyyaAMeCJuy2k8mYX81lCyyV/EzSib7meWrs8WY8CAsvCnfgh0Adv2Wj/8VDgvWdpbg1uQvM7KVUy9/ttYCF9RhLBKeq+uR+OSXE3hPpYSq2e3U3u5jMivU/vnDIFI0uEOeYu+J9WSCML6oFDG5RttUUOujBVByw7ZicETO66a6uVSH78st0ikvGKb9EYkGyl/7t2lj3XRLkOjsZQRCOJwUT5Wh9lGKmvmbe0MG0dmAO61RHlzti+2xB9mx51E3xpEFrdOAyW5uZ1gVwCvQ1Er809wbjVVx6ihxhfkh94o4ljvlZB/t8bPBPNIgtGWJQAzL1BjlsjWWPKn3yf3CGAYSVvff2YzFpekJZvKhLFZxP/oA7vwH3VO4UaRR7HLZmTAjZNIQC7732Rj5VPt90OD5SwnpI6JGmULX/n5LfpIKKT2Vc5Q7avAQKfP27lrZswNRrawJJbbdv4AlUMJUKLg8ixudnXunuvUhJUDhFQ6FZuRIfEXRH7JwWjpqnW33V30ft5WuEeBRHkAfMJaicXLoyaU6EHYt6NZNDvfc581bhCK3hWc8g9VoXyx4XfS1WVdlPIV+4LTT1a8In4V9dtUaX/OeVoeSJ72Nq0hvKSTBt32c3cVJVh3KT4t71zvKGs05Kup5C2hYO8=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(36840700001)(46966006)(86362001)(8936002)(450100002)(110136005)(82310400003)(186003)(70586007)(2616005)(47076005)(81166007)(316002)(5660300002)(83380400001)(15650500001)(36860700001)(70206006)(336012)(1076003)(508600001)(356005)(36756003)(4326008)(8676002)(107886003)(2906002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 12:29:04.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ba3840-aa14-4be5-45f7-08d98e450bb3
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0102MB3570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the port over-current message is displayed only if the
over-current condition is permanent.

But in case of permanent short-circuit or over-current, some USB
power-distribution switches (such as the TPS20xx, etc.), after the
over-current detection and the consequent shutdown, return in the
normal state.

So, in these cases, the over-current error message never appears.

To overcome this problem, the "over-current condition" message is
displayed even after a series of some over-current events.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/usb/core/hub.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 86658a81d284..24ef09ad208b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -50,6 +50,9 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+#define USB_OC_COOL_DOWN_TIME		100	/* ms */
+#define USB_OC_REPEATED_MSG_DELAY	2000	/* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -5565,6 +5568,11 @@ static void port_event(struct usb_hub *hub, int port1)
 		}
 	}
 
+	/*
+	 * The over-current events can be continuous or intermittent (sometimes
+	 * the event disappears after the cooling-down time); in both cases
+	 * display an error message.
+	 */
 	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
 		u16 status = 0, unused;
 		port_dev->over_current_count++;
@@ -5574,10 +5582,12 @@ static void port_event(struct usb_hub *hub, int port1)
 			port_dev->over_current_count);
 		usb_clear_port_feature(hdev, port1,
 				USB_PORT_FEAT_C_OVER_CURRENT);
-		msleep(100);	/* Cool down */
+		msleep(USB_OC_COOL_DOWN_TIME); /* Cool down */
 		hub_power_on(hub, true);
 		hub_port_status(hub, port1, &status, &unused);
-		if (status & USB_PORT_STAT_OVERCURRENT)
+		if ((status & USB_PORT_STAT_OVERCURRENT) ||
+		    !(port_dev->over_current_count %
+		      (USB_OC_REPEATED_MSG_DELAY / USB_OC_COOL_DOWN_TIME)))
 			dev_err(&port_dev->dev, "over-current condition\n");
 	}
 
-- 
2.25.1

