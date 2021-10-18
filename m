Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0B432257
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhJRPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:46 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:23649
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232873AbhJRPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH3aTclWremqHxjsdnOep3TSR2LoYdVr7UFRMoXDnrf1Rc/Ka0PGuAes/caLNwvvY65I7oTQuTIH3B6qlQrLtwPz/YnWt6489EfPqxkNgxQa81mlL8Q8yBp8lId2aGgIa9+okGIDS3kCvuRL1d22HrZl7SM2k0FkwuF4zLkfqnl7pPCLNGH7jNC0t5XDaah1Bg/4aNnAyYqUIAjvh39be68YRasUCpnNF23FNE2E9DAdEqu8rtBcj1UzlAdc/O0yfdxbtA5NhVNjDPOarSmgq+4PipebifmCjfrmZpVRJaRC+Yjt791HQ+m5TbcYSpe8ooNOxWSE0Xtc7D8hRcGKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kzv5m38XfmQpArEfwdluJpuPF2O5ekWFHl2FMYzWGY=;
 b=ep8whzJ9FITH/kGdHChRibKFG3defiO4vlexBeMO53ystPtXWASHsEGkqby4Hzs1I0AtSkfinkTHB8tWS12dEGtD9LcQucqDejI6Xu1xA28KWxv2n/WUiHSvhcd4fg019sS5YNfK9FQ4iScJb73e6ynHoDSegb09dXZqWVra9PaVjhPvypda6bc1JjaCDnnNn9LZXIvjVlk7WVeNU2P3STCzBJqExJg1SWkU9dTy2l786yzLmaSt//QUc9N2e9xr2nzUs7mlkOE7hGyK5bYJeiG4upmF3Yoz2CSjlbfB0YfaaCifxm98TQwHxrgG1bpV23NgQ98/wpKgFuZokNCkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kzv5m38XfmQpArEfwdluJpuPF2O5ekWFHl2FMYzWGY=;
 b=dDDIl+FS+vY6fykh7pXPapVxDZ8KtQJruvicCAJFPVhavRVUpcZd+LFQW+DQUoFev83QWeepmMqlIO22EFUBZsuFgG9dQ77LtdKFF8eiuK15adPA9z6LeTRt5Y8pYjdEQO3+HL9SFfZ+fuXTvL3sZedhpJXYcll/xpj1XkRR704=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:10:56 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:10:56 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/5] soc: fsl: dpio: use an explicit NULL instead of 0
Date:   Mon, 18 Oct 2021 18:10:30 +0300
Message-Id: <20211018151034.137918-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 484174eb-3103-460f-036c-08d992497bc2
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB72683EC5E01DAACF19C0D9AEE0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVS/Y1KU/PICsDLbjYSlrr03U6MBCp5qAJqfK/I7unT6J560IcdCYjbqGjfIyXPJJCqgNDzEcF2hWFoJC+Q+VqczAwf04LrYRVJQav55O7TugzwOSy5VOWa2r343Ny0d52yOGnDVCGYgRKURuwcps3ns5HoByh3Hl0l0RdVLi9qHRZy7zBcvYyXa5g2rTaceNeFrEFWtDi+AMulHtQwuv65Jf7OQh5JvKgOomy2lqSo90hOtDmEyparNffcEvvprf7fyfR9hZxsPd8OaagD3l3AlVpx9HjAMZfI+rASafk3XGH9Cygjbiz/JhI7R7berB0AGJ1+4FCnMYbfGnH57ZH0RPEVb4L7atZHLqxe8oty7T3eF++DAP9GaFrxof2Kw6Gb/SMHArV1RHDOx/mmRln/hpcHJ5NinqVa5mOIpnBDWyfNymlMi08Iq3u/YIZPP7MFgEmchm1kXqp6nAK71YkyP107FYiXuQ56I52/oKKNldIecj3MyRMRUO6ygmi6Zmc03lC9ypSWLsSRfyRw/GvBbdw21zoSN5dz9vltGtnP6NKqBe0eJZNYHJ65p15uXtnAoakhto8TSpjVcOTpgLvDM9RwmC3oeDy6VbrfK+ordA/VRt9xSar2ozLAuuQIU+VUfHEuFUYBoFk0MtQ3EwTGGDNfaf8ojqnSf66zSMQbNwOf+fZ3opPv1SwkA+ZLcO4oToH2+b3Vgo/ZK3jdfAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(83380400001)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9HHbaHbKGYVrpbIai2otkmarA0ot9mCQf2Tlsd4CdVIURtMXbZDAMUUNqsl?=
 =?us-ascii?Q?UCTWS9WTq3BxjSeO3Ced2zG1wX4yVrCadKXUAW4whW7w8WDD99M/4x3YAiyV?=
 =?us-ascii?Q?wPk15tEv698BE408zP6fuwUarJ07GeM1J7XFOVKetd4JjIbvsQMtN8QaYqIX?=
 =?us-ascii?Q?2fPfm0bS/bW+dNF91m61tzpVcRj7sCTYL5JqyzBWpqO9VdaslSbS1U8QEeqp?=
 =?us-ascii?Q?tzu8Akn502Y9pNo83bib+R5LDUUcBTlRD02pwl87EeBusJUrO8Aieh7AZ1Xs?=
 =?us-ascii?Q?DYkQyuF/7N1f1RRnC14h7VESZh0Is/IraROJINnBO2aSi0juczPMeHXQmSKn?=
 =?us-ascii?Q?tec3kDcChgJMc9myRMmQJCQvkX3O9abnIbw3J3Hc1PEcigQqKinK99CzB0x5?=
 =?us-ascii?Q?H0751h8fAhHuzUw7+gJvmusR4D1WqZ2G4e1nAfWnvgFOUuXuaplcIhxobykp?=
 =?us-ascii?Q?QoWry/Bfr6KjdUrfni/o8XTsOEjgxMawVakgluvL/aeWSKa0dRdIqMIeBGY0?=
 =?us-ascii?Q?NBFhA5C3+lqzGccHwr/fl6g6eRmykgCaCmsckBoGTpdfOSmSUdySCisDEqal?=
 =?us-ascii?Q?z07PliyUFblpeHLvi+F212nTbKM6lch0L2BopMZQrUJ3wVF+bOMAZ8JWWtKr?=
 =?us-ascii?Q?alWlovK71cwk0uwLBg+xxO4z05O/mEPgmuI6DgVJS+YtPcvDUcBggv/U52Mx?=
 =?us-ascii?Q?y1MyyRgXbIXpAq3Kb0rfVtULm9JV4U/WpP3np/1NDP0B+MJWsIwoT6iWgHXU?=
 =?us-ascii?Q?U+Vj+ePj/dYJCsIUBe289F/AdBFPI5zoRqY2cuz7kGuhm9UhdqYr8LxIQpwb?=
 =?us-ascii?Q?dKaV83S2jDkduWkW7OLs4xJc6PxJi4Y9Cj0ZAvUa44675S4di6PlgbhYCAap?=
 =?us-ascii?Q?aVhPfx/Gs2eiOwEJ9jIoLfR9cbbgGTR7o/gYmPJMbp/rbb6WJ7FQMd5/2Ubq?=
 =?us-ascii?Q?3LhnEJTmhFLs/fJSuO9QXBvfLrhAne35pmXXvUpLtz/oQ/VOkx+hKkGd6t05?=
 =?us-ascii?Q?8rjX6mSSDR14cX/NGmQ1BIuv76p3hx7lC+N4OxuPDg3OekPY7x+PY8of22Gj?=
 =?us-ascii?Q?78f+AXyiFd4kL50MXxcYF6PtPRAs76m6+jMVX7BcadsSlUli0MxnBD77pMZ5?=
 =?us-ascii?Q?SlAMKDV/r1I0Bq/QMgB15AceX26DTZgBkPGWXUwj4wjAvxTtSP+xXADfovvO?=
 =?us-ascii?Q?GMIENiz+W7xCTTj1y6gFgmMtYXKYdUFcreN+Ek0IX+u0l36HIUSdbsrCIW8U?=
 =?us-ascii?Q?5+BQWK3Ad24Yup+fervyvE9aDy7aL+KDRInuqZoZfhSalAgkw4q4BIeqrpVY?=
 =?us-ascii?Q?KORBSYnVKXAk4dEOy9vpVSbz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484174eb-3103-460f-036c-08d992497bc2
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:10:55.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fl9oWuLQiqsQSzzqGs8qz0kYvpFakIgOcJ8QqG/j6ah2Z8ultHu092d8/nSws+UT2J9834s1cE1TVa5cjonzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an explicit NULL pointer when calling qbman_swp_enqueue_multiple()
instead of a plain integer. Without this fix, we get the following
compile time error.

drivers/soc/fsl/dpio/dpio-service.c:466:60: warning: Using plain integer as NULL pointer

Fixes: 9d98809711ae ("soc: fsl: dpio: Adding QMAN multiple enqueue interface")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 3fd0d0840287..db0d3910fee4 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -500,7 +500,7 @@ int dpaa2_io_service_enqueue_multiple_fq(struct dpaa2_io *d,
 	qbman_eq_desc_set_no_orp(&ed, 0);
 	qbman_eq_desc_set_fq(&ed, fqid);
 
-	return qbman_swp_enqueue_multiple(d->swp, &ed, fd, 0, nb);
+	return qbman_swp_enqueue_multiple(d->swp, &ed, fd, NULL, nb);
 }
 EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_fq);
 
-- 
2.33.1

