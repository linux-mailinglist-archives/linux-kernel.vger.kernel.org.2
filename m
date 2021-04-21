Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE0366D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbhDUODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:03:25 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:19880
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236913AbhDUODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:03:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z73LE5hl9Tsh7VP5vXNNmjeIaPS51hjJvYOxDAK46yuY5WzZ0QZCkagSBHVGMzWB1bWSsW/jEQO7VS9xdVBc5rxu8qs/KkbMQl774+bYJG6U1Leu2YY4gm9ICZsnvd5p7UmgNb2WpqoLh3ezL8mUZlbLfWU5CN2nFzG8jNcXUSnLFJvXa4m+/9kLoZFHoHGbusVzFgLifltyNgewH4P8MrEeAnaRvHUReBi/YjeYqDq9YXWxSYuhL25A1/5OjH6VxvbrU95MlD+vQIDqjc6dw2mq2r1+Je+E2WOerzCfYxMfaJtN1yF+bdoUqqveDAqdQTKo6TiBVAwQivifRSY8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL0tTH3kB4/m9uYIXsxED/KJ1bKpatevXELtn+L5v1I=;
 b=hqsp82rEklE2+Cn0Tmkf0D7jifb5NsknSb4N2FqQiEx8NGeDldCFObBBL3FiZ13HzUWE8eAFfDL8fQrOsX6JGyQCk8SpU6jDylkDeMN5ipSB0tCVejKE0YvSaNepV2PnBjcQSqVYo8JMLjSW0gj1OPBQJty/g6fuFndhsfQSuYPaNPhbvkBJKuvsng5XL0jPFB049NxnPUl84pAs32K988EFK58oLzIyUACSI6yfggDN5lhHmufg8ByHLI8BLxBckhpJ+YRgY67vgTDYq3loIee0Y5vLuwIKTYviRTlJDgppzhS/ykq62uezAv/sffwLCnvreuF2YF02oNy8mgo57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL0tTH3kB4/m9uYIXsxED/KJ1bKpatevXELtn+L5v1I=;
 b=iDJXC0qkiTY4iKXsXtG7svuZhlMIoG3GO6fUExWDtBvdZL9vDbItwEL+x5WjBuRfaHHlZiUl8UbhFt5prGmxNdbw3qTVY6V3pYDj8G6gPA8irto/QqmRWw4k/YKHmm1DGPFbnHZfmHauuP0lUxAIjZtVppuFR+gikLlHZVnYORswC33pBscNvz9Xm2pVxaFWxqBJsi2oojJBoLTRWZliYqcgkG4KHPa9V3ES8YN6/l/1E2StgJJYJhMnoYkS4iaa7wZdGPGOI4tOu5siUgMVahLBslmHUcIrqs2FQlkC9EAb76yPMsG1YMtfNusJ2rsGJ/tsSUeJnltfJo/LL0QvwQ==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 14:02:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:02:49 +0000
Date:   Wed, 21 Apr 2021 11:02:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 059/190] Revert "RDMA/srpt: Remove unnecessary assertion
 in srpt_queue_response"
Message-ID: <20210421140247.GG1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-60-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-60-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by YTXPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.22 via Frontend Transport; Wed, 21 Apr 2021 14:02:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDRH-009W6A-Iq; Wed, 21 Apr 2021 11:02:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516b47f4-1903-4871-472b-08d904ce25c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2601FB600BB8B040FCAA413EC2479@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPdMwHvOJz92g4S491Ls+BO+gEeV+1/cUVfjiGtLVEUnNIMhOmMJ79GVDjYm8+64LqZuxd5l51D+gS8TrFinvoP88xhaH+mzNfrrN/yQ5tU0xIki3+nVnL51UPZO2MlhSSgfFdlquu/yQoNBpcTOZmKNQZYaGPzpHzy98+BEugkJuVRUXx3+fh1dHsdhX/nAIL11WyuASwN1/KaZIrND1qeFAeIUQTliQ0tY7HlixzgTbVawLUsyOEmU+aKFmdxOfG2kaM9Q5BCDY8Ww0U7kRw9MfEMsouzD3o/rsh8CYSfrIdz8saCKFmgrKMj5sz1bow1wQLNhPkqHO+gHPqAYLK6N6zlzFPfCHrDwjXgVHrW+3qnFTjpYuqGq1vRc6rdbiediNcUWSWEe/YugEDd8e+XiyxI4sk41okxijyHZQsHdU/OGVmmVqg6AvT5oDGbppIJz5P9WIE/q8YKEZwburiWVlO9f4EFkit204cCzul8P9s7vfQ8iGQrie0qwgJa/dW6xTLDGcp83oEc69KU5RcIIIqSompXNguDzPoh7nu1UjqMcb2yBQo2+GF+VSEWE3QLQXPq+gt6SPfYpzp9b3lRD3BFZUjicb1W9cKoax9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(66946007)(66476007)(33656002)(478600001)(66556008)(26005)(9746002)(9786002)(8676002)(86362001)(5660300002)(6916009)(36756003)(186003)(83380400001)(8936002)(1076003)(2616005)(426003)(316002)(4326008)(2906002)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BEA7wPXRoNb/lzAc7B+W+TXPKTAvM2KeBL7RfgIyq0A15gV6+N2EJTWng9aW?=
 =?us-ascii?Q?vNgDmwNXhU2pOM+VYnCon+yDbjxCpS2A7zmu1G9blPEGUmjp0k3S1V27KT1H?=
 =?us-ascii?Q?1SG9HYJWSJA5FsbQLyCv2sqVx6/krPCHlOWSliBDGazr9MxrhTSGQFbCBeHe?=
 =?us-ascii?Q?/o5bes82hrlAiU7yOyZbXJe6fGCJhPWQ59wyh9hX+a3oA1euv60iGEYTSyWi?=
 =?us-ascii?Q?qV+EDfdXRdz4HKYk/RfNgjUsb3aI4/CBOCjq6G4NqvwgB1UskhZsSjVNKPwX?=
 =?us-ascii?Q?xx2QG+aohBOEB0l7bwB1apTye0X0Hg5NVsT+OuZamTafgtKESSItRNwXNHDh?=
 =?us-ascii?Q?jarHhc0qVgmgMNwW2rUJzhVX7t+L61iUgDdul7yPPKH+6vxOkP9M7+c81qk6?=
 =?us-ascii?Q?LsEtn4yCZPBc0QIFVSIfI65MlJen1zPBF1Oa7hgnWvkAY3TFKAxkruRxdUxp?=
 =?us-ascii?Q?ASqWbLJQlzGY3DY2s7Xze+ctxuSqaIGDjfZwpQpqL0ST+ZfnpERW+YmjkKLJ?=
 =?us-ascii?Q?+wPaDeMZeHiGquCpXwbt4MSH329Xbbquv6QhtNYHhNupQY8IWgK+2tI6i9VM?=
 =?us-ascii?Q?h3qEWKv1fH03fNGq2ueu0/Ha+x+wmiOwjQ/bK6qeonZpnSfJsMCiMNlJ3+pA?=
 =?us-ascii?Q?DkV/cHiHODOXM+s/BHC/RkNtFzpKG3abUGuGwVA63D7Ac7lnz6yVmy5uVKld?=
 =?us-ascii?Q?J8WPx39yGyOjwe/DL8IUEIhiOawKs5O5Rn9WmfAs74ftjxwdHGyQcpcdUfKM?=
 =?us-ascii?Q?75O+8RA6Q3G5U960kVDqEkV3zEY+PUCuvC0yxWTouNulV8KmO0OpYAFl/3NH?=
 =?us-ascii?Q?OVLAOgj95dI2n9us3EECljSW/HefS49dwAZV7UrTgt9HiCyxdf/uptASTizq?=
 =?us-ascii?Q?6w3+2ZGnRmftODl18OMGepTHLK9LiAqgIaIcWmHV6N2C+tXlAqCmubSRER+G?=
 =?us-ascii?Q?5LEKEeTCtKOp2OQzaaC5/+fyxcj2Dg32F7da9j00DSGj+TQNtQENBnuj4DtJ?=
 =?us-ascii?Q?CXvsq6TfEtvOLUxFvKGFTpQ02PRLcYcj0aN/Xj2NSHG20PZ2h//mGU6EmwMK?=
 =?us-ascii?Q?uPqVK+eN3IB2NSxB3GR360QJSrEHWoP6D8V/A4f39TAmhwOe1KPl/zgWX0YE?=
 =?us-ascii?Q?AG/dXWfwZsd+gQk/jDbZPz3go6dA6EGXXOHTgtHmtYoycXScbshG0ZnPyEqg?=
 =?us-ascii?Q?3CUiM/TWrGVzo27CiHOZXcDN88HvVwAWk1uiDlyjyyVolgALKSYkvMbUsiz1?=
 =?us-ascii?Q?w12muviaHQy7V79qeiEVHHDWnKGn/CeZ6Qd3PKGgG1VZLeQxGfXqnf9LQT4Y?=
 =?us-ascii?Q?+TaTI+0wEx3I4WAdMQMbmGGco//gMDP9lKfGGd3dy924GA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b47f4-1903-4871-472b-08d904ce25c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:02:49.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhtLBBzATCMZZZgoXEdmOHV2kjYB4EYwBGOvQwKwFyeeH20rRskYxrAh63avK76p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:54PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 9f48db0d4a08624bb9ba847ea40c8abad753b396.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 ++
>  1 file changed, 2 insertions(+)

I think this one is fine

Jason
