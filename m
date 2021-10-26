Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5543BB65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 22:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhJZUKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 16:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239090AbhJZUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 16:10:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:07:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 187so495404pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QZfJ0JXZD4hGi2c/axrYXIwzz739J14LlWMbDQhGfy8=;
        b=jh+U/f/503Pyc9kVPGIvebraJNvIizTIstIOIE1dxwjZueaEesfI9VYURJTCDK6Cu+
         QeKBSrHGodLrSQy10WPqy1ST35WRGeTiipkH8j+zL9e/7KDudMKnonH7jKHNNJNv8v9m
         +cDAlXj2ynVqKOtnCfbf2CGVFtIvBMSCDHrd8p1DMeC6+vqvGinhRvXUHB/HyAYmgNyM
         sebiDRFeJDdTGmdTGuTExQ5VPSoqHUSqjEiTDslWxaIC8t948mvk4DJy+gLQ2sSH+pl+
         nNxQv7QYUQMzFaqyXmd9X0B20CjiIdanh1GZfWgcV7UK4AmEF2N7DyEXjkBsR+kLwZvZ
         9LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QZfJ0JXZD4hGi2c/axrYXIwzz739J14LlWMbDQhGfy8=;
        b=gZPzWHx7fJcprEtsaLgqDC9DVg4/XkB5QG2FsLkSUMadYWKgeCA/qGS5ZI0QNXxHp8
         Anr7JSek5VT7/+uDM0/3UHTtwlV9BedN3aY4wirC38rfGnGbUp1lNDevk3/cS3SIEVcp
         BTueec0iWSR4qS2qMO0L1vu/m0VXpb7PaMboAWTn77BPP3sSE7cbpqBeu6h303ulXPMr
         PO566l/Mzn+41301UHovPKJCWlwdQPisI5h7d5XFMYcqzgaIavSxTmFncGcUTqBzxifz
         GMqfbx5aWccA0RAlHoMOXnrnG96uLGxXMMU05XEtZuMGBlWmWldtWUN9inm10Gwh31rr
         neWw==
X-Gm-Message-State: AOAM532p/Ehvv/Cr0f/FNexwWv0FYB1/8xV3tw8AR6HQwy3dh4ZX073I
        fsHHwSxKD/vlC76EFsiruClw+qjimhk=
X-Google-Smtp-Source: ABdhPJy83ItqvUCXCnArppd51Bzp3kdKg/8uzw4G5Ylx8Mp9/j3u2ACaX1DZx7ZKUesgwfu1GgrU3Q==
X-Received: by 2002:a63:7706:: with SMTP id s6mr14182169pgc.184.1635278859806;
        Tue, 26 Oct 2021 13:07:39 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id g22sm3726123pfc.202.2021.10.26.13.07.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 13:07:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2 2/5] mm: avoid unnecessary flush on change_huge_pmd()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <4f604380-a52b-660c-af82-541dbd7652e4@intel.com>
Date:   Tue, 26 Oct 2021 13:07:37 -0700
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <640A6374-A06B-4E20-BF5D-9A21CC85CB12@gmail.com>
References: <20211021122112.592634-1-namit@vmware.com>
 <20211021122112.592634-3-namit@vmware.com>
 <c415820a-aebb-265c-7f47-e048ee429102@intel.com>
 <E38AEB97-DE1B-4C91-A959-132EC24812AE@vmware.com>
 <29E7E8A4-C400-40A5-ACEC-F15C976DDEE0@gmail.com>
 <435f41f2-ffd4-0278-9f26-fbe2c2c7545c@intel.com>
 <8BC74789-FF33-403F-B5D7-19034CAC7EE6@gmail.com>
 <4f604380-a52b-660c-af82-541dbd7652e4@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 26, 2021, at 12:40 PM, Dave Hansen <dave.hansen@intel.com> =
wrote:
>=20
> On 10/26/21 12:06 PM, Nadav Amit wrote:
>>=20
>> To make it very clear - consider the following scenario, in which
>> a volatile pointer p is mapped using a certain PTE, which is RW
>> (i.e., *p is writable):
>>=20
>>  CPU0				CPU1
>>  ----				----
>>  x =3D *p
>>  [ PTE cached in TLB;=20
>>    PTE is not dirty ]
>> 				clear_pte(PTE)
>>  *p =3D x
>>  [ needs to set dirty ]
>>=20
>> Note that there is no TLB flush in this scenario. The question
>> is whether the write access to *p would succeed, setting the
>> dirty bit on the clear, non-present entry.
>>=20
>> I was under the impression that the hardware AD-assist would
>> recheck the PTE atomically as it sets the dirty bit. But, as I
>> said, I am not sure anymore whether this is defined architecturally
>> (or at least would work in practice on all CPUs modulo the=20
>> Knights Landing thingy).
>=20
> Practically, at "x=3D*p", he thing that gets cached in the TLB will
> Dirty=3D0.  At the "*p=3Dx", the CPU will decide it needs to do a =
write,
> find the Dirty=3D0 entry and will entirely discard it.  In other =
words, it
> *acts* roughly like this:
>=20
> 	x =3D *p			=09
> 	INVLPG(p)
> 	*p =3D x;
>=20
> Where the INVLPG() and the "*p=3Dx" are atomic.  So, there's no
> _practical_ problem with your scenario.  This specific behavior isn't
> architectural as far as I know, though.
>=20
> Although it's pretty much just academic, as for the architecture, are
> you getting hung up on the difference between the description of =
"Accessed":
>=20
> 	Whenever the processor uses a paging-structure entry as part of
> 	linear-address translation, it sets the accessed flag in that
> 	entry
>=20
> and "Dirty:"
>=20
> 	Whenever there is a write to a linear address, the processor
> 	sets the dirty flag (if it is not already set) in the paging-
> 	structure entry...
>=20
> Accessed says "as part of linear-address translation", which means =
that
> the address must have a translation.  But, the "Dirty" section doesn't
> say that.  It talks about "a write to a linear address" but not =
whether
> there is a linear address *translation* involved.
>=20
> If that's it, we could probably add a bit like:
>=20
> 	In addition to setting the accessed flag, whenever there is a
> 	write...
>=20
> before the dirty rules in the SDM.
>=20
> Or am I being dense and continuing to miss your point? :)

I think this time you got my question right.

I was thrown off by the SDM comment on RW permissions vs dirty that I
mentioned before:

"If software on one logical processor writes to a page while software on
 another logical processor concurrently clears the R/W flag in the
 paging-structure entry that maps the page, execution on some processors =
may
 result in the entry=E2=80=99s dirty flag being set (due to the write on =
the first
 logical processor) and the entry=E2=80=99s R/W flag being clear (due to =
the update
 to the entry on the second logical processor).=E2=80=9D

I did not pay enough attention to these small differences that you =
mentioned
between access and dirty this time (although I did notice them before).

I do not think that the change that you offered to the SDM really =
clarifies
the situation. Setting the access flag is done as part of caching the =
PTE in
the TLB. The SDM change you propose does not clarify the atomicity of =
the
permission/PTE-validity check and dirty-bit setting or the fact the PTE =
is
invalidated if the dirty-bit needs to be set and is cached as clear [I =
do not
presume you would want the latter in the SDM, since it is an =
implementation
detail.]

I just wonder how come the R/W-clearing and the P-clearing cause =
concurrent
dirty bit setting to behave differently. I am not a hardware guy, but I =
would
imagine they would be the same...

