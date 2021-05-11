Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB337A128
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEKHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:50:25 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:41683
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229935AbhEKHuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhKsdJqdFyAwWCm6drGJ4HC/LqZK5jizOaJvOLz+UurhpXczc3sVBmU3cPAhyPeHCpyX0i0lO8iuf+LSGHFTjtiOdMiHnz00imrRWZBbYfkktI4ACvfQFdkZMl1T3YHJxtTZpShuToCu5lGyPOJT7GSsDU2AtrOJ4FejB16pksWlQtGLxnlEnIDoagGrqmJSYVatI+V8Bbg9Wuor4Pq5KoVSkI1N8/cHAhIPbacWrLVZkKnqjSbWi/uSeq10f6BZslkAJ8HOgcZapHdESL5GGWgof7tZZACE86BskP6J+kongH/G5z0A3/wBfP8lB896QaKsH4fEu5Efj9L3omlogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fwgXfYDjwFNC4mZ3tXONWogCB2KQ08YrvSGVEzmArM=;
 b=E1HBhUs0U3RdGAmj5S94nxitHfBV9nNa5R620WdSqwz7xnNKw6I2HZCpOuXjEN8MNQefvRGr0SEpxmrPGiYibDgLnMy6bKswXDifF/u+1gPHcBK9d5cQzNYpawukV+RMYY/gVnNBT2fSbtAJ32+0jd9pZYT7Ia+cYKZq2XbheiOcmF3x8/PF0XqDackmEmjV2pxWhxTQWr6/e7V36WXHjZgHGgI+Qq68X8p2ws+TW5PbmCLylSXSwrlS1k4ddvUbRf4ueeOxPZHtnR29x7jkWMsGETh4NnH38cYhEFE1nW7g6/r/G+BgssRyA+lhH5/7la9p9cFdn7iMfKCD7TJjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fwgXfYDjwFNC4mZ3tXONWogCB2KQ08YrvSGVEzmArM=;
 b=GSpT4azzoRkhqbcO3Zi18/egPfP67QEt/m5fVnSkIpqiPgfGiqyO2Ix+raZOKtTJaquZaeC8szBv6qqg3gxGv4HyxPpkb2wnu7e2+NvgYcsRGaP3975aO7dEgohd0Ey1kBL+EB8dbnDYJL6DM5wiVuqHsvRCmY+1mjInknzFPvE=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN7PR03MB3841.namprd03.prod.outlook.com (2603:10b6:408:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 07:49:15 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 07:49:15 +0000
Date:   Tue, 11 May 2021 15:48:56 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zou_wei@huawei.com
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Remove arch_timer_rate1
Message-ID: <20210511154856.6afbcb65@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:332::23) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 07:49:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92950bb8-1f55-4dc8-5315-08d9145145d6
X-MS-TrafficTypeDiagnostic: BN7PR03MB3841:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3841D3C06116D8C8E860A72CED539@BN7PR03MB3841.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1RHyqzpVjTU4ffJGbRsrJda2o1qNgyXa5tugymShGtY5M8G4Ghukct3gzT2oVAAoO/z+KvHDgmyma0cmadc+EmW2t1rN6Ejdsh/DEIyTgHzAyLVT2aeOGjx8P0Z2GNncJQMkfWOr8HGkHeudx5FNwmsk+fWhbn3RkKAKFMb8Os7FjaIxlnq+pqzaG0LPREOyxUxhgymqbPd4EojwEy+nXVUUjZrvDPt0UI5CA8Qfg4byirvJpmRgRyAuXOYwYPPmazKtCGRLA0LleN9QWQDMDD2Aoq6F9hepoEKkOz+JZudg+WkPuBBKU8oLzE1Y3whYu7oTRLNiGSJGi4IAAiSEwT+VVn1eesMdoNiZttKEw9zH+3VP4/o08Zbt+xNBS1v6x8zGFVexXgJGlhI+8zAZF5gfTMPpaSwl1XLsqD+Ij3DV1kLoM9tVftKZGQB/h1acJzhkjeoU8hBf+4ud22xOa079boSc+0tpaCD+cN5ubdy2YSk/cvlArStdX5FZirZSzmJoT/0aZywTlD/AO/OLyM+36Z5zDMPcy3xDVMlNrgxRbG4RDhF6VzZRm/AMJRlEz25SCLjA99LQ1TqGxZWsjG9h7QpShxPDPUv2NXe1Js00JTFGnFgVENIMkg/DI2KY6fknyIqHslO2GYJX9DYKUVfCo8LpXib5et4fHEHV4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(376002)(366004)(396003)(136003)(8936002)(8676002)(110136005)(83380400001)(38350700002)(38100700002)(4744005)(478600001)(86362001)(1076003)(316002)(186003)(26005)(5660300002)(2906002)(956004)(55016002)(4326008)(16526019)(6666004)(6506007)(7696005)(52116002)(66476007)(66556008)(9686003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h9t8uMosFNPN8VBMlzGiJaxdHjc2oXm69F9L7la8BN4qxfmameL24qaQB2MK?=
 =?us-ascii?Q?5Mbba4HhTfCkoCTwZpxrqYrgAxgLpiZjdmV8uAgZPz+8u0cINIvr47jm9tIE?=
 =?us-ascii?Q?yk05Ll7aeVkxd24hk7IWNP2PhsaBDNLIhOtnEdfkBFs+9/9enl7EhQKPbqYp?=
 =?us-ascii?Q?uJXe0uR9FTTD8u51AcnSuzOQXshr7m6dX/N6fs2aATB0HOUWpGWEyVtkImTi?=
 =?us-ascii?Q?pG8W/M7oUxqTQmqQhY2vSTuUO2iJApVhnbfESSTK2NjwriojQ3iqnvGNso4P?=
 =?us-ascii?Q?3slnUCGTsD03T4RApi09d5vIxg0V/3jq4GDadO00Iqhzg+njVk/ISAO0rQWT?=
 =?us-ascii?Q?bDPCeothWiPeRAonpp5hIrSjPrIy6wv5DJyPvQ2nSGAUSn6sTtwuFzwS1T+0?=
 =?us-ascii?Q?HwN2g1EC5ZAmDhIkH0dzDexUXNJxuVsxOJBcd1UoNWIbnOSjbU0jbubf0B/p?=
 =?us-ascii?Q?1OLIQoORZQkyj124PwBFU1eULMnt2DX8RH4g0eMpS4EXcgs0pH8McjiZpeJI?=
 =?us-ascii?Q?dDADty6kpjD8xwu5eIlndm5AMUxlcusqVWdFFehdLjvPfw8BgOobDubVOcJZ?=
 =?us-ascii?Q?yl8PYjpUva8XRFFA5nflj7cHkF/kFgAWeFKWJeXqDEn5Paf/5j7AgnU60oEG?=
 =?us-ascii?Q?n75gCZ045TWmVghjRYW4rTCMlo6g2Ucat5DTsfPjkRIiYvVGI4jMJBjs/inx?=
 =?us-ascii?Q?i4kIM1dxZfotpKEvRQcKIuYB7qtvAdbvyZtQCTJFXJ7ptLwirT8hi69+e0hb?=
 =?us-ascii?Q?sIihixokfnVN4R6nZ1je5O3mdiRD88MQN8j5QrJFg62gUIcHXmVcOhP5j5sY?=
 =?us-ascii?Q?CU+YDzpuI32ENdQJhd0adiXnlkCdK3kgrr6fIwDi5RPcPG+CH2+deCcZj7af?=
 =?us-ascii?Q?OwtzTSdc0YdhehLhzfCKNAmP9x08xL9XYF9e3954dNIjqJd7iclDxDLAppMm?=
 =?us-ascii?Q?p8G+aDFCULcyx9TixzP5kfhLeGBtjyXIkCEDuhb5prspXMK9Tb+UwkeQG7gp?=
 =?us-ascii?Q?UvVX0Q+sYifRRSMBbmrlhWpaJ7PWNIxC4SQGAOfapMhbUymPU5hgsmsYNmOf?=
 =?us-ascii?Q?LIGYXVJjvMYwxVA2K5uB9j5NTR+N/b6mIHJsFRoQszMRNJQuYY9M7fyJIEfF?=
 =?us-ascii?Q?G6IJBLrP0MMnHLmeYK4Hlaf+RowL0EzjOyvA5WvsNKQHQ+34Y4yulfpTEAkK?=
 =?us-ascii?Q?ZTSDFyqp9kNZlA3EZkFhMKzSt5oc1yqhslKBIsF4cdpinAsPYdOcGBjZR0pd?=
 =?us-ascii?Q?dTDASNRHez6omzV6VWBchEednQxAotsf/Xjsh3Qbo+mcM6LlYLs/HSsZziL0?=
 =?us-ascii?Q?hz3BW2E5tW7ITynqO+1rHdih?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92950bb8-1f55-4dc8-5315-08d9145145d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 07:49:14.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCi34nTIOlCFJguXJNixOCIfvUd46MqHfoUqRiL5Su1ULtdTCpkq+llJpA/391O6XVLhKMMGCMxhmGZxsaOotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3841
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is added by my mistake, it's not used at all.

Fixes: e2bf384d4329 ("clocksource/drivers/arm_arch_timer: Add __ro_after_init and __init")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
---

 drivers/clocksource/arm_arch_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index fe1a82627d57..89a9e0524555 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -64,7 +64,6 @@ struct arch_timer {
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
 static u32 arch_timer_rate __ro_after_init;
-u32 arch_timer_rate1 __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static const char *arch_timer_ppi_names[ARCH_TIMER_MAX_TIMER_PPI] = {
-- 
2.31.0

