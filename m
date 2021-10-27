Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D7943CFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhJ0RkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhJ0Rjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:39:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A798C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:37:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2617839pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/J0YkumngNIENyA0Hh3WuCSq4vFUAHYEuopIp35/Ic=;
        b=V2SPRWkS8CePT0K/8f8mN5S8eqjIIqPO0ejP31eO4OHq9cs0JIh1cVVws2WajwgDBv
         5VR+6oBxPj/CVB7I5qhzvBLCx6uFQrDs92mem06OS7e4mBGJOTXexWjY7EvoIejQcwXa
         2dpyzN+yB2cUAmUu3Ea5hyn5KEqGqZAnwA4rYAivm3skERzdtSBVPCZd1F2SeIFAKJYQ
         DIFeFDh2qVjKXk5ENIlSY6qXCRB2JMnH9Cgup9oez3MRM0/Oujbxbk5BGVHI2K/NGMWd
         aB7ODrlOxiLTOpLyV3uSLTpd36SvUFQ+wGJXPDo0rmclsH5nXFDtnWOQfe7MneBLQQxn
         v9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/J0YkumngNIENyA0Hh3WuCSq4vFUAHYEuopIp35/Ic=;
        b=79lgvO+bbjqfqGCAQondaaaH/iv0cCsYAoOZVR/At0WMW7JwK3GbjqPHgDB550GWGE
         vZ212G1+cPNnCkLq6p+OTa4pFdwd2v8ME3aU7G3ZGKvhR+Umh0MxsBv8uScfUL0N3D5c
         I/JoukVVVfw2MGLtQ2HInnCnQSbHbSSByYyi3A3Ri//o1rEdYoYGpaSU6aiivG7vvlzm
         lfMSEfGstB3FpKeIp962pqo9GMZHQmki75fGsfGpd3B7PLxVmMhUsX4aLeSwVNKA4piJ
         qh962IMwPudv9sDf9wagkpxyJa+RhrxhWtfhUBP679ofLvXeOBfR3C7XK4z5YJQl/d2C
         O2gA==
X-Gm-Message-State: AOAM533eqMMKd6GQmbgd0lGfxqDKFNUNefoxvspshnwUA7fzJm4X0q6f
        6xdB/mS+1MafEHB+sJzeGEyWJ11oFVxLWx69IgM=
X-Google-Smtp-Source: ABdhPJzdqLk+Yxd9Sue9kqKm6uaKc5lrA3fiH6Yv98OEF6iDeSWlTXi4KlRmexeT1cqisSBHSTRyR3qPycNjqkKHqiM=
X-Received: by 2002:a17:902:848c:b0:13f:e969:3c26 with SMTP id
 c12-20020a170902848c00b0013fe9693c26mr30132958plo.34.1635356247545; Wed, 27
 Oct 2021 10:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com> <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic>
In-Reply-To: <YXmIP2EPg12N7foP@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 27 Oct 2021 12:37:16 -0500
Message-ID: <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 12:11 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 27, 2021 at 11:26:15AM -0500, Noah Goldstein wrote:
> > diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
> > index f5a38a5f3ae1..cb10909fa3da 100644
> > --- a/arch/x86/include/asm/fpu/types.h
> > +++ b/arch/x86/include/asm/fpu/types.h
> > @@ -330,11 +330,21 @@ struct fpu {
> >       unsigned int                    last_cpu;
> >
> >       /*
> > -      * @avx512_timestamp:
> > +      * @avx512_ZMM_Hi256_timestamp:
> >        *
> > -      * Records the timestamp of AVX512 use during last context switch.
> > +      * Records the timestamp of AVX512 use in the ZMM_Hi256 xfeature
> > +      * set. This include zmm0...zmm15.
> >        */
> > -     unsigned long                   avx512_timestamp;
> > +     unsigned long                   avx512_ZMM_Hi256_timestamp;
> > +
> > +     /*
> > +      * @avx512_Hi16_ZMM_timestamp:
> > +      *
> > +      * Records the timestamp of AVX512 use in the Hi16_ZMM xfeature
> > +      * set. This includes usage of any of the hi16 xmm, ymm, or zmm
> > +      * registers.
> > +      */
> > +     unsigned long                   avx512_Hi16_ZMM_timestamp;
>
> No, not more of this but less.
>
> That was a bad idea to begin with as exposing this to userspace would
> cause exactly this: but but, I need to track my special use case more
> precisely.
>
> But the feature mask can't give you that precision so it'll be only an
> approximation no matter what you do.
>
> And I'm being told future cores won't have this "problem" so on them
> that file becomes actively misleading.

What I've heard is it's a lot better on Rocket Lake (only extra downclocking
on multicore usage) and TBD for Saphire Rapids.
>
> If you really wanna track performance drop precisely or AVX use or
> whatnot, there's performance counters for that which can give you
> exactly what you wanna know.
>
> So I'll take a simple patch carving out that into a function and which
> removes the opmask and otherwise let that thing die. And on future cores
> which are not affected, that thing will report only 0 anyway.

What about just splitting off a field for 'AVX512_ZMM_Hi256'? That field
seems like it can give meaningful information.

I think mostly like 'AVX512_Hi16_ZMM' will almost always be set because
GLIBC's ifunc uses EVEX implementations for all string/memory functions
on CPUs with avx512.

But if you insist will do.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
