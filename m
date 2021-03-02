Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A5832A078
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381123AbhCBEVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:21:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4945 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbhCBAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:10:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d816e0001>; Mon, 01 Mar 2021 16:06:06 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 00:06:05 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 00:06:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 00:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b63K01FdiVsIqUhKrOhuQvXOVqlZ+nf5eby75HkfXbXZY8EPHikKGmgdKvI8SSklxSLgMnjEeVyGwNjrrZFbflSpi41hCRUb7nxTRfWiFPB0XoeAa3xpEEmKGuprtUiQPYcNonNPAUFpWEFJzODa4oZ293Xb/79grWL2t88GBcbov4F6CkoOeyERwatS9gMuH5UPQa4yGLqq6m7tsRhtS/CpRVQ3Y0DuJcvjDgFgCdKjf5FYlWjSt0350UEUO3yGOwQn8GCMVU+Ys+cRv6RC54N0wPDB9qZaJImjqdTyNibc/l5f1+otuFRCnneIFNrfGTU1lk1vZgcizopYOJj50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlRygJWLB5PGvQRv237k1PGGvIniA6bUeamuyGdUW0Q=;
 b=K2C5xC/X551eoMtRGhaEbPxDzAA/7wcGeS/jEUgXP1KAa5UMTyF7dYbW5EXk8g3IilFtGD8LcGD3z3YHPW34D5YZLGwNiUJugcbTQSWaMVj0KfyRHb51QetYgB+cvQZAfe36aSl2AMiomGdYB2XGYNTgbriIbQOXqppqpjs3YrS4bFpkUnMvkUY9LQ/4g4Ix7UI9pxULodbVhQjZYhOFFrIJP3P7aH87CZSJ7TpzazFx2gFZYZZ1Nfv21R+BjkHLR2tIidDSGAhDHjLqe73EhbzRKq2Eg4jez7SzeQWie/X3LTchpjeVQLIxPCgkit+9gz24nCethlPmBujOb1g7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 00:06:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Tue, 2 Mar 2021
 00:06:01 +0000
Date:   Mon, 1 Mar 2021 20:05:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <bskeggs@redhat.com>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <jglisse@redhat.com>, <hch@infradead.org>,
        <daniel@ffwll.ch>
Subject: Re: [PATCH v3 5/8] mm: Device exclusive memory access
Message-ID: <20210302000559.GA763995@nvidia.com>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-6-apopple@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-6-apopple@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:208:32d::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0058.namprd03.prod.outlook.com (2603:10b6:208:32d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 00:06:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGsY3-003Clj-EX; Mon, 01 Mar 2021 20:05:59 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614643566; bh=SlRygJWLB5PGvQRv237k1PGGvIniA6bUeamuyGdUW0Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=G+aFSB2VntL5W0jA/emAOatTaR93Kvlu880urJxzE0aooLL+wY2cRJY+lFct4vqaw
         Cym6aSwol8ACDdqNJ1oidKX1oFbV4r/6xWmF1qFIDA3WOEJAnE2xyoI2blqci+Ft0S
         E0tFEFKhyrw3fDvTG4jECWHczZEQoJeKOXKFtFhAkdqOESc3Wm6V8RadVIZu8NxbLE
         noEMI3hd8dNm0CgtXcrZnhTeR/DwF+uIMCm7kjGNO83sFYeZLWFTMNjVw2VViGQ4BZ
         aZzvvfAbrefuotXg/F8oZ4PHOmDNU/aTk9Hi0HsdNiz5TlJYuSeBUn90SJQOfhUcu3
         +PVpa1qYNq7LA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 06:18:29PM +1100, Alistair Popple wrote:

> +/**
> + * make_device_exclusive_range() - Mark a range for exclusive use by a device
> + * @mm: mm_struct of assoicated target process
> + * @start: start of the region to mark for exclusive device access
> + * @end: end address of region
> + * @pages: returns the pages which were successfully mark for exclusive acces
> + *
> + * Returns: number of pages successfully marked for exclusive access
> + *
> + * This function finds the ptes mapping page(s) to the given address range and
> + * replaces them with special swap entries preventing userspace CPU access. On
> + * fault these entries are replaced with the original mapping after calling MMU
> + * notifiers.
> + */
> +int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
> +				unsigned long end, struct page **pages)
> +{
> +	long npages = (end - start) >> PAGE_SHIFT;
> +	long i;
> +
> +	npages = get_user_pages_remote(mm, start, npages,
> +				       FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
> +				       pages, NULL, NULL);
> +	for (i = 0; i < npages; i++) {
> +		if (!trylock_page(pages[i])) {
> +			put_page(pages[i]);
> +			pages[i] = NULL;
> +			continue;
> +		}
> +
> +		if (!try_to_protect(pages[i])) {

Isn't this racy? get_user_pages returns the ptes at an instant in
time, they could have already been changed to something else?

I would think you'd want to switch to the swap entry atomically under
th PTLs?

Jason
