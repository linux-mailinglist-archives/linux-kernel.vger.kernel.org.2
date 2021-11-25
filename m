Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5695F45D3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 05:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhKYEGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 23:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhKYEEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 23:04:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A4C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:00:56 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 133so4388477wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 20:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylDq0FfzSaqEWdCszpNSV+7v+4nX5xK6Mtea+/73fVM=;
        b=YnZHssRxpvDgrpmbxW51Zi/bxRGzwfxhzevprtt8SlG+goQz4dOHO7dPuMwroAmMnI
         RW6v5S/jT30rmepzp+Ai+MkNTcO2aoQqIZgZbsqs1SXbiTwZLK6RyzFw3uo8WY0jO7wg
         6BhDEPrLId9LajPw/Smkeinn09NKxsJMbb/Z6w53UcP7fNRWPxnH5Dms721wgw10SSQv
         6EBU4ajsUZTblimwIbb7UOX5gbvU6RIe8b5Lze0UkEAK/NyyxfrVUCvhhkarC+ym46Jc
         hnpfn5B/X0abvDFa8iq4jPWnCMdCEirsza+lpEP7iAILDrvPj6G3GhOX3kGFlkUAqQNX
         uPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylDq0FfzSaqEWdCszpNSV+7v+4nX5xK6Mtea+/73fVM=;
        b=rMUxgMRnIOZiP6bSOU6BCLQGMLR7nDJjG/pRRSXFUXm+DcUlZPpUgdV2sGcgGDiLUT
         8snmIHr1cagzTN4Jmt0/BIMadHLymBpJ5rKdAaVz/YB1RgY9+0CKYL35/hwFKNhwlReW
         VeFjvBBM7MAnYkunWERjg/FKweCMbldqTLQr50qrZYNLFRVRM8hbyL6WckXSG0QB0jUu
         Om8xuqWawcYbjVWbM544Z7+f9ZNoXKoOy/V6RiG0rL11WjjPB19xSAZbZzdxctah5O0h
         j4p54xsD97VDuMddM7U4Ju0AzyDow1cVUAy3ao1qySIc0hmaO4Kh7pIWIs43W+eaE1Vb
         NxeQ==
X-Gm-Message-State: AOAM532ADZImoEM3tm5zt8GBM41Mt/Mncnu22AjYNgqV75hHKbohzc7G
        4jQ+spCI53TxfJByEnros+Z31zrSL0woKOG/1z+CfKNzgnjzFg==
X-Google-Smtp-Source: ABdhPJzYnMqYarVXK3vXZYG2/OUC3zbl9tdbb9sBNDVn+KZRLzOrmA1hmA26k0kIHh3PNrBEG3VhrcezDd6HCu+RHCc=
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr3416719wml.49.1637812854737;
 Wed, 24 Nov 2021 20:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
In-Reply-To: <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Nov 2021 20:00:43 -0800
Message-ID: <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 7:41 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Wed, Nov 24, 2021 at 8:56 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> >
> > >
> > > Hi, I'm not sure if this is intentional or not, but I noticed that the output
> > > of 'csum_partial' is different after this patch. I figured that the checksum
> > > algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> > > for the spam.
> > >
> > > Example on x86_64:
> > >
> > > Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> > > len : 11
> > > sum : 0
> > >
> > > csum_partial new : 2480936615
> > > csum_partial HEAD: 2472089390
> >
> > No worries.
> >
> > skb->csum is 32bit, but really what matters is the 16bit folded value.
> >
> > So make sure to apply csum_fold() before comparing the results.
> >
> > A minimal C and generic version of csum_fold() would be something like
> >
> > static unsigned short csum_fold(u32 csum)
> > {
> >   u32 sum = csum;
> >   sum = (sum & 0xffff) + (sum >> 16);
> >   sum = (sum & 0xffff) + (sum >> 16);
> >   return ~sum;
> > }
> >
> > I bet that csum_fold(2480936615) == csum_fold(2472089390)
> >
>
> Correct :)
>
> The outputs seem to match if `buff` is aligned to 64-bit. Still see
> difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.
>
> The comment at the top says it's "best" to have `buff` 64-bit aligned but
> the code logic seems meant to support the misaligned case so not
> sure if it's an issue.
>

It is an issue in general, not in standard cases because network
headers are aligned.

I think it came when I folded csum_partial() and do_csum(), I forgot
to ror() the seed.

I suspect the following would help:

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 1eb8f2d11f7c785be624eba315fe9ca7989fd56d..ee7b0e7a6055bcbef42d22f7e1d8f52ddbd6be6d
100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -41,6 +41,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
        if (unlikely(odd)) {
                if (unlikely(len == 0))
                        return sum;
+               temp64 = ror32((__force u64)sum, 8);
                temp64 += (*(unsigned char *)buff << 8);
                len--;
                buff++;




> Example:
>
> csum_fold(csum_partial) new : 0x3764
> csum_fold(csum_partial) HEAD: 0x3a61
>
> buff        : [ 11, ea, 75, 76, e9, ab, 86, 48 ]
> buff addr   : ffff88eaf5fb0001
> len         : 8
> sum_in      : 25
>
> > It would be nice if we had a csum test suite, hint, hint ;)
>
> Where in the kernel would that belong?

This could be a module, like lib/test_csum.c
