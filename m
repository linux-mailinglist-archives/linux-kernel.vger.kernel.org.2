Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710D3297DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245426AbhCAXAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 18:00:08 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13231 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbhCARuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:50:09 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d29280000>; Mon, 01 Mar 2021 09:49:28 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 17:49:25 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 17:47:21 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 17:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3BLx1NwkfjoWIgHuViB661XrnhFZW9QwJeOAhPmDkAH5WbM2/QfRs6gXPS/bMAyNj25f9XnfZ9B1x5kCieE0FkXpHWeMQ5JRUr+GSPt2MTNSljVnLoR11VIljLVHkbT8ghjmXABDMU83hf7i5B4L5qx2s948XnjPXMcmJl56n+W/GMQxlz9OzPlr/mEp2imS3pXpJJ1MIlScKSsiPp172ePFeDtQZEgVkozdS+0YDSrmkNhnv+lQw8iDyaIIQn4bpOP6pCpUvao+1n5YT7uwxbcNfKOqyRkEnmzbvIHHxc3+tgsxJxc7YVk2UhoN7Eatf3gU0efnScBURJZYzs+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5odiawRgo/h9QED/AAgw1st4fjqiXTxejdJ0ivrCaj8=;
 b=fV51jIrY1lLPh8EeL1inYD7jyIzSx6WtVphGYDmGTatj2kY/q1Q067jZFPwv2dmin8DQ8QLTXNx4MTqn3NTpGNbc8IkgLlAM9BpYGoXomHY1msgitQRaaL//Y9ijotbIiieC63ujT+yJbIn15gTBHWD/Az/zBcfU0tPZxyvDOLTfdjqEvCLrthelLWwcL/EAkqsgh228YKBUlxkns1v/rQ5BAi3DycqCL26MdAZkyu1AEFKBHtMhPclGsy1tx75O+qjKUT5JzGpKkeISlXKeFZqsVcCq5YkpnX9w9A3lrs8AgZqhIrO1BPQJnfD4ME9KANGi6pHNks0vSO5J94kw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 17:47:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 17:47:18 +0000
Date:   Mon, 1 Mar 2021 13:47:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 2/8] mm/swapops: Rework swap entry manipulation code
Message-ID: <20210301174716.GQ4247@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-3-apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-3-apopple@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:c0::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:c0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 17:47:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGmdY-0033nk-Tk; Mon, 01 Mar 2021 13:47:16 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614620968; bh=5odiawRgo/h9QED/AAgw1st4fjqiXTxejdJ0ivrCaj8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=kre8DYUFi+RGqqUnUhPEXEZJNztxb2Ic7yj6yf1FxuVlD6SAmuagNp5YAGwmXyklr
         k6IjSzTIAZ+4Ecw0ndesyLUutiCkCFye4RgUvmxxFm8aZ8ZMWioBg3LRYbnIv6hbgJ
         WUB/unbX5gyQ9RyD4D4MwZpo6tMM1i1+zcN/rubLss2gR3DLbQGLyaZQtd2PMg/pTd
         jkdmBu1GRtlf4O5Ba1iGOjamkZrWFvY4bwKJG/ipHcmnXg1HT3ccdf1H1UPmkgGALU
         YECkJTbBFHVXsYg4qhe0nCrjUdzVHcleylAd5XPOowgQ2cpXn8s25Lb6ocZ0Pn06pU
         S3qIAwyCLs6XQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:18:26PM +1100, Alistair Popple wrote:
> Both migration and device private pages use special swap entries which
> are manipluated by a range of inline functions. The arguments to these
> are somewhat inconsitent so rework them to remove flag type arguments
> and to make the arguments similar for both a read and write entry
> creation.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  include/linux/swapops.h | 56 ++++++++++++++++++++++-------------------
>  mm/debug_vm_pgtable.c   | 12 ++++-----
>  mm/hmm.c                |  2 +-
>  mm/huge_memory.c        | 26 +++++++++++++------
>  mm/hugetlb.c            | 10 +++++---
>  mm/memory.c             | 10 +++++---
>  mm/migrate.c            | 26 ++++++++++++++-----
>  mm/mprotect.c           | 10 +++++---
>  mm/rmap.c               | 10 +++++---
>  9 files changed, 100 insertions(+), 62 deletions(-)


Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
