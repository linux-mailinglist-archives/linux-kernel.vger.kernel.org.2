Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB9F42FA46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhJORdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhJORdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:33:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12CC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:30:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so7765438pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KmqK08f9L0/ShipbOP7F9z3OJVRC8UB33zrJdEufV38=;
        b=WDacoiNCJPVqB1pe4kwbmhFKShHTkjgKaP2486OZYZ98vF3TwtB9wlF/DsURSHO0Zo
         D880T8elAupEVGXm2pR4qZXZWXUu1jH+vy87EdhUE1OMDl1s70RoarZPvaslROrLoSYQ
         jcCqVcGdOpDfqBGZPfOy180wliu4ZMUFOWU6ho21dsuewt8eryq7Ui46yOXiLYJFMe+i
         SAY1hMZNhDnU3QmriWKqHrc87AqiNWuJwNio12ghTZ+3sUzYYTlJdIiqbHe772h3laed
         YoycUrngZDMgQENlHmkSufaJ4ElFOQWfCuHjWa2FCs06kv5LtTBpURDRjaVgEl/c4PqJ
         ko+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KmqK08f9L0/ShipbOP7F9z3OJVRC8UB33zrJdEufV38=;
        b=enOpAKzkf9qUghF+QdAizzRXjHAaDQGDGniZ1CzltYrWSEdzj/EfujxaSR0S3h5vAf
         CdmJH4qfWOgGxsDLcJh9otrV8HWY05aDBFE/2EhwMBWvrzzEDSy+mU5jz30gcT2ZcCg2
         Ye92OlmTaD8vkhEkCp+aPjlPb3U8oSvowb9fpcBEzvfVlbPXIeOvQ0Mk5V3dAG1Ql/om
         JC8hY1hCJBFlGBUsUvPjPYVeyG5sebFfuUSADRP+k0G49cvs0bv8G98w903H+qTE73tL
         ecbZpRb+7+1lsgZSZtHXhs0nUjzqO3qxqvPItSSs6vv9zDeu2ZQEuJ5sDOIUpcur2yPh
         vp0g==
X-Gm-Message-State: AOAM533gR2C+0UUYEUJN3Jd/TnbG1pzZ8RgX92hs257Rta5MKjvWX98z
        CywYi4dMIT/DLyvKUBYCMj8HrCjeilxF1v11hxg=
X-Google-Smtp-Source: ABdhPJxFWn+nhkaBWXdPfzywE7IXzw2SB17pOGvieYy+/pTCkfQQnmk6uwme2g6DqSX+LuGaAFndSkVpK0bQ3UW/Dc8=
X-Received: by 2002:a17:902:8d8b:b0:138:e09d:d901 with SMTP id
 v11-20020a1709028d8b00b00138e09dd901mr12465137plo.34.1634319053041; Fri, 15
 Oct 2021 10:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
 <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com>
 <YWfqEIaCKOwSWGHF@zn.tnic> <CAFUsyfLf5a6-L7f2AjLx3j8+qbG7EU9iLPJCTA0+UoOUg3C61A@mail.gmail.com>
 <53c43d2d-0e2e-654b-417d-d3dcbca42fc5@intel.com>
In-Reply-To: <53c43d2d-0e2e-654b-417d-d3dcbca42fc5@intel.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 15 Oct 2021 12:30:42 -0500
Message-ID: <CAFUsyfJxASE5MTBU=5eJWt7vXr0fHMBxuyqFJ5T9FEb3Yena=w@mail.gmail.com>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp check
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, X86 ML <x86@kernel.org>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        aubrey <aubrey.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:25 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/14/21 8:49 AM, Noah Goldstein wrote:
> > Irrelevant of the still existing flaws, it makes the output more accurate.
> >
> > Is there a cost to the change I am not seeing?
>
> We'd want to make sure that this doesn't break anything.  It probably
> won't, but it theoretically could.
>
> For instance, if someone was doing:
>
>         avx512_foo();
>         xsave->xstate_bv &= ~XFEATURE_MASK_ZMMS;
>         XRSTOR(xsave, -1);
>
> That would leave the opmask in place, but would lead to the ZMM
> registers tracked as being in their init state.

The 'XFEATURE_MASK_ZMMS' is new to this patch so I don't think
this patch could be adding that issue.

>
> This would be *very* unlikely, but it would be great if Aubrey (the
> original avx512_timestamp patch author) could make sure that it doesn't
> break anything.
>
> Also, there's the side issue of AVX-256 use.  AVX-256 uses the ZMM
> registers which are a part of XFEATURE_MASK_AVX512, but does not incur
> the same frequency penalties of the full 512-bit-wide instructions.
> Since ZMM_Hi256 is the *only* ZMM state which is truly 512-bit-only, we
> could argue that it's the only one we should consider.
>
> Noah, thanks for bringing this up.  I'm not opposed to your patch, but
> let's just make sure that it doesn't break anything and also that we
> shouldn't do a bit more at the same time (ignore Hi16_ZMM for
> avx512_timestamp).

I think that may make sense. Or outputting separate timestamps for
both. Especially because in GLIBC we have moved to preferring
EVEX implementings for all x86_64 string functions because
vzeroupper aborts RTM transactions:
https://sourceware.org/bugzilla/show_bug.cgi?id=27457

So if an application is using GLIBC on an avx512 machine most likely
the avx512 indicator will be permanently set.
