Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391045FE31
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 11:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhK0KyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 05:54:01 -0500
Received: from mail-db8eur05on2135.outbound.protection.outlook.com ([40.107.20.135]:27841
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231611AbhK0Kv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 05:51:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcYyWa7GZenaEo4AylbXbKdA9XYNySDtlIHgKRuTn4OM5Cnuwj9YkP8SE+vPdOHD+DP7767RnJUftWzh/2olJtQQFbf7dPO331iyWVWd7DQOcDKup7M6PFEv9/69zpwqHxNErFRbzUJIdm/uWsfCdrjCK8FgmNOtGnBJGs4g+IcEwpxniZMCKMvJq6T9Y5hzbWUIgVyhFxxs0VlXerLZYucB22fTlRIbrcV3TJNmr+zlrrGa/kcgmNHUGXvLNZybZd5mRNDPBIpWlp9bvHiHWyJNjfdxJ/w9q2ah7oebmuaV1Y/8bA5OjrhJyn6TA2lUpgv3QOnOW5bpNobCbZZGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzTc+Ky3twYxoalB9EmWkcthoIWrmrW1gPHJzZkumOs=;
 b=Xz+P7r5bC9fLodUI/GcsSBfroW4r/30aNKajrElddD5scXc39Ga43TPlDMTVpBH0RWLXcpIXKk0YIDfpNKoQHmMA9IOmapP0LLMBdipBhdwic7ji5aSUCy3x7DQPiYlpd7v8mvvIg0zLe/STplH7lkshI+QhraWUPjIng04lXWvExHawoz8d7RV7le2g/PLDQfKp3py94BMAN/zecv8bhwNw9JKfUPYX2x5eXHauW9JXJTrfIQfrU+leMooLC74vHtA9vII2kGJgAUIm/kf/zc+ity4myvlJnVhkpdW9YznN0jcsHpREemfDNR7u6Y0KWCnbKoUGf0RonqvPza+zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzTc+Ky3twYxoalB9EmWkcthoIWrmrW1gPHJzZkumOs=;
 b=djXo/BgCscfx/uqJ01Ul5bmgCZIU7KDHhAMPNv3f6kFWmqouqTB3njL60GoWLF5UKTYqhrYr6OPmLnFFuLIn527OjWKAW+we9N/d6fRc7VfvF/zFBOsVDy+P2qJJPLfCnTdUb9mTgMpjpvCVbTW/g608DeKX5tjmeujx4p6Zfrs=
Received: from SV0P279CA0066.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::17)
 by VE1P190MB0912.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sat, 27 Nov
 2021 10:48:41 +0000
Received: from HE1EUR04FT040.eop-eur04.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::74) by SV0P279CA0066.outlook.office365.com
 (2603:10a6:f10:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Sat, 27 Nov 2021 10:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de;dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 HE1EUR04FT040.mail.protection.outlook.com (10.152.26.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Sat, 27 Nov 2021 10:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schleissheimer.de; s=dkim1; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AzTc+Ky3twYxoalB9EmWkcthoIWrmrW1gPHJzZkumOs=; b=Kduj2jMh6tmTJPX6MgBv6Lq2GF
        m9152LF2vKjRv13wpk5o954myGm0Akwq+eF60AZWvLUWQdn7U9PVOFLpLpRnt8IkPY0NySKgU+t1u
        IcR3XIGP4Xcw4SEnsslDJrYabsXCT3PS+91nnFsk5vj/jUuKso/U1nHVYDCNPvUJ3wQg=;
Received: from [192.168.10.165] (port=59684 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.94.2)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1mqvFw-0007XO-2Z; Sat, 27 Nov 2021 11:48:33 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
        BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
        BODY_SIZE_7000_LESS 0.000000, BODY_SIZE_900_999 0.000000,
        HTML_00_01 0.050000, HTML_00_10 0.050000, LEGITIMATE_SIGNS 0.000000,
        MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
        NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
        OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
        __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __CC_NAME 0.000000,
        __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000,
        __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000, __FUR_RDNS_SOPHOS 0.000000,
        __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
        __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
        __MIME_TEXT_P1 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
        __MULTIPLE_RCPTS_TO_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
        __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
        __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_REASONS 0.000000,
        __PHISH_SPEAR_REASONS2 0.000000, __SANE_MSGID 0.000000,
        __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
        __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
        __URI_NO_WWW 0.000000, __URI_NS 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 4.1.4, AntispamData: 2021.11.27.95716
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     john.efstathiades@pebblebay.com, kuba@kernel.org, andrew@lunn.ch
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of "0" if no IRQ is available
Date:   Sat, 27 Nov 2021 11:47:07 +0100
Message-Id: <20211127104707.2546-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf8570f-54c2-4999-1a43-08d9b1937a09
X-MS-TrafficTypeDiagnostic: VE1P190MB0912:
X-Microsoft-Antispam-PRVS: <VE1P190MB09121C71C3F468EF0451B06EDA649@VE1P190MB0912.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rekyjPXrE+hLP7G8+eSoYoeveJ5ffwyJ4656BJ22WSy9+TaWLzcpy4efeDoK0qo7qjSHScI1IzJNECjKfJBkh7R0UduBm9beKwcdR3KQsm9Tvojfwc88G3UWsaf12s60KwUA2VstNi0yy0Vq2wgWF4kh3UcTlg1tpbZcwhLEZo93UhWDAtY7msvlBZFGw6GISi/HCn5Q2FIccTfGJZ5QW7Cy6BXBBjotlA7z23uQ7BvSIdd9xyxj1e6z25s34nXSVGMoNypMFwwRBvrsKdv5Rhpl4ctnhNQ3NAxENuiAC+IfCHo49aNiOugXl7+C6JD6X4jCvISR8jACTFmUiFQ92mK3AmvDOBMNUzKPOwPjKC8nD4dkF+xP8Q6T2KFDTxG7ahsfkWFeLG8SzK6XTMzb1w6ITOODpXPzLAf9kdOBNJvX/wecxOCuffJKzBU/qDVsE/zVjQCTC/t0O1oqWWOC5/vzF2QPTbz6UdmgtmbMd7bMiEfZ8kC/yIVg/ffW3v68bFuMC3hYZL0t43nX4ntYp37hyQZGZmTcjGAh2vidgVQYhukR9BLf4eANHW5K7ZBL2C5Becd0R3xkp/VH6ndw3jDuDUEMijZcLdml4JFgnqUnzR5yt9h571sgqfEBgcVdjL4P7gzKRtng/W4pO9CG/80fON1Crt/5EPJMd9N8d0ZNOsOY5gkrAcHr9CXg7hHKU6mU3mWyzlkwOyf0F6e9Q==
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:mail.schleissheimer.de;CAT:NONE;SFS:(4636009)(136003)(39830400003)(346002)(376002)(396003)(46966006)(36840700001)(83380400001)(36860700001)(9786002)(47076005)(186003)(54906003)(7636003)(7596003)(8936002)(316002)(4744005)(508600001)(2906002)(70206006)(356005)(70586007)(36756003)(26005)(6666004)(2616005)(7696005)(426003)(5660300002)(82310400004)(1076003)(8676002)(4326008)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2021 10:48:41.4352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf8570f-54c2-4999-1a43-08d9b1937a09
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT040.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0912
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most systems request for IRQ 0 will fail, phylib will print an error message
and fall back to polling. To fix this set the phydev->irq to PHY_POLL if no IRQ
is available.

Fixes: cc89c323a30e ("lan78xx: Use irq_domain for phy interrupt from USB Int. EP")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
Changes v1->v2: Added "Fixes" and "Reviewed-by"
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 2bfb59ae0eaf..185e08c1af31 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2398,7 +2398,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	if (dev->domain_data.phyirq > 0)
 		phydev->irq = dev->domain_data.phyirq;
 	else
-		phydev->irq = 0;
+		phydev->irq = PHY_POLL;
 	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
 
 	/* set to AUTOMDIX */
-- 
2.17.1

