Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F9452962
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbhKPFJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242928AbhKPFJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637039202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuzOVY/lauvGexWGkWrAO1q71UBvsei/aBKW+iGdLQ4=;
        b=BI0+BvMp9zGLukBxfp8JQf5IGQp1jZfeteZPG0C/Z9xVGviqHnyMgFaKQYtzYZYwrP601H
        h8Go2yCPgGE2Sxy7dyiSQvT6r3ghQQCEuD1mlgKBiLySkgBuLze2sKyHGWK7T6OONDpjzf
        LzTWgfJAEhQ3hdIbNbJIvpKN57iZygI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-uW-MIcMiN66NSWMKeBfkLA-1; Tue, 16 Nov 2021 00:06:39 -0500
X-MC-Unique: uW-MIcMiN66NSWMKeBfkLA-1
Received: by mail-pj1-f71.google.com with SMTP id t7-20020a17090a5d8700b001a7604b85f5so5646621pji.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 21:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AuzOVY/lauvGexWGkWrAO1q71UBvsei/aBKW+iGdLQ4=;
        b=iCPxl1Qa2igS4uCWBz0JnAeac1pmongy3jfl60KNvSowkKlgJFUCiKOj94kdYb4/my
         BKhZktkBgNTsYR4I9HwYCHc4W0rD4Cf431nf5eJt1sChZJiD5tcUT5xDMgWATCJL6dI+
         omlyE1cOtKdNWsZLCVLJ21y4D90qeUNo13gjpW/eCKLICx68uNyhURpG7V7b7rMuGjST
         NUuC6sGbBf/fgsHaNXsSe/a0tQArVsBI6556nAwZ2WFAZNBklWDKN5M1c+akNmrIEKmz
         d0eIK9pxfi4pdHhwanUr43hfSiwryCoOCb/3Jje2SYQWILo5uZVaG7Eh/x/eya9P+FjS
         UXtQ==
X-Gm-Message-State: AOAM530pqnfmzL5YRWTTDeN7dcUpYjpH6MloK3AB743KUeGdn4RlgFYN
        48IoGSZwwhegD5bAl7gFzozjeX07t8xrqmInBCLSEoVA2hlS6BbnCwIShjPB02AmnsjNYOkpu7r
        kJt4ozKtHxRcc6nwlE94WXk5X
X-Received: by 2002:a63:f70a:: with SMTP id x10mr3103345pgh.12.1637039198516;
        Mon, 15 Nov 2021 21:06:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx79zlYcM3aNI5NxvJzl0JyITbzxDW6jQYt5RMsN04A1pwcOL73bXYgTKif8jzEGiaR2hd0uw==
X-Received: by 2002:a63:f70a:: with SMTP id x10mr3103328pgh.12.1637039198279;
        Mon, 15 Nov 2021 21:06:38 -0800 (PST)
Received: from xz-m1.local ([191.101.132.59])
        by smtp.gmail.com with ESMTPSA id kx3sm914236pjb.5.2021.11.15.21.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 21:06:37 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:06:30 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Message-ID: <YZM8Vrr4H4hlDcNR@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-3-peterx@redhat.com>
 <YZJnTKKXDqKWZ6UP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZJnTKKXDqKWZ6UP@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 01:57:32PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 15, 2021 at 09:49:51PM +0800, Peter Xu wrote:
> > Clean the code up by merging the device private/exclusive swap entry handling
> > with the rest, then we merge the pte clear operation too.
> > 
> > struct* page is defined in multiple places in the function, move it upward.
> 
> Is that actually a good thing?  There was a time when declaring
> variables more locally helped compilers with liveness analysis and
> register allocation.  Compilers are probably smarter now.
> 

I see, I don't know the history of that, but I did give it a shot with a patch
that recovered all the "struct page*" back to the origin, I found that it'll
generated exactly the same assembly of unmap_page_range (actually, the whole
mm/memory.o) no matter what.

I only tested on an aarch64 system, with below gcc version:

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/aarch64-redhat-linux/11/lto-wrapper
Target: aarch64-redhat-linux
Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-11.0.1-20210324/obj-aarch64-redhat-linux/isl-install --enable-gnu-indirect-function --build=aarch64-redhat-linux
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 11.0.1 20210324 (Red Hat 11.0.1-0) (GCC)

Thanks,

-- 
Peter Xu

