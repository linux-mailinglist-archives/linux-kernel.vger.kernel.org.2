Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81B3B7EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhF3IKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:10:34 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:32740
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232936AbhF3IK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8cP8YnRq2naAV9f5ePqGiOL2aQktMGybj85JRQOlTuTXfGSakp4L2Jefb1b33BwNeWVgRha8T7vdJ09e08mpnIEoM8WTiyPD5dg/XCUE6a7wCXP53l8T+XZjGUJTkb4yDjD1jZY7CdDt5KWiKAPOdPjlUkuLDYKFX6D3lmnU7/MX242Qg/2DPzfsEw4WNS9oFHeYNK6D4cVqguGG2om5y68SL3l57ZCBHH/g0HwS8xlneIgR+k4eH9mN6SuvGJI7d9LKWo9f8meo9+Jzsevv5a7swKr6fUN7pCnoXIi+yJuS3NDkxVe7pmpoEBe0pdPo/8hWCRqDfkxDGPTIafjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMqi8FQuXlEaH88O2RXuB7MEuqWSXnr2+JVhnly3stA=;
 b=LfrEhW6xUhhKCRuhrCb+eTZs4vSj4xsYn1gSd05j5yuOSIFlpIpWhYbM405guT7phg/afLjWTFgjzbCvGXDgMw7jDbzUU0VVPwXootE4QoqVWqWxT+aa6+AAF6tmeK/uMu9wxRMfoRxSs/L25mZM616VYtlEKgLwBZ8XrlYyZMKXE/+yi7lcDnG/CPG6GiyjhWH7pJRa7t8L6vaEMQtW2euARK5L6bBECrTb7Ebmfk0KDgN+kwUPVhMKEfxdR5SZpUpkVxlFbrUmi5tdFLae9hH55L/jXsIqqzN9MEiOw++vIuNoVBdObD5Zk16fse5JEHOUdgZUAMuEy8spNSyYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMqi8FQuXlEaH88O2RXuB7MEuqWSXnr2+JVhnly3stA=;
 b=lgPYPwJ69xnRkF0/e2a7EWxXnmPzkU6As6Hg6TpOJLgkmvQZR+pPG3Ysl3l0DX6Q28EnoLkoA8TOJRSu9FQhzOheOKMTTktvOMS/+m8kQhNjNpS967FVniaV9/v/SskiDKqdtHGGwvF0VbyhmHc3IGVjApElc/2C7M9DqmLQhKs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3342.eurprd04.prod.outlook.com (2603:10a6:803:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.26; Wed, 30 Jun
 2021 08:07:58 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4287.023; Wed, 30 Jun 2021
 08:07:58 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] mailbox: imx: fix crash in resume on i.mx8ulp
Date:   Thu,  1 Jul 2021 00:24:53 +0800
Message-Id: <1625070293-28641-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0177.apcprd06.prod.outlook.com
 (2603:1096:1:1e::31) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0177.apcprd06.prod.outlook.com (2603:1096:1:1e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 08:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922e86b9-9a01-47ae-1686-08d93b9e2c0e
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3342206DC89B6904392D659B89019@VI1PR0402MB3342.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkys32pqe32EsAGUL0mApAd3n/HkXfnRgKEAK/il13kaJfKccYam2UILSYTLEDuXl9cmlvmvlHDaMhV2+uT0Yj44D6803OhxjlmcyEMtLORCpgxP5w49heTOS0IsQJXCE9JvoQJLlsPzVGmQtEXSwwPzdWQoWX8I3Z+v/wxTvm+pt30et3Hb2+T7O431twaUfuXWFHQFI378AOQQ+jphOtXqvjwJ1tSCJt7kXCVSin68k6IOwD7VHueYhqU8iAMhPga2QOA6g3clp0MXaC9mpQH/gt5/yEtA9Ea5v3qYaqjC2lug1j8G6+BrjVjmYP2EQCgj1ReAT78GuuVeKIJJ9bXPebg5YyBr8TVh7c4ZvDwLjxHMXvL9a2BdfDvRBbLDVXx/AveOPl7RMjgu86j1dvYn48D+zcGd52YmnAdWHMo8OFy0pw0t4M6mFnADclfLcSVZOn+TUytAYcTBPSMKLNLvfUfoyGLPXvpW+VrZASWWQRBbeQZnEuD7u5rYOZMnYayaeKe5nH1xy3z/xdaAAVNgiTv+ksDGzvy0xYpi9CBcrJEZAqoT0ejwh97nAqD7eEgelcsQLnVuWa3LTzwaFK8zM8rGjB1vYTGQcqesXEFXhAauNVVYh2LEVbp0g0PztigC90NgSl3WAartxg7Fkrp+zTZSAjuUg33CmZOAkylXhZCNSUKKfSHrlMPTiuevNYzrdW0BjCCPxFfT+KF3Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(6512007)(52116002)(26005)(66946007)(66556008)(66476007)(45080400002)(83380400001)(6506007)(15650500001)(2906002)(8676002)(8936002)(36756003)(5660300002)(38350700002)(38100700002)(16526019)(4326008)(86362001)(2616005)(478600001)(316002)(186003)(956004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4irWZwo1XWTkbh0FVEjM59EmfF5jdHrwPHmuSOpW6P113nzTiKU1KloZM+pY?=
 =?us-ascii?Q?tcq0mxb9UGSC57c2CdEMRMkKDFtMJUzGkjlxFqb9FZnhp12dWPuUVGpV6IWo?=
 =?us-ascii?Q?a4wIKcBXkCmo/Am3C8/KF8o9uGI/oz/d3A5ZcUvCD6ZCnV3Rq1tYvc5edrFM?=
 =?us-ascii?Q?mFoZNLb/ugbNfB5miH2EoVZQh1FTQ/sOEXcVDLrPGkVzUjzVVpi3fAiSH2yt?=
 =?us-ascii?Q?Bm/0rUNnbDIB5fDvE7NONK68InwGlPGqGwljCoEkx0zbKVjFq9TBTFNR5ED2?=
 =?us-ascii?Q?G96muf08KEvKJm6EdK76phZd9P/z7j4ZRNbK6NqEF/Ig+B1fKmBi6Tc062LQ?=
 =?us-ascii?Q?bpjF2P4nu8CXlrKlsJi8KcK4r6C2JdhNrJtGN/bQtRXn+ENfyrv1zrfehrFn?=
 =?us-ascii?Q?TZmSTTZi4LAd8A6IAtRQ5B4BOonLPd27LId/6jctcYNHFDvYZ6G574NdArIW?=
 =?us-ascii?Q?zXmG6ha+g1ljWHY0wtvO4PoZFYlb2aALzQ2/QPPTnUkZMHuBnawbpznfD1LW?=
 =?us-ascii?Q?qHlGJHb2/a3UubBmwWauzK7Uh18xk+cAwejnqKfa1gZYTVstUeVR/vBW49XT?=
 =?us-ascii?Q?g2xUVi7xb5hH2unmEWSnYbeYdANd7/R88HiMRzUJX9PZ0UAc1d+ULsW7LB5w?=
 =?us-ascii?Q?jDidX2AiUpKgJmsZWOy7QgdRYqelC9IoQXBbUwaatrbcDz3ql5g8DDGB5V4+?=
 =?us-ascii?Q?T+Qg+ox5r1ZIHf2VLIfA/opRxfeU90JEye1uVlqJJX1R09u5hHBt8v/zjbpa?=
 =?us-ascii?Q?SuALW4Rv3HCQn7WZ6CB/+vJtZIyU6spli2wclz1H+rLR+Dk1/uBQwjEF6BCB?=
 =?us-ascii?Q?y3m54dfjjqGnnRuC5+uk8GDgsKCqJRGFXoqqT5B1lX54FVQpl88l06cTOwdj?=
 =?us-ascii?Q?nVPWUeK+KUVJ8F00ILIoPTOzkJ2kbAEYyG8DbzIsNzCMyzohhVZPn1zPLcu+?=
 =?us-ascii?Q?ImowTYJijM7oNz6yZcOzFJSMgbx7lngjPn2dDxbr7gVwQ8k0Py8X1RStb95F?=
 =?us-ascii?Q?waTCGeYA0ONd3zqu3qSSPLnbOXIs55UIj7+dr/IhRq6oKs4MbeBLKzB1hJT9?=
 =?us-ascii?Q?WzWpcXUp/aehX6cDyMbtNXvtckkDjhdlnOYaKl5m57xgRTenR6taXgeMcQHq?=
 =?us-ascii?Q?x9SRJloKarNogboeWNT3MoTinyy1K1wIDoOoPiR3F/hOYMlpWWgHuXM+zkTT?=
 =?us-ascii?Q?hiklyG79pkCvumEGcTPmYx9b8FH39g4SauQFJzbE3TG7loCStgXmZu2F8iDa?=
 =?us-ascii?Q?tM/Bgg3uKB7SZyuGnh4wjq4/m0lggVqgKCighf7J2FBlIIVkFZJbQSwDhppi?=
 =?us-ascii?Q?cCtExfzXjcakG4dvWZCXPw9V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922e86b9-9a01-47ae-1686-08d93b9e2c0e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 08:07:58.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/+39tuQ3QmJUO9O5+DzseID5f1R2n43yifVDVgCBymGRUJ2ZHGzxgS//7+Hb236SVXzjyoGBizmw6LCFsQKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3342
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check 'priv->clk' before 'imx_mu_read()' otherwise below crash may happen on
i.mx8ulp, since clock maybe already disabled by runtime suspend.

[   79.155733] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[   79.162979] Modules linked in:
[   79.165998] CPU: 0 PID: 460 Comm: sh Not tainted 5.10.35-00234-g0b4d749783dc-dirty #571
[   79.173738] Hardware name: NXP i.MX8ULP EVK (DT)
[   79.178240] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   79.184082] pc : imx_mu_resume_noirq+0x14/0x78
[   79.188422] lr : dpm_run_callback.isra.0+0x38/0xd8
[   79.193085] sp : ffff80001b63baa0
[   79.196337] x29: ffff80001b63baa0 x28: 0000000000000000
[   79.201512] x27: ffff800011bd9b30 x26: ffff80001157acd0
[   79.206682] x25: ffff800011a210f4 x24: 00000012682e38d8
[   79.211855] x23: 0000000000000000 x22: ffff800011b85000
[   79.217023] x21: ffff00000425c810 x20: 0000000000000010
[   79.222195] x19: ffff800010c79550 x18: 0000000000000010
[   79.227368] x17: 0000000000000000 x16: 0000000000000000
[   79.232539] x15: 0000006fb5d33a2c x14: 000000000000027a
[   79.237709] x13: 0000000000000303 x12: 0000000000000001
[   79.242879] x11: 0000000000000040 x10: ffff000004424f80
[   79.248050] x9 : ffff000004424f78 x8 : 0000000000000028
[   79.253222] x7 : 0000000000000006 x6 : 0000000000000657
[   79.258395] x5 : 0000000000000657 x4 : 0000000000000000
[   79.263567] x3 : 0000000000000001 x2 : 0000000000000110
[   79.268742] x1 : ffff0000054b8080 x0 : ffff80001af40110
[   79.273915] Call trace:
[   79.276340]  imx_mu_resume_noirq+0x14/0x78
[   79.280345]  device_resume_noirq+0x80/0x170
[   79.284431]  dpm_resume_noirq+0xb0/0x218
[   79.288271]  suspend_devices_and_enter+0x20c/0x5b8
[   79.292938]  pm_suspend+0x2ec/0x350
[   79.296362]  state_store+0x88/0x108
[   79.299786]  kobj_attr_store+0x14/0x28
[   79.303460]  sysfs_kf_write+0x40/0x50
[   79.307046]  kernfs_fop_write_iter+0x110/0x1a0
[   79.311388]  new_sync_write+0xe4/0x178
[   79.315062]  vfs_write+0x24c/0x380
[   79.318404]  ksys_write+0x68/0xf0
[   79.321664]  __arm64_sys_write+0x18/0x20
[   79.325508]  el0_svc_common.constprop.0+0x68/0x160
[   79.330179]  do_el0_svc+0x20/0x80
[   79.333436]  el0_svc+0x10/0x18
[   79.336444]  el0_sync_handler+0xa8/0xb0
[   79.340200]  el0_sync+0x140/0x180
[   79.343463] Code: f94a9022 f9400420 b9403c42 8b020000 (b9400000)
[   79.349383] ---[ end trace 4af1de2c96411434 ]---

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 2543c7b6..848c0fe 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -620,7 +620,7 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR) && !priv->clk)
+	if (!priv->clk && !imx_mu_read(priv, priv->dcfg->xCR))
 		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
 
 	return 0;
-- 
2.7.4

