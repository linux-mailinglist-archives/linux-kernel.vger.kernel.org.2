Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C040BE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhIODW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:22:57 -0400
Received: from mail-bn8nam11on2075.outbound.protection.outlook.com ([40.107.236.75]:28448
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229758AbhIODWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:22:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adJKUoW8Rb2zuHPcxHUKarBOLMxW7g4BpklnJZxZijUa8oTQiAIzB+sv/VZY2q3ltr8RrNoUppGYJQ13ue9df6Rfl2FQYI+FVDFQYcK5h1BzTQD/lc3eB4j6bm+5xAQiowDEeyVsY26myPkPO1e2iSMHKdI/mRz1C153OfsWFHOAthkfTcNnEwC5JpdkvE8CtvQ+njnj/4WyBnGpUEjdEeiZpQab2iDBOFdRIEXIpyLA5syCqKUDvvpqY8UDlUX5xlUjxWaQcWhautIJPhnU/5w8i0kxKZw+oxto/84Xw5flHOk9N+Z0i4pIphkxzE+b7ctCPlwKCb4f/aMWZYwQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GhVC1LP5g9oA6KCnf1yCs6n4LFkK6iyH9itabp1ihkY=;
 b=LVRHYEYOu04z116lal9Djs31EclV6pLPEOOf73az4D/fPfl3bpq82jUAfZd5ik5q0Ky9U2i7tnvS5RS9tlgUDqR//8QT61UetYfmz3+NT3OPJnbNM0bKVasLRZyyg7S3P8LTdjJWnlxyIhgEwzr8BKVJ3B6ZVxslEckbd9SeRbFMd3h7MN3xMCU6ov18wX1P3bjTNkWjCCWVaiJbxiLLAI9P0mEnJ0+f7246QDwIEix4usx/8Q0vbZcmcP6+ONBtITecQLZMUEh8cK8YWgCs/ckLcVs7GkkcFouwK4apz7HJjSMlgLIW7Mxj9rRFC/jG6T7m63JB6OmpZgWagzJIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhVC1LP5g9oA6KCnf1yCs6n4LFkK6iyH9itabp1ihkY=;
 b=sHlS4S8F21OzqfOqzdTMetVS8ori3phUKtJTi7jiNIL1F3r3cc8As5brieGsTzIdC4+oEaMhpEo/Uc/Ck6KsoGlyU8omQQguqB9Pe9iqiqyVIregsTFpJ7xOHCprffMocfi04hzfAgjwvgkdpkmVaLGazUACL0YhGeSjVLoZc+pVjW8oFMHGLFc0BzySRdK/6G95hfoWNHCQTOapfPKRPG1AyEslmBN7AJGQmlJOacblmNDBAP5Xhw1pFQ2b7DadfcwQrAzYpfTnXJmNJf3fn/3i0CeDi65BvwW+bdzBBMeLjslcLo4/HU9EPFJc9h5h93Xz9d9Eb3Gv8zkAJ3JgLA==
Received: from MWHPR07CA0020.namprd07.prod.outlook.com (2603:10b6:300:116::30)
 by MWHPR1201MB0240.namprd12.prod.outlook.com (2603:10b6:301:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 03:21:36 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::8e) by MWHPR07CA0020.outlook.office365.com
 (2603:10b6:300:116::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 03:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 03:21:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 03:21:35 +0000
Received: from nvdebian.localnet (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 03:21:32 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Date:   Wed, 15 Sep 2021 13:21:30 +1000
Message-ID: <2497776.C4p5gPNQJS@nvdebian>
In-Reply-To: <YUFgAPJJxy8L4GMP@xz-m1.local>
References: <20210908163516.214441-1-peterx@redhat.com> <2576475.WBpAVSM2eX@nvdebian> <YUFgAPJJxy8L4GMP@xz-m1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ab708de-cdf1-47e0-ab0c-08d977f7ec7a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0240:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0240BC7126D17C77FD12EFA9DFDB9@MWHPR1201MB0240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7g3DaiPJoDw25oblzyVYaNla1nofol1CMqh8krkM2+IKikNNxtgjrLhsU6oMrzT5p1NQx3m+6vRZsx9Nrxy9x8ML3wCDGwHj746KbfrKls6e9z+tXnUHrbAw3Ew6C1+KYx3py1W0eVSHwYD5FgJXbsDq1BXELWfWTNBM96A8PmZlmpyyDOXlSbGAtRC4Pf3BarGgFprvdcBVoRQSXFxCNyODn7re6NAhJNsE6Q4Ct5e9dgQvY1l5GmQzmtJ997Ti/0TYi7XllAUHboum5eF2NCqYTZFlQO3+pn2HsJNrzGTZGnUjxxi1HWYXSiGxGWv6Jy/8/AWGR7Tk8sCFoG03Baa4018TQ3V7RNVCp6mGEPLEoPC67gIE2IKlWFQkdi5CiXVPJguFXLqSTd2bsIkkec4pQqLcwAhqF8o7toCuDhFv1Qofd8BaOw3wZKBiTgyiUOxrK+GKElcvwRo/KX+bHQsPhmEtAyfP9yiVdNs0E5HAPT+wqO/F6sdy3hCqvyi7NDKwsQXjA3m/fsPOt6XomxOKDhX8LqzqaxVB20EyJBv7Uv25x2iD65+o8fjeNv0T+973xZa1XPTQdFudffxUDDS/4wULZJioKJFNUTe31MF81BmORINBhFXvw1aAEMDMbCyPd1Z1Ytyut99b3D5o+0LfUN6K6g17aswg+z4YAfcXlaHc7nK8pmSMFkyW4uO9E1wVmjhAIZIuBYG19hyDASA/ePk6l+vu5SY7PN0/4So=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(86362001)(478600001)(83380400001)(82310400003)(5660300002)(82740400003)(9686003)(426003)(70206006)(36906005)(186003)(70586007)(2906002)(316002)(9576002)(54906003)(16526019)(7416002)(33716001)(4326008)(336012)(36860700001)(47076005)(356005)(8676002)(6916009)(8936002)(7636003)(26005)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 03:21:35.6656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab708de-cdf1-47e0-ab0c-08d977f7ec7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 15 September 2021 12:52:48 PM AEST Peter Xu wrote:

> > > The flag introduced in this patch will be a preparation for more bits defined
> > > in the future, e.g., for a new bit in flag to show whether to persist the
> > > upcoming uffd-wp bit in pgtable entries.
> > 
> > That's kind of the problem. The patch itself looks correct to me however as
> > mentioned it is mostly reverting a previous cleanup and it's hard to tell why
> > that's justified without the subsequent patches. Perhaps it makes the usage of
> > zap_details a bit clearer, but a comment also would with less code.
> > 
> > I know you want to try and shrink the uffd-wp series but I think this patch
> > might be easier to review if it was included as part of that series.
> 
> I posted it because I think it's suitable to have it even without uffd-wp.
> 
> I tried to explain it above on two things this patch wanted to fix:
> 
> Firstly the comment is wrong; we've moved back and forth on changing the
> zap_details flags but the comment is not changing along the way and it's not
> matching the code right now.
> 
> Secondly I do think we should have a flag showing explicit willingness to skip
> swap entries.  Yes, uffd-wp is the planned new one, but my point is anyone who
> will introduce a new user of zap_details pointer could overlook this fact.  The
> new flag helps us to make sure someone will at least read the flags and know
> what'll happen with it.
> 
> For the 2nd reasoning, I also explicitly CCed Kirill too, so Kirill can provide
> any comment if he disagrees.  For now, I still think we should keep having such
> a flag otherwise it could be error-prone.
> 
> Could you buy-in above reasoning?

Kind of, I do think it makes the usage of details a bit clearer or at least
harder to miss. It is just that if that was the sole aim of this patch I think
there might be simpler (less code) ways of doing so.

> Basically above is what I wanted to express in my commit message.  I hope that
> can justify that this patch (even if extremly simple) can still be considered
> as acceptable upstream even without uffd-wp series.
> 
> If you still insist on this patch not suitable for standalone merging and
> especially if some other reviewer would think the same, I can move it back to
> uffd-wp series for sure.  Then I'll repost this series with 4 patches only.

I won't insist, the code looks correct and it doesn't make things any less
clear so you can put my Reviewed-by on it and perhaps leave it to Andrew or
another reviewer to determine if this should be taken in this series or as part
of a future uffd-wp series.

 - Alistair

> In all cases, thanks for looking at the series.
> 
> 




