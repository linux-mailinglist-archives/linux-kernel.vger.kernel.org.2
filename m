Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1331E16D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhBQVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:32:18 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36576
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233009AbhBQVbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:31:47 -0500
X-IronPort-AV: E=Sophos;i="5.81,185,1610406000"; 
   d="scan'208";a="373372739"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 22:31:06 +0100
Date:   Wed, 17 Feb 2021 22:31:05 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: add swap script
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
References: <20210216080133.455456-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@depends on patch@
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
> +- b = tmp;
> ++ swap(a, b);
> +... when != tmp

In this rule and the next one, if you remove the final ; from the b = tmp
line and from the swap line, and put it into context code afterwards, them
the generated code looks better on cases like fs/xfs/xfs_inode.c in the
function xfs_lock_two_inodes where two successive swap calls are
generated.

There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
the function ath5k_hw_get_median_noise_floor where the swap code makes up
a whole if branch.  In this cases it would be good to remove the {}.

julia

> +
> +@depends on patch@
> +identifier tmp;
> +expression a, b;
> +@@
> +
> +- tmp = a;
> +- a = b;
> +- b = tmp;
> ++ swap(a, b);
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
