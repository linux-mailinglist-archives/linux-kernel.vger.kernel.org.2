Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8465834721B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhCXHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:11:35 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:14304
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231272AbhCXHLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH7O8l2aA851k8wCoQPHKlADVD6S8rwNnTnZ0niml0j2SYHh8ENinS5U0jqJcO5Q+a2903MJ/GjmDHvM8rzR/c3bDN/EVHjpS9isDjS/hQ+/01TUIX3QZKrKq6FGRnLdifDysJDdxLGWbVM+ribWVeSYI1fhZciIbto/zEYhAV735T/Y+pfUwGAD+IBbgpSqtdSd2rX2JWBjT0YtLJBy+1E2yVYk9zAlXXqF5ocqXhZeP0TGluN6F2mnmqIr232SayDynetWaQmw1370934mp+l7EdZ/XBUykltbCRTmTkbQDqaZyWp/l82qy3Q2zImuBNSRrKIEGmDCurS0rtYNzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7VeeScmoMLSGZJEsFlNC9F+knY6ybldvtF8HGSnBmE=;
 b=Vek93sACFpB0MKGx3EFXZ+vZxWWbIgoF2OCEUl6jn7tVYsz9Pfn9PdGaKszQwdu8qvZdZ4NY9WHktdZO/8qjPhkBO15r2z/FlbpKJh4mDZ/7PKpGr160JVlNfHrYKhVj+VmRzDj+UPyPxT8m6Ze4VruxzA9OC9ZFBYlsqDf/3IM7JMXPeHFZCz0LL0xKv1BNE5ofyifqrntWlwbn2I0FtBzixAGCcLjxvnz3QnkyjYnnVTDLped+h3zGG7Nk6QR6lLo7R99d7LEMb1/9jrH/lAPDnxNxV883Jb0NgZ4f/FtZzWtfUmtAJ7/Ws/nkPKVo3y0oASq2p07hZQfOkTu+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7VeeScmoMLSGZJEsFlNC9F+knY6ybldvtF8HGSnBmE=;
 b=C/LspvQxXe4Jf9Onj2b2cVUIXkNekoc5UsYAqOoLDIFhwptbXqQlF0/bbcXShVnfKhpVBzWCPCBDgYQo6fHtmzu2SjuGu2A73E5LwrpHePFKrygrdzLt40XP92+4ZTNzHqnNFI7AE/zTxGVYVXZltVuYGh6y75gthAXrRZOEGWfbzD6oW2ByiRVjR9dEZAdmjj3E4sW7NGq0ARw94fr2ysaFoSqEVfZiu0Y+UlN0SJIPGEaAyvbugRkN5C50IlRVljYqope1K6e9fvT+1g4RKZ7ri+V9c+PTnWdHgpLjmpdWbXuQqg74Zv8pbMAJPn+hKvKcaxpzQZS+yWev4HB/1g==
Received: from BN6PR1701CA0017.namprd17.prod.outlook.com
 (2603:10b6:405:15::27) by CH0PR12MB5267.namprd12.prod.outlook.com
 (2603:10b6:610:d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 07:11:12 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::ad) by BN6PR1701CA0017.outlook.office365.com
 (2603:10b6:405:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 24 Mar 2021 07:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 07:11:11 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 07:10:18 +0000
Subject: Re: [PATCH v6] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>, <digetx@gmail.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
 <YFrRugjVLlazTNPy@google.com>
 <71b7914d-d9ff-2200-d6c9-6eab28499887@nvidia.com>
 <YFri1Qn1YorOPvsM@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e95534be-6cda-ca82-0ee0-a0a626e871ba@nvidia.com>
Date:   Wed, 24 Mar 2021 00:10:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFri1Qn1YorOPvsM@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd2c9d5f-dd7c-482c-db4f-08d8ee940166
X-MS-TrafficTypeDiagnostic: CH0PR12MB5267:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5267F9BE9CE1EC58CB7AC20DA8639@CH0PR12MB5267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw9dAQwm51MUFk8so3O6QclHPyIeiU9COTNSZutAd5yPYRRX2+2KUkdGOBa7Zz3Us7SODk1p6aTeitULRqLlFJtgMlRYOKi1FK+3xWXcytE2/CJk5pbHjKIf8FU4smozjNKFgNab/sPpSQDaqtNE7UeTGqreUbX7zTS3Kmvw4mlzpYtlvVc/cdKgksIi3ZeJSJhW7SEXQ0rtM+VQsPVa3O09dqx36w7YacylvKAG0QfoNDopQDyo5GqJ68v0d+5fcBi7FmI5xpKZY1qQrNv0004us6Jf+ErxKM3SL1ExDugdQe1xr2gHhbL3ve8aK/IJ3wiPRnL2WBg/+XgGPDf0pIHrVeGX7Di1TyKlstfaRRC0ePUnMj2Rtesd34joA7B0yI8tMJ7PIvZPURWFHeuh0qv0bqJ9jB1sxbF6j45Xreqaaz8r1+98ljd71EfulK3A/zmwVpO8uJJsXs17bWd7xn2gqAaPqCEkx0fJHgEfuEwL6Z6JLiUitx5YYOgSnBiwC8OORP2QQ4xU9XT7+3DXn+9lmnmZsTUzb2G3Ji5gXeMZ+MmtZJ6QJAsgi3kBTdCdFukqVH0RUCn7zj9en5M0jjTN2w6iQLLBzYdQHoGW0tXLvsF9+0GUW84gyeXUSF2jXpYOwnFbeSrcSCGwOX+tibRczgjifkI5oM4WAL2djJvzVtZtcXakErZDpqcSXph3
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(53546011)(336012)(2616005)(70586007)(426003)(356005)(31696002)(16526019)(186003)(26005)(7636003)(70206006)(86362001)(2906002)(82740400003)(54906003)(36756003)(4326008)(31686004)(36906005)(47076005)(4744005)(36860700001)(8936002)(5660300002)(6916009)(478600001)(16576012)(8676002)(316002)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 07:11:11.7404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2c9d5f-dd7c-482c-db4f-08d8ee940166
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 11:57 PM, Minchan Kim wrote:
...
>> , how about approximately this:
>>
>> struct cma_kobject_wrapper {
>> 	struct cma *parent;
>> 	struct kobject kobj;
>> };
>>
>> struct cma {
>> ...
>> 	struct cma_kobject_wrapper *cma_kobj_wrapper;
>> };
>>
>>
>> ...thus allowing readers of cma_sysfs.c to read that file more easily.
> 
> I agree cma->kobj->kobj is awkward but personally, I don't like the
> naming: cma_kobject_wrapper parent pointer. cma_kobject is alredy
> wrapper so it sounds me redundant and it's not a parent in same
> hierarchy.
> 
> Since the kobj->kobj is just one line in the code(I don't imagine
> it could grow up in cma_sysfs in future), I don't think it would
> be a problem. If we really want to make it more clear, maybe?
> 
>     cma->cma_kobj->kobj
> 
> It would be consistent with other variables in cma_sysfs_init.
> 

OK, that's at least better than it was.

thanks,
-- 
John Hubbard
NVIDIA
