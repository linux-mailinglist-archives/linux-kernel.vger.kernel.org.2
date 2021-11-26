Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6345F08C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377991AbhKZP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:26:27 -0500
Received: from mail-db8eur05on2092.outbound.protection.outlook.com ([40.107.20.92]:44625
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352552AbhKZPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USo1l//KA1wqyWWjm7QclCpNh0bUwyEtk5xC7FVp6f0AQwOAlAtxm5/fSqvo++AWQ3OQbsZPTEqMH8xzD3SNfFEm1Km955hBUL1JEXsTTd1MjEmyDcMDpfmZHu5NYmK9/j/dUo1xydMk9kosq9VWGx96MUTsOsmkg+1YabeG/iJau14vF8bLcRjzDp0ogp6uHM09+xnw6mvYKTEY/JRzS1UD8OAsbyNwgxjXslC8w6JljT6ADMOkpohw8pYSBkJvtg9FZioG540QAUSZIEL2wVKlYuHQc3pz3Usc8nRxlyUzRtfuiRSbbhNXzZ7PSRlCfnkH2DFjG7bF/NAS/fCh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y8PsXp3Fe9PfRlSmIhxIeAxMV+Sb4vq5cDHy25MOiI=;
 b=VBWekgb4gy37nBuu0fcx58fV2o6Nfmr2Ym6PbrqgZGexwQMdMe40IQ0opoLfE62OTb7IJC4/xH9ba5QCN3gk8z6hwzSILVnTVNrfuSbt2lmrEIbshywPy8IyDw7RJBwZu7F7bqY2otspBNcr9AV2kTEsmpHYABkpW6ICjs6LWOww865pSjLysloqBpur47czDY0Bb929GtMSgDrk46Us2WxdMVD8u6ty6khmlpStGQwEI1JWf0iSuJ4Hi01oPHBnGjjkEwNyDtkYZo7oIJ3w/WRlh31BSwHtgEC+nlAtwW481siERqh8FqyEWCdYMKQisr7R0mneKnhAsEZ8E3nIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y8PsXp3Fe9PfRlSmIhxIeAxMV+Sb4vq5cDHy25MOiI=;
 b=jr8FarWFFlF2Gnoyn2i4G8SLqCwfJTjFJ6Y8Yxq0vIPjwC39JKke9vGuy7/7wFzUUrvAB9iZd46PhTWMgAXsTRpSKUwbBC+lcqzcAS0/6SL+M2t+vq97lAESJlgDBOxpZSx+bmrPyGW8/ktIarJFRyj9FnTFRBY00hHs453xN7o=
Received: from SV0P279CA0001.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::6) by
 AM7P190MB0693.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:118::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Fri, 26 Nov 2021 15:21:11 +0000
Received: from HE1EUR04FT046.eop-eur04.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::d9) by SV0P279CA0001.outlook.office365.com
 (2603:10a6:f10:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 15:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de;dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 HE1EUR04FT046.mail.protection.outlook.com (10.152.26.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schleissheimer.de; s=dkim1; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4y8PsXp3Fe9PfRlSmIhxIeAxMV+Sb4vq5cDHy25MOiI=; b=XByJgvrE+aSAlU8ON8CQq/i0ts
        rHSapQIbcyYEulcu9mXtEmDBVLXMzMRcPLfcyPFhAwaESvhWTWn/TYWn6NdjKidBL1rikphrQ+GI0
        4hMySDkzYavXcW+K0zKEPb+/NLrTEQHMPZHpPA7YSY9dr3wPOAMw0p9+mBujjqW4dRsk=;
Received: from [192.168.10.165] (port=46364 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.94.2)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1mqd24-0006GU-2o; Fri, 26 Nov 2021 16:21:01 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
        BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
        BODY_SIZE_7000_LESS 0.000000, BODY_SIZE_700_799 0.000000,
        HTML_00_01 0.050000, HTML_00_10 0.050000, LEGITIMATE_SIGNS 0.000000,
        MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
        NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
        OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
        TO_EMPTY 2.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
        __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
        __CC_REAL_NAMES 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
        __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
        __HAS_MSGID 0.000000, __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000,
        __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
        __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
        __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
        __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_REASONS 0.000000,
        __PHISH_SPEAR_REASONS2 0.000000, __PHISH_SPEAR_STRUCTURE_2 0.000000,
        __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
        __SUBJ_STARTS_S_BRACKETS 0.000000, __URI_MAILTO 0.000000,
        __URI_NO_WWW 0.000000, __URI_NS 0.000000
X-SASI-Probability: 19%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 4.1.4, AntispamData: 2021.11.26.144216
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of "0" if no IRQ is available
Date:   Fri, 26 Nov 2021 16:20:40 +0100
Message-Id: <20211126152040.29058-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e4815b-dcb4-4719-1217-08d9b0f060ba
X-MS-TrafficTypeDiagnostic: AM7P190MB0693:
X-Microsoft-Antispam-PRVS: <AM7P190MB06936F4ACB852CBCA7E40BC8D3639@AM7P190MB0693.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InwbKVeTdfime+Ssx5eLmavMCXT2P1XQE79YElSoA1JfE862MQmxA4hb42yheKt/nY5cpih3rfPNto3DV3Xv4B5Hx3hNHySYrpc8oFVTawQm65qJSQqQqHeoFF1+iPw28j0bMYhBxMYyqXaCUXIMmW4ZJfSzK2IB5vyo0k6BCmWGAkzAyDxx9zXl6xLEwBZ6o1xeSsrT2gvWc06W9PLAAudtwQycVXGwXETpDGPQFzKZ+qXa+yTg3C00EVEwcR2gjfWMCTW5ks9MD1aItJ5J/d5mbMnvKOtgnIDdl3yF4BY8DgW6o8EgidOymr3ruxOgGbOaGfBPV00jmxE7T9X08+YZ2nfQvY5d7m/+idWC2H4uxbrsp2h8t9DjwYjtItIqYsUK3gNNc1yvFcP/pp8nfOE+N7hfPBwqP7HgCX1//B6EG4TsYo7Slcf0PhpYQmnDm7ULCRvK6bGZMKAf9WEY4hFtzrly39L9wbfcvCnD22U9TF5qia8v/jrNmZUHPaBIsnCFCOZHMd5hy1ISlJR/1UEHYXFABDfGGaIRLBIL0YGBHxrwFKgR3OqGhMQ8PHe62QVT2RTs1On36/UhYf5yKqo2EWD4muN9KLyvEqkubCbxDMik1bzml4zU8/rr1EeAC7A9yHAPkw+A1XXqd3HDXz7wTAUp4KisTz7Uf/Sl61Z/Khh8yZ4HfnDW++AD7l/oeJInVFzuGFgmd40kFRQEIimauKLf64Ud1liwXnramyE=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:www.schleissheimer.de;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(346002)(136003)(36840700001)(46966006)(8676002)(9786002)(186003)(70586007)(336012)(109986005)(36860700001)(54906003)(26005)(508600001)(6666004)(356005)(82310400004)(1076003)(83380400001)(7636003)(426003)(36756003)(4326008)(2616005)(47076005)(4744005)(8936002)(316002)(7696005)(2906002)(5660300002)(70206006)(266003);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:21:11.0133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e4815b-dcb4-4719-1217-08d9b0f060ba
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT046.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0693
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most systems request for IRQ 0 will fail, phylib will print an error message
and fall back to polling. To fix this set the phydev->irq to PHY_POLL if no IRQ
is available.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
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

