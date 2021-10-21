Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB4436184
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhJUMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:22:59 -0400
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:28496
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231297AbhJUMW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVmUT5sIjWpc36k0/FNVd36V37xYb9heXvr+MXMx3CjcXsz566+ZwUUHYQIiG6RvLXI9ZMlzuU47hbDj3cSav1yNmYtKWRhKUciVOfWBJY6QIF4zfvq9UGLwGwS6BX4jCtylLA8iMVdkbhYtrl0wzvBbk3y0PjfBP7qtfQneY2Y+uiiFho74cbDRjI3tbPGhs4fX3AyOvppkucdCsGqnQFPB9iInUSQXrjLs5KSxVdojbui5YuyyET9xIHwJg1KNXOKXQhd+wUdgpsmb58qVyrc2SUYhYz0hVpwK1sFA1YwSiBFg041IqcB/Yi3EtGcEBgGEY5tT9b89MQcDKmUStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwFH0p6VosQCWgK9zuDvf5FIYxjHiW90JksQCgyWgNY=;
 b=oLdZwVTyMuuAbAwehlbSshBADy1yY9UTfzBKKunawgXJ2SkzkGpuIhdHqiN2C4lUjClALnm5OgUdiXduosxsiozg8vmn3qkd+jIjaxqa+Xy3I+t3TEU2CZhRSBwwxyfEJ28Y29PBIslc61EARyCOlnk7LLkTe0D8yhn6y93kfEAQAglfsL5LBUCPTixkStC+6SGjoAhZFu5EndGj0nlXaC87OG4/KnT50cSfDj1A+fQbMqcOxbwOLSzVnzLKlczk+3F6j48SF98wz+xviDBdrbioShFQ2oiGNekCOvKij/57VPMN+/GaaAHibC+VFuW29QbB3I8AushZyFIjQmD8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwFH0p6VosQCWgK9zuDvf5FIYxjHiW90JksQCgyWgNY=;
 b=QhxTwzuGnzUW6yc/IRQrUj+Dzhe4bLWaJNF9fLCugOuuyyYKyLZjku/Eqh9aejg37NNtFVVgm7OA4DHMlStVCcCBN8i1JOqcKcsdxpjP3x0f5XYkBb7Nf8oZg/GuS2JwNWgIDhtZRLACBmajjEeH8w5sKXhxJUwspeMOhulgN+Y=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3727.apcprd06.prod.outlook.com (2603:1096:4:d9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 12:20:40 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 12:20:40 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] staging: r8188eu: Use memdup_user instead of kmalloc/copy_from_user
Date:   Thu, 21 Oct 2021 08:20:02 -0400
Message-Id: <20211021122015.6974-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR03CA0058.apcprd03.prod.outlook.com (2603:1096:202:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 12:20:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b95954ed-099b-42e2-10ae-08d9948d31bc
X-MS-TrafficTypeDiagnostic: SG2PR06MB3727:
X-Microsoft-Antispam-PRVS: <SG2PR06MB3727DAF49FA6E9C97A46DC90ABBF9@SG2PR06MB3727.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4ACjoCvagGXvjT9R11ZFNLbrNZD2qYSL478JFDafKjp5y51v2d6WHGQcm/xRJaNobBqxrhSopk8PfLGZkqd9YQz4XH/cVIb6SpcUWmWVle6pM31FilUXmV2qMjFNLypukrKnStUJqTs6TVhA0lhbxXKZN9sfHnMNKKCn99Ek1t00hhkxILFKSucx4ijacm2lg59WrjpUeXTtJLvM7gEKr+r4+6UStxp2ypemZCZyqQZASH6UYHuj6bFpsuSorVVV1M0CDxe08IWw79/Hprv4dLR0WcRiErR4rRY5/mWKRErqlUqGyB7njMCxh8YcrgNn3IzPj6SwWk1NEKeTap8UL8eMDiJChwbnQhZ0DPnQmm+zloXqUiIpaF1+9gRY3mgP/i686NtjvaBRV2GgDHfrz3eEgWiVAZMwcq2fm6xCp2TYeVjZS0xFOamAOqwU6g5yyxb4Kf8Yf3CIkYqAsv+PuR3VK2EAm0h3KHMUgiL+9KJhs5vCSHjrX+cURpiAuLah+omgo7JNMQMAYEg9DcgXCqKAkr3a2LRLEPe6kq/j+3RyqHNTXpVjudLjSaAAIYhwwzYUl5hKabE4fZkMHu2auZXJofPF9m8ScQDjn7j1WDB/fioihpCMXgBou+y54ARH+I378vcT1qztUHjw5acyd5cV6e5Pdo6tKJl20AWGCdIIuQS/8hAzoT9rhSZkXvKh4nBfaAJjz4jfh544+F9hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(110136005)(2906002)(36756003)(316002)(26005)(2616005)(186003)(66946007)(66476007)(6486002)(66556008)(83380400001)(52116002)(956004)(508600001)(38350700002)(38100700002)(1076003)(6512007)(6506007)(8936002)(5660300002)(4326008)(86362001)(107886003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+6U2rpNdh2hf5k1QhVBOCDLSKGkPlv+mvFLULKAxzsk+q6jRaEsDoV/gYpW?=
 =?us-ascii?Q?shClID0T2w3SWqnvNmyvtKOtzIZneazA9YDnVgb/G2TEKfUKQ4ifO1d+4K55?=
 =?us-ascii?Q?cPDkqAjryoujiMU7Hnx0eUkJsPiLYIzuYrn6xEhdQgTidyia91CtdOW1f5VV?=
 =?us-ascii?Q?r0LT8BBpUS1i+NN4Ka85F8MlP3JMzDTA0Ju0nwBw1SrydSKx07TgYVFRXre2?=
 =?us-ascii?Q?60OX2KXqA7zZEAHbd3CL9MgrREeHpqZO7JOmkPrr5VjbwxIep3HUhZEL/cbR?=
 =?us-ascii?Q?PmK66+RmK7ykRYuvzBtCsh6/G09ZiNOr17VMX3zdOrmjDfEEIwaV+W4RP1sp?=
 =?us-ascii?Q?+pz9lqRy/L5hkdSLGyaju71U+lzKodPHVOGf86iLq9sbyaRDjT+jWTrt5O7Q?=
 =?us-ascii?Q?N6RM8IipA2iY7C7SGnnj+4Mj3ZfK9G1ewnsihUGpPoqLg3UpEPigNjlZKRvb?=
 =?us-ascii?Q?6k4I5LrticpU39gLulFG4NRlAahXXTFtDUJHSl9/kOyLVeR7A20d0z/4UPh9?=
 =?us-ascii?Q?v2BmXDVPQ2tV9ntCZ7ECZqHwL2R7tymrOafXvAVjmhUq60lIYN9R4KSvMh2N?=
 =?us-ascii?Q?abKWKMOxLpVK4CXWiuu8kcWLA5TIO9VJyK7Psmt2H9MiFBWDBFxRYk0SREbV?=
 =?us-ascii?Q?YN4EpY5+aQnxkGEilcZ9Jv/d5PhTnCGQ+6X6lI6C01Om2Sq8t1K1Yoj5CFpK?=
 =?us-ascii?Q?5MrjysHrm7hle8ZqAq28f8TxU5JWdUoKMIaXMdujxMIMk/CVY/9JhL2B7Zwk?=
 =?us-ascii?Q?G4Twfl1G1mOTg7lvBlVgvDS6t0asj/zFl6d6+0M1EnDXG4yFWgNFmKHmrdNR?=
 =?us-ascii?Q?GN7WPdcFZzLDGpZN2F2MDCcguRc8I7l6XK0XhSgAoQSMmkxBG0RIGMaa8ngZ?=
 =?us-ascii?Q?R4kqA5e6BYlC3UxVh7+MJiFViDYS4k7eVBDXPKzhbQ9OjgQ2sqU+KejVeUDL?=
 =?us-ascii?Q?3kOtptKJhHNwLYQtkP0qOiNCjGGJ1saT8sOCrIyaId0iQhKPO7dWsQvbpfYB?=
 =?us-ascii?Q?/T1JLvatJgANdxjPdPgw8AJqpoXOL+wWyQHNDbk5AbKrLCTeZQ5D0Erjr423?=
 =?us-ascii?Q?RRm9NEnSD61E7gGDSEQS0CAltvivtMMyMtJGz/OGkexJ4CBEQfvcXJ+MiOwf?=
 =?us-ascii?Q?dpjAgTOeSYdOgtDYtMeScUSozZZ85bdUkQqBw0vc/wlw++Y0tA2IMTzLaLbN?=
 =?us-ascii?Q?gSRGcod7/lO/Jq9T4YyTLUbALs9mcnP71oyDl9MldjzIWgDxfW2C3q/R5FaK?=
 =?us-ascii?Q?9ckqgMr1YiiwM2uu1OTj/L4FuoqKGT3a+EBWlMjWKCMYj4xySsl8ybSUX2iA?=
 =?us-ascii?Q?4abn0tZWvGRDeefR9brly+NhP1MM2NnTkZ+cS3Xf0xdslBYQCIVNhvUYHU1i?=
 =?us-ascii?Q?pk0h+WYez8DtZEbqoQtJl8C21wJsVvKcUXY7tohdhf/Ryh79mWkVXQDU+pOm?=
 =?us-ascii?Q?Laww/kAmf/Q=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95954ed-099b-42e2-10ae-08d9948d31bc
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 12:20:39.7362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11126903@vivo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/staging/r8188eu/os_dep/ioctl_linux.c:1986:8-15: WARNING
opportunity for memdup_user.

Use memdup_user rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4f0ae821d193..301a29984fad 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1983,14 +1983,9 @@ static int rtw_wx_read32(struct net_device *dev,
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 	p = &wrqu->data;
 	len = p->length;
-	ptmp = kmalloc(len, GFP_KERNEL);
-	if (!ptmp)
-		return -ENOMEM;
-
-	if (copy_from_user(ptmp, p->pointer, len)) {
-		kfree(ptmp);
-		return -EFAULT;
-	}
+	ptmp = memdup_user(p->pointer, len);
+	if (IS_ERR(ptmp))
+		return PTR_ERR(ptmp);
 
 	bytes = 0;
 	addr = 0;
-- 
2.20.1

