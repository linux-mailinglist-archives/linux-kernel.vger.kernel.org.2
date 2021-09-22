Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D77415433
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhIVXvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238541AbhIVXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632354582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omSt3JLppABnkkTziz8DoRFcEud7eDSDemkN9abf1/s=;
        b=MXgnX4jiv6Kytjl/kwW06h2JLQUjsPk+GvKollQ4hdbJQrh3Dr6ZTjSea3WLan8XaypB62
        WwTfhFVXXe+3LfdUu6Ae/aroTKQuH0G77ciTJlcD0m3R/R5YE/z5gbpuNzt7etbCv/kpFs
        vmjB8qw8YD8muuANwQK1GH+p0UrGQyw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-Gb5ZdidtMiuD3wfgnF8M6g-1; Wed, 22 Sep 2021 19:49:40 -0400
X-MC-Unique: Gb5ZdidtMiuD3wfgnF8M6g-1
Received: by mail-qk1-f198.google.com with SMTP id az30-20020a05620a171e00b00432eb71d467so13859138qkb.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omSt3JLppABnkkTziz8DoRFcEud7eDSDemkN9abf1/s=;
        b=XEEo6opEU0yMdM3PLAj1qJkkuNn4juonqI4BzoH4f3BDW2Fo285Q70QSWbBv121Ha3
         6xbXBRHt7VxrdTkVjIHCSUSAXgBhlfCPM/TQNaobcWRZO68+Pyuk5qnstv7+4zEmGBWR
         lxbxfvvZYnLH7P4DnjLRfo93XR9LDl78XSxjIs6lMWfCAsT5zFjhVTf82EpBfok4hZsr
         W+fgLxuPmxQnafTEM82zNUHrcConX0noqUfklhosUol4UTdhT00XpJ+b05KR/v6g68r+
         Xj6lxYraPwPC82Cs0Da+ORBZJIMUn4topbWglkSpmBu/8u2PWHIMZWVo+iL+25HcZGAd
         JkvA==
X-Gm-Message-State: AOAM533fx1cDYZjSWXiIRqr2sB0s4iBMCD0AMjmIeZxh5212u0KPC/1E
        bMsYsUmW2n7bbuPeZMiexsm+FRsAJWXNYBAQevNKlqJd1a4CZfjC+8kHLCIC1olCmmNmwdiXBPH
        uw/niVk3EXuPHHTO6l3eyi6JC
X-Received: by 2002:ad4:5569:: with SMTP id w9mr1775727qvy.52.1632354580066;
        Wed, 22 Sep 2021 16:49:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCdoM1GRE07kCEtSb93RXwmmhtccuFEOrQUiN2B6B068zbi1IqfsdT7iiHsx11Lp/nV+NgzA==
X-Received: by 2002:ad4:5569:: with SMTP id w9mr1775718qvy.52.1632354579802;
        Wed, 22 Sep 2021 16:49:39 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id v3sm2986083qkd.20.2021.09.22.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 16:49:38 -0700 (PDT)
Date:   Wed, 22 Sep 2021 19:49:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YUvBEXV1Qs5wC+Jc@t490s>
References: <YUoaDr2wsW8wtk5Z@t490s>
 <CAJHvVcj68inRrpmw0pJq9qFc20JzG8+s7b31HkXQcsLcAJN_0Q@mail.gmail.com>
 <YUowr6phZU4v7dds@t490s>
 <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s>
 <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s>
 <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
 <YUulep3+YADkwlUu@t490s>
 <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:29:42PM -0700, Axel Rasmussen wrote:
> On Wed, Sep 22, 2021 at 2:52 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Sep 22, 2021 at 01:54:53PM -0700, Axel Rasmussen wrote:
> > > On Wed, Sep 22, 2021 at 10:33 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Hello, Axel,
> > > >
> > > > On Wed, Sep 22, 2021 at 10:04:03AM -0700, Axel Rasmussen wrote:
> > > > > Thanks for discussing the design Peter. I have some ideas which might
> > > > > make for a nicer v2; I'll massage the code a bit and see what I can
> > > > > come up with.
> > > >
> > > > Sure thing.  Note again that as I don't have a strong opinion on that, feel
> > > > free to keep it.  However if you provide v2, I'll read.
> > > >
> > > > [off-topic below]
> > > >
> > > > Another thing I probably have forgot but need your confirmation is, when you
> > > > worked on uffd minor mode, did you explicitly disable thp, or is it allowed?
> > >
> > > I gave a more detailed answer in the other thread, but: currently it
> > > is allowed, but this was a bug / oversight on my part. :) THP collapse
> > > can break the guarantees minor fault registration is trying to
> > > provide.
> >
> > I've replied there:
> >
> > https://lore.kernel.org/linux-mm/YUueOUfoamxOvEyO@t490s/
> >
> > We can try to keep the discussion unified there regarding this.
> >
> > > But there's another scenario: what if the collapse happened well
> > > before registration happened?
> >
> > Maybe yes, but my understanding of the current uffd-minor scenario tells me
> > that this is fine too.  Meanwhile I actually have another idea regarding minor
> > mode, please continue reading.
> >
> > Firstly, let me try to re-cap on how minor mode is used in your production
> > systems: I believe there should have two processes A and B, if A is the main
> > process, B could be the migration process.  B migrates pages in the background,
> > while A so far should have been stopped and never ran.  When we want to start
> > A, we should register A with uffd-minor upon the whole range (note: I think so
> > far A does not have any pgtable mapped within uffd-minor range).  Then any page
> > access of A should kick B and asking "whether it is the latest page", if yes
> > then UFFDIO_CONTINUE, if no then B modifies the page, plus UFFDIO_CONTINUE
> > afterwards.  Am I right above?
> >
> > So if that's the case, then A should have no page table at all.
> >
> > Then, is that a problem if the shmem file that A maps contains huge thps?  I
> > think no - because UFFDIO_CONTINUE will only install small pages.
> >
> > Let me know if I'm understanding it right above; I'll be happy to be corrected.
> 
> Right, except that our use case is even more similar to QEMU: the code
> doing UFFDIO_CONTINUE / demand paging, and the code running the vCPUs,
> are in the same process (same mm) - just different threads.

I see.

> 
> >
> > Actually besides this scenario, I'm also thinking of another scenario of using
> > minor fault in a single process - that's mostly what QEMU is doing right now,
> > as QEMU has the vcpu threads and migration thread sharing a single mm/pgtable.
> > So I think it'll be great to have a new madvise(MADV_ZAP) which will tear down
> > all the file-backed memory pgtables of a specific range.  I think it'll suite
> > perfectly for the minor fault use case, and it can be used for other things
> > too.  Let me know what you think about this idea, and whether that'll help in
> > your case too (e.g., if you worry a current process A mapped huge shmem thp
> > somewhere, we can use madvise(MADV_ZAP) to drop it).
> 
> Yes, this would be convenient for our implementation too. :) There are
> workarounds if the feature doesn't exist, but it would be nice to
> have.

Could I know what's the workaround?  Normally if the workaround works solidly,
then there's less need to introduce a kernel interface for that.  Otherwise I'm
glad to look into such a formal proposal.

> It's also useful for memory poisoning, I think, if the host
> decides some page(s) are "bad" and wants to intercept any future guest
> accesses to those page(s).

Curious: isn't hwpoison information come from MCEs; or say, host kernel side?
Then I thought the host kernel will have full control of it already.

Or there's other way that the host can try to detect some pages are going to be
rotten?  So the userspace can do something before the kernel handles those
exceptions?

-- 
Peter Xu

