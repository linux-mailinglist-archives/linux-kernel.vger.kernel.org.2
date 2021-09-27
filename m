Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585214194B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhI0NBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhI0NBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:01:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A97C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:59:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so17740856pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hkKh8BhLSfCbj1zhtuZadMT8kTOtwFNe1ZknKGQvtw8=;
        b=I1rSGypxqGABhU/ICvtsq7GZCjHEkFiwxbooPx5yiZd8UHpgpsVReOOg66Xs6h/vEL
         pzUwX/odsC9m8alsUkvxDZvHW7cY95ZgYfFjJRksMuR0rgcE8V/sc6j3IHKu8XSHtZpk
         a1q6KGayEjU6YVifnhJAkXqPPOlH0q8lpuEBBEq9Ynqe68UdeObJ1bacXJc6J5BP1Zkr
         NMSha0t4kIAwPPNOPiXIeUZnI/NUV+q/VOmlyNrI2CCtZ5ly6MHU8v11Bek3TQb6SMuv
         s5p8sjkUdPA7OAG8pUJukwsa+FmhSeccAHdSqTSpc+CeFJWGQn2EOFFxtQ5KZJecgHlp
         xLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hkKh8BhLSfCbj1zhtuZadMT8kTOtwFNe1ZknKGQvtw8=;
        b=4taKwiS0jdOg0Il0eOOY11VL1dGxsj9dJTlq+oM2KW2PfycnE1GRjvP0YP6Z2Oj/Uq
         1Fq3MK5b5WQJnSfz0hEKLLPeq3DIT2UIVb/+YIdIRX5/Aegis45AaxMjW9MyHk8wGFAN
         h0deUSvh9M1NwY/6xfFr25xhWyWHNmKEX4GCbpCenNhpgQQiHYXCM9LLMoKxJVyuEWPx
         3YPjNRWzroUhAl0Mix1DHnChacctOADKr0Dj+1fGEx8K14eq/NuKyS+3nJnbtsI9mbS8
         rONw2tSbCLnPfDsYTZmmKHT0THGHtwrld/I55K9BjEKbm2XI+zufXvdKK50YQBAn1l/V
         6MVw==
X-Gm-Message-State: AOAM5320lHNgKl2FMLTkwDbVpohaSGyR/VxWYBYIxZCecX5ejXxpfIBr
        18XdlLLxm+Z7DqsK0RVCt4Q=
X-Google-Smtp-Source: ABdhPJwrporjblo/EPRBfimIXexZclTNbr8Rc5LE+xA/OJufJu5iD1kw1ckHW8MtLSkNrlU54+nfLQ==
X-Received: by 2002:a63:e408:: with SMTP id a8mr16532631pgi.184.1632747592800;
        Mon, 27 Sep 2021 05:59:52 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g8sm16583032pfv.51.2021.09.27.05.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:59:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927124518.gjas4itro5c3park@box.shutemov.name>
Date:   Mon, 27 Sep 2021 05:59:50 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6496185C-6792-4D67-AF5D-E049A8DC65B8@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
 <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
 <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
 <20210927115507.6xfpugeg3swookbh@box>
 <4211F6D4-A282-4AB4-8D96-E273C5ABE0DF@gmail.com>
 <20210927124518.gjas4itro5c3park@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 5:45 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Mon, Sep 27, 2021 at 05:33:39AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Sep 27, 2021, at 4:55 AM, Kirill A. Shutemov =
<kirill@shutemov.name> wrote:
>>>=20
>>> On Mon, Sep 27, 2021 at 03:11:20AM -0700, Nadav Amit wrote:
>>>>=20
>>>>> On Sep 27, 2021, at 2:08 AM, Kirill A. Shutemov =
<kirill@shutemov.name> wrote:
>>>>>=20
>>>>> On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
>>>>>> From: Nadav Amit <namit@vmware.com>
>>>>>>=20
>>>>>> The comment in madvise_dontneed_free() says that vma splits that =
occur
>>>>>> while the mmap-lock is dropped, during userfaultfd_remove(), =
should be
>>>>>> handled correctly, but nothing in the code indicates that it is =
so: prev
>>>>>> is invalidated, and do_madvise() will therefore continue to =
update VMAs
>>>>>> from the "obsolete" end (i.e., the one before the split).
>>>>>>=20
>>=20

[snip]


>> Perhaps adding this one on top of yours? I can test it when I wake =
up.
>> It is cleaner, but I am not sure if I am missing something.
>=20
> It should work.
>=20
> BTW, shouldn't we bring madvise_willneed() and madvise_remove() to the
> same scheme?

Even for consistency you are right. My only problem is that I am afraid
to backport such a change. For MADV_DONTNEED, I saw an explicit =
assumption.
I can do it all in one patch if we agree that none of it goes into =
stable
(which I clumsily forgot to cc, but might find the patch and backport =
it).=
