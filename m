Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029F23958C2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEaKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 06:10:39 -0400
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:13281
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbhEaKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 06:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQwuE9zUCtgG4K8x1aF/Prk5XUL078sn9irDX3wQ/jfoiiv6SwXDfSA0XFFIu9HnTi47nskCh8imFlFdoFt3huUUyfZqrtSFu394z/xS8tA8UtNqrpwpk9FDTsKfN4wVLq0fzyAiKDiFV7IzAoQ71/2tlFEQOlr/bbZPcmIr+embKg9+b5MyjlgtvoVmCg213qvaHINJG+3UZfltdV2BqoJm5JplyXVD3b7cdm80P1JVzOJSJK6yg6/L05arOSPCJcL5SQINEWGG1qnKEG9bUi8obwYlB8uDzn67yEqzfiF4Cmk3QEq2rI19KWnjYvdrV+zpv7PA/Tw2KC5CNMwOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuqIBIr2j3yBkDvU8OB0grujgWJQUTfM0/mfIyJzeI0=;
 b=HIbv9mdVhGuYr7BekH2pnIfIfWOYGNfS5RMqACPHAHIfpRLChB3jZkHA8Fdud3bzB4nwlmpcPfNwB9rrZ93GkyzUjj/L/7e72ABy7GgwXJYAb3Rqs0N0fFwjZDCMTwEXisGCe2WI6F1h500SXpVU5UlUfqlcgGCVm1mrpNLrMwPcYp50b47EPIsFR66ghIxCWs/p7DyY5lcb4gTllx8mSnQcymuaUtn20uJCCnivgY0uXtpoaT3ewKkrJCXlU3vvc7EbrojE0czd6V2UGbrS7ktO/fg30R2hsYSL0olX7kL92Xho22X+AT1ejy+lxn2rfdFEHaKbtNkPyJ9pZ1V/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuqIBIr2j3yBkDvU8OB0grujgWJQUTfM0/mfIyJzeI0=;
 b=gVFn8N2ki7XgOrpIfDKvEv5H19en5SawpGYVaxeCuaekK/7+Gks5Eeh2AKd5FNta5ZmSYq9I9YXsubo/vMpiyWzKrts4aWBDYQ6mtIWV2/ifimg37ieEmABPChECOdyqEiuIg655FrKDrAMb7b+xG76InEymql0kj1JOD1ikBmw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7850.eurprd04.prod.outlook.com (2603:10a6:10:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 10:06:58 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 10:06:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: not calculate new rate for protected clks
Date:   Mon, 31 May 2021 18:39:57 +0800
Message-Id: <20210531103957.21886-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 10:06:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb440e6-17d9-410e-4d82-08d9241bd3ae
X-MS-TrafficTypeDiagnostic: DBBPR04MB7850:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB785059CD1394450E4EC87494C93F9@DBBPR04MB7850.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUBkakfjp2IIHWFYdPa0RyZCSqRRXYLsDeG8XWfO59Vc4pHlRspFgVmeNTWcjd6VMkg/RFja95vBOMtWfSTPX2Z9bbUOCHhWQMK0mYk/lUd2Bf4j7Si3vOf1HcE5QvEZmd1vtXnjACmxivpAF2wa930oKtP7ZeFjBl85rlAtLtjOCdRcVkwJW+Q/MbO3SjWajTE3E0hWRD0ETvt22L6gexEaX/h9djSWXsLn+B+1AAeWAWGZGePREmR7wx2sNCXTx0sqTe+L3Lat7zLPhZTE0pwMahxJCha7ysRtyUtuzYdMgEpwdbxDYNFlsngbV4JEOGU0qFKuiELsUPCkaI/xUJZIlW1LkJG01A+tx4jlau+eWcCir0Ugmbrh3CGkU/gnJVE6pwfmsp2tOTwkuLBkZjsvcPSZ7hRk3pMCvfLHSMezal+uP+ySIow2744e6ftTpDNZzvS7+VeUdQoS214I0V8XHKANncN5ULRm6v8xkd1lXUdudq2chgpPOppIi/LlBH7iN8eNfX6LVgtxzfWeUE87CrRJrYRMi2plRNPBEspldRVRJkRIoqeyEfE4cf694pDo7gg7yr3YMOMYweRBz+iuvBGR3m2raP4On2W5vE0iQl836lYOzcSZxqeK/bowCxPfWZJKsbfvD5OecUaATN5DQnKfbPnP3md1jOsthHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(478600001)(83380400001)(86362001)(38350700002)(38100700002)(8676002)(8936002)(4326008)(2616005)(6512007)(6506007)(16526019)(5660300002)(1076003)(52116002)(2906002)(66946007)(186003)(66476007)(66556008)(6486002)(316002)(956004)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ww+t4GWGlDp+eRePpOl0o9JGC9osMOMu3lvmJb9fQ//H2IOHT/HNzTaRESEt?=
 =?us-ascii?Q?6IXHQSWVQGe8a3kA9qI8GrskgRKWkYapdMn+dcxiWWD5D2qh9QaX2yLhgz3t?=
 =?us-ascii?Q?PPveSiVb7iqZOqd7kM1M4LbLbzDvKHxE9s/+4mGJIuGDGlJV2HwU3b2Rf7e+?=
 =?us-ascii?Q?gtQQP1CCgwJBvkJiPvlFLhvYYNkEYvGzaChG8vdeOxWKADcfzQwIC5momLs3?=
 =?us-ascii?Q?CKIHtjxDRdgqCPdjUhamNQ/teh8oDXrqRAx7NSgWamTyhCCLKZ2yruIHN9ea?=
 =?us-ascii?Q?Gd+/zLh6DqCsxK0JyIitON1F1A5UTTMli4hyMz6vL75KOCCP7JvqZ78txekO?=
 =?us-ascii?Q?pDM5W/rd2Opn+Np6U49OeoFo15iox4oo/n/0t2ILuwpBv1v8I/X0Oakt34ug?=
 =?us-ascii?Q?5fTTtJcU6ja4Y9wJhwZ6JMFZUV28STkbtdHa+UoYgGmGbi/1fwSrYBBDOz2O?=
 =?us-ascii?Q?Rjq3m8tyHmeRIhK7FdMOpAQXVTVnKcOsZxzFACpNoDvkvInhN69/QY742vts?=
 =?us-ascii?Q?ItgxH2wo/M8F34vamX2Kj9Pvc8N7Y0XZKcdh9maOYh9LdQNAakIba/2CPqDa?=
 =?us-ascii?Q?G0bmZOxMZWuabSgg7wCiPbmhieRQ48/yYkRtDKehQa5rFH2FxG8hf9dkYEFs?=
 =?us-ascii?Q?icRXb2jpfqY6Nb8VMr76Ku4liYAdRNG02kKhu6MbUdpWrq9iGT6WI9DgOTHl?=
 =?us-ascii?Q?GnMJe+tid88U5mIfT8alf4qaOS+Ji/BbbSBx+En3l6bIAaYC6mQUsQr1qwAh?=
 =?us-ascii?Q?4ahy6D8Eu1GbOFxtIT0bfi9qjBFGhgHBEYavavBNTb04sl+0UHsQkisdoO9O?=
 =?us-ascii?Q?b7EsaVC4PNoUzkGOnd02U3/EKTQZKMDJW+NPvXDHw1Zyua4TwHXmrk4PQ3Lc?=
 =?us-ascii?Q?+p61md3yhgytfAz+dl9i+4LX0O2FEhuEuEDeihIweI8LjNYD6+yX2hXOc9wH?=
 =?us-ascii?Q?jJ2GazCQIbiOCTflrZ+k2fCl6mtEFVJ2uM3xiiXTRuEUcXK2Rsn4PiwquS5K?=
 =?us-ascii?Q?T6LoXWJl/i2Jg3KT0wKmojLDomNa5x0ScWHVfoRNUABCT3JWft5U1rajnQVI?=
 =?us-ascii?Q?viOh3j7/prTalKWmtSsq7rPUH7R9iMgifwI0lIihFxYtrO72VoDz4wUd6xnd?=
 =?us-ascii?Q?qjwtSYGlzp4qNpyKr1Qn7APUnZikIYLodoo+LvaCHU6FoqqgbWrFS31S/PCv?=
 =?us-ascii?Q?Ln7wCJZmKURJACc6+FY6sPgwSzZU3wmOsQVA17gv3VUH0q03QVCD0/LLOvGN?=
 =?us-ascii?Q?NBwFFTjnge1t9OxqL+5epq0FA7zdz+NWa1x+whfpNotVouthbXmSNIfbyDRK?=
 =?us-ascii?Q?8PWH5H9vWxBudO9cnnbVkbb0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb440e6-17d9-410e-4d82-08d9241bd3ae
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 10:06:58.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TcpCu/B31OAoxNR3AhAcEgC4wyxVBIAFRJ09OUUfdX2j+xMPr93SsLfeHlFuhVXf4Ia0sYDIRdOEnWWtIgYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If the protect_count of the parent clk is not 0, we not calculate new
rates for parent. Otherwise, the common clk framework may configure
other child clks that is under using.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..8ac121838e13 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2002,7 +2002,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	}
 
 	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
+	    best_parent_rate != parent->rate && !clk_core_rate_is_protected(parent))
 		top = clk_calc_new_rates(parent, best_parent_rate);
 
 out:
-- 
2.30.0

