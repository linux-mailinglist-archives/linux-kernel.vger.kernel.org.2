Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89936446465
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhKENr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:47:59 -0400
Received: from mail-eopbgr1400133.outbound.protection.outlook.com ([40.107.140.133]:30314
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232773AbhKENr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:47:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLnv8TJoFJ3PtPZdreD7VH73SLCT0stN+q7UHTypKJ8XJ1OEv2pJxFLBeamdMhNzJZRAUpRTHEQcmazDHIu9GcmqkqOvxvICnvx+9Kt14cC1LYnj5F4gotkuIiO1XEIUzmG5wpYJi785E1q6XrMNuTKslrlXElrScBBgkT+0foUjRIQ60+SYUgVkbhTnUfU0jUR9OGSoLwmFIGwRjFRwzy7iVvpTKnvb0sqcjNpB7Fo1K7uM3S/LlAPWxt0J2k4e0f/tbFAQyCljk4e2cyH4cBi7k3UhiPU1ZhevyPkiV54TOF/5k1xEn+AALzSzfbS703x0S+0AaD9uu80nIK8lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g7s6KhRX2oClvNROomUCdyNzHv4bDsT2QxpyYt2Lrg=;
 b=hXUb1mTQAwWPzKX1c16nJESrMbv5yDTJj7LSlba1zdm2g1Ji89dztGDUBdzJ1qwLvI5tM2BDWUFxS+xMRNoxcX2vGzzxNVwRH7+aqZbpayWbO0oK1BFXBSGUNaOc+HxJVAJA+YooTW6kvSfsK8eBWOq5aa0PqiBmUCxNgjpDJIHeW4gCdnHaX79vMgbo036FV2PEZr61BfPNPMzazjnWVZOpJ9LihxDB0QVAWR3i60K/f3LgwRoQaVuuz1aAPh6koRuOHP/CCq+vT5Uakhr9dMWKWj3dPy0URB7rmx7URxk7E/j8zpTDUNq00EjBXCSf/iCpAOxwXMIPGdymjHvcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g7s6KhRX2oClvNROomUCdyNzHv4bDsT2QxpyYt2Lrg=;
 b=TRPn+IYHkQc/yIrWVKs6ygSqrUXBnKw3YbpbvueTraQk8Bd0A0RNEQyUh+xqVKW4FSQcy3l6vMdcPbpXFurEDusocEZ7BsTuo6w0mP3VE17qbCOS68Mr0V/u6YOyHpQWJjifYWF5Vih7SSOGbEuRq4x4M7bTdf1SyLPIE4E/0Ck=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=connect.ust.hk;
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYYP286MB0954.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 5 Nov 2021 13:45:17 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c0af:a534:cead:3a04%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 13:45:17 +0000
From:   Chengfeng Ye <cyeaa@connect.ust.hk>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, Chengfeng Ye <cyeaa@connect.ust.hk>
Subject: [PATCH] HSI: core: Fix return freed object in hsi_new_client
Date:   Fri,  5 Nov 2021 06:45:07 -0700
Message-Id: <20211105134507.31946-1-cyeaa@connect.ust.hk>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:b7::8)
MIME-Version: 1.0
Received: from ubuntu.localdomain (175.159.124.155) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Fri, 5 Nov 2021 13:45:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e018635-286a-4d93-11ff-08d9a0628027
X-MS-TrafficTypeDiagnostic: TYYP286MB0954:
X-Microsoft-Antispam-PRVS: <TYYP286MB0954F1EA56AD823467B7CF478A8E9@TYYP286MB0954.JPNP286.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhc9HtPrN4Ahgj28cozeLBwUB04oVQ1Vd3ynGp01L4pp1VqI4f7uoM1VIIa9S885CD5qDasiPnwakmB/10ymKHzD6VAC3AFsZybpDKsHsHgJsrfzOumX0guI81+/1Qm2/K+vLvIlOzwTbSYXynp+bqcIxMKz3WSzMe/46SFwwVzyb7AUghTdPOz0N52EKR42TPO1OYYGH1tUPBrv1TwhiyKJLRA/t7SRcaYGF2gfssqxIhbs7WpJOqqwoaIkUMPuHhdOcpIOqCLAL7YOqH9882JMRyyienC1bRVd57Neume0PyGOzqIlTnf2Tggb8tpshWNjThZHJXsmLeUJ6oYUfDWaPz3fdyv87BwsCbBQgKTJWdY/gkxULnVbaZQIB25O4uwM6e7gI3lwjUjtrWbHUv5pL9qIonsjLpqgKZ0hAc4HMCiOGo3ObusK7oYvi1LJa+uJfgDykrY41xpzGb2xJsFfwQHKyhCDmeV2bhe4S5illQ4TA2VFukA2t4J44dY6e9frYv7P3z/4v4wu992nQapGOXNpYxlVWvv2nI+C/AdEh3NodxDpCdDd24D8u3zGcw45VQF96L3dAC2aMyeks+MxJW2nCYDzw8QhkbdLJbJAQsJDoQT6eM2IwObQILyjO/immzHLJQpHhGbY3HQduduP6VlVLx/y9hfk3H+2nx92Kt48T4KNCdUhJ/lm2Z+YwEYcEnqvBjQ3e7meB7RsEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6506007)(38100700002)(186003)(66476007)(8936002)(66946007)(6916009)(66556008)(4744005)(6512007)(107886003)(86362001)(52116002)(498600001)(8676002)(2906002)(26005)(2616005)(5660300002)(38350700002)(4326008)(6666004)(956004)(36756003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRzj9Fx4RviGhZjDt9xmbpC8aDIw612FHSphNvpxcjTWWoOg95dWB94aEb4O?=
 =?us-ascii?Q?oqFjfu1/3OlWR1WE9P3FspjyrkjC8tkO23nUOi7TEzd/BSG0VpzJQ7OgBLvZ?=
 =?us-ascii?Q?AJnzwZLOJmG9qt1w5BjNICT7Jq5ZhyupmN5LxY93HF1ZzW/djOtVZXSokcyZ?=
 =?us-ascii?Q?BhSbojbaH3dnDd1ZADY/ZFV1LX2injhK8o5ICYyGMrq4WrsJESptWjPXK6ii?=
 =?us-ascii?Q?mFN2J5+UXVzQwiGIKxJGXjmych93GXgBec05TnmhPMwMvo6j2vmSdptX/I3J?=
 =?us-ascii?Q?4/6UWoNBikaH2ug3uNp27iNw/m/AvkGis0YvIsC7UWVqZ6WeWXfc+CWhsm0Q?=
 =?us-ascii?Q?DobsZ5EW1s0q3fCn55JC9Nsn3IBhseuTLs9IoEqhsGcWW+59xBDlfq/rfnJA?=
 =?us-ascii?Q?w6qugFvrb2MHnkzTwFAn/gHTUfE9lf0VT5XaZhUXHZvYGbNwAG6EbfMmQbSH?=
 =?us-ascii?Q?LpUnZ4E2aDRsMmV3+0/myoBAtKrLxSsV7HaigYLvDbkl1u3c6nfqqGBNlVTX?=
 =?us-ascii?Q?i7hncFvBAyLZYMrr29vnruZffs2mJrB5kFmcXg+uSEoFCQcCtbXMdERNlZQ+?=
 =?us-ascii?Q?PbT/I+ckQRV00y/D7otWLFwsnffij7fF5ZoUjFGGH9IHvWsF4cMNhHMY8nRp?=
 =?us-ascii?Q?DPcWJcceZF7cUJ/49Eiy5zAUf3FQGhoxXFdpUH2OdtH1PA83UtKlTiWM5WOV?=
 =?us-ascii?Q?rUfu1AEZT6WTW7HPsXAUoR5iq41nFb4yE8Zp6lmBth/CIR+oVKJMPcnLi/Fj?=
 =?us-ascii?Q?R8dmxXvxd8SAUC9Qqlva+4vlehJjYpaonDSL0pZn6ply/j1LaZQB70FLdDPi?=
 =?us-ascii?Q?iPLf6y0t0+dw6+GlmbOtVq5CAefkWbDwJyczEh3vM8p2hVwtGiuc9LDgLVwo?=
 =?us-ascii?Q?9/ol6T/lZBBaxzYAVvwrthQiD3yi5XU9K2WULjkLmROFTVhpvq7+43oDUC9F?=
 =?us-ascii?Q?9oa+S7c92qBoOBY+LRytm5pmARg16D0hm+/yTxHvYDuCWZnNkOkrvb93Zdjn?=
 =?us-ascii?Q?sxO8YgCstNjFo/mAP5kiJtN60RI5O214yFM6X+nG3v0zjBF0bvbXnSPsgL5F?=
 =?us-ascii?Q?7qdCz3dhxUcH/NTpGUL229dqFtITxA22O1iw/lr+BxaMcSCHVKqzdVhqja18?=
 =?us-ascii?Q?pv383aL9q/xexZGfSgiMBJb4dGTfP/S2NNfWkdXTTZYns2+6R4vZInoTp/BG?=
 =?us-ascii?Q?5r1jvs5Dg3bwlQOBoKJUHbttYum93GrLkumq1HabJq/xHwybRBAimjn4JHgu?=
 =?us-ascii?Q?i7/GRJ4huxWEFeixFJNMBfNcwdxRFCRYs0TwZNOJXkbK4NZhG1StOflTo185?=
 =?us-ascii?Q?nR4LJhqoOvwkgiw1v4ws1bgiEKAlG4g7GPMScf2oHK1841NfeJNE7Vd/mLpE?=
 =?us-ascii?Q?+2nkpeRK4I44DAjFbGP78eayu6zDBXiSOSFdgq0glT8LBZ4gYmCdbYNIWv69?=
 =?us-ascii?Q?Rkx6YEwTXRh0bgPpWYlfHiFenMvVBX0fM+ICTYN2zhSIBQiIn1oLvriFXije?=
 =?us-ascii?Q?jB0aY7dMCNphjxucGgXkHZwpDZAlkVhdGn7IJ4NcOOsSGKKJqMkgBWm/RouZ?=
 =?us-ascii?Q?ix4+LtORnGZEQAt/wFfzK56LivYQmr7WWlPVOBdj+9ErPDr6YrqV+/PKWC/6?=
 =?us-ascii?Q?hgS0mAHxoBlCOI8LivNO0ec=3D?=
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e018635-286a-4d93-11ff-08d9a0628027
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:45:16.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWN+w6NPKFVMMemUaYbiEUZzxG46n5n6hNsTZ/Wnn8olXzK9Rh2r0XpE57iAGF4LaqbbGy73jnVM93HQOYjYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB0954
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cl is freed on error of calling device_register, but this
object is return later, which will cause uaf issue. Fix it
by return NULL on error.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
---
 drivers/hsi/hsi_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index ec90713564e3..884066109699 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -102,6 +102,7 @@ struct hsi_client *hsi_new_client(struct hsi_port *port,
 	if (device_register(&cl->device) < 0) {
 		pr_err("hsi: failed to register client: %s\n", info->name);
 		put_device(&cl->device);
+		goto err;
 	}
 
 	return cl;
-- 
2.17.1

