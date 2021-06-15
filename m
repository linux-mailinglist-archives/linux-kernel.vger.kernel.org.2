Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6213A88E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFOSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhFOSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623783173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nA288JO8PSyw9mKU3u+nzowGkx8Yk/ykJ4RqSFR/wM=;
        b=TB3q1CCSsjlrARjxgsQT3Q2naCkrHu3l/gntJ2u6x974dNjz8m4rfCqHAbhEz1s1m5KpbY
        PQTEeKPlaJEqcUMTLUZQhjw+p8if62qqVf7zOVKf/63qZgAXUTNwzyD+Lqz9TYVlLCnCYB
        xplW6Z80bMzg598sJbFMFu/RDuv0zGY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-msOaXtpGOYSdCX9F_s18xw-1; Tue, 15 Jun 2021 14:52:51 -0400
X-MC-Unique: msOaXtpGOYSdCX9F_s18xw-1
Received: by mail-qk1-f197.google.com with SMTP id 190-20020a3708c70000b02903aa60e6d8c1so21988845qki.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nA288JO8PSyw9mKU3u+nzowGkx8Yk/ykJ4RqSFR/wM=;
        b=esXF+WeftQPPleXoy3dPk4Y2lHdxGcdhVpZH/6ab9zSTKCHZB3aGafQgkceOp/B+qm
         X2QiZLe1mRWb4oyXqP9H+f69Ys/KrKdUk8hRCPeWkZqcrSOxKpAIaFMq6uIWUfA2zo2m
         Ze3gqG4t2TocrdZR3FRqtynpeZ4A5f3V8T+16HKK7sGsZoDdxl7QrtcVAc+gjmh45qOQ
         r/FFbsHXXdcEuCoreHenL3qn6nBSBUc46NhahI+pH0m6iJpC8mSH0mJY8X2pZ6T8OIkH
         6qKgHjkCnZN5ajBBlTGbDeLZYQ1WMd0LslWESMPa1mCGoJERlEc/x2a664xsYcB/xvIL
         to/Q==
X-Gm-Message-State: AOAM530K1b6wREXoaSOvmgHpgZKtEbBB4TifwdkHVuTbfWn4wEMBPHUs
        wTpbdjPS4ZppZROz3wcb/RpfzcLjzYVBkaJSSvT2oSl6ByISkfjbs0p2+XOU6gqg9/CfiN2XtZU
        /4T/oQExuQKsqaH7bhF1O1oET
X-Received: by 2002:a37:a513:: with SMTP id o19mr1107720qke.470.1623783171245;
        Tue, 15 Jun 2021 11:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ99edx7nfSWHifVKkoU4UY7i8EkmYP4SjCPEvUcoZGG0M/SSzwhh7wbXC8NWaWSNw3zYuug==
X-Received: by 2002:a37:a513:: with SMTP id o19mr1107699qke.470.1623783171024;
        Tue, 15 Jun 2021 11:52:51 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id q16sm12843398qkq.121.2021.06.15.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:52:50 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:52:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [PATCH] mm: relocate 'write_protect_seq' in struct mm_struct
Message-ID: <YMj3AeGMzEme/tcp@t490s>
References: <1623376482-92265-1-git-send-email-feng.tang@intel.com>
 <20210611170917.GW1002214@nvidia.com>
 <20210614032738.GA72794@shbuild999.sh.intel.com>
 <20210615011102.GA38780@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615011102.GA38780@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 09:11:03AM +0800, Feng Tang wrote:
> On Mon, Jun 14, 2021 at 11:27:39AM +0800, Feng Tang wrote:
> > > 
> > > It seems Ok to me, but didn't we earlier add the has_pinned which
> > > would have changed the layout too? Are we chasing performance delta's
> > > nobody cares about?
> > 
> > Good point! I checked my email folder for 0day's reports, and haven't
> > found a report related with Peter's commit 008cfe4418b3 ("mm: Introduce
> > mm_struct.has_pinned) which adds 'has_pinned' field. 
> > 
> > Will run the same test for it and report back.
> 
> I run the same will-it-scale/mmap1 case for Peter's commit 008cfe4418b3
> and its parent commit, and there is no obvious performance diff:
> 
> a1bffa48745afbb5 008cfe4418b3dbda2ff820cdd7b 
> ---------------- --------------------------- 
> 
>     344353            -0.4%     342929        will-it-scale.48.threads
>       7173            -0.4%       7144        will-it-scale.per_thread_ops
> 
> And from the pahole info for the 2 kernels, Peter's commit adds the
> 'has_pinned' is put into an existing 4 bytes hole, so all other following 
> fields keep their alignment unchanged. Peter may do it purposely 
> considering the alignment. So no performance change is expected.

Thanks for verifying this.  I didn't do it on purpose at least for the initial
version, but I do remember some comment to fill up that hole, so it may have
got moved around.

Also note that if nothing goes wrong, has_pinned will be gone in the next
release with commit 3c0c4cda6d48 ("mm: gup: pack has_pinned in MMF_HAS_PINNED",
2021-05-26); it's in -mm-next but not reaching the main branch yet.  So then I
think the 4 bytes hole should come back to us again, with no perf loss either.

What I'm thinking is whether we should move some important (and especially
CONFIG_* irrelevant) fields at the top of the whole struct define, make sure
they're most optimal for the common workload and make them static.  Then
there'll be less or no possibility some new field regress some common workload
by accident.  Not sure whether it makes sense to do so.

Thanks,

-- 
Peter Xu

