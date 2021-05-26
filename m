Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94081390D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 02:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhEZAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 20:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232466AbhEZAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 20:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621989383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QQCbsE9nrJN8+nNyi5jRwRh60Z9Mhr/wKU96F+K8Wk=;
        b=QhQ5ghCFjNrWP8jwNauRElt5q/oifS19kuevVfJqByH9RRLcqT0g3M4UCjrKBtYCsef6L+
        /0fYoaQxXwQPeSU1oSZVkS5b7suB9Qjyzt5cQvCbEmSOL3AK3wWQtE7wbnZITccfJgOy6K
        +BLHU3PEfSnKyW9XyDrGG43XkL+qS7w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-Ga3FOYrOPHOask1oJPJfEQ-1; Tue, 25 May 2021 20:36:21 -0400
X-MC-Unique: Ga3FOYrOPHOask1oJPJfEQ-1
Received: by mail-qv1-f72.google.com with SMTP id h10-20020a0cab0a0000b029020282c64ecfso13077891qvb.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 17:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QQCbsE9nrJN8+nNyi5jRwRh60Z9Mhr/wKU96F+K8Wk=;
        b=HNhZJ6Luq50RPn+KF+y/+mUsBnYDfM4Dfl5uLAbZG/3ZNeal6lVPNV+62bzhX0UKa2
         M4ZoWTBHVrvyn0/otiYLMeAkPBfIe2eTKPjqpMzXAVCYOTl4nIJsHMwOqpSbuAC5hvGj
         EbKTN1XuZjQYWcOI4o66PmfBOC4w2t2shrW1l4KWF9Ekk4yynyjpd4bLbPty5m6RgFye
         /bxX9hBdoFcJDZQHrFkFxlKkhhunzFpkHFvsV45vJesS0tU3Nshjj1Zhi7q0dQYRqq6J
         e3JtOycPPe0q9Hgk5OCWEUq9Dkv8fNo6IWtHHS20ngbidjvvP5FtKBluvXOi3Wnkhc+W
         ILxA==
X-Gm-Message-State: AOAM532PTKH2POHv28cZ5rHOJDmhb8YtZTFDJitHTuTXPbSMekO1TZkZ
        VJMF+Te0/MDhJ9AH6jJ/fhOhSLCjB30wfI29N2X3Kai2/x/hugjCqs91SM0Dqu476acfnsxBWNj
        /nNCQn4iT/SvF1U6PFEMnhBZW
X-Received: by 2002:ae9:edc9:: with SMTP id c192mr35574942qkg.312.1621989380820;
        Tue, 25 May 2021 17:36:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDlNUzm3gb3pSpCP2Aln5V5qEqEPNKVi6kDoAZ8azpepBiFQgjGScdd+xeQ75TMGddkTcnLw==
X-Received: by 2002:ae9:edc9:: with SMTP id c192mr35574911qkg.312.1621989380538;
        Tue, 25 May 2021 17:36:20 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id t13sm497164qtn.63.2021.05.25.17.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 17:36:19 -0700 (PDT)
Date:   Tue, 25 May 2021 20:36:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 2/6] mm/userfaultfd: Fix uffd-wp special cases for fork()
Message-ID: <YK2YArvcaabj8GHi@t490s>
References: <20210428225030.9708-1-peterx@redhat.com>
 <20210428225030.9708-3-peterx@redhat.com>
 <20210525171558.3b223a89c16bdf002f3e83cf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525171558.3b223a89c16bdf002f3e83cf@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 05:15:58PM -0700, Andrew Morton wrote:
> This run afoul of Alistair's "mm: Device exclusive memory access",
> https://lkml.kernel.org/r/20210524132725.12697-8-apopple@nvidia.com
> 
> `vma' is now undeclared.  I think this?
> 
> --- a/mm/memory.c~mm-userfaultfd-fix-uffd-wp-special-cases-for-fork-fix
> +++ a/mm/memory.c
> @@ -850,8 +850,8 @@ copy_nonpresent_pte(struct mm_struct *ds
>  		 * exclusive entries currently only support private writable
>  		 * (ie. COW) mappings.
>  		 */
> -		VM_BUG_ON(!is_cow_mapping(vma->vm_flags));
> -		if (try_restore_exclusive_pte(src_mm, src_pte, vma, addr))
> +		VM_BUG_ON(!is_cow_mapping(dst_vma->vm_flags));

This one looks good, as both src_vma/dst_vma should have the same flags related
to is_cow.

> +		if (try_restore_exclusive_pte(src_mm, src_pte, dst_vma, addr))

Should this be s/dst_vma/src_vma/ perhaps?  Alistairs please correct me
otherwise, as it tries to restore the pte for src mm not dst (the child).

I haven't yet got time to look at the new series, planning to do it tomorrow
maybe.. but I see that it's already queued in -mm.  Andrew, we do have chance
to go back if necessary, right?

I haven't looked at the rest, but I think try_restore_exclusive_pte() can at
least drop the *mm pointer as it's never used (even if we need, we've got
vma->vm_mm too)..

-- 
Peter Xu

