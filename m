Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E604F44E0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 04:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhKLDGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 22:06:20 -0500
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:61152
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233939AbhKLDGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:06:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRtELOAxsHNoVbwK/7KrXd0a86JCRJeukK4qY9wJRphUWlle8bR7C4lOtLoODa7Fr/hAZSEy6L9jw8ar+g0MrF9hQk5DBXBgtViIv7Qs4R+7Y01FGfbLZjn2HY83oocYJSVjoWvHHQDR0X4jTEvQfMKWYreG027K2lAyHYyrB9RjEtobL8J9joMeCd8Kn0pj8kcZ/w1qxrxGKm3jF4hDV7Ft9IRNluZ0kQcwFoOFJSqC/cvwTVeAFigbJ7t1MPsF8jcSVt0X2K3ynodrmRaFDXSZeP7mVNruyfT+oQiRRNnoFQQ3pO8DLGvhHQrrIuHpYCTHW24xjCv+PC9oYc62Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wztogNCrreBJj4jRucXTlLYj2uT3DgP6KAgTqQiVDwk=;
 b=d1PU+keo21o7RVMKhkxyDC3lUOARIuLcXZtBIVm2vHwZdwe05Pn327xnHm5LVIc1SXA/pvsFEaT6Akt8ECWcfYM+mfeGB0d+ZgQDIfZ/6Qr0qzkUOWeBOfyAWQlSegPi4IuEZLRQuDElvtBp2e6zRTQ9LHEOw+NmJBgbuk3FIARvTQy3K9kw8JfVLecgytaM9/nwAB8i87ST44JrD1sGfhKo2+wjmJNTPv6DBr1eOQsVj+KwSfmoPYhXMV2kzq8KQpZY8H4XPc9cYw+jopgaCma/kJFN/Y5GHAvnNeZnSCWnBh4PaQd7sfpnEVNtM7wexrQWSS9tw7luwTljCondiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wztogNCrreBJj4jRucXTlLYj2uT3DgP6KAgTqQiVDwk=;
 b=iYVGu0NDCA8lKaZlEFagme06xiK9mwV94MDtruexNVYvi9B2nh0G6H3gAbsM3zGA9qgjf7+/BVmGwmV5QyD9BcplFS3pmvwSYlj3otHA+8UgfEAfzRQq+bvbPEwB3Lp8K7Q9wFUe/6ldjUvS71+YdRLf5TDgtJmTobP1TazPErM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2176.apcprd06.prod.outlook.com (2603:1096:404:19::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.20; Fri, 12 Nov
 2021 03:03:25 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 03:03:25 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Yihao Han <hanyihao@vivo.com>, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] libtraceevent: use swap() to make code cleaner
Date:   Thu, 11 Nov 2021 19:02:47 -0800
Message-Id: <20211112030250.4018-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 03:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e67124-3af9-49a7-8702-08d9a588fe58
X-MS-TrafficTypeDiagnostic: TYAPR06MB2176:
X-Microsoft-Antispam-PRVS: <TYAPR06MB217600C17640586A0FB45F42A2959@TYAPR06MB2176.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3yhoAnBGSjbQeahcR0BPAqGAwjNqSgaWGgmGsIuohjNRXOiXQarYLThKMUOghISpp3nJyWg9iJ6hIxAKRC1nqZ7Z3a+gUTI5jqRFDb6HSCLlbLf4UaOe32X4hc1VKUQVZMpjawWuUaDXgKEyzqZF4cDyEYhzD03bQRQm2WvHjvehsva3WS1Tco1qoLE3B6MQVY4bTxKzUH4v1TDM4gn1c7ZoeskgjefTPSAvW9rPCRt1j8tWH+4r8vDaC8OgbWla3lFnP4DlsNx8C5hL6rm9WwTjAWq4PDL1xYdopnuzeuzn62znr3AHDhD+vVTQQRkHQnj062l/LEeOtWP0U4jqTEC1a0YYUbTdpN3VEjgUq9cmKOqAPY1qzSSWnG3ycxVeR3UbTrGmwIFgrSHFeKX+nfOLy/yPqoY9T/bAEbQfwPX1QtBin+9IgSHTkON/BjLtIGSP32wuNzu+3KMRzwTmVMqBhS1UM485DEXBSbt6Fp/x/xRxDJ4B6E8stUvhbouUjDjYs10xDLajAdeV9xhhgHSRIHeTYG7DVO++vfOZEJMYBnPZawtjPvwRFL6LCFxyX3txGDn/aXIkUDH5psD33E97fPNlq2by98mZeQ6Se5wL8k+WQHChSN/lIioOdajbBNCOTLh5G1rOq+qjc+SzMbPEzKRHKULIIgFlAGYc6QWIHkj/hfIGwxziGPGJiU/+yTOt8teOgY8ddWTaC06Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(36756003)(5660300002)(316002)(86362001)(26005)(6486002)(186003)(83380400001)(38350700002)(38100700002)(2906002)(4326008)(508600001)(4744005)(66946007)(52116002)(8676002)(107886003)(66476007)(1076003)(66556008)(6666004)(2616005)(6512007)(8936002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4kkUGsOx+vHmqbKlxAoL6aR3n4FIUBZxI9pKJfYS8ChmUBQB5+M3hu0W3sY?=
 =?us-ascii?Q?OjEcj+nkbSUl8ZskXu+74+soBhdS3QzTYp0m70SSpwyuV1Y12SSiSP7g6ebw?=
 =?us-ascii?Q?E7F2PQfb1WsO7MP809m1ch9rTft+Y2f6wVJJf36X9Upq2G9fuSwBxBkQFuH7?=
 =?us-ascii?Q?W5RzJqzEbbCGEoMsRgIWQnd7Fwe52xBBzDeImMABpuNhl9jeS0Uogqzzjd6Z?=
 =?us-ascii?Q?wc+ZKVLTU2TVkuCj0FYC/GoILRcybigVmFqVrN7ywL62Kutr80bkLw2axuHA?=
 =?us-ascii?Q?ozqW2t+3mT049RCLXj7e8NnPP8r5rpE87XFlOLVT7Sf2PlV7Om466OTOZBbw?=
 =?us-ascii?Q?4wyyQNhLw+jDbEqrU9jTNDiXxExktrDAFFbJW7U2oMVOxyuuGW7VXdbCqfbU?=
 =?us-ascii?Q?w6BN9/O4A2V7S3f4FH5LhbcOQ/iGy+LNidfUmrsedxoDmEQQCoCyOYat5Iwe?=
 =?us-ascii?Q?JycVSmx1JVFrGrmFH/xHAZbnNhr5YBNCiLWq3w1gEAfJkhkroNgDrs0Svcb2?=
 =?us-ascii?Q?A5KmPC1dc0DTNIf91TX+YWfW2Q8EQAD5IJdJpluSHQRBdAnqOMXULgdt0rA4?=
 =?us-ascii?Q?nOetv2EX1yZhKpLU6kAW+BvstawpCzXCWv2wGLPRXCTbF95XjIRR5QdO64sM?=
 =?us-ascii?Q?yU/jbRssQEwlvWTeQo2/1H3IgyXpd0Hiv9rZoEDcwfxKgn9SIiHCQdKtBvZU?=
 =?us-ascii?Q?lC7/CDA/68FDK9/PUO8WUB229nq/4tmFN+gd00XeWdys/4xjhKcg4mV8YzGV?=
 =?us-ascii?Q?IleDqp9rU2K4mGkwebDTBGOjT6Z+2lXhkd8u6hqfLYqVLxuGxPBp0haF5PFg?=
 =?us-ascii?Q?WsGwSj4px2zCZFZC2ZY1rFnPPCwZyZxNP6wDwC1szofqc8XLm99p9h15QnZD?=
 =?us-ascii?Q?lpA2PQ5ah2lvZ7ZBAwUeuszmtowi08wCF8icVhJ8k+DaoUHEZqZbBvZxW++K?=
 =?us-ascii?Q?YVulOwNHFLPXJf6GGw8yUCyWQ9IDScnzkBaaPJ++/el4bh1wLEj1/bxYrAVG?=
 =?us-ascii?Q?dzfJTrYj5Anco+q/TyszBh3MmYMnqzo0KCsWaep8TNqH7qGlWr5/iHHFnnt0?=
 =?us-ascii?Q?QmJzGWIsh8fafDv1GZE8I9uuI6mREd93GyfcXzGLcUwP0527ReNHUPa9PsvU?=
 =?us-ascii?Q?vuYowoXSmtTmhsXXNp9629NL/LV9uq6qfTd88LZtH+8dr2vPuAo2VvTOKFeX?=
 =?us-ascii?Q?nwaBaUOIgOqB13LoH9yzey9yeKbIY1fTYGSRr/oDqlip28+DqbtR8Y++cppU?=
 =?us-ascii?Q?V0AJFOGOiMYSjgvrCRwhramKvNdFtpfLQp5CWjQfu8WmJUPPmZUni8mF+y5I?=
 =?us-ascii?Q?G/wReO8KpCyMbx8etEdKFj6NoFPCnvinzL/sgua6+0Wbt+XAz28OFzgiTAl0?=
 =?us-ascii?Q?1cxeJTX3dkOb1DH3rRfhvuIb4mKQq3iGDO/ZAJ3uzvVEEN9SaAfNdvuUbkXV?=
 =?us-ascii?Q?TnuA4Yhp+MUumUlqMO80SuTxJ9/omVyEXrPenrm443S9Eq+EEc4Zc2pxpvqb?=
 =?us-ascii?Q?QHZhITy5SZIacIEAezjWaCfkmi+s6abTRv5wlCrLd53jLK6wMRI0jZ6fEVXe?=
 =?us-ascii?Q?K14yjU4lBOvWCgXnY8zD9zZcvMeyaTjvFfiL8uVUdOzIvOZcDsOm+Vkf90+3?=
 =?us-ascii?Q?IKOkqMpfDtR8LHEDDvk0OEo=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e67124-3af9-49a7-8702-08d9a588fe58
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 03:03:25.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfVWxZSts6C6VeKrKlfPG9+dcyZBaquq1mFL7fzfBZ04HzphbEnoioy4DS2MRIcJ65n85qlYpHRpQF04rmAVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 tools/lib/traceevent/event-parse.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index fe58843d047c..71bddcc9ff3b 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -2081,14 +2081,10 @@ process_op(struct tep_event *event, struct tep_print_arg *arg, char **tok)
 
 		if (right->type == TEP_PRINT_OP &&
 		    get_op_prio(arg->op.op) < get_op_prio(right->op.op)) {
-			struct tep_print_arg tmp;
-
 			/* rotate ops according to the priority */
 			arg->op.right = right->op.left;
 
-			tmp = *arg;
-			*arg = *right;
-			*right = tmp;
+			swap(*arg, *right);
 
 			arg->op.left = right;
 		} else {
-- 
2.17.1

