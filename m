Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6063AF57A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhFUSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:57 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58727 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232329AbhFUSty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:54 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AFTM8E6/U+dPHV242oeZuk+DEI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlEPBw+PrAoB1273HJYVUqKRIdcLK7WZVoKEm0nfVICOIqUItKMjONhI?=
 =?us-ascii?q?LRFuFfBV2L+VHdJxE=3D?=
X-IronPort-AV: E=Sophos;i="5.83,289,1616454000"; 
   d="scan'208";a="515895312"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 20:47:38 +0200
Date:   Mon, 21 Jun 2021 20:47:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] coccinelle: api: remove kobj_to_dev.cocci script
In-Reply-To: <cc3b2db6-70fd-0bb2-d083-f87f9a35e9a7@linux.com>
Message-ID: <alpine.DEB.2.22.394.2106212047100.47043@hadrien>
References: <20210621174808.1489111-1-kbusch@kernel.org> <cc3b2db6-70fd-0bb2-d083-f87f9a35e9a7@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jun 2021, Denis Efremov wrote:

>
>
> On 6/21/21 8:48 PM, Keith Busch wrote:
> > Using kobj_to_dev() instead of container_of() is not universally
> > accepted among maintainers as an improvement. The warning leads to
> > repeated patch submissions that won't be accepted. Remove the script.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Denis Efremov <efremov@linux.com>
> > Cc: Julia Lawall <Julia.Lawall@inria.fr>
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
>
> Acked-by: Denis Efremov <efremov@linux.com>

Applied.

>
> > ---
> >  scripts/coccinelle/api/kobj_to_dev.cocci | 45 ------------------------
> >  1 file changed, 45 deletions(-)
> >  delete mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci
> >
> > diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
> > deleted file mode 100644
> > index cd5d31c6fe76..000000000000
> > --- a/scripts/coccinelle/api/kobj_to_dev.cocci
> > +++ /dev/null
> > @@ -1,45 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0-only
> > -///
> > -/// Use kobj_to_dev() instead of container_of()
> > -///
> > -// Confidence: High
> > -// Copyright: (C) 2020 Denis Efremov ISPRAS
> > -// Options: --no-includes --include-headers
> > -//
> > -// Keywords: kobj_to_dev, container_of
> > -//
> > -
> > -virtual context
> > -virtual report
> > -virtual org
> > -virtual patch
> > -
> > -
> > -@r depends on !patch@
> > -expression ptr;
> > -symbol kobj;
> > -position p;
> > -@@
> > -
> > -* container_of(ptr, struct device, kobj)@p
> > -
> > -
> > -@depends on patch@
> > -expression ptr;
> > -@@
> > -
> > -- container_of(ptr, struct device, kobj)
> > -+ kobj_to_dev(ptr)
> > -
> > -
> > -@script:python depends on report@
> > -p << r.p;
> > -@@
> > -
> > -coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
> > -
> > -@script:python depends on org@
> > -p << r.p;
> > -@@
> > -
> > -coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
> >
>
