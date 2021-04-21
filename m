Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB76366DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhDUOJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:09:31 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:60640
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243323AbhDUOJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TScPmFcAVHXZn4J4hHt7YeQDhFIALHrP+MMsocQNrKnfQQv0QLmNYsU+UWCq2p2OkidKzoPP+TJbJBkcKrIQwZ2RcLV1OfVzncPMtvAlprlLowgCkX/kwHcff574j38QjWXZbjF0wGOgnmF95djhYlcfMVQGVApXhE3FTwJMpt6jiFpo1py20bcKnf0U9q9suviBPJaGmnFmwyLTTAvGlHxprblVdM7Y9BdZzQ8vTqcE1dSzbWw2ZDnzPnrNEGZkAw8OwgP+MAaW5Q06xAIqJe2UrJawd/4qedygaJ0jiycBNPPcgRmEYC7kNQXbA3UlocyqpL3HWFU8XMI5zlrJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9Tqzj+reuBw1gFZW4ccbxYClvONKsOhCApcNoV36Zg=;
 b=mUH6S/1UeUBmf1uuLShvUY1dV0JQtpirB6KBkKzRgEJQNlW/fXFkZ0k2Z3YFYugq7EDLMboc+MrhHtDe+0meouzvh8kozw7A23PlPKLLg/AR40GJr7Z20XuSZL5DXsHGLzXUizYTTFM6gxsIeHpawAz2y0cQ6FP9qXuJNXHV0i+KUZGe2E3Y2whMrWf1cPaSsSl8x0CgDYJgmOITB8t9tQeZAA0KAVCQfXj+CA0BW3YjWphJ1Reu0/k9XkxcmtZBNcsBq/l6VlUhY2s1NGX8kdvJvGd5JIRQQet6elSHuQSmx5HcBAZ6rrR+SZa4LV2E2rutMCDSFGsZvdW+rJ0utQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9Tqzj+reuBw1gFZW4ccbxYClvONKsOhCApcNoV36Zg=;
 b=CElxXSoQ4oTARcNruM/4ZnltQXAL+RRvdLsmxFhm5KKzYRyP1UmMT5PEoxGbnf0YQqTqQHZIa5UmspKfnk8t3Urzf5qyqBumvPWU3nZ9Uv3QRsxudCZPCinvL0VRrjoxuW6uMaWwKpfLPR1Ahzdq1BY4kibHPqHJe/TkLLvJzuz/spH+s+6WqxqL62YqrGaOJV4vCJhGwYZVpcFzsosigyGMrGA7gm0JVnqD9NkM9wI77dRpKSUu5tPfro2r+vv5e5JMj5YxFtq14RBuqLaOb0GAxcJflvoL3RmYY3dqxNJhUlLonYgNQ5zrMoSqCaYpcJzbNVLIl4JG7Lj4lHintA==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 14:08:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:08:46 +0000
Date:   Wed, 21 Apr 2021 11:08:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH 166/190] Revert "infiniband: bnxt_re: qplib: Check the
 return value of send_message"
Message-ID: <20210421140844.GI1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-167-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-167-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:208:d4::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:d4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 14:08:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDX2-009WM4-MW; Wed, 21 Apr 2021 11:08:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8fc531-0ab4-4623-88ac-08d904cefa5d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383591E429A2956B007B06ADC2479@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DS+4f4IhD0bbWFgDEjC8+vczJRB6UkiyarC9L6tj3ooGnC0DSa7bKX517LxJ1/lHQVyGb7D2ZGMzJVXJG1jfM8RYUGHn2HRM0nhN8eiK2mFogVUvX1rcyWr+BYddHIk5041l1RL/UplfjrLlQ14jsuoQlGib3yOqcMMGPh77YRugznyLglnq7GqYQIIvm0T40wkY5X3EYSqgSZzXxJNruL4m/ISXdLGzoyWbhp81MBTbopmzm2kbUMono2l3jL1zcf9loylrgTXv4E/vO1aOv+KwZMbPVYOKLr86PTM5RhVne/1LkzxtAfeqmUyy3ePdBG+uB8E28gd9VCRZGlqkA1ipWWlJBdtTpmz/cibio0RjXCzXCAJjDiAjkhucz27BHT76c33RGCU6YpOnw2cGXstW8nXquZEeW9tWaAMDueKQH8/39WdPq71RhUxTxDzTvgUM3Oc+csrUvpTBcJ3PyYe619EMVLmAwIYb9WopaE8E8MfHDUicQZLx+8cuMrOPbDYxAawxjk/JJeFWWSFsF4o2cXcrtdqRSiR2aIFo/bSkUWNhnZ0Jf1BY+dwwWRSh7oRtqlwp85gBKL/AdZ/oFBw52sb7nvv/Il6uotMb8zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(8936002)(1076003)(36756003)(9746002)(86362001)(9786002)(38100700002)(186003)(478600001)(66556008)(5660300002)(66476007)(54906003)(316002)(83380400001)(6916009)(426003)(26005)(2616005)(8676002)(4326008)(33656002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8fHrCBhQF2Ja8jeAikYj9rJGl9Y5JXF5szAVP5fob/ahbDO/nYcmr+7+I9mF?=
 =?us-ascii?Q?dJnlay8FMV6ZJR0V3biWLbmefGQGZRvjqt+IDkQH+037UfAVXqIYBlA96WHH?=
 =?us-ascii?Q?XEnQb2es9hhp9OTxK3Xrb7YpPE8IEyvM+pO+cWkBlXkrpTz6Q03z+TwrKIxH?=
 =?us-ascii?Q?3FK1XNxuafsI6bQ3irvgSozPGkiBkex5L0PrypuIXHb1P6LxV2rvzyjKAPgT?=
 =?us-ascii?Q?tksil8DfhJRVdZWMFmMA2agTDTl/2eJa9vtDgM+zn6eVEfxxoe/Hm2b5vfdM?=
 =?us-ascii?Q?gN41tlApSV3N5aY95yboEXNtvH9DCgVOeB7tIL+rLUnyUateYzdecWJeGmhZ?=
 =?us-ascii?Q?yEw2wwsFjW2k4TJyhjcEAeDIyxVDN9RKsClBjg4PNlxAo3N63PJ5NEezgCDK?=
 =?us-ascii?Q?2rt3i6vPYJTqOKztIwJmDJUTdjJkrtiUrI+mpl9RaGPcm5j2OD/+qspfCSHD?=
 =?us-ascii?Q?YF+KGSDH50O6FURTsLprlMMOQy/iCM2dU1hM4Z6b+peKwTYTazlWCeOHiXTO?=
 =?us-ascii?Q?KES2kV3rPgdUMPxm1tIcOis38PPczHQtfGobihROPYVpXvM11C0ncQw7wEsi?=
 =?us-ascii?Q?YCSzzkupCqUxeG0j2R9hnATBo9f4Fhid9Ecp14vrblCjOvDvl4pd/b7AwH5T?=
 =?us-ascii?Q?Gbxzx4Z+ESWlaed8+BgKj3b70cG1wlcRgGKFcG0ae6fc1UxCPTD4WvTT4/Ip?=
 =?us-ascii?Q?HG8BX4WGYVgRZAkkJ6Ti/dhsTVZ2svVVqDIyP5iyXTOGZRunn6/2bVmY6Ixr?=
 =?us-ascii?Q?rMb93HJIkH0AKK55036AygtdJySM4H/wJTY/0wqPWYGtxtJVDrKZEmAPa6eb?=
 =?us-ascii?Q?05SYAUguLq3QXxnqVieVPuvJW5XrB587ZKGFZZKmlc+lOAPYb0h5h5Y5lk4s?=
 =?us-ascii?Q?s1Q1RdJsOrVeyOjBGgsxW+PBQBR3n+c7/R5cWODYKcPLbKjnTkiLxGf6NiQE?=
 =?us-ascii?Q?bM/Ty6w3bPQryKw7XcixUjFacqNrlGTR7lF022meh3CxMjv8k+DsVBaXxYSe?=
 =?us-ascii?Q?8j8jgko6sJXsu8xKY5Wz0qNzwmti5xAFikojaUYj7aI8XPt+3Gx/Mq11+m0T?=
 =?us-ascii?Q?T4V4N+abTT45MOiOCb+dJWKHVw9h+yitXWJn6ye5DvjYC5bbBuL/jjcp1ZSR?=
 =?us-ascii?Q?ezNeuwN7EURE/Hhl7DblgAU7wd3DrUbnPkqmTrxb4YMqrTixO6jEfIK+Mqbg?=
 =?us-ascii?Q?FnyLbvf05X/k8ftJmn4Vvcj/stA6B+2k3JD88Adb1r2Ya/ItquZx6bs6AlF1?=
 =?us-ascii?Q?5woLlp9/hN4fTcAU32WdvpH3lkCgHVWDjA8i3ciP38CjkEfrcv95M7yP3mfI?=
 =?us-ascii?Q?bGQfW7FueyDdzU6YL50pDunkp5cbefgaOccLL6X82AfhqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8fc531-0ab4-4623-88ac-08d904cefa5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:08:46.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ouyjGARMRUc62ki8Ar7qNWZz/YVkszPFKirAIjNt2VruYb0uduqN+zwnw4i128Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:00:41PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 94edd87a1c59f3efa6fdf4e98d6d492e6cec6173.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Devesh Sharma <devesh.sharma@broadcom.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Can't see a reason to revert this one, I re-checked the callers error
paths and it looks OK

Jason
