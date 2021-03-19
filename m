Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E5341416
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhCSERG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbhCSEQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616127395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fhkm3I7YJkrB4vQzfYOVqceaFTpMmkPj/a4yOIpQi6U=;
        b=NcahxqvvDX/d9EN13SI1OkNnv9rXmHxc+dUlmJVxXpC/10tzxHs66CWYNnmrmk21JGpq2R
        eMNtb2aDR/VB+No6Kex4gYcWuQmT1vZNy1oGWx4npjED6WcTH5LhlZGWPWmcYBebdZsVaC
        PasXEEjeKJKWBDJHtqrL5Sl55nR1e+c=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-_jKFXr3UM8Ge7ySHtwQEdA-1; Fri, 19 Mar 2021 00:16:33 -0400
X-MC-Unique: _jKFXr3UM8Ge7ySHtwQEdA-1
Received: by mail-pg1-f198.google.com with SMTP id i1so23673064pgg.20
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fhkm3I7YJkrB4vQzfYOVqceaFTpMmkPj/a4yOIpQi6U=;
        b=G+9TDoPaUPUM5yO6WU2QBn3RraG1z29SV3npH13AR6Zx9iMxpCiEVO66Ew1xG8P2dY
         Dg4bngtKQfXtEplcSKci3pBf/2Z/XSzNXdmHVnc1jc/tRkW5NO8J0Z+jieK4h6Y9dYbG
         yG21QwGIPbIt5Xev1OWTPp2gUFpDSPvCaZrE7+m4ufJhsirn2CP+o1QyiXykhvY2UkBQ
         pCuiW8jnS9/SrG7WOtHyAOmpa2/9ZL/z7TRUWHsHiFKzZ2AJYYVo7JRq1pkf3ltwd3AS
         czUthgCFKca7tr3MjH5OVh9CLkE1+H5V62CnwxoF270+7gD9av/gNBK5H/e57BWlBIaP
         ISsg==
X-Gm-Message-State: AOAM531AIEaC/AoiI5DNj73v0sYwfjM2SKm6lERroefrc6eaf6Rhzepv
        VPActX7dXf6TU5YU94FhVy3M62jT1GBMvt55GknAkZuv00vNBEi3yseaAQicZRhnAVN/UmYUtCz
        jGXjO7NaHHs9DKH/Xq73Xm48Z
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr7561391pjh.29.1616127392194;
        Thu, 18 Mar 2021 21:16:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6yU8WKXeC//FEBmjUB4/v+p+sRLJt6wM50P29v0rcFSpGwIdiUxrwif9mSFPQyLZbSwodGQ==
X-Received: by 2002:a17:90a:5284:: with SMTP id w4mr7561382pjh.29.1616127391987;
        Thu, 18 Mar 2021 21:16:31 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g21sm3855236pfk.30.2021.03.18.21.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:16:31 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:16:21 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        Martin DEVERA <devik@eaxlabs.cz>
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
Message-ID: <20210319041621.GB1431129@xiangao.remote.csb>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <dffa941d-63b5-2068-80f4-dd012f520147@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dffa941d-63b5-2068-80f4-dd012f520147@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Mar 19, 2021 at 10:15:18AM +0800, Chao Yu wrote:
> On 2021/3/6 12:04, Gao Xiang wrote:

...

> > +	    (*last_block + 1 != current_block || !*eblks)) {
> 
> Xiang,
> 
> I found below function during checking bi_max_vecs usage in f2fs:
> 
> /**
>  * bio_full - check if the bio is full
>  * @bio:        bio to check
>  * @len:        length of one segment to be added
>  *
>  * Return true if @bio is full and one segment with @len bytes can't be
>  * added to the bio, otherwise return false
>  */
> static inline bool bio_full(struct bio *bio, unsigned len)
> {
>         if (bio->bi_vcnt >= bio->bi_max_vecs)
>                 return true;
> 
>         if (bio->bi_iter.bi_size > UINT_MAX - len)
>                 return true;
> 
>         return false;
> }
> 
> Could you please check that whether it will be better to use bio_full()
> rather than using left-space-in-bio maintained by erofs itself? something
> like:
> 
> if (bio && (bio_full(bio, PAGE_SIZE) ||
> 	/* not continuous */
> 	(*last_block + 1 != current_block))
> 
> I'm thinking we need to decouple bio detail implementation as much as
> possible, to avoid regression whenever bio used/max size definition
> updates, though I've no idea how to fix f2fs case.

Thanks for your suggestion.

Not quite sure I understand the idea... The original problem was that
when EROFS bio_alloc, the number of requested bvec also partially stood
for remaining blocks of the current on-disk extent to limit the read
length. but after that bio behavior change, bi_max_vec could be increased
internally by block layer (e.g. 1 --> 4), so bi_max_vecs is no longer
as what we expect (I mean passed-in). so could cause read request
out-of-bound or hung. That's why I decided to record it manually (never
rely on bio statistics anymore...)

Also btw, AFAIK, Jianan is still investigating to use iomap instead
(mainly resolve tail-packing inline path). And I'm also busy in big
pcluster and LZMA new features for the next cycle. So I think we might
leave it just as is and it would be replaced with iomap in the future.

Thanks,
Gao Xiang

> 
> Let me know if you have other concern.
> 
> Thanks,

