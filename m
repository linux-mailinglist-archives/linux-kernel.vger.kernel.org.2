Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3B3738BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 12:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhEEKnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 06:43:39 -0400
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:58624
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232825AbhEEKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 06:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/RbGE2IwXaybD8S2hjHht4CMnAgQQQBrgGXlJNAyDX4B/ThIQbf+eMNRQKzTU3/82e1THaXyBz2aUuUvYWgw+wQEH/9Kwn0Xm++bIHRdi+gp7sAcuQXYXtwERUnAGsGOjR2ACL8VrF8a1oAbuD6piq/2Q1GOYxnsIWQ8BpqnBAQ2iDPAtEZlTiCyByIR6yz1Fpc5/wqguYzKT5kVK4Khh4VHN5nwmg4ZYTFtd+Ry5gIqhNZymMpsLz41FW1DJhMZqBZ9GxPalT0c+FMW5zd5V3kXBwIUr0jIV8bPtd5PH6RDcoEj8nWiWJf5VRFk/HgcJqbdssNPTarev9xOsu6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=OTzRBjA+OPoxJLuw+u1GyXMZjbpokYygolQD2FSel4nXMGGtzWtqRcGz830SRZg1qU99k8IGHIFe5wfgUpTtcgXLrT/lQwtAgVNhj+0GRZot611V6zY5xYJdYD3V9SJRxxyjKuw3Xmmqj8A0Yhmb3LU5SbaQft/V/DQtheJ5huBYCAeq9uqog6cSGIA0IeCYJtBHUxgBtw90PYau7h6EHSAOcOCkBkYDTlm0qEh9oZiJ0LHFFS60uUg0PF2j3scG9tlzqX2nRKD2vlmHpUATCnLmK3iOejIZAtPA7xBiUonN/jYGANbtKduossikJQbCQpVyMXcFEsXU7aO9ltyzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SnCIBDpkalgVVVF+P5DhCWVkYmPO42eKylJiRGYr0U=;
 b=G+m5NDrqvdvQbpZT9ZdNwqG8PSBRxGJqGSw2j3FrdtGoE4Qm/kDkY/SZximjQGmrz4T4OaYy2g2KvGW01ynfZZTQDcWspsEX9bFALa+WPsR4sh3YFyTsDqbpT8sB9bt8Xl8DLNfgCtta+R8hj+bziJBW79oF0ewFl8fS5aNbb1QRTYNWWGA/hp93AL00+LAdqPruzTP6Ey0hYDzBe6BaZC0gQ03XjW/z72Cs6WVIEAcwuuvEdUXpJZVSC/NaUezX3hWIU7k7lQirM7UfqKPA/j2wrcU6S1YOZAiLAzFVxyflL0bQYKGIGbpH8sA2Ot2uuUc5n2u2gdb9yBUO9bOktw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
 by HE1PR06MB3948.eurprd06.prod.outlook.com (2603:10a6:7:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 10:42:32 +0000
Received: from HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4]) by HE1PR0602MB3449.eurprd06.prod.outlook.com
 ([fe80::9ca0:8dd:38d7:c7d4%7]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 10:42:32 +0000
From:   Nandor Han <nandor.han@vaisala.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Nandor Han <nandor.han@vaisala.com>
Subject: [PATCH v4 3/4] nvmem: snvs_lpgpr: use cell stride for regmap size calculation
Date:   Wed,  5 May 2021 13:42:20 +0300
Message-Id: <9cf842f712282916d210da975d60d70908f1c37b.1620211180.git.nandor.han@vaisala.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1620211180.git.nandor.han@vaisala.com>
References: <cover.1620211180.git.nandor.han@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [193.143.230.131]
X-ClientProxiedBy: HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33)
 To HE1PR0602MB3449.eurprd06.prod.outlook.com (2603:10a6:7:8a::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (193.143.230.131) by HE1P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 10:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be1c183d-6616-4602-6650-08d90fb27c36
X-MS-TrafficTypeDiagnostic: HE1PR06MB3948:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR06MB3948A50D299F25AA9B14802E85599@HE1PR06MB3948.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xwbbe1ZwystVlYe+H6B1RrA5Ow3NAebs55TtXaiFwJRAz4RLplOfk0BSXkjT67HLw8XcopD1z+od0upIlDel/CYKvr8H4E27wOMJ358GEj3LUSf510gghR3Fn5EuuXhMeWt1awG5gWtGxaJeqpAIO+S0JfinTrOCmBrd8vZV65Trjdv0YAi0NeygTlyT+k3e6RTqSQw0sSnLq3P/CdDnQwT8s7KB1LN6Q77arxANuGI4qvO9UUHnlV9NI3AkKoZdplJKp6bYgKWs2dvfyvTIf7lFWEP4K5Yltav3KwWvQc7u4UvMRVMzRnr56iJnESZNdhVQdzdUw+ocHuuuRZAQD0yAcY2Zy5tSjaC/QtIxyla8DU+L6IgnAjEeWt8/NOLeHuYJf5UlVasR67VCOpgy5mp5ucCBixDqmzbZXvLMpMVaFUNiqRih63YSM7ly1fSsQK7uvlFNUGvJfnnsCVHHOfDSGn5G59SgC/jIXioviCPqfhcQMvc3IrLsAS4MwR1e4f5/DWmrBEZJh62RBQMVCp7Shx6pqvtt4080V5UntJF1J9dLn785SLTzzKiWr7qWCuqRS8Pfyrmd05Db+7qrwua7xEaZFhWe6lHp0kvkb/DrlibYoZcOPMxkWEXBmQG5EW2VQaPyU9F2ZG5Q5ExDuOfkll0M5zDOy6Bjvaw5GBvVeu7D9Z0Z1ZTg+Y5GzdW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3449.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(8676002)(107886003)(6486002)(316002)(5660300002)(16526019)(4326008)(86362001)(186003)(8936002)(83380400001)(26005)(38100700002)(38350700002)(2616005)(956004)(478600001)(2906002)(66946007)(6506007)(6666004)(52116002)(66556008)(66476007)(44832011)(36756003)(6512007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6gsY7bvHeJ1a0HUzsYke4cDgcD2wB30TSi1eufcJ4aa/vqPlJ6U+GRmxADa/?=
 =?us-ascii?Q?OYQyzWi9BhqxqyPNanEZouJEq6mQiaH5Q6BEFXRS0cxXM6tFoQ+fAISJkqEo?=
 =?us-ascii?Q?VDMYks2qt3pDdUN902jGWcUERglWdxg7D3xWVmQD2ABPhxdroL9RW9OQOraj?=
 =?us-ascii?Q?NQzuGrz5p/qwDxZZX2Bc7NNmZMEaeUzMSnIIMmzPScKC4Emlnn/hx8pnXzKH?=
 =?us-ascii?Q?vQuiGlfOjTyOdePF5G0UJ9ow439h1F06gKBbf6Pe1vq4M6OHGUQzMOGN5YVD?=
 =?us-ascii?Q?6TZvetxCHm3AjuyTEelhOfpLeHecO3PEGYxkTXfzcWiQNvFK5YkjVzP1Cd0e?=
 =?us-ascii?Q?rmkZJzZXsgc2wBL3KoXHrMqRSvILzBHZ4sOuth51Zyef7EmRzmOvScuXDAJN?=
 =?us-ascii?Q?T2jv7PUbfyl/d0v4AucQb0J7W9ZtV7LFC3TPK+c4zKGMXIE4jhbnbIEdDU7B?=
 =?us-ascii?Q?ezDdqMUNXi7XJC+dR90YVI2w3aFyxNiSlYIfZdQGPXx7G6fSCck4cWm+z9DB?=
 =?us-ascii?Q?RHXFqO7xz/4jPtN313TvzZsGdc6e2k5ynIT9HWOep8B3ClYpAdAa9GlFyhPl?=
 =?us-ascii?Q?LV855NsTN1Y0US0XIasylGpcGB1C7WMehtMmOa29Urci/v+nhnrMnK0RQd1j?=
 =?us-ascii?Q?fXMgc3B6GMuhCkuFZxFA/s58CKp2Gb3RraO6qWd5wQJOybyuAPrdWkNQG/jL?=
 =?us-ascii?Q?lCUay6ktbBptEz6C9tPSxzoQ+px9GGWCpo7T73tbr4P9SnsAA+AYNac/QJr8?=
 =?us-ascii?Q?5E9n2EH9++ImPCPSUzUS54PExG838c/C12lfrbWCBTURXeyMG7Amo0jhwQkz?=
 =?us-ascii?Q?Gkt3FiSNtVyMmo49NuNu1E/KJxcwjY4Dz7e3KuVrmgjo5dIKZIaNlv0y9HzH?=
 =?us-ascii?Q?X6IS9fH9cW3l+cyEL5kdT4w0OWEkQhw/z37hE+NFawidujfmTCAG/9rTcUvm?=
 =?us-ascii?Q?ICVZHsDbi26f4Y7DBxbi/oZTGmdgBgjtUAVxnsrFNMDjUiTcxHoC/SMvDS6S?=
 =?us-ascii?Q?nnQEf9URqhA/kKPoLmGMi9fjs7GK5sWtxwBEtcE1BYvJuZuwCHSMXvid/y3o?=
 =?us-ascii?Q?cA5ClxsrstUrjki5elPv61KzWjWt0LnvFO9XZrswmcQXmtmBPRuHeR0I2AFZ?=
 =?us-ascii?Q?tkcUJMQN2w2uV5MDnEKhNtg5k76BdSXzdxHEOYdymLUmEVzcjYW56zJC1BNn?=
 =?us-ascii?Q?SXeydTTkXpNozGN1YpXDVhM9vqUbsl2jW6e+wqHrhbJZLluzNR1nnYIuafKg?=
 =?us-ascii?Q?FCh/MyUikkcS5memScV7OKarjV9ptaJOZFJL0ohfQJml81CXEjVUXFeq9mMj?=
 =?us-ascii?Q?GHiWi0oH5LT8/zw28cXfw5T9?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1c183d-6616-4602-6650-08d90fb27c36
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3449.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 10:42:31.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eME5+UcF2lj1tyj6jsdD9nzs+WKebL74yI5rq10bDJm+HFyasSmOi/pO9hBy01w50m7ScTj+/Kk7rtCWisW8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR06MB3948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a hard-coded value for calculating the number of registers to read
makes future changes more challenging.

Change the calculation to use the NVMEM cell stride instead of a hard
coded value. This will allow specifying different NVMEM cell sizes.

Signed-off-by: Nandor Han <nandor.han@vaisala.com>
---
 drivers/nvmem/snvs_lpgpr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index 4692aa985bd6..35457421314a 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -72,7 +72,7 @@ static int snvs_lpgpr_write(void *context, unsigned int offset, void *val,
 		return -EPERM;
 
 	return regmap_bulk_write(priv->regmap, dcfg->offset + offset, val,
-				bytes / 4);
+				 bytes / priv->cfg.stride);
 }
 
 static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
@@ -81,8 +81,8 @@ static int snvs_lpgpr_read(void *context, unsigned int offset, void *val,
 	struct snvs_lpgpr_priv *priv = context;
 	const struct snvs_lpgpr_cfg *dcfg = priv->dcfg;
 
-	return regmap_bulk_read(priv->regmap, dcfg->offset + offset,
-			       val, bytes / 4);
+	return regmap_bulk_read(priv->regmap, dcfg->offset + offset, val,
+				bytes / priv->cfg.stride);
 }
 
 static int snvs_lpgpr_probe(struct platform_device *pdev)
-- 
2.26.3

