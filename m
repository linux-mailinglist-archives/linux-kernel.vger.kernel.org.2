Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF76351D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhDAS2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbhDASEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA8EC0613B8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 05:17:09 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x27so869187qvd.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=At0hLz31f0qtUzLaHQ2A95j4ugCcCPB956OmXqMS5rs=;
        b=l7M3Mf6hI23/wkm1ICIFnK4z5S/ekbJFlZIz4UiO3EsuXmT30w9b87KrwixxDKuOge
         kh27oUqHkyQTSs2iHP2qZJTfRNww1HrJg8hIp7P1s31lVF6sCtzKCNywqazuMljSnbZI
         VrktpgcxZDu4WVYhVEDtDa0Ycxd6+y0Q+LpRfxZCsL0W7CyTUFoYURX/lUa1BWRBcp4m
         J6UrzIPeKoG4TVI/D2+yz7jbU0sUzgPRgt/HTkBwnGZRS8mGeHR4/hSpC69G+NWcn9tR
         mZZm3bLcxk2s7tCtokFiFSwixJsxPoMX0tgcrxy4euObBQjAEpkCWkHE+a5h4GvQzYY2
         h10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=At0hLz31f0qtUzLaHQ2A95j4ugCcCPB956OmXqMS5rs=;
        b=NHa7GmjkVERA19MXpe3pd/Y3KvoUMnITiWvqoaoN3UH9giVzO7HMk5Bq9Q47d5lHF2
         K8rXJiaJoMtCtXIt4HGdEIqtRyiF1vzRUuuK+ii6H+oH5TQdWpVmyJlHSTBZn8TeFSUb
         ChIgnvxZOBGarCL4lMF1doNeKCSkbFLLsP1bJzjIRm29q5PsjGTgTZnWfW3Xd4EvXr0a
         4fL83XMn/Kw4Zgfl4pl4zX1fXwcfe97a9vhWaOTtq5+DTtQj8M/xWfwOw2BwfbxT/hWW
         aeBNspojRmtgRfkuXe01AHxCvFFCtACUY2HnQUhIGsxlTnmFNislmFL59VXBrvC5D50G
         ansg==
X-Gm-Message-State: AOAM533kak6FJU0VPNn1ABuxZ2FvR6jBXqUeWnr57Cf4WNvg3t37O4CO
        7vJO2dllwL/QPd3cVI1IUt7O0A==
X-Google-Smtp-Source: ABdhPJxg0Kygm+S1OT+znq+JgIErKthh9M7WdRZCmxr/Gdr15knlJbF92ZospUDVdcnAt+x2LMSZSw==
X-Received: by 2002:a05:6214:2689:: with SMTP id gm9mr7853319qvb.42.1617279428419;
        Thu, 01 Apr 2021 05:17:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id q125sm3859775qkf.68.2021.04.01.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 05:17:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lRwG3-006jas-7b; Thu, 01 Apr 2021 09:17:07 -0300
Date:   Thu, 1 Apr 2021 09:17:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yang Shi <shy828301@gmail.com>
Cc:     jhubbard@nvidia.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: gup: remove FOLL_SPLIT
Message-ID: <20210401121707.GZ2710221@ziepe.ca>
References: <20210330203900.9222-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330203900.9222-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:38:59PM -0700, Yang Shi wrote:
> Since commit 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
> and commit ba925fa35057 ("s390/gmap: improve THP splitting") FOLL_SPLIT
> has not been used anymore.  Remove the dead code.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> v2: Remove the reference in documentation.
> 
>  Documentation/vm/transhuge.rst |  5 -----
>  include/linux/mm.h             |  1 -
>  mm/gup.c                       | 28 ++--------------------------
>  3 files changed, 2 insertions(+), 32 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
