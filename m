Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA8F41CBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbhI2SdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346178AbhI2SdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:33:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD37C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:31:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h3so3614921pgb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EDxWKrkBNuwtscCUnWnrQX4z1oFAsXag7E5OmQf8Q0Y=;
        b=BPOF37dk+fGPzpRboMeMfINxNYQelW6JxCrXGIklsY6hPBFAJe9fT2GA3DVXyjNtny
         ipg045baJHE0iOJJHykXUcRSiDc8t1rXzLJC0IuD+wt+Mg1zoWRvSOy9AKwfR2ikq0fD
         zkQ+aSKC9CSRu6/yJwYkw5S/Fr1/y+aaeTNX2cbUACJK5JQVYn+B2OR1AEJV59d8n6P/
         /AM3gZaBU4zt3Uk1LUpxommmIoLQUQlbqJxJ3ErtWEIn2umyXdXbS3yYdIi33vom0KhX
         kyYLPFR8sJppnhNbUE8KLwtfFO3Spu4FNjkY8RYqBcNYitj0vh8xyDKxOBINt5Nny/9i
         lXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EDxWKrkBNuwtscCUnWnrQX4z1oFAsXag7E5OmQf8Q0Y=;
        b=R9P2YcKAEqkDrbK11SzE84GVC5qfMcdiWsq4NtwNcYJdOStiYL8l13OcWFbuZLxOdl
         WH8Cb1KVNTbZ5PzJjHMO27ysenQ86U59DvHwyx/hLdOUPoXttqaZeEDXzju8UVD5M1w9
         0/r5oQJkrAdE91vVCMMktmvQLjnUhIbNTmRqHJL7b5Gw5Y7BiAWiFE3/KNsb3HmonI3t
         tDc7HyX2ptMqVL5PLLvOuQFeHhHfXZ15w5IyqVoR8iGAnPBoB6bU4R0jM1Cn6KGzsJo0
         IJUvlH6FrYQma88L0sPJ17xPtrsttq3OFukaqJDsCJAd3ddy1jgoBXHk2Bwr3KIP91VC
         YEzA==
X-Gm-Message-State: AOAM533CDRGFob6TgfgaXpFuj1b/KIc2t6bLgqWJxHluNleFWRmab3f3
        DGmHarNP1zhwpIgc4ZW0r/4=
X-Google-Smtp-Source: ABdhPJyCqaL3em1P1e20gZVMndRpFUW6agFVdrsWYmXSByskDXDqy1BM+fIb9uyCzX0XFrjx7X3a0g==
X-Received: by 2002:a63:f4b:: with SMTP id 11mr1176984pgp.189.1632940287330;
        Wed, 29 Sep 2021 11:31:27 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id z10sm470758pfn.70.2021.09.29.11.31.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 11:31:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
Date:   Wed, 29 Sep 2021 11:31:25 -0700
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8456D5C-4FCD-46E4-B6F8-771076243D7E@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
 <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
 <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@suse.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2021, at 12:52 AM, Michal Hocko <mhocko@suse.com> wrote:
>=20
> On Mon 27-09-21 12:12:46, Nadav Amit wrote:
>>=20
>>> On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
>>>=20
>>> On Mon 27-09-21 05:00:11, Nadav Amit wrote:
>>> [...]
>>>> The manager is notified on memory regions that it should monitor
>>>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these =
regions
>>>> using the remote-userfaultfd that you saw on the second thread. =
When it wants
>>>> to reclaim (anonymous) memory, it:
>>>>=20
>>>> 1. Uses UFFD-WP to protect that memory (and for this matter I got a =
vectored
>>>>  UFFD-WP to do so efficiently, a patch which I did not send yet).
>>>> 2. Calls process_vm_readv() to read that memory of that process.
>>>> 3. Write it back to =E2=80=9Cswap=E2=80=9D.
>>>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
>>>=20
>>> Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?
>>=20
>> Providing hints to the kernel takes you so far to a certain extent.
>> The kernel does not want to (for a good reason) to be completely
>> configurable when it comes to reclaim and prefetch policies. Doing
>> so from userspace allows you to be fully configurable.
>=20
> I am sorry but I do not follow. Your scenario is describing a user
> space driven reclaim. Something that MADV_{COLD,PAGEOUT} have been
> designed for. What are you missing in the existing functionality?

Using MADV_COLD/MADV_PAGEOUT does not allow userspace to control
many aspects of paging out memory:

1. Writeback: writeback ahead of time, dynamic clustering, etc.
2. Batching (regardless, MADV_PAGEOUT does pretty bad batching job
   on non-contiguous memory).
3. No guarantee the page is actually reclaimed (e.g., writeback)
   and the time it takes place.
4. I/O stack for swapping - you must use kernel I/O stack (FUSE
   as non-performant as it is cannot be used for swap AFAIK).
5. Other operations (e.g., locking, working set tracking) that
   might not be necessary or interfere.

In addition, the use of MADV_COLD/MADV_PAGEOUT prevents the use
of userfaultfd to trap page-faults and react accordingly, so you
are also prevented from:

6. Having your own custom prefetching policy in response to #PF.

There are additional use-cases I can try to formalize in which
MADV_COLD/MADV_PAGEOUT is insufficient. But the main difference
is pretty clear, I think: one is a hint that only applied to
page reclamation. The other enables the direct control of
userspace over (almost) all aspects of paging.

As I suggested before, if it is preferred, this can be a UFFD
IOCTL instead of process_madvise() behavior, thereby lowering
the risk of a misuse.

I would emphasize that this feature (i.e.,=20
process_madvise(MADV_DONTNEED) or a similar new UFFD feature)
has little to no effect on the kernel robustness, complexity,
security or API changes. So the impact on the kernel is
negligible.

