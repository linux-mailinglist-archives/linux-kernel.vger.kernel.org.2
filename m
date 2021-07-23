Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78E73D41E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGWUXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:22:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68134C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:03:29 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z3so2716210ile.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g4YpTcp3h+RgxTPRET9ugOvi0BQtHn/1JEwwqbGkE/U=;
        b=McPl8puxnnTzPUlKiCepnHDluFGdGfpsoJG9x9z+8k0jttFilOAFD/NzvxAniBB4Vn
         BOrG/jORLwFSuHSl5mbW+4i0QugLS+Q2uXgv1qUy33jHkPvE0CDpF2Jkqrmtdb3/wmL7
         LKWdW68pxiHZEL4zDHKDvWLSRjEHMHZOpSHSI8HSPlimI+lvY6iF2X+F6lI3vkQV+5dG
         jDPRGyDnBhEqBOBWTUtJQeHbbZfjv/YgnNdMekoAnUtB0ismdyj0qY843hGLe6TlPo1E
         qnw43GFu1ADCcOMO0X7afn6TGBuLoiMGMl65CN7JwvB7fTgFf86pFDeMwusxKw+rUWWG
         t24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g4YpTcp3h+RgxTPRET9ugOvi0BQtHn/1JEwwqbGkE/U=;
        b=pHV04Fn1+P5/X9Mt7GGLSMroardNSKBM5aBKA7977qATb6oj8OP5y2Dtw+nz8LuGaT
         R8kmdRcdcajJx5A25s9asr2Y4rrOLR8/EZoTxvKxWqHbHYpErRbhP3Uq28lHTJNMvLut
         8agHj24n2O5Bf75BdlRhNULkPhn9yhalxFrZYyaeQXG3GnAiRbrNewRK9adPRFOFG7rI
         VOLtYgNdpo71urNfwVKXcEkLRn4WtqAdGhAflZi9zgki1PKqLnqzOv4xeZUW5BNFGLRn
         Kh2zJNIKTk0C9x4jpwPbIT4UUyx+Q7YevX8uAvquGS2IHg2/ofxJQIBgsJ6d4eLkA35J
         /UzA==
X-Gm-Message-State: AOAM532X7zfNCUORGk4JqkT0gGHD4yNppDNxZ9L69S1Rm/nKq/YbDkRd
        4iZnIVkMJiEgriQINifqipVIbLeYbJgVXv4gi8t9Mw==
X-Google-Smtp-Source: ABdhPJzioucCwSXORMWbzuA2mStjVTrtGgEk04mE58I9viVa45egooDKurLRScco2qFR1s/S8sckjQPdaXNN5LnJ0Vk=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr4794985ilf.129.1627074208652;
 Fri, 23 Jul 2021 14:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com> <20210715013343.2286699-5-irogers@google.com>
 <YPsKLa0Qe5/as4Jh@kernel.org> <YPsQGZOXqoy7Tfe6@kernel.org> <YPsQ5En9N7xG1Cya@kernel.org>
In-Reply-To: <YPsQ5En9N7xG1Cya@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jul 2021 14:03:16 -0700
Message-ID: <CAP-5=fWUr91jLgD-BDYK08v0ELQtypFHDop7QW4uFOPscncCQw@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jul 23, 2021 at 03:53:14PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Jul 23, 2021 at 03:27:57PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
> > > > Enabled to ensure that info pages build.
> > >
> > > How did you test this? I tried installing texinfo, that is where
> > > makeinfo belongs:
> > >
> > > =E2=AC=A2[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
> > > texinfo-6.7-10.fc34.x86_64
> > > =E2=AC=A2[acme@toolbox perf]$ rpm -q texinfo
> > > texinfo-6.7-10.fc34.x86_64
> > > =E2=AC=A2[acme@toolbox perf]$
> > >
> > > And then:
> > >
> > > =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf O=3D/tmp/build/perf =
install-doc
> > > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> > >   BUILD:   Doing 'make -j24' parallel build
> > >   INSTALL Documentation-man
> > > make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> > > =E2=AC=A2[acme@toolbox perf]$
> >
> > Also:
>
> We get closer if we do:
>
> =E2=AC=A2[acme@toolbox perf]$ make -C tools/perf/Documentation/ install-i=
nfo
> make: Entering directory '/var/home/acme/git/perf/tools/perf/Documentatio=
n'
>   ASCIIDOC perf.xml
>   DB2TEXI  perf.texi
> /bin/sh: line 2: docbook2x-texi: command not found
> make: *** [Makefile:289: perf.texi] Error 127
> make: Leaving directory '/var/home/acme/git/perf/tools/perf/Documentation=
'
> =E2=AC=A2[acme@toolbox perf]$

Do you need to install docbook2x?

$ dpkg -S /usr/bin/docbook2x-texi
docbook2x: /usr/bin/docbook2x-texi

Thanks,
Ian

> - Arnaldo
