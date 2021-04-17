Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429B4363105
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 17:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhDQPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 11:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbhDQPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 11:49:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E8C061756
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 08:49:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z22so10378468plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=UlHLApmjNaxJ+1f+S4nkAczcT2x00yaeeZv8PjGcs5U=;
        b=DOATV8KCNPLlC64ojiDhxStRv+r134ACf60ucyeKmF1U6zYzZKAkj2+B3nQQuTrG/+
         J0kw305r8C7SREWaTAwN5r6I66x1rECUggTJ8TG0DU647jj9RsyEPErB5Mpbe4Xlntou
         dcK5VHLUflLnIfuKRS0i+f3IPMzq4N2nygihb7XuWYl3OMnbYmyWHoAs8RuPZ0KgUAVY
         K2uAbRdz2MMisWxCmB4ZqkgB+74Uxj1g1P/pr2eYPSrthdThcakkIYtiwWdcX/acZLsL
         rMvG3eRUY76nUFaKr1q4mDJbqH60QroMmNlfU5QJEmZjxzQK7t2F28T6ljfkqyy/Fae6
         z0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=UlHLApmjNaxJ+1f+S4nkAczcT2x00yaeeZv8PjGcs5U=;
        b=qOObjLkoOLOvhux8wzMWW3FkT0JHsVGEKT+z+AtWvpj2NC504H1pmFCxGzYLO7Qs/1
         Wph3YPTnFWXAJ2VdMIRPHHuZAYZM2StvCf1OlWQctNHKZVzrTI68cAxBicI98HatBPgu
         Ulg1GHNNm10osECJeRLsWHcI0ayX/iKGYUmm+ND78RY424YfAPDAwI6QqWyw/4cOilZc
         36bG18d6msE78fU4ztibX15ID9M6D7X0GbcvnzYEYpk7UvxjwAXr91UTVO7zAIFStOK3
         SwddRTVd7WW3nA1QUUeCd4jAVUs7DnpE65lp0+SzK/mHFR5Py9V2G2J9rHzyETGWOUNF
         7o4g==
X-Gm-Message-State: AOAM530ewYdBkJqLBd9+2rIY/MLsGNj3RVelgLj9JDWlTvnDIKxY+bgc
        +WbHjBRz/lBVvyn6Qg+YKDvn5bmDQCLwUIRK
X-Google-Smtp-Source: ABdhPJwFHAv7m8fAa8AkhXeRVmulhkVfmIQjGzUQ31IIRFeR5AtpMP9wZCArV0Mow8p5L67d1M725Q==
X-Received: by 2002:a17:902:b28b:b029:ea:eda0:4d5e with SMTP id u11-20020a170902b28bb02900eaeda04d5emr14314715plr.68.1618674540558;
        Sat, 17 Apr 2021 08:49:00 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:6956:1417:1f96:6f53? ([2601:646:c200:1ef2:6956:1417:1f96:6f53])
        by smtp.gmail.com with ESMTPSA id i18sm4701340pfq.59.2021.04.17.08.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 08:49:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/15] x86: Implement function_nocfi
Date:   Sat, 17 Apr 2021 08:48:58 -0700
Message-Id: <23831847-4613-4CD7-9DBE-D0DFE5F9AFF0@amacapital.net>
References: <a8653ebf0a52498888f728524ebaa110@AcuMS.aculab.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
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
In-Reply-To: <a8653ebf0a52498888f728524ebaa110@AcuMS.aculab.com>
To:     David Laight <David.Laight@aculab.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2021, at 7:20 AM, David Laight <David.Laight@aculab.com> wrote:=

>=20
> =EF=BB=BFFrom: Kees Cook
>> Sent: 16 April 2021 23:28
>>=20
>>> On Fri, Apr 16, 2021 at 03:06:17PM -0700, Andy Lutomirski wrote:
>>> On Fri, Apr 16, 2021 at 3:03 PM Borislav Petkov <bp@alien8.de> wrote:
>>>>=20
>>>> On Fri, Apr 16, 2021 at 02:49:23PM -0700, Sami Tolvanen wrote:
>>>>> __nocfi only disables CFI checking in a function, the compiler still
>>>>> changes function addresses to point to the CFI jump table, which is
>>>>> why we need function_nocfi().
>>>>=20
>>>> So call it __func_addr() or get_function_addr() or so, so that at least=

>>>> it is clear what this does.
>>>>=20
>>>=20
>>> This seems backwards to me.  If I do:
>>>=20
>>> extern void foo(some signature);
>>>=20
>>> then I would, perhaps naively, expect foo to be the actual symbol that
>>> gets called
>>=20
>> Yes.
>>=20
>>> and for the ABI to be changed to do the CFI checks.
>>=20
>> Uh, no? There's no ABI change -- indirect calls are changed to do the
>> checking.
>>=20
>>> The
>>> foo symbol would point to whatever magic is needed.
>>=20
>> No, the symbol points to the jump table entry. Direct calls get minimal
>> overhead and indirect calls can add the "is this function in the right
>> table" checking.
>=20
>=20
> Isn't this a bit like one of the PPC? ABI where function addresses
> aren't (always) the entry point.
> IIRC is causes all sorts of obscure grief.
>=20
> I'd also like to know how indirect calls are actually expected to work.
> The whole idea is that the potential targets might be in a kernel module
> that is loaded at run time.
>=20
> Scanning a list of possible targets has to be a bad design decision.
>=20
> If you are trying to check that the called function has the right
> prototype, stashing a hash of the prototype (or a known random number)
> before the entry point would give most of the benefits without most
> of the costs.
> The linker could be taught to do the same test (much like name mangling
> but without the crap user experience).
>=20
> That scheme only has the downside of a data cache miss and (hopefully)
> statically predicted correct branch (hmm - except you don't want to
> speculatively execute the wrong function) and polluting the data cache
> with code.

I admit I was quite surprised by the actual CFI implementation. I would have=
 expected a CFI=E2=80=99d function pointer to actually point to a little des=
criptor that contains a hash of the function=E2=80=99s type.  The whole bit v=
ector thing seems quite inefficient.

>=20
> This all seems like a ploy to force people to buy faster cpus.
>=20
>    David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
> Registration No: 1397386 (Wales)
>=20
