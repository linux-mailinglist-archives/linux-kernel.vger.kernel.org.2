Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC442B85A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhJMHFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:05:00 -0400
Received: from mail-eopbgr1310139.outbound.protection.outlook.com ([40.107.131.139]:52544
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232006AbhJMHE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:04:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH+Fj+vTg64EHGEyB/5BOfPNB76yeSuiGjO+rBGPZl8MXH6L7UqUKztnKODGvt76BADwIg3QWoItcUZTQb4A+WpccfOqOUjGZKimYvww/H7+uWZfzTQimfJpXD31ZtbJhA5JBiiXjy5p9od6gFSe1oY/O/laVcYG3KsA10K7LI/fFes3Ve9zRE4Mpmn3yOoe93WZR3RRVMM7FF5IEQ87ZMTrUmhw6fbpFqUNMNppkKDKfdDIoXT8RSTz6RtIcp7GADvRstGA1eqSNlLw5cG53sQpH1C0DqMuY1SoLXcDTreL2xjgKbldXQPvZJKDJl30aGkJ0NWStn7kxYWhtniOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo9GlYrhkYre3CmliqtCG8fgOpGRKa9+ZbQW2orPQyI=;
 b=fZGiBgnSea5KrKSvCRQGou4FhBx3QvpSameuqU3+Km+QwRSKvxeWIF5Cb+Cl/zTLn658ndgqGY74Fid66ZqLpES6RKQrPJWGw8XplL+ArQGcwxzzWtb7cuIjT9LEVt0BpgMo6kBmIGAAhlEvy5n8ZH4pUAijnI8Ezp8z3gfh2k4GtpHmGQiC3Ak2rReh2nTQiOAGshc3jCRDteGiVEEW6vwJsqqR+uv2vEdXSb1/4WD2e1cVeMAcYwGHfbPqfVR56jX4xVpYddsS8o+Ae/cmpxTJbGtUkLrR2PU69osYTX9o9gTCG924KZqx8bMd5lyyNNErfarRkbSghfuASx7GeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo9GlYrhkYre3CmliqtCG8fgOpGRKa9+ZbQW2orPQyI=;
 b=KsXZEPb8j4zOHTibhR1a5LoeBKjxfeV2qS9NhnRthgw+S2qYHeLEalmbPMS5XH4TUglG75Ma8v8sK+TaBMCGULuCfKC8OaQyBX3/z3n94vnwBfsFIybqc86IZtI/QqH32RykvMZGHGNQSQDMfMfjPYRvCLQG0eiM3VDRag/tlyc=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3822.apcprd06.prod.outlook.com (2603:1096:4:dd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15; Wed, 13 Oct 2021 07:02:48 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.015; Wed, 13 Oct 2021
 07:02:48 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] staging: r8188eu: use kzalloc instead of kmalloc and memset
Date:   Wed, 13 Oct 2021 03:01:28 -0400
Message-Id: <20211013070149.349-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 07:02:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14dbd822-c295-45bd-98a9-08d98e1776e9
X-MS-TrafficTypeDiagnostic: SG2PR06MB3822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR06MB3822A3710CCEF8EA12B5A107ABB79@SG2PR06MB3822.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8HHWqyLsq1OHRuvrk0vwVpkJcMUx5aqkWf79pR/Jw0LfaSFk6vQ32I5FOqeEaLUBzzSV/xfbUeiDFNFwdyNozHE7GBB1llJimAgU1fA6w55N1lwNUV12kXKSYGeA+xoBfbeXxgk1tZANx8MqwOG5JjSesHtZLNXGFzi9Qw4uMUVd6sWOOHDSYoC4lLNPyZABLbxTJWLopt2S++Rjt2grxjxT36F9BRaiMz5TAfKQiDRmoAIcvq7eksFjFnZpRBVIsYqxQMrb3ixoCg2FDiMp+D+Kdo/IozZXoX4jEepJRjC+OgUzZ4XzpFTlhFpA4zSsGhJf3YcLV+xb0eQipgv5s8voKp3FWEsNcygJ6+MdiHECRCl+Cqm51/pcKvaRZ16pxN3c/MSKrvZ4mb/aXndJeE5QUNiQLE2JT/kwDTRd16129XoUurNU+uBdPsfh5NRj8WitUoDJnEjLGDCe+rb3GX4CGoI3rJs1dYjggQ3i4DzmJv3bmqczJgy7JDvysjLiNEAxPY+xaDeUpmPBhxk3rRs6LbCUADkByeYSUGYvyVrSf8GK0FyF4xg/RxztoXMMhCg9cGTPptMu9JIk+RnbJAUWLILHO09gz4Cy46qOUE/jaqoZzrGAtdUfXn9/hwah2CfFHMeh2feOym3S/htlPsNrxyBpjY87YYUAJ0KEMI5bqrQvDD9Cr3GU2poArHangAU3Pl4W8j2Wa0cO+Q5tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(107886003)(66476007)(5660300002)(66946007)(6506007)(2906002)(26005)(1076003)(6666004)(6512007)(52116002)(8936002)(66556008)(956004)(2616005)(186003)(8676002)(110136005)(316002)(38100700002)(38350700002)(86362001)(36756003)(508600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEHLliqrX+pi/jbPjkDDCrilgM1L/z9InRj3OgNEB9Qfm901u3a6zgIdAQ29?=
 =?us-ascii?Q?/Na4nPsjt1rdJ0AKh9ACiUvAaupGuH4o7ctMMPq3cERsTwI/h3w7a9rnWRhD?=
 =?us-ascii?Q?102MMmmm3yFQPqZtyQcmdDiz/ydntcDUWeQRwiENdqy8srm52qaS+2+BEgb6?=
 =?us-ascii?Q?aH6T6O2p1QKfRPQ8f/dF7/xqv7nZLcsQyHt5+eqFo2mxMYcEftrpuj0zsX/K?=
 =?us-ascii?Q?ARCxEvuqSDUlUcy2TAXQtC8MS6edAq67Zm5I5s7J3yy43LWR2KF5mNdd/MDz?=
 =?us-ascii?Q?8AQoWZr6Ig0IBrDnjv+zwPIDvydpcgl7DYkfm15qywqERdEdRjGQlkuYO5rt?=
 =?us-ascii?Q?TQQndUiMNk27uEJkiBWqbsqCAjxT5QF0lXBR7/7Mg2/PT+B1pe2iDn6S4ciG?=
 =?us-ascii?Q?RBkz4rvpEQqVHiTGKJJ2aC3d4IP8KkvKChqSMnTt3SC9NhIxMEb9t0XSSyps?=
 =?us-ascii?Q?9L3x6nx6y6nMoZA1ZQ9JNFTJ7knVWs1Hvxwo/b+nlSMAUv25z738OuBI+BGv?=
 =?us-ascii?Q?OdHgMD3a68CDHHUb9Lo3XEMmBF0hI4KM9TqYuh0oYeXpYl/vsPGZXn21xOac?=
 =?us-ascii?Q?Tp2TzAg/0buZVV/vw94P+If3h8AnzjI38ojo2i1DZGow8oRaZ84wpBVmckLA?=
 =?us-ascii?Q?jPIMFxNmRAGZU+pxpb6Pu6d/tTLw2xUQr82mmfS8ASESQR3R66b6Mqt7o/Q6?=
 =?us-ascii?Q?sMt2ULNeVtSONMrwV7ud2QQUsVq0wwyEV2mYy1145VmLbnc+SGqeF10kM/+J?=
 =?us-ascii?Q?YN097Pp6GXU6lXDG4wCcri8s4GcuLQkfc6ITPIDlpu4X6OqzaU6ZXghrOj/5?=
 =?us-ascii?Q?VLfqv8B/DqwK4WYTIPxHhYccMk0ExGgWhe87IrmKicpFgwuGhFvcIJ9TjCoB?=
 =?us-ascii?Q?9/SuchNpRGbV+Ec7OV3sktQO1tRSemaCLmqfn96eiLV+sH8QYzlUd3R1PtGn?=
 =?us-ascii?Q?3SS8aLc/+wchIpiNKAIUNGk5othJ0UyAI34rdSUAVPnljXqqBaknhVpzTllA?=
 =?us-ascii?Q?W+ZKBKeD0M8NvyPV9S1Yh0z+shfjGmhKv5xr+Ia9GBZBhbdcD0SJfCGb0LU7?=
 =?us-ascii?Q?jGRkz4Dvc3DPCTf8B/UF0XyiHdNxAeru5CSDIdDZlM6VzueB5LIgHWl/hQeZ?=
 =?us-ascii?Q?/MkE33WcMBHGtB5CG9W+W7gqQXYKaFWP/hIN2DcIcgLYrAjwgKwwaFKiBocx?=
 =?us-ascii?Q?AeQbqnvp92qJu6g1Hu5f9nBWPhyKEJ6A787vrG+TTUSMQYCRhsCBjDmy76Qj?=
 =?us-ascii?Q?g3tTFX/PNoA7NDEqmbfVMaGPA5FaGmxaFPq6YK/jMJNbiNv0IxwEBEHKzHvG?=
 =?us-ascii?Q?x+JSVH55gcMmGrC0o1VNql8A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dbd822-c295-45bd-98a9-08d98e1776e9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:02:48.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM6+WsZHXdAayfbe5zeJa8iZm9DkMQQV983cKAImHsQBz9DJvhOC6Txevi7VTDdFCqMLzAi4fQma2288MtBmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3822
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/staging/r8188eu/os_dep/ioctl_linux.c:422:10-17:
WARNING: kzalloc should be used for pwep, instead of kmalloc/memset

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 0201f6fbeb25..51f46696a593 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -419,11 +419,10 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = kmalloc(wep_total_len, GFP_KERNEL);
+			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
 
-			memset(pwep, 0, wep_total_len);
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 			if (wep_key_len == 13) {
-- 
2.20.1

