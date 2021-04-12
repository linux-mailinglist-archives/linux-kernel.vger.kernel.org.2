Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0C35C974
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbhDLPKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbhDLPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:10:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CEAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:10:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so9616567pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=li5yO3ci0EdtyivxU0FpvQYUbBKVnudD0U4lu+FaRh0=;
        b=NGJFfwIZyS0imURzuBF05ohtiBtg34GQq4kGYX/62PKwtlFdBEVYFNTa5Zi1/6cRZ6
         or5SOK/xSJ5R4rD28Ua7hSopdjvFZpBFlkSJSDjecQxz+qvumCUF0IE6HAQ4UsItak7L
         IyQPPlA/1sXPoGklQurc7fLPFjUWYOeO68I1dwBY6zbOcAqMpZDk12f6oh0wkpWF152t
         jEsLmzCn+k2xMf6xA8Nxei9itkcnPnIfy6peNFiF3umtLXsTzXb9EHLBifvTLgMAxX/U
         xjoekDWz2ELRh/ysQ1cXZu51PhefpUH/jK+xOEDdcfxQvLUA7KxtemAcepmqfXVM0wPa
         6BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=li5yO3ci0EdtyivxU0FpvQYUbBKVnudD0U4lu+FaRh0=;
        b=AgZmz57ZNl+RzoUQIt8aBO/l5Kk04kpzqtcb9rs0PjN1Xo/2t6f0E8P47AuNicYSLE
         sEPQGplJ0y7ze03G0qZyQerxIn8BT5Rgft6Y1+E6e0i7khvJBIUbm1uclL7FNZywjiyd
         vNt2KNroIp6jaOC8QsHLUd0vUgCVWI0TuViSr8uvgHtwjvQXQZQNKlEInzRBM2QTdRWz
         Dx6HvY6IWJ202OtX7jL0ZPAzueozTslyaiDTb3dGMDO1oVFdvNnvPZ1Fee9nFG7eKWzD
         rDSe+6s+33Smm7r1Pc/jIqa10K43LyOmFmJ6d0tsLJKEBvhyjj+qYgXLHV/WMbExNKgo
         TRng==
X-Gm-Message-State: AOAM530Rex2wA8bX25598kWt3Wr3IDRB1axVOeZzZCzE5Vdc7rHZjNXG
        rtyRuKu2xbHBFPg9xiJOcZiFBw==
X-Google-Smtp-Source: ABdhPJw4Z9a0+E3LK/tLCB54UgB6olpIiC2jeODE0O0qpJFi4bjSHZhl+QTFflJbHHJNTng03JQWCw==
X-Received: by 2002:a63:3e06:: with SMTP id l6mr27221422pga.140.1618240218355;
        Mon, 12 Apr 2021 08:10:18 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3129:54c1:fe68:a222? ([2601:646:c200:1ef2:3129:54c1:fe68:a222])
        by smtp.gmail.com with ESMTPSA id q14sm12798351pgt.54.2021.04.12.08.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 08:10:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
Date:   Mon, 12 Apr 2021 08:10:15 -0700
Message-Id: <27CD4C77-E58A-4AC1-8415-3E57BE0F3663@amacapital.net>
References: <878s5nk1pk.fsf@oldenburg.str.redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        libc-alpha@sourceware.org, Rich Felker <dalias@libc.org>,
        Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
In-Reply-To: <878s5nk1pk.fsf@oldenburg.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 12, 2021, at 7:38 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> =EF=BB=BF* Borislav Petkov:
>=20
>>> On Mon, Apr 12, 2021 at 04:19:29PM +0200, Florian Weimer wrote:
>>> Maybe we could have done this in 2016 when I reported this for the first=

>>> time.  Now it is too late, as more and more software is using
>>> CPUID-based detection for AVX-512.
>>=20
>> So as I said on another mail today, I don't think a library should rely
>> solely on CPUID-based detection of features especially if those features
>> need kernel support too. IOW, it should ask whether the kernel can
>> handle those too, first.
>=20
> Yes, that's why we have the XGETBV handshake.  I was imprecise.  It's
> CPUID + XGETBV of course.  Or even AT_HWCAP2 (for FSGSBASE).
>=20
>> And the CPUID-faulting thing would solve stuff like that because then
>> the kernel can *actually* get involved into answering something where it
>> has a say in, too.
>=20
> But why wouldn't we use a syscall or an entry in the auxiliary vector
> for that?  Why fault a potentially performance-critical instruction?
>=20

CPUID is horrifically slow in various virt scenarios. If user code needs to s=
erialize, use IRET or SERIALIZE.=
