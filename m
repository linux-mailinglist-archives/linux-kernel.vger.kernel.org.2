Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860733B1FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWRkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 13:40:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:38:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w26so2675927qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UqKboHF7puyYHesYjNmpk5W53Yf+9XZPhNn73yz1inU=;
        b=ocp0MVYBUWes+41iCL9NiCc9bOOvCmEPnbyq8Y4S+XfSG1sT2AyucVRZ++dnWwZvut
         bIzV8G+F5q1Wj39T0+FYe/jLlCK7FeDBo/Lj5pp+WqpwFlH8ZIt4dE/m0I2eeILjok5n
         7pWNXcIR9bZg6y/n8ppC34PjFN6yQQYsip8lTYVwznIgdXUaZcvtwCYr2/FdeGq+dOrI
         mkeFXMuBlpf9xnvVsxF3BzQbT5zCEg1JUADMkDurou9IiYbXwfpUBdIkUCRrG22K4V/F
         F/ZR/XADvKsLYtDxdR6FGQJSD+qAgw9jv8jEBTfWr64e3sh/xftubXeabJJKBNQBHBy+
         s9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UqKboHF7puyYHesYjNmpk5W53Yf+9XZPhNn73yz1inU=;
        b=HgfwND0AYveSlVFHAmIWg6CQX3QPwcFMXVWSvERl9rNv2t0CjMCvGooKTom7p0VFAm
         gLeMp3QZuQtC/cVF4asjbQ8FQJK437lKPxOjSMv97PcTJzS3NRkEBiRA+2xdXQQmlnR0
         xfpn1Nec+jlH9Ll0DQZGpJPBZioZKrt1fiFxrjGIzQVc3CCXMagXvHwM792Kqq8U3F2f
         GcTWU1XHo1CBIfxLFFzeYeUrrLkesj3YURWbt9S0PanxW5gdr94DoBMPllTu2joaSxRC
         6ZVHf5nYF5/WNOt7A3BoqJodvYYVpASuOAdleaug5ZEb8Wh/Cfs0AgNT9VMpzPP71GHo
         I7aQ==
X-Gm-Message-State: AOAM533L45Dltlks9wszUnkeIVDv+wd6bhiEDhbhcjWRx1LxgU3BMWYW
        KwFXiPw6zDxeY9M8LwqTJUEWOg==
X-Google-Smtp-Source: ABdhPJxtp9DJtcphPbNvy37IHUZ9wlvtyQUBIN5iGdofdboOD6poauXaNOHjSWl7ll2a7V7uYarECw==
X-Received: by 2002:ac8:7418:: with SMTP id p24mr983226qtq.107.1624469900671;
        Wed, 23 Jun 2021 10:38:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id p14sm356051qtw.61.2021.06.23.10.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:38:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lw6pP-00BZVk-Dd; Wed, 23 Jun 2021 14:38:19 -0300
Date:   Wed, 23 Jun 2021 14:38:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/bnxt_re: Fix uninitialized struct bit field
 rsvd1
Message-ID: <20210623173819.GV1096940@ziepe.ca>
References: <20210623171202.161107-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623171202.161107-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 06:12:02PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The bit field rsvd1 in resp is not being initialized and garbage data
> is being copied from the stack back to userspace via the ib_copy_to_udata
> call. Fix this by setting rsvd1 to zero. Also remove some whitespace.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 879740517dab ("RDMA/bnxt_re: Update ABI to pass wqe-mode to user space")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 5955713234cb..45398f1777aa 100644
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3880,7 +3880,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
>  	resp.pg_size = PAGE_SIZE;
>  	resp.cqe_sz = sizeof(struct cq_base);
>  	resp.max_cqd = dev_attr->max_cq_wqes;
> -	resp.rsvd    = 0;
> +	resp.rsvd = 0;
> +	resp.rsvd1 = 0;

I think I would prefer

	struct bnxt_re_uctx_resp resp = {};

This isn't a performance path

Jason
