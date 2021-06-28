Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B09B3B6890
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhF1Siz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234624AbhF1Six (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624905387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rpyYS4aMlbJs7+S8vLgIMcBLCr2xnKpzKiRrhW0l4+Y=;
        b=bgvtERx+wYfoaveuc8JqRBAkc+/4f0ENsHLRGJYnxGiOMVXk23BMBG6qO3ZEnljqhk9KfQ
        vOXROZWCPZwBzol6und/BTc1wxMbU+vOpa4M90jO5ga3fM+o3CCRkjMifCpylBoTmgFSnR
        GIkdXOwRxvv03LIurFxAB/g19l/tuBU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-px-Ikkt8OH-snjkzRXieRA-1; Mon, 28 Jun 2021 14:36:24 -0400
X-MC-Unique: px-Ikkt8OH-snjkzRXieRA-1
Received: by mail-oo1-f70.google.com with SMTP id t19-20020a4ae4130000b029023950cb8d35so12178863oov.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 11:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpyYS4aMlbJs7+S8vLgIMcBLCr2xnKpzKiRrhW0l4+Y=;
        b=UqfY4gM7zGd+zqt3oUmnBkrA2K+i4fXZw5eOucfT0190yP5f39MPf3ffduvUsMjbXl
         myh4HS+muftmugDpjT+7DFlINXlotoBQ9HHgNT1eofhP2wBnqSTgKCQ0XBcDvJBMAzGJ
         i0fgpaR9/xZmv2lG6wUm6I1yin7jH5kdP2v55aX+au7KaGRABd/3I0uqV5V7p2thk24t
         t84AkHYCoc3oeSubzGoiTzfjqRlmCIIYyifeQpjmLzUmM/h1k9TR/A8E/iUGGQGhYapj
         L1CHytct5Y6DfwsTPE4Njj9gbRq/WIMSBitSPTd693/A1OvRXj3s9hpiqc+Njb4F5djG
         u2aA==
X-Gm-Message-State: AOAM530i4ymicUFkBta+LbMjlqjeKaD/gSgACbBZ+WLzZWpqhUtmRC0T
        12oNoqo2fbkm/+yzo37r5YI0feu+hsy9PIndhuL2KZPKeqCRd0jVzawvvaw47z7Qr459tf95GXb
        cUJEbUAZjUSyKFIbbpLmzJy1h
X-Received: by 2002:a9d:75c2:: with SMTP id c2mr831424otl.348.1624905383338;
        Mon, 28 Jun 2021 11:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXti3P+IcH5ZHbUOams0qcERA6rX7AwmQaBi719AT7VIYyhawZGywWKLoSb7TWkl8IdaEUqA==
X-Received: by 2002:a9d:75c2:: with SMTP id c2mr831415otl.348.1624905383157;
        Mon, 28 Jun 2021 11:36:23 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id n16sm2615961oor.47.2021.06.28.11.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:36:22 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:36:21 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com, prime.zeng@hisilicon.com, cohuck@redhat.com
Subject: Re: [PATCH v2] vfio/pci: Handle concurrent vma faults
Message-ID: <20210628123621.7fd36a1b.alex.williamson@redhat.com>
In-Reply-To: <20210628173028.GF4459@nvidia.com>
References: <161540257788.10151.6284852774772157400.stgit@gimli.home>
        <20210628104653.4ca65921.alex.williamson@redhat.com>
        <20210628173028.GF4459@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 14:30:28 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 28, 2021 at 10:46:53AM -0600, Alex Williamson wrote:
> > On Wed, 10 Mar 2021 11:58:07 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > vfio_pci_mmap_fault() incorrectly makes use of io_remap_pfn_range()
> > > from within a vm_ops fault handler.  This function will trigger a
> > > BUG_ON if it encounters a populated pte within the remapped range,
> > > where any fault is meant to populate the entire vma.  Concurrent
> > > inflight faults to the same vma will therefore hit this issue,
> > > triggering traces such as:  
> 
> If it is just about concurrancy can the vma_lock enclose
> io_remap_pfn_range() ?

We could extend vma_lock around io_remap_pfn_range(), but that alone
would just block the concurrent faults to the same vma and once we
released them they'd still hit the BUG_ON in io_remap_pfn_range()
because the page is no longer pte_none().  We'd need to combine that
with something like __vfio_pci_add_vma() returning -EEXIST to skip the
io_remap_pfn_range(), but I've been advised that we shouldn't be
calling io_remap_pfn_range() from within the fault handler anyway, we
should be using something like vmf_insert_pfn() instead, which I
understand can be called safely in the same situation.  That's rather
the testing I was hoping someone who reproduced the issue previously
could validate.
 
> > IIRC, there were no blocking issues on this patch as an interim fix to
> > resolve the concurrent fault issues with io_remap_pfn_range().
> > Unfortunately it also got no Reviewed-by or Tested-by feedback.  I'd
> > like to put this in for v5.14 (should have gone in earlier).  Any final
> > comments?  Thanks,  
> 
> I assume there is a reason why vm_lock can't be used here, so I
> wouldn't object, though I don't especially like the loss of tracking
> either.

There's no loss of tracking here, we were only expecting a single fault
per vma to add the vma to our list.  This just skips adding duplicates
in these cases where we can have multiple faults in-flight.  Thanks,

Alex

