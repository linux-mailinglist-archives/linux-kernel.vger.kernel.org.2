Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4945C3E01AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhHDNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:11 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:35169
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238356AbhHDNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcUpoKEXHWFSo4u52sZLYe52SQmwBNB/gmVx7W3I7SNKeu6nS5hHiLvkHKOh3Kie3hepeI5gNU0Q+bGO37NVj+liu8swkIVAKiX+p54MiGySU0AbbRz21eXsSpyfkiMyF3taZptq7U4o8JYl18vej71rIn+C55KgkvwYqLHtbFgL/KS0ZsVnnf+r0hKiboq0rwrs6tf/+B51DAT6RmzON/fA8Qa6FHSaWdnjr7s4Y0VFCSti9cRFYjDc6/NyvG5zw6Evi/SXmbNHC6S+mxqOpyExE3b646qWW4U8aW2zPlTdnsWmaYXSBdVZyT7YOnE3s0x8OSPUFh8ghPlIwpoQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QINOo2EK78jKgw9jFciPQM5txgvEv01vBABX65mvvBE=;
 b=BI2tt527KPnxvWlXbGJeRfb31qYetYkqXZYyQCBxgtvpjz8CEhbKGZ8oXhzWqDGw8rTl/Hgzi2vOdLcnd5ljioDArmNFaEI0ZDzIpnIbcYE5dxSn4UaI6TixrEAx92Rd5NFLhQ44oFulNs0fKxoePyn+Y+zxDfzhUn8+jErDn4lBXrvVlxwz9yVDDVprMMU9/RP9nGwk5fDrkfH5DjRSbCTbf0Sh0dwDBqcKSYHuIlAvbRlxWywzxFQeUCvM6l3WmghBHJSyJhhRwaet4D6WYRV0v/K4OqNmXRSwTALPImgnUYlIMPIMBCsBWKyV/9Lz1DO9zFCU5VENxynYimsazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QINOo2EK78jKgw9jFciPQM5txgvEv01vBABX65mvvBE=;
 b=FGPv7j+IYGqGHSDZ+4vIVRiZfyPHbwzSdo2RPl8WSEsz5MSHvRMOkRVGpXnSkimdi9LBIQqnHCwg/9nEBlx/Zf6l2+F9x/DMo7kk60VI3ydm1LVoGPBiGWAVRyr3bcR9CZ0r4bzH/Kv4Dx3OhIxHZx8Q/57x9PxNdv/oJbPM7Uk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:52 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:52 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 4/7] arm64: dts: rockchip: enable io domains for rk356x
Date:   Wed,  4 Aug 2021 15:06:22 +0200
Message-Id: <20210804130625.15449-5-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804130625.15449-1-michael.riesch@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7408e878-a8a8-4e39-5126-08d95748ba27
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5401E02886EB42568CB9A616F2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6T55nFzzvEEKdvVw8s+J2TLBJIX3XSY9PIVjTRRP/6n4MEcRcVfTsyBPoCrzptjjqaWPYWUN3DHqZfIgkfwRI7UBShcWfI4L3belW2ZPnIi+mr8B+KPa7sMvd7JYnwFzHuXh7nn2QTWCK4KHDTWXmrSw4Jd/SqLsPDMPf0qyW8YaJahaW5zk9wfjXSqu/c57C1QPLcsuGpObQSsw3KamjE1z7lGRBu+cq9EHzCMeoDa6NY8YbYspBjKyGifiYaoVF+vqL9S0arqP6s2uZNZxDolMOdgNtj9BqROTfCHmVKezfu9aty/o/x+aVCEkoWwaA7Zb9b+ZTq3o8yXiZDh9BvNDfsB83jhtmF5Vc9SkD8A4Ujrzalo7loqTL3MECBVPW7ivsLUcOfAIG/H8fL6h+pGP+ln1yeOBSzSprbeX+sIjNxha6IcFIDzr98iknb5YFJOefL/yHilIemaB9bGpxw+qJOMnxxpqbHxKBHcB+mnqZZvoFZa4EITOVtQENo5bzmXD948oOtT/v1j9NLIG/ne3BNkk+ywPLOePDBxTBt811+WziMQ8S4M4gmXIx8LZkh/8IENGNZNoqFYZmi5TNe4/tRwe5kern+P9RI9LdoN3niaGJLw4Qp6BDC1QE0WSnkar7KT6qzHaxM6bRUOH6rGFt1lBbeWcjEG9TP/2XQEGxKRmWV65um0lrKcMViLDZg+3MdHS+5vHV9G1rGE/rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(66476007)(66946007)(52116002)(6666004)(83380400001)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(4744005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdA2CbyXCRWzEWA3/mAS95TnpFDnZLs84HRG/6DGnW+PCH34jN+CtugemS6m?=
 =?us-ascii?Q?/lEtbhDiA0kymBn5QWvMEQKFr5YbRIlAhMlqRqnutcweXOhhxLkk1oDvtvL9?=
 =?us-ascii?Q?dNfvxekEjYjujvf1fvhvIcHoI1DueLCAqKZOa7TM4w7QXADcbfqEYPDBCZY3?=
 =?us-ascii?Q?m3SB88myWcoAJysUTALWVhHwqTSlsNUBA/8iyzGX6k4Qz6NVMe33Dlv8w5aK?=
 =?us-ascii?Q?vLvXWbhFG+AHRXvrzDBsce46Z4AstfDWEt14+YuQP65qBVQ94BJ8yJjDQcCd?=
 =?us-ascii?Q?Z3HebCyAJkRGhX0tExfbu1Crw/54ExtXmzojxxmyqq3RjruA8/MxaPXCnetI?=
 =?us-ascii?Q?1Emb0INDja9B5RtqGPpL4oBV2rNEnLhr6clvT5ZEag/AZrs0jn8s8ZuEn1rP?=
 =?us-ascii?Q?tFfl/UCf2jRwRS6qUEKFv6C17vPPCtrTxHuuznkEJKI+IYprNB/8cjh+uWay?=
 =?us-ascii?Q?28W4MpKloe+UOoC92LVroGXbvoWuU7acJfPRSF1vtZ1rd1ouDXggAFnKSJ1V?=
 =?us-ascii?Q?kYwiLGS90A93ykS6+DZ2YJUjoiiTUFj6VxymS7TYm1sKQg2hbzLYLA6U+x+/?=
 =?us-ascii?Q?UGeUJm5EEtOaRh5vkR0jywjy3A7AGTYV9a43GNsGyjYhsGd04K8LF4LEplv6?=
 =?us-ascii?Q?yFm19c9gaoUtfI69OOjlJt7cGztWlnnNkFPUWIJ4noKSzcLszjpOwlvju+CR?=
 =?us-ascii?Q?YPk2mYNXHi/VZR6FFcUXIsACWZGYYFxgSaWo0dYpkGI7jTpzX1sAEmMBcG3q?=
 =?us-ascii?Q?lmpdzbO90z6fnpSlfQq+m4PPpOIeWNrSdswjgVMMa3Sp4Ro3BhuBWzYisIWv?=
 =?us-ascii?Q?a96L5yQBxTxpWgv0y1vAbO8RUb2BFqhc1fNnwmqCIZXmIKWwnZMdOMQGBC+o?=
 =?us-ascii?Q?zZMym5Wc4aJN7hXQ/p/px3J62tO+NjuNHLLoT6cqEOfj7FObz+1mHJ8E8dUe?=
 =?us-ascii?Q?GYsX14pkoikLDtho+sRef5VPQi/tGjAB/IbdBGiN1M3n0+xa6j8mytTsUPxj?=
 =?us-ascii?Q?9L9O1AMyToWOPZYxSMp/RnyJno59aWFpa2jRK1eGwc2ZC78pYHAXwW471wI+?=
 =?us-ascii?Q?AOMUGoNnE5XZ008NIxFg1qOsgAEgra25FlSUvphgeEWZU1ZaI4E/sc4JpS8g?=
 =?us-ascii?Q?ZPa3nyEFlT3veokbAuOrVOXyDN570j6TJ/IzQHZuHY9UImDr4YbdMzlwbUEB?=
 =?us-ascii?Q?ZoGhUW3+ugGbzVlI5ly6n3SOoXM1MPglVSpWyRifCwzvM2VmbOjhtEffXv69?=
 =?us-ascii?Q?kyve66MIpJ3wzLMLqQHfyidsm8Oi/g8R+HXkJNUVltigWZcJ7UwrrZKc9VL7?=
 =?us-ascii?Q?9+uhHov8GwHmWx2Wp2YO53IZ?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7408e878-a8a8-4e39-5126-08d95748ba27
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:52.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SfsrE4K91XNkXoxu40E6+IeN4qiMSwE1hD8we4ekbGMvD4XznXqRmVUN8fGFDwRXly6ngONF3wAgvIIFNLjVrY6XqUks9Ox+Rc0Y3U8OSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3e90a8832bb9..834863940eba 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -203,6 +203,11 @@
 	pmugrf: syscon@fdc20000 {
 		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfdc20000 0x0 0x10000>;
+
+		pmu_io_domains: io-domains {
+			compatible = "rockchip,rk3568-pmu-io-voltage-domain";
+			status = "disabled";
+		};
 	};
 
 	grf: syscon@fdc60000 {
-- 
2.20.1

