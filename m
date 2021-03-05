Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48432E35E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCEIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:08:24 -0500
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:7790
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229669AbhCEIIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:08:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A13YAuEcj4GaWUGpsVfeEhW/erXG6X+FAQuNg8S90zZP48REe8Af1CmTpogKdFo/o7wP0QVcOL82Hc8vqb2NhDpVuBkeOFvnbIdryDy7GBWUL4W6MaWQlD8cEzvfUHTyQnFYcUCaZLWTGsCAFIg8mw05lvECW9WYTIeZLR+B5bbgk9A/hywxBPOlBlUq1Br44dm7OxLsAUahE3Od+Ae5BNRfFINMphP9ndAOxMbQgCmJnNsXrG/gDImPKRNmv+W2jCkhDjzHPyBPV60seYApfKjH2LikEM6+Wu6tysvakx97HMzmB4rSQRCzVqrLvTJwT48ekJCIRGDFeX8jzaHcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pblvAzrrZL7MJ5ZJOYZcxMUhbNf9jVdHxB0pBxDWKgM=;
 b=CQsMEwXO6SpgkjmNB3SSaCdN4kkk5SsJLA4CKu/r70HIojL/pRxyvMaJn6Y9bZjFZM6HJT+zD+/E4q2/K9uwY661tVohhlOtFxenqL0Gohjdz24gO2xgb7geEpNKmBZEvDNpQ+aWFKM8GPGPLDahhS17D1dDoct5lWcQyeIMeZbPw5Nr/WAsHy0e3ZBSWB+8rdDo0dy6xlsSFsF1F6s2fQ1mVIULMGIlEIk8OAVGJGOCewpaI9pl8GZCm+YYeRPR87H5V3KjgHQWJR38F3qYf5aqDpA/V8G6Z0r/L4n1n8SDhczPtZKBLy0fhKS055/EQYF2sh6tbrkRTwKpbVwCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pblvAzrrZL7MJ5ZJOYZcxMUhbNf9jVdHxB0pBxDWKgM=;
 b=UAbzFo7M32zyKpUMPrmoMt8/MLFRhLv6BP5yllVHsdtDIGxLoPICAMThZYgSWpWR6RUpnEpKIsPKbrW9MBpGurDscAXCtqqfZoArN7ovhIgCIGGeH+q2IhfpnDZq3xGDFmPQ+NkbgOpYY3bManhnTimMPoSYy43RCrpnEVOBXEE=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3020.apcprd02.prod.outlook.com (2603:1096:4:60::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Fri, 5 Mar 2021 08:08:16 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.032; Fri, 5 Mar 2021
 08:08:15 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] erofs: avoid memory allocation failure during rolling decompression
Date:   Fri,  5 Mar 2021 16:08:02 +0800
Message-Id: <20210305080803.789634-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:08:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20d4211-809f-464f-a1eb-08d8dfadd409
X-MS-TrafficTypeDiagnostic: SG2PR02MB3020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB30201DFDE83175AC0ACC8147C3969@SG2PR02MB3020.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqvW6aUJl8qca2dYpxU4+xxJqof43oeQjYrtbhvui9tBMJjc4hWm1U9aqo0WoHcHnoeaEjbWc+wxShoiaUbmKleVvzYwbJlhTlm3iu3rAFtab4fJ8od7sOM8eYEis500m1wchy0yC4QVcphSNjvLPC1zDxWZAE4E2GbXGhkGnX6I3VyCsuGODULW0MEfzYyeVxkwgu/iFsUuDXai6HgtiPKysOInhUvET79Ve7TeJdKf82rMpRx9MNO+l2Sqz4W0W1VyciuTYxEUt+Xj1/bniaY8MAz5gFgeSA1OsdAVKilgr6FX/AvRJODL58YBF4x7dOfgFIAJn8Dkf81gJp82t+0UOl24LCGnA4wB7vG332aqYUvSTRGhMRKW1M4tx5/vNJbWXpz4ohSsgWu+rN4ke2CLXKmZfFoKJqF2Sk9o3XMDe8ccw5LCx7hz545nTRecIY8l+MmsczIag2BjItcbtw4fNvZ0cxXrgSil6eSftvGsKEGHngFJpijjzMyhJmSndWytadmloPni2P/ngubDDom0M4iXJVV24fZyQo21iJyLoylFZKjDzEQ9kJEW4Tzva0e64OoL3KL7p+4G9rBLOwjLvrnnhbwGjeYm0miApRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(6486002)(316002)(83380400001)(478600001)(16526019)(6916009)(6666004)(66946007)(1076003)(66476007)(6506007)(6512007)(4744005)(5660300002)(52116002)(66556008)(36756003)(8676002)(186003)(4326008)(956004)(2616005)(26005)(8936002)(86362001)(69590400012)(2906002)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D+MqgD+B2429qYiVgu02YqCKtY4ZQ0aoAhaokahEONgUfWk65STIKo848WG6?=
 =?us-ascii?Q?IH0qv8mOPcubPNaAkP7q/LbB6JeThTCmb5hEzzGqZ9gSI4kTfQN8uxPOtQIV?=
 =?us-ascii?Q?G654ud4dsOPGcsDr1T22k7+cpEd3aCN5py0i8S7ufJT+tUbO/Kjp3H3QfarE?=
 =?us-ascii?Q?5I7hI8w2y7WsBaL2WPa5zAwSlxCKZ99pY+C+/1f6vOND238cQgBcMKdkoNZp?=
 =?us-ascii?Q?P1aRp5+1QGv1l6M/HxslZK/v4X4lWdkRntY9rwb2ujDkkrE3kNE0ksB+yUCS?=
 =?us-ascii?Q?yp4yBZVbJkYMgaUN/ISxo74gDY47TNGmh71AU4w2SmCIJkQm5bVZVamQ3bGP?=
 =?us-ascii?Q?ToTcNBZkA70ekoOh+3Yf2OF98ncXI/W2B+tkFaQYXx6sc2od55L3Pnk9ivdM?=
 =?us-ascii?Q?ojfj5PIU4r3VnOr/Sa2oBXb1PNyBmp6y025ZsxSyg8j9po589zGaFyF5CTcZ?=
 =?us-ascii?Q?VRl8v/bQEPoxAUlSwluPxFbWkEfYP1/c6UVokQikU2OC2D3np5HKJc9A1ufV?=
 =?us-ascii?Q?gjUAFlWHtFrJn4n5SvIx89r8r9HoV7h9gqQbL95WSUmzy5s8U6050uoLeufG?=
 =?us-ascii?Q?7DPLUaXOW/zsralis9ZKckPQ9pbvzpHstqHyKGtB1mMViUPZN8IzFHK+I1sX?=
 =?us-ascii?Q?//YyrL1V0d11YDffTsNhYYzXutHnCR7kFh7lb/uVjG6C84v5dMncJZyBhZfg?=
 =?us-ascii?Q?LalE2vnXwjFF/ucn0+v1p1CaF3nkFhlJkBvAlKwoVV4qClPo7qaEG7DNhu6+?=
 =?us-ascii?Q?dgovIjZAT+KEhiA0Hm0jUYBYBl4tyj6vp4fc4t6IPq2x0QthS8Vy5edbVwnH?=
 =?us-ascii?Q?HiIZ2ZbeFtzDjTr8S98Y5djlJYcVbVKefSXhxfnF45eaINpCjqB3St8l2lXS?=
 =?us-ascii?Q?cKtgPwWM2I6NArg5Gyy3n9QN6eH+szdBoWoEz/0+GbrIjyUFQLUc1lCrsgtu?=
 =?us-ascii?Q?wdIlt63CVfnmpeFwWWCRfipnjEfyx756nQDjf9FfTaKNiTs9lQwcHXT82GjM?=
 =?us-ascii?Q?dWm8I2LNb2/xANJQVj7GR/8Rg0Bf/tuoZi3O1WLOzfPFuKxCPmADRzlw7yW8?=
 =?us-ascii?Q?rjbSyfUazetC8Uy3mhIErdsBOr+uotFKZyOtTOavM/EVezqfwJeHS9Z+oRYk?=
 =?us-ascii?Q?buDvkAZQ0Ch5mnHWE2/hpzwJQpIMgTrF3IOulS90T2uGjL7xaSaLzqP+F9s+?=
 =?us-ascii?Q?dqQtVidj427dWtdcOc4mmjhgmotjgeAF0Zhh+MpWvPmODe9k9zej8d/vCbdo?=
 =?us-ascii?Q?Po1t/vqLstK9Nj31nc8Ml4512kTuJggJlq4tZroX+MS4sPOEldPlDqyL6JZL?=
 =?us-ascii?Q?d9WqM3VmAJhIzi8d/+0HX0tb?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20d4211-809f-464f-a1eb-08d8dfadd409
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:08:15.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 402sfui2iTi0fV7xZ5M00etq8p1cJsI+v16g19xKPBakSBu292MKXOkqQMkr/sFM2OEEP15Psr0Owlj5HURhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, err would be treated as io error. Therefore, it'd be
better to ensure memory allocation during rolling decompression
to avoid such io error.

In the long term, we might consider adding another !Uptodate case
for such case.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1cb1ffd10569..3d276a8aad86 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -73,7 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			victim = erofs_allocpage(pagepool, GFP_KERNEL);
+			victim = erofs_allocpage(pagepool,
+						 GFP_KERNEL | __GFP_NOFAIL);
 			if (!victim)
 				return -ENOMEM;
 			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
-- 
2.25.1

