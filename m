Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD8435253
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJTSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhJTSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634753100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Rqy0k0k2+9dGFIZEyrmWS0grYJHei54Mq69/JjUvUA=;
        b=SwqRNWTkVVnEkkp6ka07GqZYuKv/+A5pHlN94BsPB77mRKW/p4Oy4VxAs/fcrndNHeu6Z9
        i6zqlfp6R96fkmZRyGuBuZyyaJjvsAhBxMV1A+EulDpqZccLAxs1eAcGGcK9H/r6tycyML
        E8B3DH73JaEBhFtQ7JiQ/Cd0aQ8Sdxk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7nQdzHjRPGSPbNG7Y2NJZw-1; Wed, 20 Oct 2021 14:04:59 -0400
X-MC-Unique: 7nQdzHjRPGSPbNG7Y2NJZw-1
Received: by mail-wr1-f69.google.com with SMTP id r21-20020adfa155000000b001608162e16dso10240918wrr.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=+Rqy0k0k2+9dGFIZEyrmWS0grYJHei54Mq69/JjUvUA=;
        b=3tfgZiXDbcgnuonKwFnid3cOEVFufXBY/rqrwolCJll1HS3tOa6PINcIwF1OeMIXO9
         ejY8UPt/phnRQHIxyqWcNkXr17G4NhSM/gnqXhjkYvC/UEQc+CFfqsH9jwVA9RWXtR10
         EPKMO0M9Ni0rdpz2VNC53mGEHMj4bTeEqUDUQdQUjAqWT1ru5O9zvjI3VOcX2iOap9I8
         EpbJvPITiqMdfknwO2+CWvFhyBUGtDXu5C3hzHvGMLH08KZLBB3ZBtLXyvdWQVMEDJ89
         1o/qbE1wmMDd9c3NL+VN3JO0onEYE0oMDzPKkumzBeGy5mJ+S8y7HJlko1mPTGFAd/tj
         rEVA==
X-Gm-Message-State: AOAM530LTTc7ePJitStc3XhCf9GC2M2CiZ4dl5oY/LOFfG+V2GVGZZGc
        7kGK5tmOJi9UglgAw5XA476rPWBxNRsfdkg1NJkgpy0loE9+u+IlKLYZyr2UMpr8GUEMb2fZH7J
        bqLgiZ06+MAdMT/FfU2V2XxMF
X-Received: by 2002:adf:a3da:: with SMTP id m26mr917487wrb.336.1634753098347;
        Wed, 20 Oct 2021 11:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnbhcs8X/+Ni82lPE9E4UUTahXmAl5AM96VeEI/zc9Q//uwgL1v2x+2la/x4nZfuXGZRMdxA==
X-Received: by 2002:adf:a3da:: with SMTP id m26mr917444wrb.336.1634753098043;
        Wed, 20 Oct 2021 11:04:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63d4.dip0.t-ipconnect.de. [91.12.99.212])
        by smtp.gmail.com with ESMTPSA id t188sm2637956wma.43.2021.10.20.11.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 11:04:57 -0700 (PDT)
Message-ID: <436a9f9c-d5af-7d12-b7d2-568e45ffe0a0@redhat.com>
Date:   Wed, 20 Oct 2021 20:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
References: <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan> <YUtHCle/giwHvLN1@cmpxchg.org>
 <YWpG1xlPbm7Jpf2b@casper.infradead.org> <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org> <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <996b3ac4-1536-2152-f947-aad6074b046a@redhat.com>
 <YXBRPSjPUYnoQU+M@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
In-Reply-To: <YXBRPSjPUYnoQU+M@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.21 19:26, Matthew Wilcox wrote:
> On Wed, Oct 20, 2021 at 09:50:58AM +0200, David Hildenbrand wrote:
>> For the records: I was happy to see the slab refactoring, although I
>> raised some points regarding how to access properties that belong into
>> the "struct page".
> 
> I thought the slab discussion was quite productive.  Unfortunately,
> none of our six (!) slab maintainers had anything to say about it.  So I
> think it's pointless to proceed unless one of them weighs in and says
> "I'd be interested in merging something along these lines once these
> problems are addressed".

Yes, that's really unfortunate ... :(

> 
>> As raised elsewhere, I'd also be more comfortable
>> seeing small incremental changes/cleanups that are consistent even
>> without having decided on an ultimate end-goal -- this includes folios.
>> I'd be happy to see file-backed THP gaining their own, dedicated type
>> first ("struct $whatever"), before generalizing it to folios.
> 
> I am genuinely confused by this.
> 
> Folios are non-tail pages.  That's all.  There's no "ultimate end-goal".
> It's just a new type that lets the compiler (and humans!) know that this
> isn't a tail page.
> 
> Some people want to take this further, and split off special types from
> struct page.  I think that's a great idea.  I'm even willing to help.
> But there are all kinds of places in the kernel where we handle generic
> pages of almost any type, and so regardless of how much we end up
> splitting off from struct page, we're still going to want the concept
> of folio.

And I guess that generic mechanism is where the controversy starts and
where people start having different expectation. IMHO you can tell that
from the whole "naming" discussion/controversy. I always thought, why
not call it "struct compound_page" until I think someone commented that
it might not be a compound page but only a single base page somewhere.
But I got tired (most probably just like you) when reading all the wild
ideas and all the side discussions. Nobody can follow all that.

If we'd be limiting this to "this is an anon THP" and call it "struct
anon_thp", I assume the end result would be significantly easier. Anon
THP only make sense with pages >1, otherwise it's simply a base page and
has to be treated completely different by most MM code (esp. THP splitting).

Similarly, call it "struct filemap" (bad name) and define it as either
being a single page or a compound page, however, the head of the page
(what you call folio).


Let's think about this (and this is something that might happen for
real): assume we have to add a field for handling something about anon
THP in the struct page (let's assume in the head page for simplicity).
Where would we add it? To "struct folio" and expose it to all other
folios that don't really need it because it's so special? To "struct
page" where it actually doesn't belong after all the discussions? And if
we would have to move that field it into a tail page, it would get even
more "tricky".

Of course, we could let all special types inherit from "struct folio",
which inherit from "struct page" ... but I am not convinced that we
actually want that. After all, we're C programmers ;)

But enough with another side-discussion :)


Yes, the types is what I think is something very reasonable to have now
that we discussed it; and I think it's a valuable result of the whole
discussion. I consider it as the cleaner, smaller step.

> 
> I get that in some parts of the MM, we can just assume that any struct
> page is a non-tail page.  But that's not the case in the filemap APIs;
> they're pretty much all defined to return the precise page which contains
> the specific byte.  I think that's a mistake, and I'm working to fix it.
> But until it is all fixed [1], having a type which says "this is not a
> tail page" is, frankly, essential.

I can completely understand that the filemap API wants and needs such a
concept. I think having some way to do that for the filemap API is very
much desired.

-- 
Thanks,

David / dhildenb

