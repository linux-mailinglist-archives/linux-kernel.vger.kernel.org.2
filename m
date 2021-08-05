Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526293E1459
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhHEMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:02:11 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:52366
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241268AbhHEMB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daWyftDZpC6Jaj/D3wrEQReiI/WtU8vYIP6hLOd8p1yGwRyC7kNTsHzqxfyMfTsc3tOPh6z4SQBy+DrlO3wuByCvYDahWQ+zQxUVneT+m7zKKX6C0TQxX8SKmgcS1AoUuZFD0Cimh2OvxE2ooC30o852ISlPgr84vvqOYsy4A36qF7QIZujaYABVOnvIyotkzBMhhs09vbjYo8rXlyvNFPkJYARwpcFayb1sxRjpac2bDF/6duGNs1ScPEd7/w2sZ7xrTx6GDvuFkRyGGiDJ47pNa1aOb8IW9HHQaxI6jvopMzvpj7Q/vEE34LFnANov7doTrRjPLmd5FHF5kTTqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMeKaFya5E5BhDlzKXqnjSDJVjSdRmPo2gngnsjMstQ=;
 b=XJRyNoPHKbT9M80abXF9esIaIECN+DX93dNC2WELtmWCF6Hcb7FiikrM7mXNna3kMPQRWzZ7UupJ/i4IWGOJTC/tzfIulox4qCFtUYw+5tbS5qGrgKk9OYGnMHiBDPji1WfVnZvJQlYL29eeKX4dEHhqVgYkDjXXZXYj9GqmgkFzUYJWKyw/uuKVct4Mf9I3oip671ua9AYq701FKv5a1Tfry3C/TXGb9aSK8L9nQVrjHjTUv93Oq2GBaKHOo5MEjc6egEFa/fhNQ3oHc3fvLRtZufdR4eCnjkjiRLQE2SggyGAAHHHyBHAhIDX4pLG3cnIBQNw4mc7G4LcNfKnRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMeKaFya5E5BhDlzKXqnjSDJVjSdRmPo2gngnsjMstQ=;
 b=JxhlfZ5W/6iEAPxx6UWsJrkWpPST5fZSyX0CfDlxCtIJf67dZ1yputXPzi4NWlV+QsXJASyfiKtnro9FRwBW+VuYfxBrG6sb1x5FKeldnSCcNx9nE9ebSHOXyyuH3B0XrBnbOD/OMTHKw/tbie4Zlc5KF1LdGP6DTOG8ATKbkPE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB7PR08MB3865.eurprd08.prod.outlook.com (2603:10a6:10:74::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 12:01:31 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:31 +0000
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
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 6/7] arm64: dts: rockchip: rk3568-evb1-v10: add node for sd card
Date:   Thu,  5 Aug 2021 14:01:06 +0200
Message-Id: <20210805120107.27007-7-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a98e94a-424e-4e74-accd-08d95808c370
X-MS-TrafficTypeDiagnostic: DB7PR08MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB38650DB826BFA57A1AC834B0F2F29@DB7PR08MB3865.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72VdU+G/fFn/xzOcEJtTiPvaHjN9HlS1H3nFwWv3GeFFZ+c4qy4Qji2pEeE2tkx3wCE+WTYFpPwbQFS/6dC0TnNyNC7cp9ULWA5tEVn7kveyDKDoI16IxOjnQRsQvQYPbSOE+DbrF4SBpwmYe59FRC/18NgBvW7703cyh0Qc9SkDv4m0leMTkxG5nDecwy78oUuh/YGsovJKzUMCW98Wt/1qjCWdwkmELo45qK5rdUM4Xcl9ChxUe7Oo2wL4oB1We1Io1I5SmQ7Q+qvzun467DaRjTfiBDCBocJyErHsfhpKz/wDdZOsDyRTqhoB1m2NTZ4ZBpwydO5kpRqBXbpN1rk6FoLtgVM73R3fdbyfbusFutllQNu4d6vtoZfYhcLGYj/C6XjT6rHAQlQsBK0veN9BII5p+iKoSuEP38P/cpt2V1GDRjzM6G5EzhClnkPnVvoUXAS5mCqArSK302KPW3eDWdgSuFlyzXL5dOmjtA2o3z/qLM52SPZO8nTi8/gwn0ab3fItSm1e28r7aVk8YcUnVLN56tZ6scRAC2jsG+R8K+xsadUK1mDBmbMML14n8Aiof2H/rVToP1J81tVsilAgyp6tdvzCET0AQWodDkbdYDylFpyf57nRkywMFMeXE6jq3/wpFKeyLGY13ruos8SAEm8PlwXjbu84vK7GA5NuKA7mW9cKyNUV+Jou2hs57deuJFp5B1tekISCamMEwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(8936002)(5660300002)(8676002)(6666004)(6486002)(26005)(38100700002)(36756003)(2906002)(6506007)(4326008)(66946007)(508600001)(66556008)(7416002)(66476007)(1076003)(38350700002)(956004)(44832011)(2616005)(54906003)(52116002)(186003)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcJBGdBBrbdYrb06heSxVrdADzG/aWwgZNlAtqdTbGDKsVvM9Y1nKxjvV3vq?=
 =?us-ascii?Q?F5QiSbHul67mYHRgA0cFBFJjvyjqDmvGbEdZfFXdphvOSLEgWRcNC+lWqQCz?=
 =?us-ascii?Q?bRW45sYP60C/NjtzpAHjLJ+TkfJBtTATGDxsSuKufjpQkLCzpJOBpPxYRzOb?=
 =?us-ascii?Q?3lUYIW2z2sd5mnegGwQrvC7Mg+frvB5b9qZ/cnCtwKLnmr6W/e8t1mG9S7Nd?=
 =?us-ascii?Q?l2OSbVPJeABqUsPwir3e1XWMJBqHUgQMM8oCiI4m28ZiSP4WCyeCX7eeSbGM?=
 =?us-ascii?Q?zg5oCq6FeCGhDZQHiFZa5j3Z+svolm3trVmHmWMISToKSAqZU8stek7pryaU?=
 =?us-ascii?Q?ZlS0c9ktcmjbgvZGzBbD+H9p+jrOiHkSe9I3qbh2KGCfNvGJQUJYgBsJL7HJ?=
 =?us-ascii?Q?BKy5M/SEnMhhoLd4Kd7tvlmSmfEDQlF0mMZsjGkjhM8jkfk87LNBYFuXgIvH?=
 =?us-ascii?Q?m7SvlqndH8MvVivJNjF3e1i7+6sV0mg7gN95ydQKeib5fjY+wev8DIuixewo?=
 =?us-ascii?Q?I0MquS7tt8/8WfiyU2NPJoraKZe1vh6A/hFbxQ7BEj3KOtZmt63pj3xcZgvd?=
 =?us-ascii?Q?oNrh9D+PkR4vC/1VKiXQaPs8Crn7cqVHLuobY7t425nKb7M75NKHxXFxpOvk?=
 =?us-ascii?Q?YvKDIoeycnVsI1AOjfLpFCLASlWC/+OHlURSjXyzt4hcnVl563hNHXk1Uu2p?=
 =?us-ascii?Q?FQbzl0m3fnXatwn2UMgem46JBxqORLzM+ZqI6w+GwQl55KM1n2V4PpJaluxo?=
 =?us-ascii?Q?ov8gsItsJb4la8NRNjk+yoMC4OVxrIOg3HXeWZKVapHgFeFZjnrWzgyWBINN?=
 =?us-ascii?Q?lGoiNCcoqcNbF6n6oBcW6/zbNSvfVNJCk6BD7kjGr9MHFCusZvMXiJm5Trwp?=
 =?us-ascii?Q?DsyHtLxiVJ4kpsQDSKnRQ/ry9wx5bIfYxOJbNdWPXKiqLU9G9h9aT++u8cZ+?=
 =?us-ascii?Q?nTV0xIEZGHu8wJhlbW3/bWwcckcBguiGtm2VfWirs6no3O6COeXwVtCUBhyT?=
 =?us-ascii?Q?DpPpxfDqYNKuASWrr2c77yPC4ChERWUVgCvr0N/n75REkrXBF6+J6aSVCk8s?=
 =?us-ascii?Q?/eobUoXDVgip3mCH8tO7TwOC1hfH88V8x0OQGQQOk8WObDufzSULWFnIzHss?=
 =?us-ascii?Q?siZoSDClH46LjAW+nw9w95bLs5hnRSCE9llo6httnPrFe6HGtjKUOF2s9XAE?=
 =?us-ascii?Q?scIdN3Zx3/RHOiNuunOHGubhEk8vu5iXJaNUULk6soCh+YRZBfA0q7leCaXN?=
 =?us-ascii?Q?bcwACZ6ENXoCmtcQWTh+a2rAu/G5z7MHo8txpacZS0lOSqR1DHXLtdTtZYIW?=
 =?us-ascii?Q?UJZ/MIjJeQnuK9CRFhPgv0hS?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a98e94a-424e-4e74-accd-08d95808c370
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:31.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RSexPUzkBRaFS6xgYnBZbhH0KHP6/vBIxsbHYDtV5YnniakoTWVlLpLOR7JM41DXbD378SP0fKBDNlzyn/SW5Vzc5VQGdnsszDIgZNmObk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SD card reader to the device tree of the RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
v3:
- clean up device tree properties and sort alphabetically
- revise alias

 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 92af4ce89b70..1c34d529b771 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -16,6 +16,7 @@
 	aliases {
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
+		mmc0 = &sdmmc0;
 	};
 
 	chosen: chosen {
@@ -365,6 +366,19 @@
 	status = "okay";
 };
 
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.17.1

