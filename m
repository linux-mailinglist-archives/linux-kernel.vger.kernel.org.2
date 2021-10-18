Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB1430D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhJRBfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:35:48 -0400
Received: from mail-eopbgr1300099.outbound.protection.outlook.com ([40.107.130.99]:55635
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231426AbhJRBfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcMaMvub6GtIxGKlC98PSMMGMJAJjz7d+Q44/JQ2gUCzT6LnQu9qsQjjG38HKQD/O+e7MuyT0oSc7em0xz74+dKKK3gRE4SP4/vlLkcp6jFDzVgwGBFY3NIvrZSH99kNq2cCSMRprAzHOSCSP5WEYMeuqyWpxTP1qWrNhlH1XwF1DH4LZLxh6M+Hl8JswJSA4NhYwkAqzZLnU3mkzoVN7oJ92lzixePQyzLFF8lOCXkgvEsYBs3as6wI11xpXnXLBOek76+3piFQNUccfKweb+49YfnH2hZJ12wGdup+5TCwteBoNQpHIcqMLKMMch+066ZGwvtGUza/YXkM70eBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKyHK6IZw0tIzxhT4TcXRqbiVyGSqCFiBH6ald+cwqU=;
 b=nJ8xVI40azSJB7eT7+fK7oNo+/WgEi3oLGW5xigzMuJaoTGXlj0/MFUW3BoBAqSi8FKjmK/h76Wx1B3Q33kpJXRCwz4JW5wpQIYofmIUqMzwqNJa4XfdIUlWdDJn5z7ieS71ZvHPUqRpNh04Wko/RTumCQYDgWQLjxAq26BpI2B/ib/4MMcdG0YuOMjaSVVzccti7VfUWAfyyOGZOOdIeP2vMEzmkKnZLl1EkAA/rmZb5HJsHnGiNY27oMVm5SeFMaarE5MtuarIjOHbkdKEm0AURlTgQlqRoqgp+mCdYmewcF8iuITJDoWeLMGhhT6Vd+xgzdaJIAkgOfQUPa/B7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKyHK6IZw0tIzxhT4TcXRqbiVyGSqCFiBH6ald+cwqU=;
 b=EtfF2M94hOAgzrCjUnP1uVGKY6RdNQfelkYSh+o7YydV1w2cf5FDjccLgY0LucCMuSaN9wZkGyOFcxbW6l9+zCaXU1lBirrx+063CxfTSYKmVdyizrq0x/FdZkAJBpbVb3jsmStjS8g4VOhfH+wEFmj/XASF9ZsMKrncgEFeM+s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2523.apcprd06.prod.outlook.com (2603:1096:4:5e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Mon, 18 Oct 2021 01:33:32 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 01:33:32 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mailbox: cmdq: Add of_node_put() before return
Date:   Sun, 17 Oct 2021 21:33:14 -0400
Message-Id: <20211018013314.4535-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR03CA0045.apcprd03.prod.outlook.com (2603:1096:202:17::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.11 via Frontend Transport; Mon, 18 Oct 2021 01:33:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a793ecab-29e0-4f06-1830-08d991d74bb1
X-MS-TrafficTypeDiagnostic: SG2PR06MB2523:
X-Microsoft-Antispam-PRVS: <SG2PR06MB25234491FA1FF48C80D08153ABBC9@SG2PR06MB2523.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wJ81/C7p171eozBohZz2EEGwstyLk0k40uOGzKR1SCGvOyyfmi2f6pM8wQVu6YrYJ+dNmHWb4GyxaOxtXhIkEXh0kqNDag2ZexbenjaescyntavHnG/mGjDyxK2WY+0zxs2zCT7BwA8bMzNh9D2Aa5GYqW0ilhtipwe9VK7V60u/yje3tRkyVEmthv5Kgo05sQI88GZ9s0+/JN3go1k9WICTDPK5fo8CQm+KxWabTfu1SjKFM6tn+FyvMwlRUfKJrmwgkkBISG/EQ81GplKmClf2vZzleQSzTXM24VIRfRbjbrXEDzdOKVIIXyhfG2GMd1wVrrTJU6k0s3rAhWuCzqSFkeYod9c9EEMJt/cvWjMdehoNX0kAz5Lhg1vQves+jAfWJfq6kBX/Br8s6fPLpFyTlHP++Sf2Faf1oqnpaZozhx3wjl673cBq52ZN7xsszYZCFBAWrHzitfSWlC1gyR2e+8bhAhNcPh6eQNgL6otSSK5JUl8QqWoW9AH7brfxV4FbSdQbZvTJW0vdGopyqIXpsrTyVKqCUoiiaINIEfj2qfwqZ7/px56sWPUMnZGJdYozDxcB4qfdfqn58I9tqMx0HlFk+CP3UBg0YRCkheZspkbrzgRXZeiMFT8Cr8ZRHtZ5lVqqXi/49SyZqIAhMp0TVsBj0xQn6GzqHRo74VEVkSy5tGimPGD4/z9kuO7XXk6sldPaIJcm4Jv3avOCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(86362001)(6512007)(26005)(316002)(5660300002)(36756003)(186003)(6486002)(6506007)(83380400001)(956004)(38100700002)(38350700002)(4326008)(15650500001)(66556008)(4744005)(66476007)(2906002)(107886003)(66946007)(110136005)(6666004)(2616005)(8676002)(508600001)(8936002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?foqm3gmdo5zYt1fWAw3ALBvZltqcWhAna9h3jMjYYq3OAVrhtgX9+FK+bfTu?=
 =?us-ascii?Q?1gwlKxSW7ahmxlbfspjVi18+PJ3D8xi2PNY1A7y79EGYVCx1ua6gDf3icWoX?=
 =?us-ascii?Q?95gqd7lEoanqA3wUOaI0l/PkHUOnP8mt8xRUpp5KIO1oyUF3sztlExG8jBAT?=
 =?us-ascii?Q?h37RScA5GHWfDbunI7woHFhXhou6WsytXna+qfTE10zvyU5RrqYwAL/VrL8j?=
 =?us-ascii?Q?Zdf5kCJFiiEO9KFe2gqtLfhIDNiIbGCczXo1Z995S+5RkWqiPVO1BRjgiBbI?=
 =?us-ascii?Q?A/WUwi8spHRpdfcvM8eH4Qz9upqwiAnBGRDaolM0GrE9SuHADLYOfOjhGN71?=
 =?us-ascii?Q?WUBuGVNUfbo4Fe/44JrBDuWeJWDAV0k13M4uWuBXG1nqKpYkPR0jj4N/z1oX?=
 =?us-ascii?Q?zM2uSkFH+O4dTwOhevW7ggDEnsgN47m86SvryWvKI4GUBUg1EBl+vfNoWww/?=
 =?us-ascii?Q?qxquXxbr70i3Rp0JmiUan281eC1letGQOiJ6GYoj1IBXzJWTs76DveBGAxgT?=
 =?us-ascii?Q?vB1y73/R21XhRSap0CYZJG6RYOlCEdaN09qEJIhWI4sQfVP5XRXou7LXffr4?=
 =?us-ascii?Q?/U0BFJ/HJDaIF+G0sEzT3XohAdYkKwMaX5X6n6wJJg9OVYnV2NZ8uTn/0Elk?=
 =?us-ascii?Q?rnZBbxB+s4+40L33L+cpL8MMozxCvA4T26OFbLzpn2UB0spw2LOnpkk6xaae?=
 =?us-ascii?Q?quzOf32UqROg6vJUQfuzTlKsE8dtdYSgmnxo6+PZeFVNq5/qGHjyRsfuhYMU?=
 =?us-ascii?Q?8hpGRSekhigXF6WltXHbHCbt5pZHQn/zmeqDRi+EneDSgkoy619H9O7iociK?=
 =?us-ascii?Q?9ZIPtE/bm/BvmB7FD8tRHZ0deDfB1ZjT4he9ozCw8RVAYRhptqiu8ckOPGVq?=
 =?us-ascii?Q?eKK3RT2ncnNgqwaVwJUVFNC4edxjy1NTQIi2ne9d6VLndAnw4JP8hAzZ8btg?=
 =?us-ascii?Q?B8Gt4RZfbd9rEHwTX0OOgFv0k26g7mJmnCHlMwULl9uiMVd2lODwfDkLpU91?=
 =?us-ascii?Q?sSprq0jYUHU+w3PYzKdlwPO3OPp3vt9SWLWW+1Gf2ZaeabKx5ijiNX9VS/pf?=
 =?us-ascii?Q?B3axTNL730mpenKrtQirqLA553gcPnRa+2SiH5tvmDWEQ3Kd7/L5LkOsfpTJ?=
 =?us-ascii?Q?BWNafzv/5qNl3YIMO8jw2CrytdWMMW3er8SBfVVT7ppWG//HIbFKduN0+r0J?=
 =?us-ascii?Q?osIk9PWkytG08NuU7CmR0PrwuD1fbvuU4GH9uEfTp9hfavzT6V/+qV8cmpMT?=
 =?us-ascii?Q?XJVUBf5UDYp7iGvQ8hK8NBHCbjgHJdV46EwfaMP22l5V7IYT0eXnG7k9S0tC?=
 =?us-ascii?Q?B0REsiSxGUXofMAxsjWEG/Q6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a793ecab-29e0-4f06-1830-08d991d74bb1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 01:33:32.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K09SZG7s9LMOx5sMYOou4+NLFWmmoyumv4tvHLkTEo7DI3PT1NqSK37+BkffPd9hPVHTacnWdvLL6Yw/nLy1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/mailbox/mtk-cmdq-mailbox.c:572:2-24: WARNING: Function
for_each_child_of_node should have of_node_put() before return

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 64175a893312..ab4f42cc987d 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -579,6 +579,7 @@ static int cmdq_probe(struct platform_device *pdev)
 				cmdq->clocks[alias_id].clk = of_clk_get(node, 0);
 				if (IS_ERR(cmdq->clocks[alias_id].clk)) {
 					dev_err(dev, "failed to get gce clk: %d\n", alias_id);
+					of_node_put(node);
 					return PTR_ERR(cmdq->clocks[alias_id].clk);
 				}
 			}
-- 
2.20.1

