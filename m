Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726E8314953
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBIHNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhBIHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:12:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D96C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 23:12:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l12so22196086edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/fyLcZYeGnA67qPRYPlm4WlD9jOHnw/D0v2/HCLEQv0=;
        b=RrIZO2392pgF3HXaScrSCQRqmosH5X8au1G2CoEJEtjdbgvk9xHqKiA5a/Z17GZiK4
         OranIdXOYUSzRU2unJBQ4gtAhOwfW5aIGU++OcmjWk25WTiwbQwMiychumU+TTGYNWaP
         HoC2SfBoXxwFj0Ot8jKxxWdjZ9GfEYOy1DDYUNw9y8YoLo36PJfophVrTlAP2LmOghGT
         Ltj2jZyMNQMzHoroKFVRad1yBIp/GegzDgkcIPJ320ayawYYjh+sb14qkR+Swhx6Gi+h
         c3sCb93BMDowBZvTC/cxsHCvoMyCvv0UKd7pWnvYf+gAGo66r09JxmMislmmtuP+TfgZ
         wv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/fyLcZYeGnA67qPRYPlm4WlD9jOHnw/D0v2/HCLEQv0=;
        b=QM6Su1dLa0YihC6CwOXtMeklNyF9u4OK2PsyW40LvhAm55ipLC/FRh9JaRX1v6tBmA
         KgUzWocn11OsQt9ZfDWHfAnOy2H6v3yD/lrzFwHx6N0nJb08tAMTl/P7A5d8ewG/G5v9
         t3TGnFk84z+cVBoCpSYo/dFBRAWydL57ot2eim9hwQcnu9LAw75Mg3ve+m1iitCmMdy9
         holMKJWdPD2FWLfo+1U+Y6fuDNFP2MYuWwSkzAYeBwR7dLjnKDydHOMWUQjpN64FjEEP
         JIfabh0Ys4qTjrW/h9nuo6iy49UxisRucODGSjbEFYiTwv1OVL2LrBkTEhvkkmVNlXWU
         eoDQ==
X-Gm-Message-State: AOAM53040jiM9C3vX9FgRf43y/P/ZA6FIRhHghzg+brwI8CyZUGFP1UY
        js6lHPwSH5ZO97016LXMGfv0aVhtjZOHL7cvbpT2vRsv7YzxqNq1
X-Google-Smtp-Source: ABdhPJzdVVy0NQAJ5BnepCNLvogRmDEebhUqjaFLY5oEhV2wX54H6VT1JcuzuZswkekDVEJvWKGTnOJI6xeY4cPBBOk=
X-Received: by 2002:a05:6402:2053:: with SMTP id bc19mr20743122edb.230.1612854732214;
 Mon, 08 Feb 2021 23:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20210208145818.395353822@linuxfoundation.org> <CA+G9fYsjJ+K7w-PQ4gp=L3QO_VSaUMr6syvAS77--aFbfZVK-g@mail.gmail.com>
 <4373079.srkzGm6n8t@mobilepool36.emlix.com>
In-Reply-To: <4373079.srkzGm6n8t@mobilepool36.emlix.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 9 Feb 2021 12:41:59 +0530
Message-ID: <CA+G9fYtHQ6aQDpUjVC3S5VZ2C8s+y_fEO3n7Vfx=otEVwaF_TQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/120] 5.10.15-rc1 review
To:     Rolf Eike Beer <eb@emlix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 12:22, Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Dienstag, 9. Februar 2021, 03:31:44 CET schrieb Naresh Kamboju:
> > On Mon, 8 Feb 2021 at 20:44, Greg Kroah-Hartman
> >
> > <gregkh@linuxfoundation.org> wrote:
> > > This is the start of the stable review cycle for the 5.10.15 release.
> > > There are 120 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 10 Feb 2021 14:57:55 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/pa=
tch-5
> > >         .10.15-rc1.gz>
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-
> > >         rc.git linux-5.10.y>
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Due to the patch below, the x86_64 build breaks with gcc 7.3.x
> > This issue is specific to openembedded kernel builder.
> >
> > We have also noticed on mainline, Linux next and now on stable-rc 5.10.
> >
> > collect2: error: ld returned 1 exit status
> > make[2]: *** [scripts/Makefile.host:95: scripts/extract-cert] Error 1
> >
> > ref:
> > Build failure link,
> > https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5=
.10/D
> > ISTRO=3Dlkft,MACHINE=3Dintel-corei7-64,label=3Ddocker-buster-lkft/64/co=
nsoleText
>
> Is this part relevant or does that always happen with your builder.
>
> | /srv/oe/build/tmp-lkft-glibc/hosttools/ld: cannot find /lib/libc.so.6 i=
nside
> /
> | /srv/oe/build/tmp-lkft-glibc/hosttools/ld: cannot find /usr/lib/
> libc_nonshared.a inside /
> | /srv/oe/build/tmp-lkft-glibc/hosttools/ld: cannot find /lib/ld-linux-
> x86-64.so.2 inside /
>
> Can you provide a log with V=3D1 where we can see what actually is going =
on?

Daniel D=C3=ADaz sent a fix patch on the stable mailing list.

[PATCH] scripts: Fix linking extract-cert against libcrypto
https://lore.kernel.org/stable/20210209050047.1958473-1-daniel.diaz@linaro.=
org/T/#u

- Naresh
