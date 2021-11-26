Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29B045F0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378067AbhKZPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:34:26 -0500
Received: from mail-am6eur05on2133.outbound.protection.outlook.com ([40.107.22.133]:19145
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378028AbhKZPcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:32:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KutxveZB7W1YRujBPJmx4EFso8FbmowcByCU+0C8+Syz5rys7MFWIxhfWgoRGd5zc87hYQXBpFEsAj35HgMO/xeGpotZrPLy7CB3LnzzS/wELBRmLQp994xfvVJVgfqw6qStPhIayHcuPzRoZx8BHgnh3J99RDB0AIssJpoYHU8mhnFUx/lrOGHtXHIqBHu6aOMJ1yTt1UUwuNby2LEn1ZeFYmFcT48UacAqX4XE3YtsISMB47BwT9bdL62w/V+ZDQFRG6N+6+3VunejpBlgb2WLhClJl0ZZ1tux3x9avQBoq1z6JEj/k9gk1RNDCRwMuMbPAsUwUVfujbIM8TcKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdVQ34VT/ZygNj9IXyiql+K3P2n1ZV5VmOcNgYFc6Kg=;
 b=Bv6RNGQ6oaahfUawdHMwLhsqvJEDOk3kxE8UgPV9mtj8dSblaNvoJL9nzJsmEvkyRF2BIjaWincgPSMuK0IQReUuK7oEdV1Bx7FUCZos6pB2IzNp8r4ABHOhuomgxk8R/+tEpPHZhRfyj1BR7dUUmXI+4Kzr31+UsxsKGAABONUMsaYa9/gyNOtCr1SMSi7+2DMlMOvlLPfr83HAuPjMEpThzw8ugTiwz9uZ69eSGqyARSgxDvNPcda7JTiJQQMKBYkspRRXNjVi0YtHqe8OHtENgR6Cy0WNB5EIlXw0LAEQaCrJhxwVR9fGtj9Kj18Ptsiaa5fyZgzLjpllqmmvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdVQ34VT/ZygNj9IXyiql+K3P2n1ZV5VmOcNgYFc6Kg=;
 b=kUf2JijC+pWfXXSawsgs1ntiHiAGICXHZuONnd8vuHuMK5iUoJqZUKHmJs7COjaQsH0M4MbBOjp1Oxn03CLyEJ6hgLrGXDTcjEpcULUOeR2K+f4gds3xwRWKdxzfWO+XD9raLpTV7f+yQagbuwchqHeGvHtkgyvZxa6jEUuBi1Q=
Received: from AS9PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:20b:48b::17)
 by AM5P190MB0324.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:23::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 15:29:11 +0000
Received: from VI1EUR04FT015.eop-eur04.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::88) by AS9PR04CA0064.outlook.office365.com
 (2603:10a6:20b:48b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 15:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de;dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 VI1EUR04FT015.mail.protection.outlook.com (10.152.28.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schleissheimer.de; s=dkim1; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zdVQ34VT/ZygNj9IXyiql+K3P2n1ZV5VmOcNgYFc6Kg=; b=PMxaTtIiZwgkK69tcQfG/yvqvk
        5qToe8EC9h2G42oT3Vnsme1TpsWS3anHXuO7mEWJEowMNnXFoeplkZscnPK4O6QZ4iKxinoYB9GhP
        qACVUxraws/P4jVDsCAuNC0wC7KkR+nve8XUNQ/FFpOQPTbWgc8qErP0nDgeeF/GeTNU=;
Received: from [192.168.10.165] (port=46366 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.94.2)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1mqd9v-0006gE-08; Fri, 26 Nov 2021 16:29:07 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
        BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
        BODY_SIZE_600_699 0.000000, BODY_SIZE_7000_LESS 0.000000,
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
        __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_SPEAR_STRUCTURE_2 0.000000,
        __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
        __SUBJ_STARTS_S_BRACKETS 0.000000, __URI_MAILTO 0.000000,
        __URI_NO_WWW 0.000000, __URI_NS 0.000000
X-SASI-Probability: 19%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 4.1.4, AntispamData: 2021.11.26.144216
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: lp50xx: remove unused variable
Date:   Fri, 26 Nov 2021 16:28:46 +0100
Message-Id: <20211126152847.11740-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e96936c0-9fb3-491d-f894-08d9b0f17ec0
X-MS-TrafficTypeDiagnostic: AM5P190MB0324:
X-Microsoft-Antispam-PRVS: <AM5P190MB0324599370F99201E055F394D3639@AM5P190MB0324.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQ+rEJSVWUHfm/WNgETejuFqtvacWZzWzD8tnotiu4UvAK0jS+Ysv7GcM9cIRMu+ZoEQiSzLZpTrT54vl/9FyMp1iy73gEJBAn+qAxFJbGP3bMZ6DucVZxsl8Tf21pFo1h+kZkEYr4VAC9D7JPBd5pi8Df8zktmIZD6a/gSfBR1WZyiyKGZaciXdffmarUr8d9G8aDrWYYpw9jGwbvcjjs2eHHzdvi1RFi39PqaskvSu88BljsojfdWjavJlraCCQvgtTFMuUF9yb97b3SRNvycUff2JYpWbtW8JiAQxxKBdBRRim3iJzDv0OW/c/dkgEtCzAIV88nl5oIsmONZJZAJ+feNixm5EJOXQS+IbEs8148n/u3PMFxgtZtw6C646crMC+2WfMh7rP+kjRJpR1MXPotWPXX23wgRmyoGaRQGlM9BegYjhsqH7LkdqtMjsnFeUY159Slb9dkAFWCmSHiEzH++tSk6xF/ByA1qJhxLvQDGEZuYPVZ2AceifEEAyhr4JGS2+XVh2N6DEA48BAt0VpV+J/8JieVjkarRz/ru6SLETN9bHPMvdhVjU5sPQ76jvwC8zoBnUYtGf9AoyoBq8kjno1wZU5pLA32J5dpTfybKXPTcsJ5Thfh57y30aiUd9/isexwo51U9VYFe4c/sxumx3eHCXOJYP9mzUHswdBFl1E7euGB/MVkMGevhHqWCEn3u0murIDeEkOG9YMm3o7MZzO9/cVwpD+ZBh5ac=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:www.schleissheimer.de;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39830400003)(36840700001)(46966006)(2906002)(82310400004)(7636003)(109986005)(8676002)(2616005)(26005)(7696005)(9786002)(316002)(186003)(6666004)(47076005)(336012)(1076003)(36756003)(426003)(4744005)(70206006)(83380400001)(70586007)(508600001)(5660300002)(4326008)(36860700001)(8936002)(356005)(54906003)(266003);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:29:10.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96936c0-9fb3-491d-f894-08d9b0f17ec0
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT015.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0324
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During code review this unused variable was found. Remove it.

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>
---
 drivers/leds/leds-lp50xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-lp50xx.c b/drivers/leds/leds-lp50xx.c
index 401df1e2e05d..50b195ff96ca 100644
--- a/drivers/leds/leds-lp50xx.c
+++ b/drivers/leds/leds-lp50xx.c
@@ -266,7 +266,6 @@ struct lp50xx_led {
 	struct led_classdev_mc mc_cdev;
 	struct lp50xx *priv;
 	unsigned long bank_modules;
-	int led_intensity[LP50XX_LEDS_PER_MODULE];
 	u8 ctrl_bank_enabled;
 	int led_number;
 };
-- 
2.17.1

