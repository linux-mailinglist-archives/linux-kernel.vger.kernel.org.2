Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9533CAE5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhCPB3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhCPB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615858167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZHiTZwXf5sTvxAUH1ipIkf3/1wzr5cvwcSvdfU7CpE=;
        b=fzXiOA77ccF5wBFSMWbr7S3AutM2Mbg3rMdbbxYnm1Cp9sX1mzTPaVOHICYi/51GBe0Obx
        /8oog9iufZnWJP/fpiLJ6psdu1WaBaElAn4Fp9u76XPHTyeJiWZpC+kv9Z/sfGDMKjxKEf
        rGnAtm9O2A0dx0vfzOEp3Si2P0mu9vk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-t5IjBFt7MY2IWzL7JkDU-g-1; Mon, 15 Mar 2021 21:29:23 -0400
X-MC-Unique: t5IjBFt7MY2IWzL7JkDU-g-1
Received: by mail-pj1-f72.google.com with SMTP id oc10so15771266pjb.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 18:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZHiTZwXf5sTvxAUH1ipIkf3/1wzr5cvwcSvdfU7CpE=;
        b=A6xU6XMHCNLmNzaM6YyhgIYlF2joZQPpaigodmZD61T+3YdZL9AVsoZG2oydp1js82
         lKmmZTitTf/wcJKhIXYaUu20O7A3Y0b5ys+OosCE6RTqB9l0gUdeRZKKot/O6ZUmJzSz
         TdQaRmAB5C91VTu7J/pY/r2HGa0f3ir7HDlpzrrzRARUfXCwiiDJlwR0zceGvE47zIk/
         ooutIzPT3oS9QCKZFk5tOQuV1hSDWL8V4b97o0KimWVBj6ZmidMWPftaKNbWk+as7WN5
         YKe5F6B32IOU3Hk47HqJPUKutjx/9eaxqADLG6/mUb7QsFIUU2fIK7Fd2jb+kowF/q1D
         EN1Q==
X-Gm-Message-State: AOAM531vs3/dUeZvSVGQzFY1bx+zmwAdXT1flXlhjmPb8HHQ9W0YO6aO
        AMYr56Mf6tfK6pNjLKjBgI6XZd9L7UlTF5XS+PusXshauX0ho7Xe5NfZFYDAcuNnGq2djR1XDbv
        nAf1yPNCuf0MPvIGzT4pYEImI
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr1592368pgl.130.1615858162612;
        Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiiVJoHyC1v3XTRSM9p4HatDVJojHr0fu5Xx4awKZWFd1YYRdVwO/FQnoKTZD56cw9PPyiCA==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr1592361pgl.130.1615858162405;
        Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7sm835378pjr.18.2021.03.15.18.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:29:22 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:29:11 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>, Huang Jianan <huangjianan@oppo.com>
Cc:     zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org,
        guoweichao@oppo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] erofs: avoid memory allocation failure during
 rolling decompression
Message-ID: <20210316012911.GA931077@xiangao.remote.csb>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
 <110aa688-515d-7569-80fc-546bbeedc8c5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <110aa688-515d-7569-80fc-546bbeedc8c5@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:11:02AM +0800, Chao Yu wrote:
> On 2021/3/5 17:58, Huang Jianan via Linux-erofs wrote:
> > Currently, err would be treated as io error. Therefore, it'd be
> > better to ensure memory allocation during rolling decompression
> > to avoid such io error.
> > 
> > In the long term, we might consider adding another !Uptodate case
> > for such case.
> > 
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > ---
> >   fs/erofs/decompressor.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 1cb1ffd10569..3d276a8aad86 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -73,7 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
> >   			victim = availables[--top];
> >   			get_page(victim);
> >   		} else {
> > -			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> > +			victim = erofs_allocpage(pagepool,
> > +						 GFP_KERNEL | __GFP_NOFAIL);
> >   			if (!victim)
> >   				return -ENOMEM;
> 
> A little bit weird that we still need to check return value of erofs_allocpage()
> after we pass __GFP_NOFAIL parameter.

Yeah, good point! sorry I forgot that.

Jianan,
Could you take some time resending the next version with all new things
updated?... thus Chao could review easily, Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> 
> >   			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> > 
> 

