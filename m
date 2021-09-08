Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0D40336A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 06:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhIHEmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhIHEmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 00:42:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76A4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 21:41:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id k13so2297232lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SXLeBiUyDbIxM6wAYybRH9JPurCTPQJNt9i7c78CL8c=;
        b=Rbgf8Y1OXI0IcL3zhk0dAWwKjW7yFbGTWIW0f6eAu/jbsLFDiOi4j9Td9AclL2N+NR
         +6bSqPxyyq+5Nb0LgFDGqMsCdDLmUjwHSxBgvgFvSdLMsvikGXFKbJroSSWKznRdQ5wl
         7Cdl6ZMEU4XV5qDZwE4sZ4/k/6rM9tLNlbWD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXLeBiUyDbIxM6wAYybRH9JPurCTPQJNt9i7c78CL8c=;
        b=Liks71m3OzjEi5R0lJmlmFQlpsgSpbrGn/CvwadO/AYGOKXE9Xne8kG3WL624CJe3P
         pUS8mL+W0WMAQQqcc/GEB5Wo8i4TjP+6yFcDKw8jt4CEdk2fLLdOab/rlgN9oQnPwoBV
         EKZN2WSiXKc8n2yT4i0xUWcxyAFWkpmzqqdd37Y2ABc0FlOGyh813LQjfmTxXH4fvMVd
         PJ5Pq7H0WcpAmoyaZ8JCXCciukqUHb74FgYinwGZqIuPWkCHXzxLvmjIrFRXga8SZmI9
         PefHGXO7ONq7w2fCx9XPPoF89RmhqAvvwou84GFt3PBfHx3leSbu5zxP/RpB0ruRFsYA
         h+nQ==
X-Gm-Message-State: AOAM531Psh+5+bOzJS/SaVQWoN0VxY8ouT/Epc5f69Gai6hEZ3Ln9GYX
        h5RJagqTqL6iOBS6Yi8jwO1oGofHFewCk9NtRII=
X-Google-Smtp-Source: ABdhPJwY9tSrJ1OgBCSB1yShTnR/AfKjl49b5Q58qb02qXGFxCoZbb+7PA0K3seZaDJHg7W2ILMbEQ==
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr1271314lfp.416.1631076103728;
        Tue, 07 Sep 2021 21:41:43 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z1sm79059lfu.222.2021.09.07.21.41.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 21:41:42 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id k13so2297052lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 21:41:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1285247lfg.402.1631076101854;
 Tue, 07 Sep 2021 21:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
 <CAHk-=wh37UWTqUzbh5qg_x9pFgqBVwpdq_Kf+hnB5mqEUkrjmg@mail.gmail.com>
 <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com> <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
In-Reply-To: <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 21:41:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
Message-ID: <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:52 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Attached patches fix these x86_64 ones reported by Nick:

Hmm.

You didn't seem to fix up the calling convention for print__xyz(),
which still take those xyz structs as pass-by-value.

Obviously it would be good to do things incrementally, so if that
attached patch was just [1/N] I won't complain..

> I'm also seeing one more that might be more challenging to fix but is nearly at 1024:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: error: stack frame size of 1064 bytes in function 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]

Oh Gods, that function is truly something else..

Is there some reason why it's one humongous function, with the
occasional single-line comment?

Because it really looks to me like pretty much everywhere I see one of
those rare comments, I would go "this part should be a function of its
own", and then there would be one caller fuynction that just calls
each of those sub-functions one after the other.

That would - I think - make the code easier to read, and then it would
also make it very obvious where it magically uses a lot of stack.

My suspicion is actually "nowhere". The stack use is just hugely
spread out, and the compiler has just kept accumulating more spill
variables on the frame with no single big reason.

Yes, I see a couple of local structures:

                Pipe myPipe;
                HostVM myHostVM;

but more than that I see several function calls that have basically 62
arguments. And I wish I was making that number up. I'm not. That
"CalculatePrefetchSchedule()" call literally has 62 arguments.

But *all* of the top-level loops in that function literally look like
they could - and should - be functions in their own right. Some of
them would be fairly complex even so (ie that code under the comment

        //Prefetch Check

would be quite the big function all of its own.

We have a coding style thing:

    Documentation/process/coding-style.rst

that says that you should strive to have functions that are "short and
sweet" and fit on one or two screenfuls of text.

That one function from hell is 1832 lines of code.

It really could be improved upon.

               Linus
