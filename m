Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBC31DA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBQNcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:32:47 -0500
Received: from mail-oln040092253050.outbound.protection.outlook.com ([40.92.253.50]:40263
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232952AbhBQNan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arXwFNLdUuiJkOAYeqZ5YBzNDsywkCPd1VIvaIxqLk/f1c9XRgiaAj6Q7ZfrmR9AMmCWB2V+Jchs1NeBCnmOlGMqyty2wiHbOtdBbd+jLOrn4zWEfbEOtZdE7vzdDiFbsai7+dzIU9cipudjmOaMc7knhEV/YGSQxR2poCMI3vkEopLrhzNbSLQ0Qs66ZExdcajOadFVqtnRXcpGV+gUC4J9Zy9OzQmjdkNDwiBYxG7B0gR+f2t8uY85nCaCeAWYh7FK/jsx3WbKgY/YdLf3k7Pv6O1D4nhDNRfh4EOwi3rtDg4ZO8vy2o47zA19ztePy0wNryI7H+jTML18qkWsoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MgxC2qaZxvf7J5xdNrqsc7eecKgkTDwqKn4xdzaeOE=;
 b=NNZSS+VpxkNo0MOafIGO0wcf+XMJaz/uLT19Or/G3Cb56MkCG/jx0TKeynhbwyQOmGHkG4S7LmJ5xrtB5XdGLqDGUUdD3PGpSYtrgQ/IVf8/1MLERFzPMUE0fKgpMKHROQQW8RnJiICqicYwj2HMKejGi2OWMrWOVRN73cteu7T6ymnPjDBWtF2l/LAieEBqnnnayX/9C8V2aBogPbBU7CA4RXT7Rh+KJhEFU6t6G6h3qO8kEMj2ay/11pj9GAP3ffZaHJ91VYT9Ar02mzrW40EByyWJOatkDf4XolytnPRNJxecnqPOLjR9ZzLDK9CPZk/AoKRm1lQ7BcB6g608Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MgxC2qaZxvf7J5xdNrqsc7eecKgkTDwqKn4xdzaeOE=;
 b=WrBXOayRQvvxbxx+b4WyshEp3PD9wjK2IfGelXZPf3Cy5xGKYtfgzPmAKuKs7ttNVqKvi+d+2It0sXvrI0KDoxYG8L4JRPV2l4iq+aZjmsLjktkNiTteipePryJneQynWWRssQpb94b9Gs3qnzEKbXf7QrADwSybu8pKlrqCjXUdKYiGaGStO7rdkoCpC5odZntWtCrcEnRyICxp90NgOlbV5E13/cmpSolQQEAR+ilsqXiZIiqtBIqEsPnJVB+Fb30VlPsnP7bnt6cn+2I32aUy6onTKKRgB+lFjcAlMgtgS2bZZbnufJr7dTHjMAJ/DqcT3e6fyi48rDjookuBwQ==
Received: from SG2APC01FT064.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::40) by
 SG2APC01HT234.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::415)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 17 Feb
 2021 13:29:07 +0000
Received: from PS1PR04MB2934.apcprd04.prod.outlook.com
 (2a01:111:e400:7ebd::51) by SG2APC01FT064.mail.protection.outlook.com
 (2a01:111:e400:7ebd::485) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 17 Feb 2021 13:29:07 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:6130FFD0CD96B75942081AB38902EDCBD4A29F15B42E6C479BDA44E6AEB2A417;UpperCasedChecksum:EFF893FFD8E45B6016E05CFB75C9D76FB803AF1B122606E58E239FAD46DCDBEB;SizeAsReceived:7413;Count:45
Received: from PS1PR04MB2934.apcprd04.prod.outlook.com
 ([fe80::55d8:45ac:a6c8:b297]) by PS1PR04MB2934.apcprd04.prod.outlook.com
 ([fe80::55d8:45ac:a6c8:b297%3]) with mapi id 15.20.3846.041; Wed, 17 Feb 2021
 13:29:07 +0000
From:   mayanksuman@live.com
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        rcy@google.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Mayank Suman <mayanksuman@live.com>
Subject: [PATCH] staging: gasket Fix comparision with Null
Date:   Wed, 17 Feb 2021 18:58:16 +0530
Message-ID: <PS1PR04MB2934DD6390C8B16DB832BC97D6869@PS1PR04MB2934.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Y6YqTrph77TB5Z9sLm7lbWegjxJ02Hqk]
X-ClientProxiedBy: BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::24) To PS1PR04MB2934.apcprd04.prod.outlook.com
 (2603:1096:803:3e::21)
X-Microsoft-Original-Message-ID: <20210217132815.28169-1-mayanksuman@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (103.127.101.170) by BMXPR01CA0038.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 13:29:04 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e65fd6a4-04b4-4ffd-b205-08d8d348001d
X-MS-Exchange-SLBlob-MailProps: 7MJMDUNTCtzhjgYstnB+mPbk1hxdpSWr6ZMlOIB9vplQwgMYnezalEwYUmeQVAFmG6hPm3P9OaqAte8clyKuVroVbmOITOJ/gtW7V0j4mNFeNfc+up4VfnnpTrQoh8Kf8sW98SWNrBAEJCxZujTqV51IhshyWtZOTTaTSISd920FB0vOZ2wkz6w5PhsOaVqQTNfRhnB9wwf+5pm6Kv925bSHz77oZyesCB7G9SJfPo632MBdnn40jpYwU6V6dZbnRBYVRyQNrzuC7KTfQqZWi2dfgvrnu+bZ3iixEKtM98aX0FIq9/hUt//QL56cwcUtx4Yqz3Pisq3xQVRUzm3w5pilD1DLPhSZ82jyCp8owN3AnpoxVA25tEoDTlag6nfPfTxJtl/sRTh3YiWhesi4G0zBqF2zjMz0btnQQnAfj65kogC9/IGFZAMssqYQ6T/Jrp9kgDOETRIBn/uk5vto33/iZL+pZCYbvuWDABf2Emy7J2BPO29Id9kJBY3E5R3+n890slZQ98jOB2jc4c3fk3TEEkBM+gsKIguO7cN5TbD5uC1xsY+smBQ775imVJmyI93yeFbF5SMGBkyVTFNFnGyg2YQvEBSlvwS2W4Cf+qsaNGLOjD7crgbo1hJ8aJ9uPu9t74AEiQLX9aFYBe2RENf7kWv3aawzMCfhIcHvGfhO01p9PGMTQzJvoVkbuJuWFtpDsb2g9F2qxA6FQH9KfaM0/KwlqHY/O4TF1gCtZD0+aSKb5m6Cpw==
X-MS-TrafficTypeDiagnostic: SG2APC01HT234:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Q+WecJaBpbrzLolR2sTn29c0XqR57ZwDMAD+oXEmH0+mzoYS19O5xmcBB3xn8YwefCLKpEkE2ppjT7OQF7l1KvIl0sqVTfV5o5BLMVVcPwfkTaKDrOHkZEwNW87nsg3PBdF/PY6HKuS9OTJqcadwRMca3ofXZT2FHDXIWxCaVuV0g1YgOkeoM4MkJjPXaSd1rMJjb27JgsNxgUUsxM1V2H2+cUJ1QFJR292kRY+FwZ2uelV4gZrckTN5XMMuUmplXR35V3rCYuzmizd1LHbU8moSUmvDo3aqwoSXLQirXEI/08Eb8eXGn30gjR0Vb5QZ39ZLPpuStWwE/0y6LXEW1/aAVAC8s7Psj0WWiajA9u1+HZR2r3Vrno3Y5NlUXCe
X-MS-Exchange-AntiSpam-MessageData: ovpLHVKLEDDQ95IXOGaFBLF8T151VAT0rzJ9LVvO9dOR13xEPnCcdh1scOANrEH3Fbt6xEgpdDRDP2sIZXajRs9EEDFpS8uq6fo2Wvuz2YEZkXvdnwvWilzRJUBDJpT9ER7Wbp0r6KseuCFJalXbUA==
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65fd6a4-04b4-4ffd-b205-08d8d348001d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 13:29:07.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT064.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mayank Suman <mayanksuman@live.com>

The change was suggested by checkpatch.pl.

Signed-off-by: Mayank Suman <mayanksuman@live.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index af26bc9f1..c5658fdf4 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -228,7 +228,7 @@ int gasket_sysfs_create_entries(struct device *device,
 	}
 
 	mutex_lock(&mapping->mutex);
-	for (i = 0; attrs[i].attr.attr.name != NULL; i++) {
+	for (i = 0; attrs[i].attr.attr.name; i++) {
 		if (mapping->attribute_count == GASKET_SYSFS_MAX_NODES) {
 			dev_err(device,
 				"Maximum number of sysfs nodes reached for device\n");
-- 
2.30.0

