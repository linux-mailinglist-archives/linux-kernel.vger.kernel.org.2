Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786C03A2DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhFJOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhFJOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623334480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eMUW9x1stkaG9D/YeYgpV7BE6hDJxv48nfPNnU5COg=;
        b=BBZQgVmDoadEXNvnBY+fDPqhyIyZh/HA2bwvrK88tlgh3O0d9wX8wcrJFWSntTgOzLx9Ge
        r024Dp6w/QXxnj5Sfc37vWaunTcsXKuHanw10OdjznbIiKhHL25VfPBMl1WqAl1YD2yKPw
        FmZHc4Y8LOjLlYXrwzkFH44D/r3Uk0s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-kAIBFjVHOSCdJYrJaSwv6Q-1; Thu, 10 Jun 2021 10:14:39 -0400
X-MC-Unique: kAIBFjVHOSCdJYrJaSwv6Q-1
Received: by mail-qv1-f69.google.com with SMTP id n17-20020ad444b10000b02902157677ec50so20406066qvt.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3eMUW9x1stkaG9D/YeYgpV7BE6hDJxv48nfPNnU5COg=;
        b=a9Vt2u1MqIN8t10bvqNHYk5UQbr1ArrW66AFdUTxWX80bAE+3k73q4RygSmYM73f/I
         1hJ+Lf1v0GPtmBkF5FIumqnoT5sDeFIijqgwz9xjwwRFaKvtp+QBnFunHO/7YJsU29pV
         w7v9sFx5ZQ0HNtV8SW+qIU77jDkPPJBVVusTWhGKNqMMOZoYOIIH43N0ThP/vm1MbKLZ
         K1wol1Jz7qpLxbytFxnsfXXY2n58bbBKUWZVrKlDzBLnPP+a8ySlePZDKp1dRpWmZACw
         aVkccZfsEsRPq6IDEiqdRkeNIivkfLf3hOyLqP52dIfZsaL5phHwhG8o3lhXHd7IZ9iG
         k8bQ==
X-Gm-Message-State: AOAM533OTMIz7VHbLipM7H8sFIY0+odSqukmVhZkYyd7mclRAxleA7LY
        u79pe4q3saUXTWxlxPwjr9/09pjmct8YllvTPTGUvtL6F3CFybBzz4wEkkIc/wCAdQYHAmJAc+w
        AUhSFGU2+qMtNRmgD62OMXIjs
X-Received: by 2002:a05:622a:2cb:: with SMTP id a11mr5297929qtx.12.1623334478937;
        Thu, 10 Jun 2021 07:14:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaTfyNLXhsLczTD6kzm29TcEBkes7iQLehe11xU9ySZayuTwKyb0Z1O3wF3y73of5DKgKlnQ==
X-Received: by 2002:a05:622a:2cb:: with SMTP id a11mr5297900qtx.12.1623334478641;
        Thu, 10 Jun 2021 07:14:38 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id s133sm2293208qke.97.2021.06.10.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:14:37 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:14:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] mm: page_vma_mapped_walk(): use page for pvmw->page
Message-ID: <YMIeTEYwzmKdrMqG@t490s>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <88e67645-f467-c279-bf5e-af4b5c6b13eb@google.com>
 <20210610085522.f5ffyejzn3xtqark@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210610085522.f5ffyejzn3xtqark@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 11:55:22AM +0300, Kirill A. Shutemov wrote:
> > @@ -234,9 +233,9 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >  			return true;
> >  next_pte:
> >  		/* Seek to next pte only makes sense for THP */
> > -		if (!PageTransHuge(pvmw->page) || PageHuge(pvmw->page))
> > +		if (!PageTransHuge(page) || PageHuge(page))
> >  			return not_found(pvmw);
> > -		end = vma_address_end(pvmw->page, pvmw->vma);
> > +		end = vma_address_end(page, pvmw->vma);
> >  		do {
> >  			pvmw->address += PAGE_SIZE;
> >  			if (pvmw->address >= end)
> 
> I see two more pvmw->page in this loop. Do you leave them here as the code
> will be rewritten later in the patchset?

I think they've got removed in previous series ("[PATCH v2 04/10] mm/thp: fix
vma_address() if virtual address below file offset").

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

