Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2B3DB779
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhG3K6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:58:48 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41513
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238403AbhG3K6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:58:46 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2eBEUquv5/I2tx8aNsVdyL8A7skDr9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j+/xG+c5x6faaslkssQ4b9+xoVJPgfZr3z/5ICPAqTNSftVDdyQ?=
 =?us-ascii?q?mVxeJZnO7fKkPbaknDH7VmpMBdmsFFYbXN5D5B/KDHCWKDfurIruPszEhd792u?=
 =?us-ascii?q?tkuFNTsaE52JZGxCe32m+sccfng9OXKBf6Dsm/Z6mw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620684000"; 
   d="scan'208";a="389360966"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 12:58:40 +0200
Date:   Fri, 30 Jul 2021 12:58:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Daniel Thompson <daniel.thompson@linaro.org>
cc:     Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: coccinelle: allow list_entry_is_head() to use
 pos
In-Reply-To: <20210730095856.2038286-1-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2107301257470.52326@hadrien>
References: <20210730095856.2038286-1-daniel.thompson@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Jul 2021, Daniel Thompson wrote:

> Currently use_after_iter.cocci generates false positives for code of the
> following form:
> ~~~
> 	list_for_each_entry(d, &ddata->irq_list, node) {
> 		if (irq == d->irq)
> 			break;
> 	}
>
> 	if (list_entry_is_head(d, &ddata->irq_list, node))
> 		return IRQ_NONE;
> ~~~
> [This specific example comes from drivers/power/supply/cpcap-battery.c]
>
> Most list macros use list_entry_is_head() as loop exit condition meaning it
> is not unsafe to reuse pos (a.k.a. d) in the code above.
>
> Let's avoid reporting these cases.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     I'm pretty much a complete beginner w.r.t. SmPL. This is written
>     entirely by finding previous fixes and emulating them!
>
>     However I did test it by running the checker across the current kernel
>     tree. The changes reduced the error count by four... which was small
>     enough for me to eyeball each one and check they match the pattern I
>     was targetting.

This looks fine.  Thanks for the proposal.

julia

>
>  scripts/coccinelle/iterators/use_after_iter.cocci | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index 9be48b520879..676edd562eef 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -123,6 +123,8 @@ hlist_for_each_entry_safe(c,...) S
>  |
>  list_remove_head(x,c,...)
>  |
> +list_entry_is_head(c,...)
> +|
>  sizeof(<+...c...+>)
>  |
>   &c->member
>
> base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> --
> 2.30.2
>
>
