Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4E83920C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhEZTXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbhEZTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:22:59 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:21:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t20so1748642qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wI7tCNlcaTZmqH6g95a10WXByiu3PTAxzCVAG5uZNco=;
        b=SM3f/vu2XiZrKAcI7L4W7BwbiSvj1ehZ0sxFk5BfEzmHNgjVe7BHFB9U6lkCE01h52
         kWEj+xQnqO7fceVIc2CwmBHvDYJ536FMFmcdKNZhH/szoBmrBsS6sLB5dhe67VtEQKbn
         ST0HkTO80trrnBilylR/5H7rQWiV/D4neNsVX08dKvlmnSM5n9ILkC1OsbKyJEHy+nt0
         Iju4cArPuwH2Jn/2vznanYAbqSchzzPwXeQPyRid9E4ckMXp8xMY/WUBaWy2kEBavbX6
         kOhCdvm98E6NzV8ZdCN2VpIvQ+jeilVyKIm5X4kZ0xl87sngJOcVnbb6bzVSPNz0rwj1
         hSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wI7tCNlcaTZmqH6g95a10WXByiu3PTAxzCVAG5uZNco=;
        b=S3FGxHHLDy+v575OoeVIObKETZt0wqoaJOBuY3LYkN9oz0b4jTsibH04rT/bAyrXMF
         AF2Fv/kfTMdVHamNOp/QD8367on4s5xB/yR9OKKLsNRjtV42l8ZifhBbH+eakaBGfRM6
         r5xr/3X+PWNtamPtq+z10G22VByYnttqCllJ8qFKcIFDQbkS5f8qHNxdATIX+mI23wje
         wNoGdHCYM4zsCTAeVtltQVBOmCmPR1CFYiu01U95vPOl/2pNnqdOVD5JcBaQ9XOYFM+D
         2Pm3jK81N2PE+6pO2vXkGDnl3e4zh0ra22bF7AC8t6Q6HMB3Jo/oq6fUotu/1q8MkQwi
         ecXQ==
X-Gm-Message-State: AOAM532ofIrO7a4gNv9p2Th/xes1ObmSGnPJbjcaR+G/nRpgt9E+wdlz
        Hu2l5vHNRujJ/nkrFWOLbU2RKg==
X-Google-Smtp-Source: ABdhPJx3twK2Z0UVhtntwGDvGoua/9nmaJnAFQUJsqgCit0fyMZoTch2+UM/cuyHcYXCcGgh630hfw==
X-Received: by 2002:ac8:4a0a:: with SMTP id x10mr17715979qtq.201.1622056885353;
        Wed, 26 May 2021 12:21:25 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 127sm2172724qkl.116.2021.05.26.12.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 12:21:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1llz5n-00FI2b-Re; Wed, 26 May 2021 16:21:23 -0300
Date:   Wed, 26 May 2021 16:21:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2][next] mm: selftests: fix potential integer overflow
 on shift of a int
Message-ID: <20210526192123.GE1096940@ziepe.ca>
References: <20210526170530.3766167-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526170530.3766167-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 06:05:30PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The left shift of the int mapped is evaluated using 32 bit arithmetic
> and then assigned to an unsigned long. In the case where mapped is
> 0x80000 when PAGE_SHIFT is 12 will lead to the upper bits being
> sign extended in the unsigned long. Larger values can lead to an
> int overflow. Avoid this by making mapped an unsigned long.
> 
> Addresses-Coverity: ("Uninitentional integer overflow")
> Fixes: 8b2a105c3794 ("mm: selftests for exclusive device memory")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Make mapped an unsigned long rather than casting it to unsigned long

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
