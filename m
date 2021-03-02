Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5987932AE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574949AbhCBWnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838010AbhCBWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:14:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0740C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:14:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so12831707plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XDhLDlA7wOplGFamjT4K7zKlFkgvTAE9QL1XyjFvOsc=;
        b=sd2FTMkBPXXegbTUNAhOlv9maEhFBJlouq+pp2KidTfWFWPZF0o2RUPEJkZBv9FQxH
         Fgce1oFciBiQAR84qmTz36B86X7bB3k64odIITSeZicROnt9HDGtdCqvoP4ByMdYszTq
         6xaDylMzL7bgq8DG4XxjDsPH9ZtDcTKB4WfIPcoANemaEKxCXvrBduAkU+3Y6B1yA5ny
         U2yMDLjHBv83fjZXg3m+Ugksexc5MKdWPO2lkMdm55tKjHN11+ZvWOMbL03ylOs1JlHK
         imUkrjtgT3NBKTst2tTduGG7c0fby7CIVCs6om6+0n1ta0I58Vom2AVSKvS1iFIXIMdl
         oRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XDhLDlA7wOplGFamjT4K7zKlFkgvTAE9QL1XyjFvOsc=;
        b=KifsuYqh8fKwnB44VJLblXFZwK6W2HO35rppilH7cxrwu+b2Z4WduI7YwWQJ9iYUDn
         JpUSzIOUBH1+NSVuldSSweDjWp3h/mkAFpARISvkqf+SG0sJdMZLAhSadYPkToY+9yS+
         Q7YrJ/WiChuPzy6bwNlWUVkKgbe6gQGTtp+YF0vvqlRrFKlFa1GM4xGkEkUQ+yNnd+1D
         2KoA8jPPWssVIjfn798Lkty5FSMvPFS5fvWtFy8aZQt6szKnzXycFBHhZZqotixViSp5
         NShnjcZYhScsbCgU1/P/M+VDTNAiPHneLpN89UKjqamKqQaTYq0qiAzM1UosuLOOabDE
         Pp+A==
X-Gm-Message-State: AOAM530tl2YHCeawP0CP4Zh47ZuIn9RNxehz4nB2huIwyGrivnoqC36t
        x4+8v/Gl4LuCioWVTuno41M=
X-Google-Smtp-Source: ABdhPJyuohi1SRleuhxLWB79FXmAMCrkjWwjAcT21IL23kTWYfb/MdizZ1exA7+4lv0b2Lj8iNaBYw==
X-Received: by 2002:a17:90a:6393:: with SMTP id f19mr6459601pjj.230.1614723242990;
        Tue, 02 Mar 2021 14:14:02 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id k16sm14944397pfp.161.2021.03.02.14.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 14:14:02 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <82EE79B6-B29C-41FE-AA81-13C14E7F9D95@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4BFAC9DF-DC92-4E59-8E57-8D5CB5F1FBBE";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC PATCH v2 0/2] mm: fix races due to deferred TLB flushes
Date:   Tue, 2 Mar 2021 14:14:00 -0800
In-Reply-To: <20210302221314.GR397383@xz-x1>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20210302221314.GR397383@xz-x1>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_4BFAC9DF-DC92-4E59-8E57-8D5CB5F1FBBE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On Mar 2, 2021, at 2:13 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Fri, Dec 25, 2020 at 01:25:27AM -0800, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> This patch-set went from v1 to RFCv2, as there is still an ongoing
>> discussion regarding the way of solving the recently found races due =
to
>> deferred TLB flushes. These patches are only sent for reference for =
now,
>> and can be applied later if no better solution is taken.
>>=20
>> In a nutshell, write-protecting PTEs with deferred TLB flushes was =
mostly
>> performed while holding mmap_lock for write. This prevented =
concurrent
>> page-fault handler invocations from mistakenly assuming that a page =
is
>> write-protected when in fact, due to the deferred TLB flush, other =
CPU
>> could still write to the page. Such a write can cause a memory
>> corruption if it takes place after the page was copied (in
>> cow_user_page()), and before the PTE was flushed (by wp_page_copy()).
>>=20
>> However, the userfaultfd and soft-dirty mechanisms did not take
>> mmap_lock for write, but only for read, which made such races =
possible.
>> Since commit 09854ba94c6a ("mm: do_wp_page() simplification") these
>> races became more likely to take place as non-COW'd pages are more
>> likely to be COW'd instead of being reused. Both of the races that
>> these patches are intended to resolve were produced on v5.10.
>>=20
>> To avoid the performance overhead some alternative solutions that do =
not
>> require to acquire mmap_lock for write were proposed, specifically =
for
>> userfaultfd. So far no better solution that can be backported was
>> proposed for the soft-dirty case.
>>=20
>> v1->RFCv2:
>> - Better (i.e., correct) description of the userfaultfd buggy case =
[Yu]
>> - Patch for the soft-dirty case
>=20
> Nadav,
>=20
> Do you plan to post a new version to fix the tlb corrupt issue that =
this series
> wanted to solve?

Yes, yes. Sorry for that. Will do so later today.

Regards,
Nadav

--Apple-Mail=_4BFAC9DF-DC92-4E59-8E57-8D5CB5F1FBBE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmA+uKgACgkQHaAqSaba
D1p3Rw/+Onwg67Ys7jPTdP45YUycZqYIZb5Oh/Va0r2uWnSlq7hDx8zgQAFYR8Hu
vv9Y8KAJYLqrsYbq5XTnP6WQzqT4bILmdVNk7cgE2BSNt6o2BYjfD/Ofaom+v2xz
TEiJJNG9CdMFQgoCBV16HspSw61xA1gDAj+cqajoWZMXXaddyjf7Mxyw0iGeHudV
+AD5YvC3bBHiqYrqeyQtRVRKeTC3OjBf8QOG1NoRiIHYxbFojYTt7BDurQdngGne
b1XIRo9pPY1pXvp1w8r6gIGOElLSLTryq4rXkA7T15T8dO6lrQ6QY29k3axqi4Ma
oESNusuxwZ+Tbpn92XHpi06Nze4fchj0bJaoGS88tWak5euNx0BoLOiBOYnqqe4D
fWyqpYTCatYuHpSIPMipCqwC3mW9Eba3np6HSl2jhgYyInw0m8FP5nq61IuQZvqh
O72k0Bga7Jr5G1/LuwVx9bVqjAGhllJP63hXhGezwBU45bfj1WwoY5YSY2t1Uqe0
hpmeqD/LyNubXjPdfIReahYvwgU5gKF+n8zGszHYaiWKMwm2YcC5Xwkqje8aErI8
lZnqRECkQ7KEiOrfOOrKR991RC4ReMAhlKBySIshJrm8mZ3FhsdGjgHTa8NXJ03R
g1Jn3C+UC0OsdhE9yKPwDHNNGd2povRln9GiA1vaDZiFkBLa0WM=
=49XM
-----END PGP SIGNATURE-----

--Apple-Mail=_4BFAC9DF-DC92-4E59-8E57-8D5CB5F1FBBE--
