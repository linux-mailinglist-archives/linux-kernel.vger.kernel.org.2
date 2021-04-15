Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437FE361344
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhDOUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhDOUDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:03:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46F5161166
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 20:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516981;
        bh=mBdoLF9bZGe3BGzaCFodTbQG0QoXl/qTIlJl5RWDHMw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s/gP+7UqP7h7ygSqrjGou9VGD9sN/lPGa0BvDgaNFGbrSj9qgv2JqpFgKkfBfuZ47
         6XowAQxn48CB7TmAd+Ut4ODJh6B12+SWj4oCFUeKx6Elj1upZ/yDPXAr5/IG7I07Pb
         j8lH4ehSjPBrwr3ZjcXjOBdl6fwbVNnicRIbyaejOiz/qlnoDntxfEjMg6Mibj2Qzl
         KfYYyAWdEEQjOfHMN1Q791h9MJPSodgS4W6hbH/FJVhMB1dCjEIpbbTSlve3KCyuuS
         Poyn3NAB6cW4vtmYCjp6LkQKy/mT1RokPZcFihmaVki2RhuqtOQv71v8nDi53Wf3K/
         ZJVeiXwROEIcw==
Received: by mail-qv1-f43.google.com with SMTP id d1so768822qvy.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:03:01 -0700 (PDT)
X-Gm-Message-State: AOAM533RaKvGn+JDjnNZWVQFQ9Vsxqiqx1UcFEfN0bPtXtXKTA0FXO8e
        iTPRRrnFmjZbJY1qua3WTR3YLVjaOsEozRgHgA==
X-Google-Smtp-Source: ABdhPJwt/XG2MZTlEppFFk8G1r1/qVZ1yTjstUzbN+tQiPehXje/vl5nsnt93i1Ai5LKQbJ/7dtirG1NiO/C7EgJ5oc=
X-Received: by 2002:ad4:5673:: with SMTP id bm19mr5107707qvb.4.1618516980354;
 Thu, 15 Apr 2021 13:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210414195758.4078803-1-robh@kernel.org> <CAM9d7chWROPAg3T_gd+T6N+94pWawKtggyegCGo0nXzKF+F7+g@mail.gmail.com>
 <CAL_JsqKuk53i0Lf=3sMOjieSNZo3Rqh+-Uhbd0n3qn=rpRKfLQ@mail.gmail.com>
 <YHiYJp9nabvsCZ4O@kernel.org> <YHiYkhBKWRYA6WRC@kernel.org> <YHiZLbHBsnBkVzbZ@kernel.org>
In-Reply-To: <YHiZLbHBsnBkVzbZ@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Apr 2021 15:02:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+S_fKzh2qDyfvsajjUnUGhM2qA7zPfeohgYZj-tBngQg@mail.gmail.com>
Message-ID: <CAL_Jsq+S_fKzh2qDyfvsajjUnUGhM2qA7zPfeohgYZj-tBngQg@mail.gmail.com>
Subject: Re: [PATCH] libperf: xyarray: Add bounds checks to xyarray__entry()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 2:51 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 15, 2021 at 04:48:34PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Apr 15, 2021 at 04:46:46PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Wed, Apr 14, 2021 at 03:53:36PM -0500, Rob Herring escreveu:
> > > > On Wed, Apr 14, 2021 at 3:25 PM Namhyung Kim <namhyung@kernel.org> =
wrote:
> > > > > > +static inline void *xyarray__entry(struct xyarray *xy, int x, =
int y)
> > > > > > +{
> > > > > > +       if (x >=3D xy->max_x || y >=3D xy->max_y)
> > > > > > +               return NULL;
> > > > >
> > > > > Maybe better to check negatives as well.
> > > >
> > > > max_x and max_y are size_t and unsigned, so x and y will be promote=
d
> > > > to unsigned and the check will still work.
> > >
> > > Fair enough, applied.
> >
> > So...:
> >
> >   CC       /tmp/build/perf/builtin-script.o
> > In file included from xyarray.c:2:
> > /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h: In funct=
ion =E2=80=98xyarray__entry=E2=80=99:
> > /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:8: err=
or: comparison of integer expressions of different signedness: =E2=80=98int=
=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=
=80=99} [-Werror=3Dsign-compare]
> >    28 |  if (x >=3D xy->max_x || y >=3D xy->max_y)
> >       |        ^~
> > /home/acme/git/perf/tools/lib/perf/include/internal/xyarray.h:28:26: er=
ror: comparison of integer expressions of different signedness: =E2=80=98in=
t=E2=80=99 and =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=
=80=99} [-Werror=3Dsign-compare]
> >    28 |  if (x >=3D xy->max_x || y >=3D xy->max_y)
> >       |                          ^~
> > cc1: all warnings being treated as errors
> >
> >
> > Fedora 33's gcc complains, so I'll cast it to size_t.

I guess gcc 10.2 on ubuntu doesn't yet. I was somewhat expecting to
see something and figured it was fine with -Wall...

Rob
