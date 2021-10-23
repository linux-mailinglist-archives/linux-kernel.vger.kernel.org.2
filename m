Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0F438467
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJWREd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 13:04:33 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38082 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhJWREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 13:04:32 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A+Mkid6NrJgWzvX7vrR19lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQC53T1232EAxjEWDDqPOv3ZZDfxfYgjO460oxhX6JTUm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPnSHeKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFCtq?=
 =?us-ascii?q?piLf2dCXmQJaCYE7Q2jwPAfHk20cZzsAx+v9T2P40a1pTijzPm9luwdFJnZ22U?=
 =?us-ascii?q?wYgeKPW8AgYe0ACQnElZcWq/5eCexBTq/e7zEDLaFPr3ulgCFwme4sV5o5fA2Z?=
 =?us-ascii?q?D3eQVMjsNYwvFjOWzqJqwTeJnh+w4PczzNcUevGthxHfXF54ORZHFXrWP5tJC2?=
 =?us-ascii?q?jo0rt5BEOyYZMcDbzdrKhPabHVy1v0/YH4ltL733T+mKWQe9gLT9fdx+WXNihd?=
 =?us-ascii?q?/yv7rPca9RzBDfu0N9m7wm44M1z2R7skmCeGi?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ANQlI6aF+rQrHeoSXpLqEL8eALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Jom6uj5qaTdZUgpHjJYVMqMk3I9ursBICtRmzR8Jht7c0tO96ZLXKWwh?=
 =?us-ascii?q?rUXf1fBOfZrwEIXheOldK1tp0QF5SWaueAaGSS5PySiGKF+pQbsbu6GcuT5Ns2?=
 =?us-ascii?q?oU0DcegnUcFdxjY8Kyq/NCRNNXF7LKt8MLq5yudKqDKmdzA5bsGnCmJtZZm7mz?=
 =?us-ascii?q?Wm+aiWHiI7Ow=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,175,1631570400"; 
   d="scan'208";a="129830"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 19:02:13 +0200
Date:   Sat, 23 Oct 2021 19:02:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <kees@outflux.net>
cc:     Joe Perches <joe@perches.com>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [cocci] update Coccinelle entry
In-Reply-To: <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
Message-ID: <alpine.DEB.2.22.394.2110231901430.2967@hadrien>
References: <alpine.DEB.2.22.394.2110231758550.2967@hadrien> <6A7FEC25-CBC1-434D-BD81-1FDB81DD9B45@outflux.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Oct 2021, Kees Cook wrote:

>
>
> On October 23, 2021 9:01:18 AM PDT, Julia Lawall <julia.lawall@inria.fr> wrote:
> >Update mailing list and website.  Drop Michal Marek as a maintainer, who
> >has not participated in a long time.
> >
> >Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> >---
> >
> >For information.  This will be in my tree.
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 7d46f03e5037..8746149b6623 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -4594,10 +4594,9 @@ COCCINELLE/Semantic Patches (SmPL)
> > M:	Julia Lawall <Julia.Lawall@inria.fr>
> > M:	Gilles Muller <Gilles.Muller@inria.fr>
> > M:	Nicolas Palix <nicolas.palix@imag.fr>
> >-M:	Michal Marek <michal.lkml@markovi.net>
> >-L:	cocci@systeme.lip6.fr (moderated for non-subscribers)
> >+L:	cocci@inria.fr (moderated for non-subscribers)
> > S:	Supported
> >-W:	http://coccinelle.lip6.fr/
> >+W:	https://coccinelle.gitlabpages.inria.fr/website/
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git misc
>
> Perhaps drop this tree and add yours, too?

Sure, thanks for the suggestion.

julia

>
> > F:	Documentation/dev-tools/coccinelle.rst
> > F:	scripts/coccicheck
>
>
>
>
> --
> Kees Cook
>
