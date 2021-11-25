Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C445D4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349024AbhKYGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346104AbhKYGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:49:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07DFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:46:00 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so9249857wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8hpjbDa2rfcppBfA+7P/Fi8CFEbNY+hBLEo7eWX6cY=;
        b=Dx64yEkDIA4ITQtKODbKOi+9bNTd60UZnjlqZ5gXTF1dzpavlJfqS8kG7PRZF8EfAQ
         6fjxgGMebIXieV9/xorBAQoxCKgeZUql7PJ9Xmi9/mGfjcXQRUQEvRkafAJLLMwl6Tnx
         HHa3IsBFKKZOmNfqAGgPpLXSYqkAUdSY7Hg8fVoa6nECVDK92j1867qTEPuV7EXCnrnx
         fyqGL3yXF5H4oZ0T46O0o5oGLOAvPtMbM9BndsOq2+RfSuVduJPFKkUW/6LZH4gdu9ml
         Ru5LYhyeRJWFy0aHM/zTYXetXabWayh4ZBbyb48mRigFwDSjmBvyjhsdopQsO5JsegnE
         JQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8hpjbDa2rfcppBfA+7P/Fi8CFEbNY+hBLEo7eWX6cY=;
        b=LEaPthwwCGiqB+HWYgZj+J2m+2tHlls0A+OZpA07UMOY5MTgz+E+Al0anfCzVg0HJg
         7IczieCHrypKLGWv+jw5wD6OcEErHSniUpQU7jOhW2uvG4MPG2j/sC0DyeSlC5OcmU07
         UeIrIL3dJDH+kfyGS0GqnLsMHnYI/XPuYrx0pUtZzh/qHcVBCG1ATBJA7pAxjnC57zBT
         +KPwe0nYPnYTuH3cIFVpMyeir+MDA0/QPiYhNoqYvQAubugbZFxQtdtJ8faK+ApN2sj7
         qJ51aJ4D5KqtPsHZIyifsn2XL+02NmUQ0gDVcGxxI46DQWaH1wwaLnn2Orfjs9UjWP5q
         oSEQ==
X-Gm-Message-State: AOAM530m1qDkKw/r6WLOQbbUwdUcPnMKpzn20uYdHEdYn3NYSRN53VfA
        PtgIYkePzqnOfmtOgYyKiXBfd95OTxGe0MNi9qA7og==
X-Google-Smtp-Source: ABdhPJyh5Idn3kdhbPf9eI5uB7KGxUOnAiNOO6oJJFTE/uXGQVFotXySQgBrdOMBqCeH2eOqBRtAIxsAWVsakPiNDps=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr3794133wro.484.1637822758965;
 Wed, 24 Nov 2021 22:45:58 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
 <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
 <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com> <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
In-Reply-To: <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 22:45:47 -0800
Message-ID: <CANn89iJsFZrm5qzAUJDgYczQiBFa6pmvPDrA_yqkGFhfm-6AnQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:32 PM Eric Dumazet <edumazet@google.com> wrote:

> -       }
> +       if (unlikely(odd))
> +               result = ror32(result, 8);
>         return (__force __wsum)result;

Oh well, gcc at least removes the conditional and generates a ror and a cmov

        mov    %edx,%eax
        ror    $0x8,%eax
        test   %r8,%r8
        cmove  %edx,%eax
        ret

clang keeps the cond jmp
         test   $0x1,%dil
         je     93
         rol    $0x18,%eax
93:    ret
