Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79732C0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579654AbhCCSbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:31:47 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:29916 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346514AbhCCQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:38:41 -0500
X-IronPort-AV: E=Sophos;i="5.81,220,1610406000"; 
   d="scan'208";a="495951182"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 17:37:54 +0100
Date:   Wed, 3 Mar 2021 17:37:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coccinelle: misc: add swap script
In-Reply-To: <20210219092448.13760-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103031736290.2980@hadrien>
References: <20210216080133.455456-1-efremov@linux.com> <20210219092448.13760-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Feb 2021, Denis Efremov wrote:

> Check for opencoded swap() implementation.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - additional patch rule to drop excessive {}
>  - fix indentation in patch mode by anchoring ;
>
>  scripts/coccinelle/misc/swap.cocci | 101 +++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/swap.cocci
>
> diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
> new file mode 100644
> index 000000000000..d5da9888c222
> --- /dev/null
> +++ b/scripts/coccinelle/misc/swap.cocci
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded swap() implementation.
> +///
> +// Confidence: High
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: swap
> +//
> +
> +virtual patch
> +virtual org
> +virtual report
> +virtual context
> +
> +@r depends on !patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T tmp;
> +|
> +* T tmp = 0;
> +|
> +* T *tmp = NULL;
> +)
> +... when != tmp
> +* tmp = a;
> +* a = b;@p
> +* b = tmp;
> +... when != tmp
> +
> +@rpvar depends on patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +@@
> +
> +(
> +- T tmp;
> +|
> +- T tmp = 0;
> +|
> +- T *tmp = NULL;
> +)
> +... when != tmp
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;
> +... when != tmp
> +
> +
> +@rp depends on patch@
> +identifier tmp;
> +expression a, b;
> +@@
> +
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;

A rule like the above should also appear in the non-patch case.

> +
> +@depends on (rpvar || rp)@

This needs to be depends on patch && (rpvar || rp).  It doesn't make much
sense, because rpvar and rp both depend on patch, but at the moment that
information isn't propagate everywhere that it is needed.

thanks,
julia

> +@@
> +
> +(
> +  for (...;...;...)
> +- {
> +	swap(...);
> +- }
> +|
> +  while (...)
> +- {
> +	swap(...);
> +- }
> +|
> +  if (...)
> +- {
> +	swap(...);
> +- }
> +)
> +
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> --
> 2.26.2
>
>
