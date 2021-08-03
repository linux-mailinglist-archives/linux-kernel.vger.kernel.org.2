Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFFE3DE8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhHCItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:49:22 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:46816
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234453AbhHCItV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTaR7xVFk0iPD1HXEMHw963SuHuvvjRBRLen5JenR6PlN0EAJc7wYQjc0kWN3WQq5/Dasm6xdgYg6aqiT4BbmCdtz2nQpMhmyygB70B1ug00zvD96+TvBCW206sVKNPzT6+68bxnXdThfQjKM0DIq/YB17gG/9Gh8WJcgMUDeTsaeFXzYlC/NYJ+nq7h/4RBnxl6zdPeLxgHQgorom1aASV9unuJ8YxaPiZ7YruOUg8xtyXgqcwOVmGJEyZtycgaI6nE2QinMEFp3mZ4kWbDwkw90QtDquGMEE8St9v3aatmjDC1SN9ZGMUI/JCnWkM9niOkB0fv0fepRoCH330ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw9As1pVhFEH4N2f+7EK1Tt1kfDGkCb/nth9qS+zFH8=;
 b=goYnPSYMugsRSW08lACFw06htDU4sfAfmezsqJ2Heet5ktvw4P6Zr6eq1o9sRqQahzVnDiYWhwyWNTyse8HhsDX32/DS0ab83rYO7s5KWpP2sYiVNwB6ZZBSUzWJ5b5AAspTwV2yI7SKqHc4LOITE1fWYCKCGRt0pVoAe+psjaA37mUwUDnptaBjhX6L+sFXN9g7MT+mkzncZfmwXWkyc/roZTd3uVJI5Cxai/jk9Jv7PsIjuBZovn37GCPzeyze07Cyea4TSeFrYpdSUOTB4jBXcE8YSSew6XcQHgakNF5f3XVYZ0p9Ot1IQc7wgisL8S9bSR3PJosPKakRGFvfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bw9As1pVhFEH4N2f+7EK1Tt1kfDGkCb/nth9qS+zFH8=;
 b=ZL/oO7+aGHPBWBPghQBP6pX5r/HT/wK2nIdg5mXb8PWrZsVPHe+MPkGK1LHe0vQzjey6qS8X/pdT5Ry1muws339JX9+x9c0z4ZlANuzaqW5zUtfUG66tnuzjzUZSkAmOeBaAmXyMa5hsyMH9797xuJrhTQScI+3yzQQVEAzALSM=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN3PR03MB2194.namprd03.prod.outlook.com (2a01:111:e400:7bba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Tue, 3 Aug
 2021 08:49:10 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::5ced:deaa:371e:f124%9]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 08:49:09 +0000
Date:   Tue, 3 Aug 2021 16:48:56 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/process: directly use try_get_task_stack() return value
 in get_wchan
Message-ID: <20210803164856.51078ea3@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0096.namprd11.prod.outlook.com (2603:10b6:a03:f4::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 08:49:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba9a57b-28d3-4e4d-2dc0-08d9565b8f5d
X-MS-TrafficTypeDiagnostic: BN3PR03MB2194:
X-Microsoft-Antispam-PRVS: <BN3PR03MB21941B8B3A105C7A3A63E86CEDF09@BN3PR03MB2194.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiaxMHG6gEkU/scT/rY2sUzHuCBuoRSpKT3lvww8fXRbx5NClNO/toHXixiv73DRcvn7xf1DXc+Kf75o4wF3eiR39H0F0q6xKEjLL3imqLSTUTCAvD2nEoFXq2iSLadJjN51LExsi7mmwY7RtecrkdbeX4yZrWOAxuOpuxFvcO7uLRphaiXOZ/oIYK0tcL5RR1r+ViKkXSDJJXn02o3yhNlVlCCENrrEmv/1v7Y4vDQqJbPRNOMDMYRrmNTrxPRr1PFNf/D1cy3coG/zeZh/oRvz5GY2LVBi563IbPsxgku0pva8qQo6J/n1QT6SXAyRtz73e8F8+ZCg7RYbSFpUBOuCN+gBEyZDX1AO4Eahpv4wuKO05hruDz7fFXa/3Z/OLtfBjLAHh0Da1P7O36tAk6hi/p8RH4dAktvgFwK7c90beeyhVxao0lpzk0/6uEj2uB8jkjKpZOFMlHxjNgFmcqH+73l6u2xRuESqMr1zlwBYb+fQvFqdpPMGuCMfFwd91doNYdyw3+gMInAzKJlAnguk7e1WpSG2g6S5Zg7+RXpWkjaRSZGcELPQnEafAFYy/2UPeObVjSIlepYaczQxKT2H2QmvPeLwOv52mZwZJJFXGvkGqejjyWMTv8Ccemz7JQ5k2o5mHrxEkPMFFPkvm0w5lOU2SkFzPwb+t+6FPkZl8Ig1sfqoc48nlDp4vz+PbRvpGym5rTYtKApviLhDdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39850400004)(2906002)(83380400001)(316002)(5660300002)(66556008)(8936002)(55016002)(6666004)(9686003)(66946007)(66476007)(186003)(110136005)(8676002)(478600001)(86362001)(4326008)(4744005)(52116002)(7696005)(26005)(6506007)(956004)(38350700002)(38100700002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BEBwBfS2fBwtsRh/LHOaOz3YnlNePK3vsAqgz2F8XUjyC7VUfiiuDtjV611C?=
 =?us-ascii?Q?k47BNhRb4VXwhslmn1aCIx9TKJIZwSZOORfgVTdXCikhrwsXyXp2vbBSKc8B?=
 =?us-ascii?Q?2M7fRIMtKPZZTFchrvo6up92V75fdl2VH946dFs1F4qhd4NOg47wB8Mbsy+o?=
 =?us-ascii?Q?5Om7ti5qPsUas59eIrJLcczab3KsRZJCox1zOgsXb+PL6VFqLesGC7ABPul8?=
 =?us-ascii?Q?2bIOfckNOSn50XC9LrIYiq/pD7/WjK8/StEtTnaq3YXKaFhoF7TGthx59fuA?=
 =?us-ascii?Q?TGPZAnRrOXRjXo2IihAvKJplQQZyqrkJF91mpFABlbWP6T7iidNHOrSH8nwt?=
 =?us-ascii?Q?a9y7DHSMF0AzG1357Eb46j8/NxZAdtQ2+mto1HqPsHzrZbP4B4pQxZoKgwar?=
 =?us-ascii?Q?vnDTTnLvcbOElCJi6v8yIkXWQQB3hqsgj8VR9oIie3SOltOZg7lSWxGVYIBH?=
 =?us-ascii?Q?NMrZCfxB79646+zQ9J7NegezA+G6CIthA2WLNvOvkcBs7P/o0oHm/m4uuIbD?=
 =?us-ascii?Q?KbqrVKJ6Db31BFDoQ7gwTic0YGRkWNa/gdhz+jUOt+L5gbIKZjxtN4hhH3ap?=
 =?us-ascii?Q?dsHXIfnUOGgzie8T6qCuT8nQX861BB+SDH2IPTRmTlLzm6tXKZEIxtGlnkPR?=
 =?us-ascii?Q?wJEeZbhMUgaK24XdZuCvFbm/bHvitue58fb66GtxSzKKbPgnlbEwRaHNf5U0?=
 =?us-ascii?Q?B6UDvRlOxZz8d+GCfeFv0ZUYc3/aN1xYRzd/dI2ZmoE/C9/Ez5TuDekY7tTZ?=
 =?us-ascii?Q?NRN0tnPD9o0QGwESePOEvFVU9DLeiZsIfQ8HCU/AGAd6m+X8KcK0hEZXoeuh?=
 =?us-ascii?Q?eyCXmSyEesBUPfLj/YOJ96Ml3/Y/iH886QqFj3d0/Yv5qSoF/AExmOLKu22V?=
 =?us-ascii?Q?bxaINdwOh1V1jtAyp1FXcHbdVUL36DOZ0Ht1H+wkZjlxhHQDUQGv7ZfaLhua?=
 =?us-ascii?Q?I0ykVcqtBhYOmjbqNNQPU15Rdbhfa7D9nCq7plIMhdHUvAxKmh7XnwwPVgvS?=
 =?us-ascii?Q?7/CV9pjBUalof9LBBzzxia1NosLGTZKfWW0vvYmiyUvMTfanf25kh55iC+15?=
 =?us-ascii?Q?yZzbpldFkoMwFpTUr9UCmuJj3PyuYRUCMDSGrJNv7a/ch1DbLlYH4f1wvnhd?=
 =?us-ascii?Q?n8L6FEFPOzgDIQYm82Z7e46JohXelVCXMhQpxqlQJZ33TMlXMEfsTCzUZeJB?=
 =?us-ascii?Q?nALmzj/thYQXkjDM1SYIn2Eiwrye8iQR11dej609xu7ny41TX3TeD4Z7yQ8j?=
 =?us-ascii?Q?qqMja1plBoESKKnSc6QQcdZQecBYXjGHGngEIH7pjLHUCgk7Cidw2ZATXqIX?=
 =?us-ascii?Q?pGwVFbSQZ4hgyoPmxL89hzo2?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba9a57b-28d3-4e4d-2dc0-08d9565b8f5d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 08:49:09.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgHJtgoAUQlSaM/GnNHkYQWVy/zrYwL8x4ZsxBHYLI+lZE7GnOF4H+AdrQIkaSUzXJaghBz6HmGIPwdxzBsknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

try_get_task_stack() has already properly gets target task's stack,
no need to call task_stack_page() again.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/kernel/process.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..d4a6503b3878 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -950,12 +950,9 @@ unsigned long get_wchan(struct task_struct *p)
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
+	start = (unsigned long)try_get_task_stack(p);
 	if (!start)
-		goto out;
+		return 0;
 
 	/*
 	 * Layout of the stack page:
-- 
2.32.0

