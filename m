Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67B3FE1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbhIASKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344186AbhIASKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:10:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A9C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:09:16 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g11so475722qtk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOqfD8w800F/Nfr4LOJfJfsHlltggA7GI5D0/+MPf2Q=;
        b=Ox9bs87nkVrewaMMUlmMJkOnilGfEsCVRAIQ+aQ83+2LTkk4h/rfLyEw9kzGGh6UpR
         4CtRpZ+/j4GRqwTl34I65RkJQf/OPEjZVmow8X6L1VRpz9859K3wwvgan3k/Fcoucoei
         U2//8DP3FjO6Xxf5VV5GE7ZOq2ZQ3dcZOjy47iUsEyIQ3WzmvUhitw0p0JpxVRRUzWuF
         Ug1rDffJGaYnXFPzE6hUvpasFgtSoMMMEyyhfqTLNHRBptyziZ+WHbjyVg9MAv4BkbLo
         wxAgFY1zeIceBN1z4GpO4J+tFKHI5aA2Ux1r4yj46YnPsRcuESDC6eeWJhMYhw8CrVpN
         08Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOqfD8w800F/Nfr4LOJfJfsHlltggA7GI5D0/+MPf2Q=;
        b=atA+fe56P1KFX7n1u0pjjVw3AgNHgjATIDDYmFYUzmwPy8+PMrX60PdEI3ZEjLNsZj
         FsSjyptwIjeUGT5qsK2CfZglrRI5jdrjtjGE6fQCNXUv/LPayfRrUtQF3xdd/JOOE7js
         PEm/tiksvSSs8z9sbqI0tNVyCvu3wegXEyKnsh20LDNEQXCn/q/3o63X4wXji3iVGnz3
         EMsv3yjzMIbw83mtdgpPo6QEqFtGccHQu3jwnzt5YfpBsvJ+qgROr+TU/Z7JVYtHj1bv
         vOP/cM3VaswmvuQTuz9FkmnucVgv/hQ0FAvCNeW3FcIbctvOsdVHFoET/BsBZykshyRQ
         80tQ==
X-Gm-Message-State: AOAM531LA2jGZ8tbXU/8/G7OEaqit4FbyDXgute5YL7alzMirHWWS4xz
        bQGGqUw5WGil9UxAJrtvvRK1VA==
X-Google-Smtp-Source: ABdhPJwrzZAjc9PfHsU/3i22e2xwCxmIaT47VTkSIAldmXSwTLWpE8m34PMXxRVPzqe7h14/7Os0xQ==
X-Received: by 2002:a05:622a:100e:: with SMTP id d14mr561548qte.350.1630519755603;
        Wed, 01 Sep 2021 11:09:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h20sm318081qtr.81.2021.09.01.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 11:09:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mLUfi-0088XO-9Q; Wed, 01 Sep 2021 15:09:14 -0300
Date:   Wed, 1 Sep 2021 15:09:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <20210901180914.GS1200268@ziepe.ca>
References: <20210901135314.GA1859446@nvidia.com>
 <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
 <20210901153247.GJ1721383@nvidia.com>
 <7789261d-6a64-c47b-be6c-c9be680e5d33@redhat.com>
 <20210901161613.GN1721383@nvidia.com>
 <e8ebb0bb-b268-c43b-6fc1-e5240dc085c9@redhat.com>
 <20210901171039.GO1721383@nvidia.com>
 <ef7a722d-0bc0-1c68-b11b-9ede073516e0@redhat.com>
 <20210901175547.GP1721383@nvidia.com>
 <52ba8125-0382-3270-a958-ed113ae1db2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ba8125-0382-3270-a958-ed113ae1db2a@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 07:58:47PM +0200, David Hildenbrand wrote:
> You'll most likely have to touch each and every place either way, for
> example when suddenly returning "null" instead of a pte. It's just a matter
> of making this easier to review and the changes as minimal and as clear as
> possible.

I imagine the leading series to add the simplified API would include
the null return already - the THP race avoidance requires it anyhow.

So you end up with a simpler self contained series that is a stand
alone improvement followed by a much smaller series here that doesn't
got back and re-touch the first series's changes.

Jason
