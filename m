Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B3322418
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBWCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhBWCUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614046723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WKe4Azi8WwIiPXoMMrb4cd81gevagx+y/HRGK1z0jns=;
        b=cXbRLUMJLtF53fZgnBaxZw2eeByG5taPwVbKUfwRfFcdu2yNOKs9lyS5hknIlyXK8u1LY/
        hy/NtWiuj5Y05FTvJAH0g9W5eY7YLOH+h91wi1RQt1gIHq07eJ3T6aJbzHjryPbQt1XqXH
        xdd6qoBCKNYvV7LbctGSdKGMLVQ9uL0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-sczi-DQqOpm4gT5dSFMAIg-1; Mon, 22 Feb 2021 21:18:41 -0500
X-MC-Unique: sczi-DQqOpm4gT5dSFMAIg-1
Received: by mail-pj1-f69.google.com with SMTP id hi18so807163pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 18:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WKe4Azi8WwIiPXoMMrb4cd81gevagx+y/HRGK1z0jns=;
        b=KRIMZfyxQId6Bx+u9LaHRdHKWXTc9Lb6bDia/V/KYihJ7XxaeFMHz+paKU44DMJq7a
         brqHWKc/tbDvAV5/URaXpVb60JXVKw+tsxLCGcHMZNCW9Z9+f0ABTYfTnoQTz40PhHHB
         Gi8y/nWE/u0cHGq84c9pffrorMMtMKCR/FItc44P4Li3QuppMLqditDUg5RR23kA4QLj
         jFZw115SP9jOtDigOttwWmFObiORuYoXmwqr8VyVzvdBTzfs0EtrPb6DRdVj4Ibs245j
         4Pf07wG+o35gWrsO30VmZYzio4pwRs+wvylWyBMsg347jiG4vsHT4xGrO9w52q9nnPIx
         O3hQ==
X-Gm-Message-State: AOAM533+yQ4uaNWkp81n4W0CqRuxhXZ2mYyB+o5B5BDH4dUorFtTRTYI
        Z7WLTa7CBt45IOhs71KXmypNCP2lVu+1VVELdVDLr3EA52W1aedQKFKB35XZ6uEomDQGXKrw3BR
        2TWAdgd0dOrksXxV3z2YmvPwx
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr25812004pjb.62.1614046720606;
        Mon, 22 Feb 2021 18:18:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCABFRKTwBkBymzTpVoMMO56FvbMPtfXCNp92kLo3rmNdJ3nsG52Gzgj08WWoovs6WQ/pxhw==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr25811992pjb.62.1614046720337;
        Mon, 22 Feb 2021 18:18:40 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p8sm2105204pff.79.2021.02.22.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:18:40 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:18:30 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        guoweichao@oppo.com, zhangshiming@oppo.com
Subject: Re: [PATCH] erofs: support adjust lz4 history window size
Message-ID: <20210223021830.GA1225203@xiangao.remote.csb>
References: <20210218120049.17265-1-huangjianan@oppo.com>
 <20210222044410.GA1038521@xiangao.remote.csb>
 <11afa9f6-109a-c660-1664-7a596d6836b6@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11afa9f6-109a-c660-1664-7a596d6836b6@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:03:59AM +0800, Huang Jianan wrote:
> Hi Xiang,
> 
> On 2021/2/22 12:44, Gao Xiang wrote:
> > Hi Jianan,
> > 
> > On Thu, Feb 18, 2021 at 08:00:49PM +0800, Huang Jianan via Linux-erofs wrote:
> > > From: huangjianan <huangjianan@oppo.com>
> > > 
> > > lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> > > using rolling decompression, a block with a higher compression
> > > ratio will cause a larger memory allocation (up to 64k). It may
> > > cause a large resource burden in extreme cases on devices with
> > > small memory and a large number of concurrent IOs. So appropriately
> > > reducing this value can improve performance.
> > > 
> > > Decreasing this value will reduce the compression ratio (except
> > > when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> > > currently only supports 4k output, reducing this value will not
> > > significantly reduce the compression benefits.
> > > 
> > > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > > ---
> > >   fs/erofs/decompressor.c | 13 +++++++++----
> > >   fs/erofs/erofs_fs.h     |  3 ++-
> > >   fs/erofs/internal.h     |  3 +++
> > >   fs/erofs/super.c        |  3 +++
> > >   4 files changed, 17 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > > index 1cb1ffd10569..94ae56b3ff71 100644
> > > --- a/fs/erofs/decompressor.c
> > > +++ b/fs/erofs/decompressor.c
> > > @@ -36,22 +36,27 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> > >   	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
> > >   	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
> > >   					   BITS_PER_LONG)] = { 0 };
> > > +	unsigned int lz4_distance_pages = LZ4_MAX_DISTANCE_PAGES;
> > >   	void *kaddr = NULL;
> > >   	unsigned int i, j, top;
> > > +	if (EROFS_SB(rq->sb)->compr_alg)
> > > +		lz4_distance_pages = DIV_ROUND_UP(EROFS_SB(rq->sb)->compr_alg,
> > > +						  PAGE_SIZE) + 1;
> > > +
> > Thanks for your patch, I agree that will reduce runtime memory
> > footpoint. and keep max sliding window ondisk in bytes (rather
> > than in blocks) is better., but could we calculate lz4_distance_pages
> > ahead when reading super_block?
> Thanks for suggestion, i will update it soon.
> > Also, in the next cycle, I'd like to introduce a bitmap for available
> > algorithms (maximum 16-bit) for the next LZMA algorithm, and for each
> > available algorithm introduces an on-disk variable-array like below:
> > bitmap(16-bit)    2       1       0
> >                  ...     LZMA    LZ4
> > __le16		compr_opt_off;      /* get the opt array start offset
> >                                         (I think also in 4-byte) */
> > 
> > compr alg 0 (lz4)	__le16	alg_opt_size;
> > 	/* next opt off = roundup(off + alg_opt_size, 4); */
> > 			__le16	lz4_max_distance;
> > 
> > /* 4-byte aligned */
> > compr alg x (if available)	u8	alg_opt_size;
> > 				...
> > 
> > ...
> > 
> > When reading sb, first, it scans the whole bitmap, and get all the
> > available algorithms in the image at once. And then read such compr
> > opts one-by-one.
> > 
> > Do you have some interest and extra time to implement it? :) That
> > makes me work less since I'm debugging mbpcluster compression now...
> 
> Sounds good, I will try to do this part of the work.

Yeah, but it seems to be part of the next LZMA algorithm patchset (with
a new brand new INCOMPET feature). I think we could introduce a __le16
lz4_max_distance field from sb reserved for now as a simple backporting
solution (since we only use < 64kb sliding window, so the image would
be forward compatibility with old kernels. 0 means 64kb sliding window,
otherwise it will < 64kb.)

And with the new INCOMPAT_COMPR_OPT feature, lz4_max_distance field
will be turned into compr_opt_off instead. And variable-array will be
used then.

So could you revise the patchset as above? Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> Jianan
> 
> > Thanks,
> > Gao Xiang
> > 
> 

