Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C642C58C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhJMQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbhJMQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:01:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85739C061766
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x4so2137911pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NlebU/Dona3za1z6+SiD/1Xj/DgJ6yfzkx+M783le8c=;
        b=J76yMOSazJaFm39w8/8dmmyH3vr4svRzfCoZwCfINqEK/oLUPvBy9PcjhsUuxbyOK4
         3INnshf9A2ItYXXWRGyCh4htsNEigX96ImIb8XDUDC19WlZu3g2+kkMBL1HKvWgB+7/t
         8ceH5I7hyXR0ftFFRcEDy/O5zYJr8Y9yXNZFtzvIcfnTNTqo5TJF93iPplA+Z4qGZxVW
         orK8ioucIIgMe+iv5g9+sbHurtFbDZQ0gHmKI2HjRiB7oV0u9ranOkxFjYCP6L7UAAcS
         PKH7QZ7LjkIA961jHb9EqU4zCVUqUQ9D1RmUDSesBozlikcKMwGz3bhZihvOAN/V4RiH
         KVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NlebU/Dona3za1z6+SiD/1Xj/DgJ6yfzkx+M783le8c=;
        b=qanAUhSs9W9ARZqy4q5+6O5e/jDBK1YqBMvo6WugONlrc6gJtuBsNK3ifwHUgjgUU5
         TOz2/bMikmaMJg6AxqC+YSHftgqaDaJgUE73gp6W0VZY+fO9LUrF9UwqeWxrHzJzQsFP
         9NR4c/CWsRLMXb+FL2SqljL49VyZ2qqfhETqtQTNzUzleymMCYI2UXC1CHLuKtnfP99I
         KAMu4DKkZJOEIWfdtGzpeRYIQ4O35O8c575GJtziEbkDXGgwbfmunSqhXMmHy5iIa5Xj
         Ob3I8quKm8uIvL/G64LM0WMRxJqEGLw8TO+H38oczOFVKq6a313ZZkU/LMG64y0dUj9L
         cIMQ==
X-Gm-Message-State: AOAM531+smpHaHE7rlNUtvhbPQ6Y+7XY8kwJ6G3EvO9KAAHht+p1MnGy
        Z8NSpyrc+W0QDELiHxWg/SLsUjtLIDw=
X-Google-Smtp-Source: ABdhPJyGQPdam3RnOhNb88m7z9uDayTrs7w54eCyz0HzsFMebeTGAwanx7d7N/bm/4SyxqBsKugvAA==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr91971pja.238.1634140747745;
        Wed, 13 Oct 2021 08:59:07 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p17sm6433141pju.34.2021.10.13.08.59.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:59:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] mm/mprotect: use mmu_gather
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YWYYUOy0W8z5SVKh@t490s>
Date:   Wed, 13 Oct 2021 08:59:04 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09F31D01-E818-4538-A6E9-3E4779FC4B53@gmail.com>
References: <20210925205423.168858-1-namit@vmware.com>
 <20210925205423.168858-2-namit@vmware.com> <YWVgdmKIFnZcgjeY@t490s>
 <2CED2F72-4D1C-4DBC-AC03-4B246E1673C2@gmail.com> <YWYYUOy0W8z5SVKh@t490s>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 12, 2021, at 4:20 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Tue, Oct 12, 2021 at 10:31:45AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Oct 12, 2021, at 3:16 AM, Peter Xu <peterx@redhat.com> wrote:
>>>=20
>>> On Sat, Sep 25, 2021 at 01:54:22PM -0700, Nadav Amit wrote:
>>>> @@ -338,25 +344,25 @@ static unsigned long =
change_protection_range(struct vm_area_struct *vma,
>>>> 	struct mm_struct *mm =3D vma->vm_mm;
>>>> 	pgd_t *pgd;
>>>> 	unsigned long next;
>>>> -	unsigned long start =3D addr;
>>>> 	unsigned long pages =3D 0;
>>>> +	struct mmu_gather tlb;
>>>>=20
>>>> 	BUG_ON(addr >=3D end);
>>>> 	pgd =3D pgd_offset(mm, addr);
>>>> 	flush_cache_range(vma, addr, end);
>>>> 	inc_tlb_flush_pending(mm);
>>>> +	tlb_gather_mmu(&tlb, mm);
>>>> +	tlb_start_vma(&tlb, vma);
>>>=20
>>> Pure question:
>>>=20
>>> I actually have no idea why tlb_start_vma() is needed here, as =
protection range
>>> can be just a single page, but anyway.. I do see that =
tlb_start_vma() contains
>>> a whole-vma flush_cache_range() when the arch needs it, then does it =
mean that
>>> besides the inc_tlb_flush_pending() to be dropped, so as to the =
other call to
>>> flush_cache_range() above?
>>=20
>> Good point.
>>=20
>> tlb_start_vma() and tlb_end_vma() are required since some archs do =
not
>> batch TLB flushes across VMAs (e.g., ARM).
>=20
> Sorry I didn't follow here - as change_protection() is per-vma anyway, =
so I
> don't see why it needs to consider vma crossing.
>=20
> In all cases, it'll be great if you could add some explanation into =
commit
> message on why we need tlb_{start|end}_vma(), as I think it could not =
be
> obvious to all people.

tlb_start_vma() is required when we switch from flush_tlb_range() =
because
certain properties of the VMA (e.g., executable) are needed on certain
arch. That=E2=80=99s the reason flush_tlb_range() requires the VMA that =
is
invalidated to be provided.

Regardless, there is an interface and that is the way it is used. I am =
not
inclined to break it, even if it was possible, for unclear performance
benefits.

As I discussed offline with Andrea and David, switching to =
tlb_gather_mmu()
interface has additional advantages than batching and avoiding =
unnecessary
flushes on PTE permission promotion (as done in patch 2). If a single =
PTE
is updated out of a bigger range, currently flush_tlb_range() would =
flush
the whole range instead of the single page. In addition, once I fix this
patch-set, if you update a THP, you would (at least on x86) be able to
flush a single PTE instead of flushing 512 entries (which would actually
be done using a full TLB flush).

I would say that as I mentioned in a different thread, and was not
upfront about before, one of the motivations of mine behind this patch
is that I need a vectored UFFDIO_WRITEPROTECTV interface for =
performance.
Nevertheless, I think these two patches stand by themselves and have
independent value.=
