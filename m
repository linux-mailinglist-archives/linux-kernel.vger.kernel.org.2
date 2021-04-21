Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0BF366DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbhDUOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:15:22 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:30816
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239372AbhDUOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ3SL6FT7MPnn5LZ5o2YQPAYicx99uFoSvRiqch1SZZqZqs+UIDBW2IYYaJCt/yDAHjjaJZy9DBRTxgMgaPZ7XQL2nawHvTMKO4qrEk04WbQzG7RKVw3ch8UnfJGIX7UXRAiz6PDIUleZemIC6QkDhKaKrVIK3ZFm0uNtjrGDGn8NFd7GzUxJNtP4xTBO1s9ts02C1f4SrGhQKfPdd8PxkSQbKDg707me/8Voz3ZUevmj9/8o+zruT0RMZPuIEhqmMX/IiFg0tYP0I9AF9I+Qil9vtXTC2mj4w+UQIKssOzDDFLT8sSy8xTDs5w36MuiEOc7teUNfhcwGcNtsNuyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvH754eRmrkwc08VrnoYt+Mp22h+Lo2mD8PCgN4CYIk=;
 b=oQ+gChl2pp+ZzrQe/pHuESRF8fjIdp0PpRZ2SkUU9XYL8i6DXkGQDuf3CtilXO//i1HXTQUa7P/fDPlvwI0ptJBdIt5MZJsQTvU8T4CeUy1QUcQj9soJATD7Apl+nRZ9HPyrJfm0QqVrYXTmvX7PWNCZa68dXdwC6i74MNDA+iTkObzNL0k2ZKR5RA+32ys2S9W7+U0qYW4qId+1DlRJpC50fTnLv28O+/dBSJe1/OwLN03r0ssoCZVcf1JWPR1zYKNLPzZhZ/b4CBWELi7EAyqLc9OnlBSxydyQVh3sE5vahkdUoSEZE39gZlBbBlZ1oDdgMFqpOF8CCwNB+g0syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvH754eRmrkwc08VrnoYt+Mp22h+Lo2mD8PCgN4CYIk=;
 b=VLyTE67PXdn43BnevTtljxZywDibkxxlMOIkGgvC4HIvax+8fWY9fXVy7hW4zxpB69evdiYpPVdl5YCJ6MteUUzj1q6l4zy8Uo0La+Cax9fy6ozk5vK6t8ILMMrVc7QloA/tspwKAaiKLkmMC+D4sSRyjB5o/JETt8txMzGhEP3iyvWsU26MRmtrD11SvyXkQCu5tCGiaQHXXdFujRmLK8gQD3OrDQL15v/ParOPx89k/z6BvDvotUoEWeUJAprQu/WXTt2aAKOBnqDNSOHz0Dt6Q3WHeMG4EwaBByJM7bkwewOx/jlWaStXtHGDKZuog1ZImqJG4BCz0LgXOsjyDA==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 14:14:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:14:46 +0000
Date:   Wed, 21 Apr 2021 11:14:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <20210421141444.GL1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-38-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Wed, 21 Apr 2021 14:14:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDcq-009WTk-Pg; Wed, 21 Apr 2021 11:14:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 763430f1-e78c-466d-b3e2-08d904cfd128
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301810EE56F0B8E8B975A85AC2479@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdomPw3U3tQ+EpBPjh/16j/cMWW6isvB8gRkE99MwIr2elwHzvQzZigw+H+qsx7tejzSDrJJpGh5ndcJWfj8SoYvbq2jj2hXkVkZPmaJbyh5Iht70DqgjCRtxGZ5gahUjrt77MOJctHEU/nu4oF034F3XnK/6WeuTm9hDjfqgbCfOJCrpCddO9GIo6uv1Bv/sGrTN+ncZwTQeQfqBqEkUxQYg+7pS863Fl30PNLBeO9PSpHjSV7Y7KOUjGZTay2FmwfH5vNp6HdbebJ/fyHiUZ8+sHvAEEXEz83Ib3MN1AAPhyiNCTPLgQGaaDv/2uhIhsox45H9SNOLRkpZBWvc1ShNUNemE0YqnhI1etmTaYfVSFflWHHPrhzfFuElnBq7b2G2qFlT6xgFptZ7qRDQfcPUd0eLUDXuCVgXF3VD2aojCJUFzk4fQNMexUYHRJr75vId4w5MkNcqV0lf3B0RhYcBxcIoTIsaRrXqtYckhz/UfKlh/O4lbXkDQJ+2+35+zbD2TSYoF0uigrt12Qxao5M5TSaPMHo2hB6uucSPy/4Poe5Gv2r8GVLoetfO8sFuy/yxXUYTAXKcNFcb4T5PM7S0D/rXMjS2o0KzuxijfmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(1076003)(316002)(66556008)(66946007)(2616005)(9786002)(9746002)(36756003)(5660300002)(33656002)(38100700002)(8936002)(6916009)(426003)(2906002)(8676002)(26005)(86362001)(4326008)(66476007)(186003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HtuYE4QkR6uCPhTADUr3eDW3JbKeMf31I1xN45HoRNciw91CamXUvQCs0qhw?=
 =?us-ascii?Q?rIBHwkpPyYcWWysTb7XdoCuMHbdYCJwqzGDI3+Ml/i1H1B9AKD4Bbr4cJOZH?=
 =?us-ascii?Q?7BE8VzCpH+0lI0jV7FzKY95Zk1ba2HkosloEusFK+/w0OWEjvSVH/47LuqsO?=
 =?us-ascii?Q?q/2AhFa0vBZCs/jKFod2C6EU0HPBZRP2+fKPD3+gBOAkTuucRYfpA3Y2tQ7Y?=
 =?us-ascii?Q?oP/DLeOgYwVYDQde0GLZsphLKOp/QvrzAXFMyCdbuON67SeB07Cp1pTrkaop?=
 =?us-ascii?Q?K/Tsm7OBjn76JwgYFALyZK6bx0UeKCiKmvYNvh2RVrhx2ZXZ/QD7VhChqXFV?=
 =?us-ascii?Q?8t6sgaMh3PsKG4vUtrZkldx8+tvV8L5bl4tta/cavtbuy5kXbA3vb6Bazbhf?=
 =?us-ascii?Q?5GON9djnSFyAUF6Bc/I3JCZpW+zWSbcLTEwPMaE7vm8/Hs90AZuYJO3i0nRs?=
 =?us-ascii?Q?HVzWBbewWnZVE7X1v23K5q7t+ryhlaxaEwtmNrhY212ZoohxlZ0qKh7ApPVw?=
 =?us-ascii?Q?lPmL/fDloPnZcK1avp6nuIfyDqpUviy6vB6UD9orkNpZErupxhsDF35u7QhB?=
 =?us-ascii?Q?2e2OJ6pudKj+bPXN/kgY5XRPaaZr85S+Udu80p99lLYGxLfPkmOwYW1i32Fb?=
 =?us-ascii?Q?8a3wMrg4joxFdsy8HABvJrO7k/JQ4WMhcsrQktQv9Veq9RpHh00TsidQG7LP?=
 =?us-ascii?Q?RYkfg7i/THHXvkF0OoU39i8HXZkaEFVB9qu6P135CxabYZ9WQIUUNtDATTlP?=
 =?us-ascii?Q?bbjALapqdJixtSYMpL3lDJGlgVXK3RKKVtS4VjNVHOanF94oDOE46sVue91V?=
 =?us-ascii?Q?KuRaw34MGq+qHVTp0qN2c0t/1H3BtiY3+keQXLa+fqULlLLGmueD6Myq++BY?=
 =?us-ascii?Q?cxPxQmNEXNvDeGY0diHruibFBP+56nh6JqSdVMN7cOADtyfiOGgVAflqU3rW?=
 =?us-ascii?Q?o4KTFwXRVkMNbQARKhZfA/D/Ce/Ni1vkT8vSfKvdRtAzPdruhqlwVvAHZrjf?=
 =?us-ascii?Q?/pfbEDomYqBgWbh7W0YjK0Mch3t8wzzTN1lK8CI1R1bFNj7G4JhAoPOzVNDh?=
 =?us-ascii?Q?G2UWqLJGoKf2P2ljNwsetqj17y2pr7my7XnPpUcLqHdeQd6066HrJl0Vtei3?=
 =?us-ascii?Q?CZxOUJP/KzL9iC+WjYPDBoDIGoIhXrIHl33nxy9JfxBYBgVgrUZl/TPmf8Jy?=
 =?us-ascii?Q?+8WaDfq4JA5XxqY2lTd16uKi+1IDl0qmnS7jPQuEic0igObHmrQ4959vj1AD?=
 =?us-ascii?Q?EUNWdin2THTNN/ZPIne3gcII3uCKnuTXxixptVfIHlxy+OXClIDYAmChVzri?=
 =?us-ascii?Q?ePVdZIetyGcxMCvqS9FxXYoMnfmwUKyKEb3wmwG/MH6JOw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763430f1-e78c-466d-b3e2-08d904cfd128
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:14:46.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mo8MYmQ2HMBBlfnX0xJuHya2E2VC4WkbsH75mk4PfCo83FlGOXCRQVC7ER5ojQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:32PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 0b8e125e213204508e1b3c4bdfe69713280b7abd.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: https
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/core/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

The original commit is certainly moving things closer to being correct
but I'm concerned the entire area is still not bug free, it will take
me some time to check the whole code. Reverting seems reasonable for
now

Jason
