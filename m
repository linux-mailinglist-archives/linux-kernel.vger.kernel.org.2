Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0D3AC805
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhFRJw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:52:56 -0400
Received: from mail-eopbgr1320082.outbound.protection.outlook.com ([40.107.132.82]:45312
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229915AbhFRJwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOpBuRDSjY2dNikuqv+YAOxKxMgFRs2muzO1+Qj7pLZ3GHarLpkBGjf+dN6ku0tYuxC6jatvzL+r8XvZO8QfAL5GtoTkDuMVqF/klydYc276f0PCtHgpHWnD+v8mq0qT5IpWbdmvqm3iZ0EPMrNAK5QLTmGvCiJuGaVm92lFELdqmIHkDLNnkxjrUS5WZUDIHL0Hu8gkszomCQG9+gshNIKnjU64FV97Dw+HeoRK+pD54Zy4lYUaPQA5ThSUKh0esARUzuXoy1EcHwnZyAdEzFTzxpGM+4TnC2JOY9fiFir0zLwSn+NrhLQM1XH9kZnBWjZlcatVa5VtI+EjYjP6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h51DidvJpyUftRbTvJCMOLHs3+XSUMJ3D1BXbw+wuxI=;
 b=KJDUEfc69i4t+3N1l51cZQHm1E5zXhFRruVL/3dxbdOKwAltW/FaSJ5sg4PX7YP0scPE1QAqeulDLJkukh1okdg8QWTm+vpTH/8Jt0f8DJ9mxz31s607Kp/RMHZm9uKoXQSRZYROMoRttJN/+srB6YNyamGt7Wdu84WmDzkxr5n8oPiHxD4Y0tGy41F3JAlVf/+xBuWDqLmN0treq5cFSlRuiScWWf8Mo26nGBiZP2Cztpg6vJxkCYWRr28hSJpYY/s7cJ6xmgmlsExzYw01zovvb2QdhiXGrPkzDAFiIvtZttAazDpr/MsKFDMfEqC/pjaMOtI2V5dOW6y2e8nHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h51DidvJpyUftRbTvJCMOLHs3+XSUMJ3D1BXbw+wuxI=;
 b=g+YkZN9LSUIUZlPyC+wijnfHi5y6p4lBHyxb1hTfETGIAoz1xxu2q8XuBcN45WRKXs99DHgxrZiu7UWNrUYE/rEkHzeVHbj0RzgGu6y2jq1Ed77RI8yT7/MacgPbMJ7JQEMzIxMktMn3FO/92MWY2mxV+GQknXnowab/RaLHpmk=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oppo.com;
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com (2603:1096:203:6b::15)
 by HK0PR02MB3377.apcprd02.prod.outlook.com (2603:1096:203:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Fri, 18 Jun
 2021 09:50:43 +0000
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf]) by HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::850:c291:f53f:bacf%4]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 09:50:43 +0000
From:   liuhailong <liuhailong@oppo.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        liuhailong <liuhailong@oppo.com>
Subject: [PATCH] staging: android: ashmem: add size field in procfs fdinfo
Date:   Fri, 18 Jun 2021 17:50:35 +0800
Message-Id: <20210618095035.32410-1-liuhailong@oppo.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.106]
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To HK0PR02MB3154.apcprd02.prod.outlook.com
 (2603:1096:203:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PB80250894.adc.com (58.255.79.106) by HK2PR0401CA0008.apcprd04.prod.outlook.com (2603:1096:202:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 09:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72eae402-18d4-4cf0-1da6-08d9323e899a
X-MS-TrafficTypeDiagnostic: HK0PR02MB3377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR02MB3377C445C9B6DB02F0D1EB4BAF0D9@HK0PR02MB3377.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLm8FB0odxWEbrhg3cH/0Yz2XnH3t9qx/IY9DGPGmJzs5EHeKgkHTWO9RYIRo7sUuVi/y+3w5zdcwOjyOffzrp1v42JNbDYwbEQhrlNQ4Ew/RNvSBj36BY9h28VIFIOw4DuBTP4BvI7GsAe3Fk+tnhXDrDuesV1Dv73XELl29xvJBzprVhYYtD/rzuzGVAN7ULDXdGvPNysr43fVKFGXBytFXyznG0TD8EFL/0aQ2Rr1zw24+p7yw7kQrjG2DZDzbVRx2agosEZEtLPTSkAkM0EalbH5a6qjT7O80yc+WBiOl7Ch60cHgi8WWmKffRKc+XXQ86XBQHG0DACtonYXKq23Uaei/UwFgS7Ikdr2OsynFkGYBFtATN5JkAHafOo1TFNp5ngkU9joO1qjHrBa8PmkJ3WA1m+5ewMRmpDSvofKO0i8hDWgEYQTUD0a2EIJBo98Siny6cCChbqAIVzj0oQPcUB0youJrn3tWd0mhHZVM94dke3cXzK7oy47DYmlhRxPPhRvxOosS0KISC/JcKvJIsAEnKTuUGMYhm9T63cyoz7j+IPDVGUrMaoLX5h1PYcP1eGfsg6Mtx33mq+m8MkB/zqyfFlNgSaTRtAyd5QW2kLzjwGPLDyp3EbF6Ao0LfXIXUvLkdMQD016HkmBgMPZuWZpayOQxp38l9ol6OU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3154.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(366004)(376002)(396003)(38100700002)(2616005)(6666004)(956004)(316002)(186003)(66476007)(66556008)(16526019)(26005)(6512007)(8936002)(36756003)(38350700002)(7416002)(86362001)(83380400001)(6486002)(66946007)(52116002)(6506007)(4744005)(2906002)(478600001)(8676002)(107886003)(5660300002)(4326008)(1076003)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ntAn+f4z5EsEunOJQ3+uUuVbYdvtnIFExZV/M62Kth+/irIN7sVkci8yz8F?=
 =?us-ascii?Q?DIMHQHJcvfSR9RLXuROJqi8uPPp52xtNhUsgz4h08dDsf4IwkuSOijlTIp+k?=
 =?us-ascii?Q?JIPLWrEo7fmgPlxr+n2xL7vfZBXqSAsCskgtB64vWJjiWdC4Dq4TkI1hsfwx?=
 =?us-ascii?Q?B6puJbT94I/sgiZ+Iq4pfpp3jw4fG7JxyG9/twCOXYNUq1M2PGYAGxffMBUI?=
 =?us-ascii?Q?0fGHOLhZ9W511jeaBzbhb+sfOkGFNwV5/c+MLQFgP4c4+glJy7GurYtXdFiy?=
 =?us-ascii?Q?QVUghdr4k/DcpCE7ptv0kik5jXtDPZOWdp23FaTXRpSOmJtIVe0jv9weAZ4q?=
 =?us-ascii?Q?ni/H41U2g4sglnChXrmygw3mOmYaEFzqpg9cWIes5jAElPbDJgPGvuKx0zv2?=
 =?us-ascii?Q?QdoXrVXs47vX5rzXVhG6hSDP0wgJIF6HDedYhQdPDCkNrJDWMEH/ayEAGZfZ?=
 =?us-ascii?Q?NFeEUOMncobZCaIMeAPFduQ+vsSCqitza4NJG2cO5kxa2Aa1fPgs4YWbEhaX?=
 =?us-ascii?Q?xqVMN7uzUyBWYqwBin94Tunh0pPtloWCYFAVm9IMIqiHonDzCkuBzdfQck6j?=
 =?us-ascii?Q?T6VFO7IPayVgfqwG9y6rwwBmvKvn97VI4MajrG+8MzujK3UoW3uazKAncPfn?=
 =?us-ascii?Q?9d4ZEiyijtfyaxWXZv5kij3M4fUlWvrG2N9+UkSt9yFDM/pgG2XqdPELJTct?=
 =?us-ascii?Q?dcAEyNRPI8YeJICoyLVTPPiDe6W6lqruLt+9y/xAQ2OKQ+vsjBL0iSqG6sQL?=
 =?us-ascii?Q?+RS2AMb6wHYomaA9ndwjEeiZSpg2Nplzr/a3lj7S9FWLg//KMHo1msfVbRmL?=
 =?us-ascii?Q?OBTQNYhcoTUrWelMvg0u+s8dxI9X+jDHS7Hv23dkp033KVqA7vyP2oS6prGq?=
 =?us-ascii?Q?GaMgemNp+8PHoShgxZ75WURwy6VDAa+C8iSJF1Yjws3a/BH2p/huRzaHehT5?=
 =?us-ascii?Q?QMaPcD/8rC6MbiSvsFebDb9S5XDUZMxne3Fh/sENQh9hCZ5WZYSqPF4K42Ec?=
 =?us-ascii?Q?6gBLqeI4gHFgIIhyqEFoaDI5gl5htAQSlgAWU1gy40d4PID0Blj5BLq0r4Vh?=
 =?us-ascii?Q?OUvDZvUweH4Z8zcadwa5NZQNAGrw21HGA8YeS4m8JOd5gDR5uE4yTUtkWEMK?=
 =?us-ascii?Q?8fKrFMHT/JAHZ3mz0jhuQNjwzYO8+PQh6H/pjXpQIC30hxOK2UzkiY/okoMx?=
 =?us-ascii?Q?ZAHL33iVqI2Gn2FOVt6/3ECk/FBiGQPW2N3R1yOD06ZOFsWrP2h9QNF/rJ4z?=
 =?us-ascii?Q?K0/UiKbTCDLm/c2iMubWsgbsiFQOMh38m2XNX06F/vVrfv8JTGnPb716lECl?=
 =?us-ascii?Q?21DAs0kqJkUdmK4jiDS/8Zig?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eae402-18d4-4cf0-1da6-08d9323e899a
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3154.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 09:50:42.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXAW8Cd+K34omX3XDuyYu9qIa5OMVJ7KRZP2M8KT2/t1tRPL8ujRTZBiSf5B5DPUpC3TaHxWf0tM2FJi9u73lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR02MB3377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add this information to help user to find ashmem problem.

ashmem leak scenario:
-000|fd = ashmem_create_region
-001|mmap and pagefault
-002|munmap
-003|forget close(fd) <---- which lead to ashmem leak

Signed-off-by: liuhailong <liuhailong@oppo.com>
---
 drivers/staging/android/ashmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d66a64e42273..ee2fd75111d8 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -894,6 +894,8 @@ static void ashmem_show_fdinfo(struct seq_file *m, struct file *file)
 		seq_printf(m, "name:\t%s\n",
 			   asma->name + ASHMEM_NAME_PREFIX_LEN);
 
+	seq_printf(m, "size:\t%zu\n", asma->size);
+
 	mutex_unlock(&ashmem_mutex);
 }
 #endif
-- 
2.30.2

