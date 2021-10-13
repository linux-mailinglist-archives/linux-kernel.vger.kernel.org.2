Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBD42B384
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhJMDaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:30:00 -0400
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:45312
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237605AbhJMD36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT/fDQ33BoNrVgSVULUVXlvDzTg54xnNmRuEwapac/Ev3XSkFsyyFe2jZPp7kReQZkuAIEtWzl1idoJiglmOBlf1gsoHa1ar9d2qYsEjMxEr8f0FzmWViiuyjYu/FLf0u57aHCTqtzoK6Bume3vTjiuHtuDI/XJDLdAwbEp5Rf2wBoxJPC99l2RQkSKATksa8u4G3SwCajFrIQOabRtwzwqLSr+R5tDV8EZBGKvkx5n7iML9Rfdq0C4UPusQncvNnIQTtjk22O7sVuexu2tTG/dJrpF7cimDIJ5ufavv9QvhRb5uZJaDBnf/v8lIF93GfQU3+4jpbAtC793eRH8g7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UWIWtJHsfEiJJy2patvbfOPoD65IGg8eUqZ1SjwVF0=;
 b=S+smOb1c1aTRY8PqK1t5h+NQd9CZdaIbZoNoOGwJ86txg/zafYfQTRJBBpSM5cz5FAebIasKzx4jY9MVqKQlYYOkn0vJ32i1OL8pS8a/LAWCTj25KiI4JaHygmnEbdaZ6M0mXogJUFF024cE2VpOlLG58QsWa4N9nFSu173aZY7at5fGRoaRU0bgc5hwuJkDRfC8m6HEMGI7HpFDQP01Xv5c4gFp0/Pi7CokuJeLbXHAZ9UbYTbURyaLDu6rublPSqr0XM+dEl2vH7WG/TTReN9EEC3IhPV8DxVcCuUnIiYfJ3gjp3JBZ2Z5AYQnpD51Nx0VR57pIpbWOac5Jf+EAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UWIWtJHsfEiJJy2patvbfOPoD65IGg8eUqZ1SjwVF0=;
 b=FGZ2vKsTlTnQp2+PDG/QgSjXCBqNFrZLmGKaQ5euTKs9VPwbd/lgsHs8sOUX49XwgBiRd8yn8Ego6IJ3XlSaL597tM5UxDAMFepzUXmcWT3nAWY+WoMyzNwZzsnu9JWOLaDbzqsJS8S2clG4DGeQ0JSJ1959T0IafzoWLu+pDPA=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3243.apcprd06.prod.outlook.com (2603:1096:100:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:27:54 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:27:54 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] usb: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:27:47 -0700
Message-Id: <1634095668-4319-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:c8::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HKAPR03CA0010.apcprd03.prod.outlook.com (2603:1096:203:c8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.13 via Frontend Transport; Wed, 13 Oct 2021 03:27:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30bc43c-4f99-4a2d-7424-08d98df97172
X-MS-TrafficTypeDiagnostic: SL2PR06MB3243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB32437A6DC17BB75C49D925F8BDB79@SL2PR06MB3243.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lET0OIUjNAt0k39NbKgwyjMDw9P7HXGH5nMDbRVU2WskwVxDCMrSIZI438lb5xqrAAmMcNa9kuR2DFpVICr3dWr/yRLoz5tTtVcQ+4EtMVmICJU/7MyDbNtwBbhkOJEsLIErMxgg6p2LiVNLSdRbvADdo4kQTQj4nhK7pOdpPE7ULyVkyrR5gAVY4NaoDJ7IgzZyl4rACA9NVY8JzZXqRw92Vn5yJQPtGP3dR8U3hS0bfpuET4cERtH6ar41pHRJ29URyDy32vltSP8F1xlfEYgOY48grs/QWu5jg/0YRf4LAMUQ6+4PJrLo3LAN/QSamnvQPyKcd1yMjQ97NUuJqSnZETsb2lGZHBKRrCVgAzrVgrLZYv6CT265PVS43BMkIfM/OsNY0y81n7OQ5MY7AfZwyJPWeuH9nruX3+l1eT+Ee+p7rQ0mgcYlM8qGrm7KqQW522mxmLUUfAHHOKnkyMwQVdkRjEaWr33S26SjIlCMBE8SvVHhKUgG1yOzEmWzl4VEUeIA7/hlFbsZyks3yf3nddOm7cqPr6yzq6ZlJcE7XnWumqlROqeo4Y1y3+Nzxhwac7JeKXaQytVHcBwEV9myJvbAAaannza8MZlbwEZepgLeND50ihClLJcOzluN/R8kXKKtcYENnY4R0m8H6r6vzpPJWPmaQmRj8i+LxkUikOZNUcWnZRc6nvt5dxz8PFuYSJ2P594nfSLPiGhj3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(26005)(6512007)(4326008)(66946007)(8676002)(36756003)(66476007)(83380400001)(38100700002)(6666004)(66556008)(38350700002)(107886003)(316002)(52116002)(186003)(8936002)(6486002)(5660300002)(6506007)(956004)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/oXDUQZYaxiJuSfJDY6pDGsBZ3hg6CwLc7RN81u2FqWWmDk9eRD3owJ+fyZ?=
 =?us-ascii?Q?XkFNHK/hQ0QtbaMn/LDnWoZQtl5f6no3BhdGKunJ/6xMZxF9u2nK+/lZyA8G?=
 =?us-ascii?Q?qpY3m2tJH21ec+YN2pjEKnq75/+bm9K14IT2/JxrbLJJjxgtlCcvX7FJQTM+?=
 =?us-ascii?Q?klwgej/KfvLOErZDf8gMT3prabR6QoXc63L/BrVnExTe1Lw0+MRrG9zDcrmS?=
 =?us-ascii?Q?f+8r+ww4Ezboh9JPxRkACn+rNyZrj+PoWgf94IF2eDhBXw30YNRZefzRG5Je?=
 =?us-ascii?Q?p9V/+lxQVP925hOe2X9uLXreYxcqOHNDRzR6vhvU4jRrKtcAa+HJx0hiGhWV?=
 =?us-ascii?Q?l4njvy0jEiwwixlcc+9hlRU0fIYMGGZUYnMocXgekB6zMiQ2wnMzcLF0KoCF?=
 =?us-ascii?Q?JA8mhnKsIX9YJhUBamYDIlre/FRQYoGs2ekytujZkbNZMbSD6fBy6m4lmJyB?=
 =?us-ascii?Q?edEM532K9/6a65YtcUUxRdR8fKX+MbH9n2qDXSP/q/tJNWFEBjWN0YAAGx6F?=
 =?us-ascii?Q?QLcilP397Sk7kuSDC6aHnOnAedIKdtyeqIcfh9K4vQ/MEvxGRK8YwfvDb+mg?=
 =?us-ascii?Q?CqqTiYmBp0WZHEo4QfwIJhguAL75zZrvIh4sNRg5CaoSEpeuOFxUWUGTYuij?=
 =?us-ascii?Q?Nf4jwz4RChUGnzVG1NPeVgfJMQ0FJdEfcJ9fYIVLan7VmDBvucC5pHpNN5Qo?=
 =?us-ascii?Q?fFeo2VH0CSelflJDcQSLq77UYidl5Kk7fll7flGi8wl//fw0AG6imxvbp830?=
 =?us-ascii?Q?+I5scFc6wYdAMnrKC02iD3sWjoEfjwlGU0HzU9EUOi8/gFuTbmXpm5JPz3kA?=
 =?us-ascii?Q?TmkPxNuop5jh6948pNSTBCKjr/Nqj283X1GKNPnA7Vvf3DcW6qQsnJhSz9Ur?=
 =?us-ascii?Q?RA0caqUp2UlwceEh/aap5pS2b0R2eOFfeKDw3E7O7btHlupff53p8v7+sR0z?=
 =?us-ascii?Q?n1dAkbfqylgvCa8ovBY/1rSbZd4V/1MnXt569nVMfpBFMXKJ2FsceyOeBidq?=
 =?us-ascii?Q?m8av9mKdRkzhEoVwLHOjIA/OMBQEm/QTXyD/ENN//VQJ/wR5e3OL6ITC5Vvv?=
 =?us-ascii?Q?oChYoQUbvW/xi6pkgNR4H7+P+ofojqcjGxep+46rMFGHU6dx/R29EWQrETdt?=
 =?us-ascii?Q?l4ZhSlOYdxVGJ3MTeD/AwFqaSrPED7mYaJiDmBoic2+7PDGyi55dpCxtCAum?=
 =?us-ascii?Q?KVWME7+S8GF6JQO8Rsvzv9HbX/EMZ+P+cWlvbXpytQ4Adzb5/XCQQLPW0y/3?=
 =?us-ascii?Q?6vU9KT/ZgdvswCsTCbW6C2zsadT2CZoYYNdEii5oP4jZDcC4MoWmTkTLQWFy?=
 =?us-ascii?Q?X4prAGACyo6xU5qc9zLqkaNP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30bc43c-4f99-4a2d-7424-08d98df97172
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:27:54.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxaiitRWTLo5kAojxR3zNrck/hWFS+SUmOZfnTm2/XVLeDpWLpJpLSZDTKzKCQ8b/1DKiyNgyJznJLpvjQTPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/usb/core/sysfs.c:730:8-16: WARNING: use scnprintf or sprintf.
drivers/usb/core/sysfs.c:921:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/usb/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index fa2e49d..6387c0d 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usb_device *usb_dev = to_usb_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
+	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
 }
 
 /*
@@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
 	struct usb_hcd *hcd;
 
 	hcd = bus_to_hcd(usb_bus);
-	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
+	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
 }
 
 static ssize_t authorized_default_store(struct device *dev,
-- 
2.7.4

