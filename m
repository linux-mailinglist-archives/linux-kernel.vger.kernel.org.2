Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3850F35389F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhDDPdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 11:33:36 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:64865
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229861AbhDDPda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 11:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQb/lcefNc+rq6/5Y2z9gyYG9eU/3GadWjZxIUUKY6gRftzOU9+kscp3354XEtdtRnudWoXvOo93aIhKnhHMuPAt8QfU2Fn5/Nqi7/1XWv6A5yhMUDdsKrh8fd7Sid0YG4oRNPk5RZPWpUpR8UupAsB0NObUh4FYZDVo8vneNTZjc+jgJrtH5DYkCSbSnittPq5ZxfI2JK91wmr8NKKSYWrNNiZKB56hJg5NIfE9lwYWI8nVDJX8oD6Z9AUcT6bOvNJKAkIINWb5Bu2TeNlM0MrNiKjQEauKqJQF9nGOnh9mAA9psh1OcjaUxJrBZOTcfptZr45ohWzECBREmJ52GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN+xSFkfvlNLrCRov6cVFmDsVsY1dzQZspqOVJDp8e4=;
 b=Iws4kjHvOX4cPg8cV/AINtBhcYWR9bwrb0vqV+0iWHO1eAf9Luu9EJSlcQL8jraVbhYvHsZSE7z7Z+5utPeVy42in3fzBv5soDMiG8lOMFLSiaB5tM64RjtK5ZDlv/Rz3oT+jruzJEpbKNAyazSP97QDKcyKUO4PX2lf2REuEK2/l5iDo6+hQk+fAzBIskCwFNT3WbXi+tqbdkMvdojEaIAJfaARJ05oDhkn1yp+KnwO2p4L4xcJY2sx/ok25YFEgkIcz34b8WbZRVd3hoLz01UVUoxgLCXeiaZrra3dFTKTrnyPaFNt0EPBUkgTDqbzwTPaXiSv1QmT7Qg8BZ3bQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN+xSFkfvlNLrCRov6cVFmDsVsY1dzQZspqOVJDp8e4=;
 b=RFs+K/pvw78EEsvB0NtxIqniHJhU7mKM2pf6EK0FpZIROTBtIXLNwE8sir7n2TGrs+q9AONozn2pm/Ae23DGK+sRmyepwPym/mQwrwUHyAwcHQydtn+FKYYzHAJWvl2jTVjxnl/1gNaNOwxEa9l7o5zCknRbcCnK5JXvfF/k9S0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4181.namprd11.prod.outlook.com (2603:10b6:a03:18c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Sun, 4 Apr
 2021 15:33:23 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.3999.032; Sun, 4 Apr 2021
 15:33:22 +0000
From:   yanfei.xu@windriver.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm: khugepaged: cleanup and a minor tuning in THP
Date:   Sun,  4 Apr 2021 23:33:09 +0800
Message-Id: <20210404153311.1460106-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:202:16::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0136.apcprd02.prod.outlook.com (2603:1096:202:16::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Sun, 4 Apr 2021 15:33:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84fa8da-1500-45ec-3bc2-08d8f77efb33
X-MS-TrafficTypeDiagnostic: BY5PR11MB4181:
X-Microsoft-Antispam-PRVS: <BY5PR11MB418160A772D9D38250C385A1E4789@BY5PR11MB4181.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHdfQ8FA3KRXnTS73Mvx7RH9UKHmxgr48aCgSq9CkCQ9x422h3STfs2STeqa7H32LYnw6ZnLULgWAs4owJl2YXaLiwVz/ZXUlCCYSVdcOcI4PrZ1n+dzl58QDX0Y7R+bClwtjq81WdsdP1KOheByI5VBzJ8tJrWGhOGpfbMJ76z8aiqKhaMtzStdMwCMTduJpIgt2FUc93hUE8soCtHPGr5r7FCJzhLQIMDQuHrKgp9ixbVPXO6Qz/XX2KMZ+NlWDMIx1kSEmHx4t/JXxbp9qbTKA/E0/N1gBaRwSF/D5zaTBdqxrjDM09A+zwdmAMg1SlqLgFX6bSy1tL1w5vUC/RgPkn+w8tYTrkwXvJ5aejj7NXEz6Vz4uTTX/jGw4TdH17KyGX6OyPa8JYj0gXx48L1MwGL+9ipITfFcYpyezWK/a3S+qLRRzomqdga/VFHr9d8XYaF1FMRqlkJRY7Ed9dm9EVFltOwOH3di7gixmP7Zh6DQrZ/Uma7TZiByxhHc1PzajaJTG1gpLI9HK0O+BdHwCdp2LLh7j9CufZ2RPIbP/RVwiEg2J3orCokQRoQ4TwHSvE8rAfmBEmgoIfnjvyA9emA/jr1M93xg4Ex9jb7BCsBDAAGFzsJb5Mgd9a2KNbeIsyDI2hk+2HbpeIROXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39830400003)(346002)(558084003)(186003)(16526019)(6486002)(8936002)(1076003)(36756003)(6506007)(86362001)(83380400001)(8676002)(956004)(6666004)(5660300002)(52116002)(38100700001)(9686003)(6512007)(2616005)(66556008)(66476007)(66946007)(2906002)(478600001)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?waVSy1pLvbjRXM0dnZo0b8EedDksP53tVN+Qsk8XK4+Lvio1IWhOFHj4o3pN?=
 =?us-ascii?Q?dHTBp8O8/tMZooMfWHqqmEpWPFUs8hWCyRTqDfYGAgowLo07HwkdYhaTu3xe?=
 =?us-ascii?Q?Y1JoO8L1zO4WyaKOMrUGnqhudZCZYa9LR0F1ZMHrO7I/6VH2Hn3ZMo/oRGrX?=
 =?us-ascii?Q?t5ddssawcU1RizEVdVXWC2BOAfi4G4Rr63bCgHWrtm+dji5ZwRS0nyqBEYGp?=
 =?us-ascii?Q?NYkDYmbr19F2G7hguu+snycupHhbRSBfLQBf8jH8Z6ZOPDth7KSVMxgE00QX?=
 =?us-ascii?Q?X71uvqiKWxiYzoem1y7gHpx5j8jpwHtaH6XSesIdV1ftLAg1wjFW8bAaLsw1?=
 =?us-ascii?Q?LBc9Ovmn7pUx2GPqQgEzboSEMEqEYRlvhst1/+xuJ5D6XFHI7jSEAJwMI7Vr?=
 =?us-ascii?Q?UiMb7nbd3a0U3BDw/0nj52QXwNU0CmUgN0bv10YKDs6Ub3sDVFgzkvkZ7au2?=
 =?us-ascii?Q?87RG/BcZS3bUDekM9VBz6+YG6U3L0CPSSGk9GNde/pIYVI5yXJl3Jjdl2G7g?=
 =?us-ascii?Q?k3tFdH9iHq8eDhwlZwa3yWza88JKyKOTAXc2uZePyZxEBGDLQ0ttZ7CYNH0A?=
 =?us-ascii?Q?td3YMEEqN4HXGrUL7XiUFQSqw+/AeD91Hh2nqyAvUqbkbE4A9XTxxLoLwH/I?=
 =?us-ascii?Q?irjYUuADuuCaj3MHCBbRhnbLm2y3sYjBJqggk0Z/ntkJret8R6XvAuAwOH7b?=
 =?us-ascii?Q?Z2a4okisD8a2yfaOHvXYUEXl5tyUmkW37fLbVRkM4Fc73RLbMoAMOhzv4DCX?=
 =?us-ascii?Q?koj9Auk5JZBF9Z1GrGaSr3bExFg9LZ3iw9yf69xccHciA7ehCVOLnIR5FwhP?=
 =?us-ascii?Q?t9SlPT+6HDUGD1C/WQJjj452Q4c27lEK0hBGfRiW7BCsO573SwjlpzaorH+2?=
 =?us-ascii?Q?P7aejANxBgWvku5tKc93gny078ACE0OgLS4l9jtbtsM2sWPDBIWROEgleQd/?=
 =?us-ascii?Q?yUm3mBIPQHy5ElezZQMOxYotSKrkAFK1QdKKxaiOkRx/YzDpTjhWBYxHYlrF?=
 =?us-ascii?Q?4Nr1rjisMs/7I+29c/qHIbUq+RyWIz7XCny59jBwUyg1OASRED2x7m+5buQq?=
 =?us-ascii?Q?LV8iXugPFr+bYwamrkanXHCIZwbyBx9m0iy06dIcqw3Eh+UJ9W9b/JqGbJrV?=
 =?us-ascii?Q?LFuJmrcwQGYH2zt/BFiw4rShRwg/XBZtCAszp1mOexY+eTkgBP4QsLrbyFEH?=
 =?us-ascii?Q?MQjaSx8jvgETMT8lgWn48fwGBVQKOi7sOGDrJay+z0JekoUbawYU8pRhpZer?=
 =?us-ascii?Q?apIfnbUd0j7e6nl+oJNSJTYnZ1pfUUqqD/zZx9E7YQYYoxYc7cr0Dq7KdYuE?=
 =?us-ascii?Q?zwBMQGolSC+vP/llK2LRB7ax?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84fa8da-1500-45ec-3bc2-08d8f77efb33
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 15:33:22.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbFjQCwwlrUci7m0S0Nif9I3oWwnkpTtKCYD27+ZTLLD34ayKYBqi7i7a958O7ev2Him/RmJRWq20P/34La6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>



Yanfei Xu (2):
  mm: khugepaged: use macro to align addresses
  mm: khugepaged: check MMF_DISABLE_THP ahead of iterating over vmas

 mm/khugepaged.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

-- 
2.27.0

