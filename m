Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5045D405
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhKYFBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhKYE7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 23:59:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6850CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:56:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y7so3670482plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGalc5vNffPGwVzGOhJUGlxHQAzjz377ajF/zJb0e/Q=;
        b=iO93cGLXwgW8TAKpeYweegndUzcvXmaqtRn9N0gFEegtV5OhJcGMqmlzTfubARcaqq
         lUv/K8K7FD+4N+YQqa6RvYKspgd6cZ+llRLviTU/Wm+56pUIfntHOeDP+cMGeBI0Bnev
         LoROQM7W1LXnUoCimhQQSP36XmSnu43cuyknuJTPPRbgfBgMT2V4o/+xwC2855v3AZrS
         IApzUzirQnow7G6LEYLziZrxTVlhA8RQ8uqca9asyRksUZUTNv6YX9m04e48FSTVxfj3
         9E1L1Z6YkIkuoUs0ZqQlqj65/q6JlWwauaMnPs4vxrqCWSbFzX96YROqZ6E29YuryoVN
         RYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGalc5vNffPGwVzGOhJUGlxHQAzjz377ajF/zJb0e/Q=;
        b=qeyEh1uGkvspxsHKTqmi2tM2f31FoKMkCbI5qqUt456wgkOxYsIyh14zAlpe4rFP1r
         u1lwDHNJzOUe6QPoPo5eMLg2uVBLAYysyDoAKwVJ+IEojvwUShBTWiqzvzFnSL0Bs5mJ
         VwyunxMEpeaP33m5h3ji7lzZlIgahHpWZVQyxZNNvWcynf1Iq1AHxUGF+yP7Kc6nKzJ7
         wtadnDwRgKHwsjnqRLelynb3OGV5NTZEA5Eq6VlrRdMavoAloyX/wR+3r/uDI+Da0OFs
         W9OxSYHz2m0zdWpukfGqNjTb7wLremQQULuIyJjUgudv13wGS+9+q+x+Q5cYFMYGUaZf
         zXUg==
X-Gm-Message-State: AOAM531bVwrjc+lz6+BTWLJbTda4d7dI0oqhIxtpfM1qW+jzhz8nbjNI
        p7HiRJtopJjHGl39sJCSnsNap9CsFbm+kGNkATE=
X-Google-Smtp-Source: ABdhPJzPx5w5w/SU9ovaWbQEM1MCezMbDw2eUwionIqklVMH9N0PvczDv4B7+e5Z1vbWGkv9zE1b1Pm4XJKcSON6Rqk=
X-Received: by 2002:a17:902:ab14:b0:143:77d8:2558 with SMTP id
 ik20-20020a170902ab1400b0014377d82558mr26345760plb.54.1637816189350; Wed, 24
 Nov 2021 20:56:29 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com> <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
In-Reply-To: <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 24 Nov 2021 22:56:18 -0600
Message-ID: <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 10:20 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 8:08 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 8:00 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > >
> > > It is an issue in general, not in standard cases because network
> > > headers are aligned.
> > >
> > > I think it came when I folded csum_partial() and do_csum(), I forgot
> > > to ror() the seed.
> > >
> > > I suspect the following would help:
> > >
> > > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
> > > 100644
> > > --- a/arch/x86/lib/csum-partial_64.c
> > > +++ b/arch/x86/lib/csum-partial_64.c
> > > @@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> > >         if (unlikely(odd)) {
> > >                 if (unlikely(len == 0))
> > >                         return sum;
> > > +               temp64 = ror32((__force u64)sum, 8);
> > >                 temp64 += (*(unsigned char *)buff << 8);
> > >                 len--;
> > >                 buff++;
> > >
> > >
> >
> > It is a bit late here, I will test the following later this week.
> >
> > We probably can remove one conditional jump at the end of the function
> >
> > diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> > index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..15986ad42ed5ccb8241ff467a34188cf901ec98e
> > 100644
> > --- a/arch/x86/lib/csum-partial_64.c
> > +++ b/arch/x86/lib/csum-partial_64.c
> > @@ -41,9 +41,11 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> >         if (unlikely(odd)) {
> >                 if (unlikely(len == 0))
> >                         return sum;
> > +               temp64 = ror32((__force u64)sum, 8);
> >                 temp64 += (*(unsigned char *)buff << 8);
> >                 len--;
> >                 buff++;
> > +               odd = 8;
> >         }
> >
> >         while (unlikely(len >= 64)) {
> > @@ -129,10 +131,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
> >  #endif
> >         }
> >         result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> > -       if (unlikely(odd)) {
> > -               result = from32to16(result);
> > -               result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> > -       }
> > +       ror32(result, odd);
>
> this would be
>           result = ror32(result, odd);
>
> definitely time to stop working today for me.
>
> >         return (__force __wsum)result;
> >  }
> >  EXPORT_SYMBOL(csum_partial);

All my tests pass with that change :)
