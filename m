Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730F3356305
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbhDGFZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:25:58 -0400
Received: from mail-bn8nam08on2045.outbound.protection.outlook.com ([40.107.100.45]:41184
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235474AbhDGFZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAzf+TjCvlzAPtKMK6fCsL1jHWCWbwM4S4f9Vnt/EW12Gs/SpS/PnnYTRZM0wfX7RpwrIaWZ3K4wzUdek8Y3n3nTjT3S1ZP3BOSAn+4hSxmJxBdq849H4iuqZeLUmat2O9pazuGn0afleMp2WpKM76+brHy9z9iVxWnxNvvOa6ybuG2ZjvRDHVSDItwtR6qo3SMcnh2LgAlfPYgGmB5hufW5L4NIXXsSbGlzI0OQAH0De59wpKFqSJiJ5TuTduQtoPHdXXXlHqv4nNgvh/8xbZcTk1Qp5qv9kg7cOLlcoe7nzH4LuLYxJ5l61n9EIJe0NJl0e9z4CxCbXUvHFhS1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rddZH7zPm5VEE2CdAMzH3dnTzxoe8rZyMZ9SMkiRSY0=;
 b=RU3Dx5ZLqQ51vy1J3XTBeO6Yg8OXwuUMIlTKPvPNzlIo8Nlar1xp0W6e78yGKlqJ4hh5yCcE0G2/+6VfWEX17P+ycNRz3q4hKNiJoLvgc2pKh5wXeZtL929oFnmmTfqF4qa3265S1+YDLxlNWSAqiym3zYvnA4gpWVDS9CZdB0cWBhFpIMdqAIM9lbKlrv/WL+Wxzrn63aE5IVk8Iz7iFs4MtMV/5tRWhFrv17ZE3feq5xHvK3SqNi7naG22VZ51DOkPNWB9S0IjpBsF3+umX2ntWeXXWjNOt/in8HGc14KAmMCB98qTeVQ5Z9fqBOdZOxi9zbVVxnrdWeUaZw3/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rddZH7zPm5VEE2CdAMzH3dnTzxoe8rZyMZ9SMkiRSY0=;
 b=oDx5ovFUMfMBO4j0Q7ag7oy7xUyvlrip1UMl7WG8ISv5mv+YvZR67cFwkbf9rPzRkjaO3Poex3Kn4u11Q+ustNwAr9+TYeDTiw07ycoBO09qjveKrS/tqX9Lc4EBMgYFZejswYVFCc/8CLfamOsYROnxr+t3oTbmhkiVJmwPVek=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 05:25:45 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::35d1:d393:5e05:4efa]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::35d1:d393:5e05:4efa%7]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 05:25:45 +0000
From:   Meng.Li@windriver.com
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        meng.li@windriver.com
Subject: [PATCH] mfd: syscon: free the allocated name field of struct regmap_config
Date:   Wed,  7 Apr 2021 13:25:25 +0800
Message-Id: <20210407052525.27592-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:203:c8::6) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HKAPR03CA0001.apcprd03.prod.outlook.com (2603:1096:203:c8::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Wed, 7 Apr 2021 05:25:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4dbb225-d0ee-4c7e-0b5d-08d8f9859836
X-MS-TrafficTypeDiagnostic: PH0PR11MB4936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB49369A5FB9336B7DA64844E2F1759@PH0PR11MB4936.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeKimz255zRmMDCkmCcq2GL35txpPsUGmCJ/TbKcUs2NUyP4ry7JUIER4Cha1aANoWKJcbnQMdEj/JtabIFwtbe6neonfEPlGYCiWOQfQUFlxCn89RRwQecnu9yGbAHwzkOVWT+l+Iw6BHYhSMhL7vSycutmvtYVGvKKB7MbcNFQf1xkV5IgUCCgpbnDaUppceIPqaWlJTmoC5ZwHrnSHRaQMpP0bR80QJ31hKLvIiNG4aMlOcc7hSNHAbwmez17DUiF6fMB0Ze1HkTI1NfgPp69QENyP8BLe2WdVaFrnwPF2oaulC6CnWrVzVUi7GHJz/6dMOIasI29J2AUcsTM9n3bCdEBgtA/vJ1WTig4LXkPYBmW1LrnQEtQ07DVmX7l8JX5xyjuoRMfcyA5i/63x22su7yjj+cL2YMiC7tms5pBWa/RU4tMUutlu5VjHm+aEYnUbwP5fGbNjwERr0EICj4eRsjkT6+GFZ1lnqpvZi+ts/VYwXcPqKlAImiRbW1DF7bSd1sYn7Ss7tPY2+X3pKmcHYe17tvNGPQcNGNMZny4msvbtCzrpUxQk8QfDCzMndEVYITJoF+f1WbI8oKKa3YlPTjpBMyXIUBIPa6qA14q/5NIF+mtF6CUv8dzhJyzFOO9zg7rIpI4vidkDr7A3J00Ro2RpawYSP0o2j2gjShoEnto3tdBLYWIS5vF7Prp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(346002)(136003)(376002)(956004)(36756003)(2616005)(6512007)(6506007)(86362001)(9686003)(6916009)(66476007)(66946007)(66556008)(8676002)(6486002)(38100700001)(5660300002)(26005)(4326008)(83380400001)(186003)(6666004)(316002)(16526019)(478600001)(8936002)(1076003)(107886003)(52116002)(38350700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/6mshaXB+xIH1/2JqXZFKGDE8hwIJtBxVFUIP2HU4eriIQ8jwXTQkGfi9IFU?=
 =?us-ascii?Q?wNPe0vvaBTl5yOB/RbksmDGnV81RE2UkaRLtwaTrVXQU+sRIwtaerrDQC3gH?=
 =?us-ascii?Q?zkCdsLNtnTTg8UjpGPIH7366mZRX/G3kzALCjk6vyB/ZUtjtZKbNMYKOpd2L?=
 =?us-ascii?Q?SZBxgue8Q9BF77H8zJTxYs7+HOeQkgdNxD+GT81Cb6/zW2aRJhAowUKw62RB?=
 =?us-ascii?Q?kjvBS0Ze0OH+2vnRwBMpsK8jZrL/OtbnbmOTKNwsyF5UTiQxJfuKDu6hf7oP?=
 =?us-ascii?Q?REAmRNmXFACDlCcbC9Oci7UTeKnaNB/yc75uKVGO3NmC2tW7oN6DYGqCO9w3?=
 =?us-ascii?Q?gzCSbTd697Lu1smOVSCjgrF2zYonb+W1o+aJPdpDlBlAprOXL+XvHj9W2k06?=
 =?us-ascii?Q?LZJVnjQdpVtWsZ0qh5ZKfOYR9wR0UIh4PSAiK3RZ3vOOcsbSVYT0m8XD520m?=
 =?us-ascii?Q?tgllQsKJ/3nmSnT651zwq8+Yuq9HHQ6WMT0LsErtf8whQu3Ept4kqwzQ5GDi?=
 =?us-ascii?Q?qpj0PB2o7CZezLsyARmkSYgmTaOGmJIaJdo6OG349hnwi3d7OqcXGKGhaKdc?=
 =?us-ascii?Q?h7fw/g5LZ4BmGEL8xPwOrqbqp+PpCje4a5us4MQziqTZY38upytZ+GbOZILa?=
 =?us-ascii?Q?XfGD1TmrAVTu8klwnGc/JnmVfvfK9mSKn1dc2AhlLHnrBn5pUcLDeMGPXy7e?=
 =?us-ascii?Q?xq6yKqsWr202Gk+PPO8gOXhRdaaqzHixfPdoMaAyYt1TAHS87JSdhsUgBRME?=
 =?us-ascii?Q?o22X+UTOwJQdjxjhcK7yp2CLquIOreU40WHGcGApqqPBebOFeJntM8Xa/J8V?=
 =?us-ascii?Q?l25lumHvLcpPM5vom/SQc/9BfY6ms6TPa0NBFkLt0oKmXqjrso/QVIh5J6ul?=
 =?us-ascii?Q?QFNgmhP5ps+bWi6M9G5r9B9kehg7S+EhK1e5l2YWLA33nAEufBPRZ4mj9Vka?=
 =?us-ascii?Q?aF8rkSlS2/S/unciedK1v42AxGvWUCS/t8BrBbCjXQajs0JKZT/2E1HmFaNN?=
 =?us-ascii?Q?dmLADxbNCWd7GyPrTKImzNl/tN+Hxj3BB+kq/lk3tN7pgp3L6Pfz0uuNuUCv?=
 =?us-ascii?Q?fFfeIcpbjmbdLOwye/4mAk8+GUnaVJNKBobIPsXmHJfD+tKULeSLMZpsfszK?=
 =?us-ascii?Q?8c9oWbPHv/D5EyJWyJ2CmnEcbM0yZCyUaGcNYCaUWQAhjkfMsVFacH25xYRR?=
 =?us-ascii?Q?kqxYSTl6vWl6P6Sb7qcg6Vtc/ceB2r2n1SQI9t0jU3FJqCClwpzP9OJoiNEY?=
 =?us-ascii?Q?+M7zAHoUzkt9t/JXrwTdgGL1TMz/gj+5imGexEF6yI+UcaIqWBjZevHhXGhk?=
 =?us-ascii?Q?16KCpwMD/mJH4m36PoTEDArp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dbb225-d0ee-4c7e-0b5d-08d8f9859836
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 05:25:45.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXL9czg1qCQVN5R4N+nFhMZC6lHgoaSIsPnFrMIzcl3Mq9c8fQ71STR4j7kLyeWFiETzP181dypZ7t3FbjCteA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Limeng <Meng.Li@windriver.com>

The commit 529a1101212a("mfd: syscon: Don't free allocated name
for regmap_config") doesn't free the allocated name field of struct
regmap_config, but introduce a memory leak. There is another
commit 94cc89eb8fa5("regmap: debugfs: Fix handling of name string
for debugfs init delays") fixing this debugfs init issue from root
cause. With this fixing, the name field in struct regmap_debugfs_node
is removed. When initialize debugfs for syscon driver, the name
field of struct regmap_config is not used anymore. So, the allocated
name field of struct regmap_config is need to be freed directly after
regmap initialization to avoid memory leak.

Fixes: 529a1101212a("mfd: syscon: Don't free allocated name for regmap_config")
Cc: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca465794ea9c..df5cebb372a5 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -108,6 +108,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
+	kfree(syscon_config.name);
 	if (IS_ERR(regmap)) {
 		pr_err("regmap init failed\n");
 		ret = PTR_ERR(regmap);
@@ -144,7 +145,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
-	kfree(syscon_config.name);
 err_map:
 	kfree(syscon);
 	return ERR_PTR(ret);
-- 
2.17.1

