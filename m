Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C764257B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242721AbhJGQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbhJGQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:21:24 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C505C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:19:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n11so3838152plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=as+J/lxzPZi8gSu9qHJ01le64iXMD2SD5LM3hk3uIsc=;
        b=DBHGRrRpx6yepuXWPpvf7lZ3mR0f7CW2oCJ6H0mt9265TGxf2XhVUo4R1jwpfwnDgH
         1DMpyy2pW0l+5fauWUFIbhYvQ59eTVqOHQYziacHWKvLuYbk4Eqe04IbN6g/rXlqniPk
         GdyBsOKsvefJ/1ZkRyY9Xzlz0k+6qssxDz9hhMi3GBP8Djby7mNA2LBUzW4ONyqoKO5a
         C3Sl/x7koCIryJWr4wTK0m3+YWkyC14iwOkTFLvSrET0/L/nr8N+SVYGSDxbiX1O0dQe
         hpR8NoiQNBRFNpV4jqyLlsoIiVbTj1JOj0XMKDrk+YUihU9tzmw7PcE5HpdGruNJprKK
         20vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=as+J/lxzPZi8gSu9qHJ01le64iXMD2SD5LM3hk3uIsc=;
        b=tC51gUPJklshV6wvSfUyERUHHTYMif5T7IOqqNq+RzKPE7r/xiBSgwFDxvDx96S3rL
         itU2zONwWg50G7MPnkOFJId5uTenXwDRct/qI2k2BFUDDIVV92LzFPotryrnQkJjR/u8
         pPlaXDa9psnHvRXp5GzngykQ+AzMBgR/bbGtS8LGz2Od6CB50IG40brXY6WZkJgTlifl
         JdvtIR6rN+pKEil4l6CiEpKzap8VwsLbemvEnuMDPmZx7hDHMosqOOuFPW9bkoNvLsGV
         iBy51mNjr4Oysvyegl5n8tWEgU6fx/YaWD6gfMF5ar+sNKAsp4aNEfFbfRyA4iDZmNDk
         HR/Q==
X-Gm-Message-State: AOAM533YiN/L9pkcE6XkQnBnteGFj7vYHHbw19RmrNH0i5Astuty7/D/
        YgcXS1tEo83yZuByZnjzrSQ=
X-Google-Smtp-Source: ABdhPJzbewOJtDCZjDP5RvhlMo0QEPLBCiMFAN4ehj2Dik+oT5/5Zw0grewKoWb9bq8UCf9e9WSWeA==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr5843881pjr.9.1633623569470;
        Thu, 07 Oct 2021 09:19:29 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d15sm74756pfu.12.2021.10.07.09.19.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 09:19:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC PATCH 0/8] mm/madvise: support
 process_madvise(MADV_DONTNEED)
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a456a41d-c089-a639-b223-4412bad82e8d@redhat.com>
Date:   Thu, 7 Oct 2021 09:19:26 -0700
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
Message-Id: <F41F322D-111E-4260-944C-48B7DEBF5C3E@gmail.com>
References: <20210926161259.238054-1-namit@vmware.com>
 <7ce823c8-cfbf-cc59-9fc7-9aa3a79740c3@redhat.com>
 <6E8A03DD-175F-4A21-BCD7-383D61344521@gmail.com>
 <2753a311-4d5f-8bc5-ce6f-10063e3c6167@redhat.com>
 <AE756194-07D4-4467-92CA-9E986140D85D@gmail.com>
 <f47970f5-faa7-9d5f-f07a-9399e4626eda@redhat.com>
 <9DE833C8-515F-4427-9867-E5BF9AD380FB@gmail.com>
 <9b53a85c-83f4-4548-c3b5-c65bd8737670@redhat.com>
 <C533782D-9E4B-41F5-9120-A31A4782BCE5@gmail.com>
 <a456a41d-c089-a639-b223-4412bad82e8d@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2021, at 10:58 AM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
>>>=20
>>> Thanks for the pointer.
>>>=20
>>> And my question would be if something like DAMON would actually be =
what you want.
>> I looked into DAMON and even with the proposed future extensions it =
sounds
>> as a different approach with certain benefits but with many =
limitations.
>> The major limitation of DAMON is that you need to predefine the logic =
you
>> want for reclamation into the kernel. You can add programability =
through
>> some API or even eBPF, but it would never be as easy or as versatile =
as
>> what user manager can achieve. We already have pretty much all the
>> facilities to do so from userspace, and the missing parts (at least =
for
>> basic userspace manager) are almost already there. In contrast, see =
how
>> many iterations are needed for the basic DAMON implementation.
>=20
> I can see what you're saying when looking at optimizing a hand full of =
special applications. I yet fail to see how something like that could =
work as a full replacement for in kernel swapping. I'm happy to learn.

I am not arguing it is a full replacement, at least at this stage.

>=20
>> The second, also big, difference is that DAMON looks only on =
reclamation.
>> If you want a custom prefetch scheme or different I/O stack for =
backing
>> storage, you cannot have such one.
>=20
> I do wonder if it could be extended for prefetching. But I am =
absolutely not a DAMON expert.
>=20
> [...]

These are 2 different approaches. One, is to provide some logic
for the kernel (DAMON). The other is to provide userspace full
control over paging operations (with caveats). Obviously, due to
the caveats, the kernel paging mechanism behaves as a backup.

>=20
>>>=20
>>> You raise a very excellent point (and it should have been part of =
your initial sales pitch): how does it differ to process_vm_writev().
>>>=20
>>> I can say that it differs in a way that you can break applications =
in more extreme ways. Let me give you two examples:
>>>=20
>>> 1. longterm pinnings: you raised this yourself; this can break an =
application silently and there is barely a safe way your tooling could =
handle it.
>>>=20
>>> 2. pagemap: applications can depend on the populated(present |swap) =
information in the pagemap for correctness. For example, there was =
recently a discussion to use pagemap information to speed up live =
migration of VMs, by skipping migration of !populated pages. There is =
currently no way your tooling can fake that. In comparison, ordinary =
swapping in the kernel can handle it.
>> I understand (1). As for (2): the scenario that you mention sound
>> very specific, and one can argue that ignoring UFFD-registered
>> regions in such a case is either (1) wrong or (2) should trigger
>> some UFFD event.
>>>=20
>>> Is it easy to break an application with process_vm_writev()? Yes. =
When talking about dynamic debugging, it's expected that you break the =
target already -- or the target is already broken. Is it easier to break =
an application with process_madvise(MADV_DONTNEED)? I'd say yes, =
especially when implementing something way beyond debugging as you =
describe.
>> If you do not know what you are doing, you can easily break anything.
>> Note that there are other APIs that can break your application even
>> worse, specifically ptrace().
>>> I'm giving you "a hard time" for the reason Michal raised: we =
discussed this in the past already at least two times IIRC and "it is a =
free ticket to all sorts of hard to debug problem" in our opinion; =
especially when we mess around in other process address spaces besides =
for debugging.
>>>=20
>>> I'm not the person to ack/nack this, I'm just asking the questions =
:)
>> I see your points and I try to look for a path of least resistance.
>> I thought that process_madvise() is a nice interface to hook into.
>=20
> It would be the right interface -- iff the operation wouldn't have a =
bad smell to it. We don't really want applications to mess around in the =
page table layout of some other process: however, that is exactly what =
you require. By unlocking that interface for that use case we agree that =
what you are proposing is a "sane use case", but  ...
>=20
>> But if you are concerned it will be misused, how about adding instead
>> an IOCTL that will zap pages but only in UFFD-registered regions?
>> A separate IOCTL for this matter have an advantage of being more
>> tailored for UFFD, not to notify UFFD upon =E2=80=9Cremove=E2=80=9D =
and to be less
>> likely to be misused.
>=20
> ... that won't change the fact that with your user-space swapping =
approach that requires this interface we can break some applications =
silently, and that's really the major concern I have.
>=20
> I mean, there are more cases where you can just harm the target =
application I think, for example if the target application uses =
SOFTDIRTY tracking.
>=20
>=20
> To judge if this is a sane use case we want to support, it would help =
a lot if there would be actual code+evaluation when actually =
implementing some of these advanced policies. Because you raise a lot of =
interesting points in your reply to Michal to back your use case, and =
naive me thinks "this sounds interesting but ... aren't we losing a lot =
of flexibility+features when doing this in user space? Does anyone =
actually want to do it like that?".
>=20
> Again, I'm not the person to ack/nack this, I'm just questioning if =
the use case that requires this interface is actually something that =
will get used later in real life because it has real advantages, or if =
it's a pure research project that will get abandoned at some point and =
we ended up exposing an interface we really didn't want to expose so far =
(especially, because all other requests so far were bogus).

I do want to release the code, but it is really
incomplete/immature at this point. I would not that there additional
use cases, such as workloads that have discardable cache (or memoization
data), which want a central/another entity to discard the data when
there is memory pressure. (You can think about it as a userspace
shrinker).

Anyhow, as a path of least resistance, I think I would do the
following:

1. Wait for the other madvise related patches to be applied.
2. Simplify the patches, specifically removing the data structure
   changes based on Kirill feedback.
3. Defer the enablement of the MADV_DONTNEED until I can show
   code/performance numbers.

Regards,
Nadav=
