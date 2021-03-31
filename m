Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2953734F8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhCaGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:21:28 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:52192
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233706AbhCaGUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:20:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4yWcy2PRvIBM1REW7acVsz5mXP9oMrJQ1fXwhxWAUAHM1V7r+7BJP3OLBK/7zXavXWRWxrQOFBxetJa5xbGf8bEU2yoJLfvDWj6JCGgxYmr6NMYlWbttP83wlK7axa2x9W7k60bDtjuuUEIXjMPIrFW5t8Brbvx4IEg+6MHyRbzPmLNC0QNXs7+Vrub1P5l9PiUm+7FD1rOmGZUl2B3ErZQpcdMMbRI6nNPJN5z7Oh2xwWlRTp4n85qh8xrpyRuNvIZwR86eXxgxmGEhDy2ewgFzB3BIIz0U3fMkVM3GGhU716C+Con7Vtu2+x+iZThsIE1z03jgnImMB+AIRKWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZXSm+FXuSHvwWUARuqFj69vi3lj+DgW4UG1LNROHt4=;
 b=kapbg0x720M0fVtLED+g/l9LWatciLCJs4wymIn80CyXaPuxjBpP8H39/zYDd8Ht5j+8vcA37NTssQwIputgEAwTEX47PWndpKs8+1hust8mzM4DUprYh2hhX0g2SthMwfw/t8WtmeRFfAr0/rlYjjwTQ3rbYediRqcj4ch0YRKTySJliUSKb3flg6nQL+AEuzpnO9q0idWfgYlbI1yS/xKddfTNNgcHxWM2nINJrl5Ns1liZK+tXWPAKfel1jxRv4UCqED3K9CQw+TTIhkMQnraX4ScKt7sV2zMMTHOykuSCErj9ve2A+lNkZN6sHdkuExe8AP16mFzDCrMY2omeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZXSm+FXuSHvwWUARuqFj69vi3lj+DgW4UG1LNROHt4=;
 b=KYT8WKAwbu5W02vXka5f3EHNigawLnE2l1O/nfxOeKMOTJADPCkEc4kVR+gxUB3FULzNcqjWpnTauxlOBzykUe3hHptp/6YVwmM/cw3lSuQU1qq+Owieu2n5e/GruofILwnYpF9bA1Qn2/ZWRFbdf6iVF5fLkF4kqUfRBOeX7a2mV9uqvxSh2cRm1rTQ/XFMoP6Ni1pvs8IfBEfsNDdTPINFuvhbrmexIwsr9E4gfsFXKDhgbi9Fw79wzrpZ9tMqWLmiNg7yrje5xz4zOIS3/UTgZ+ehR+7kGvtnFqfjd8dBqE3ulVpY8Pe0gikit4n0F1t+HB0zqIDBrAtYdXiaQA==
Received: from MW4PR03CA0305.namprd03.prod.outlook.com (2603:10b6:303:dd::10)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 06:19:49 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::e3) by MW4PR03CA0305.outlook.office365.com
 (2603:10b6:303:dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend
 Transport; Wed, 31 Mar 2021 06:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 06:19:48 +0000
Received: from nvdebian.localnet (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 06:19:46 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <daniel.vetter@ffwll.ch>, <dan.j.williams@intel.com>,
        <gregkh@linuxfoundation.org>, <jhubbard@nvidia.com>,
        <jglisse@redhat.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] kernel/resource: Fix locking in request_free_mem_region
Date:   Wed, 31 Mar 2021 17:19:44 +1100
Message-ID: <12736273.ONR6GAMRWp@nvdebian>
In-Reply-To: <e910441c-73a7-b57e-1330-ead65c4ff412@redhat.com>
References: <20210326012035.3853-1-apopple@nvidia.com> <3158185.bARUjMUeyn@nvdebian> <e910441c-73a7-b57e-1330-ead65c4ff412@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3df7faac-2604-4808-3b72-08d8f40cfcb9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3622:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3622ACA9974AC692E977037BDF7C9@BYAPR12MB3622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jTvpdH4mUNhJ/3RSZcg/+r7N3xqIIrjO8bh2Uqg8KHdFqfiRUA5ghsKJ7+70RNTOZPTfE9sfOhUwQvry/3IrJEYCTblGVlUmD8MnJcb9A3arjxJwwvt5zWo5yrG8qQHmduo7GzyMMQKOihijyKbF5t8JiCbqYJbIdlGu2nd1MBJPilycn8B2Fz91+qrEf3Lz5ZpHf6rz6DgNQsfrmsbxAhZkp5oMIkEjeZKHbGxHufrXLPVrzF/6hwVKabsGgvWJywWbl0P97icK8kHKHGBebwNnR2Z5QRcX8xjVg33r5JvmzObxg5+Os41+NeBZC+nEgoUFHqqCJkc4VsImGMyYbGNyqB6bWyVzJR1JCoGEgxgI+RyFCWQhVPkz70hQrX23iwKxXL/KqeJx0CmKJz17dcm+XGgZtIPtBg6XNUujFjxNmqnx5zKAEKpBErQjzh5ZCWq6AiPvES81VFG4HI3MWpbj23M4CEugdjqBURmVdfecxXweY3hUH1CLx7Yho4HMJNgStoNS8dTW9MLpf6r/jaHcDEiHXPQP7DPNK+QIDLzBEEwkQW0pbq9Al/DVnxWJ+L25QCH+RF+rRolrSfUzqQKHm3k5ZaSwqgN84DftTa8sgCUrUlW+k5VGB8o88No72qxwiYYwWPb7NN9YnZwYNYYHfZjkZpCZw8EWcNMVqP7U4z/+ABUj48BJrHSQ3gU
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(33716001)(5660300002)(54906003)(47076005)(26005)(4326008)(70586007)(83380400001)(36860700001)(2906002)(82310400003)(478600001)(70206006)(86362001)(36906005)(7636003)(9686003)(9576002)(356005)(6916009)(8676002)(426003)(186003)(16526019)(336012)(82740400003)(316002)(8936002)(53546011)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 06:19:48.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df7faac-2604-4808-3b72-08d8f40cfcb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 30 March 2021 8:13:32 PM AEDT David Hildenbrand wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 29.03.21 03:37, Alistair Popple wrote:
> > On Friday, 26 March 2021 7:57:51 PM AEDT David Hildenbrand wrote:
> >> On 26.03.21 02:20, Alistair Popple wrote:
> >>> request_free_mem_region() is used to find an empty range of physical
> >>> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
> >>> over the range of possible addresses using region_intersects() to see if
> >>> the range is free.
> >>
> >> Just a high-level question: how does this iteract with memory
> >> hot(un)plug? IOW, how defines and manages the "range of possible
> >> addresses" ?
> >
> > Both the driver and the maximum physical address bits available define the
> > range of possible addresses for device private memory. From
> > __request_free_mem_region():
> >
> > end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
> > addr = end - size + 1UL;
> >
> > There is no lower address range bound here so it is effectively zero. The 
code
> > will try to allocate the highest possible physical address first and 
continue
> > searching down for a free block. Does that answer your question?
> 
> Oh, sorry, the fist time I had a look I got it wrong - I thought (1UL <<
> MAX_PHYSMEM_BITS) would be the lower address limit. That looks indeed
> problematic to me.
> 
> You might end up reserving an iomem region that could be used e.g., by
> memory hotplug code later. If someone plugs a DIMM or adds memory via
> different approaches (virtio-mem), memory hotplug (via add_memory())
> would fail.
> 
> You never should be touching physical memory area reserved for memory
> hotplug, i.e., via SRAT.
> 
> What is the expectation here?

Most drivers call request_free_mem_region() with iomem_resource as the base. 
So zone device private pages currently tend to get allocated from the top of 
that.

By definition ZONE_DEVICE private pages are unaddressable from the CPU. So in 
terms of expectation I think all that is really required for ZONE_DEVICE 
private pages (at least for Nouveau) is a valid range of physical addresses 
that allow page_to_pfn() and pfn_to_page() to work correctly. To make this 
work drivers add the pages via memremap_pages() -> pagemap_range() -> 
add_pages().

 - Alistair

> --
> Thanks,
> 
> David / dhildenb
> 




