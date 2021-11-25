Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C945D40B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKYFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhKYFMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:12:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0CDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 21:09:30 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 71so4142714pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 21:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUIyGOCik7HwUJdjk6rVBZ+b+XIOGrvD3qJdaDOphpc=;
        b=IYatwOExkSO2BoCW+Uzyt2pjQ6yjCcNYizfRSuBdXt7xA5SlUI6gvHY7qvA4dzxu3E
         kMLtcYfx5zA3xVaorNQQ99ULeR9T65DXlvsdtKn4rIC/tygbq+o3tWf57Uk/Gakox2NV
         KkCF4PBiiyEKKiCABdeNKcbHrswIHVTK9ME1f3XsS57tDrkr8ulsrtwCdA3/kBQk3ed3
         NZkw+I+CQDX8eTZKy22VagQW7shaThlkdZQ3Yb+0J6G7LPG/mye65ugwKabV4kgOWhml
         Bz8/8yNlPs1CqaKr3OLLBANC/TMYxdfs5JSixPObsN6BjPjH3OUcW6I3Q3fnfXXTBywy
         bVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUIyGOCik7HwUJdjk6rVBZ+b+XIOGrvD3qJdaDOphpc=;
        b=LNVORL55IakMBOjgTqDH1cHw+dehDJH9fnjxSgTQxnckJBGCiuXEZGUXvD0Yh1dwE/
         oHxEVuDOfH2RLeaBezgdiTz8FBOu8B6EKLjDZ8OdIHX2cC/r8JqaQGZp8iIlPPjRVyAE
         1Tyve31L2VHI7VtVGzam1NB4YrnUwU4Co7mJgfObqYi9vGAbhwknzvhq7wPERKaqyw5X
         +qvpQjULWTq1SnlEghiyMWQYKr//jUZy9wcR9fPe3ggn2jMzITllITPHxBGGScjEZhOS
         W3lzOowuLeLsYzlSQUm6YnllqN1d0l2Zia2UK900+BwZIoHMiCqRUqEzNgskExb5NSpY
         YQSA==
X-Gm-Message-State: AOAM5309wbls4krk8ymt6nBJeyhqYCtfzVsrXi07PcZif4qVunjQ79pP
        iUyvUeeeOMkWRqU6omsuJrYe94tpKlywYCQGvhI=
X-Google-Smtp-Source: ABdhPJy0ZpumYkG0zv9g/pk0UhOW56NqPwuex9NO1gMfpUtYNvyZuTcLXVccL0nNOyxRejVLa6J0Xh1ViPMKUxZh9/U=
X-Received: by 2002:a63:1217:: with SMTP id h23mr14621795pgl.18.1637816970093;
 Wed, 24 Nov 2021 21:09:30 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com> <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
In-Reply-To: <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 24 Nov 2021 23:09:19 -0600
Message-ID: <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Eric Dumazet <edumazet@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:56 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 10:20 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 8:08 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Nov 24, 2021 at 8:00 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > >
> > > > It is an issue in general, not in standard cases because network
> > > > headers are aligned.
> > > >
> > > > I think it came when I folded csum_partial() and do_csum(), I forgot
> > > > to ror() the seed.
> > > >
> > > > I suspect the following would help:
> > > >
> > > > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > > > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> > > > 100644
> > > > --- a/arch/x86/lib/csum-partial_64.c
> > > > +++ b/arch/x86/lib/csum-partial_64.c
> > > > @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> > > >         if (unlikely(odd)) {
> > > >                 if (unlikely(len == 0))
> > > >                         return sum;
> > > > +               temp64 = ror32((__force u64)sum, 8);
> > > >                 temp64 += (*(unsigned char *)buff << 8);
> > > >                 len--;
> > > >                 buff++;
> > > >
> > > >
> > >
> > > It is a bit late here, I will test the following later this week.
> > >
> > > We probably can remove one conditional jump at the end of the function
> > >
> > > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..15986ad42ed5ccb8241ff467a34188cf901ec98e
> > > 100644
> > > --- a/arch/x86/lib/csum-partial_64.c
> > > +++ b/arch/x86/lib/csum-partial_64.c
> > > @@ -41,9 +41,11 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> > >         if (unlikely(odd)) {
> > >                 if (unlikely(len == 0))
> > >                         return sum;
> > > +               temp64 = ror32((__force u64)sum, 8);
> > >                 temp64 += (*(unsigned char *)buff << 8);
> > >                 len--;
> > >                 buff++;
> > > +               odd = 8;
> > >         }
> > >
> > >         while (unlikely(len >= 64)) {
> > > @@ -129,10 +131,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> > >  #endif
> > >         }
> > >         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> > > -       if (unlikely(odd)) {
> > > -               result = from32to16(result);
> > > -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> > > -       }
> > > +       ror32(result, odd);
> >
> > this would be
> >           result = ror32(result, odd);
> >
> > definitely time to stop working today for me.
> >
> > >         return (__force __wsum)result;
> > >  }
> > >  EXPORT_SYMBOL(csum_partial);
>
> All my tests pass with that change :)

Although I see slightly worse performance with aligned `buff`  in
the branch-free approach. Imagine if non-aligned `buff` is that
uncommon might be better to speculate past the work of `ror`.
