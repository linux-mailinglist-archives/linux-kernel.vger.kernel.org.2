Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB845D3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbhKYDqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhKYDol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:44:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DEC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:41:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq11so4125851pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 19:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0urWh5kyX/7OdsoA6yYxBrS2aT/BuVxDjFE/a0zn6U=;
        b=hXVCd+M4EMTJ0xnd+MS29sd2YQqeXf7raO74B+2+Z95Bdef7L9E5iesgSU32o6rZ7h
         jDctqifkbJMerRWBOeJVmmwLcVaDEpBKJwy3G/wJDWljrSSRHjwsOeYlALYvfgD6CMIG
         2c9qgcPztdeOhON3YjyTLpo8tz2NE6ImR9M+NGTUtI97kB10x8o85KXvruzTRkbpjjXE
         4xGd1rLuGwexIriJC/mv8MwI+Oar1ANPPaFI1IEtw0S+kWvZhDjrlVqOYUabiontIGQ2
         LYWOQ4/dNYlQ9THWJwKQuRxebxDoTiseTMg2DmnrtseDR2bUfWKRE+Hq2te7x0DYoKIM
         sRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0urWh5kyX/7OdsoA6yYxBrS2aT/BuVxDjFE/a0zn6U=;
        b=m+PvVmSMdjfUM7qAxfiGpaZlI/QJtdwRSUsizkhnH9Isel4vZ1yIHkwvdrYXMWGhGp
         mgnwYaA3KTaMIDLp/KtDoMSGHPL1hhWlHnOirj3Db9ixkz2XL5qlEPbLkKItvX9C2ojB
         CIkgFVOAT1QhCei1HX/Pm0IJ67SKBLItTjjJnW3NS0iTR/SfEmYOSFHtaezTjjWuYS4Y
         2b68S9EkK/LtvDnb41NR92T4ZYCePoUYlbHhtlsjsAKNNoqAEnhNNEmkLX20SKollsnu
         otRi31BR0D07SJgOqJ8wtY3XZPOOn7HjKpQ4Br+IzI923KAYVZIsHToG7IyDPpLdlMhN
         asaQ==
X-Gm-Message-State: AOAM533FAFicSSXqD4eFaBPl5pAWKNi4KhnQ8hGYhvlk/d06068SIlIv
        vDtuVeY7vVFrovdrCRan7UKGpDPEniAcnd8jdzM=
X-Google-Smtp-Source: ABdhPJwfJHfK9XFIeHNBa8g24eIsmZQITv5sKETh7/I0wTPNAc2MZyi6LhvTS6iv9mBgGEILO08b/RgTyI0vG0Zm1d8=
X-Received: by 2002:a17:903:32d1:b0:142:1ce1:30c9 with SMTP id
 i17-20020a17090332d100b001421ce130c9mr25786977plr.0.1637811690063; Wed, 24
 Nov 2021 19:41:30 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
In-Reply-To: <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 24 Nov 2021 21:41:19 -0600
Message-ID: <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 8:56 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
>
> >
> > Hi, I'm not sure if this is intentional or not, but I noticed that the output
> > of 'csum_partial' is different after this patch. I figured that the checksum
> > algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> > for the spam.
> >
> > Example on x86_64:
> >
> > Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> > len : 11
> > sum : 0
> >
> > csum_partial new : 2480936615
> > csum_partial HEAD: 2472089390
>
> No worries.
>
> skb->csum is 32bit, but really what matters is the 16bit folded value.
>
> So make sure to apply csum_fold() before comparing the results.
>
> A minimal C and generic version of csum_fold() would be something like
>
> static unsigned short csum_fold(u32 csum)
> {
>   u32 sum = csum;
>   sum = (sum & 0xffff) + (sum >> 16);
>   sum = (sum & 0xffff) + (sum >> 16);
>   return ~sum;
> }
>
> I bet that csum_fold(2480936615) == csum_fold(2472089390)
>

Correct :)

The outputs seem to match if `buff` is aligned to 64-bit. Still see
difference with `csum_fold(csum_partial())` if `buff` is not 64-bit aligned.

The comment at the top says it's "best" to have `buff` 64-bit aligned but
the code logic seems meant to support the misaligned case so not
sure if it's an issue.

Example:

csum_fold(csum_partial) new : 0x3764
csum_fold(csum_partial) HEAD: 0x3a61

buff        : [ 11, ea, 75, 76, e9, ab, 86, 48 ]
buff addr   : ffff88eaf5fb0001
len         : 8
sum_in      : 25

> It would be nice if we had a csum test suite, hint, hint ;)

Where in the kernel would that belong?

>
> Thanks !
