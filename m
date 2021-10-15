Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBBA42E9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbhJOHNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhJOHNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:13:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F20C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:11:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so7813783pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=zm7YkG8ue0/7nw5ACjv9T9SMPdO+s6Vc7kJ3z0VxOjs=;
        b=Ks4MhnG8gr5R2uZppwO3waPIx+5PyMZMgj8SQAU5hSDNKzLfP+yQh6+QS4605rjkjf
         z8m5LsJpZrAXEZNXARJVg3WIg4U8D7tgN9QujADBFaMhADruF3fItiY1ZWFj37qNg1H0
         gviF4gNsA0rw8+fUZe0AjjGb2lo4HvdCHEnvtl85qpmvP8ps14TpyYK5VAySgTsi+Z2D
         Qr4TvDn14TP3eQD0Qfs7IgD0cuG5Fx6cmq6AJRDK9SWCIsLvd+DKaNi/YufHrZnwYJT1
         aYNmqrS+3g3XqHZvvpbGvInDzQ+s7NCSrpXQ1aOfAxTzLNcqTnaTdx8Koz17wNLIQoIw
         rWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=zm7YkG8ue0/7nw5ACjv9T9SMPdO+s6Vc7kJ3z0VxOjs=;
        b=geVT6NtUHOSqZz/Pwncz8hmN00TjTtnUcMvBHb2zBo+1UVYL69JLbZmBveQ1nREPBy
         +Jn24eQrDT15LbldRH4WhZK0WPYsGbCes07qZLzmAFBe07BXNRfyur0nkXIoDqi8/aaI
         8dUW84WwRYQq9CjwFtSqhM6f1VHIvPDKYeqWG5EwrQzfywuTKWp9Yj2u1GgomR96nEIQ
         T0fJQKelN1hDaDeuEzwPfmQ6OsgRk5bMMAlz9kLWZ+ZULTIBs01UavoE2zPgy+dcJhcz
         qsrS6NGSxsLqqfGhiPdXuUsGdCGjA0oiDOhJOtGKRWzi/Tuun7R9w/ltSnYlASAgXasR
         ODrg==
X-Gm-Message-State: AOAM531q869wAGlNvepXHu69hb/ap/0AmZEhkC5H0UVl/kAf6+IL0bYG
        3OZIgbuUjUTJuXTuQSa5WD5WRZp/zHA=
X-Google-Smtp-Source: ABdhPJyQry1SwSFnaYo9cSK7x1MFZG/FzFi5GjSU/nnkwPvoCieRdvRSAKO/fFIe5EZiSOHXfJUgmg==
X-Received: by 2002:a63:2dc7:: with SMTP id t190mr7968460pgt.455.1634281890421;
        Fri, 15 Oct 2021 00:11:30 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id x129sm4348269pfc.140.2021.10.15.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 00:11:30 -0700 (PDT)
Date:   Fri, 15 Oct 2021 17:11:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Chen Wandun <chenwandun@huawei.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, guohanjun@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
        <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
        <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
        <1634261360.fed2opbgxw.astroid@bobo.none>
        <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com>
In-Reply-To: <d1f7249d-ffc2-7038-ed4c-f7fbb3e68eda@huawei.com>
MIME-Version: 1.0
Message-Id: <1634281763.ecsq6l88ia.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Chen Wandun's message of October 15, 2021 12:31 pm:
>=20
>=20
> =E5=9C=A8 2021/10/15 9:34, Nicholas Piggin =E5=86=99=E9=81=93:
>> Excerpts from Chen Wandun's message of October 14, 2021 6:59 pm:
>>>
>>>
>>> =E5=9C=A8 2021/10/14 5:46, Shakeel Butt =E5=86=99=E9=81=93:
>>>> On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wr=
ote:
>>>>>
>>>>> Eric Dumazet reported a strange numa spreading info in [1], and found
>>>>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introdu=
ced
>>>>> this issue [2].
>>>>>
>>>>> Dig into the difference before and after this patch, page allocation =
has
>>>>> some difference:
>>>>>
>>>>> before:
>>>>> alloc_large_system_hash
>>>>>       __vmalloc
>>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>>>               __vmalloc_node_range
>>>>>                   __vmalloc_area_node
>>>>>                       alloc_page /* because NUMA_NO_NODE, so choose a=
lloc_page branch */
>>>>>                           alloc_pages_current
>>>>>                               alloc_page_interleave /* can be proved =
by print policy mode */
>>>>>
>>>>> after:
>>>>> alloc_large_system_hash
>>>>>       __vmalloc
>>>>>           __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>>>               __vmalloc_node_range
>>>>>                   __vmalloc_area_node
>>>>>                       alloc_pages_node /* choose nid by nuam_mem_id()=
 */
>>>>>                           __alloc_pages_node(nid, ....)
>>>>>
>>>>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"=
),
>>>>> it will allocate memory in current node instead of interleaving alloc=
ate
>>>>> memory.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k=
6JJc7JR2XYn6k_Q@mail.gmail.com/
>>>>>
>>>>> [2]
>>>>> https://lore.kernel.org/linux-mm/CANn89iLofTR=3DAK-QOZY87RdUZENCZUT4O=
6a0hvhu3_EwRMerOg@mail.gmail.com/
>>>>>
>>>>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
>>>>> Reported-by: Eric Dumazet <edumazet@google.com>
>>>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>>>>> ---
>>>>>    mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>>>>>    1 file changed, 26 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>>> index f884706c5280..48e717626e94 100644
>>>>> --- a/mm/vmalloc.c
>>>>> +++ b/mm/vmalloc.c
>>>>> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>>                   unsigned int order, unsigned int nr_pages, struct p=
age **pages)
>>>>>    {
>>>>>           unsigned int nr_allocated =3D 0;
>>>>> +       struct page *page;
>>>>> +       int i;
>>>>>
>>>>>           /*
>>>>>            * For order-0 pages we make use of bulk allocator, if
>>>>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>>           if (!order) {
>>>>
>>>> Can you please replace the above with if (!order && nid !=3D NUMA_NO_N=
ODE)?
>>>>
>>>>>                   while (nr_allocated < nr_pages) {
>>>>>                           unsigned int nr, nr_pages_request;
>>>>> +                       page =3D NULL;
>>>>>
>>>>>                           /*
>>>>>                            * A maximum allowed request is hard-coded =
and is 100
>>>>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>>>                            */
>>>>>                           nr_pages_request =3D min(100U, nr_pages - n=
r_allocated);
>>>>>
>>>>
>>>> Undo the following change in this if block.
>>>
>>> Yes, It seem like more simpler as you suggested, But it still have
>>> performance regression, I plan to change the following to consider
>>> both mempolcy and alloc_pages_bulk.
>>=20
>> Thanks for finding and debugging this. These APIs are a maze of twisty
>> little passages, all alike so I could be as confused as I was when I
>> wrote that patch, but doesn't a minimal fix look something like this?
>=20
> Yes, I sent a patch=EF=BC=8Cit looks like as you show, besides it also
> contains some performance optimization.
>=20
> [PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy to=20
> accelerate memory allocation

Okay. It would be better to do it as two patches. First the minimal fix=20
so it can be backported easily and have the Fixes: tag pointed at my=20
commit. Then the performance optimization.

Thanks,
Nick
