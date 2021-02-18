Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7D31F2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBRXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhBRXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613689149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKI2EI2akMTifDNZ7stGxIBdP3HZn3yIh1zXVcGhwwI=;
        b=Mx9/57Xj14d2Ekqps9OMGwCJ0u/FkcWLAdejcCMrVYWm1C5Rz2ufWnOOdNzhwGCxhdbGRR
        o9mtDgn4ZiK25BlUNFDzSRHO6uiceCtNMfBGdYH5RkYu0TfZQba6Lmti2ElwBxcYCI9ByN
        RnivzEMdy4PBA+d9iC2JoDhC2/S5nw4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Ci5Se2vQOFu0QxHMA4PxTQ-1; Thu, 18 Feb 2021 17:59:07 -0500
X-MC-Unique: Ci5Se2vQOFu0QxHMA4PxTQ-1
Received: by mail-qt1-f198.google.com with SMTP id l1so2152362qtv.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PKI2EI2akMTifDNZ7stGxIBdP3HZn3yIh1zXVcGhwwI=;
        b=RrBWAbWjYCIBR1RBJ8ZRU/1XyBIQokvXG50w0WbWM4j2q4qfpoe+GswkS8dKeEWgTi
         Um7P17KB+ydoad/q06mx9KLSnqdUhfY45JqNe4U4R1ArmkRwmYWwgnmFf9wfxm4JML3g
         7PWM1GOfSyHCnLGHyPEAnBEIXe9JpK5weZRaO6DVFsAe50sNwwY0D7/o/3Q81SrF0KsA
         l+u2BCOt+nAQivinQfqMLkMV0f+Qume4saQkSumye/vdr6rCiAAAGinh6XpEi9gpGsbH
         LcYDg+/L0lsxJxhzRbf6u44pyYiU5eKhCDdWp/A1mCM/WNJZM384a2s6fKM43vSu8WEC
         ys0A==
X-Gm-Message-State: AOAM530TzpsIGFJYMma/ooYZSc/j30+gqulWIyAT/LOjuAPtOm+zAddP
        y8nTiTRc0yv9sM7TeRz+oPxOly3fHkD9/V7oCwp4PiJ4LqlmdAyu6cobINFqojbyGtHTvPEkzCb
        XmKLeaMpugoClJn39sEnyzkeZ
X-Received: by 2002:a05:622a:307:: with SMTP id q7mr6527654qtw.211.1613689147177;
        Thu, 18 Feb 2021 14:59:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmNDEim01hYlaOLCBph1TMgm3UzsW+W0hEZou2jGGlO0sciL3i5yzo2yWdc/gQPQKN5MZMSg==
X-Received: by 2002:a05:622a:307:: with SMTP id q7mr6527629qtw.211.1613689146890;
        Thu, 18 Feb 2021 14:59:06 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id v75sm4944965qkb.14.2021.02.18.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:59:06 -0800 (PST)
Date:   Thu, 18 Feb 2021 17:59:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <20210218225904.GB6669@xz-x1>
References: <20210217154844.12392-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217154844.12392-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, David,

On Wed, Feb 17, 2021 at 04:48:44PM +0100, David Hildenbrand wrote:
> When we manage sparse memory mappings dynamically in user space - also
> sometimes involving MADV_NORESERVE - we want to dynamically populate/
> discard memory inside such a sparse memory region. Example users are
> hypervisors (especially implementing memory ballooning or similar
> technologies like virtio-mem) and memory allocators. In addition, we want
> to fail in a nice way if populating does not succeed because we are out of
> backend memory (which can happen easily with file-based mappings,
> especially tmpfs and hugetlbfs).

Could you explain a bit more on how do you plan to use this new interface for
the virtio-balloon scenario?

Meanwhile, here you seemed to be talking about file-backed mem, however later
it sounds more like for anonymous, so I'm slightly confused.

Thanks,

-- 
Peter Xu

