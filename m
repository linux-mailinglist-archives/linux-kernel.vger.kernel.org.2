Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76C1417C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbhIXULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344434AbhIXULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632514180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JF7bGwTByYC0+rcfVC0+8sx246e3qoBcuxrMSDsRAXE=;
        b=b5LmkMO8ktb5F4CCm7abbDKMKA9wIfxRkx/a4MEX9Y8ciTkgPqjWIJtPhDGwapIBeMRikw
        Pj4/s0CU9gPL29DMiJLN2Wy5bC91JiCPIOXJQosYNDMXhVyml4MpCffT5FBIZK/eu1lmZZ
        UQWxOTzFcfLlf2wQyvXUp3F3VpePPas=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-LIHcSs_YPvyYQQrGpjifcA-1; Fri, 24 Sep 2021 16:09:39 -0400
X-MC-Unique: LIHcSs_YPvyYQQrGpjifcA-1
Received: by mail-qt1-f198.google.com with SMTP id 13-20020ac8560d000000b0029f69548889so38657595qtr.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 13:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JF7bGwTByYC0+rcfVC0+8sx246e3qoBcuxrMSDsRAXE=;
        b=2v70lj0B3zPBf0OK/iP0nOtZG5WpL8W5RKmIdrY1hvCdUSE0kJWPhnTkGDhsuoDXqx
         MYMEzn2rxvwdac5CvmKvDbYUYnKTjV3+2XsJfeaNXcRJ97nTNNS0+DOMuNReduzmZ+pM
         PLIrEt+Q+Wx1Lde2OXgEUauI0TBDCiabA7e4ouFWG3ijFzqZsUebOzGU805MYDsIAiYF
         13Ozh42YQkCTv4TXoJobh5zZfnm6pid6tkQ80c45j9YhxuLFVL2RN8ty/NMN5WZwKpfk
         oZ7emiKBImM2RQ7hH2PfynaV+epQ8sxKBKvv0wl9yZzUYLhbTIhrsOJHgluLH1BS1Qg0
         FvBw==
X-Gm-Message-State: AOAM532e4pEGwfp/Vw7YuqsxuN6e7Ntm21jF/CjcncPy6P8zHoFsfWnN
        l5RT+G8i6bhYmOqS2IkAUxSnn1Z25EkzLD9Hgiz3H+ShkQv6O91zW1zZVLLFVWZMpoM91bzpbb0
        huUM4GSZVAWyNUUd3bIRrwiUB
X-Received: by 2002:a37:a943:: with SMTP id s64mr12516639qke.422.1632514179211;
        Fri, 24 Sep 2021 13:09:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3gxLjGPmfLb2ZJlaFoBhFN2L9UI1Qd+uCG2DUMhvj32SghjV5co3PJAnbwRLS3/NhRODzVw==
X-Received: by 2002:a37:a943:: with SMTP id s64mr12516610qke.422.1632514178902;
        Fri, 24 Sep 2021 13:09:38 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id x18sm7190271qkx.94.2021.09.24.13.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:09:38 -0700 (PDT)
Date:   Fri, 24 Sep 2021 16:09:37 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jue Wang <juew@google.com>
Cc:     James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] userfaultfd/selftests: fix feature support detection
Message-ID: <YU4wgSmStmkxxSt5@t490s>
References: <CAJHvVcgz18qU9vjPimOhJ5YswfJnLN0tQGfsgjCh6M7ckvhfgA@mail.gmail.com>
 <YUp438W5p5VHL1Ch@t490s>
 <CAJHvVciZc0mpcw8OSPk71YsVzCTajY+ikymcD3+zBJKsZynYkg@mail.gmail.com>
 <YUtoyNic4Jxfv9f7@t490s>
 <CAJHvVcg6PRCK_JcYEhRqq2vPyypnc+ySOtLhtFf5GrcQjimsJQ@mail.gmail.com>
 <YUulep3+YADkwlUu@t490s>
 <CAJHvVcijQdS_hfUnasz7BhhQeiHmNu=C5j8xfX=uWsfVO9-+Eg@mail.gmail.com>
 <YUvBEXV1Qs5wC+Jc@t490s>
 <CADrL8HUhV9ag6n3=MT2pNhtfrp8xH1Y-9zgispubzLy0ye6frw@mail.gmail.com>
 <CAPcxDJ6E3c2gcnJ8pDeQidf-yHDP7S=Knah_b3hy+FL1kOObqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcxDJ6E3c2gcnJ8pDeQidf-yHDP7S=Knah_b3hy+FL1kOObqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:43:40PM -0700, Jue Wang wrote:

[...]

> > > Could I know what's the workaround?  Normally if the workaround works solidly,
> > > then there's less need to introduce a kernel interface for that.  Otherwise I'm
> > > glad to look into such a formal proposal.
> >
> > The workaround is, for the region that you want to zap, run through
> > this sequence of syscalls: mumap, mmap, and re-register with
> > userfaultfd if it was registered before. If we're using tmpfs, we can
> > use madvise(DONTNEED) instead, but this is kind of an abuse of the
> > API. I don't think there's a guarantee that the PTEs will get zapped,
> > but currently they will always get zapped if we're using tmpfs. I
> > really like the idea of adding a new madvise() mode that is guaranteed
> > to zap the PTEs.

I see.

> >
> > >
> > > > It's also useful for memory poisoning, I think, if the host
> > > > decides some page(s) are "bad" and wants to intercept any future guest
> > > > accesses to those page(s).
> > >
> > > Curious: isn't hwpoison information come from MCEs; or say, host kernel side?
> > > Then I thought the host kernel will have full control of it already.
> > >
> > > Or there's other way that the host can try to detect some pages are going to be
> > > rotten?  So the userspace can do something before the kernel handles those
> > > exceptions?
> >
> > Here's a general idea of how we would like to use userfaultfd to support MPR:
> >
> > If a guest accesses a poisoned page for the first time, we will get an
> > MCE through the host kernel and send an MCE to the guest. The guest
> > will now no longer be able to access this page, and we have to enforce
> > this. After a live migration, the pages that were poisoned before
> > probably won't still be poisoned (from the host's perspective), so we
> > can't rely on the host kernel's MCE handling path. This is where
> > userfaultfd and this new madvise mode come in: we can just
> > madvise(MADV_ZAP) the poisoned page(s) on the target during a
> > migration. Now all accesses will be routed to the VMM and we can
> > inject an MCE. We don't *need* the new madvise mode, as we can also
> > use fallocate(PUNCH_HOLE) (works for tmpfs and hugetlbfs), but it
> > would be more convenient if we didn't have to use fallocate.
> >
> > Jue Wang can provide more context here, so I've cc'd him. There may be
> > some things I'm wrong about, so Jue feel free to correct me.
> >
> James is right.
> 
> The page is marked PG_HWPoison in the source VM host's kernel. The need
> of intercepting guest accesses to it exist on the target VM host, where
> the same physical page is no longer poisoned.
> 
> On the target host, the hypervisor needs to intercept all guest accesses
> to pages poisoned from the source VM host.

Thanks for these information, James, Jue, Axel.  I'm not familiar with memory
failures yet, so please bare with me with a few naive questions.

So now I can undertand that hw-poisonsed pages on src host do not mean these
pages will be hw-poisoned on dest host too, but I may have missed the reason on
why dest host needs to trap it with pgtable removed.

AFAIU after pages got hw-poisoned on src, and after vmm injects MCEs into the
guest, the guest shouldn't be accessing these pages any more, am I right?  Then
after migration completes, IIUC the guest shouldn't be accessing these pages
too.  My current understanding is, instead of trapping these pages on dest, we
should just (somehow, which I have no real idea...) un-hw-poison these pages
after migration because these pages are very possibly normal pages there.  When
there's real hw-poisoned pages reported on dst host, we should re-inject MCE
errors to guest with another set of pages.

Could you tell me where did I miss?

Thanks,

-- 
Peter Xu

