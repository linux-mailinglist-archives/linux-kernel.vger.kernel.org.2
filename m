Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15243225C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhJRPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:13:59 -0400
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:64975
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233405AbhJRPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCBun15VUWAHwHFMKlboDyLb8Brqqzgy4UD2f5vo0odF+zo8QMLmWqtmpS9KsUfaouclSaaL5lirauGk+phx69LJPwhgqET3TZxljz/cpmIk8FzOqlwvild8LX9pBOfJSI8HNoJggkuzjClI+ViQ9cc1wMTQnGA2d7+GYV3weLz1vg9yoHhXtZLBnto/3x6pETQvZzSEcIzQtin1wcZQYIMdZQm+7ofb0T7JMpRDOyDCHZXr/qogdbZVhcvI48NJcDqJtI9ecoGVnRUauxL4JQ/tNLCgVit82c3z3PLbr3POJWawzZ+TEwYRMESp3WzwJDOIb1Q5ZLJeZkreHGGRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVv5RR/kV4sVEXHXK3qccsontOWYpG3/YZkQw/RIPDc=;
 b=cwXBKadd0kMJyPQH2yGnhfkyHCYJ1dgRZwGfa744JucLqWRG2LR7nmToRi8n4Rwac0zyEi5EvxzKWmm7Hr1oBIVkeWEiKBn3odCDQBopASeANin1Cbs/qy+HJM8BBd1zF8jS/cyq07m39wlzuA8VcdrZ758tG71M6QhyeboOvIfuvsXO3Kdx4BpY250hyguUcbwloHVScKVp7aNd4gW6XLP0XWMy/uc5oddyKSCzQLqazYRbi+JzZokzGHg8GOukr2XaiV5xAQWA5YbToOrBR1Le73x16r1/0NDBDbjijAIp+i+Yd5K5OzETe+/lH38BB9gHnkp7i9COxPv6DbCX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVv5RR/kV4sVEXHXK3qccsontOWYpG3/YZkQw/RIPDc=;
 b=GNks1E30XMiesWtL1j0/Mwq8A7mF0F44RUNREM9KqxIslfG7KklpGQYYNbMhML7g4xK0YJlysGae9j1MOcChZ78GP07VSpxUaHigN+gNGbarpJbV2yYePsGvxRFRUtIj9ySO95vWf6UUXlbQEIvQCX/cVlD3626+TTevD1i45P4=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13) by AM8PR04MB7268.eurprd04.prod.outlook.com
 (2603:10a6:20b:1de::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 15:11:00 +0000
Received: from AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726]) by AM4PR0401MB2308.eurprd04.prod.outlook.com
 ([fe80::6476:5ddb:7bf2:e726%8]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 15:11:00 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     leoyang.li@nxp.com
Cc:     youri.querry_1@nxp.com, linux-kernel@vger.kernel.org,
        Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 5/5] soc: fsl: dpaa2-console: free buffer before returning from dpaa2_console_read
Date:   Mon, 18 Oct 2021 18:10:34 +0300
Message-Id: <20211018151034.137918-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018151034.137918-1-ioana.ciornei@nxp.com>
References: <20211018151034.137918-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM4PR0401MB2308.eurprd04.prod.outlook.com
 (2603:10a6:200:4f::13)
MIME-Version: 1.0
Received: from yoga-910.localhost (188.26.184.231) by AM8P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 15:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016bf510-5e8c-4cce-acd3-08d992497ea6
X-MS-TrafficTypeDiagnostic: AM8PR04MB7268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7268ECD2B86F97498BD5F644E0BC9@AM8PR04MB7268.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4+ixN7Jctug9aOovuRE3VPvp/OC4kfcu1l6+ZuE0UbULRtL03eI7kVEjlek8qnRk4fI4aW6v8ova6mZLRhefq/LAcVuFKASynNcEXRwrzawcJ7o8gjCaF1E/J0fR+BVRQ45bgnRKJt0+PSuN0XXn2IY50swZDAzuerNAmOjma/4bqqvCtURka92zpkL7nKILGDwsvkwvilN1rpTVhjcI+fglMj6dOtxUNSfWNfnDHVTwxL8F45KXjOY8ZuHuv0g7Vvcye64sQ3EDAuSffr24J/Zp4bnVWPJfPqw56UTqzjZWAcJwwBI/OD4Me3TVyzm5ZMEdMgi8Eh38wRhZpNsAlpTcgt0RzbAyCe80Cm//eYdTpKy1GpgZh6GLp8IAlKgTcTf/I/hkJE8G1f1lA4Prr6as124DQRmTdqstvDqNyYigFU3E+jNI9hXahz4ZFT3gbO4Hed+gyeTA0vu5mqwt5s95WnNJlt2DTMuu+2ZgNqJbuxmh8PPQ/YykuoCxpfbrip0ToS6+D7aDmuiYep7h6FcWlrp/Xe04SkAx9S9P9RTxM1n9LHuDGHnP15EYbIVvXiuyjfzCdk2rneiJXXeSq0ryZJRJhE8EDggvcxsEPDnCIL1YmeMm6WAw3n8VfXRddyEasfIoh3BXW+GNw/qTD2cB6h+nml7qLwYCax9bDPtkEjq+HhMgZz8Jyc2ucGNA10iFqOSEfi8aghk+1H+ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2308.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(1076003)(66946007)(66476007)(2616005)(956004)(86362001)(6512007)(508600001)(4744005)(44832011)(6636002)(38100700002)(8936002)(186003)(4326008)(37006003)(8676002)(5660300002)(52116002)(2906002)(26005)(6506007)(38350700002)(6666004)(316002)(34206002)(54906003)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y773kxi2IPvLAAVAB4oknzBFpxFiDXW4BAqclG7qtaYabXtV/aSjbl1twMKI?=
 =?us-ascii?Q?ogXCWoraCVQHO8rNL6WIFYBrT23TFTZAoF7QFpxXPoxyAb5T4OTVYATm5g3A?=
 =?us-ascii?Q?tIlf/HvY4FqdH1J9VHBKqntZGyanJo52MlyzPqjBj/fPvpKGQAeDVOtH7wix?=
 =?us-ascii?Q?6gHxF3EwaJNnaBJT08vU9Dxcf/5qhph9NlHHcwuyQ+TECTb0mLaCzhsyONOS?=
 =?us-ascii?Q?eKLd5izd9o5buX8QOCRDdhBRCpdSA7Yj+GgWJo5/Dktr+MaoS+O2hnPXdwjI?=
 =?us-ascii?Q?0wspfXOdouafO4RgC1aA7lqEEVvDCOoOL1VDa6gjSgpAFIpk5/R6wUSDNc42?=
 =?us-ascii?Q?6t/lDYZjnhR07mH/9NOvA0jkmbGbTL7UoCwdDJQyUhkWki5GKA50gqR0fD55?=
 =?us-ascii?Q?aLbw3koonP+ESQX7npUZTa23hCZ3ZkZw3UHgRw+vM30wJq91TADZC9RUi3Ix?=
 =?us-ascii?Q?w3WUpoglXI9PPYVMKq67dTjEd2GAvLZGmNnCa12akCEDJtk7TzlWe0UobrZI?=
 =?us-ascii?Q?udvlJs1FBEBQ7dOLnR2tGxjW3YvVKgJh+mucQFO816ZmclzX+5FVNT55NO/i?=
 =?us-ascii?Q?YRPkeQBxmj6UAFPb67As0sKxmYEiULoONVYxoBKGZvTq9kCl9gpfOR4ZP7TO?=
 =?us-ascii?Q?pFxeiSWnPXn59AQCM2EcZhQVn9aSzH0I3eXp6OM+8dL7ONnwy/Vswp82Bh3z?=
 =?us-ascii?Q?sA+k4Ga+bZ4anT48StlUfQP9/CrF+Bekj62X7GLBu69imVrWXETOVY6O8IOh?=
 =?us-ascii?Q?XMZNZz+pccBF2iTuQ389m50vPBjq6olnxOIXf0Z8zU4SJI/FE2WrBFk9Oc1i?=
 =?us-ascii?Q?kHQR3KtpbscLjSroafqkpHxcUyUIG7KtaLamXvvjchd8h9ylTuJZoB7rDEog?=
 =?us-ascii?Q?Pquha9AdOnfW5kVyXafPf751uX8Ts5GFfb92TqmSzkxoSxF7RB7flA7QwZko?=
 =?us-ascii?Q?hTxlwdvoAhyqNNnzkkbP77WRANaamOG6xxGhjnUO//ZhQ0cf6za5bCkj4GWe?=
 =?us-ascii?Q?6dtDJiQdswo6+i7IiYfCXIHJgLW/0oNWmCqlAn5r3BJpiqx9MvSQzAXaPz0G?=
 =?us-ascii?Q?jsV0pFpyfiNnNCH2HHitRyBGunnLhwJZU35eK/qOQvRRDt+D/N0NKlWGFtRl?=
 =?us-ascii?Q?xQLU/pw2EnRJuZYDGxSTqoD+0Hw94wz5WVOsSaP74ZMUsmcq/qGQ41yuDZbq?=
 =?us-ascii?Q?fzZ/WdOzqPCTfFpUKzoXZRCVf8TpQ4EcGVqpYGCSfi5CqRQZBSv3zzLlBlny?=
 =?us-ascii?Q?Cjh9Xx496K5H0/1uhCt6Azok9TMIaJMBYtBFfv7rlrPE5q/dQQSXPQvxJnyq?=
 =?us-ascii?Q?V9rOAUXyFYY72w3SWt1yXhRi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016bf510-5e8c-4cce-acd3-08d992497ea6
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2308.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 15:11:00.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlCZtAxJ/FZXC3lwLqKCWJ0rB3/Othka5VEKtx+4kojt8QtwN2yZZ6p4/T6Z+EHY25BQOJAKRpIpnIGL8T8rHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7268
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>

Free the kbuf buffer before returning from the dpaa2_console_read()
function. The variable no longer goes out of scope, leaking the storage
it points to.

Fixes: c93349d8c170 ("soc: fsl: add DPAA2 console support")
Signed-off-by: Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/soc/fsl/dpaa2-console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/dpaa2-console.c b/drivers/soc/fsl/dpaa2-console.c
index 27243f706f37..53917410f2bd 100644
--- a/drivers/soc/fsl/dpaa2-console.c
+++ b/drivers/soc/fsl/dpaa2-console.c
@@ -231,6 +231,7 @@ static ssize_t dpaa2_console_read(struct file *fp, char __user *buf,
 	cd->cur_ptr += bytes;
 	written += bytes;
 
+	kfree(kbuf);
 	return written;
 
 err_free_buf:
-- 
2.33.1

