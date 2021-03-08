Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F7A3318B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCHUgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:36:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhCHUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615235762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtEM8SCXvIO16AentYXNZkKzs4IVjutP/ewH3m8Y9qw=;
        b=C9d/UX28SWxCOzmgek3TXGHtJg8ktB09wF9AV77yYw9vc+dY8YYLlIi3cMBUYs+mcUubFC
        PjS7C6oLFTwaYtiwDaHB+XnTb4dNOthH/SDFbcKRI0MtsZlzBA5ZvXi2g/ncG8GMn6lNHP
        zkk3YabAJ0wmbK5f8p5Ba8tj7uJlmgI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-cLgtGIahPhqMQ-xwExPDXw-1; Mon, 08 Mar 2021 15:36:01 -0500
X-MC-Unique: cLgtGIahPhqMQ-xwExPDXw-1
Received: by mail-wr1-f69.google.com with SMTP id e13so5344297wrg.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 12:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FtEM8SCXvIO16AentYXNZkKzs4IVjutP/ewH3m8Y9qw=;
        b=ar3xxCQ4CxweIV7grDuSN5swQjsVzAL+5MFTqj0Ll6j/RlSItbzFFoUNgGeN3QWSV/
         AjC8zQpvFwMYB1rknOWggT0EIxTCKg5cXCgOmU0geaSmeXdvSMxLduo1Ao+kyiYX4lHv
         vEjEyjLtE02FFfXtwYA1fnhk5Wib0iCj1nDFGCigyjmeQsDljOQqxf15B4aNkvcnSHi5
         cvSDyjCfa7cif7nQqMCOgCYD4UMslPa0EPMtxRClwrNmWNIq6TCAZFsQHaCtzELxivw1
         luhrPOyf3syfhbsB8c/1NnlenmSQyBBf45wxPEmlFGpsQEvRxUe4gQUs+jmV85UEQcEf
         IFPg==
X-Gm-Message-State: AOAM532UrbUnYZRKbyVqX8W87vm2E371X+5henDOcWLbpUO7BlMTeKFj
        7NPa3M/ZwK5KPAgwnex4VICjxxl5TePWFvXWEmH2XItawkN/yXJp/8aq6AF9+xfeUyiUqN4F0gB
        tS1+JJ28h3vHDE0DxzbdG5b3x
X-Received: by 2002:a5d:698d:: with SMTP id g13mr25530218wru.2.1615235759858;
        Mon, 08 Mar 2021 12:35:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM42sUxBjHtd8Lz8LSAruQlmts87ltWsaKFthq9Fv+YcDQ8wlH4KkqDNuaYsQk/GwjwHCPUQ==
X-Received: by 2002:a5d:698d:: with SMTP id g13mr25530205wru.2.1615235759653;
        Mon, 08 Mar 2021 12:35:59 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6c02.dip0.t-ipconnect.de. [91.12.108.2])
        by smtp.gmail.com with ESMTPSA id d29sm20522202wra.51.2021.03.08.12.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 12:35:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: huge_memory: a new debugfs interface for splitting THP tests.
Date:   Mon, 8 Mar 2021 21:35:58 +0100
Message-Id: <44C62A78-4B37-445D-A9F7-25D1A412A802@redhat.com>
References: <CAHbLzkqjeLZ2ZK=m3+nBqcM366gtq=Ug-=ALiSmnpi+FyZfjZQ@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
In-Reply-To: <CAHbLzkqjeLZ2ZK=m3+nBqcM366gtq=Ug-=ALiSmnpi+FyZfjZQ@mail.gmail.com>
To:     Yang Shi <shy828301@gmail.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 08.03.2021 um 21:18 schrieb Yang Shi <shy828301@gmail.com>:
>=20
> =EF=BB=BFOn Mon, Mar 8, 2021 at 11:30 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>>> On 08.03.21 20:11, Yang Shi wrote:
>>> On Mon, Mar 8, 2021 at 11:01 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>=20
>>>> On 8 Mar 2021, at 13:11, David Hildenbrand wrote:
>>>>=20
>>>>> On 08.03.21 18:49, Zi Yan wrote:
>>>>>> On 8 Mar 2021, at 11:17, David Hildenbrand wrote:
>>>>>>=20
>>>>>>> On 08.03.21 16:22, Zi Yan wrote:
>>>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>>>=20
>>>>>>>> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
>>>>>>>> <debugfs>/split_huge_pages_in_range_pid, THPs in the process with t=
he
>>>>>>>> given pid and virtual address range are split. It is used to test
>>>>>>>> split_huge_page function. In addition, a selftest program is added t=
o
>>>>>>>> tools/testing/selftests/vm to utilize the interface by splitting
>>>>>>>> PMD THPs and PTE-mapped THPs.
>>>>>>>=20
>>>>>>> Won't something like
>>>>>>>=20
>>>>>>> 1. MADV_HUGEPAGE
>>>>>>>=20
>>>>>>> 2. Access memory
>>>>>>>=20
>>>>>>> 3. MADV_NOHUGEPAGE
>>>>>>>=20
>>>>>>> Have a similar effect? What's the benefit of this?
>>>>>>=20
>>>>>> Thanks for checking the patch.
>>>>>>=20
>>>>>> No, MADV_NOHUGEPAGE just replaces VM_HUGEPAGE with VM_NOHUGEPAGE,
>>>>>> nothing else will be done.
>>>>>=20
>>>>> Ah, okay - maybe my memory was tricking me. There is some s390x KVM co=
de that forces MADV_NOHUGEPAGE and force-splits everything.
>>>>>=20
>>>>> I do wonder, though, if this functionality would be worth a proper use=
r interface (e.g., madvise), though. There might be actual benefit in having=
 this as a !debug interface.
>>>>>=20
>>>>> I think you aware of the discussion in https://lkml.kernel.org/r/d098c=
392-273a-36a4-1a29-59731cdf5d3d@google.com
>>>>=20
>>>> Yes. Thanks for bringing this up.
>>>>=20
>>>>>=20
>>>>> If there will be an interface to collapse a THP -- "this memory area i=
s worth extra performance now by collapsing a THP if possible" -- it might a=
lso be helpful to have the opposite functionality -- "this memory area is no=
t worth a THP, rather use that somehwere else".
>>>>>=20
>>>>> MADV_HUGE_COLLAPSE vs. MADV_HUGE_SPLIT
>>>>=20
>>>> I agree that MADV_HUGE_SPLIT would be useful as the opposite of COLLAPS=
E when user might just want PAGESIZE mappings.
>>>> Right now, HUGE_SPLIT is implicit from mapping changes like mprotect or=
 MADV_DONTNEED.
>>>=20
>>> IMHO, it sounds not very useful. MADV_DONTNEED would split PMD for any
>>> partial THP. If the range covers the whole THP, the whole THP is going
>>> to be freed anyway. All other places in kernel which need split THP
>>> have been covered. So I didn't realize any usecase from userspace for
>>> just splitting PMD to PTEs.
>>=20
>> THP are a limited resource. So indicating which virtual memory regions
>> are not performance sensitive right now (e.g., cold pages in a databse)
>> and not worth a THP might be quite valuable, no?
>=20
> Such functionality could be achieved by MADV_COLD or MADV_PAGEOUT,
> right? Then a subsequent call to MADV_NOHUGEPAGE would prevent from
> collapsing or allocating THP for that area.
>=20

I remember these deal with optimizing swapping. Not sure how they interact w=
ith THP, especially on systems without swap - I would guess they don=E2=80=98=
t as of now.

>>=20
>> --
>> Thanks,
>>=20
>> David / dhildenb
>>=20
>=20

