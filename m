Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30781324C43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhBYIxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhBYIxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:53:03 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61A1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:52:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b15so3105994pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=d5/TPW++NCSJGRNsalsS5yFTJhGv1Cm8PSt/sN4M8bc=;
        b=bhTwLqqMLp3/+L2qX3Z9XIZoHOETK8uDKwtkpsnfzS51Sjq+nyIxTdm4NgUKUxdgJ7
         03XXM4tOpPFUFFKRVihnZz7a3YeZbLJhRmN7ENtXwV/ZEncILLjlkBaTceBdJhCUq/CZ
         +1mbDcoeit8x1mlvC3SXOL3oXu3IfViQ9wz4pL9I0ZonAXJX92aPutVA1Q4hF97cx4Tn
         u2XEOJK4Dgo1hL42DHzE0EW1bWxXhysd+PLu8otIBF8BVveYTkzexflPN9A9Q71hkmhb
         D4AdK3LH4l/XDeLEqspLE1BoACNQ+siESoWUGB1YxQyNEHg/yWq19zq/tneS7pL4+Pkz
         37bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=d5/TPW++NCSJGRNsalsS5yFTJhGv1Cm8PSt/sN4M8bc=;
        b=st12tHp6cCqzROgSQCivbqeeyiTcimYZkEsuLrARLXdvfXtucelAPA87YpbI288rG2
         NTotxJ6XOUasatuzHIuoD6lVuhWmxWhh/oeKv48NW/bPJoTn0Ci5A5/UNmABZmd6DldQ
         j3WRu0Avo8q2nyh2alm78J8CL5SarzW9imCRn3BAGAsvrEtsgVTIdf4cerPtQ3LNupe0
         nuTr8zXiP624Xqn8uFkz6ihzG62e/mwfTxx5VTRKKwdpTxzta/Wk4HZZmDJBuSbOZqin
         DfzqGjOPX9FM16MtGqXSVrdZuywdrwE067/ld8VsdrzNDfm826+d1uN8xfvBGwf2YLMX
         UYZg==
X-Gm-Message-State: AOAM531ttaHF8xV6LXx9AnK9tgUa28n/iyE/0SD408SWmGN1NLxdF68S
        HkRFrF9Th/Vv1p6ez+Md4FRb/1rdkBQNpA==
X-Google-Smtp-Source: ABdhPJz2vUt3hhPmsQecYZf2VgwndgcBUEDQILC3K4F8ZVdDYhJwf1acRLNE6t6/jJ3rkGo29rT//A==
X-Received: by 2002:a17:902:d2c9:b029:e1:8692:aa7c with SMTP id n9-20020a170902d2c9b02900e18692aa7cmr2226071plc.21.1614243142998;
        Thu, 25 Feb 2021 00:52:22 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 74sm5432737pfw.53.2021.02.25.00.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 00:52:21 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <64538CCF-AD11-43C2-9632-E054301F9E6D@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0E5A07C0-7909-4A31-A67D-30FFA2DD5115";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Date:   Thu, 25 Feb 2021 00:52:19 -0800
In-Reply-To: <YDdiZ1SFRrvRPhkR@hirez.programming.kicks-ass.net>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
To:     Peter Zijlstra <peterz@infradead.org>
References: <20210225072910.2811795-1-namit@vmware.com>
 <YDdiZ1SFRrvRPhkR@hirez.programming.kicks-ass.net>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_0E5A07C0-7909-4A31-A67D-30FFA2DD5115
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Feb 25, 2021, at 12:40 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Just as applications can use prefetch instructions to overlap
>> computations and memory accesses, applications may want to overlap =
the
>> page-faults and compute or overlap the I/O accesses that are required
>> for page-faults of different pages.
>>=20
>> Applications can use multiple threads and cores for this matter, by
>> running one thread that prefetches the data (i.e., faults in the =
data)
>> and another that does the compute, but this scheme is inefficient. =
Using
>> mincore() can tell whether a page is mapped, but might not tell =
whether
>> the page is in the page-cache and does not fault in the data.
>>=20
>> Introduce prefetch_page() vDSO-call to prefetch, i.e. fault-in memory
>> asynchronously. The semantic of this call is: try to prefetch a page =
of
>> in a given address and return zero if the page is accessible =
following
>> the call. Start I/O operations to retrieve the page if such =
operations
>> are required and there is no high memory pressure that might =
introduce
>> slowdowns.
>>=20
>> Note that as usual the page might be paged-out at any point and
>> therefore, similarly to mincore(), there is no guarantee that the =
page
>> will be present at the time that the user application uses the data =
that
>> resides on the page. Nevertheless, it is expected that in the vast
>> majority of the cases this would not happen, since prefetch_page()
>> accesses the page and therefore sets the PTE access-bit (if it is
>> clear).
>>=20
>> The implementation is as follows. The vDSO code accesses the data,
>> triggering a page-fault it is not present. The handler detects based =
on
>> the instruction pointer that this is an asynchronous-#PF, using the
>> recently introduce vDSO exception tables. If the page can be brought
>> without waiting (e.g., the page is already in the page-cache), the
>> kernel handles the fault and returns success (zero). If there is =
memory
>> pressure that prevents the proper handling of the fault (i.e., =
requires
>> heavy-weight reclamation) it returns a failure. Otherwise, it starts =
an
>> I/O to bring the page and returns failure.
>>=20
>> Compilers can be extended to issue the prefetch_page() calls when
>> needed.
>=20
> Interesting, but given we've been removing explicit prefetch from some
> parts of the kernel how useful is this in actual use? I'm thinking =
there
> should at least be a real user and performance numbers with this =
before
> merging.

Can you give me a reference to the =E2=80=9Cremoving explicit prefetch =
from some
parts of the kernel=E2=80=9D?

I will work on an llvm/gcc plugin to provide some performance numbers.
I wanted to make sure that the idea is not a complete obscenity first.


--Apple-Mail=_0E5A07C0-7909-4A31-A67D-30FFA2DD5115
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmA3ZUMACgkQHaAqSaba
D1rCig//TIRdRCRBpIkezqG9RtBiN9wOTWkZrUiUySmoArI/tBwzTpJi14TO9Z3x
RKTgzeztBk0YBAZ+bwqpRHg5xn3xBMzD12+E/X6rQc/TW5aKhV4PiQaA8zfGnL+M
+KYFWzLU9vKPm0KRTD9KG4PCQbCISdNxw/knGvEqPVJHEDLHvZc/DamK8eW1E7kU
W8HnJXEoivWdq+Csf1Al8XJCsOLnj+7rbLiWErVXsh71JJV7imPW7lIJfAdWvPQV
O9bux93Xs8zW80YjQaOTIG0GTOWEuimKalL3ULOoyzst6zVp3k/dlut4jjRGwwK4
pc/KRe/o2+j2wcFQ4RZcSvsZbF3LFXcyCuXfoTuUEBnH0CG5I9s3Hu/ALOnMnhCo
nQ8LUnBgKqdi5F4A8/vcoNKySZVaB6L44tmm6mz2R+nF6u6xO9zRVHUfK+O/tKQ7
u3240HrMThlAqewwJlKFOlvi/jyTPkN0Yul+X+poxhJARNkXozO6QmCIExR/I6EE
uIR6INUbmBgyk3mThay+jL8m861M/qwmjPz99/hAUwFz+FnwDAleFooWU97vzWSK
Tothgl199/oPmtyphtlvWmE4hKNK+a/DEgdVBlTBn8pOVxJJKmj9YoOlL3AsZru1
1kVC1Vd26a+iihb4VpJXrJKEuzSg9PsDAmYJ/Qc+6NlbDPtH1aI=
=tmsY
-----END PGP SIGNATURE-----

--Apple-Mail=_0E5A07C0-7909-4A31-A67D-30FFA2DD5115--
