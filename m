Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0B30FE7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhBDUfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbhBDUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:33:50 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E991C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:33:10 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x81so4758149qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dix9FkD7Q8YvsbhJky2+W/nmTrrOT5ZKalVOWF+tmA4=;
        b=cDReKReTwzY2tEy8CRJVdi8dW4eTpCWSFoK/DAgetsqmSkAE0SjhMtop0C+tzZyHXe
         ZFYbRiqB9GdxJTTYEmeOBWpGKktel0p5pbUaRtIDGCk+m8sDube/UYt33Kam9Ddu99Rh
         XNEMmYFFu6iuQeUbcrdhEx7OznZh9uhoyM8jgiTREGAgvh+5nx71ab66DUY4tkuZnAqu
         1HYufMlNMn1JGPbP5rTAgd+3qzl8iN+HCJHLVB/lsb6Vo/AxFckEVcxuAqnlxODzIjFW
         4vFH8nqfzRKapeKAUSaYJ+aEe6hmE6tockmkb8P0l3xdZ0GnpilcTZl9Xh6JhFd9TPwS
         KlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dix9FkD7Q8YvsbhJky2+W/nmTrrOT5ZKalVOWF+tmA4=;
        b=Ak9JzIKC4/Y9A/4BSMAgvQPfEOP8kaaZBwx8NQsLsODnPxD1mCVLzsoPLTq0iGegv8
         8T8gT2mlmwDB2Rnr/V/OtzV/vV7QaCwuMbBfOm2PBLBJEOQRxdAjS8Z+q7xlE1jLZH+a
         5N0lpMvbAuh7CoP9HvoiwmnONUieG/Pm7k/GJl6Z8IPSKcCw+usa29wyXcfa/hfZnK6o
         5gfKxmdRBAa3FOWaHCuz/k3GTtZ5b22Gy4w0r+j2HJ1ZwkdZ9OVacMkh1JdKO4kJfOE0
         Ek3EA0aokKQcOB0ARn1OQLB1fiOfMbXxM1EGkJ5u6h6ZAiCK2opMCcMF2Lw55oM7GqIX
         z0hA==
X-Gm-Message-State: AOAM532grXVHpnR24RMyEaCsz7wymyr3pr8+3/4FpbNb+UHOSuklT9Dk
        Qsfxo3SrAJVl3q/Z62JX11Z14g==
X-Google-Smtp-Source: ABdhPJyEtwuXXyB00lgRC7eM+25Sj3EPce7HrV9Mel8mQaMcAOrHGScwlSChOxTQiprPAv/ifQ3CSg==
X-Received: by 2002:a37:9aca:: with SMTP id c193mr925374qke.91.1612470789613;
        Thu, 04 Feb 2021 12:33:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h8sm5398309qtm.5.2021.02.04.12.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:33:08 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l7lJM-003bYY-Dq; Thu, 04 Feb 2021 16:33:08 -0400
Date:   Thu, 4 Feb 2021 16:33:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@google.com>,
        Jann Horn <jannh@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] mm: Export follow_pte() for KVM so that KVM can stop
 using follow_pfn()
Message-ID: <20210204203308.GB4718@ziepe.ca>
References: <20210204171619.3640084-1-seanjc@google.com>
 <42ac99c2-830e-e4b7-00b9-011d531a0dda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ac99c2-830e-e4b7-00b9-011d531a0dda@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 06:19:13PM +0100, Paolo Bonzini wrote:
> On 04/02/21 18:16, Sean Christopherson wrote:
> > Export follow_pte() to fix build breakage when KVM is built as a module.
> > An in-flight KVM fix switches from follow_pfn() to follow_pte() in order
> > to grab the page protections along with the PFN.
> > 
> > Fixes: bd2fae8da794 ("KVM: do not assume PTE is writable after follow_pfn")
> > Cc: David Stevens <stevensd@google.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > Paolo, maybe you can squash this with the appropriate acks?
> 
> Indeed, you beat me by a minute.  This change is why I hadn't sent out the
> patch yet.
> 
> Andrew or Jason, ok to squash this?

I think usual process would be to put this in the patch/series/pr that
needs it.

Given how badly follow_pfn has been misused, I would greatly prefer to
see you add a kdoc along with exporting it - making it clear about the
rules.

And it looks like we should remove the range argument for modular use

And document the locking requirements, it does a lockless read of the
page table:

	pgd = pgd_offset(mm, address);
	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
		goto out;

	p4d = p4d_offset(pgd, address);

It doesn't do the trickery that fast GUP does, so it must require the
mmap sem in read mode at least.

Not sure I understand how fsdax is able to call it only under the
i_mmap_lock_read lock? What prevents a page table level from being
freed concurrently?

And it is missing READ_ONCE's for the lockless page table walk.. :(

Jason
