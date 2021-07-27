Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5C3D6D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 06:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhG0EEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 00:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhG0EEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 00:04:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52925C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 20:57:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd39so19943096ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8U7xDAK4FSg1tJfcyum01j1PPQFOk8gcpIdAVxAsAGY=;
        b=m5ffkEdGU3/1AQhD+jetfJbTG8PqqMo+EM//DqwUvbhU/6MzzC9EFuueqPP2ZSHKhw
         OH2KCki3MFqwxUFeYiZ4/7w8FXVfHCAJ19bN5cGa2k/x6/7MymaeGXpU5Pc+yl9SggCn
         KpcnoLwMWhXsAWJ0HyWJbsd4KDpb5vqnLYAco7BYag5Xa3vCVV0wuwIc3eX7TEtMTpM2
         zwkdI1PzTU5BwOaTDrwbRdnNJhvP88Ujxsv3GIS0gk1prLvXvV5krULhbs4MBwwz0e2R
         qtcg7AcgMHfNMGB9GEsRETl6oEvyTFDAMrFD0d/zCB78jv29+cgDWkqbPiif1GqJJp+L
         8f8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8U7xDAK4FSg1tJfcyum01j1PPQFOk8gcpIdAVxAsAGY=;
        b=bmT2Q+BEgrKQAvBihXJnT9s5Qw3BHXlZTChA5Zb6L/j2u1cg9akQPLDSvDEfHiNtvC
         su1yjFmWGMKQ9UVWSGFv0X3lUzXfYCXF3D9L3rOB1OVDiwy4wc9mhDDIY4KZEy5VNtO1
         7P3cj6yGDlXJzCWGC5Z9KFp9rep7Nl3/gLRzd4VglxitNLoIMv8GVdDGp4ZVGjnYtzWD
         avLFOJ88MoNdD3XwgoqQ1vVFeLXxGHd6NHOcVR+3V+seHmEBUa4HMg9YXS8tERrdq8es
         0McE8AudBbQIIwjOhvVX7Br89QWR9Mh3eyaBA1XRl51hnhHy0pm0L5QZ2FdHB9aI6A+x
         2JsQ==
X-Gm-Message-State: AOAM533pLYKYUA79C/TNt9h+i2y2DulsRIonBPv1XB9eVqI3hfrKvzHJ
        3LNUUr60GKfWSXTmE2DlHY38poTvOwPZ328iw5N4sQ==
X-Google-Smtp-Source: ABdhPJxJHGvHP3IhbnuxJO4+FvKR9Wp3ZP5Hjy58OsHqrHvM0Z52GGdHdi73uW8k45TzswSl6qYZM63O8tSK8ml5QCo=
X-Received: by 2002:a17:906:40d1:: with SMTP id a17mr6385261ejk.503.1627358227634;
 Mon, 26 Jul 2021 20:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210726153832.339431936@linuxfoundation.org> <20210726193553.GB2686017@roeck-us.net>
In-Reply-To: <20210726193553.GB2686017@roeck-us.net>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Jul 2021 09:26:56 +0530
Message-ID: <CA+G9fYuaWpyewAmYV041o9g+dFqutGEKnemCPFz6KmCH63TS9Q@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/120] 4.19.199-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 at 01:05, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jul 26, 2021 at 05:37:32PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.199 release.
> > There are 120 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 28 Jul 2021 15:38:12 +0000.
> > Anything received after that time might be too late.
> >
>
> perf fails to build:

Results from Linaro=E2=80=99s test farm.
These build warnings / errors were noticed on arm64, arm, x86_64, and i386
while building perf on 4.19 and below.


> builtin-script.c: In function =E2=80=98perf_script__exit=E2=80=99:
> builtin-script.c:2212:2: error: implicit declaration of function =E2=80=
=98perf_thread_map__put=E2=80=99; did you mean =E2=80=98thread_map__put=E2=
=80=99?
>
> builtin-script.c:2212:2: error: nested extern declaration of =E2=80=98per=
f_thread_map__put=E2=80=99 [-Werror=3Dnested-externs]
> builtin-script.c:2213:2: error: implicit declaration of function =E2=80=
=98perf_cpu_map__put=E2=80=99; did you mean =E2=80=98perf_mmap__put=E2=80=
=99?
>
> tests/topology.c: In function =E2=80=98session_write_header=E2=80=99:
> tests/topology.c:55:2: error: implicit declaration of function =E2=80=98e=
vlist__delete=E2=80=99; did you mean =E2=80=98perf_evlist__delete=E2=80=99?
> tests/topology.c:55:2: error: nested extern declaration of =E2=80=98evlis=
t__delete=E2=80=99
>
> Guenter


build link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/=
DISTRO=3Dlkft,MACHINE=3Dintel-corei7-64,label=3Ddocker-buster-lkft/893/cons=
ole

--
Linaro LKFT
https://lkft.linaro.org
