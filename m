Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32B835AC42
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDJJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:14:07 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:37837 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhDJJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:14:00 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 13A9DWjZ007591
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 18:13:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 13A9DWjZ007591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618046013;
        bh=+hdfayiNVQX2n4soZ0P6JpA8C3ANS1WRtJuZiigUefQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BS6PRJQQO1EO/wDXpKcXXkrJNg78sjWcw6g0f0iNl1ewbSz8mwCLW7K5XU/a22G4D
         ph5YVFBn6WibUblDrLCeWbBSE05EUe9DKv2X5IvN6Owm7CQ0tyDLmPB81ct2fjVCLP
         5DTkNRp8gTcAn+ToQ89QbmG0IzoMtYmnDBUsUVKPeJWwIRZL2xP2g/F8dcS+fDDp74
         m8STriyiVahLnMSNBTBw+wkjCjLzuwJvgs3N+f5r5xwwYDVcOFpI0z6JpwPEgWMHh/
         T/HEwDdDGGOLk9IiU1r5KaGuJNfs6WcKRSgnULbmKhh0S2H1d8WhSdDgl33K85+Mo3
         fIkmFb+CbGWmQ==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id t23so4080035pjy.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:13:32 -0700 (PDT)
X-Gm-Message-State: AOAM5307guSUzo61a9O6f0hXXqCYkd865c7uuvXQiuiTk1/HAs+TnP29
        MnwXl+CWhyoLecmo9PfkBViJ+xGYAXGpFOiIP6E=
X-Google-Smtp-Source: ABdhPJw7lYuWw2AMWsrC52sL9wclEJx9rUOOB3i7/ClTK3bq1hWvi1a6XJ484VpPtvDevWbTCXJznJ8QX5xbSwdjRJ0=
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr17980591pjb.87.1618046012066;
 Sat, 10 Apr 2021 02:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210327120155.500-1-ionic@ionic.de> <20210328095227.24323-1-ionic@ionic.de>
 <CAK7LNATzx9ujmapPbPzjL1Yo-A0RAXz0Kma+ve8pUeDDVx8GGw@mail.gmail.com> <9e8d429f-c21c-7d9e-0dcd-8947846fe9ba@ionic.de>
In-Reply-To: <9e8d429f-c21c-7d9e-0dcd-8947846fe9ba@ionic.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Apr 2021 18:12:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzoCoeTtTxyver_XsLd_hCC3Tbs++GU_bAx7q1Crc20Q@mail.gmail.com>
Message-ID: <CAK7LNARzoCoeTtTxyver_XsLd_hCC3Tbs++GU_bAx7q1Crc20Q@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: nconf: stop endless search-up loops
To:     Mihai Moldovan <ionic@ionic.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 4:00 PM Mihai Moldovan <ionic@ionic.de> wrote:
>
> * On 4/10/21 7:47 AM, Masahiro Yamada wrote:
> > On Sun, Mar 28, 2021 at 6:52 PM Mihai Moldovan <ionic@ionic.de> wrote:
> >> +               if ((index == -1) && (index == match_start))
> >> +                       return -1;
> >
> > We know 'index' is -1 in the second comparison.
> > So, you can also write like this:
> >
> >        if (match_start == -1 && index == -1)
> >                 return -1;
>
> I know, but I sided for the other form for semantic reasons - this more closely
> directly describes what we actually care about (both being the same value and
> either one being -1).
>
>
> > But, it is not the correct fix, either.
> >
> > The root cause of the bug is match_start
> > becoming -1.
> >
> >
> > The following is the correct way to fix the bug
> > without increasing the number of lines.
> >
> >
> >
> > diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> > index e0f965529166..af814b39b876 100644
> > [...]
> > +       match_start = (match_start + items_num) % items_num;
> >         index = match_start;
> > -       index = (index + items_num) % items_num;
>
> This is probably more elegant and fixes two issues at the same time: match_start
> becoming -1 or n (which is likewise invalid, but was implicitly handled through
> the remainder operation).
>
> No objections from my side.


Could you send v3 please?

Then, I will apply it.



-- 
Best Regards
Masahiro Yamada
