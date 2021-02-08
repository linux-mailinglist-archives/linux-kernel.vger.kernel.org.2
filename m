Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44CE3143BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBHX1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhBHX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:27:07 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E568C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 15:26:27 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id q85so4030576qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 15:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tPs7Rxd3+a1J4EcPtbp92Vc8SIRVzBfN6f0oIsK/9dE=;
        b=NGjt6irEWGzDe4R0vuCTGyrQtyj+Lqew2oddL9qXYYkTZi3hhtyG5TI8KRmoHku4Z6
         I/rDjvOu8LBsGkR/eDbnCjg+qzHLR5uL/lXzqVJBJWF7lTbDTTQnj31VWRcSSU38XJkF
         ZUXv2uerrPTteSPfpP/x7KBNkFNj34yXvDcbiUUJYe0CUwRKgxgPkWOYY+ixLlzPM+pG
         o08Os9fzu3jVp0yHonS5lYnDKycpicZDlNKLfkRCkp4Yc49CG/S+p/hSK0+Jdic42+BD
         FurImZvpISN/hhX+vEsJWpBVYY+XEF9zHrkBXlAuQkqpqhZvPqw2LoE8i2sMKsC9yd1i
         i34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tPs7Rxd3+a1J4EcPtbp92Vc8SIRVzBfN6f0oIsK/9dE=;
        b=t9Uwjr0hI/79CeXqk06cf/F4z05mG9gp1/vOf7g3yTviEpqK5xsYN2/W7P4/jWSaBs
         S6yeHERjpwhPx4+w8hPRvSsKRg9y3+YvXIXSz3zHNT23r0DV/gnKiyoY/DC+3rCWk3wv
         bwmnkaxpTlV83kd8wsUbBe5lAec3NRwUxJr77c9h7aYHpSbRl9sl37/w1OfygIYxPD8i
         Doskt1x6hi4pnPOxOTnPOcW1ZoM9PpVQQfBnTQvW7iBNMWlqBmv7YVPWQ6/1HqJ76Gn8
         G91eAt13ch2igM2lC66gi9HYioKcA/aWhcqHCp6iL6Iggdk/VHtSHcmbMVPQlofnqjo/
         a3HQ==
X-Gm-Message-State: AOAM531dAvRALXczS813MdQwfIqZnaJyu3X27yRlefyKYPiB4nZiAD9y
        eXiF0vw/KCDGC6kJU0zT1Gdwqg==
X-Google-Smtp-Source: ABdhPJwSgIbUiF0xJm2keLZ0APQp0Ru6baflVBIy955ENsWj4a1eAmS+5rWyR/uRtttw/vmjx7myMQ==
X-Received: by 2002:a05:620a:5fa:: with SMTP id z26mr19500613qkg.108.1612826786830;
        Mon, 08 Feb 2021 15:26:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id q55sm2537411qtq.57.2021.02.08.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 15:26:26 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9FvF-0057WX-GA; Mon, 08 Feb 2021 19:26:25 -0400
Date:   Mon, 8 Feb 2021 19:26:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     dan.j.williams@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/2] KVM: do not assume PTE is writable after follow_pfn
Message-ID: <20210208232625.GA4718@ziepe.ca>
References: <20210205103259.42866-1-pbonzini@redhat.com>
 <20210205181411.GB3195@xz-x1>
 <20210208185133.GW4718@ziepe.ca>
 <20210208220259.GA71523@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208220259.GA71523@xz-x1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:02:59PM -0500, Peter Xu wrote:
> On Mon, Feb 08, 2021 at 02:51:33PM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 05, 2021 at 01:14:11PM -0500, Peter Xu wrote:
> > 
> > > But I do have a question on why dax as the only user needs to pass in the
> > > notifier to follow_pte() for initialization.
> > 
> > Not sure either, why does DAX opencode something very much like
> > page_mkclean() with dax_entry_mkclean()?
> > 
> > Also it looks like DAX uses the wrong notifier, it calls
> > MMU_NOTIFY_CLEAR but page_mkclean_one() uses
> > MMU_NOTIFY_PROTECTION_PAGE for the same PTE modification sequence??
> > 
> > page_mkclean() has some technique to make the notifier have the right
> > size without becoming entangled in the PTL locks..
> 
> Right.  I guess it's because dax doesn't have "struct page*" on the
> back, so it

It doesn't? I thought DAX cases did?

Jason
