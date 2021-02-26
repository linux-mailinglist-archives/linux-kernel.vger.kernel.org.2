Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6D32600C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhBZJ3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbhBZJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614331558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2l5+I6W4V05+dmGrghLMdI2gVzdtzzFhQzH8nXmI6M=;
        b=dM4M5fWZUP0dCd8B3fgM5izAnSeiRQhq7QJ7DxEieAZpqeQcBiOKGA65FNmPbJDG9NvYiR
        3uVUrdUyeOf//s2+QBd4ONL4ikBFEEhcwQK4D3YzfCaARq0RgTV21hI6YrCQwAn5Ko8+pb
        yJAn7gdAb14mqe0pdDoHb8XS+UowN8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-2EKMBF7fMeeONTPdz_wxrw-1; Fri, 26 Feb 2021 04:25:53 -0500
X-MC-Unique: 2EKMBF7fMeeONTPdz_wxrw-1
Received: by mail-wm1-f71.google.com with SMTP id j10so1531600wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=T2l5+I6W4V05+dmGrghLMdI2gVzdtzzFhQzH8nXmI6M=;
        b=d5qCpJlsmiPCpfL3NMTU0ZIj1G+oqvaZKdM+H7+hnAi9z3CH/Nw8k/C+N8lGEo2hUy
         e+OBCh32S0dOytQ3z8QrwrnBkriZmvXxxCw69qSDY/HSVr8ZFFdJ+8bR0LMNvKGvC1Pk
         lU/zSSNp+cOMKZlaF5BvhVLA1cmKykXKqurm74tQqlrWX0fYLzQYvvAzZY4ar+7wa4Y5
         HMktxA1iGu1RiKLlfPs7uOpo/glJXwAxPmPPxKr1CyqpI5KqLf6m10vZ5NZe37ubRAKh
         +119r4NjMYzg7+MCRoqf504PmIgouCi6/9ik1VR6owjvjy6SOEWmmJsrygtx7qLVToBh
         ziTg==
X-Gm-Message-State: AOAM531fUptuSUO9B6EPVnnsKtf7RtnEnBHWHvHXfH3JqUg1x5HwMjax
        SPdn9WgaLC8w6yZ/EScy1LhBVegBrMWW78BykYUdj/UN270Xr3Ler6/QEgNHCHryJDQGnYx9ETB
        Tco0/jtB2IMXM6ZCGIn+QBOD/
X-Received: by 2002:a5d:4952:: with SMTP id r18mr2219321wrs.268.1614331552472;
        Fri, 26 Feb 2021 01:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK3P9d1lxR+Xyd0m/onYDYoGFVvo+pCNmt6qG49TdjEe1bmQtkOMnxXO3vpJ+gZg1OnU90LQ==
X-Received: by 2002:a5d:4952:: with SMTP id r18mr2219302wrs.268.1614331552212;
        Fri, 26 Feb 2021 01:25:52 -0800 (PST)
Received: from [192.168.3.108] (p5b0c63fb.dip0.t-ipconnect.de. [91.12.99.251])
        by smtp.gmail.com with ESMTPSA id i1sm10030446wmq.12.2021.02.26.01.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:25:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Date:   Fri, 26 Feb 2021 10:25:46 +0100
Message-Id: <1F1B32C0-10EA-4A7F-A062-1B8CE8D47C3F@redhat.com>
References: <YDizi3/TKYnSi5Zo@dhcp22.suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YDizi3/TKYnSi5Zo@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@suse.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 26.02.2021 um 09:38 schrieb Michal Hocko <mhocko@suse.com>:
>=20
> =EF=BB=BFOn Fri 26-02-21 09:35:10, Michal Hocko wrote:
>>> On Mon 22-02-21 14:51:36, Oscar Salvador wrote:
>>> alloc_contig_range will fail if it ever sees a HugeTLB page within the
>>> range we are trying to allocate, even when that page is free and can be
>>> easily reallocated.
>>> This has proved to be problematic for some users of alloc_contic_range,
>>> e.g: CMA and virtio-mem, where those would fail the call even when those=

>>> pages lay in ZONE_MOVABLE and are free.
>>>=20
>>> We can do better by trying to replace such page.
>>>=20
>>> Free hugepages are tricky to handle so as to no userspace application
>>> notices disruption, we need to replace the current free hugepage with
>>> a new one.
>>>=20
>>> In order to do that, a new function called alloc_and_dissolve_huge_page
>>> is introduced.
>>> This function will first try to get a new fresh hugepage, and if it
>>> succeeds, it will replace the old one in the free hugepage pool.
>>>=20
>>> All operations are being handled under hugetlb_lock, so no races are
>>> possible. The only exception is when page's refcount is 0, but it still
>>> has not been flagged as PageHugeFreed.
>>=20
>> I think it would be helpful to call out that specific case explicitly
>> here. I can see only one scenario (are there more?)
>> __free_huge_page()        isolate_or_dissolve_huge_page
>>                  PageHuge() =3D=3D T
>>                  alloc_and_dissolve_huge_page
>>                    alloc_fresh_huge_page()
>>                    spin_lock(hugetlb_lock)
>>                    // PageHuge() && !PageHugeFreed &&
>>                    // !PageCount()
>>                    spin_unlock(hugetlb_lock)
>>  spin_lock(hugetlb_lock)
>>  1) update_and_free_page
>>       PageHuge() =3D=3D F
>>       __free_pages()
>>  2) enqueue_huge_page
>>       SetPageHugeFreed()
>>  spin_unlock(&hugetlb_lock)               =20
>>=20
>>> In this case we retry as the window race is quite small and we have high=

>>> chances to succeed next time.
>>>=20
>>> With regard to the allocation, we restrict it to the node the page belon=
gs
>>> to with __GFP_THISNODE, meaning we do not fallback on other node's zones=
.
>>>=20
>>> Note that gigantic hugetlb pages are fenced off since there is a cyclic
>>> dependency between them and alloc_contig_range.
>>>=20
>>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>>=20
>> Thanks this looks much better than the initial version. One nit below.
>> Acked-by: Michal Hocko <mhocko@suse.com>
>=20
> Btw. if David has some numbers it would be great to add them to the
> changelog.

I=E2=80=98m planning on giving both patches a churn early next week, with

a) free huge pages
b) idle allocated huge pages
c) heavily read huge pages

(Them I=E2=80=98m also planning on having another brief look at the patches :=
) )

Thanks!=

