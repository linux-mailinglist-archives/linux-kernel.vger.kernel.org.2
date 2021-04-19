Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FCA36492C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbhDSRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhDSRqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:46:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A3FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:46:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lr7so2224193pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=hwFvRMuVGIiNQ7GQsg0y4BTQQqFhJ+eITKyGtAkPN3U=;
        b=uO8r42k6YXtL8mT7P1C2ovl4Iw5dHpFttKEehhEy18/nf1xQd+5bt53kjqpL3GiN3M
         3BZkUoEaoJClAZXyyDbv8MRD3uK4qRczFUuqeObE1kD+AuDTHMuZfLsByVRn86FW81fQ
         gwZidwnmpEOkcsJWCrRS56StGIc/1O3h60ejHjUTkvwudKHnR7TrDlcbW52b85y0NgUW
         QyiWdcCdKfHsSHIHibQ68QdEfhZAUjCuedovB6f9KVzjQTZiwR8Tl8zjhmnSbV+VOHCl
         FhUp7gMc9STr3fIa0dA4TpY1Gz4qY+gADkC7M3hi/vmCaWCjjfVOM9c8P+KbGirCTIEA
         Vf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=hwFvRMuVGIiNQ7GQsg0y4BTQQqFhJ+eITKyGtAkPN3U=;
        b=ph23PNHHa+BG+RBh9c1ayUWaoWK4ElJBR67YpaK+fGZYm9yXqEslYcQsGMNoZkhiLs
         I3bqpZHKj67gxjxtapVnnxmaqXkLYJAG7xmgNcXPZLFxI1gqHiaZasWbg12eFhYZkdrd
         xM9XY3V3aBoPuNHQhWdIyCWyDc3ffdcGr4tE/oMo8u6owU4/L35jc2Eojb5mYwjUNval
         vXvyXJwl/u/JtnEBPv1mhUTq6ylsA1wU9ymkDhlI6Yxgy5HLCMaL2OeXvnjFPtFxValB
         VsEoKbz9BGJdVq74H1HUl9+FR/RtLBO6/EEiCyQp5ykn6Kch34cdTtc3mmGwXb60rqf5
         n7kw==
X-Gm-Message-State: AOAM531IXavs2ufF4UrDM4ErEQcdUNsxgIx+QOzSJPiIEHiwPCiCPTA7
        GnaeEfdRgP48h3eImY+AzVyjNA==
X-Google-Smtp-Source: ABdhPJw4D/whcV8iQXHlPueObuegHrs+cjJkV5MuG7NqxAhgqfkza5aZTmSHNnLTAWy4MyPVKp4aBg==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr275773pji.102.1618854382622;
        Mon, 19 Apr 2021 10:46:22 -0700 (PDT)
Received: from ?IPv6:2600:1010:b018:f7a3:b93c:afa3:79ad:4736? ([2600:1010:b018:f7a3:b93c:afa3:79ad:4736])
        by smtp.gmail.com with ESMTPSA id p126sm12685306pfb.32.2021.04.19.10.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 10:46:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Date:   Mon, 19 Apr 2021 10:46:20 -0700
Message-Id: <2C6F783A-8337-48FE-86F3-5871BADF7BC2@amacapital.net>
References: <c0af9b5811cf4066b7297196bc46456f@AcuMS.aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
In-Reply-To: <c0af9b5811cf4066b7297196bc46456f@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 19, 2021, at 8:26 AM, David Laight <David.Laight@aculab.com> wrote:=

>=20
> =EF=BB=BFFrom: Andy Lutomirski
>> Sent: 18 April 2021 01:12
> ..
>> Slightly more complicated:
>>=20
>> struct opaque_symbol;
>> extern struct opaque_symbol entry_SYSCALL_64;
>>=20
>> The opaque_symbol variant avoids any possible confusion over the weird
>> status of arrays in C, and it's hard to misuse, since struct
>> opaque_symbol is an incomplete type.
>=20
> Maybe:
>=20
> s/opaque_symbol/entry_SYSCALL_64/
>=20

Cute. OTOH, I=E2=80=99m not sure whether that has much benefit, and having a=
 single type for all of this allows it to be declared just once.  I suppose t=
he magic could be wrapped in a macro, though.

>    David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
> Registration No: 1397386 (Wales)
