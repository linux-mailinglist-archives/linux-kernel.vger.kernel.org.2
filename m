Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37D0366DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhDUOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:07:42 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:23648
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243195AbhDUOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMPh1e3+ljIK0MpDEJO4ndDMEAX4hl3BG081Vea0e3wQDld5ISni+uAe5IWrsiBo8rUTnAjwjPK/Di8MuStyXl+2x4eMqpyXgTANJRZ+NuaMXlV9vnu6XH0PH3Os0UithXbWiWvqcitJjhReQnBwYdVAI4AzruR6gYP7ugV+Lmmr+O+rpHZ82PhgnKfrQYo+rVz3EPaJZX4i3US2+l6HHWTPmStwtlSi8Qj8FpqSTgNdmuZVFpVpLZ9Kkibynxakfg6KiOpztGhfHy7xMbOky6XPBOPPdMhLzF3heerJpGtmPtyxhZQRHLC7w4rtbdcBn+buAhrYNMM9Q+Da5Yg16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpFWSxPNA3pJJ7c2jyk5z832qMELwx+LGskj13nh3Lk=;
 b=cY5aR7Epyv0VXVpt1hgzNUCJKatWpgWfLvP5mj99LAfMwWapcTMyD2yKDNMe89TjqTdaj4T3dSdEdnErbODDE91R73xpkn0n9yP3sxuEclucglgolWJSlrpX0Cx2FYMknpTH8KywTFoUoie4rwipJe0C6RMmYgJdeIFwfXhit863Idg+ic3VWXwe7OIYJTsqAQJW4EfSz9Sn/KRyXaH8uGL8E/E7ixcBzkAsz56D6706rjL2oYWRcXyCXPeION3YFC5EendHGA1xKeG8uxDNYh+UsmGmHpeq1oIpwcOr212JPuNfec7W+x0v657qCfSZgz+f+VVlN0Th7QY4N1jXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpFWSxPNA3pJJ7c2jyk5z832qMELwx+LGskj13nh3Lk=;
 b=uisBi09J6qceQ678fE7Dz1p+1ByTY+Nsi2siWEbvdOjND/cM8kV3RgH6PQ8VTWuQP9+O8GQNZcGDFG45wtUY90nhkxubyYVGBaLCTWd7cvyVERLcK/lVUUm5gBUfOTZngAqX3wocDL3kW5grpDLUcM8P4E8VF/B4DouiK1X0gRr2TCzcJq3aROfqPbLrGFxhb2pDJ6Cch6Pyvvp6QLSAtGRI94nU9sK/I/5sRxp3HHijuqcF/KqgWlHfdyjZSMjM27YUVVEj0rna+7PuOIDAGNkdYvPUPcfdJstYJbL/Sgb+Xo4N2+IP6HoqJe5I5PpxBBCxR1TPPJJ+BGCcalfnsg==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Wed, 21 Apr
 2021 14:07:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:07:03 +0000
Date:   Wed, 21 Apr 2021 11:07:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH 107/190] Revert "RDMA/i40iw: Handle workqueue allocation
 failure"
Message-ID: <20210421140700.GH1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-108-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-108-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Wed, 21 Apr 2021 14:07:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDVM-009WI5-IC; Wed, 21 Apr 2021 11:07:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12bc480b-b52c-4ff3-7739-08d904cebd04
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835ABF56DAAC515C699DE60C2479@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfP45uXaQu0Ux/KdmKVF4Tq5/hc5T/yBrCzkvwlNvDySMBxq9CWZAi0ZhX8avPj4UGwJa+EA8inAAc1oP7I3scpUPxWJHZoPe1tjBSBdIQQDSAknaTih6Ay0xwT0KAUajBUERnZa2rV9hvfzC9vJt2gWPpt0+/N37jbcue8C8y2AozgrJNjfN1c12BGQVzCw7r2utO/3jjyKpyX562WiNRfq4VfO8LQ2AXg5P8D26sorjN1thlXyvPMIvH6k3zaiW7KBm5q0jBbMT2BIPJbgw6mzKHHTHvrPioUpRxc8tiWSHcyF036krKRiL1OIfVv4q2koFahgileVEGk1W1Mtmbl1GfP6euGH1vsY0vwopc7WhusHRzZMteY/dRc7URAVklw75DpbgaEKxs0i6076T5GB/CifD7qQY4thxPvPYVZyrU4rRv/qMoHxMyliSoL68TqgqFImNeoPfIXIrKqjxbUaEF0Tt5fmIPCbY/tIKwO7XyKKfcu+Zn6kfaKwXVdi+dO7sD5PUyAj9X4TDNlAnBT1QptalFIAypxDKt2LPmXv0Ejr9iUk5yMEO+abM1E+uMnkwYuPowIg9+Zce5nc8QkxumNw/k9MHudZsyV9EmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(366004)(346002)(8936002)(1076003)(36756003)(9746002)(86362001)(9786002)(38100700002)(186003)(478600001)(66556008)(5660300002)(66476007)(54906003)(316002)(83380400001)(6916009)(426003)(26005)(2616005)(8676002)(4326008)(33656002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GG89V02C5WjDrjHR58j7lqQilfJdQUSAOJ2BjZ7j5LiMpWyOM0O+KM7+BNPs?=
 =?us-ascii?Q?M0Lofq8RFR2WYokWqE0Jk2ThE9gKZ4ljuScSm3DA9UtvW7GwM5wkGd1SR9H6?=
 =?us-ascii?Q?A5zyCaNrLsV3uW8IWdMe6b4FfrhFlIAIqr+7YOHf3+RQZl7RYm04aJbh6VDJ?=
 =?us-ascii?Q?dZ+SpWq6bsW3OAM88/cQkP4FKbmUBqh/3fm2bWHukxeFl/Y6p7PsYNd4cu21?=
 =?us-ascii?Q?dWyUbMHNbGVZTY9Uxc8KQYD8+Xgl+F0INHuxC4yNOsAJL7UpbXwPN1xMRn3M?=
 =?us-ascii?Q?BHj51wrxFLvIwbmxIzSVpepi0fcVw5B1oKsruvtS5JTUyjH29ZfvKXDXbxNg?=
 =?us-ascii?Q?jQk3q+MIzVQs7ztLJICvzLhWJuqjWVcKjk2Ss9wNe6n01Z4cod2WRdC+aa7C?=
 =?us-ascii?Q?6PH0zfPgfi0TLjxUXSXnl3zeuUMTT/sCVQL3sWLy6/eFGIH4USJ8ELelxp9Z?=
 =?us-ascii?Q?fBmFfkIWXfhHW+N5SHWpRHY/EZUCjUoXUuvkDALlWpp82YFh7OWUUF2XVw5R?=
 =?us-ascii?Q?nskcDMnTo9bRrRmkWWpgb7H26B72oZaUcNpYu+kjvDfrNzVlDIBGk+jnAkyf?=
 =?us-ascii?Q?OVnTvERtlUA/WjLyCR2ZEq460UpCon+GFDA3MXdiX0AJSs6+Dl4Qi8cBewS3?=
 =?us-ascii?Q?w0Hr1NjvG3FeOf5N/oCBBQdZu7k9RYHqaV1KloI/ku5LLOCyxeMTWGkNI3YP?=
 =?us-ascii?Q?IMadzNYRoEWytA1Sy9WlCDfY2DTaHW88r7MeKnQNF4URvivPHjaooCDoyLNE?=
 =?us-ascii?Q?7mJQwEdW8jMl02uSPdUNCMaZKb694nMlyX4jRJSJuiosBESwWUFbjUnqMZP1?=
 =?us-ascii?Q?btuzarUilVQNYi+j/u8N1AxtXjBXaLxLGBsjUh4MWwAcn0WMcA05VR3d1PNK?=
 =?us-ascii?Q?5kjU9Qa2YFwjitKhyvyZ2l8hah+HC5zgFnWof1z2379wBjTYE3N4jFh/tuUQ?=
 =?us-ascii?Q?M6cA2M4AS4yYdy1myK2dAJH3UYW0RKF/jXuvh8OaEj03lRq56XylY4KjCq+E?=
 =?us-ascii?Q?Q0llapa20XGI21Q8AN1TugkspBQ4V1FPUUdXHHT3fmffg2QW/BfDuZE5gUo+?=
 =?us-ascii?Q?hFAgePAiIiw1HFxp6W+TT2Bk9C4Ow6hqDzFI3TBybYjhlL3tmsg8PIkQxusR?=
 =?us-ascii?Q?dR10iKSxRugRLEWQWdDTHDTq719NKgxKw6jQGsxzGgud66A79t1PiAEUuibU?=
 =?us-ascii?Q?NV62cFIsKj8N1Srm3b0Uy39jR6cHXYpljBLVjkIfQFBjVUXL++wEI91v/TXt?=
 =?us-ascii?Q?NFJakx8yThE/KMjjy9ojOzHdEX5OuJ2F9Q6kdS8cjHg5jNPL7XiG6Zz7/8on?=
 =?us-ascii?Q?+ubkad41eRTo2G4K/B8tSJCO+91F9Ue9QRpm3Skiuf5rlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bc480b-b52c-4ff3-7739-08d904cebd04
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:07:03.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4infKQD+6brZzlMGt0jiYDA9CZHswMxkACgkIfnUlWCVzbQceoNHn00I/5uz6wDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:42PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit e2a438bd7116889af36304903b92e56d0f347228.
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
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Shiraz, Saleem <shiraz.saleem@intel.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
>  drivers/infiniband/hw/i40iw/i40iw_cm.c   | 18 +++---------------
>  drivers/infiniband/hw/i40iw/i40iw_main.c |  5 +----
>  3 files changed, 5 insertions(+), 20 deletions(-)

I don't see a reason to revert this one, the new code structure
appears OK

Jason
