Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC031E12F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhBQVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:18:52 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:57059
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhBQVSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:18:40 -0500
X-IronPort-AV: E=Sophos;i="5.81,185,1610406000"; 
   d="scan'208";a="373371849"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 22:17:56 +0100
Date:   Wed, 17 Feb 2021 22:17:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: add minmax script
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102172208030.3081@hadrien>
References: <20210216160326.1341741-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Feb 2021, Denis Efremov wrote:

> Check for opencoded min(), max() implementations.

Some cases that could be improved:

diff -u -p a/drivers/platform/x86/asus-laptop.c
b/drivers/platform/x86/asus-laptop.c
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1195,7 +1195,7 @@ static ssize_t ls_level_store(struct dev
        if (rv < 0)
                return rv;

-       value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+       value = (0 < value) ? (min(15, value)) : 0;
        /* 0 <= value <= 15 */
        asus_als_level(asus, value);


diff -u -p a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -382,7 +382,7 @@ static int atc_pcm_playback_start(struct
	apcm->started = 1;

        max_cisz = src->multi * src->rsc.msr;
-       max_cisz = 0x80 * (max_cisz < 8 ? max_cisz : 8);
+       max_cisz = 0x80 * (min(max_cisz, 8));


> +func(...)
> +{
> +	... when any
> +*	(x cmp y) ?@p x : y
> +	... when any
> +}

In all cases, this would be more efficient as:

func(...)
{
 <...
* (x cmp y) ?@p x : y
 ...>
}

There is an optimization that causes this to be just a search through the
nodes of the control-flow graph, rather than following the actual control
flow from the beginning of the function to the end.

> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_todo(p[0], "WARNING opportunity for max()")

All of the org cases should be coccilib.org, not coccilib.report.

julia
