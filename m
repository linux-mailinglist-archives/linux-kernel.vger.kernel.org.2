Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9786E447B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhKHIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:00:55 -0500
Received: from mail-sn1anam02on2066.outbound.protection.outlook.com ([40.107.96.66]:52385
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhKHIAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:00:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE+XC9m+dgRB/oW4q7L49TYZLSCmbAvI8HGdB9UJsbLI5AWD97jcZa2yoMmFaVJx2dKIIrC1wRvdYO0TgjkHrCFsSOk6MyXGux8qqOqNmd24VKiQSKdNqMXcLqCGWvfeejGWVk3290EJFeahBds6WOzw0f0htvxRmZvmCUcgXW8vr1HLVYeCWL5M4q1fWZpITPJhlGSYL+PeXMBMKsmLwqfq13RE35bGqZA59rcINx3k8FZ9rnyw/FxUgy8TiQwas1giivi+Kmyt/33ev9WpqNackXo8VH2FazXVumq+DUNV/hGmTK8YzPBUxItYfG6/trzpCv0B2uR4fHhf8bDVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eem2xtwvxX72CvC8NKf5kLDM5r5eykG++19d/b9V2kA=;
 b=S9qVkJwJJW/r0yuERpcfl5a5BNwPF3kqKYvCy0x0KxZUh+G+MOnVlBFP1fZRcQd1avq3AGhv4Odg/Ighw3OHbqX53MWwlCPR+PYN0gRmQtpcH4U4S8cExz2Wq34V4G0QMs3HE3fMiJWpm6a9sPu5qCYyRcpRAKYYUrqk5A94S4yJ3rGhlWuLE71deNTKiE6c3w0w4LD3tHk1ONVfCXN7ryn+xSjiGACb1iwyMWNBuoCF1TAYAwPDj/VJsemyQusrYpX/PeIm6hy4KclAmRPu+g+HoNabDb9sGB7m83BlDJC2Hln9jYaM/dZJA127iPCf6PmeW6HjHkujekgSE2oh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eem2xtwvxX72CvC8NKf5kLDM5r5eykG++19d/b9V2kA=;
 b=ZMEj28e/t0vRga1gbs1N/oZAfjKjT9Gcq+pCYmXIZVsbRCvkgUK8RbcgodK4loXiqwAUONfc4wkpkG45ArYa+L5in/dzft3MW9UC3DSyO1C+RZg7WrwTPNAJShLJ1F6K2FN3gbHAWHo1dLEKlLZcbbhBWcqZeor62vJ+ob9ogAxSNb41YxycQCtO0CDwJRgE8pGJmQJaFLFBnFZ7BdKS1XzT4adc1cgkYm0Dx3n6kyuliR4O00Rx4dR8evdl9Y0XK+eh8gunQ4nsXDGAScPerezXXh9P2/onD7Bd/mtiWIgBBT2bJWQMIxUHrlBlHPtqXy/4gax6wQLxwKkrpGvUkQ==
Received: from BN9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::8)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 07:58:07 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::a1) by BN9P223CA0003.outlook.office365.com
 (2603:10b6:408:10b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Mon, 8 Nov 2021 07:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 07:58:06 +0000
Received: from nvdebian.localnet (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 07:58:04 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <akpm@linux-foundation.org>, <jglisse@redhat.com>,
        <jhubbard@nvidia.com>, <ziy@nvidia.com>, <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault
Date:   Mon, 8 Nov 2021 18:58:01 +1100
Message-ID: <5535346.2Y9IAguWGx@nvdebian>
In-Reply-To: <20211105122557.GA2744544@nvidia.com>
References: <20211104012001.2555676-1-apopple@nvidia.com> <20211105122557.GA2744544@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab70f436-8613-4121-2c87-08d9a28d7fcf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5096B47E96FBCBC728C59120DF919@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHlKPvWMRK00buembhi59nboGFnMPje0i5mkZYu8See6/uMTDBW0QuosyD2vLWm1Ld8WkfBbu/HYbcJE4NXtDUS555WHuQ2QEPEX4FVkTgJY+N6KjVxzUNgPJQZHVvbmMAUV08NtBHMrEi1X9dVdxTHHzOroHuseJJd+zw4k1affxJ7oAOsFZwLJwFcOVc6wj0FTFWOvNAfFkMOnYSTG92SUKES7dCebce/LrPSgEAu4vUaxecAC0odaA5z9v+O8mUOycSFn3SzjpiEg3ZCusesTQxrrcJGWg51i67BXL31Q+E9mEfaTiT6eQL4qx+oXUTP7hISp7X1R9ln3kokUCAOwIZIaQyGl+zY5fSqHgLUY84aTZaJS1nO2M2YVzQ2YLHxZnxAsKCasb2puEerhP863PJt6/iaS4xKPH4fbCg0FazgDG0Z2isQCsX8EIXg66OEsulv8/EnXwc2MHMlSHpxOit1C/sNtpdr17xNoJ+5h/jv52I8yUMnfwYAoXysirrDqGDCm+VR32VXdPLs2ogFEUtzQsTOCFMhjnZHudd+pi1E22+j7jQy0B6k2/JqOgqUk9wLqhpIf15u0R0zhvE8bbDd+8Rzq0ByoGaNSpMrqMoGhdcHzga17UO6ohzVGL1f3bBpiG9sRVd+bwQHyGDjEEyMw/y/4U4ZxqMNWqLbc5CjdZ2HDSoZy7uTZuZWxgqByM4kVtaVB7vnBG6DtLw1QtMT+51sW7bukvYZTRXw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70586007)(6862004)(16526019)(8676002)(70206006)(7636003)(356005)(4326008)(9686003)(9576002)(8936002)(186003)(82310400003)(26005)(86362001)(336012)(36906005)(6666004)(47076005)(5660300002)(2906002)(36860700001)(6636002)(54906003)(426003)(83380400001)(316002)(33716001)(508600001)(39026012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 07:58:06.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab70f436-8613-4121-2c87-08d9a28d7fcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 5 November 2021 11:25:57 PM AEDT Jason Gunthorpe wrote:
> On Thu, Nov 04, 2021 at 12:20:01PM +1100, Alistair Popple wrote:
> > hmm_range_fault() can be used instead of get_user_pages() for devices
> > which allow faulting however unlike get_user_pages() it will return an
> > error when used on a VM_MIXEDMAP range.
> > 
> > To make hmm_range_fault() more closely match get_user_pages() remove
> > this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
> > case in hmm_vma_handle_pte(). Rather than replicating the logic of
> > vm_normal_page() call it directly and do a check for the zero pfn
> > similar to what get_user_pages() currently does.
> > 
> > Also add a test to hmm selftest to verify functionality.
> 
> Please add a fixes line

This has been the case since hmm_vma_get_pfns() was first introduced. Therefore
the fixes line is:

Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")

Should I send a v2 adding that tag or does Andrew normally pick these up along
with the Reviewed-by?

Thanks.

> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > ---
> >  lib/test_hmm.c                         | 24 +++++++++++++++
> >  mm/hmm.c                               |  5 +--
> >  tools/testing/selftests/vm/hmm-tests.c | 42 ++++++++++++++++++++++++++
> >  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 




