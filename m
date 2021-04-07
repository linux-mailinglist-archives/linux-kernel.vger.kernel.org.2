Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E963561BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 05:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbhDGDGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 23:06:24 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:21720
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348243AbhDGDGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLDQwyj+kgHZMEwpZ9pD8j+MekRXvEi5vOUCgCIV3d8bD//MpnT6VuIDcC4z1V/d03D53Ibxq7Gpqpaa9PxVQ5jtrShMkV7ntJBl6TTzihs6YxM9fcPf4YWXCQHfJr4djo41PYMhH04hLAqk6CNPwNnyOgnaivzZmTRRFbYXl5dproaTRplpzxPmVRf3AACSTvmbvf5LpQoS5IEYxAxpQTpqvvZx91Uro+Q8MsZRXUkw2v2D2LDRCRE8bADe2FTPx1e/wvCOYwOaH0Ta5TCTf015j31xBCbvSxOA0Pn3ZSRMYNhRMY1tgRBUI8k2+KoRSCNDYj7ESjWv35Llq08CSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PxYS/FOxV9IHr5Qx1bG4OJDt+34SM/KiBs+qc7GLJE=;
 b=IaP8zBfoipSyjhFAfKl17QiVIcFDbJrEDIMLyVbio5osTmX3UZiwJnNAKIn2pPGhvVMjLzL8FGuXuI+w34jjCvE6IKD160cX7Q5VH3afrCvWygLB9MhEu6Wzs+4qCli6ldeSFPXvciJc0PZPvLo+/DnxZ+jE7GisshiGM8tM+Ly8K99i/Cbb6Cb/rFnCnK30xhAZprvqikpsltH0mBOocivnvJqezZF7BND9lKczK2V7JFIPQAGu2fkSXGoTwj/13ks335Jtgf/QQcjPsMTWA/1DP8IDX7958TqC2/kyVMk07GYfEZHnNokof2SrNlwYH2NYIyUF/RnF9CpluWotsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PxYS/FOxV9IHr5Qx1bG4OJDt+34SM/KiBs+qc7GLJE=;
 b=I3hvMXYdUXJzvg5P2jf7VTOdPuKQouXUQxNUBQcA1lMqzkPN6+x5mHTKJT4ElJq9++cS1+RYFn5OUUb52X09pvgVvsjmdjG9Jwk6O4TWprFbWF1IiGMaF8Hl4rE2Ldfi6aFwxfvYJaabTCLn1jgG7+NWByTeU7raWxxtMe/MU2E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Wed, 7 Apr
 2021 03:06:08 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 03:06:08 +0000
From:   yanfei.xu@windriver.com
To:     shy828301@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: khugepaged: check MMF_DISABLE_THP ahead of iterating over vmas
Date:   Wed,  7 Apr 2021 11:05:48 +0800
Message-Id: <20210407030548.189104-3-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210407030548.189104-1-yanfei.xu@windriver.com>
References: <20210407030548.189104-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 7 Apr 2021 03:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b550e14-64c7-4ad9-ca96-08d8f97216e5
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4864:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB4864FF37230DE6553F8D5C50E4759@SJ0PR11MB4864.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWmiQuzEMIv/aRZOeen4969lp/b5wLYA0lYpLSzuzSARGz+1pE02MHR75msgmJ3XD25XwBgCzeaCW6PxXdB/WUwlwllq2dQUDD34KL2zlKIAITBnJrSE938TmhfwcoMmvG0/QpexdGyelMxWAyD6j/gu+NLzhHyP43TtpfPNGYYydpnyZsNezcE5TBOFsrRmB2PjfLgpJgVTWdcuvnIei6HahB8sH/rf7F69R1L7nztcsOuuKVU2osMPpvcsjqkisArnFd0KXsPc4X4BQvRmBLXyXvmtEcoRiggUGRgIj52jnOlSwnBtcE6SgZ0iQghMV/O68VsBdHkgZNgFU+4ZyvcRxKgumMJdvJbj8aI9Mf5haBCyGqgJbkM5ELW31mRnx66pgSnUF9ouQpcta2chs5hsXRfinoY83T/OvZGuZsxnOH3BEBIm3j+OH1UADkIMsdhWbeUxlQ0cL0oYzXJDUYYYFfc79PRPoOkcxok0hPVvd6ls+AsCAq3G0GtyjBXQDErHZ7QvmHEsD6Z2cKm+nljmfHldZ3Aci62Zer9KP3S3PSqMQT3QLsxvbVGRbkiZ4LzJKiKWuArpiIgaNpE+csX5fmf1inUKrF6SxLXMeq44MoPyfLoT5KHL/zWvKRQpMzxvHN/KFVN2TATQL0U/zrGQIyebrsGj07xlEGtp2weRRKV6j6XCu2kw87xe+2aP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39850400004)(136003)(396003)(4326008)(26005)(6916009)(52116002)(38350700001)(66476007)(38100700001)(83380400001)(2616005)(8936002)(316002)(9686003)(6506007)(16526019)(86362001)(66946007)(6512007)(5660300002)(36756003)(6666004)(2906002)(478600001)(6486002)(1076003)(956004)(8676002)(66556008)(186003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?231G/Gypk3dILe2Ktudwlp1hDzCEquZS9a9u0Hg5v9Q5iJxZmCwLnlzZoE1E?=
 =?us-ascii?Q?nk8vXl7fN+Pu+iXAJliUZ7dTw/ko/m5HdNLxdOGsxBMVMCu1+MI6p7+sPJGS?=
 =?us-ascii?Q?XUOdxMBJMMVlEYq/NE9NibMPeqb2yNHYScXy3x600wtsJm1gFUGyxxJCs2V0?=
 =?us-ascii?Q?aA2gDt0Bo+MirL5c+DDCtotNIDPAsE6zL4FGc6++6xzPII4aO14DR27WxPYv?=
 =?us-ascii?Q?oe3dHIKCtkCMDRWDGwnGFe+3o6nnZPa011cFpeeEbHeVdXjHehShI6FS02FV?=
 =?us-ascii?Q?azksMNL5Y3R2A5+6Ea9z8SdRABT8wNx+a2aJOva0CbiCijGkb3ey1kvELTiU?=
 =?us-ascii?Q?OznwYUjVld+ROzlPnceXr3in0mSsPmpTw8wvzEb2nUqkODY4uimwmiVjDuv1?=
 =?us-ascii?Q?MdvP2S0Y37oVb8yNOTFmjTPfGRT3qVfUxDdNkeyAQjyIqnMcTVERNri8AmwD?=
 =?us-ascii?Q?hPrQXFtSr/jRAeoB5oG//xNXFSFS+eQKrgrRs6tmNaW1HojZRX1J482Q5LAZ?=
 =?us-ascii?Q?U9s1TSgN2KWZmtA6q/vHAPzZz8j6GuEwLwyZe4x4F2F7OrXBc/6STbTvudLv?=
 =?us-ascii?Q?aOaYGruLdoSR1UaeAHIs6dDS+5Y7LmjXm6/7fWS8sjYFVaiEkZcJIpTDdd8M?=
 =?us-ascii?Q?t5PmORAsvPTo5/v2IABQke4haJ2315LT8hUNr7/w9oDsdSMQOS82UxHiGHhn?=
 =?us-ascii?Q?YUDW9SOuTS3Ui1Cm0OKBHMzBxQaYN7APxeceWemlfNn06dw7mzxuY9hHr3NI?=
 =?us-ascii?Q?XrAZRtNwwBOAZ+CyaklHaMZrGRwzma7R3NahKT8o+e8wNeuH1zFTKX9pW6/H?=
 =?us-ascii?Q?b2M/ZknKivDK7pTy74E5ntfPuAKZy/P/Xws185hZKHrHgog1Ta+8xqApqJzu?=
 =?us-ascii?Q?N7pGSoE0hDIz6rk6eiXbDhLexbYWyf54r2M0eDTpdIcHmOXHrZZ4jDdy0Tuf?=
 =?us-ascii?Q?urhfoCfzYLOu+QQ6k0/Y0uKXmoxU8OVXvhTHBC/HSAc/3GVpxavnOEGytQ00?=
 =?us-ascii?Q?YLWKtD58pbhGAk3M7nXCyZpJt6updIBBUj1BiHK55EWDzOi1shAXZQvPkGYJ?=
 =?us-ascii?Q?rJ7xfMVYBvo5wfN+oZrYqZPYD/0VeRFsnY3tgw3GQz6kliel7YAnziy7RBho?=
 =?us-ascii?Q?W6Bf9g9Pw1iX16e/1J7yDC0VJdRnboLlqAnzPy6iDhKSExhslfuK/H74HnKP?=
 =?us-ascii?Q?Yl/06RxRZ6AO3ESIcxNP1UFxQr+HUcV1IW0bRy8XpwtuPtmfVVbeAerszt0i?=
 =?us-ascii?Q?S9d/lm7hat4r6dzZYqMMbGtq/zZnrcgR1ztm3O4077/q2MIvraMxukg1K2CS?=
 =?us-ascii?Q?NSgAKJH8s5GIgxxqNNJAJbfL?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b550e14-64c7-4ad9-ca96-08d8f97216e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 03:06:08.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1koOiV3sbaqJn251g30YrwiFYbSQ5sKZ4XbqfbtIfiUb1UJSVT4+yU31qUi+wFFzC0pUKAgdAGts4+/nOIIK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

We could check MMF_DISABLE_THP ahead of iterating over all of vma.
Otherwise if some mm_struct contain a large number of vma, there will
be amounts meaningless cpu cycles cost.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a6012b9259a2..f4ad25a7db55 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2094,6 +2094,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 	 */
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
+	if (test_bit(MMF_DISABLE_THP, &mm->flags))
+		goto breakouterloop;
 	if (likely(!khugepaged_test_exit(mm)))
 		vma = find_vma(mm, khugepaged_scan.address);
 
-- 
2.27.0

