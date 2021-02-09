Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA43144D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBIAYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhBIAYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612830199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TP6uJnqeuWbRiNKlKQkquP+smnR+VHjueUIpOLLNaCQ=;
        b=NRJAKviCmtJYKa8VClXLGmrAcdej2poDCJG+pTqUROA5ky+S/XBoCVjVX/f+CjRHOvJ+UH
        KNzmJSl054u1iCxd8DQyx7APakqzGZVMiMDzVWt59Fo28xuToZNlkNTWLyKFIyBU93VHQT
        o8SR8bNsOkZ54V5NRgnhZmlnSL4Pdek=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-PSrR0E13PdClFVbvNvAqGw-1; Mon, 08 Feb 2021 19:23:17 -0500
X-MC-Unique: PSrR0E13PdClFVbvNvAqGw-1
Received: by mail-qt1-f199.google.com with SMTP id z18so605330qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 16:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TP6uJnqeuWbRiNKlKQkquP+smnR+VHjueUIpOLLNaCQ=;
        b=g7aGD9iI3/iiPurergSSE2n7TuK6rzQE9BVam/68ppFEtMXtzsnL6b3toDaSkXfw54
         6Bq/H6WoeWXqwbLwIbueQtbyjEwp9arSCrUewgrjFWzTa9VXuNZEgw8LdvMpWwsq8Ku7
         hPkxwwXWxJcedNCNKe9tNbf8fyVMYTmlOGN9Zs5RuQ0HGMEr4QSCoUASFGIQNMywBozh
         dfOpnN0WOxPxlFh9xLkMe3Cff6+nJA+mxWemmI/QNbItJyEb2HX6Sx3ktD09pPSdNuXJ
         CnOBp5MrpQtXtWBPwaCsp1LxDyB0VwGnkQVeaVB4XY6NpQ+Cy8UGmjLCMT9J24Z0Julx
         hQgA==
X-Gm-Message-State: AOAM531w5/svwHzc8EQbXcHPjojgm8EUn0NUFPpH5OTmwC+R3t8Hw9YK
        5QH8wpUS5beiEFmU3bnBJ+gy1a6XDbxLvU7yqTE9RnNZibc7ZTbLINCk6KhmNLe5lYD8OLYAN9t
        pEatdM85DnXzU7cX5YuqNtAPG
X-Received: by 2002:a05:620a:544:: with SMTP id o4mr21023317qko.285.1612830196951;
        Mon, 08 Feb 2021 16:23:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWNs4U+EA9v9RcX9qjKDT/ZuKzhasdvMhBjPXS/jV1Gn6jl2zjma9dO8fkqgPdHV9iV1j83A==
X-Received: by 2002:a05:620a:544:: with SMTP id o4mr21023305qko.285.1612830196770;
        Mon, 08 Feb 2021 16:23:16 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id d71sm17505236qkc.75.2021.02.08.16.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 16:23:16 -0800 (PST)
Date:   Mon, 8 Feb 2021 19:23:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dan.j.williams@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] KVM: do not assume PTE is writable after follow_pfn
Message-ID: <20210209002314.GC78818@xz-x1>
References: <20210205103259.42866-1-pbonzini@redhat.com>
 <20210205181411.GB3195@xz-x1>
 <20210208185133.GW4718@ziepe.ca>
 <20210208220259.GA71523@xz-x1>
 <20210208232625.GA4718@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208232625.GA4718@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 07:26:25PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 08, 2021 at 05:02:59PM -0500, Peter Xu wrote:
> > On Mon, Feb 08, 2021 at 02:51:33PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 05, 2021 at 01:14:11PM -0500, Peter Xu wrote:
> > > 
> > > > But I do have a question on why dax as the only user needs to pass in the
> > > > notifier to follow_pte() for initialization.
> > > 
> > > Not sure either, why does DAX opencode something very much like
> > > page_mkclean() with dax_entry_mkclean()?
> > > 
> > > Also it looks like DAX uses the wrong notifier, it calls
> > > MMU_NOTIFY_CLEAR but page_mkclean_one() uses
> > > MMU_NOTIFY_PROTECTION_PAGE for the same PTE modification sequence??
> > > 
> > > page_mkclean() has some technique to make the notifier have the right
> > > size without becoming entangled in the PTL locks..
> > 
> > Right.  I guess it's because dax doesn't have "struct page*" on the
> > back, so it
> 
> It doesn't? I thought DAX cases did?

I'm not familiar with dax at all.. but it seems so: e.g. dax_iomap_pte_fault()
looks like the general fault handler for dax mappings, in which there's calls
to things like vmf_insert_mixed_mkwrite() trying to install ptes with raw pfn.
Or I could also be missing something very important..  Thanks,

-- 
Peter Xu

