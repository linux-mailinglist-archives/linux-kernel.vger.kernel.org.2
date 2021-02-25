Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84382325991
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhBYWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234326AbhBYWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614291321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+533owFFoe3g0xTq7seU8RN9Dccv2HdyDhgPBrwMfSM=;
        b=QBYD9AzjfwOy7FUJ28dldZi7L+h46/u/YaZOhLh2ACNHR4ZVQ+5O6Uc0a8j51h/G21daMa
        xX8me5yicb/+mFDENgoJyiN5oOWrfmIRhcgoAPNxQbV/9OTTDfMCX5PG5DXGeEwTGXyzR4
        6fDpydKNBUBeJULmwXnIuBSQgo6i560=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-rQM6TUUnNFiBNjy3LLlibg-1; Thu, 25 Feb 2021 17:15:19 -0500
X-MC-Unique: rQM6TUUnNFiBNjy3LLlibg-1
Received: by mail-ej1-f72.google.com with SMTP id y3so2937066ejj.20
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+533owFFoe3g0xTq7seU8RN9Dccv2HdyDhgPBrwMfSM=;
        b=ByjrdKp4w/jQoDpyJrVhQmmGOyPL9fjEYBfiEmHyhisSCLh2kE5+PEJq+/55IXbYbk
         tx5oinZeoPE7dGwGF6gQiZnhmjEa6yKgQSSM4hIIzSTKl32JZx+Bl6xhyPRYLfn15rm0
         wIj3FFeOhyHZQNnH/0YIREtBEPGUJBLQoSpSU+xZ4GfoJMHrYxPoyUTxG5Lo0NhjFIcv
         /rGJIaqDb1Bs2upZ6T7BH4jn2BX1GdZ2KkL9tSV4VrUSnhJaMQSokpQDexXuTrPK/Pt6
         BaPKrd0Ra/k8WtL0sxSdRbYBo2DbfQSJ0ZRjNTBAlv/IN9NoLzCemrK6SFp9pUMA/5h0
         51uA==
X-Gm-Message-State: AOAM533hCwqLvZBcRupcmyJdg1vfBCc97sbqzZriBZcF55znE5u8Jny8
        qAXX/UtRngim7nFWAqqfNskBJLkywuVqsPrc0f99njgCqwiQMqS1n5cbBmDuzmGOF/TGmBWGZxk
        rj98NgtH+K+LroU44Uj+W83N9
X-Received: by 2002:a17:906:5acd:: with SMTP id x13mr4841441ejs.211.1614291318592;
        Thu, 25 Feb 2021 14:15:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsLOW/8G5/Ak1nix7I8hM+mG5Fh/maJBwHMgKJbldwwCRfHbbA63oUAdYER2wiGlo1aFp3nw==
X-Received: by 2002:a17:906:5acd:: with SMTP id x13mr4841423ejs.211.1614291318397;
        Thu, 25 Feb 2021 14:15:18 -0800 (PST)
Received: from ?IPv6:2a01:598:b880:cd5f:2452:43b8:4b31:c43? ([2a01:598:b880:cd5f:2452:43b8:4b31:c43])
        by smtp.gmail.com with ESMTPSA id a3sm3531876ejv.40.2021.02.25.14.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 14:15:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle free hugetlb pages
Date:   Thu, 25 Feb 2021 23:15:15 +0100
Message-Id: <1C808F10-158D-4DB8-A393-01829A398B17@redhat.com>
References: <b4bf7fcf-449d-daed-e490-994b1072652a@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b4bf7fcf-449d-daed-e490-994b1072652a@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.02.2021 um 22:43 schrieb Mike Kravetz <mike.kravetz@oracle.com>:
>=20
> =EF=BB=BFOn 2/10/21 12:23 AM, David Hildenbrand wrote:
>>> On 08.02.21 11:38, Oscar Salvador wrote:
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -952,6 +952,17 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
>>>                      low_pfn +=3D compound_nr(page) - 1;
>>>                      goto isolate_success_no_list;
>>>                  }
>>> +            } else {
>>=20
>> } else if (alloc_and_dissolve_huge_page(page))) {
>>=20
>> ...
>>=20
>>> +                /*
>>> +                 * Free hugetlb page. Allocate a new one and
>>> +                 * dissolve this is if succeed.
>>> +                 */
>>> +                if (alloc_and_dissolve_huge_page(page)) {
>>> +                    unsigned long order =3D buddy_order_unsafe(page);
>>> +
>>> +                    low_pfn +=3D (1UL << order) - 1;
>>> +                    continue;
>>> +                }
>>=20
>>=20
>>=20
>> Note that there is a very ugly corner case we will have to handle gracefu=
lly (I think also in patch #1):
>>=20
>> Assume you allocated a gigantic page (and assume that we are not using CM=
A for gigantic pages for simplicity). Assume you want to allocate another on=
e. alloc_pool_huge_page()->...->alloc_contig_pages() will stumble over the f=
irst allocated page. It will try to alloc_and_dissolve_huge_page() the exist=
ing gigantic page. To do that, it will alloc_pool_huge_page()->...->alloc_co=
ntig_pages() ... and so on. Bad.
>>=20
>=20
> Sorry for resurrecting an old thread.
> While looking at V3 of these patches, I was exploring all the calling
> sequences looking for races and other issues.  It 'may' be that the
> issue about infinitely allocating and freeing gigantic pages may not be
> an issue.  Of course, I could be mistaken.  Here is my reasoning:
>=20
> alloc_and_dissolve_huge_page (now isolate_or_dissolve_huge_page) will be
> called from __alloc_contig_migrate_range() within alloc_contig_range().
> Before calling __alloc_contig_migrate_range, we call start_isolate_page_ra=
nge
> to isolate all page blocks in the range.  Because all the page blocks in
> the range are isolated, another invocation of alloc_contig_range will
> not operate on any part of that range.  See the comments for
> start_isolate_page_range or commit 2c7452a075d4.  So, when
> start_isolate_page_range goes to allocate another gigantic page it will
> never notice/operate on the existing gigantic page.
>=20
> Again, this is confusing and I might be missing something.

I think you are right that the endless loop is blocked. But I think the whol=
e thing could cascade once we have multiple gigantic pages allocated.

Try allocating a new gpage. We find an existing gpage, isolate it and try to=
 migrate it. To do that, we try allocating a new gpage. We find yet another e=
xisting gpage, isolate and try to migrate it ... until we isolated all gpage=
s on out way to an actual usable area. Then we have to actually migrate all t=
hese in reverse order ...

Of course this only works if we can actually isolate a gigantic page - which=
 should be the case I think (they are migratable and should be marked as mov=
able).

>=20
> In any case, I agree that gigantic pages are tricky and we should leave
> them out of the discussion for now.  We can rethink this later if
> necessary.

Yes, it=E2=80=98s tricky and not strictly required right now because we neve=
r place them on ZONE_MOVABLE. And as I said, actual use cases might be rare.=

