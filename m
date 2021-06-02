Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3187397E71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFBCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:08:55 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:10304
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229654AbhFBCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiMv8DQrg8IAfN8OhGEFI4PagZOxeTM9JUvHPtd19vw+QiuQFNpx07uLPtJWhOWMbWrLlOVUwI7A0RpnQtzvXLBgNW4X1kWOfabk92N/dUS+pVYNXD6P6jpxTYPCkTUhjyCw9HSGAQS5nqRUi7Yy++FhotEejRgaAeXar+6S2e1YNUrdrV4krMfPxFl8Um9oewWV4QIAejEk9oKZZhzfQyGwSK6JjzyGtUfrJhBZp8+9QZanHsSANHw4JEsmD9CFKO5PETAtd8/MKpOKj9jOB+ZPQpel0xhZwnv065/E8KU20NDqADYxJ7c+EoSe1FfCrut/pQ+6iUdyyQFhfwyLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJQTd7AvRqQgNo8Hp3kW2b8X/6q2JIuN5h+lK6j0hw=;
 b=juAwm2fqqEDnV6iuCAuXVBJR4XhMogcm+D3e9UAZLrbg45m/YcMBDs2YoNhokVB34Q/AQq1zo/Zic/seRBclNOQZahvbqgSFYKO/XOZyVYDifnEqdCE8EjEzqpTTJJKWqTduJKivEtMYSHgz6mT+dR44+8cZhq7JiSQpdY+kZRn7MWRn3tWteYNXKrhPHAEGR+fzYvTN0kr0b4bEYUN+sDi1cuj/vuQ7V9UJC+yVVu7/CLv/L9pAbsUxvCQEHWS1prqj0vJbktGNZwbAmEK1UlW71Cbr5VEiYeTUogoJITXq5vUvs/nlkVYjx/qP0RwPkzA0q1nH7MKunrLDbNx7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WJQTd7AvRqQgNo8Hp3kW2b8X/6q2JIuN5h+lK6j0hw=;
 b=Dijy2BbCEB1VSUwhaAduN+eXaZQHjml7Pjkh2OONK29F6/LfgNV6QOfLuY677v87TGuge0lv8XNltjC7jTxvdb9jH/YjLU74zq5BobUfgbztUN4nBCOrvt+Jl755j8harJHUDgwR5dUl22SfohIzHrsAdds5CQnA9SBb55ab+N/3ihro5Eu2amMzDs8QMRXSmwKk5gY6Kz4xCFW9g/PjwkY/6n/hq1vowsEpizAil5YKeGmFNA6Cv+CXerwr9lQfIVbapp2xbR00mYLRar6jmsHBUzFWSvBEFu67TJmNBB8Xscgaf3y4/bmqseiszHJQ2PKjRm154n1LeN45mFkFqA==
Received: from CO2PR04CA0134.namprd04.prod.outlook.com (2603:10b6:104::12) by
 BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Wed, 2 Jun 2021 02:07:10 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::db) by CO2PR04CA0134.outlook.office365.com
 (2603:10b6:104::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 2 Jun 2021 02:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 02:07:10 +0000
Received: from nvdebian.localnet (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun
 2021 02:07:06 +0000
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
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] mm/thp: fix THP splitting unmap BUGs and related
Date:   Wed, 2 Jun 2021 12:07:04 +1000
Message-ID: <2748366.Ij88iOltre@nvdebian>
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53316702-5e59-4c65-4cbf-08d9256b2178
X-MS-TrafficTypeDiagnostic: BN7PR12MB2692:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2692830BD528885B15D104B6DF3D9@BN7PR12MB2692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PF9wKyxtHrKvworh2zpXTMbZaxY6dwuJ7LGySHLQdlxE1lAASET5oKB8b/+/mRby2IPXKpo1s7Awq9risXF0dni8bUkWRgqZe3Z5ftdXMI2Xe4EZR33/aFix+h+0/yfrvxjB+In4iqxr+oh36LNm+bHePqbneK2cDKNLlOb0LeGgVjTJ8BiIzln3r7a+Dgj8yG5spMKXw+V9kyJpANBAI4/4Ot8N7hhm1foA0abyy56tPu9IDt3t3sfVGD/RUrxqGIx0Ws1yGr2TsbB6Hx3HablTaYCPqH9rR/wo5FGFZ3GXHAGmrbjeGwsv91g06P6QM57KYyB3PTy+Owd79GTiSQFj9xJboWO6NtKuuITI7TH2ojS+6i/jlTBmejTQcfxFetaQ0Unw+AiPa35i9fYxsFUztXObgmsNDKyBbL4KyaDKGe2HWYhgeeB2WPXuaMWDH5oNJBhUpNNv6jdg+0Xn7yZMt7y9d+NJOohfuQoj/kxRpduiz0sqGIYX/isKKjIdJV+upiUvhLcXkgpCbp0Q+gB8CRDdtmDGaiQZ34xWO4mTH1KaGejm4gFHvfznNgewxMNruZHNe0cTYCTHZPs8ELG5Frt6vqxA1ZSMqYcOllUl+YSV8k9TIClWMd5dF2nAaizptBN8xQF7x/KuPQkmVw/f77LAUHvoA4E9onKnhaltmWIBrWGTndPZPesFsjyYHkISQAMoNnNMaUxluNfxmEQ+x85mdOM266g/QvWyMQZQa/Bvrh3DF1EdfelFxKATYWw4+JLS/7DycHQar+60VHcU+fyQIQnvU+QhJ7vagVg=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(2906002)(54906003)(356005)(82310400003)(478600001)(336012)(47076005)(36860700001)(5660300002)(7416002)(8936002)(316002)(36906005)(70586007)(9686003)(8676002)(82740400003)(86362001)(26005)(16526019)(186003)(83380400001)(33716001)(966005)(70206006)(6916009)(426003)(9576002)(4326008)(7636003)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:07:10.1796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53316702-5e59-4c65-4cbf-08d9256b2178
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2 June 2021 7:03:30 AM AEST Hugh Dickins wrote:
> Here is a batch of long-standing THP bug fixes that I had not got
> around to sending before, but prompted now by Wang Yugui's report
> https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> 
> Wang Yugui has tested a rollup of these fixes applied to 5.10.39,
> and they have done no harm, but have *not* fixed that issue:
> something more is needed and I have no idea of what.
> 
> But at least these clear up related issues, and should go to stable
> (except for the last, which is just an optimization: it would be
> fine in stable, but it's not required there).
> 
> These are against 5.13-rc4: easy for others to try out, but my next
> task is to work out how to shoehorn them into mmotm and linux-next.
> 
> I would have said just before Yang Shi's related
> mm-thp-replace-debug_vm-bug-with-vm_warn-when-unmap-fails-for-split.patch
> except that (which should also go to stable) is currently placed after
> Alistair Popple's "Add support for SVM atomics in Nouveau" series,
> mm-rmap-split-try_to_munlock-from-try_to_unmap.patch etc.
> I expect I shall offer you some rediffs of Alistair's, we'll see.

I haven't looked at Yang Shi's patch yet but aside from patch 2 this series 
applies on top of mine fairly easily. The only other issue I noticed was 
needing to rename migration_entry_to_page() -> pfn_swap_entry_to_page() in 
patch 1 & 7 before applying.

> 1/7 mm/thp: fix __split_huge_pmd_locked() on shmem migration entry
> 2/7 mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM splitting
> 3/7 mm/thp: fix vma_address() if virtual address below file offset
> 4/7 mm/thp: fix page_address_in_vma() on file THP tails
> 5/7 mm/thp: fix page_vma_mapped_walk() if huge page mapped by ptes
> 6/7 mm/thp: unmap_mapping_page() to fix THP truncate_cleanup_page()
> 7/7 mm/thp: remap_page() is only needed on anonymous THP
> 
>  include/linux/mm.h   |    3
>  include/linux/rmap.h |    3
>  mm/huge_memory.c     |   47 ++++++++----
>  mm/internal.h        |   54 ++++++++++----
>  mm/memory.c          |   40 ++++++++++
>  mm/page_vma_mapped.c |  163 ++++++++++++++++++++++++++-----------------
>  mm/pgtable-generic.c |    5 -
>  mm/rmap.c            |   39 +++++++---
>  mm/truncate.c        |   43 +++++------
>  9 files changed, 266 insertions(+), 131 deletions(-)
> 
> Hugh




