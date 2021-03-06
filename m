Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB932FB16
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhCFOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 09:09:03 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16188 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhCFOI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 09:08:57 -0500
X-IronPort-AV: E=Sophos;i="5.81,228,1610406000"; 
   d="scan'208";a="496489458"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2021 15:08:56 +0100
Date:   Sat, 6 Mar 2021 15:08:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] coccinelle: misc: add minmax script
In-Reply-To: <20210219090655.8985-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103061503290.2976@hadrien>
References: <20210216160326.1341741-1-efremov@linux.com> <20210219090655.8985-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Feb 2021, Denis Efremov wrote:

> Check for opencoded min(), max() implementations.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>
> Changes in v2:
>  - <... ...> instead of ... when any
>  - org mode reports fixed
>  - patch rule to drop excessive ()
>
>  scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/minmax.cocci
>
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> new file mode 100644
> index 000000000000..61d6b61fd82c
> --- /dev/null
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded min(), max() implementations.
> +/// Generated patches sometimes require adding a cast to fix compile warning.
> +/// Warnings/patches scope intentionally limited to a function body.
> +///
> +// Confidence: Medium
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: min, max
> +//
> +
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@rmax depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y

The rule below indicated with FIXME is supposed to deal with the
possibility of () that are unnecessary when using min and max.  It doesn't
work, because <... P ...> allow P to match 0 or more times, and thus
func@p matches every function.

A simpler solution is to just allow arbitrary () in the pattern, eg:

  (x) cmp@p (y) ? (x) : (y)

That will allow each occurrence of x and y to occur with and without
parentheses.  In the submitted  semantic patch, the () issue was only
considered in the patch case.  But it actually affects the purely matching
cases too, because () can be used at one occurrence, but not the other.

> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")

p is an array because it can be bound to different positions on different
control-flow paths.  Notably this occurs with <... ...>.  If there are
multiple occurrences of the pattern, there will be one match that contains
all of them.  Thus the reporting code should be:

for p0 in p:
  coccilib.report.print_report(p0, "WARNING opportunity for max()")

julia
