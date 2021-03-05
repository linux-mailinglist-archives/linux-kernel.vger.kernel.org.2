Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7332E368
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCEIKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:09:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0AC061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 00:09:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id m9so1337452edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xq99tDzcqNpM0H+7DSkqy3t+3i4Sz74IC+jmKCdPino=;
        b=FWUNMGhoTcncJLepBpDgRHBHU5MUs+4/99vf449zMSL5Z4hz4YHvmZHCGA1SjYImph
         SQPojSicFhfuft2M63p0efDkFx0z00iSC/E9fTGfepJNm/yLL4I9Pj38C4b1awA4Ea9C
         o3j6TkacjOHVplRmb//yFG9BsVwDm5qbHd/aWdvG37KiNypEnI3IKBbOegMqMzK4nYay
         6RuwdHQ9/D3aENfBFI6cIAWeCbqGEZRaE+p+F1FM1m/S5vJ7rsY3PeCwqcZT3nBz4iU4
         D78zugPICToh6xy2jzcEHORw/Iv5PjNWN4R4iNFsv58dgKBbY6BTaFShx6OlSflrW3NT
         a+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq99tDzcqNpM0H+7DSkqy3t+3i4Sz74IC+jmKCdPino=;
        b=jJM53DyurcI6ES6OTkLHJTTQYbXUmLuZTryJvGxmEToumHJaxNzZuDhBsaKYfVf9at
         FY/vAyuAe/giHgkSbGLupChqNi1yW2pVEBvHUNYBtkCLGWbGhd8fAUnBXDq1uiGdCvw1
         dSJXm0ThCEFx35SFQAKIUkZu+anHB5WppZz6cFHoIyWFEQCL1WCPt8kPwLLbEi697eSa
         BZS2y8eV0T7k3Z2pPJOVtevSPg2B1S0jzOxfwxZXCrxMKwz1on7PNxsp4qCTk33SzNCA
         ZbVHOsnpOVg9kuuMPfTLIfbEhNYy8QfVVR+0dK1+GUDwv3zM9T3+Lp2ghVom2vlyzDEe
         MLwA==
X-Gm-Message-State: AOAM530b3xlODpVPC2PNVLfDQgEoZMKzzf02G+iQkU+rCBKaoVYXBe1U
        +G3o7Sn7uJHG2yryEnoI9kB0N9NyH2kUEO7V7jwymg==
X-Google-Smtp-Source: ABdhPJxeJfzqEHMqwZbGySXb3yCyR7DFZkcAjAPW9eMOvJ3nbll16EW2GjCNMv+dTD8MdTLcPfmRjsKN4WKCa4uq/5g=
X-Received: by 2002:a05:6402:13ce:: with SMTP id a14mr8126670edx.365.1614931797483;
 Fri, 05 Mar 2021 00:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20210302192700.399054668@linuxfoundation.org> <CA+G9fYsA7U7rzd=yGYQ=uWViY3_dXc4iY_pC-DM1K3R+gac19g@mail.gmail.com>
 <175fac9c-ac3f-bd82-9e5d-2c2970cfc519@roeck-us.net> <CA+G9fYtkrAs=ASaVVu6-Lnck8A6Pt_LGODxnpTYouvppbw_rbQ@mail.gmail.com>
 <CAHk-=wgxLTur2G5mvYKCXE4DkUo90T2Dy3X526sqJgOCm0gzNA@mail.gmail.com>
In-Reply-To: <CAHk-=wgxLTur2G5mvYKCXE4DkUo90T2Dy3X526sqJgOCm0gzNA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Mar 2021 13:39:46 +0530
Message-ID: <CA+G9fYsUJvLbaqOFkxYZJxZkgay92vxjjoD69C0+tS5kthZmoQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/657] 5.10.20-rc4 review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 at 02:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 4, 2021 at 9:56 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 4 Mar 2021 at 01:34, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Upstream has:
> > >
> > > e71a8d5cf4b4 tty: fix up iterate_tty_read() EOVERFLOW handling
> > > ddc5fda74561 tty: fix up hung_up_tty_read() conversion
> >
> > I have applied these two patches and the reported problem did not solve.
>
> Hmm. Upstream has:
>
> *  3342ff2698e9 ("tty: protect tty_write from odd low-level tty disciplines")
> *  a9cbbb80e3e7 ("tty: avoid using vfs_iocb_iter_write() for
> redirected console writes")
> *  17749851eb9c ("tty: fix up hung_up_tty_write() conversion")
> G  e71a8d5cf4b4 ("tty: fix up iterate_tty_read() EOVERFLOW handling")
> G  ddc5fda74561 ("tty: fix up hung_up_tty_read() conversion")
>  * c7135bbe5af2 ("tty: fix up hung_up_tty_write() conversion")
>   d7fe75cbc23c ("tty: teach the n_tty ICANON case about the new
> "cookie continuations" too")
>   15ea8ae8e03f ("tty: teach n_tty line discipline about the new
> "cookie continuations"")
>   64a69892afad ("tty: clean up legacy leftovers from n_tty line discipline")
> *  9bb48c82aced ("tty: implement write_iter")
> *  dd78b0c483e3 ("tty: implement read_iter")
> *  3b830a9c34d5 ("tty: convert tty_ldisc_ops 'read()' function to take
> a kernel pointer")
>
> Where those ones marked with '*' seem to be in v5.10.y, and the one
> prefixed with 'G' are the ones Guenter mentioned.
>
> (We seem to have the "tty: fix up hung_up_tty_write() conversion"
> commit twice. I'm not sure how that happened, but whatever).
>
> But that still leaves three commits that don't seem to be in 5.10.y:
>
>   d7fe75cbc23c ("tty: teach the n_tty ICANON case about the new
> "cookie continuations" too")
>   15ea8ae8e03f ("tty: teach n_tty line discipline about the new
> "cookie continuations"")
>   64a69892afad ("tty: clean up legacy leftovers from n_tty line discipline")
>
> and they might fix what are otherwise short reads. Which is allowed by
> POSIX, afaik, but ..
>
> Do those three commits fix your test-case?

Yes.
As per your suggestion I've added these three patches and tested
and the reported test case PASS now [1].

This means I have five extra patches on top of the stable v5.10.20 tag.

$ git log --oneline
8c1c1de499af tty: teach the n_tty ICANON case about the new "cookie
continuations" too
02aada164879 tty: teach n_tty line discipline about the new "cookie
continuations"
fb0df6b17897 tty: clean up legacy leftovers from n_tty line discipline
429f7fc84d6a tty: fix up iterate_tty_read() EOVERFLOW handling
d0d54bca80a8 tty: fix up hung_up_tty_read() conversion
83be32b6c9e5 (tag: v5.10.20, origin/linux-5.10.y) Linux 5.10.20

[1] https://lkft.validation.linaro.org/scheduler/job/2344990#L1207

- Naresh
