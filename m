Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3156D452B23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhKPGpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:45:24 -0500
Received: from mail-psaapc01on2097.outbound.protection.outlook.com ([40.107.255.97]:16160
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233185AbhKPGpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:45:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqVHL2+Y2TVLmaqMhX/to2o4RHE2lPg56vRX0C9LiKqxWCpfM8UHcMC/OhaB5VWlhqHdT/dxQxEOQnzS/D2wOA2zJ5N1Dzs4qtqZqD0GQmjdfcEd+fTmzbFx7nvKmpwAjmvo2QJ4nGPWdkfd0Qv827WAqibqnksJNtfpvvAJvCwyqlIaBxlt0Fy7QL+q2Obf41z1vQ+7NNbYiRDM31p98Vo0VqJjKHm5WwDHrx7riUCoyDMZabJQzsLUb++Y7QuX+72q6tJiYQTxAjpV5Es/QMCUtrmdCM7F/m+PvsnRhX20ZLR4mdcKSU1yBf/mD2iCr1zDhE72B2zMkNqXlZa2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4rex29SYtDNyhH08CwsoaIQgoQIHUNk3dHEnGMpwoc=;
 b=dd2ISIasaJ6PXMiExbzEI3RPR7jCtqNIKEcI4o4a7PV4JqfRerHymR/l2/DjuHx3TL3GC2hX/pzNujfLYI0u0Ut0FAHxyG9jgN4ZPGvhI8xg8ZDo2VGsPJSV1MoKHDwgWSAbenmxNIllXcnti99I5B7y8EtYRZHgzSOmrh5ZTjsOX+aaGV8oSZ29/W1k48wrm0tcRiaWXnvEQ+bMr1+xuJHFwsP7D+LrkrTN673yQxmGcEPCiJNoTLVFVVRKqH6+b+iSxMCI8x3jGwRvNACr/XugsBBfqdDrGrX/Sw4pIcNK7IXglVIa3BK5klvmLO7N8+Xwy4Qzh/xxsS64RIC72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4rex29SYtDNyhH08CwsoaIQgoQIHUNk3dHEnGMpwoc=;
 b=mw4P8OqqlON03EGlDF7LCspxb0hi1Cr46KsZVG/dN09CqC9xnc+7zGFjxVPWTbXoZycVUsuqStHxN1AyXQyEpQ/U5cFNwMQYFqheraNKD8DZwHATfheepB3GgVihemdhJO2UAKP6X9iUHy9mn9K28r5A9ZPgVhDZt4cW+k1AwF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2100.apcprd06.prod.outlook.com (2603:1096:203:49::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 06:42:07 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::814a:4668:a3bd:768%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 06:42:07 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com
Subject: [PATCH] staging: r8188eu: fix array_size.cocci warning
Date:   Tue, 16 Nov 2021 14:41:07 +0800
Message-Id: <20211116064124.8833-2-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211116064124.8833-1-guozhengkui@vivo.com>
References: <20211116064124.8833-1-guozhengkui@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR0302CA0014.apcprd03.prod.outlook.com (2603:1096:202::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.16 via Frontend Transport; Tue, 16 Nov 2021 06:42:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60aea1c6-cb6e-4942-a403-08d9a8cc3591
X-MS-TrafficTypeDiagnostic: HK0PR06MB2100:
X-Microsoft-Antispam-PRVS: <HK0PR06MB210015983EF4E5089A4C5A15C7999@HK0PR06MB2100.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTqC2QMXz4JOhaD08Dzwgh7pgyp4wGkWkRRcAXxgSN/Sgh7FbcPkzaIkcw8QRB/NOVMIodM4OHrk8nO/I2fuS8ZbTqkUC9CGkBrGGkVl4N7Nfh9thYKLI5zR+brhMQLJ6q5CA8CFXpAiKfqGK9q+kGwUn1btvfwsp4RmiuaBcqAX+VJ1zzwyPn8/ocA24P2hOUsaA3X7+fkHl8GqfYbSoXt1fQ3ebrGWPa7ca+mXczjXVU81P/QwO2mcfm+u3SxbpGgaKjgasCPTL55k15+QvLhkdRaWeWLYkvTZqbxFecqkjD54ESXW0KJZZwN7JwnMU/KRbzdWSOPRGoM0n59IufJXOOPRg2HImO2nEAG0uGmtS1yhLbzzrbt9VA1MNWLLC3UgawMGqit0x2KKItsIV90K9cnN4tXo5A66cGzobwXEc9dON7EpfczhL7qGW3iAyKFn74rIfNefnkYu2Y5GBHZyRIPR470SEdK0qSBs7ZaNZugWNDzyYm9I35elfjaajAdunQjxHl2EFZ20KRWevlWuL893R6Qjou/VPsplbaZlutDy3bKajAttz60u6g2LcCyZB6gFC6YQZW2VUfuknGpoqnYh5GHKizhFJx7piWfOn6ThQ5nfcaJGcOkcsSD71WjcgKlIxQl/CPKj2YJaTXMeURWXJh0bCrReaB+q2GUH6qGbL0oJ1p4ABKIhcfT44Sp4vu35IZXrF4vclB7X1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(83380400001)(66476007)(26005)(186003)(66946007)(38100700002)(508600001)(316002)(66556008)(38350700002)(8676002)(6486002)(5660300002)(1076003)(4326008)(110136005)(86362001)(6506007)(52116002)(107886003)(36756003)(4744005)(2616005)(2906002)(6512007)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOQubZtlPEomBRy9eo+8X2rSVYODxMZ8pUM2PMZe+5hJJeAJimwkFTTm617i?=
 =?us-ascii?Q?JeoP0sIjsKizDYrxI57qH5Z3p6VaqCYauqz2DmOpzB/LiUPNiWRibj4q6Js8?=
 =?us-ascii?Q?aksjUAssAvkHYxY0WxbDgi1gjPejMakGS9exzXfxAnWpMqOeAx9TNKnAmF0b?=
 =?us-ascii?Q?IuAePynwXrXZPDIhnWWdFYFs3mRlKzZsMR396JBdo/2gCzxFt3btc4YhcAas?=
 =?us-ascii?Q?M4vz3JOGB1OBeL7AA4ydlYhyCTTg+WK7AGNmk+hRoSwLQzqXUi1MNo7uXju/?=
 =?us-ascii?Q?yS3+YCwuoOB39dY6w6AaiapAs/KPeh1TURaAFZEWYd/GUEqSLOFo8pOmrrb1?=
 =?us-ascii?Q?V5u2of7I0I4Ql2pRs/i9893MZJJvn5kdJ8YUrMZPQSt+g7I1Iy1E8V0APfyQ?=
 =?us-ascii?Q?By8NGnMzdDT9xD/yBL6KcA2fOK8qknunYRBCpR8nYOvdnp01E+tjQHkJxK6u?=
 =?us-ascii?Q?iD7t+UfnqubrBkG+vimwUg1IADd0/TnmFWekZmy1ZNwzehJao5u4LmTWIJIz?=
 =?us-ascii?Q?25OnFZ1LTrqCZINDYKZKNH1RbfANq5dzWuw0ojM2mbLb92V0wTs4CDOnL8Zg?=
 =?us-ascii?Q?/iXYrP7wD2zWu3/8YfuNPPbbFRj8jfAvBdux/jQfsqE6ZcVLuNwtyMI4zlYB?=
 =?us-ascii?Q?anV4IM5XyueVRyyvMZXpfwgLrM8cHL2/VVQp+Ipk5ZY0VMOXxeBY4w5bfe/G?=
 =?us-ascii?Q?zUnCwqaDqSMBtorN3zy1skVYSWVuBK0yFZ2w2IfclPUMuVMof//89lA12/an?=
 =?us-ascii?Q?4IBFqXxCcRGxEFPObljf99/kx+WCVCodUNltBcThwHvyjc3XqPa1p22T0cAN?=
 =?us-ascii?Q?Utqrbm9trioGMpGzzZFC8jDUVkLKnp5JiAZ0lRbYL8CMBiEmc3qsJdW+gE+7?=
 =?us-ascii?Q?zu773I59IOil3LGb/mxFiwyWF3SYz1vPa2OXl7+9oj/7UZMwtDHvwlTf0aoA?=
 =?us-ascii?Q?Cm7KVBZXd8ykQeBFIhz/5aMRpMFW5XhA8XuiGM/waD/M2S363w59+jUFEl05?=
 =?us-ascii?Q?xfmLzaW6+pP8hsEC+fa6N3jJOyNsRIwBVJB3Eu8CxbSodW22ijVWc9nmi4ln?=
 =?us-ascii?Q?FFhg20dbjlRPF5fxQhUwD6zaUfUJQH4EukUvwn4bFS4Vhuvux3j0b0kSrklc?=
 =?us-ascii?Q?apozaQtKvQnX0ojCyEWFW2r8C4XOAxsbvG4BF53FQYwJiUiahHOvifhg41B2?=
 =?us-ascii?Q?kgWn2Mn3RCi+yK66qlvmQwywZgLI3K2tEtsIyqRSsfKPj0d6ueqamL3N2BHo?=
 =?us-ascii?Q?pZee/SK0eEvJtTZCulkNmEUXogD4ByOQrP9+slvlruxXGZ1Drag9u5fP24+2?=
 =?us-ascii?Q?z5FdVGDCiLNQkalB26TxvToZRXVtcdedCV4G7s5xwq6V8+jGv4XNnxQCZgQu?=
 =?us-ascii?Q?uWbJasMCGJNO1OTRplm/a4PnJRQMVXi8nfK0mmxh7vwg88632J8VkpPL+4TT?=
 =?us-ascii?Q?W4BUuTcVp1QBL9GgZavfeYVhKGaEmPpvrCSbRraGVgMOU/jBuxf/IkbAcsH6?=
 =?us-ascii?Q?YdZkQqH+hSKvJKZ5grg1lYz9mnklAHPk6e87RwqN6q7/gHwDjN+aI57lw8BB?=
 =?us-ascii?Q?wFsMU9N9kl7l8i0nHgsi3jduuz3Tx0MWhFmNFHFMYMgNdoi+4gEMg3mH45ZF?=
 =?us-ascii?Q?MNIVS5gEz/denliYOj6seek=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aea1c6-cb6e-4942-a403-08d9a8cc3591
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 06:42:07.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FRGR5kMzWmTW9b1EmD9Tep5dhqtEyexNYpX+OWKeRhmJm0CF7SwODoTO67INZiumv+qnx3pcEpDdRASoYzXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following array_size.cocci warning:
./drivers/staging/r8188eu/core/rtw_rf.c:38:48-49: WARNING: Use ARRAY_SIZE.

ARRAY_SIZE() defined in <linux/kernel.h> is safer because it uses
__must_be_array().

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/staging/r8188eu/core/rtw_rf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_rf.c b/drivers/staging/r8188eu/core/rtw_rf.c
index 2ec56012516e..e704092d31d0 100644
--- a/drivers/staging/r8188eu/core/rtw_rf.c
+++ b/drivers/staging/r8188eu/core/rtw_rf.c
@@ -35,7 +35,7 @@ static struct ch_freq ch_freq_map[] = {
 	{216, 5080},/* Japan, means J16 */
 };
 
-static int ch_freq_map_num = (sizeof(ch_freq_map) / sizeof(struct ch_freq));
+static int ch_freq_map_num = ARRAY_SIZE(ch_freq_map);
 
 u32 rtw_ch2freq(u32 channel)
 {
-- 
2.20.1

