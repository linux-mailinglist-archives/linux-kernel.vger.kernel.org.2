Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE6321D63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhBVQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhBVQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:49:17 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11662C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:48:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b24so9691104qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+mTrq1FCm72aS73t2sdgEW0wRg3cpUyRs6KvYINKIk=;
        b=b2JA8LweUMvXaEpIDY/7TExlbGmdyzhfW1IpfJORsKvS7slxkMolm0g6KRAZj4Cfd0
         38f0gj7yLmaSO2OLXL9khtoLY+e5CJngVroT+J0iOI2oKmtOtTyy9RD4smRHlCHFq3UZ
         YdZ+EhlnaUzF+kPHG16HwF0++Q0QH3R8FjlAMndOmcONnVVMdILdVOvb7rzceGI/rxA4
         fcDOjxxQI67tJMFdUT5ValRN82CdAa1Szn+5mvWL1lxweljw0X91FfDE4uhv/viFMcL0
         f4IQeEGda0GWVUDugBsbilU6UPCO6rx8tfppu69qlanu9sA0uMhF3UuNXEL/fkHaN5Qc
         fhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+mTrq1FCm72aS73t2sdgEW0wRg3cpUyRs6KvYINKIk=;
        b=druy4wuPnXv6AiCVNUJhyoTJbSNZz2I6+6CEHz+725bw05Ctk7pkWqQC4tvEucZknO
         6czzhXjnUl7YyYKSDlo6ONwzUAAQuwggD3kswAHPpqq7HRN0hoChhV+guHCpQJmGCfrF
         amg+jTHR2wi/FciQLvUo+vdoTBvug5Wblje1M1jPNg2tdFnj1iq+oZ2MmGTqxZP6GPhN
         +PrkNXIoDvCc2KGSKqyqhGWgIt/ZBF3AbjnzFKsSJ+PMLBQKN5c0aOeMxacC/Ba3ux7Z
         zA/ce3HeeuhYPkZ66ujVvB6vp/A+C80lnsezQ7VWFj/tDC0/bsfr3qgOx9qqvJNan1JJ
         UaCA==
X-Gm-Message-State: AOAM530mb/YpCwAK0SGYkj2WFVG7feotpXA4hbYEJfl8k53gFjtBKY0z
        tHl6TWMzCqsiKSj8rDtt/LB+7w==
X-Google-Smtp-Source: ABdhPJyQ/sflzonzw4oVX7/5kwotkwpb4JDTR/ykrj6redal1FML16b8uQV2zByESAu1JiEsnO35eA==
X-Received: by 2002:ac8:4b56:: with SMTP id e22mr15959033qts.311.1614012515304;
        Mon, 22 Feb 2021 08:48:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id 15sm11072578qty.65.2021.02.22.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:48:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEENu-00ERzG-4Z; Mon, 22 Feb 2021 12:48:34 -0400
Date:   Mon, 22 Feb 2021 12:48:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Praveen Kannoju <praveen.kannoju@oracle.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>
Subject: Re: [PATCH RFC] IB/mlx5: Reduce max order of memory allocated for
 xlt update
Message-ID: <20210222164834.GL2643399@ziepe.ca>
References: <praveen.kannoju@oracle.com>
 <1613138176-22082-1-git-send-email-praveen.kannoju@oracle.com>
 <CY4PR10MB1448EDE77B7FB66DF79ACAD38C819@CY4PR10MB1448.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR10MB1448EDE77B7FB66DF79ACAD38C819@CY4PR10MB1448.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:26:23PM +0000, Praveen Kannoju wrote:
> Ping!

Your original message didn't make it to the mailing list or
patchworks, you will need to fix your mailing environment and resend
it.

> -	/*
> -	 * If the system already has a suitable high order page then just use
> -	 * that, but don't try hard to create one. This max is about 1M, so a
> -	 * free x86 huge page will satisfy it.
> -	 */
>  	size = min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
> -		     MLX5_MAX_UMR_CHUNK);
> +		     MLX5_SPARE_UMR_CHUNK);
>  	*nents = size / ent_size;
>  	res = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
>  				       get_order(size));

IIRC, there is some GFP flag here that fails fast if the order is not
available, why not just use that?

Jason
