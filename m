Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9441504A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhIVTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhIVTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632337124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ofPcTS/frwqtKKjQDjZ8KF5U88MhOUDV+L9va2W8ZM=;
        b=cbb5moN7q4785lp4ti/jfNkgcAw9VTrMzyr8Aa0iK+SLHOu1wDmRk7ITt5OxiFmSLc7h7O
        UW6PbE4Cwvr1I1+pI/tyIUEmhcPmrzvZOKA6rnfe2DiBQ3IrkqX77H5YvkZkU1bcsP6/mu
        DS3PqOdy4GBD4HJp7JWzPHFFoWFjJo0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-LI7AWH2RPmm97VmBqRE9zA-1; Wed, 22 Sep 2021 14:58:42 -0400
X-MC-Unique: LI7AWH2RPmm97VmBqRE9zA-1
Received: by mail-qv1-f69.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so13438220qvy.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ofPcTS/frwqtKKjQDjZ8KF5U88MhOUDV+L9va2W8ZM=;
        b=ByerSr/KA40Yyn/hX+6RFGbpeOpBAX+ouncmbLGoSjRxvdHmfa1m8dYb5agE9icA2/
         4ECH9ncv4w17O3gjx9JsOotDFZjdOZR2VcD3Haq5yOPdihrBPi1NtqC5c4No+CC4QyhD
         2gX/nOdmNf4239HWhu8lk58pht+F3JjDCLys5tXwmOfar2OkdR1CqI+3QU049sIEIK8r
         NUAbja6J1CgwkSa8Z22tZ4XUp3ftJTHj8FC+EdnHp5gzlyyXrVFXRAI9EHpzSnZ3an1i
         dPaZy9EtwzNnzpO4SGRBklzO0Z/HMSh6B0IVJ3KGi5UCZxB6fE5YgkUbJ708WAzy2b+K
         zl+Q==
X-Gm-Message-State: AOAM533f3M/82L02lGTMnvedl2lfPklRNatDf2JfrJQ6CdrSPmazOxh2
        z8OS7GlDSAzNFblmkhGTWplfAGdD5MALg78YN94hK8TPSvE/zesmy2FT9UfrvZZ2j3bwMIXkTIh
        Gi+DKzA+IfGshucIp57lHssGp
X-Received: by 2002:a05:6214:44f:: with SMTP id cc15mr652425qvb.6.1632337122267;
        Wed, 22 Sep 2021 11:58:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdziVJ7/s9bivZNO1Y6zqgwQrqh8ywi/LR/XDhj5zKc+Q4un+WmnGk28QCYMLRSTQt7VpsIA==
X-Received: by 2002:a05:6214:44f:: with SMTP id cc15mr652399qvb.6.1632337122015;
        Wed, 22 Sep 2021 11:58:42 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id c16sm1579816qkk.113.2021.09.22.11.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 11:58:41 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:58:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
Message-ID: <YUt833H6eaYFyHXD@t490s>
References: <20210922175156.130228-1-peterx@redhat.com>
 <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:21:40PM +0200, David Hildenbrand wrote:
> On 22.09.21 19:51, Peter Xu wrote:
> > We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
> > scanning right after we detected a uffd-wp armed pte (either present, or swap).
> > 
> > It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
> > enabled VMAs.  Checking against the vma flag would be more efficient, and good
> > enough.  To be explicit, we could still be able to merge some thps for
> > VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
> > ptes, however that's not a major target for thp collapse anyways.
> > 
> 
> Hm, are we sure there are no users that could benefit from the current
> handling?
> 
> I'm thinking about long-term uffd-wp users that effectively end up wp-ing on
> only a small fraction of a gigantic vma, or always wp complete blocks in a
> certain granularity in the range of THP.

Yes, that's a good question.

> 
> Databases come to mind ...

One thing to mention is that this patch didn't forbid thp being used within a
uffd-wp-ed range.  E.g., we still allow thp exist, we can uffd-wp a thp and
it'll split only until when the thp is written.

While what this patch does is it stops khugepaged from proactively merging
those small pages into thps as long as VM_UFFD_WP|VM_UFFD_MINOR is set.  It may
still affect some user, but it's not a complete disable on thp.

> 
> In the past, I played with the idea of using uffd-wp to protect access to
> logically unplugged memory regions part of virtio-mem devices in QEMU --
> which would exactly do something as described above. But I'll most probably
> be using ordinary uffd once any users that might read such logically
> unplugged memory have been "fixed".

Yes, even if you'd like to keep using uffd-wp that sounds like a very
reasonable scenario.

> 
> The change itself looks sane to me AFAIKT.

So one major motivation of this patch of mine is to prepare for shmem, because
the old commit obviously only covered anonymous.

But after a 2nd thought, I just noticed shmem shouldn't have a problem with
khugepaged merging at all!

The thing is, when khugepaged is merging a shmem thp, unlike anonymous, it'll
not merge the ptes into a pmd, but it'll simply zap the ptes.  It means all
uffd-wp tracking information won't be lost even if merging happened, those info
will still be kept inside pgtables using (the upcoming) pte markers.

When faulted, we'll just do small page mappings while it won't stop the shmem
thp from being mapped hugely in other mm, afaict.

With that in mind, indeed I see this patch less necessary to be merged; so for
sparsely wr-protected vmas like virtio-mem we can still keep some of the ranges
mergeable, that sounds a good thing to keep it as-is.

NACK myself for now: let's not lose that good property of both thp+uffd-wp so
easily, and I'll think more of it.

(To Axel: my question to minor mode handling thp still stands, I think..)

Thanks,

-- 
Peter Xu

