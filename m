Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10B3FB082
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhH3Er2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:47:28 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:48770 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhH3Er0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630298792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+NtNGE9SY7uv0V0fXCFFEmdeMPWcTOXCgMJg3R5pQX8=;
        b=Pd/Q2SpKQWu+mgzDgYt1R5pW+/OWW8nYRlANgJCh/lvU2rdEm9h8XNvp9m7vi8mSUj1TAS
        bS42VhKZ0Fow02VFTWo/XMCf0yAtZI/sGhyJwHeuaR03tfYJfOAHjcVQ+Pa8y2Arwllvi4
        J71zjKQdnt+/djh0jDLGf5JoHv5tmfI=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-hqqyvQQlMyiyNxxylOPYNA-1; Mon, 30 Aug 2021 06:46:31 +0200
X-MC-Unique: hqqyvQQlMyiyNxxylOPYNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwnYj8dDuyuve2khw68Y6gPNTSpAqO6DAaPm00QfO7OHp+vxUEgGk95VBSVKjSY1QOJfW6L44clPpyFCEOrFddDqMImYpwbFQrkVEkc0BdTzPhRjd11j1oEgxjGEqGSKyq3JP1RDI1x+57ADJd/h7YP89NcVLboD5CSGBeL9kxQoqQ3MQc0VoVABlFeeV+6OFTjNM8EZIy9ofNnVLBB/4VskxyUhB4T+vyusN+WOhSDA2hUvkF35vtn5goFlFVljQteWTA9XpXHLqRdvbRxhx/K/N9J76YvCv2pcKbfiontGI6csQjjvPJcL6HfKfS91nk1gQ+GOlGBAcbTCE4Wnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCokgxGLZl9QrUw5hu1Th+Svdfwva4BRiv5Norjt0Fg=;
 b=jOQVbkITaFShAZysDUBmJSLBV7QaWv8KuQbGb0l8y/BszNuu+LPVXDpTHX/7e/mml91FFtEsALmTG3n6xqEsBvDFZ9X8e04GW1ioMCh9N7HKr66zLa2MbMOPMdIDMyiqFI9OJQNA4iuXH+bT+cMW/stuGeAk717RADSsC8Vr0jzhKVlFYnypIczAJ2BrRvC46xuonZXK78xLapCtWjvvmpNqw/YG1U6R1dB8L44KoZ41qOLQuA9A9QnUIvsJq//uakcj9QZ4dGUBHf7jUA4jkxlEmduOMQXUsnG25G48ny5ke6M8nHCTwMUJaJRu4xBrdpiecn8X6g1NH3L5s9sFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fasheh.com; dkim=none (message not signed)
 header.d=none;fasheh.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM6PR04MB5064.eurprd04.prod.outlook.com (2603:10a6:20b:4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 04:46:30 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:46:29 +0000
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
CC:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH v2] ocfs2: ocfs2_downconvert_lock failure results in deadlock
Date:   Mon, 30 Aug 2021 12:46:21 +0800
Message-ID: <20210830044621.12544-1-ghe@suse.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (60.251.47.115) by HK0PR03CA0116.apcprd03.prod.outlook.com (2603:1096:203:b0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Mon, 30 Aug 2021 04:46:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5343dc60-1a01-4639-1c05-08d96b712219
X-MS-TrafficTypeDiagnostic: AM6PR04MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB506429F0C5913E2C7E5C4B0DCFCB9@AM6PR04MB5064.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0aUGhsn/GdcVspRDVM/n8zFdN5QinSBGSs5FRqKCxNYOXvwiGtXmhUOUjk9PuHdtI8ryZSlwFxi7tqp+tc2x4fwYBFGon2x/vffA3a4+x3ruNQQxRE6bsXHWryToSWzrkqzQC1fqZa9WKPXJYr3yvBJBCYJ9SMxU+/cva/vyj8YNWb0ux/sCd5IVyVUhXfsa7Ur5rXAg1j+V5MRPqTkCtN6NAGnR+PhWDGKlecL820uzuBOEcquILdzNUrU6aubJYEQfSe+bfeoAKUfbnMOb8/VHGZXhQazWUZLj5aBiST1jP99vTcqUqIUfYVCCuxJXWcT9hV92h8mBVhdzpSAb8kkII408ddhcS8T1kvVQ1m+CgYKHANqPye/OCVztXBn76oMTkZ51YlZWvf9n1JpAWCwE9NSSwHH0ty0ucn/XUUtTLWo3SU0CE7AIfejqUvgrcZsW1KFP6hi5KunaOKKsosQ5hVwQDWBb/orYJJsrowCD620KsEcltHVEGT4eMxvcxxTJV+o2kZlSxLg0pfEqbha9JErxUWi70UAmFXhVR3/thlq8aLMClcePuOQQUfiVAzfVGQc3/faKyZBnOE+Ijy92GdHCU6a6D8Az7ISY738MH+vzqkqmMErCmIGS5J4IWwFAkMevifE8xYnWRGoDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(366004)(396003)(346002)(6666004)(86362001)(5660300002)(4326008)(66946007)(1076003)(83380400001)(66556008)(66476007)(2906002)(6486002)(36756003)(38100700002)(2616005)(316002)(26005)(956004)(8676002)(8936002)(186003)(6496006)(478600001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxbzOLa0wcNtkoZQIKozcAcihm6893Fz8qaGdCgwwXFn2PsEju8K8zt9E4Zm?=
 =?us-ascii?Q?IlAcE7utf7hA6ez0jIvmw+VgvGKjVi/TR9RXn2Ivg59+mUUHIuF5RGkVvY6f?=
 =?us-ascii?Q?gKRoJmqYV1lfA31vMFFsvbTJZTT4KmzSpYPbJLpQ6LsxJ389CM2A4LsNd4JL?=
 =?us-ascii?Q?Gw4fA6h86sY8eD5LaPuvR9+2C9L6eQBI6r0BykAQlpwlotWpM+KB4Nshv1Vg?=
 =?us-ascii?Q?ypNXOfcHlZE/gAf4r8H1jCjDD2PbYNyRlb4UNZDuhucH5w280dXcVpD79rnU?=
 =?us-ascii?Q?SO6EwAKK0lYSU9I74ZJ5LnCIjQIjmvkNlsjXWwMV6Dteq5DOBTazesqVJj5j?=
 =?us-ascii?Q?Cnft7fVwe8l9xVRyiikIbcwJ3kHtN2X8TDQlY3yg2cddGC8SeJLdJk1tkk9b?=
 =?us-ascii?Q?wCrF7u+aCtj4wWqmkwYyWQhHEsrRGMECAITqN+YHb6Sr+T4bspsk5CCzPjCx?=
 =?us-ascii?Q?Etz+itzxHNBCIXfFsB88BhatuWYhoHt7RANifk+ii189My5y1vvD8c+bS7H5?=
 =?us-ascii?Q?n4oz1vQWPNmuXFU1dL/5RT1TOPtE4uahyr/DQR5k3XG73J1KRcZpZlU1DDjA?=
 =?us-ascii?Q?rphBOW48bRTEAtDR5f3RCbIUUySyhi5vltBWOe2Vdit/F1hOnLdy7QFaAXEI?=
 =?us-ascii?Q?L+ZW3OdP2bKwmkY7+saVDbClDMLqcPOJHMxQvUWnH6dMcTQ0frwYF3TuggaV?=
 =?us-ascii?Q?JCt4BQ0gJmJjQJ490Ulhze87LUKEBD8hMuo494LgPQc6fLiArvbcm7HrWepj?=
 =?us-ascii?Q?Yvz91xT7WUD0vRVP+07IP8UJANbEJotQu0FzHcz3c3Cc8CZiBgzwfqa/kAST?=
 =?us-ascii?Q?EIQfbH9YSwiMPzkhgN9/d4QG8Di8uwL/EB4mEnXMkWxQsXa3AtmU5S8Vnmy4?=
 =?us-ascii?Q?r2fIC3IzB9Jay0Y9rQ3GAB/VCMJlc12RZpOjq+J7fqtLzPnLcXs/cQwgnVbD?=
 =?us-ascii?Q?3TBrVn8apthLno6zWvo354mqg2Y57Bf4WwlB9xTBodBeL88pFpHHMXHPNN0K?=
 =?us-ascii?Q?FevGcxnl2+GhwDYH4isw2glbFNFj6uveK6d1BB4FDL7qt9TaYRpmaSv/khiC?=
 =?us-ascii?Q?MkeQwsV/k7Xi24g2gcznLShMtgCa2tqmcFhYPb0tF8RmP5vIm5iidaZC08qj?=
 =?us-ascii?Q?10ZN/ljhotCiUbwZ3W06SD10nC6mjPCduxWfjdKQIL43mB+Z/YpB3/wItHe9?=
 =?us-ascii?Q?LKYLVukH478b46edUCB3o3htBtDTmm8HbsVyWwWE6pT67bMzm8KFLH3fJ4bY?=
 =?us-ascii?Q?iv8YPBqy377xsIX+xZ0EqZqI/e/M6hAUdfucR0f07byh6LIN79xnKbJjDcfA?=
 =?us-ascii?Q?e5WQC56Cc39TxzRz9wc85zcC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5343dc60-1a01-4639-1c05-08d96b712219
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:46:29.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85rtYvDp+vt8ptc+8b6i0ADkvnCW58ZpNkGf9M+TncRv5w4earB+UZFvuVa2oe5U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually, ocfs2_downconvert_lock() function always downconverts
dlm lock to the expected level for satisfy dlm bast requests
from the other nodes.
But there is a rare situation. When dlm lock conversion is being
canceled, ocfs2_downconvert_lock() function will return -EBUSY.
You need to be aware that ocfs2_cancel_convert() function is
asynchronous in fsdlm implementation.
If we does not requeue this lockres entry, ocfs2 downconvert
thread no longer handles this dlm lock bast request. Then, the
other nodes will not get the dlm lock again, the current node's
process will be blocked when acquire this dlm lock again.

Signed-off-by: Gang He <ghe@suse.com>
---
v2: keep error print in ocfs2_downconvert_lock function, add more detailed
comments in code, add msleep to avoid repeated attempts.=20
---
 fs/ocfs2/dlmglue.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 48fd369c29a4..f8f561850470 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/delay.h>
 #include <linux/quotaops.h>
 #include <linux/sched/signal.h>
=20
@@ -3912,6 +3913,17 @@ static int ocfs2_unblock_lock(struct ocfs2_super *os=
b,
 	spin_unlock_irqrestore(&lockres->l_lock, flags);
 	ret =3D ocfs2_downconvert_lock(osb, lockres, new_level, set_lvb,
 				     gen);
+	/* The dlm lock convert is being cancelled in background,
+	 * ocfs2_cancel_convert() is asynchronous in fs/dlm,
+	 * requeue it, try again later.
+	 */
+	if (ret =3D=3D -EBUSY) {
+		ctl->requeue =3D 1;
+		mlog(ML_BASTS, "lockres %s, ReQ: Downconvert busy\n",
+		     lockres->l_name);
+		ret =3D 0;
+		msleep(20);
+	}
=20
 leave:
 	if (ret)
--=20
2.12.3

