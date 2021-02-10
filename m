Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9413166FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhBJMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhBJMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612960735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5zocG/6DEMNV7g0FDh+4/QEFEu/SF/aSAR03DpAP2M=;
        b=JFysrwLjI0h1oB4Nwx3XDT+B2vNwFRaRmC1BhxJLJ/EfK2gcDmz98DOy3B6rslBur2fgm/
        7X/vyh9eTY9GsiEDP9/2+dT8QC89A9PaB6B321ZzaSUToth9Nj2NKGjL0PIya+G/enWo/z
        MmzV5FbHJBQlAI95+WtWbdfmg4Yqs9I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-j98a3GOGMTm_tcYfqRvnWA-1; Wed, 10 Feb 2021 07:38:53 -0500
X-MC-Unique: j98a3GOGMTm_tcYfqRvnWA-1
Received: by mail-pg1-f197.google.com with SMTP id d7so47638pgb.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t5zocG/6DEMNV7g0FDh+4/QEFEu/SF/aSAR03DpAP2M=;
        b=JnThQlYd6jlgiwaeNBMdvaWWS7H4IOXlkyqagiMWtwMKC7F0dGFIsSoWdgFhu/HhSP
         LxyYDqFib3e2my1zw2t7CgC1oyVP0d64slYEhJh5YeSQy3OHLyawvlfnayCBLR0FL3w8
         4IgtgrYG0SdDPq0pIpsDaEMbTF7swDgXx2pPxAnOgiMWJRcO/S1hFdNfL9K4al4LdtTg
         pgbusq185E5VQMkWRgaznZfB/AMx9RfE+QKWbMNytN3WwTv3CKA4pCu9cNCoRtJLH9qF
         LeovKMbq48IHlECYLdnjaRn2ZcgNmzd7W27RuxtgvaTV2zaOBplRLLCWAMuxhoneUmkJ
         Kj/g==
X-Gm-Message-State: AOAM5307BTkLitnEz9NQvWOMDSQ7QDYAfQ0pjaqaC9a3dh03iO1jW2A1
        bZsI1YlmHS4Sj3d8MocmP7pWr2TGmNYra2lO6608bGpUtoYE44QigRPwQU6Y5P9Z9ERaDJ7C3Bl
        f/ji8GIqZxbxbsiT8oPu0XJWd
X-Received: by 2002:a65:5c48:: with SMTP id v8mr2952653pgr.400.1612960732006;
        Wed, 10 Feb 2021 04:38:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLt2kDrIhO+iH4UMX39/RYiTwzC3trgZ7NS26DneSpm1fk6cOe9PlqjltEGKMVJyzyRSj5Og==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr2952637pgr.400.1612960731730;
        Wed, 10 Feb 2021 04:38:51 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j9sm2222324pfh.52.2021.02.10.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:38:51 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:38:40 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Gao Xiang <hsiangkao@aol.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] erofs: initialized fields can only be observed after bit
 is set
Message-ID: <20210210123840.GA1173803@xiangao.remote.csb>
References: <20210209130618.15838-1-hsiangkao.ref@aol.com>
 <20210209130618.15838-1-hsiangkao@aol.com>
 <ac5abccb-70ad-441b-a5b0-b8808ff37c00@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac5abccb-70ad-441b-a5b0-b8808ff37c00@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Feb 10, 2021 at 08:09:22PM +0800, Chao Yu wrote:
> Hi Xiang,
> 
> On 2021/2/9 21:06, Gao Xiang via Linux-erofs wrote:
> > From: Gao Xiang <hsiangkao@redhat.com>
> > 
> > Currently, although set_bit() & test_bit() pairs are used as a fast-
> > path for initialized configurations. However, these atomic ops are
> > actually relaxed forms. Instead, load-acquire & store-release form is
> > needed to make sure uninitialized fields won't be observed in advance
> > here (yet no such corresponding bitops so use full barriers instead.)
> > 
> > Fixes: 62dc45979f3f ("staging: erofs: fix race of initializing xattrs of a inode at the same time")
> > Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
> > Cc: <stable@vger.kernel.org> # 5.3+
> > Reported-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> >   fs/erofs/xattr.c | 10 +++++++++-
> >   fs/erofs/zmap.c  | 10 +++++++++-
> >   2 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> > index 5bde77d70852..47314a26767a 100644
> > --- a/fs/erofs/xattr.c
> > +++ b/fs/erofs/xattr.c
> > @@ -48,8 +48,14 @@ static int init_inode_xattrs(struct inode *inode)
> >   	int ret = 0;
> >   	/* the most case is that xattrs of this inode are initialized. */
> > -	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags))
> > +	if (test_bit(EROFS_I_EA_INITED_BIT, &vi->flags)) {
> > +		/*
> > +		 * paired with smp_mb() at the end of the function to ensure
> > +		 * fields will only be observed after the bit is set.
> > +		 */
> > +		smp_mb();
> 
> I can understand below usage, since w/o smp_mb(), xattr initialization
> could be done after set_bit(EROFS_I_EA_INITED_BIT), then other apps could
> see out-of-update xattr info after that bit check.
> 
> So what out-of-order execution do we need to avoid by adding above barrier?
> 

These is one-shot lazy initialization to delay read/parse xattr/compress
indexes to the first read since many workloads don't need such information
at all.

Without such memory barrier pairs, if two (or more) initializations runs
nearly simultaneously, the paralleled process could observe uninitialized
values (zeroed values). That is OPPO colleagues found on their products. 

Yeah, this could be somewhat kind of out-of-order, yet more specifically
called memory reordering. Xattr/compress indexes initialization could be
lazily observed by the CPU after it observed that EROFS_I_EA_INITED_BIT/
EROFS_I_Z_INITED_BIT is set. So we need memory barrier pairs to guarantee
such data ordering.

Thanks,
Gao Xiang

> Thanks,
> 
> > +	/* paired with smp_mb() at the beginning of the function. */
> > +	smp_mb();
> >   	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
> 

