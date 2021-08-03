Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D23DE8F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhHCIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:52:34 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:59680
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234615AbhHCIwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:52:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXiUZ9j4bfYpvnM+YU+0RuTOXCQ86cq3DOPTJY9JGOyvKFNOTiApmF/uNm3b7KLSinmcOQnHLdYoZ1hwqtI4ZsrtObKJPwLevkoQ7qykmO6QZKZvf6G129tAwXxgr1QAJmrnSTRfkN5FqHM4UiXWWUf6sFeuKd8nlKwFPKQ6BQuCVGOhXeocwqsP+48lFrVmGwufPfZK/nm4VyOYOjFEWkKJwdx3zH5TiuEYCLX3F8JTyaXGw9tcVjwpxcKZe1tYL871rNukEM+IMWU+nNV1SXynlKdHQlPjQO1nOe8MABO3oQmh1gnoIoCUaEZQ4fBX+yV+pg0L9gtn6ehJFzeH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpnIzRWe0ppgf5zI2jxetoMJggABBVHgv821PC6mS38=;
 b=LH7FhF5flRKJ21n0N9F5e77Em6/wNAFfI9BF57mbz4d/lqRRh/8SHlbp24v7VAzQvCkumLAiAsFfm0h8czH3POLuM47peWgVThBpAsYPFdJcvtp2gaBw+a7NHDQjvklmYQL/YbQ9EqHUi5NlNPYwgJq2aXXRmOtp5yiK7R+Yr5zRQwGWXdevk5BOGQ1Zkv401IhW0mgHEFZWj84C/mSrSk1fJwKghsHcJrebnN3M1WQyh9pu6dCazm41MJt8+EVG2lHLRvG7YLtGK8MZgTTRamXxal7XW5vhuZgr0eOt34LYtgdSspq/uNee3za6C/PJCmi9gUSe3ubzIC2zeMZh3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpnIzRWe0ppgf5zI2jxetoMJggABBVHgv821PC6mS38=;
 b=TEdFAO72S4IhfLT8UXAGFJXxecurQ2+oS1/oHs2kVEyNXwUJ1fyyIF5YWvLNY0VQQG1LeDCLmJUyL8YgcWaAzXQ5Bhp8NaDVZ+p2tKYscXnoDA5CTW520lRZ1MU1IkqreGjtj85es1QAOQDBcPXivov9hDpAoJAM1rMVCM6bmjA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2291.namprd03.prod.outlook.com (2a01:111:e400:c5f0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 08:52:19 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:52:19 +0000
Date:   Tue, 3 Aug 2021 16:52:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: sy8827n: Enable REGCACHE_FLAT
Message-ID: <20210803165211.3b00db29@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::17) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:e0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend Transport; Tue, 3 Aug 2021 08:52:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d24a1d-aff1-4291-4e26-08d9565c0039
X-MS-TrafficTypeDiagnostic: BN3PR03MB2291:
X-Microsoft-Antispam-PRVS: <BN3PR03MB229166E89C306FA850F5EE7CEDF09@BN3PR03MB2291.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSUW/AewWZ+vo6Tr3gUoEFKnY7qIMG4xkIm9I8sQ3kXu/m+5BUCsUSkPS7BlsTrX++qMWrUU+SIGdA3XxtNc9zSjOh7bryi0yl4vReWXHzgijwBZEyeeYsb6oMyy0877N7pld9RK8wlY3+YCJtSzdfjv2c8xtPSLUlvt2hS0gOe+VPIemO3NONrOEQDe+X1oZuYEWFiSgQBm/Gp1rYgFyEXNTHD0ljx51aXsfeelp22nHefxb5fxM5VBcxilStiCmIYb/I+4hzl66DkbkPXfzJOcbuOMna1VzWkNh2+7djZh9Syt/jhxlyjCiYHaFHqJXccwir5h378AptEskLS8XFuSWt4LXbcJHwbsHdA+P1Eoy94sa3rJQguY/6fSG2qVmewlXm+100RFuBHqA07tYfIR8xuRnJxgihnrgB/DqtPomHg6GaBTU+HT1QtNfKlkTXLXZoNEcKabGsh8jNrdB/doz24/8wfBFSohRp2JqmR6v+lOc7/6O/DrYfncG7He9uR8Jb6IoyxqIRejyww/repNL9RfuAsLG7WQUusVXZkX5HGzI/cMZ1ZSdQluOKRehfuVD0A8Tu7IX9dTBBTjiLGpPVD9h0xkU64LnLWUk5kRayU6ZQ+LIgY1dAwBr6iT3s3v4E30aHPX6YqutQbghaLnpbs4bc2RZe+ibrvIkhdPfbPRmwTemWWRRUurpkS652pQpiBfPVZMUZ8hFJgcMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(396003)(136003)(366004)(376002)(478600001)(8936002)(186003)(316002)(8676002)(83380400001)(9686003)(5660300002)(4326008)(2906002)(7696005)(52116002)(26005)(66946007)(66556008)(66476007)(55016002)(6506007)(38100700002)(86362001)(38350700002)(110136005)(6666004)(956004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLosCNKgHfj0dqV2WkLI4MdkcE5C1gn5Dw7YFDPsdJD2wGXMwE/QtIEVqsgQ?=
 =?us-ascii?Q?/Cur/JKx2GiwEp5BpIXblRwUljXrgoD4uMqrrHv1lZ20wUgMHpR+I5SM3JPF?=
 =?us-ascii?Q?fy+FEEUmBbTXBxypYaFmzyB5uDUeurx0x440GH/RAQrqGmcGDvjXUts25res?=
 =?us-ascii?Q?gO2tW9j0j9Al+T+7YIKMCwoi1molz8gH9vBV0jkMaWHXMCpGuWZey9DS6DdY?=
 =?us-ascii?Q?Z1TmDxu13ycIbqQxGylLpBamWQUVONiKEyqaWychl0olkus3xfBQKVP3L+xf?=
 =?us-ascii?Q?OpKWX8gU+MpSGSHTlUF2LAZgBuy1g52UC+ucWfq5ceMLEzlsYGIH+VuHAsY8?=
 =?us-ascii?Q?3cHUhMpNSSRpuVxx+EXbM6CrkmOopl41+ZHvQOlkjUqOSQNkj0Jk4FuExFXN?=
 =?us-ascii?Q?eGSKzzYIk7+ufQdampQ/IR56rIMPHZ7HVsiasnVJ5YhNYCwZiwbBpMuvgcxd?=
 =?us-ascii?Q?okBtT0bEbwqqQ65tzVjA6etxgSQmmuSES79He2NBeq/8QjP9i8JloWOZjWF6?=
 =?us-ascii?Q?bTqotHiQxsahurE815qXJLnrMrWtE448ei6h0+6ySNXP8bhbRq7u/yGGa2sX?=
 =?us-ascii?Q?J5l4nH0rlbpojFJOYJYMxKDv94+kyVglzFr8J6AQcMbetB/x3YaWsdnQEgmz?=
 =?us-ascii?Q?yB3z5JqXX+OuL2J3XbT7Bwvoof5I95/fGkmXXsjqfFX3MacC3wduz75XJJsl?=
 =?us-ascii?Q?twSylvXdYOEABpqdsXpKcha8dv8vvofy+COTCchQChpksTzJlBmBDfPhT0+C?=
 =?us-ascii?Q?N844Nrq0JJMSWNvEfupJ6XZEXnJz7FbBIVIXuu6WpadvzEgSk2GBaTszbZfy?=
 =?us-ascii?Q?JZEwDWjj4Osfstv9ee3T8uwSqcvhuK4JYiozfTQGDUQab8MaO9/K3JFKwcsS?=
 =?us-ascii?Q?9gIK5+Aw0LVNnrGb7tOyq+F0IPCCtK/rBJuNINkPkyFvwOQNkvzyjh+FNrtQ?=
 =?us-ascii?Q?Y1dUp6nCPfpJQfr6fCiFo6yF+paQpkM/Q/VPhIyrkEgUABTY38DuXpumKuVL?=
 =?us-ascii?Q?6h+hwShYhM8RduHO7i0c3yyN454IrKqWSjn2fkUR4kjFY2Jwmltw1zHpdOjt?=
 =?us-ascii?Q?bP3TiUUA5n7MHg4KzkPEvyPxXcw6hKlWMH+cfOG9jtB3ApMETHIrs2aaGtST?=
 =?us-ascii?Q?dc/ODq11mb1sjvyTA7+zmy1UIyRSJhhoC54MVoBMvPI2k9b5pAnxtIRZCwuh?=
 =?us-ascii?Q?Iy9kIiT8tYoe3KQmIvwNmIpn7uCqlpQz6+Ac9dBjRQGx0og7gADvozPFymzy?=
 =?us-ascii?Q?gwvaxMnKHZqSszx2rivW+kxfXUTmTzD4wMFKtFje1PEgBh4Xln2gE+y7vpVn?=
 =?us-ascii?Q?/7JOVKf7T4ttV4RVoGkdroVM?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d24a1d-aff1-4291-4e26-08d9565c0039
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 08:52:19.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xetlxedwpfVLzZnR4UgXD1LD1xOK6H68xTGj/PfoCuhmRaO1RR0MQ55RKIHZSksa9cafvXyKv0re1GsLq3tyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2291
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable regmap cache to reduce i2c transactions and corresponding
interrupts if regulator is accessed frequently. Since the register map
is small, we use a FLAT regmap cache.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8827n.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
index 52e8c17afe24..7d5d9f879ce3 100644
--- a/drivers/regulator/sy8827n.c
+++ b/drivers/regulator/sy8827n.c
@@ -19,6 +19,10 @@
 #define   SY8827N_MODE		(1 << 6)
 #define SY8827N_VSEL1		1
 #define SY8827N_CTRL		2
+#define SY8827N_ID1		3
+#define SY8827N_ID2		4
+#define SY8827N_PGOOD		5
+#define SY8827N_MAX		(SY8827N_PGOOD + 1)
 
 #define SY8827N_NVOLTAGES	64
 #define SY8827N_VSELMIN		600000
@@ -102,9 +106,19 @@ static int sy8827n_regulator_register(struct sy8827n_device_info *di,
 	return PTR_ERR_OR_ZERO(rdev);
 }
 
+static bool sy8827n_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == SY8827N_PGOOD)
+		return true;
+	return false;
+}
+
 static const struct regmap_config sy8827n_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.volatile_reg = sy8827n_volatile_reg,
+	.num_reg_defaults_raw = SY8827N_MAX,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int sy8827n_i2c_probe(struct i2c_client *client)
-- 
2.32.0

