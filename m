Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764E2419453
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhI0MfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhI0MfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:35:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:33:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w11so11645529plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vIUxvPG7r6WRv2s+586G3uUFcKQV9EEVz94m50u5c8o=;
        b=Dm20pXbuODJi9E4d26gWxQdWF4WKYPY57n49iilt38oynabqdwl19DLcjw2vVzs9YC
         qvz/annyS7qAVq3ybRpSMaqwVrdRXK0glutOr0AY53lsvz+poExSyOE/+lVbVyr9piY9
         Jlcw4gKurIA6xL8lxT3HejdEb4SAZZtr0W+w2ZZPmxVfowsgpppqHl2N7ImJm+Biotiu
         jDqIO/6O6paUZjk9b9bIHTM8j45mNdAiMBBbQAAsU9fiZbs94AaEya8Q0qFDiBEPrB57
         WkwzhlXfKAn/rI2gaxlgM9lLKXf9a1a4mTQGl6yaTZMLcIz1ijyxwkeYoV/BJqRVBZLO
         sntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vIUxvPG7r6WRv2s+586G3uUFcKQV9EEVz94m50u5c8o=;
        b=2CYfRQbDZKyxcvNVXDyMhcqIGF7yc37tSAO95FCs35qzyjSJM9e1hJs4RsYDE1jwS6
         W86oSWDQQQJwrfr2Oxw2eoMO2K5/4fiuGk9W8obIVB9PG9F3msUO2jUuCFsYTZIeiIky
         j2Ad9uy3nFWGvnCDFK7q8omGuNjTR/EkuHLFMMKX5R2UQIcrH1xKXUWQt8XAid5YIVkB
         fXS0ND7Sy3ljPEk+k6D2N41LstVnBQZclocDHMlrjumdHzn76J7JPOsj0ScBcZIE/IYL
         vSyVZI8p3bNIqJ4N0R/3Wi2Ft0NsdJKQRdpgIUbUNhm0A8P+BS09/sGyb+xD9QEnu2Q6
         4Mlw==
X-Gm-Message-State: AOAM533Af/Zf7SMwLoewxMiHy5z0cbSAGWWxn40VkNlsTY+mWBQRi+5N
        VVjoDtom7ruQFQUuQitrXh7EoZksKOY=
X-Google-Smtp-Source: ABdhPJy8+zMmYNGCKw92KCp0c5+82Rp5iWOQwe4wIgfH6nhB+Flpu840zpmqz6cBeQFb0DHvBx7oeQ==
X-Received: by 2002:a17:90a:351:: with SMTP id 17mr19887649pjf.145.1632746025137;
        Mon, 27 Sep 2021 05:33:45 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id s17sm6643460pge.50.2021.09.27.05.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 05:33:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210927115507.6xfpugeg3swookbh@box>
Date:   Mon, 27 Sep 2021 05:33:39 -0700
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
Message-Id: <4211F6D4-A282-4AB4-8D96-E273C5ABE0DF@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
 <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
 <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
 <20210927115507.6xfpugeg3swookbh@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2021, at 4:55 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>=20
> On Mon, Sep 27, 2021 at 03:11:20AM -0700, Nadav Amit wrote:
>>=20
>>> On Sep 27, 2021, at 2:08 AM, Kirill A. Shutemov =
<kirill@shutemov.name> wrote:
>>>=20
>>> On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> The comment in madvise_dontneed_free() says that vma splits that =
occur
>>>> while the mmap-lock is dropped, during userfaultfd_remove(), should =
be
>>>> handled correctly, but nothing in the code indicates that it is so: =
prev
>>>> is invalidated, and do_madvise() will therefore continue to update =
VMAs
>>>> from the "obsolete" end (i.e., the one before the split).
>>>>=20
>>>> Propagate the changes to end from madvise_dontneed_free() back to
>>>> do_madvise() and continue the updates from the new end accordingly.
>>>=20
>>> Could you describe in details a race that would lead to wrong =
behaviour?
>>=20
>> Thanks for the quick response.
>>=20
>> For instance, madvise(MADV_DONTNEED) can race with mprotect() and =
cause
>> the VMA to split.
>>=20
>> Something like:
>>=20
>>  CPU0				CPU1
>>  ----				----
>>  madvise(0x10000, 0x2000, MADV_DONTNEED)
>>  -> userfaultfd_remove()
>>   [ mmap-lock dropped ]
>> 				mprotect(0x11000, 0x1000, PROT_READ)
>> 				[splitting the VMA]
>>=20
>> 				read(uffd)
>> 				[unblocking userfaultfd_remove()]
>>=20
>>   [ resuming ]
>>   end =3D vma->vm_end
>>   [end =3D=3D 0x11000]
>>=20
>>   madvise_dontneed_single_vma(vma, 0x10000, 0x11000)
>>=20
>>  Following this operation, 0x11000-0x12000 would not be zapped.
>=20
> Okay, fair enough.
>=20
> Wouldn't something like this work too:
>=20
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0734db8d53a7..0898120c5c04 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -796,6 +796,7 @@ static long madvise_dontneed_free(struct =
vm_area_struct *vma,
> 			 */
> 			return -ENOMEM;
> 		}
> +		*prev =3D vma;
> 		if (!can_madv_lru_vma(vma))
> 			return -EINVAL;
> 		if (end > vma->vm_end) {

Admittedly (embarrassingly?) I didn=E2=80=99t even consider it since all =
the
comments say that once the lock is dropped prev should be invalidated.

Let=E2=80=99s see, considering the aforementioned scenario and that =
there is
initially one VMA between 0x10000-0x12000.

Looking at the code from do_madvise()):

[ end =3D=3D 0x12000 ]

                tmp =3D vma->vm_end;

[ tmp =3D=3D 0x12000 ]

                if (end < tmp)
                        tmp =3D end;

                /* Here vma->vm_start <=3D start < tmp <=3D =
(end|vma->vm_end). */

                error =3D madvise_vma(vma, &prev, start, tmp, behavior);

[ prev->vm_end =3D=3D 0x11000 after the split]

                if (error)
                        goto out;
                start =3D tmp;

[ start =3D=3D 0x12000 ]

                if (prev && start < prev->vm_end)
                        start =3D prev->vm_end;

[ The condition (start < prev->vm_end) is false, start not updated ]

                error =3D unmapped_error;
                if (start >=3D end)
                        goto out;

[ start >=3D end; so we end without updating the second part of the =
split ]

So it does not work.

Perhaps adding this one on top of yours? I can test it when I wake up.
It is cleaner, but I am not sure if I am missing something.

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..548fc106e70b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1203,7 +1203,7 @@ int do_madvise(struct mm_struct *mm, unsigned long =
start, size_t len_in, int beh
                if (error)
                        goto out;
                start =3D tmp;
-               if (prev && start < prev->vm_end)
+               if (prev)
                        start =3D prev->vm_end;
                error =3D unmapped_error;
                if (start >=3D end)=
