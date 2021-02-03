Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3F30DC1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBCOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhBCOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:00:58 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC0C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:00:17 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id n8so9200510qtp.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJ+9yGGyku726Fmhx6VA5s47tWt2QRSJZr3QMNhgXi8=;
        b=LE7U/OxlvMOLCeJKV5W2LOjo71WvODo9PJaGIz1NiWr9sWessOu+ZKfLM74lMAmEHu
         e8gX2TWWeo3/Da2sCByEOpaWnFErP4MIJlli951RdrrmSkDKcZQZIlf7mW9lxyoXb4l8
         dYA+0mmu9449XB6qvuYasR/eRyZxUfoy5rL9IzDj9wojRTmaQ9QU9m4K7zhvuJe51+L2
         qo8ivy9KrEEX0smtzCT6teS/W4pPmP6MlN3rgoZ1XmA+Pk58e5gEufK4JQi3CFbVIpTr
         dVMQJPypWuh2q7jaQt4sw+so6f6mtW9F379aVUYmYmiBvilL/zVt0SJL4QFKSCYApOYz
         VSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJ+9yGGyku726Fmhx6VA5s47tWt2QRSJZr3QMNhgXi8=;
        b=beRRoLSG0V9XlccCl7uvlL7c3jftYsmGlRt/1lhKA4Ic6a38Yo51LPvMREaw8U+41T
         OxokjhLiwr8Q8956uyMRs77tl2myw+cypFFB7uX2lKKRV/qPVqrvBP2p3t3fq2w8mLSX
         FjoCMGW2Mp2f895ynQxTUC8ZEc6Beg/e9eQdz/DsS59fSRV7d3/1dKvYyAin9Lm6wiID
         HSp1/qQpMuudIvXs6BUyCV+Cwtto9yIwJew6sQ9/4QUYDPteJPT04Cgkmp8DXRCf5tAg
         4ZvKa2V4+RXkas1tgkiTsbLJ1YUi1QVFC0uPvtiofLmMrN4wUs+oW2McI/19G7xt0vtB
         /VBA==
X-Gm-Message-State: AOAM531AeT0SpiXRg4dI+PuJU8CLnSmFk3iAJEFHfsl6AhFb27tZuKcT
        oTkNFURSVeLvUYeb5EFIqtP7qg==
X-Google-Smtp-Source: ABdhPJysYd6gW3Yn+bme0w5Tc++3D1cbKiW0SwSo45oVCtlU9ebsBZcNFwOLg1YSFToUDcm3XDAggg==
X-Received: by 2002:ac8:5a48:: with SMTP id o8mr2501828qta.196.1612360817039;
        Wed, 03 Feb 2021 06:00:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id o17sm611051qtl.47.2021.02.03.06.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:00:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l7Ihb-0030iv-BO; Wed, 03 Feb 2021 10:00:15 -0400
Date:   Wed, 3 Feb 2021 10:00:15 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org, gokhale2@llnl.gov,
        hch@lst.de, jack@suse.cz, jannh@google.com, jhubbard@nvidia.com,
        kirill@shutemov.name, ktkhai@virtuozzo.com, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcfadden8@llnl.gov, oleg@redhat.com, peterx@redhat.com,
        torvalds@linux-foundation.org, wzam@amazon.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20210203140015.GP4718@ziepe.ca>
References: <20210202171327.GN4718@ziepe.ca>
 <20210203124358.59017-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124358.59017-1-galpress@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:43:58PM +0200, Gal Pressman wrote:
> > On Tue, Feb 02, 2021 at 12:05:36PM -0500, Peter Xu wrote:
> > 
> >> > Gal, you could also MADV_DONTFORK this range if you are explicitly
> >> > allocating them via special mmap.
> >> 
> >> Yeah I wanted to mention this one too but I just forgot when reply: the issue
> >> thread previously pasted smells like some people would like to drop
> >> MADV_DONTFORK, but if it's able to still be applied I don't know why
> >> not..
> > 
> > I want to drop the MADV_DONTFORK for dynamic data memory allocated by
> > the application layers (eg with malloc) without knowledge of how they
> > will be used.
> > 
> > This case is a buffer internal to the communication system that we
> > know at allocation time how it will be used; so an explicit,
> > deliberate, MADV_DONTFORK is fine
> 
> We are referring to libfabric's bounce buffers, correct?
> Libfabric could be considered as the "app" here, it's not clear why these
> buffers should be DONTFORK'd before ibv_reg_mr() but others don't.

I assumed they were internal to the EFA code itself.

> Anyway, it should be simple enough to madvise them after allocation, although I
> think it's part of libfabric's generic code (which isn't necessarily used on
> top of rdma-core).

Ah, so that is a reasonable justification for wanting to fix this in
the kernel..

Lets give Peter some time first.

The other direction to validate this approach is to remove the
MAP_HUGETLB flags and rely on THP instead, and/or mark them as
MAP_SHARED.

I'm not sure generic code should be use using MAP_HUGETLB..

This would be enough to confirm that everything else is working as
expected

Thanks,
Jason
