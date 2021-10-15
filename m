Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B781642E958
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhJOGwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:52:39 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:2306
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232058AbhJOGwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXWCqVJazQ7OlFK2yqVNQlvbzcisrDu9gy8v0l7hHhAZnzr3PNnL2VMglpUFYMy4uqX3OuoghPmUUrRC0eXgofW2Y8hn7aFfRAAzHPEzTGMhtP7CxE+WmJMnofDsQxw2Hqu/rOqG7j/4iy10nsOJqTwynMf5Y/PEMVcG9tXhGt2/57FvqneW9ldbwiv2fnejzKyzZQEqmL5VNY6eX/fFdygmyaBS23TugsHmzoMvmF764S4iaGuTf0Tq01SW+d3uLYXpDd4ezqYNaRgfTaPFCV5iNLsSeEKY1EhJR2RRe1K2VxSHSSs+VuACRMLpvzpzot06zW1jZzIKuco47hdX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCTYBL1wOeMnx0T+Polo/ImJBz5GPE+R3COAodX0eMI=;
 b=PX+BmTcc2VKJDGx1DBPjm3378xKLmLEHF+3MM5E3dlWs/8es4uaijAwxJ8TC9wCdJuMTaOvkJCyHo6KRTJxs090MhbI9hQJN8wXbD2q8+uV5Yw6WfD/cuYriHG9+U5BeBZpUMZIuwo+0coQwdRx1oo6iEtH1EfjgJRnGMIyb6KvHPJuv0fNi9vchZSxsn+pQyfWrEpKAmZj5hDM+34k0B2mCqDv6l8e+E9zt3zoXZ5Kqg5VK7kX8qghhJrD53KbpQzLM/nEy3xD8QVHxAckSAUeshYIN9B/ahfThznNhDAn8aopLJb8z/11nWaGO6+YRwJ45wYBmL6mcwYWlKA9xVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCTYBL1wOeMnx0T+Polo/ImJBz5GPE+R3COAodX0eMI=;
 b=UGuFxr+ivTOYOHMOJ1PYcgmsplT92xc2IkGuavIqTSlzqEjB273ErlPnrBxBhOWM9ynlgdbb/+cn+rjv1H/Ds6edngBT3a536Jhf+xob4QpFXXVESdEAIzKJyhCwtT6gABz1S498Be97g854nP+hb9usnj+eYgeB9lPSuVTNxzU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2777.apcprd06.prod.outlook.com (2603:1096:4:1a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.17; Fri, 15 Oct 2021 06:50:27 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:50:27 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] soc: bcm: brcmstb: Add of_node_put() in pm-mips
Date:   Fri, 15 Oct 2021 02:49:23 -0400
Message-Id: <20211015064958.9826-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR03CA0065.apcprd03.prod.outlook.com (2603:1096:202:17::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Fri, 15 Oct 2021 06:50:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edd9fe25-c19b-4175-3e5c-08d98fa811d8
X-MS-TrafficTypeDiagnostic: SG2PR06MB2777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB2777BE8D6211A4F3E5BDF28AABB99@SG2PR06MB2777.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZigGp5WMYevyOBCJ5fDdpSNRl9ArVG5oIwyCB3FEK6fCf+brjxIpOhBsEYLFnuVVKA8NKXIeJKz+RxmQuUL/s76NL2saw/ugYUnm1mHW2aIv7a8dqWnnsxDCj4JG4fDa9IaDKLbdpZhrnX1YkWIEJXroQkedxJpLyvxejcFtW/V1niyVY81U4gtq1Vqvcq0LJlxnSEttqI6cMraYhELk5wdlQxzj9ZUejtjVSIEhCwQtlF8kDCeem2roCk6nGEaLt8ARxqIGWWTEMIVspPbD/wzgd3YwUFSGk6X2qmgCCduv70VPZ45tuoCOy2WuivrsS9AwsKEwIPWBF5lcYYuMguPQkJwD+yIuMpYZY+Wo9fg4V098BUbM888XfcF9fhz7dQ6bULwZ9CJoLcd7bziIOJDR/Hh8ItOFpmK2tx8hbHWMKkOCN3m/le/o+so46rV0KpJDWTmvpWVE1BS7EMu5VzkFEWlThUNaIdVsCJFNX3Clq5SRqNU0hkkEHcko8jbnODNDIlr6Z6he8sWHXQirHzjqPRuImmrWD8PdyBUEIoWnnNMOjQwOsc4qop2pJAQ1WIoIFVcmB6TdBPL4WxITfTXztzT9ba62ZLOteovs8SVeWuRQznGlPGlPuVFa/36iG/ZNQysTlyxC5VD1rpQl6KjUXVm5R5NyMoHW5AYtW+6LluEhBzovLRF29gHpwaJ00bfRoulonJK2wMt10m3FePU8tIy8ZtJJqDh58yJtlKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(86362001)(6506007)(8936002)(5660300002)(110136005)(52116002)(4326008)(8676002)(4744005)(26005)(36756003)(6512007)(83380400001)(186003)(508600001)(316002)(66476007)(2906002)(38350700002)(66556008)(1076003)(66946007)(38100700002)(956004)(2616005)(133343001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14MO1nTpbWs6UGkXS6/sasTHOwGIfuCl6+41H+u7iacrcYh7I0NekFMMdP58?=
 =?us-ascii?Q?nOaCVfSz6J7/Y+whbwZGLBcYvh5ETnkKhwINeSOGvgaZ4hewLrNlb8WwomWc?=
 =?us-ascii?Q?wug/JKoAC8/zOm2X6TQoPgVh8S83L+AC+cYO8w32+qFqsaR9QyFP1qDk2OXW?=
 =?us-ascii?Q?0u3SUaCPWG2AcPGDVj7VV2FqUj08ZdUPqyefINr/3TwFSD9dribst6PlrjBV?=
 =?us-ascii?Q?kFbEH/GYocyIyEswm4FGeCjp9nsVfzAGzVDS8LBLJnhl01Pvi0Kim7vnT7OH?=
 =?us-ascii?Q?X3uvNgMdbPDqoeDXJnKgnpiH4Q67J/8zYOE1nbfr4cIPnAA+v8o4QmQaY0FD?=
 =?us-ascii?Q?+yIzcrNXJbthD4dVmbAdNySW2B7ujU8mVO9OOVprU8A7VouB71KkeYU4dfNV?=
 =?us-ascii?Q?C2ueolmwWjwkTR3fhxbl26f8P7Q5l/VyTGbcsDE34a3G99559Fy78zqglrw0?=
 =?us-ascii?Q?v+jX0smfgzwV9ob+l0ez94AmTSKO+kr0nX3sW3JTJWhQ1VptIRGCruEyrUU5?=
 =?us-ascii?Q?Jz3rHFqQrvrZBFzB8EoqA/e7424tnheFA5jy+AVdYnA5npokpf9Xtq+B/5TU?=
 =?us-ascii?Q?suHDEHovRgc2FARpXjfu83tsuHt8dB/qrI121zzXj4la0lIlJnClQvIrOVne?=
 =?us-ascii?Q?TXoQoElHnFnzbRS9cQAiwWCLrruKX+LLOnlV/R7YIiGJW1xmHrzJ8gTy6UoW?=
 =?us-ascii?Q?T5eDetqLk1/slz3L/nmMQFvQTJr5h6sjUqyDfIUljmFwG7GYsq99stTg2jeG?=
 =?us-ascii?Q?f7hFs/ukeI7l7YXQFu/LRBji0MWosrIcez52GlLkz4G8ul6qmwXLWU/MD8JQ?=
 =?us-ascii?Q?gYChVe+B6buZJjIJmntCsKjEUsmvm30ftnklXa8vBVyFo8v0iDVlq6DOixhU?=
 =?us-ascii?Q?qw38k4VXoLj8E9LjaDCKWQx9iW1PWaqVZMtX4raIEJPqt5oEM+v/hGSGgl5j?=
 =?us-ascii?Q?9J1KJhta4XBzDYuoayxhXfGcKUrp00P4UuLe8gR0x7ScIw6ojqLeoT9jPLcN?=
 =?us-ascii?Q?/83HP1k9IODkHF0kl4NISkL6ercLkCBGS2ZWPbQaEeVfKJvM7SxxKKQPouYL?=
 =?us-ascii?Q?acRxVxQNAlM1UIjKBvhrE+IuyS6HISsk946Qi2/w1xxEf4geAcwhCIWVmdYq?=
 =?us-ascii?Q?ZDxcY6RsdRqFWMeMavIUpR2NXCo63z3aG7l73CWBaVrV8kvEB4F+QkBGfaXW?=
 =?us-ascii?Q?yEL/XpNK2hbGpCGsjklM3DJ7jysBct/LzB7296QzR9NAc8CFW/D+dTeRPHhH?=
 =?us-ascii?Q?OniWrcHWgFqGPVngn3greDgs7XbKZpfb1TgoFFhhKR3kvRryHZp6au/jiuq+?=
 =?us-ascii?Q?ER7OwZCz8EeMnC7OnxQrxosS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9fe25-c19b-4175-3e5c-08d98fa811d8
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:50:26.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llONUdURaZQ4cFm1DhbfzrY2YVuXmuSuqAJC9O3keARIMbr76y+CnlHgJx5FeNs6xBp3KqHPWGNDQMfNnOpJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/soc/bcm/brcmstb/pm/pm-mips.c:404:1-23: WARNING: Function
for_each_matching_node should have of_node_put() before goto or break

Early exits from for_each_matching_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-mips.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-mips.c b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
index cdc3e387f049..4dfb5a85032b 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-mips.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-mips.c
@@ -405,11 +405,14 @@ static int brcmstb_pm_init(void)
 		i = ctrl.num_memc;
 		if (i >= MAX_NUM_MEMC) {
 			pr_warn("Too many MEMCs (max %d)\n", MAX_NUM_MEMC);
+			of_node_put(dn);
 			break;
 		}
 		base = brcmstb_ioremap_node(dn, 0);
-		if (IS_ERR(base))
+		if (IS_ERR(base)) {
+			of_node_put(dn);
 			goto ddr_err;
+		}
 
 		ctrl.memcs[i].ddr_phy_base = base;
 		ctrl.num_memc++;
-- 
2.20.1

