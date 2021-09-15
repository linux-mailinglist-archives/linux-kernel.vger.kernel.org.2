Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF240BDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhIOCyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhIOCyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631674373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mNknc3PAGLPEbfdAPlC78Lmk68krcKaGTS1ga1ZhVzQ=;
        b=CRAQuLwXkHE4vrRV7X778tcZGJiZ6THphx098dsNsfaN3gZffUm2b74XtLW/xuVDdAnlRO
        NRgJRiQJk6yZmgeVV/3ZlltX7KOzt6Ux6K33/zeaHmkIFVyyCbWzyMBcWdA4ahG5E2f8gE
        8Hw5fsiDmnK3XTwG9GQJ9EXEHGa/Grs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-hPlLvY-mMwyqdBJPrs_wGQ-1; Tue, 14 Sep 2021 22:52:51 -0400
X-MC-Unique: hPlLvY-mMwyqdBJPrs_wGQ-1
Received: by mail-io1-f69.google.com with SMTP id y1-20020a6bc801000000b005d0abb2b449so793754iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mNknc3PAGLPEbfdAPlC78Lmk68krcKaGTS1ga1ZhVzQ=;
        b=BLuddLgHcdNihLBAySuJnv7nDXlwglYM8u0ky84jiKgb69Uh6xpd1pnTttaHozrO2H
         3eoxRO4gVWjZpPUO6NeTblfCohHmJCerNkppnYfEXm40SdeMoLyUR2u6tyDs61Ob+J+O
         1vLDjpi25B2u3K+ud6sPNb5Yzh11ZSt64ygSyh7qiyBlkZbVayvZiGjG/KlOW/inxcT+
         lzJMMYM2BD8jM9CFPL4ifceVFgQygqDKIuB5kHELYROCIQaKkJaTp9J/7sAuEwGzFTpp
         I0I/yKSgRqO9eI4UEC7zgYDi3z5YvI+RMkMO4Gg8XojX4N28q1JDC6fsYdlGjP5QE5oR
         eoIg==
X-Gm-Message-State: AOAM533DHyxF7OrOH6wKvUqHkXIJe6SOyN2HjQZrmBzOCYapbh3S/GJM
        wSXZ3XyX//yKzSaWAMpEoyzlrB8bmjx7Jeuvc2/pUYXyjCvOS1wcHbEIhZ9TC5hAqpVZlN5l/OG
        U4uD9QGNmgdticy7n0jqnm5KF
X-Received: by 2002:a05:6e02:144c:: with SMTP id p12mr9551344ilo.292.1631674371219;
        Tue, 14 Sep 2021 19:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHNRphTXwxe/+Sfyf1gmfRf0CW0WLj7r6TJhh24pys6jEp3ccyd4fnS3xT0F3TuQSiiABz9A==
X-Received: by 2002:a05:6e02:144c:: with SMTP id p12mr9551326ilo.292.1631674370967;
        Tue, 14 Sep 2021 19:52:50 -0700 (PDT)
Received: from xz-m1.local ([2607:fea8:56a2:9100:f950:40ca:dc9b:42e7])
        by smtp.gmail.com with ESMTPSA id t15sm7375529ioi.7.2021.09.14.19.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 19:52:50 -0700 (PDT)
Date:   Tue, 14 Sep 2021 22:52:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
Message-ID: <YUFgAPJJxy8L4GMP@xz-m1.local>
References: <20210908163516.214441-1-peterx@redhat.com>
 <20210908163628.215052-1-peterx@redhat.com>
 <2576475.WBpAVSM2eX@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2576475.WBpAVSM2eX@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alistair,

On Wed, Sep 15, 2021 at 12:25:07PM +1000, Alistair Popple wrote:
> On Thursday, 9 September 2021 2:36:28 AM AEST Peter Xu wrote:
> > Firstly, the comment in zap_pte_range() is misleading because it checks against
> > details rather than check_mappings, so it's against what the code did.
> > 
> > Meanwhile, there's no explicit reason why passing in the details pointer should
> > mean to skip all swap entries.  New user of zap_details could very possibly
> > miss this fact if they don't read deep until zap_pte_range() because there's no
> > comment at zap_details talking about it at all, so swap entries could be
> > erroneously skipped without being noticed.
> > 
> > This partly reverts 3e8715fdc03e ("mm: drop zap_details::check_swap_entries"),
> > but introduce ZAP_FLAG_SKIP_SWAP flag, which means the opposite of previous
> > "details" parameter: the caller should explicitly set this to skip swap
> > entries, otherwise swap entries will always be considered (which should still
> > be the major case here).
> > 
> > We may want to look into when exactly we need ZAP_FLAG_SKIP_SWAP and we should
> > have it in a synchronous manner, e.g., currently even if ZAP_FLAG_SKIP_SWAP is
> > set we'll still look into swap pmds no matter what.  But that should be a
> > separate effort of this patch.
> 
> I didn't really follow what you mean by "synchronous" here, although the
> explanation about pmds makes sense so it's probably just terminology.

Yes, maybe I should use "aligned manner", or please suggest anything that
sounds better; sorry for my awkward English.

>  
> > The flag introduced in this patch will be a preparation for more bits defined
> > in the future, e.g., for a new bit in flag to show whether to persist the
> > upcoming uffd-wp bit in pgtable entries.
> 
> That's kind of the problem. The patch itself looks correct to me however as
> mentioned it is mostly reverting a previous cleanup and it's hard to tell why
> that's justified without the subsequent patches. Perhaps it makes the usage of
> zap_details a bit clearer, but a comment also would with less code.
> 
> I know you want to try and shrink the uffd-wp series but I think this patch
> might be easier to review if it was included as part of that series.

I posted it because I think it's suitable to have it even without uffd-wp.

I tried to explain it above on two things this patch wanted to fix:

Firstly the comment is wrong; we've moved back and forth on changing the
zap_details flags but the comment is not changing along the way and it's not
matching the code right now.

Secondly I do think we should have a flag showing explicit willingness to skip
swap entries.  Yes, uffd-wp is the planned new one, but my point is anyone who
will introduce a new user of zap_details pointer could overlook this fact.  The
new flag helps us to make sure someone will at least read the flags and know
what'll happen with it.

For the 2nd reasoning, I also explicitly CCed Kirill too, so Kirill can provide
any comment if he disagrees.  For now, I still think we should keep having such
a flag otherwise it could be error-prone.

Could you buy-in above reasoning?

Basically above is what I wanted to express in my commit message.  I hope that
can justify that this patch (even if extremly simple) can still be considered
as acceptable upstream even without uffd-wp series.

If you still insist on this patch not suitable for standalone merging and
especially if some other reviewer would think the same, I can move it back to
uffd-wp series for sure.  Then I'll repost this series with 4 patches only.

In all cases, thanks for looking at the series.

-- 
Peter Xu

