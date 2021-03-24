Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04C34844F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhCXWBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:01:50 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:36512
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234910AbhCXWBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzckYmxxujtsPhdI5cyZp99+He9xIi0Tk52tJB2a6NhEEZYcf0FxqzjMm4he5LdmdL0eUwPMdjAF5Nd8XCViXjA1tQCw0SIDYY9f43MfHx2T6w8nRkn1NcEFP+CLSHwtKie9ILZNfHt+vlNfdo5+Th1jaEUYKx/AG293dw6ayiw8Gpc5FINqTUJefVdrG09Ff/YSJvp3s3KoC+k0PtKOOrQw30BYKdm8F6VUX3oT5uOu7V/IZ5YrQDF2kBYD8b69L9eqiEC7nvl+yFMIxVf7k3cBdPH5Ka/KNWIdRmoSOw3IluYzfatYVkgleWgJYsVywcYn+egg/3UvnwXSPeGxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3wf/C+nkQnxo/jTJYLNsGMaEAmecW1/CfReKCA06t8=;
 b=XYbiSRyJwUFQUkkoyzZwHvMgvtILTHCVqE00s9bXvYAyYTOCLQahaPYDXrikb3A+NOtSM21ube1m9XN+QhAp+CDVrXr9YsvhOV5ExGa0f8A58nNWjyRezb9WB7+1MsHnEAYh8u8FKIojbLN609WXjD/2kDIzanFel4p//uSu/0twCS/i0Ug2C+xC96CWC2KtxjapjBCHHiv3pQcJFb9iPW0t0hctIsxULuaLo6EmYoumHU7MMxF4OSKSoxTU8uOg99OwpdexuT+W7UMMU351Na6s8Gto8Y6rjhLWr2x0NqLg0X0cT/2D3K1I+OJxRmNgmp5F+bTiWk8Su7jzYN5t5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3wf/C+nkQnxo/jTJYLNsGMaEAmecW1/CfReKCA06t8=;
 b=tPiFtCDc5aT8+RCX5EqRbAZ8Kn8NwLGjAOwFJHF8wMyRQ5lGr+X3OFGn2s6rL4uON2La/FOPMUv8tLR0VvOxLo360NBphZ24hxKDQTV+xYIQXyRD6DN89XXq1DWQkkXJWdR7UVLSit628AQN+fqcFdHd9lfsBl+DkCTbbmN4ThlD+b844eCoug1xK83Ejt09jmUimuDzZiZV85Z0HivhjbpgC9ZqfkdygYoV2nu5gg5VNf60Agq6/rVPCkB0Bni5OJP2/87mwMtii7W3/i22wF+/cLYBJW8bFxRZckmfjobgy1JjJSkQmz6sEBsebgIFfOYgL72e0w0QP8WN4XNZYg==
Received: from DM6PR04CA0005.namprd04.prod.outlook.com (2603:10b6:5:334::10)
 by DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Wed, 24 Mar
 2021 22:01:32 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::84) by DM6PR04CA0005.outlook.office365.com
 (2603:10b6:5:334::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 22:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 22:01:32 +0000
Received: from dhcp-10-2-49-164.owa-p4-only.scl-ca.nvidia.com (172.20.145.6)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Mar 2021 22:01:28 +0000
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     Dmitry Osipenko <digetx@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0ac4d495-eece-fb71-d334-a46e069b0c35@nvidia.com>
Date:   Wed, 24 Mar 2021 15:01:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9360be-a2bc-46cf-58e6-08d8ef10627a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3324:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3324E45DD01CD5C217D717CCA8639@DM6PR12MB3324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwiYx1s7UZTkqqmXlmSrPvUas5JDBRTrt5tv3vi6SYn+WT/KJQ6eBI3MWwuoYU+dFV7+66dyM73LoC07QJersA7oJUuS/KSBrMQZj6tWLRbR4qBGE7YQNMj4ZFAfc83gtg2JvYW2oifmCiPtM1h6H5Q96XWhjFDgu+sHMjQzEcHNcICQONpX7AFsFHpzzLFM88W7/dExRJpM5TWt3kn9oPmrQ8UGkgv5xKTvE3Mwx7JPFswrJRMrD5sLDjgUMSlALGBrPzCSKeSaaSt4ySWxnDg+UrCK7XR8ijsD4+clr3D6QaifAbUXN0ksyZJjQ6InkTHlTNpcUVwLk1Ts4OTENqLilSkBC+H0UVO/6cDfo5tcYQ1KBV61ohjfsPnZ3OhNy/fEdllqUtTYfNaPTsFId79ispxajNbzFKxqzB+1/JW/QRjiy5yWtANTcRSExZXvg2wDI+F/3lJDjEl09nxDPjafnSCeqzau7QhXi1XfKbjy0G5Mx9rFP+isubhOmxkJXcewQzjuHZ3h7dAIyRxSzAY/fHBR/v+/+RKK8gGhZpXgRmNLFMe63VzFl1X0K8Gctb0vqjYe9LiZ8Z/iB60Py5hNv3EaPrEmEjk6wPBqkPGc2iMAiLH3KFui6+EvW+7Jlhde+EPdUjByFHoidB7C5iQL7BsWrapFR63aYDFy+XybXKKmb0PWtZ7hHLBqPoyT
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(356005)(31686004)(2616005)(426003)(4326008)(4744005)(7636003)(186003)(47076005)(26005)(2906002)(7696005)(8676002)(36756003)(336012)(8936002)(82740400003)(16526019)(54906003)(110136005)(36906005)(70586007)(53546011)(316002)(7416002)(5660300002)(82310400003)(478600001)(31696002)(83380400001)(36860700001)(70206006)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 22:01:32.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9360be-a2bc-46cf-58e6-08d8ef10627a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 2:31 PM, Dmitry Osipenko wrote:
> ...
>> +#include <linux/kobject.h>
>> +
>> +struct cma_kobject {
>> +	struct cma *cma;
>> +	struct kobject kobj;
> 
> If you'll place the kobj as the first member of the struct, then
> container_of will be a no-op.
> 

However, *this does not matter*. Let's not get carried away. If
container_of() ends up as a compile-time addition of +8, instead
of +0, there is not going to be a visible effect in the world.
Or do you have some perf data to the contrary?

Sometimes these kinds of things matter. But other times, they are
just pointless to fret about, and this is once such case.


thanks,
-- 
John Hubbard
NVIDIA
