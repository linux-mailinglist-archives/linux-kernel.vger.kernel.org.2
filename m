Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC03B03FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFVMQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhFVMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:16:24 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:14:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r7so15802043qta.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LT13jFHeh4LTP9zE1+qKjJtIwv0pd0oBJbwT/TZVyeA=;
        b=DVQUvpScWMPfa8jzOm5GJInZHiXCte3+7wziG++Cbt2SXo6S0kC7qZ5S2R19Ku6N+A
         +vcesmQHxhqQ+ddNmTWS3xBsTMne9dSIRGwCC3dwN6DCWpPomjcFHHQZYfPfiz/U/fEN
         BcsFGVCk1nuYt6OvtcPkLFwavtC2bLEKzsVU0amWt0xsa55b68zHXTNFL1KkUDzWmotu
         KG8+rBgFVndL+pzoViTAulSH2ukV7ozmJvV+rEBk3tEt2BUB0neZ+u78kUkjzPj/SZdO
         /KrnU8ojE8AnXCeGbewGbvTKu7mNHlbniKbHuoKMydoFIv4PWU5cJ6qKHZhm45zyssZM
         wL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LT13jFHeh4LTP9zE1+qKjJtIwv0pd0oBJbwT/TZVyeA=;
        b=rqN9S65p13ixTq1du7OFL8mSIPUCYy242mVdnLCFUj2wypuMikf4XQLz5pC7cwAubK
         WqDuKyR7te4411cowoERoomq1VTvTF6hXIBVLPHj9h1KFA5X+QnxIqRMbaCVS/QhleX7
         ntUklgdaxtI3MVF98/mEgzWwCu6Nf/vsBb9G6X3+TuC3v+lGQ/Nco9TU8sZ3n269Lq5I
         5VUtP4P3Rp0rHiPSC8iRXn7XPlfffzrvEpPWXcfNGTPwze+7ZNXFa437ZWOtleqvLr2z
         DUiDZvvMbbktrLHYfkd+vFhDsLKlTr//61XQhsBTVT4ajo7kf+R0ZuU8l2F4AwnvTZi0
         9W3g==
X-Gm-Message-State: AOAM5316SAB7D9Wj/IkhSxRS0hZzywr9wovJESGvmiZ08eNzNj9hH7Pn
        VVMNQalSjgfejUUYMnF3MUmHTg==
X-Google-Smtp-Source: ABdhPJzB/T8OeZHW0Fa+lqmMV3l7eddmIs4AfvJ743S6J97Z+4JDNhhYB8uDnrjQ0zz/SUkxhHUkoA==
X-Received: by 2002:ac8:464c:: with SMTP id f12mr3175896qto.303.1624364047367;
        Tue, 22 Jun 2021 05:14:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id c16sm1395182qtd.46.2021.06.22.05.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:14:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvfI6-00A9az-EY; Tue, 22 Jun 2021 09:14:06 -0300
Date:   Tue, 22 Jun 2021 09:14:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA/i40iw: Remove use of kmap()
Message-ID: <20210622121406.GM1096940@ziepe.ca>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
 <20210622061422.2633501-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622061422.2633501-3-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 11:14:20PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> The kmap() used in the i40iw CM driver is thread local.  Therefore
> kmap_local_page() sufficient to use and may provide performance benefits
> as well.  kmap_local_page() will work with device dax and pgmap
> protected pages.
> 
> Use kmap_local_page() instead of kmap().
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This needs to be resent against irdma instead

Jason
