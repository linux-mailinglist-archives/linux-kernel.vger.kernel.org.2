Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCF3504BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhCaQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhCaQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:36:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:36:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v23so8185941ple.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MjlfWtKKNtvhcQxErgPdfEHfy5pj5T+5lDeGsL21dU0=;
        b=od6Qn6Sb+/X1QJjdXBdBOuWwoHtBuZuAB0iA9sjOV0bN1QYx3fSQlQlXATlCwKNaP6
         moHey2gAwy/uJ/kWV6SDRwA6eOXv91z0arenc/54XPkg2uYfOLDQcQUz4gpAJqF/gpqS
         C1mFc/y+WHWcmQKQjrM/wtQGKPKFlrTbaQjQmRdK3fSfJVpYWmpcwYKlQqJAgQ4PCpz2
         ATDdU8zVi7TT6IMDtAy2mKRcUrvg2H1EnU1VbHMq+83kom0IceX7x0ECvwfVHrzqinv3
         jZLrWNGCz4wkoxfs83j6fzh+OWJ5RTl2199wGzUG8vJvCE2hLgtGmYd8iYQFVSR1qcdl
         h8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MjlfWtKKNtvhcQxErgPdfEHfy5pj5T+5lDeGsL21dU0=;
        b=cDL8FeU47iTlpGOHo1GgFaT8ieN9itd/PG64MT+wQwTYWy43+VRV4PbCC0WtxF+nm/
         HOiSs3vN/iEBdVlWlNpTQVPkg/xPCvkSF06k7hqJzG3QAT+RSCboOntY0u2X08iMgwXq
         dPSR3E6a/AAFtuCC0ILuAnrDQBOIP1upyNuTowbF9nE62vT25a5Ic0hV8DPm6CWIn4P4
         9EKdyuJtKCR/xITi+Ksgrex3L23vMyj7OLKyORoFRLTePUuApowPq7ueJu2Wbk7RNgE7
         5tSmL4GTsomgdU/Mva4NYo/wkGgJRydpIxYnuXPllzONEWYTnSQdWbV6H+oZ3mH1wcc2
         rocw==
X-Gm-Message-State: AOAM532zzVCsNfmofhhDvZzGBL2y3sO81vocruIo2kTo4aqxKo6rTIOd
        9IMXRaEKirgV+r8TMZMbSlE=
X-Google-Smtp-Source: ABdhPJx3c8WHn6bdxe5Bt63IFgNZSfHCKpFVP5drDSjfY+QBjOKt6lfi1az0cSeKWaG2PM8eK3In3A==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr4245708pji.228.1617208568531;
        Wed, 31 Mar 2021 09:36:08 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 205sm3061907pfc.201.2021.03.31.09.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:36:07 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <C42F16F8-646B-448D-A098-E1A98637E28D@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F337632E-750D-4B46-8772-8021968CA3B8";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC] NUMA balancing: reduce TLB flush via delaying mapping on
 hint page fault
Date:   Wed, 31 Mar 2021 09:36:04 -0700
In-Reply-To: <20210331131658.GV15768@suse.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        Arjun Roy <arjunroy@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
References: <20210329062651.2487905-1-ying.huang@intel.com>
 <20210330133310.GT15768@suse.de>
 <87a6qj8t92.fsf@yhuang6-desk1.ccr.corp.intel.com>
 <20210331131658.GV15768@suse.de>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_F337632E-750D-4B46-8772-8021968CA3B8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 31, 2021, at 6:16 AM, Mel Gorman <mgorman@suse.de> wrote:
>=20
> On Wed, Mar 31, 2021 at 07:20:09PM +0800, Huang, Ying wrote:
>> Mel Gorman <mgorman@suse.de> writes:
>>=20
>>> On Mon, Mar 29, 2021 at 02:26:51PM +0800, Huang Ying wrote:
>>>> For NUMA balancing, in hint page fault handler, the faulting page =
will
>>>> be migrated to the accessing node if necessary.  During the =
migration,
>>>> TLB will be shot down on all CPUs that the process has run on
>>>> recently.  Because in the hint page fault handler, the PTE will be
>>>> made accessible before the migration is tried.  The overhead of TLB
>>>> shooting down is high, so it's better to be avoided if possible.  =
In
>>>> fact, if we delay mapping the page in PTE until migration, that can =
be
>>>> avoided.  This is what this patch doing.
>>>>=20
>>>=20
>>> Why would the overhead be high? It was previously inaccessibly so =
it's
>>> only parallel accesses making forward progress that trigger the need
>>> for a flush.
>>=20
>> Sorry, I don't understand this.  Although the page is inaccessible, =
the
>> threads may access other pages, so TLB flushing is still necessary.
>>=20
>=20
> You assert the overhead of TLB shootdown is high and yes, it can be
> very high but you also said "the benchmark score has no visible =
changes"
> indicating the TLB shootdown cost is not a major problem for the =
workload.
> It does not mean we should ignore it though.

If you are looking for a benchmark that is negatively affected by NUMA
balancing, then IIRC Parsec=E2=80=99s dedup is such a workload. [1]

[1] https://parsec.cs.princeton.edu/

--Apple-Mail=_F337632E-750D-4B46-8772-8021968CA3B8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBkpPQACgkQHaAqSaba
D1pAvBAAjzpeqjamVJvvm0jAmkjIyImbd6zd8mCnwDXmKVaGuhPVi329I8qadJ+u
/eq0a+xVd1Rm2FbhEi4LT7LoccrIDe8959f7thT0TDIdaUGNuO83qJRIHQQZiyEL
dxwFWIfwHHvoXjGgRZZ/yHttCGNhbyh/J9RToOrEURQJm8EniBo1Ik2X2BdP2bMc
eLWzHMiXn8flthpiIrNXwKz9oThlVXg9U3VJEVzNOP5y8L9yTkg1iwhzDxSOZlNH
78/4EXTYx8PS0UD+0KLlO3d3J2sFiYnPRmBAD/oBxDBYGfprcV9CHsaJUlEh6F8V
+joOQfMvpKZNah74gw1A4JsE/8fEJGubfzZ3g+QQV40dA03xP7+mQIX5llo2h2a1
+u3rLDygT1wLzZK8jsmG6GEFcL+4JhCEMOlBq/CEtb2nAourfi9einvbWanS9bCq
Ytw5sMsc/At6KWg4uQiPuM75edvPdUjgokaE/dVZRQwesUt98dj9mjLNR44mu8N2
QI5fU5J4IDr1jR2SQrAfMRYgQQU3eftaOVf6Quvh63h2rXRv9YpmG/C2pqZcYF/Q
CA0PiqV1jB6Z+yxvTLoUuJXnCC0pl5vEhdPR3BmEDdbkDuTNmJkTiD9Pk5jEWTuR
5qnebPt+zsIjgWrO9sppk8GuYHOVAtRQuE73Nhj/d4Bxi42m4GE=
=i6Am
-----END PGP SIGNATURE-----

--Apple-Mail=_F337632E-750D-4B46-8772-8021968CA3B8--
