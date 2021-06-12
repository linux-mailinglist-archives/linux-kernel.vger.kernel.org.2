Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26D43A4D68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFLHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 03:36:53 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:33793
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229942AbhFLHgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 03:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehrPL0bX7le80QfFKrYomHHL1r+tRWL+DOXxQ2/A2sg5MvYj8hn8/qP2PkrIowCaN3+Fwc7DfgkammtRceRVm4F/4JazE3Ni9a/EqrSNwRdAQFtG1Keok+MHT56BCWaWf3i6ILJMqxcUB6DKG48cDVPIaRoFSEnMGrPDothTbf3TgPAaXWWqn/f5mT2TPDmAWNb9MT3SvOGAV6llPixkOjnNTx4VvPeuc+wRA+42DES0NzGNhHl6qyWTpq4rdSr5wFJDLIke90OWVI50pQuRzBZfariX6UQwFng1y8LY8l/UevhnwKZAbuYkMY+nqcG3ZSelR0JrKrwPHgcoRx9Ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4l3J5n6OxIV5uydagOo1gEO1ZvGPHP7JIpaZ7tLcxw=;
 b=eZOshKpA3+bBMNnr/6Cfe9YCmdmF5x+T0kzDVeUxgTDd9Ko4QE98MBgiKJ41EikGCdg/xOr7qNLyoBrvUeqtDUE0UiIQkzKsI1+7CYOauUq9JbsUW7O+RIhpN/19qQzWxEkJMTyBjoqHZNPe+Ytb5a3uT+NCctM4HiewRryN28FmDO4o32l1mAi4cdLB4jz1w6Ny8zdljIt3yCon2Bk/c+X7WVJhejIG35pLV69PZk11pO1KWtQt6C3Out03QrLhdqNd7TMaFfOyKGBbF/y6Xp6jIIFqeDt+FCbvcHjTFFkr/z3DsBWFCF4MhE1JEb0Qn0K9Cmy8Mv96E6O+ya8e/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4l3J5n6OxIV5uydagOo1gEO1ZvGPHP7JIpaZ7tLcxw=;
 b=rUCjHvdstqeEqD3Exwmvxp4j21g2CP59OGXw3emM7Lzo9kIkRfkHmg0PxudbosNg97cDA3zOiJI/5TuRuzLpOHTf+WrY+R7kFEYeoWJG6ofTPLTfPadUXONPphSkqIBO+bGZNvA5i16xjNZoQv+HsBZ1GD/VVKVpzG4bp1TefVkG507mlW2zE5vkiae9pJ2Kip+Wu3QaPziK+M+cgxYGWen5uUxHQmxGAXVO3Z10k199wk+kpvc97yf9y+nby/YzW8CRpvKKU0VKKZpCb/sksux2S4Sf2sahmB2UPYEpPZPdO+mrZGCWfZaCXn0UV76EniwffX3qdibbMDKH1p0NTA==
Received: from MWHPR2201CA0050.namprd22.prod.outlook.com
 (2603:10b6:301:16::24) by DM6PR12MB3980.namprd12.prod.outlook.com
 (2603:10b6:5:1cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Sat, 12 Jun
 2021 07:34:52 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::f0) by MWHPR2201CA0050.outlook.office365.com
 (2603:10b6:301:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Sat, 12 Jun 2021 07:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 07:34:51 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 12 Jun
 2021 07:34:48 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Naoya Horiguchi" <naoya.horiguchi@nec.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] mm/thp: fix THP splitting unmap BUGs and related
Date:   Sat, 12 Jun 2021 17:34:45 +1000
Message-ID: <14130393.9bCoogeq7g@nvdebian>
In-Reply-To: <494c929d-5253-58b0-6329-dec8395199cc@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com> <1697169.ADtCEf3Xva@nvdebian> <494c929d-5253-58b0-6329-dec8395199cc@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94595507-6edf-414f-d7f8-08d92d7490b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39800A99A99537807C51FD4BDF339@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30loumy0/0q9zwM2jYF7AzxAybcS+nsggXA1NAnlWWhpluYL0Tzdzvma0i5e9LUFseR9HVH2FgQOZ8Rkn81OeKGTNuYJZtCVGsVUlv3KgDm+wZ11Phw4AsDiYLwcnMxdPKtaNoF3Eap4HbdJzlU1kIEZjGQx4AtDtYomTxO/wtQjxfccL+IL7exlAo99GuVtzRR3boJiaR1us/2QH+KEj0q7xjmfbVzToDc1M4m0sHJRFRvFUCn/ZHiYQRfXfG9tLbJTx/eD9761mNgH5GtwWWSWa7Ldqwc5DfCXSR3bemeBjJhrASkZ12ssMshidcPw5iypQm3Uz3neLzwjp3fj+VuCOlM1iwZgvyHGFs770u3pXaHCdHdcVU2AHTgxUPkKlTWPb67XYFGUzBnW7LqH5nmTWwy5so0IJjbjS3YkcZbzMQL6fn5cPTrdRJsXHlvQqnhJxkKvld6Xvj/LY6NDzL7q0z4bxhFDvFC+lc4ccxu1Wn24/PwmwRlKPtEVwBi5yLdx88AS46E7mmdzKhiUZ13b7TuffLTjz9rsqbtEawx4qBrJlQZh+FTEROiYYPSI7OX53VLJFawWHbEW3HjO8vdiq9hhs2gABMrveqFHa00wVRXravOtW6znJCYrDcZwJrJXtlnrX6pHeBwK57Gb+SubqE82RXX9qeL0tAcCHbQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(36860700001)(426003)(9686003)(336012)(7416002)(54906003)(82310400003)(82740400003)(47076005)(6916009)(16526019)(186003)(478600001)(8676002)(8936002)(4326008)(83380400001)(26005)(36906005)(7636003)(5660300002)(356005)(86362001)(2906002)(316002)(33716001)(6666004)(70206006)(70586007)(9576002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 07:34:51.5116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94595507-6edf-414f-d7f8-08d92d7490b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 12 June 2021 6:56:36 AM AEST Hugh Dickins wrote:
> >
> > As to sending my rebased series I suppose it would be best to wait until
> > linux-mm has been updated with whatever other fixes are needed before resending
> > it based on top of that. So far rebasing on this series didn't require too many
> > drastic changes to my v10 series. The most significant was to incorporate your
> > changes to unmap_page(). The remaining were just adding the TTU_SYNC case to
> > try_to_migrate{_one} and a single s/migration_entry_to_page/pfn_swap_entry_to_page/
> > in huge_memory.c
> 
> Yes, I think that's it.  But check your try_to_migrate_one(), it may
> want the same range.end vma_address_end() mod I made in try_to_unmap_one().
> 
> And does try_to_migrate_one() still have a comment referring to
> try_to_unmap() when it should say try_to_migrate() there?

Thanks for the pointers, I had caught both those as well.

> I've now located the diffs I missed from sending akpm before,
> and diffed the diffs, and those are the points I see there;
> but sending them now will just be a waste of everyones time.
> No substitute for me checking your end result when it comes,
> though I fear to do so since there's much more in your series
> than I can wrap my head around without a lot more education.

The first few patches in the series (and the ones with conflicts) are
clean-ups, so shouldn't change any behaviour. I'm reasonably confident I caught
everything  but would certainly appreciate you checking the end result in the
early patches when I post just to make sure I didn't miss anything. Thanks.

Also I have been getting bounce responses trying to deliver mail to linux-mm
in case anyone is wondering why these might not be showing up on the mailing
list. Looks to be some kind of mail loop, but not sure if it's at my end or
somewhere else.

> Hugh




