Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D68382AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhEQLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:23:04 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:63303
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236528AbhEQLXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuOq3uKfeGo9Uahk3Grmh1sDGLOPkRlnkGq2bPIVDs/qQZn6WTO2uQrrH2nkc36hYJbUXM/MYQ8yERVn571/0hiwzGNJLynPjkSg1gJTyS7Gz8Ak9qEkbB6jGoqE+zxyzAXd3FzlfZk9snPp8QoSKFWD8+S7X6SJTSzsL8v5c6LiT7GxkSjuB42Bz6pGpVr9Ye4VNyxw5bRlY8NsGHVh4VbcHbo7R/laTUeYcnZneOobiG+i4FXorf6M+ht35Q9uX20twecj6VCAXCJv1OBflo5S80ScPTTG2ZwBXHQk+wTGJl6CgsNLeGfBzSdlV2wHaTnYJPkLntstLSgKwQpXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jKuDsAKR5yUS1fuKzT77vuvQ5Ck5OJRl3FZJW5IsZc=;
 b=WM4pxvaMPP/NhID9PE8LX6TzRIoonY03vaoduCXHNj45iXXkrjzp7kHycG81deOzzcsmsp/5lZ1ALFCAgCHxLJKSn2PX1BpTCxPUqxmP2q3FKSSsuOPlafjCRoI7R2yDQ1oeE4uAt+xE2YMEQALuuD2D69m+Qwo8TMc1z3d6RLanOXi4rcv5//PLtfUbfwxFHOieNeWqwHVVU4TOd0rBMedS2E+BqkhBJ3F8iysoWL7TWiDzmN6Fb+VIZAASPVyGO3ZwU+8a4xQYg7q5zdGefS7zBRP6RBlgC9lH5Zpecu6JhAGxqTo4qujpZGft5SkWeKSPf3gPWDFcy702x/vrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jKuDsAKR5yUS1fuKzT77vuvQ5Ck5OJRl3FZJW5IsZc=;
 b=CAmpEw6940DvN5OxbCY3ZXnF4ptsORWbXDrLiWNc0yaG/HyMWXnugr8HYGYGjtCBylGCzft31IEIxH+Sc0G2h0REUed3E7eH8EAK4qNhqSZ/wKPzF8aeuRKo0/NwXaMe2rM7p/lCbtWLyQb4tji7Mcv1y7e8wGaqUfa2cHOx+bM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6776.eurprd04.prod.outlook.com (2603:10a6:20b:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 11:21:44 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::b10a:ad0:a6f5:db9b%2]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 11:21:44 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 0/5] mm/sparse: a few minor fixes and improvements
Date:   Mon, 17 May 2021 19:20:39 +0800
Message-Id: <20210517112044.233138-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To AM6PR04MB4966.eurprd04.prod.outlook.com
 (2603:10a6:20b:2::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0132.apcprd01.prod.exchangelabs.com (2603:1096:4:40::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 11:21:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fddb4f42-74e1-4500-2760-08d91925f35c
X-MS-TrafficTypeDiagnostic: AM7PR04MB6776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6776B006A0917B2809634135802D9@AM7PR04MB6776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2WKY2oqtFFm84atS478lPcpXG0AwtwlU3sZvPEPJuW0heq242opCjnvKs4E+WTmnrmgGW2Lj2jp48laELe0U/U3pVngPCJ6/Imr02GVD2ycA9vcjlkYdeDnM6m+fsIu4xt1UfoNcUIDcWFMAqC5Y5075a7lqxtMO8KmMF+d1eRbR7BFOGm4Ots3c7Zd1ED+oLha2Aa1xhUWYTA21Pdon/b5a9/xCq3ihG51MxrqXZySJcm16SvzkbCrLE88nJk8ZQ2EIxan3utQRlW9JWhQraT86EYtMkotUaw5zJUd+ts2evGbf4mkLxC6bsNjkAbl3lCvDM+8UBUkOHDNYiQ0nGFunbcSbnxlFJ6yKEplkFITSuAWpGE+jZK1yGXGsghwYkky51krI0xGcNYmiwOAl66GVqfK/VA8H+pLNgNl5dXEKmJ13UrVXwBGLCAAgouOkjAe4XY/ajjCkYM6m4JyEaBl9T+HgUAMup1Vzn+wz7PZT99KbWIilTY36vheodt6P6ljMWusmZ6p4mLMo7KWCd8hNebEtxjZXp4YbZmXdutbs3Y09SRJN4A3A3b0vBWPuMu5EUzrTZUZxni3q5dCCbP+6hwtD5RjVGWdcwtTxBpgK/uPCAixVTkjCiciQekHFjT/y9IlcaLSE2W9QyVeOoEOD9++SrtKMw4DSXN4VAKhcHwIDqSSM17fKjfxAvesM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(6486002)(52116002)(16526019)(66556008)(66476007)(2616005)(956004)(36756003)(8676002)(2906002)(5660300002)(186003)(6916009)(478600001)(8936002)(4326008)(26005)(1076003)(6506007)(83380400001)(38100700002)(38350700002)(66946007)(6512007)(4744005)(6666004)(316002)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1pP1Dg5Ubas0PDoA8xPX+mOCeJ9pNci08YwdgmOKXjVuldH4ABXa9CucM0vJ?=
 =?us-ascii?Q?O14P9xjRmy/tcSMf8UDTA86qOGSpkGFcA0mJd+CjzzCZ24ME526BxVnADRQZ?=
 =?us-ascii?Q?og6nBOn/og+HjgTZPfqzmUnRyKktqPDox4R0RJefKixgbtFnEAPoDqfmPwav?=
 =?us-ascii?Q?6bE9JPY0Wa5ClKfCSrRqkh/d77nXTZfFTKOTBAgdUydXMHI6c5C5KIYoXR0j?=
 =?us-ascii?Q?PHKXwoTbEYhWmEkn+FUu2SLjEA3m3xcQQXoEhbTk8ZJzT3voVdAnlaqnuTHD?=
 =?us-ascii?Q?uhDCmsKRmKDuf0EvMwgmilPZNRGNDMaiuA38EU88VNXyZJGu4zByh1AdQnWr?=
 =?us-ascii?Q?pYeYz97Yt3mRsn9ZvMCPWo5ISJ7kjePiKbqQI/OSCEwJxLx2ln0KAEr55xSs?=
 =?us-ascii?Q?azJSoXuYwsy9/GHqFY2pbTiHyEU/1/rfnnEbSfBKu+9PdzIrayKGFHibrwQf?=
 =?us-ascii?Q?cPhxqZja8LEc6sXzcacezGx7DA6bZEuglVIAjhXhaXylmLEd7KLBSIDtKd+d?=
 =?us-ascii?Q?aUUBCHxveFNziyzc9zF32IAKTP5iFqjfJiw6eRNuaLkx7sm97opg8B7UAHce?=
 =?us-ascii?Q?6EWP99AonAJN6Ds0DZ9zyCNZO7BLLBbw45wEyUbHmfmKHSMlEN2k0EbYiW/K?=
 =?us-ascii?Q?lCp3EHXcmhZ0eXpNyUSmi864k2b9bjDDNQM7zfW8qp5NoVXTJoZSyp+cHAiP?=
 =?us-ascii?Q?koWcLv3oCL/zLCrofXBQ12fS4YupAfwQnxQieSTcaiyJDScP6RFxgNBET9IS?=
 =?us-ascii?Q?RWjcMW3llYeDjYDAUai+KKkvtU+JWrSb4PKblnfnLF6exa7VPsFsz+289opp?=
 =?us-ascii?Q?ZZqyQl6NYpeYMo6lszNl68qJOu7ZqHejJ/DGw4Y4joVwbqUjNw3fM0YBfZfK?=
 =?us-ascii?Q?LLS/33P9wkFbP0jnJHKrR3YrMumNKKBbm48tNXnwlqhIeGjBg8T32mHjxiYl?=
 =?us-ascii?Q?JE2P4/mUoPnprrPWUpmEi/4OTItbUj9SqAYGnsJOMXdBNGlx3zRSOjCDxuy6?=
 =?us-ascii?Q?nh+tc9KRkP1w7VvdDEPI4FZOHPQuQapm/7azD+xSxJovVjs7MaXlb0dSDZUg?=
 =?us-ascii?Q?qHCw6Ewoqh2ZdeHVm5EpNtrXfb/KYwL2u2R0T7IEkt/kRYrtWQrtbmST2MtM?=
 =?us-ascii?Q?QUnDF3V6Ggr1ur+uWvT7dYcvaObAfqRnTJQhqg3tcT1oD6sA6SpeazwspTbX?=
 =?us-ascii?Q?fHgUX3EmRbE/QtLKEbyVspAqYRwKbVpdGX4Tbu4sNj8LVmQeIPoZ/KsndAoD?=
 =?us-ascii?Q?Qlrdo/hReO3xrTjjJXhYStKaX7fojfRoRkivZv4ORml+W4yt7fzCTbYOm2SB?=
 =?us-ascii?Q?iPUAf0OAQ8Jih4v6xd4n8rrC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddb4f42-74e1-4500-2760-08d91925f35c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 11:21:44.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txvvntlBzdj3psrVAEFnl8RqlOVK7JRc/4bQzAaPQuYDNjaXmaGRtrXdfrxjXG44+mrL4V4avSx+z7nfOPFW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6776
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a few minor fixes and improvements

Dong Aisheng (5):
  mm: correct SECTION_SHIFT name in code comments
  mm/sparse: free section usage memory in case populate_section_memmap
    failed
  mm/sparse: move mem_sections allocation out of memory_present()
  mm: rename the global section array to mem_sections
  mm/page_alloc: improve memmap_pages and dma_reserve dbg msg

 include/linux/mmzone.h            | 12 +++++-----
 include/linux/page-flags-layout.h |  3 +++
 kernel/crash_core.c               |  4 ++--
 mm/page_alloc.c                   |  5 +++--
 mm/sparse.c                       | 37 +++++++++++++++----------------
 5 files changed, 31 insertions(+), 30 deletions(-)

-- 
2.25.1

