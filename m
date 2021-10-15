Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53242E62D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhJOBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhJOBgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:36:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 18:34:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 187so6997530pfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=aeHR4HNV08DQbiiZQFZN18RReASa+1UHOE+54acdClw=;
        b=RJBiRmNjNWsZrBiTBmCFvjfj39B3qOKJHp+OKl29GcX/dP7wBhv7C/dxbYm3gIjdw+
         8+Y1Ehhx3XZpw1pMIz2C/h/hZE60EDkkU84fWAtoGuleHXXAVr2AWN+0y3sp3E9BEcR3
         B1Bnhc736DUARRf3cac+2Q991vCHU+Xw5kQpy+yggFMELM2v9hc3H+uK5QqwFO+v1yVl
         QYD78LL+Y4C7zUDR1+WgN+zQK4JKq4V4k1ZykpLhx+hBM7KMeMRXzg+Kqgo72reTsv+v
         k2kPAcUsMtPOxkcnZMxPpnLKQqQTb61u+nUXcvM9DkZ5cgPZnON2SBmmP5kWEFYwT2Fl
         UcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=aeHR4HNV08DQbiiZQFZN18RReASa+1UHOE+54acdClw=;
        b=vP2lQWDFhoCI4QsurvQwHGl/UjpgtDchynrA2whmmDlpuIg7Oq3TPheIIcdDTXUlez
         GLJuUsmRZbmNmOZu24aNFUTejK6ZZnt4UwvyvjyuAsEeM4540r6BzvW5tlJpaZvvIEBY
         WUk/TEkOuJ2HmcQEnpV2nUujvW/nQenevIZC/ZNmVUx1n9PCImCsgBcYgDdDymRwYDwl
         hZqVru5btd4q1Odd7YFX6Wy/mVa9vCd/htx0CUkV2w0EA0z7DMkB0KnRZwqqLYpbvE+c
         uqse9RXcnQHjFxHj/E0gxpkdxSsjVMI8Aa+oEu481663+QJ21nsC91Hl8gQBrlbEGAFO
         IBtQ==
X-Gm-Message-State: AOAM533j6+FvyYB7llipxSzWNdl+leZyR+cmKSGoyHkKb+fHJkW9zdvu
        gKaLgwP3hlAIq6jtNAmgPp8=
X-Google-Smtp-Source: ABdhPJyMdU3nfnnnytfCEZKrmlfEpVLdQbKy6mCluOA010xJTo0/rlZX9GBIDumitdnSx1bq+bfUJw==
X-Received: by 2002:a62:1d08:0:b0:44c:6f89:85ef with SMTP id d8-20020a621d08000000b0044c6f8985efmr8970950pfd.42.1634261653886;
        Thu, 14 Oct 2021 18:34:13 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id 192sm3455942pfy.121.2021.10.14.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 18:34:13 -0700 (PDT)
Date:   Fri, 15 Oct 2021 11:34:08 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
To:     Chen Wandun <chenwandun@huawei.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, guohanjun@huawei.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?q?Kefeng=0A?= Wang <wangkefeng.wang@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
        <CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com>
        <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
In-Reply-To: <8fc5e1ae-a356-6225-2e50-cf0e5ee26208@huawei.com>
MIME-Version: 1.0
Message-Id: <1634261360.fed2opbgxw.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Chen Wandun's message of October 14, 2021 6:59 pm:
>=20
>=20
> =E5=9C=A8 2021/10/14 5:46, Shakeel Butt =E5=86=99=E9=81=93:
>> On Tue, Sep 28, 2021 at 5:03 AM Chen Wandun <chenwandun@huawei.com> wrot=
e:
>>>
>>> Eric Dumazet reported a strange numa spreading info in [1], and found
>>> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduce=
d
>>> this issue [2].
>>>
>>> Dig into the difference before and after this patch, page allocation ha=
s
>>> some difference:
>>>
>>> before:
>>> alloc_large_system_hash
>>>      __vmalloc
>>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>              __vmalloc_node_range
>>>                  __vmalloc_area_node
>>>                      alloc_page /* because NUMA_NO_NODE, so choose allo=
c_page branch */
>>>                          alloc_pages_current
>>>                              alloc_page_interleave /* can be proved by =
print policy mode */
>>>
>>> after:
>>> alloc_large_system_hash
>>>      __vmalloc
>>>          __vmalloc_node(..., NUMA_NO_NODE, ...)
>>>              __vmalloc_node_range
>>>                  __vmalloc_area_node
>>>                      alloc_pages_node /* choose nid by nuam_mem_id() */
>>>                          __alloc_pages_node(nid, ....)
>>>
>>> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
>>> it will allocate memory in current node instead of interleaving allocat=
e
>>> memory.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6J=
Jc7JR2XYn6k_Q@mail.gmail.com/
>>>
>>> [2]
>>> https://lore.kernel.org/linux-mm/CANn89iLofTR=3DAK-QOZY87RdUZENCZUT4O6a=
0hvhu3_EwRMerOg@mail.gmail.com/
>>>
>>> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
>>> Reported-by: Eric Dumazet <edumazet@google.com>
>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>>> ---
>>>   mm/vmalloc.c | 33 ++++++++++++++++++++++++++-------
>>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index f884706c5280..48e717626e94 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -2823,6 +2823,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>                  unsigned int order, unsigned int nr_pages, struct page=
 **pages)
>>>   {
>>>          unsigned int nr_allocated =3D 0;
>>> +       struct page *page;
>>> +       int i;
>>>
>>>          /*
>>>           * For order-0 pages we make use of bulk allocator, if
>>> @@ -2833,6 +2835,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>          if (!order) {
>>=20
>> Can you please replace the above with if (!order && nid !=3D NUMA_NO_NOD=
E)?
>>=20
>>>                  while (nr_allocated < nr_pages) {
>>>                          unsigned int nr, nr_pages_request;
>>> +                       page =3D NULL;
>>>
>>>                          /*
>>>                           * A maximum allowed request is hard-coded and=
 is 100
>>> @@ -2842,9 +2845,23 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>                           */
>>>                          nr_pages_request =3D min(100U, nr_pages - nr_a=
llocated);
>>>
>>=20
>> Undo the following change in this if block.
>=20
> Yes, It seem like more simpler as you suggested, But it still have=20
> performance regression, I plan to change the following to consider
> both mempolcy and alloc_pages_bulk.

Thanks for finding and debugging this. These APIs are a maze of twisty=20
little passages, all alike so I could be as confused as I was when I
wrote that patch, but doesn't a minimal fix look something like this?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d77830ff604c..75ee9679f521 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2860,7 +2860,10 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                struct page *page;
                int i;
=20
-               page =3D alloc_pages_node(nid, gfp, order);
+               if (nid =3D=3D NUMA_NO_NODE)
+                       page =3D alloc_pages(gfp, order);
+               else
+                       page =3D alloc_pages_node(nid, gfp, order);
                if (unlikely(!page))
                        break;
=20

Thanks,
Nick
