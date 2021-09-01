Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851CB3FE3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbhIAUWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:22:25 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:32480
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245294AbhIAUVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/XqFiVgV+8A49UgNYNqM5Ex0JfAn/UmymK5Hjef2w/2bJswZYFNBrVS3Ftd7PHUc3hG9eYB4EvNXvMYDEtBrZcQGax8afLC7wyr6YuUxfmTEeaNfMjpbIPC9VaM72y30wV3hNT6Up91fB0YqlaxDisRZDhIS9C3nfX2mK3hM+8TYqS/js/TtfdrBsXB+AO7CmOXmk0zuFYtDQWKYZEX7YyIt2X65dCTauYPmxhItElfwrFLTtORXgFpox5FhLuzZYR6+HvzGSsPCecUnOJUPq5CcGEmBsQXH+H+Ca3b0wNk51a5IQoi9/vtgj5aYc1C6boH6sKP4o0aUA0gVxaKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=iiyG6XpQbgdl1F6c1SWu9IpoAhpZICjt04vYHHLjBh6JYBSOipfY75mUXXCoFL8eZc+Fxn9tlSV+9oa+GdC9yrtCLykN+XGFOytFrpSCc35TGezswuZiYtBTflouk34jZOm7XO4dIZA4DAW2Fj5qQBfaWng6+Bz/NqUS+z+osYF4E7YTQ34apv/APyZGvSPAqiIfpGcxrgTuJ3/TLKZNIrfTiBiNTOmh4TvBZGD9Nj779VcbwZGNoyFtWEb2ZKeGIpiMA+e5Mj7iPYI7qm02GqMo6+O6Ru+5+qgR9RlBWBwXspOP7ZjydHw0HfY+FEE9uDJgA6hxVdqPaPQlUT0Wxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=1l5zqoyJJUrIff+Guk52c4H3OkuJl4QvwockDUAaN/BYg32x/aRHvO6houFFjWNGGKNkVCjx3xmbXjEElUJPWVRp9D5iOkSEioZHRqkSk83xFI2vjwG1BTrvgDTn/at7c88NitUwL1dY2k50K84M3bi2Itqd5/LboHBsX+EGsvc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0208.namprd12.prod.outlook.com (2603:10b6:301:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 20:20:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 20:20:43 +0000
From:   Babu Moger <babu.moger@amd.com>
To:     writetopawan@gmail.com
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, rsaripal@amd.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Date:   Wed,  1 Sep 2021 15:20:30 -0500
Message-Id: <20210901202030.14133-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
References: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from bmoger-ubuntu.amd.com (165.204.77.1) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 1 Sep 2021 20:20:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661ae6a4-6b4d-48d8-5026-08d96d85f966
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02084030B147D91D850339D495CD9@MWHPR1201MB0208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0JvJJN2BRT7ZFBJogmenfSleE1UhqcUccT38JCeeCHCVBLZ31OzDmu5wGUWv7CEh7A6HLQDx6sXDh9N5N3Vt8K8NAw63qF57PKP9mcA/4Ei4L8AkoZK+Am1M7qnFwUL/sKCh2P7xMXhvfa8GEVLTnakFxQYxjpbUa3nGEDvfrt8pf7ywNFLxlF7eUzXhjs/vbQ7F5Z+zd3srzG/7sCtTKPL8mo2JM4Rtomeo+ssmWzXQgX+02YB2NiQPZ7K8RgUFAyQS7dsA7aroNWBTSox6uruUgeueBwg3hBWkNY31z3FghzneATMGC4ubyae5QS3XO6B4IYC5ihFHG9HTaKeoGofXpx0w8RNqFlCz0Z00lHook4MErMx9qQmDc3FAkWunpjXfJQ7LFBOP7TnZiKDpj4ObCpq0jQxdvZECwN1BAqgM5aJ25EW9w7wrDJkFvkQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(6916009)(316002)(478600001)(38100700002)(8936002)(186003)(66556008)(621065003)(73894004)(66476007)(38350700002)(86362001)(956004)(2906002)(6666004)(4270600006)(26005)(36756003)(2616005)(8676002)(1076003)(4326008)(66946007)(52116002)(44832011)(7696005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OPsh7DE5h6HqX+7bu+nrMDrP03hQ/adNKLPxQvPd9str5/bqHcWS//13xMT?=
 =?us-ascii?Q?wQellXtPBSSRxDmQBYbU/5aF29Zrm5sbOH1bV7566lvrWSsKnmNyX7HMwzHx?=
 =?us-ascii?Q?5bDmwBUuLHpK3T2tGz5HnboblESC2ckUGnwCxgCHlWwH2HivdgF998C2XGx6?=
 =?us-ascii?Q?En3dsHHT1XEVFVfkgbDo8tTlPAsZ1phtgo4dFD/LM+l0jjba3TqzHUbs2Ml1?=
 =?us-ascii?Q?rJsr4Fbrf5xq3ThW/9BslSbwcpHqC1fjopJgT72Z3O/vgwkddJMEIPskzXh5?=
 =?us-ascii?Q?ZLddVg1aUWsNTYxrpZnqWnuslt0FQVfevpAWp3oXfojr9X0NKbuUJbAoHujE?=
 =?us-ascii?Q?WQ+LxejmaYVrKDR0VcaL3Ep6cs9fJsWsmLwFqiRr+VqBrx2ZPNdsEMoyVOhb?=
 =?us-ascii?Q?GytlCQH3xBx5H0s3yRTF+egVYH9gQHB/MiVIrPGPIl66jUGHHdD9OIjduAWF?=
 =?us-ascii?Q?UWeqS77WvuRDqMW1Jp8x56po98Fxscf0IK4Sj48ngQrPqJpztYy9lrEhT3Vu?=
 =?us-ascii?Q?HavcFRgkxBxrw00TG44f5yTnk6jj2/90QBJwzzGlEalnn5uncTUv8/WHGHwu?=
 =?us-ascii?Q?rw3oRCVHk6V0F5jJj6c2EPdZQ2yX2lPrwjy2fw1JKNd9kzYguDwI2oMjjVTN?=
 =?us-ascii?Q?CLzpDOkTNE1ymhlaK3UVqe6lbNW+YEaJ38mzpPN39NUaE47AyMR8zZCoEyUW?=
 =?us-ascii?Q?1vKnMy90p5JjtcU9HyGfeCM0aRYfVSL39BFvjFh0W+3WDOw7ovIRAljhBJsp?=
 =?us-ascii?Q?lixMAJjck5Imdtrvox7ERCFGvBQVY3or91nxrdVGDOg642KLcK2aoUwNTBhe?=
 =?us-ascii?Q?R5yYvXyTr5Za2i1okSPIWWQn5YReam2Si56NtdiTTwqFyUrL1CLdszz8hRAo?=
 =?us-ascii?Q?0Tdnni14P/G2w8PdDMpdKMzpDpe3mGCn3648tx/ycEuEiHEzGFkwxVVBypL/?=
 =?us-ascii?Q?lfjQXxL4bx6du9krIxFXXHb4f3849LHNuSUHMtEm5UxFQq8VmWRyNqj9YdQO?=
 =?us-ascii?Q?cFGVtLpThHiG6V3p7YOx2WkQbpV6sSP4hHA7DxXzXrVAPkR+B20IiXI0l15M?=
 =?us-ascii?Q?m8mKDLqicatQvIif+LR9om9FQxIHD8JGI2gPhQ7jtDuvCSYVjG93v5Uf62ck?=
 =?us-ascii?Q?FeX2b+4yJZpW8sa7/EhWHu6DG70CUb0ecqKlO5k7IEWCeXyivhKYEJnzxWkA?=
 =?us-ascii?Q?QTv+f89w3vt82T9tQSrEXQnFzlj73+DuQbO4MPu0X8r+erwgEUmgU9aOumDC?=
 =?us-ascii?Q?18Bp+to/jY54uW02aPkB6W898MgjC9AMCtOM53d9yhdfDsH00GFezgXj+6H3?=
 =?us-ascii?Q?wu2vyBkYoCfJMBTH9MzczD7D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661ae6a4-6b4d-48d8-5026-08d96d85f966
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 20:20:43.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8I3HhSPzT2O5LZ7UDSbpslgJuHP/O8pGWU/I3tDgegYt2OE6US8oBrGGbHXX1C9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

