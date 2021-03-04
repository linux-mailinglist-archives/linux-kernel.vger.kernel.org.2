Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEB732D861
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbhCDRLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhCDRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:10:52 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2583EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:10:12 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w1so20972485qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4C5UfntIQbJJQjLRuQzufS05K/58468tb82tMiFSsZM=;
        b=HSai38wzaDryi2jAMn2E3ZE6uK/6d5A5Qyg2GGe/jzndcZue9IfncZCNIt91Z9iIP/
         yf9TVf2NIlQdLiDdygV5EXbsaUdeq0TNIxeyi54w+S1vBztIdsrzYFg4NCUIK19bz/Q0
         49YiBSJRWsm2jYhLRB8aRwlUCoE9bgTK7KK/X+KBSoC2H2UGCz2ELEgbpfkuNFoT5o56
         rQyGwZGu8XWb2VYUj1fAtrRw9A9DvLGMpsH1KyiewcqHkBLKmKGAlkeE0BU8ttEZOQyD
         sDU8AVVsg1do8dv+9iGUvpiM5ITBk+jRdnbbzUICrn7lBOyXKUVF0dRQ5bFgUl+iaCV7
         H+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4C5UfntIQbJJQjLRuQzufS05K/58468tb82tMiFSsZM=;
        b=qTv9TlASNLd8WhZyYoLUT/CRi6jgTwX2ovZW4IDaicGif68eNZSTKbtIXW5qyYTXoB
         ABHyEJH4WwqPMCz6OWhBfmxHSrk6tvUxYXYQ6N13v9Q5s8Etbnyg69/bAzOfdJ63DQHf
         2sua8afKcqlG0hdaAeXcd6w4KOgtomsLONaLlAf231TLnvIAXwG1gA66JD2tSjl9BzAL
         bZSXACtpa4cG+L7gNa3D1lOyP005uFv9QVXwk/iZ27lnbWgtzJpQWL2lEqFS3tEibAAI
         aIdwdNCgfrHRaNPYyxUd3RamF737rZL7QfqXmyBqErG/6IJZ6pCa0PMzeqrT8qVDuxBJ
         sBeg==
X-Gm-Message-State: AOAM5337HPxgnCQBPWiLMNRI12czjNZAP6taR5PUxCf4ak+Ybhgj3Utt
        CZ/fNuy4fhG2415pG3VO+RazHw==
X-Google-Smtp-Source: ABdhPJxV8Y6PAdtuqbxzj7Dn9OqmlHiG8ZB2QmAZBd5dcaWF2KHqeUkxa8VKVG61OAnM8HpHXjGasg==
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr3517476qtp.380.1614877811377;
        Thu, 04 Mar 2021 09:10:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id o79sm10320790qka.116.2021.03.04.09.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 09:10:09 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lHrUH-006fXp-12; Thu, 04 Mar 2021 13:10:09 -0400
Date:   Thu, 4 Mar 2021 13:10:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 0/5] mm/hugetlb: Early cow on fork, and a few cleanups
Message-ID: <20210304171009.GF444867@ziepe.ca>
References: <20210217233547.93892-1-peterx@redhat.com>
 <20210301141151.GA397383@xz-x1>
 <20210301162846.c1f684a5662d37bbec3f1892@linux-foundation.org>
 <20210303014655.GS397383@xz-x1>
 <CAHk-=wgh+f7+qj5pgfvZnJa_v+=BKuUS7d33e5xvk1Fa0esCXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgh+f7+qj5pgfvZnJa_v+=BKuUS7d33e5xvk1Fa0esCXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 06:45:49PM -0800, Linus Torvalds wrote:
> On Tue, Mar 2, 2021 at 5:47 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > As Jason and Wei pointed out, I think some userspace still got corrupted data
> > without this series when using hugetlb backend.  I don't think it'll suite for
> > a late RC release but it'll still be great if it can be considered as an early
> > rc candidate, ideally rc1 of course.  If you prefer the other way, I can also
> > repost it before 5.13 merge window opens.
> 
> I think with my merge window delay issue, you guys have the perfect
> excuse for pushing it a bit late and it still hitting 5.12

Andrew did you need something further from Peter? I don't see it in linux-next?

Jason
