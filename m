Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA89324D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhBYJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbhBYJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:33:40 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96AEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:32:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b15so3166485pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XeHCZmG5dqvm6nspXM9z8zBCHfkWPz+HLqA1CUKopco=;
        b=uZTjyzu8DHdajNqbqGXRonXkyLoQDrofd0yFAHFvRES67VWhrMinQ9kQbdwYAEd3gv
         kLjzkt2/e7TUZWrKHnJjn4QYN8v/NoWBOOJmDUMalzAuM8JGGtMyds+mZecwzlsY/HXD
         8cQhvdDapm2pRgT8f6oQNJfuwTjGJ06wu25NAi3xUGi5WRWt3kMYOWe/DfgFuLMiJyh8
         KcLBK8q6/i3B5M56CT0xI+PDC4GwxOhK1I0NNd0kNUmeunjpuBfamFqC12I2wf2vDYLp
         kNVM9/+hAtoFJlHm2kcqGHc1skdNRzivGnR7pvHmoNJZiBPvFtWm+wIXaGKiee/84kkG
         yi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XeHCZmG5dqvm6nspXM9z8zBCHfkWPz+HLqA1CUKopco=;
        b=Oq/i1j9HMLogFQBnIVrvOG6l9yoTmojNANA+IE/duTOKK/XyGckmNLVxFm+C8DDf1w
         tAKvbBcDBEEPwNZrU2VoNb0CrY58XU4eR9qXPXivdRIXJXbyksn+KuHsPStPz0VG2B5J
         mQDxR+PlBY2uIcICRQfDhenDMh18CEmibOJjezXxCgosTrnZATx0D1t1++8wucbgPKzG
         a2wrjKFoUySD6I4msZmXdFVUT5gu5e5rD1Q+vNzZn4dp8WLuG0+f9E25cU/trkJp4hW4
         eNjR5O6eXMR+h5DiZawJ2R3rDJSbuS8i2BTd9wyt362oi3/uHGkgcih3Fmvx0mRwkQ2k
         gTZQ==
X-Gm-Message-State: AOAM530Xfz60vz6c+fZz7IgjcRQKl3Q5SKwsd2ODS1pxrzl9bw3N7yCp
        WixuP+ujIdrXvgZMseNZ6fg=
X-Google-Smtp-Source: ABdhPJy3aIw7HUgtN5MwSlRPIeCMci2omEtHCAQC/8e4+WurdradiUgIeMmgrkjGQapldtqk2Phy4A==
X-Received: by 2002:a17:90b:718:: with SMTP id s24mr2491061pjz.160.1614245579190;
        Thu, 25 Feb 2021 01:32:59 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id w8sm5326685pgk.46.2021.02.25.01.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 01:32:58 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <D3DF6AC2-679F-4E64-B511-B1A03D1C6048@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_41CB083A-5C98-4549-BEB4-96CA2ADD4E60";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC 0/6] x86: prefetch_page() vDSO call
Date:   Thu, 25 Feb 2021 01:32:56 -0800
In-Reply-To: <64538CCF-AD11-43C2-9632-E054301F9E6D@gmail.com>
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
 <64538CCF-AD11-43C2-9632-E054301F9E6D@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_41CB083A-5C98-4549-BEB4-96CA2ADD4E60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Feb 25, 2021, at 12:52 AM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>=20
>> On Feb 25, 2021, at 12:40 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>=20
>> On Wed, Feb 24, 2021 at 11:29:04PM -0800, Nadav Amit wrote:
>>> From: Nadav Amit <namit@vmware.com>
>>>=20
>>> Just as applications can use prefetch instructions to overlap
>>> computations and memory accesses, applications may want to overlap =
the
>>> page-faults and compute or overlap the I/O accesses that are =
required
>>> for page-faults of different pages.
[
[ snip ]

>> Interesting, but given we've been removing explicit prefetch from =
some
>> parts of the kernel how useful is this in actual use? I'm thinking =
there
>> should at least be a real user and performance numbers with this =
before
>> merging.
>=20
> Can you give me a reference to the =E2=80=9Cremoving explicit prefetch =
from some
> parts of the kernel=E2=80=9D?

Oh. I get it - you mean we remove we remove the use of explicit memory
prefetch from the kernel code. Well, I don=E2=80=99t think it is really =
related,
but yes, performance numbers are needed.


--Apple-Mail=_41CB083A-5C98-4549-BEB4-96CA2ADD4E60
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmA3bsgACgkQHaAqSaba
D1qI7A//U0PnZXNVHZqLmdN2PfFUqLYy/Qh8jX882OkqHSofgdFMg+rMZBngRn9H
g2iXsmlpxVhWqQC0O7/Z/s2LBM7e2lbemWIhkJWwDK2cyYo1Y/ZkDweil8adXp7u
fUIiS4gxSnd3qp7sJN3si9fZW7zd7DinSktSCH1RvmN8exMqW0bnjYuStJlE3sTf
Hl/CU1UydIH+XzxWhl7f0SVMxe8RCWYJ7CO+19gDLuP1+TTmVoOeFa6beV5ctaEp
dBqTDslBNIZkWXP27Y32ENkb3hQleQF7YSOM+Ust835v/o46bjL6ynBoEE4r6WYa
baYRKAM0Tq9RCcHAiPOwcmcwKez0Fi0+p9Y5NJxc6UFYKmoThxks7ADqkiOXxFjv
uvfhNSpdI6qC0RclIuSCG2pkpj85kbuSHCrtZ3GBvsVMi26PPipBWWR4bwOSKYfE
WapHT75BlsCdIPrRZw3WQ1Gid4nh8wLCue/D26yylzxl7VKReVOv5UQTgySb5vH5
JX4B8FcgqSct19kwe6K3+x2RGrUytIQWQxD7PfM1Ny4xI7aqtikrbMqB3wmF3Zv4
7skYi/4qwnXy+ZuXyka8VHWsG6IeChLi/IMat69Klb0O7eLYfFLLguTyO3eL0mVH
zXAuaE39u6HrCIvEp+xKJ+WhEOxHIbeLmTvdvDZtcz4JDO+qeX8=
=LWIC
-----END PGP SIGNATURE-----

--Apple-Mail=_41CB083A-5C98-4549-BEB4-96CA2ADD4E60--
