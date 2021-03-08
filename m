Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776AB331962
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCHVa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:30:56 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14813
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230404AbhCHVad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:30:33 -0500
X-IronPort-AV: E=Sophos;i="5.81,233,1610406000"; 
   d="scan'208";a="375142415"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:30:31 +0100
Date:   Mon, 8 Mar 2021 22:30:31 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: misc: add minmax script
In-Reply-To: <20210308070445.104768-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103082226540.15999@hadrien>
References: <20210216160326.1341741-1-efremov@linux.com> <20210308070445.104768-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@pmaxif depends on patch@
> +identifier func;
> +expression x, y;
> +expression max_val;
> +binary operator cmp = {>=, >};
> +@@
> +
> +func(...)
> +{
> +	<...
> +-	if ((x) cmp (y)) {
> +-		max_val = (x);
> +-	} else {
> +-		max_val = (y);
> +-	}
> ++	max_val = max(x, y);
> +	...>
> +}

Things work better if there are no parentheses in max_val = (x) and
max_val = (y).  Leaving them there seems to cause the match to work in two
ways, causing an already tagged token error.  An example is in
crypto/jitterentropy.c

The same is true of the pminif rule.  Only the patch rules are affected.
Double matches are allowed in the context cas, ince there is no real
transfotmation in that case.

julia

> +
> +@pmin depends on patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {<=, <};
> +@@
> +
> +func(...)
> +{
> +	<...
> +-	((x) cmp (y) ? (x) : (y))
> ++	min(x, y)
> +	...>
> +}
> +
> +@pminif depends on patch@
> +identifier func;
> +expression x, y;
> +expression min_val;
> +binary operator cmp = {<=, <};
> +@@
> +
> +func(...)
> +{
> +	<...
> +-	if ((x) cmp (y)) {
> +-		min_val = (x);
> +-	} else {
> +-		min_val = (y);
> +-	}
> ++	min_val = min(x, y);
> +	...>
> +}
> +
> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.report.print_report(p0, "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmax.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmaxif.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.report.print_report(p0, "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmaxif.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmin.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.report.print_report(p0, "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rmin.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
> +
> +@script:python depends on report@
> +p << rminif.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.report.print_report(p0, "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rminif.p;
> +@@
> +
> +for p0 in p:
> +	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
> --
> 2.26.2
>
>
