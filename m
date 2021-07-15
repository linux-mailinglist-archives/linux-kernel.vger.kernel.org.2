Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5868B3C9BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbhGOJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 05:29:40 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55]:7937
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241116AbhGOJ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9JOdMoRbyn6gmfkFbDmkDEN9vYlHH+ro8BempWM+cj/a7YZDcUGIQ3ie3p6qxU/joUtPP/YOPQBfe2sbUEyWzfIWnq7BawXaSk/r30ggmeV6y64VEF3x4bjzDp2JixQ7G9d6me3M4ESrhLW+EWxfAPqZsmd1fig/e1miyYoC441vI3oSu4/id13efuv+viOnQLD/BRN+ODLKyO+BdQgBlNow0jacch9Hxtcfe6hDBHm9Ygnqmd6BqSHuritEydScJinxssul5pTkrs35yb3KxfW58i9CcLiANV1LIJPR6bKeAcNPEpOrr/xQb1CB16fawkdbZb8wi3Jolf9Tbs4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LgH3fy4IOJQkdtGJyvrXFRL9uuUnsVvaMKcP6KnxiM=;
 b=b126RyMb72mafVUTcGTeamx7cPCQ0cQC3CQyyn40cdFVEQHfY9nv2bLp0K2kx+xftGWCk7uH1+jsdZgMbcxwbF+FQeJEd4LR6NFLhxUZZ6AWQJxQHlazLLnRYC7g+8cACM2/q/MA2rDTgfPX2f400fVcbPBmqnV5F5z0yVHg2G6dkOkvCpWnhn8tiZcvUnh3tYmHQ1ITAQYZhG4TakbEXGzMsoU9MOhiuBxlB8V378tmXoVbwPPgd0w3c+rARzDHCa5DP1XFiDR0a9KGqS5tsffKEJmN2nHzrObVPSLxaLopgvrb2jYYVVPdeCe5dlkFlwj84+rkljUtuZtsxE4dSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LgH3fy4IOJQkdtGJyvrXFRL9uuUnsVvaMKcP6KnxiM=;
 b=Htrk8D2GbQetzvtkzuBww0LqGvR0RAI67ylh7jUiIBqRqMhB8lN1YnUILUjDSVYeQdq/lrNiDfS+Hcw0T3n7NJWROQTogq/aw4gk+AAVNbWfUcAt2NJbR5va082efQ+NEhziEFcMbPYMkETbQV01HDlDuJE7SAXGXLp9y3Jzza0=
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 09:26:40 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9178:207b:3b1b:fdf9]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::9178:207b:3b1b:fdf9%6]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 09:26:40 +0000
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Robert Richter <rrichter@amd.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix intiramfs script name
Date:   Thu, 15 Jul 2021 11:26:02 +0200
Message-Id: <d935cf2c8d73ac2ad6a9390f563d561bfa65bcdf.1626262835.git.rrichter@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
References: <ad9c50c54887bde41ae5de782248231c06a527c0.1626262835.git.rrichter@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::18) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (77.11.111.27) by AM6PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:20b:c0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:26:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e77b1c-f4b7-4cfd-d62f-08d94772a6cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB256817435CEE18C76BAAC41B9C129@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U76QRkdb+FIkobfbGTnqKRcS532llJo46LyjFhdDhMeVt821zTEjYY6mIh1cA+HQHSHUFNufRxHQyqpxBPtC6zPTLWwKzfJ81bQ3MzJgR2QOIhw4uz/Umhlt0kLXEzqn9YAPrrb2DpU5w2BlrdAm/EPv3fwiFeATt8eb2+BDLC7Q6Y2H7tTolQgUH3ah0qNS1B2UPQrNtZLkrolB5neWgsrIbU5hQj3+0WcG6X5awfxySceJ4/4t7kg27+lD1ovEfDxicRsz4B9a3TJXCiXFGCI11/Hk672oyc+2DTnbK3jrWCnJi9hmKjTr/sj0XeemmO/N0CNYGWZhQchzhVGYaVzrGEqY16hmPlNworNu/wFs/ahviUoG4Q4J/xUtlrMfiUev6pVRqLGpsh4oCr1SqkvUBcR9rGKB7QZk4LlHR9yjXZqveHiCdUh7KAktiEalrgQfI06KHxNb6XeVbCAzHYTDp9xDI/YesN780PZiqbd1arMFiQaOQp5yCVKMrF+TODzA18neG9yM1Plp++s0xKqNgo1rseXooGwFOTET0pEwMyxYLr8Kwo7klaxjkXzEb4HYEkVnz+BRE0oBUz6DhzatIG2Ub4SkCMEOofJfTNf+PLlMtfwLkIgELvRuejl1OZhc80y3fENnFGDgda6aObUJLNIf6+ciy35YHz+esZc/BYqL5SiFI0w97cdMRh4rtqH1Zav81TrJWvORf7GJhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(5660300002)(478600001)(6506007)(66476007)(6512007)(66556008)(4326008)(52116002)(2616005)(83380400001)(66946007)(2906002)(26005)(38350700002)(38100700002)(8676002)(186003)(36756003)(316002)(8936002)(6486002)(956004)(110136005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfvpmxRGvba7YCCYA2dk/ijYjzDdY04wGc/8Zw4xLIhg63z5+E8vFxNqMS9D?=
 =?us-ascii?Q?uWqw/t1Uww1KucpKoTl20MqX2X6Lf/qVa/hC4fon5aFErF+No+zpggWqCCD6?=
 =?us-ascii?Q?9B8ppLX8k4jf1IsYXSIrlHxYbhho64UnHNJwTYQ8Izh1kqLeXb1TSvlvlypR?=
 =?us-ascii?Q?YFQfrVqC1oHwjQm8EF2ynr1VgondQFxUpH95DNTqFJuKnGwsSzXn4tUqqsZG?=
 =?us-ascii?Q?8GtXTaZhuxk5FZD7JFOa67o0EurjSZfgIq284BU51Gb2OfqjThEu2E+kmQRo?=
 =?us-ascii?Q?Oh/c5iBn005TzQpb+yM+VZ0b2UId2I45zkhQEMWVz5/lmDhJpqESpfyiEsUq?=
 =?us-ascii?Q?GapUw/urHSFSTQC9Dw87CxL/HFvacVi76NkGNn7deUKIq7fHWkEUBnIPyE4O?=
 =?us-ascii?Q?hMnLujleKDGHsIA5K6Sy1MVzqcWd5A8n3BYs/8ji+pf6+pMguoGkK7cpeUN/?=
 =?us-ascii?Q?A6rzQV3SOq5iKXFhx03++ofOXOdzbBYdtxIbA/Dpn+0Szbxblg5LKkGdjxFz?=
 =?us-ascii?Q?avQpxjh+Gpn37Q5/YOHXALi70T84RfASZ0wRiqgFANBdmbvN5ZtLEfQErua6?=
 =?us-ascii?Q?aRsHUBrFTto4umWYev486q/A5HPbM4qiq5+i/tOZ6PHcSM3+SrksxgJe9jyW?=
 =?us-ascii?Q?48FGjbA0aQ88D39/QLOH4G8cVvvWzZD9ySY5ay2h2VfiUZ8pdvyxaM9Jj+29?=
 =?us-ascii?Q?FIui92hXO05w4Uk9ftDDa9xiAsK43+GbA8ro+uNXJvRjGLDMTSo5J6ibWUUE?=
 =?us-ascii?Q?ylG9xohT9KBzCi2Q8G1OSnvJxcgS+sUvWAepG8L0zNYi9LvTwUbk0gMozs9Q?=
 =?us-ascii?Q?vBCetutEEr3PPttfq9hnjYiXbznKhzKPgqObNWKnmn/T36ZBknRH7qQoa/6R?=
 =?us-ascii?Q?LdQiUgUBnxks3ABVjctmNWCc15+k74iTOo8uNJUdaJX0Da2FUiDPj/ga9Cg4?=
 =?us-ascii?Q?v8jYGMq67EKI6O6N8CYZD1U2oZHjwk7sJiQProdveoLROw+cqtRbFOuDy52z?=
 =?us-ascii?Q?LMF85OwjgUJ3MAhDQ85897d7HlF0S6C4lU9MQk1iDFfbcY5uy7lWWO9qBpIT?=
 =?us-ascii?Q?Z57PwM5EcrRAyiSWlxv11TPMCGBTw5qSTxxTHZrmA0R3REJCT6vm5v7Mw8uo?=
 =?us-ascii?Q?JFqysvADuGwzOoVmO6Mc9+JJ3U7d7Yt8ZA7hQEd1h4+S75DanwMDJJ+Bq+/B?=
 =?us-ascii?Q?/+gnmU0fkNtXcL8aUaCRzCMuWopiiaJcqTniDYvdsdb1nlSlFB+qJYLy+M1Z?=
 =?us-ascii?Q?naVyvh88GUDNjKONq24kZ1fNK4UdmmpohTKk8VL8o837vEykoqqeTEY6aXYu?=
 =?us-ascii?Q?htK12ho5itzLJ6GHyzgQu+NN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e77b1c-f4b7-4cfd-d62f-08d94772a6cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:26:40.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p04MdTiZWEEk1luqDZt+RmS4rbdUYtggBlykXAmnGGvZhq/YsYPtRMCvWODPaX3GyK9pb1ncJjNrtTTOg2+SWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation was not changed when renaming the script in commit
80e715a06c2d ("initramfs: rename gen_initramfs_list.sh to
gen_initramfs.sh"). Fixing this.

Basically does:

 $ sed -i -e s/gen_initramfs_list.sh/gen_initramfs.sh/g $(git grep -l gen_initramfs_list.sh)

Fixes: 80e715a06c2d ("initramfs: rename gen_initramfs_list.sh to gen_initramfs.sh")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 .../early-userspace/early_userspace_support.rst           | 8 ++++----
 Documentation/filesystems/ramfs-rootfs-initramfs.rst      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
index 8a58c61932ff..61bdeac1bae5 100644
--- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
+++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
@@ -69,17 +69,17 @@ early userspace image can be built by an unprivileged user.
 
 As a technical note, when directories and files are specified, the
 entire CONFIG_INITRAMFS_SOURCE is passed to
-usr/gen_initramfs_list.sh.  This means that CONFIG_INITRAMFS_SOURCE
+usr/gen_initramfs.sh.  This means that CONFIG_INITRAMFS_SOURCE
 can really be interpreted as any legal argument to
-gen_initramfs_list.sh.  If a directory is specified as an argument then
+gen_initramfs.sh.  If a directory is specified as an argument then
 the contents are scanned, uid/gid translation is performed, and
 usr/gen_init_cpio file directives are output.  If a directory is
-specified as an argument to usr/gen_initramfs_list.sh then the
+specified as an argument to usr/gen_initramfs.sh then the
 contents of the file are simply copied to the output.  All of the output
 directives from directory scanning and file contents copying are
 processed by usr/gen_init_cpio.
 
-See also 'usr/gen_initramfs_list.sh -h'.
+See also 'usr/gen_initramfs.sh -h'.
 
 Where's this all leading?
 =========================
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 4598b0d90b60..164960631925 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -170,7 +170,7 @@ Documentation/driver-api/early-userspace/early_userspace_support.rst for more de
 The kernel does not depend on external cpio tools.  If you specify a
 directory instead of a configuration file, the kernel's build infrastructure
 creates a configuration file from that directory (usr/Makefile calls
-usr/gen_initramfs_list.sh), and proceeds to package up that directory
+usr/gen_initramfs.sh), and proceeds to package up that directory
 using the config file (by feeding it to usr/gen_init_cpio, which is created
 from usr/gen_init_cpio.c).  The kernel's build-time cpio creation code is
 entirely self-contained, and the kernel's boot-time extractor is also
-- 
2.29.2

