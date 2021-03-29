Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80734C133
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhC2Bi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:38:28 -0400
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:18862
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhC2Bh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:37:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ica/+tKiWFIO0JqMNKv5C2xFSFzrUWqQYLHQnreP4t817XUUeqVe1pOrUa7pDu9XRVJVUujeeOMHanzVhm4OhktWXuZ0TtZRocxtkNWtTHuO1thBJFfH8rAhmEo58l1pGXsLm3ovn0Lb0BOclE+gzk5zoGXo4MM2/WPedV1bSO8iV5HbOivrprx9hQsDWQqpVMoDccTdsF0gk/2UA+p6nAwkHSotXlIIjO/LkbdbrA5X4U/o9LpY4Q1qQenilNoGnDoOsDMobPAIKAXkrpsjuP/B6yUWFcxeE26VdZkwcDl+n5oIq4a36COk7hza0M8/EDF4SSIsVME3rYbA2s4WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULYy3z6oRYXsmVKDzDOE2bic6jCb59+FYusADySug3w=;
 b=RSD4Z+Yw5OxNKYFcvXi6ac72XLu9y4jw69CQwsQaArWL4RtJS1Frnyr4RJqQRO82/HbfTrPAGdHqJll1OjHwDQCvALeRHaUuifzS+eONXBy3VxRtnw4aWMnNnliHiCB9t419Rk8U1frDjLz10RTTNSVmCzhloScEDtyvzRWagw7sy8N3xrSw18TieAH2Bh0XI6JgB9LFvFWlVEw2bwg8rv3sl5zs9f4WtidKcFf3qM8MoiPIyw4J0tCES0kErSi2nsMCrx4vomt89uIGuoAprpz6tsryWMuwftx5nBk99tsYeOcSCyi+0mQlS8p37W5PQMRmicy6u+B8XmjMB2v12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULYy3z6oRYXsmVKDzDOE2bic6jCb59+FYusADySug3w=;
 b=n2TCoDjYdcTxT4DbTsQrwWG03IsWWJ1nAL6bjxaK3c1QUKv7G6ZOxxbDcZplEjurxZh9Dhml6748m1rslcgNAdTSDAu9VaaFv/SZLkwy42KOFY2MWIUxGBYNXaSGk228XBr7ehl5dC3SE/xuxQi1cwziTyFHQSg1uWDH7LHNZUmsvUjfgIEuXicFN/uVHPxNook9rkXr4D9Dn5v4JiTsJ4L67EptP9C1EN9cBhElSvf585A2Ky1rS9SaGIaPxXpKLPg29yhrnoBFdtfww4oR6Bf0p88T/gd/JuDX1e7Wrfz7ldKjXEcxzrRCgEZ/bKlXu4hAMd+mQuSdqH6b9mqaEA==
Received: from BN6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:405:2::18)
 by BYAPR12MB3160.namprd12.prod.outlook.com (2603:10b6:a03:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Mon, 29 Mar
 2021 01:37:55 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::b8) by BN6PR11CA0008.outlook.office365.com
 (2603:10b6:405:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Mon, 29 Mar 2021 01:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 01:37:54 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Mar
 2021 01:37:52 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <jhubbard@nvidia.com>,
        <jglisse@redhat.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
Date:   Mon, 29 Mar 2021 12:37:49 +1100
Message-ID: <3158185.bARUjMUeyn@nvdebian>
In-Reply-To: <9eef1283-28a3-845e-0e3e-80b763c9ec59@redhat.com>
References: <20210326012035.3853-1-apopple@nvidia.com> <9eef1283-28a3-845e-0e3e-80b763c9ec59@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec5b4c1-05fc-4af5-f2a4-08d8f2534645
X-MS-TrafficTypeDiagnostic: BYAPR12MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3160BB3E48F1E6702F889E82DF7E9@BYAPR12MB3160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhragVMbqO37SWVtGwR5BfyKPKepF4RnZHZIwCz6C+JPm4cy8LCPqhpnNqlUmzYdwbBAcevvJ6ybeDSdUswe59DSVoa18K8btOshjFR5ZFESYNoTo3ZsLwYf7ln9oZl27RQL708e1auVu62sG88BMBkmMs07Xjjv4/vA7GbAR7lRswrbe7Xv65hiY4Rv8bTgr7ohgPPbUyGlABCUlLEwdlEC0eoagMQNupAGLtvyld6HkVdGJaQv43nctbfKrMplVXGvH6tEdIwxGF5og6ZyYX7za+JWfrl6wMNYmR8BHyKNnA4qPRlnLZ54g4ppkTGMdFs3yqUORbzChH5mG8t50eR6aGJCN9chyxE2dUrh8Djh2kIjGZU47VlhjpyQcJrMOH1XWl2jUxOhEW5YZqCj2g33DXHJCru7QXK1k4Cqi3Gco4PD2pPaBw3sMq90z7fX7DY/PfOY+pF5QGsrGNhQQAyU6gU1V2P0JQR5Q6lzaaMTJXMxegslm5riBX9+g/qiGMiOusqALgf5FQaNjXAvNZoJokWbA7cPWoU2kPHdcLgU4l/Cy2q2qdasgd68UUEXamYS1gu/3pClaC+9lf+cHm1CLniR2W4ioR3wowoRZpNkxtY4mVJPmtACrXp1/lZri4Wr89hjxw4Fhxtsj/lriCCEctLv2IfaMiWvQTRZp+E=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36840700001)(46966006)(8676002)(36906005)(82740400003)(316002)(86362001)(54906003)(8936002)(9686003)(6666004)(83380400001)(2906002)(53546011)(33716001)(356005)(7636003)(5660300002)(82310400003)(4326008)(70586007)(36860700001)(9576002)(70206006)(336012)(47076005)(6916009)(426003)(26005)(186003)(16526019)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 01:37:54.4793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec5b4c1-05fc-4af5-f2a4-08d8f2534645
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 March 2021 7:57:51 PM AEDT David Hildenbrand wrote:
> On 26.03.21 02:20, Alistair Popple wrote:
> > request_free_mem_region() is used to find an empty range of physical
> > addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> > over the range of possible addresses using region_intersects() to see if
> > the range is free.
> 
> Just a high-level question: how does this iteract with memory
> hot(un)plug? IOW, how defines and manages the "range of possible
> addresses" ?

Both the driver and the maximum physical address bits available define the 
range of possible addresses for device private memory. From 
__request_free_mem_region():

end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
addr = end - size + 1UL;

There is no lower address range bound here so it is effectively zero. The code 
will try to allocate the highest possible physical address first and continue 
searching down for a free block. Does that answer your question?

> >
> > region_intersects() obtains a read lock before walking the resource tree
> > to protect against concurrent changes. However it drops the lock prior
> > to returning. This means by the time request_mem_region() is called in
> > request_free_mem_region() another thread may have already reserved the
> > requested region resulting in unexpected failures and a message in the
> > kernel log from hitting this condition:
> 
> I am confused. Why can't we return an error to the caller and let the
> caller continue searching? This feels much simpler than what you propose
> here. What am I missing?

The search occurs as part of the allocation. To allocate memory free space 
needs to be located and allocated as a single operation. However in this case 
the lock is dropped between locating a free region and allocating it resulting 
in an extra debug check firing and subsequent failure.

I did originally consider just allowing the caller to retry, but in the end it 
didn't seem any simpler. Callers would have to differentiate between transient 
and permanent failures and figure out how often to retry and no doubt each 
caller would do this differently. There is also the issue of starvation if one 
thread constantly looses the race to allocate after the search. Overall it 
seems simpler to me to just have a call that allocates a region (or fails due 
to lack of free space).

I also don't think what I am proposing is particularly complex. I agree the 
diff makes it look complex, but at a high level all I'm doing is moving the 
locking to outer function calls. It ends up looking more complex because there 
are some memory allocations which need reordering, but I don't think if things 
were originally written this way it would be considered complex.

 - Alistair

> --
> Thanks,
> 
> David / dhildenb
> 




