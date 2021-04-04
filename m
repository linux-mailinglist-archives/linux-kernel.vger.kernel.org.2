Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2469353811
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhDDMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 08:34:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:63379 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhDDMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 08:34:04 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXFkxo6B84EHIPpflHelM55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/UZ3VBBTb4ikh9mj9c576TbYgCscMUtKpfmuI6+FKEm3ybdQwa08eYivRxPnvm?=
 =?us-ascii?q?zAFu9fxK/v2SfpFSG71sM178tdWpNzAtHxElR25PySiDWQKcoqw9WM7cmT6tv2?=
 =?us-ascii?q?8nZ3QQlmL4Fm4gtpYzzrcHFeeQhcCZI1UKeb/8pMzgDQHEg/U8LTPBQ4dtmGg9?=
 =?us-ascii?q?XKkZ78CCR2ZCIP2U2pljOn6LnzDhie0FM/alp0oYsfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,304,1610406000"; 
   d="scan'208";a="501516764"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2021 14:33:59 +0200
Date:   Sun, 4 Apr 2021 14:33:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: misc: add swap script
In-Reply-To: <afb06bbc-5c28-8a92-f205-c9a1c87c707c@linux.com>
Message-ID: <alpine.DEB.2.22.394.2104041433430.2958@hadrien>
References: <20210216080133.455456-1-efremov@linux.com> <20210305100956.6222-1-efremov@linux.com> <afb06bbc-5c28-8a92-f205-c9a1c87c707c@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Mar 2021, Denis Efremov wrote:

> Ping?

Applied.  Thanks.

>
> On 3/5/21 1:09 PM, Denis Efremov wrote:
> > Check for opencoded swap() implementation.
> >
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> > Changes in v2:
> >   - additional patch rule to drop excessive {}
> >   - fix indentation in patch mode by anchoring ;
> > Changes in v3:
> >   - Rule added for simple (without var init) swap highlighting in !patch
> > mode
> >   - "depends on patch && (rpvar || rp)" fixed
> >
> >   scripts/coccinelle/misc/swap.cocci | 122 +++++++++++++++++++++++++++++
> >   1 file changed, 122 insertions(+)
> >   create mode 100644 scripts/coccinelle/misc/swap.cocci
> >
> > diff --git a/scripts/coccinelle/misc/swap.cocci
> > b/scripts/coccinelle/misc/swap.cocci
> > new file mode 100644
> > index 000000000000..c5e71b7ef7f5
> > --- /dev/null
> > +++ b/scripts/coccinelle/misc/swap.cocci
> > @@ -0,0 +1,122 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +///
> > +/// Check for opencoded swap() implementation.
> > +///
> > +// Confidence: High
> > +// Copyright: (C) 2021 Denis Efremov ISPRAS
> > +// Options: --no-includes --include-headers
> > +//
> > +// Keywords: swap
> > +//
> > +
> > +virtual patch
> > +virtual org
> > +virtual report
> > +virtual context
> > +
> > +@rvar depends on !patch@
> > +identifier tmp;
> > +expression a, b;
> > +type T;
> > +position p;
> > +@@
> > +
> > +(
> > +* T tmp;
> > +|
> > +* T tmp = 0;
> > +|
> > +* T *tmp = NULL;
> > +)
> > +... when != tmp
> > +* tmp = a;
> > +* a = b;@p
> > +* b = tmp;
> > +... when != tmp
> > +
> > +@r depends on !patch@
> > +identifier tmp;
> > +expression a, b;
> > +position p != rvar.p;
> > +@@
> > +
> > +* tmp = a;
> > +* a = b;@p
> > +* b = tmp;
> > +
> > +@rpvar depends on patch@
> > +identifier tmp;
> > +expression a, b;
> > +type T;
> > +@@
> > +
> > +(
> > +- T tmp;
> > +|
> > +- T tmp = 0;
> > +|
> > +- T *tmp = NULL;
> > +)
> > +... when != tmp
> > +- tmp = a;
> > +- a = b;
> > +- b = tmp
> > ++ swap(a, b)
> > +  ;
> > +... when != tmp
> > +
> > +@rp depends on patch@
> > +identifier tmp;
> > +expression a, b;
> > +@@
> > +
> > +- tmp = a;
> > +- a = b;
> > +- b = tmp
> > ++ swap(a, b)
> > +  ;
> > +
> > +@depends on patch && (rpvar || rp)@
> > +@@
> > +
> > +(
> > +  for (...;...;...)
> > +- {
> > +	swap(...);
> > +- }
> > +|
> > +  while (...)
> > +- {
> > +	swap(...);
> > +- }
> > +|
> > +  if (...)
> > +- {
> > +	swap(...);
> > +- }
> > +)
> > +
> > +
> > +@script:python depends on report@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on org@
> > +p << r.p;
> > +@@
> > +
> > +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on report@
> > +p << rvar.p;
> > +@@
> > +
> > +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> > +
> > +@script:python depends on org@
> > +p << rvar.p;
> > +@@
> > +
> > +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> >
>
