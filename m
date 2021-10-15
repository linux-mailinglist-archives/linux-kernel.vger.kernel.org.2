Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4111B42E94C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbhJOGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:51:15 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:57912
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231949AbhJOGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGPQ2dm4lQ562vqfavPu1Annf+jWmYcRv+AsdZ4SwM6Pqqp5ENqZ3/npc6bQx5QCg7Q3Psahs8NUUI76TEUx6dejXuXlXtwmR/qdqcLraUzXH+5KMFRNrAweZw+AUveQ5W1XJlcd2+L5aIdjOC76lvWe4vuR4hJ+pwyM8ukNOGuBvVQM2/SBov7+28yHKFa/Hdy5zRENQZksWwM/06CiYxPn8pnig4R6Nfs10RYuAgNNgssvcL6dcjlKBXuZ+hYYlNsclH5nKIzTHRX1kPTjnWWIs1WAML+H4D7iehYYAFZbstnAdsYZ1qtcf09SUC1rsWCCz4EfRhlCaSbcGWts6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxLq7Niok6PfJ7F+Dk4DgdIRXGJ0bgEytLe06RZHsP4=;
 b=a9zYagzB9dXNMwr07jTxGICXjyYFQqcv/gcZmkQvQ0Ut6sy0L8jZQmh4hNRSicfkIRrprrVz+DxTlWAKC8P/H/dYeL3Eb06yhltn1bTV+JIK0b8PjFmpVOazYsYAPzQi7vlsfMP41ugYa4lmS0kQuurStaHjgZZp6mtnjbfYn8bWrAcvw+Tlo17CvrtraYSVk7MAbW/uZl0emYfebW/S6el4QZzFysUh6/HaSk5TgemSPp7Aa2El+51lmGkyQYn37G5wi8BN8VISbaaAsaZndXFXsGOrfVOShvT/vmRzPWJmIeYvd5KNcnzI8uFC5y+sqfN4LwVWPH2gyianDSFKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxLq7Niok6PfJ7F+Dk4DgdIRXGJ0bgEytLe06RZHsP4=;
 b=UyKpb0PsZ78bX/RPCIQvDIys3hfrDVv5OucrKK5ouW/VexUxItQp9Xd2O0lujXT68AVdyyEL6Hupl05RVc3T2X+TrgUyTxuFDUZH8Qy55y0jSWTv7nUwNocuKAD0PVAGApl9NSn5ZKm/etDHgKfnY2YkfQSZVghIuMTz/Hg600w=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 06:48:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:48:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] hwmon: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:48:45 -0700
Message-Id: <1634280525-4532-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 06:48:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56159a62-6a4a-4453-bea3-08d98fa7dcf4
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB3388588C54D71AE3638EC149BDB99@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqObpO8MVVLHccUhOEzGbedUn3x8N4JfqEsLNOhPV0jmrPBbpa/BhP4NiI1z/g080Bcrn7upj2DH8Lv/tDf85nW+9OfbP1cq7RRzMzJJyH4cVP0exvcP9FPvRU1StNBo6DDOfoTp2p4lek8OeA+CZ8JtMU8yyMYq7/7u5Wb6dbtlPsNVLIaZPzly4XSrqwSDhfDOH/SnBBWNTKrVRmp0G+g8T/KiR0rMc8rYZnY/BnmGNcUCT/9X7GXqeI5YMYbyfdoDq1ZyeHs0WvkWRBpyohT2bQ7qxgB06dA3mE9/F+rj8d7P5zF/suXmTu18hhisON63HrTHtOfa91H28gZfvjwoXHOk4E3KNYfvA27fuWWe4mSeix8vnI/tpAyFI+IDs4XBypb9yrYbuJeMDYV9tfXXpP8MVqqwsRoNK3bfa6CPvS2IWYyRQO6SDCGAE+uU05NwSB2TnX+ItTlQyc036aJl5jzfzB0dtftEuVWY3BMznb0cN4nHQqY6LDCja3b5WjjsK2BOf3YK++BuFPsxE/YevSvcw44aXHpaGNvwVLEeM9+TtkhQCLhxZmn541YRRA4hDe/pywyvzShCJVFJg0xCvpAKW8xy7EiZYwnCCLS0FhamsBjavBxSYuj8uDfysLrMAaFwOJ95qSTyIE75dwxVwXp+g8w8UfNXXEzRzx5Ile3YyVONcv5tLITnBMDIXKawC3SXawDxcc0NTlmbag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(2616005)(316002)(4744005)(2906002)(26005)(107886003)(8676002)(66556008)(83380400001)(186003)(66946007)(6486002)(956004)(508600001)(36756003)(4326008)(66476007)(6666004)(6506007)(8936002)(110136005)(5660300002)(86362001)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?loIwf6VMcnDksxPKO5n6vSSltW3yWIA9S6XFww0Zsq+fyj6ezWO3Euj6D2Ib?=
 =?us-ascii?Q?zjBq4OSl27VqPyqKO75TFe8FRfB3L6JA3Xxxa5zQNizIw7ESh3cxOQ/fb6oT?=
 =?us-ascii?Q?QMCylDbiJUi9GJ152CtX06sHO1+KXkk3ueSP2NTlU/2r8UfEOdQqpWLW8QZr?=
 =?us-ascii?Q?M1TNnlPUk+7+hX88Mk81qwo51cb1hBDj+CR0j2SuoRpyPpKHaRAgqxOEVfOZ?=
 =?us-ascii?Q?QmUA0kHBiaqPxk5YR1AxuAzZc8IcRQVlOrpuEPatfjI/4IMCbh1s1wIMCBPJ?=
 =?us-ascii?Q?8lmtdfPzxqvOuJEqThpjaztaVHd2mSmKTP+bIhfkRElhuLmZi6Ly7IFq56lK?=
 =?us-ascii?Q?KI33bCxp2XsOo65QRNAfwwmHKrphh+0Zk0Cy44FUL7fo25TKIjeAmesKEr2m?=
 =?us-ascii?Q?HMHlZd/NliJf9ThWD6bMt0cFBfwjd+OpaGOLq31IrRBNs54d0FGqtc2+S8ct?=
 =?us-ascii?Q?jLolIAvLG1weT+zmDTP3N7XCuVo2mOgfOL2LGrBmruA4RG4c9TZAVdNlZSyN?=
 =?us-ascii?Q?q3RZp4AVQ39q+n0UYPJOPvfpsJSM2EWY4FQq8GLphGcXaveklQCAA9ztlgud?=
 =?us-ascii?Q?DHXET/1WcUcFJYsNV9YGkOSl4OH3sEQk81VFbziutt1wdtBl8AcpkmzhVcqt?=
 =?us-ascii?Q?DaweI/PI58mi/0emXU1LUxqDulFfkrI/Xsa/CxQyQKp1M+JjmwzvQXXzZ9sT?=
 =?us-ascii?Q?5bA/2Hfl1jpvjAo3E5WeyKrsNVx/jqRU8ujd2G+J/MS6nMM8Z/dbtTpHipoH?=
 =?us-ascii?Q?ohcAbu9OTDfQehdIpbCokas6tLph3yAK481s3O2AjVuRqg9lCRRCTo7YIgDp?=
 =?us-ascii?Q?0hjWnIQSdOY8yL0B2chbncQ6BSa58gFv01ddoe+EW5FNaVfMfpdPt/JK3K7u?=
 =?us-ascii?Q?K54I6ZKMpO/7HRTcVV/dG9Z7UKGq0SDbPq42IexFcquwjLfD9/L+6azUrKMX?=
 =?us-ascii?Q?6g/HWgrz1imbP94AkMBtEJpzyfVak93TNp28OrMG2hCSDvntFTrHcV1ItkRd?=
 =?us-ascii?Q?cTzJeVf06wvAdOqrHGU96CyvKW3XGEhhCU6yxEqxS79a+p84xC3S9yKLZ96n?=
 =?us-ascii?Q?Fce3gw6mgi/W9lKB1fJtIIUQdPcBx/wZklV4uZa+Bd1siBhdtx1BknY0BeGb?=
 =?us-ascii?Q?1OjvEFcEbQ/oHNMFpo+fst0BwsWUitzo8U0iVv3RNDWWSmbamhj29DEK830W?=
 =?us-ascii?Q?whfznGWEl+EAYmj2XvRca9ntlcGgGo4pT6ufoToxyHl4YsGO7IqwxXnaw6DQ?=
 =?us-ascii?Q?UZeM+sGiZHqjXBUdNdCE5Q4kBedjmgnOi4YRRTKoGVAX/hLudlJw8VTSKmF0?=
 =?us-ascii?Q?+H5pN73ox6SGpeK+l4ZW+AL7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56159a62-6a4a-4453-bea3-08d98fa7dcf4
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:48:58.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u67cI7+IwVO776x+DDquDX7DGahYxiyLlcX5NfPjir5ILHhlGlRBghsJXUM6Y+J5gpUfVy6zcW6kLWpqgjaKRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/hwmon/smm665.c:378: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/hwmon/smm665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 62906d9..122031e 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -375,7 +375,7 @@ static ssize_t smm665_show_##what(struct device *dev, \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
 	const int val = smm665_get_##what(dev, attr->index); \
-	return snprintf(buf, PAGE_SIZE, "%d\n", val); \
+	return sysfs_emit(buf, "%d\n", val); \
 }
 
 SMM665_SHOW(min);
-- 
2.7.4

