Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C96342C529
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhJMPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhJMPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:49:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD74C061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:47:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id np13so2513573pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7tl0UrRgQJeUgfAjO37z3FAcAtBQoJqRFjVMGzCTvA8=;
        b=DWcjK29rZL8qAwcVkgX4a3/MCud1JTap4CQQARYAYNmlL+x4UPK3v8TuG4hlbnlT7u
         IVG7b9BRqAbMTX3u3JPDan7JbUgKHF2iNp2b1BR3UgUTDw3bwVj5qe930IRh6CSlOSuY
         4OERN4rn+ZwBHzQbx4+yAWOj6ZXeSzxL24EP7p/y31qCPDpVRaJszBK9NE0lKbTMi3VH
         vwKNxiLTCZJlzvjnTztAzuARXhpCchRAFhJhALtrUJ/N11LtrdVc8cx9qvrlZL9YVd23
         aSVS+X87C5n+avtxcKaZb8IavjRITBaMO63uZ6U49qh8MPivlNXPcpPnwcgiH9wk5WM5
         bSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7tl0UrRgQJeUgfAjO37z3FAcAtBQoJqRFjVMGzCTvA8=;
        b=MHmwsbPyhLGSwL5DDUmyHXShxpsH27qoYQJ88IFjR2P5xDyGZWrjMtFUt0LieaX01V
         lIPjUqBUep/mi24BTgWB7+OqBuSYdgtsNdAtYKjpWpZU8rMMESMo/thYWd+WPMwNPXCg
         ShwxN5aaUabfR755Z2TECqz84UEH8jl/L70jEUrTz0DbL10RxiJIAqo+KkvplX4K5EYQ
         TvCFrEdKioCBuMg7qc8ZGasLEDu/vkea5C0dKMJwaRgeSlTuHXFmaC8NqbkeR0+GSecS
         pv69H6wnkhCw/l7HN6eqF12bK+nb+cZdRhC4NU4pqrHpqUJ+F5GgKd8VGRHxGJ6j879t
         cjDg==
X-Gm-Message-State: AOAM531PFWrEkUACgBoLCuAMg7kzSYocHvV6VbyY/oN2DJupB8kMUj5j
        iZboMxigTZE1s22SH6obo3g=
X-Google-Smtp-Source: ABdhPJwJ++Ty0dgnmWxqRt9ZvtCdWXTVUybNoygKj7+VjckXQk1A+ag8TPHabAN0ZVWcBwEz1iV9bQ==
X-Received: by 2002:a17:902:9a91:b0:138:efd5:7302 with SMTP id w17-20020a1709029a9100b00138efd57302mr36507391plp.35.1634140034453;
        Wed, 13 Oct 2021 08:47:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id o26sm10645342pfp.177.2021.10.13.08.47.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:47:13 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <595A6581-86CF-4372-98AF-532DF65186C6@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F23DBACE-EAA8-4740-8FEA-C23F179D4E87";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
Date:   Wed, 13 Oct 2021 08:47:11 -0700
In-Reply-To: <YWYWyUMcgoAJqi3V@t490s>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Peter Xu <peterx@redhat.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <YVG2DJx9t6FGr4kX@dhcp22.suse.cz>
 <0FC3F99A-9F77-484A-899B-EDCBEFBFAC5D@gmail.com>
 <YVQbMREcRaCbUaUv@dhcp22.suse.cz>
 <E8456D5C-4FCD-46E4-B6F8-771076243D7E@gmail.com> <YWYWyUMcgoAJqi3V@t490s>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_F23DBACE-EAA8-4740-8FEA-C23F179D4E87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Oct 12, 2021, at 4:14 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, Sep 29, 2021 at 11:31:25AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Sep 29, 2021, at 12:52 AM, Michal Hocko <mhocko@suse.com> wrote:
>>>=20
>>> On Mon 27-09-21 12:12:46, Nadav Amit wrote:
>>>>=20
>>>>> On Sep 27, 2021, at 5:16 AM, Michal Hocko <mhocko@suse.com> wrote:
>>>>>=20
>>>>> On Mon 27-09-21 05:00:11, Nadav Amit wrote:
>>>>> [...]
>>>>>> The manager is notified on memory regions that it should monitor
>>>>>> (through PTRACE/LD_PRELOAD/explicit-API). It then monitors these =
regions
>>>>>> using the remote-userfaultfd that you saw on the second thread. =
When it wants
>>>>>> to reclaim (anonymous) memory, it:
>>>>>>=20
>>>>>> 1. Uses UFFD-WP to protect that memory (and for this matter I got =
a vectored
>>>>>> UFFD-WP to do so efficiently, a patch which I did not send yet).
>>>>>> 2. Calls process_vm_readv() to read that memory of that process.
>>>>>> 3. Write it back to =E2=80=9Cswap=E2=80=9D.
>>>>>> 4. Calls process_madvise(MADV_DONTNEED) to zap it.
>>>>>=20
>>>>> Why cannot you use MADV_PAGEOUT/MADV_COLD for this usecase?
>>>>=20
>>>> Providing hints to the kernel takes you so far to a certain extent.
>>>> The kernel does not want to (for a good reason) to be completely
>>>> configurable when it comes to reclaim and prefetch policies. Doing
>>>> so from userspace allows you to be fully configurable.
>>>=20
>>> I am sorry but I do not follow. Your scenario is describing a user
>>> space driven reclaim. Something that MADV_{COLD,PAGEOUT} have been
>>> designed for. What are you missing in the existing functionality?
>>=20
>> Using MADV_COLD/MADV_PAGEOUT does not allow userspace to control
>> many aspects of paging out memory:
>>=20
>> 1. Writeback: writeback ahead of time, dynamic clustering, etc.
>> 2. Batching (regardless, MADV_PAGEOUT does pretty bad batching job
>>  on non-contiguous memory).
>> 3. No guarantee the page is actually reclaimed (e.g., writeback)
>>  and the time it takes place.
>> 4. I/O stack for swapping - you must use kernel I/O stack (FUSE
>>  as non-performant as it is cannot be used for swap AFAIK).
>> 5. Other operations (e.g., locking, working set tracking) that
>>  might not be necessary or interfere.
>>=20
>> In addition, the use of MADV_COLD/MADV_PAGEOUT prevents the use
>> of userfaultfd to trap page-faults and react accordingly, so you
>> are also prevented from:
>>=20
>> 6. Having your own custom prefetching policy in response to #PF.
>>=20
>> There are additional use-cases I can try to formalize in which
>> MADV_COLD/MADV_PAGEOUT is insufficient. But the main difference
>> is pretty clear, I think: one is a hint that only applied to
>> page reclamation. The other enables the direct control of
>> userspace over (almost) all aspects of paging.
>>=20
>> As I suggested before, if it is preferred, this can be a UFFD
>> IOCTL instead of process_madvise() behavior, thereby lowering
>> the risk of a misuse.
>=20
> (Sorry to join so late..)
>=20
> Yeah I'm wondering whether that could add one extra layer of security. =
 But as
> you mentioned, we've already have process_vm_writev(), then it's =
indeed not
> strong reason to reject process_madvise(DONTNEED) too, it seems.
>=20
> Not sure whether you're aware of the umap project from LLNL:
>=20
> https://github.com/LLNL/umap
>=20
> =46rom what I can tell, that's really doing very similar thing as what =
you
> proposed here, but it's just a local version of things.  IOW in umap =
the
> DONTNEED can be done locally with madvise() already in the umap =
maintained
> threads.  That close the need to introduce the new process_madvise() =
interface
> and it's definitely safer as it's per-mm and per-task.
>=20
> I think you mentioned above that the tracee program will need to =
cooperate in
> this case, I'm wondering whether some solution like umap would be fine =
too as
> that also requires cooperation of the tracee program, it's just that =
the
> cooperation may be slightly more than your solution but frankly I =
think that's
> still trivial and before I understand the details of your solution I =
can't
> really tell..
>=20
> E.g. for a program to use umap, I think it needs to replace mmap() to =
umap()
> where we want the buffers to be managed by umap library rather than =
the kernel,
> then link against the umap library should work.  If the remote =
solution you're
> proposing requires similar (or even more complicated) cooperation, =
then it'll
> be controversial whether that can be done per-mm just like how umap =
designed
> and used.  So IMHO it'll be great to share more details on those parts =
if umap
> cannot satisfy the current need - IMHO it satisfies all the features =
you
> described on fully customized pageout and page faulting in, it's just =
done in a
> single mm.

Thanks for you feedback, Peter.

I am familiar with umap, perhaps not enough, but I am aware.

=46rom my experience, the existing interfaces are not sufficient if you =
look
for high performance (low overhead) solution for multiple processes. The
level of cooperation that I mentioned is something that I mentioned
preemptively to avoid unnecessary discussion, but I believe they can be
resolved (I have just deferred handling them).

Specifically for performance, several new kernel features are needed, =
for
instance, support for iouring with async operations, a vectored
UFFDIO_WRITEPROTECT(V) which batches TLB flushes across VMAs and a
vectored madvise(). Even if we talk on the context of a single mm, I
cannot see umap being performant for low latency devices without those
facilities.

Anyhow, I take your feedback and I will resend the patch for enabling
MADV_DONTNEED with other patches once I am done. As for the TLB batching
itself, I think it has an independent value - but I am not going to
argue about it now if there is a pushback against it.


--Apple-Mail=_F23DBACE-EAA8-4740-8FEA-C23F179D4E87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmFm/38ACgkQHaAqSaba
D1qiNw//Xbc4NezeBInOmRhP3eZALcE9fm09Xstn5YxQSevZ/tgfHqTfnm0DK4vp
4prwPEWMeOjHK1yAJrrrVWGFYAgQQyLkFyAFqNyRRb3zzDTubSzNXtAu1p1ztHV4
rK5TL0bV2HNciLaqZDfAXYFl7fIe5jAHrZRiSLLIlbLT0fY4UFU8f3A4q43OoKan
um0L+Yv3e8KPhrgCeWOsTNJ6QexGgq7RvpG0lHWO3Al7tK8Fm6oqvGw9Zz840ZQl
WDMjOQXGbVBKQktYc6IOiPBmhlOd0qsPxNYtcpg2OeWP4O6TZIrIFk8he1OaFZni
wvK7vTmfkdQBtCapVjwk8JyTcHlpgV7pq5iz3rTDl3J91rVMgZzVBCVzWqg6minN
tVGz8pHqKdpEiyU/72skRZ3P17XKvuFxCuPfhmOQn5iHKkiB6BNvop+IAvxGiGnD
osh5Lea1fT2ZO9SCnw1nTWp0v/mpCfnPRpEhAEYEaa3jTQxJRjmockE8yrtAdNOZ
p614N4eb6TT80VN7qV8KtWW0fJebbEgvzGiVwluhZM62uQedGYysjV7w43Ulk3bX
06e7R2yF1PgaFUSVRFdp7oZW+4otCmuL5N/dqIM5fY8/xH9x7hgIoWMyymjmQx8K
aCKxnX6wGWBMdYC5Nu5jh/c4bVPPyhNlKpvskctWf++vf254Tks=
=PQA3
-----END PGP SIGNATURE-----

--Apple-Mail=_F23DBACE-EAA8-4740-8FEA-C23F179D4E87--
