Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07363E1361
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhHELBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:01:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20796 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240689AbhHELBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:39 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZPEIbaw2G6AAouNYFfEiKrPwT71zdoMgy1kn?=
 =?us-ascii?q?xilNoHtuEvBw9vrOoB1173TJYVoqMk3I+urvBEDjex/hHPdOiOEs1NyZMzUO1l?=
 =?us-ascii?q?HEEL1f?=
X-IronPort-AV: E=Sophos;i="5.84,296,1620684000"; 
   d="scan'208";a="522854957"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 13:01:23 +0200
Date:   Thu, 5 Aug 2021 13:01:23 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Weizhao Ouyang <o451686892@gmail.com>, Julia.Lawall@inria.fr,
        Gilles.Muller@inria.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] coccinelle: api: rename kzfree to kfree_sensitive
In-Reply-To: <3cb9caa9-b7d3-5b1b-7020-63d72506c7c7@linux.com>
Message-ID: <alpine.DEB.2.22.394.2108051301170.8365@hadrien>
References: <20210805095822.1732125-1-o451686892@gmail.com> <3cb9caa9-b7d3-5b1b-7020-63d72506c7c7@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2021, Denis Efremov wrote:

> Hi,
>
> On 8/5/21 12:58 PM, Weizhao Ouyang wrote:
> > Commit 453431a54934 ("mm, treewide: rename kzfree() to
> > kfree_sensitive()") renamed kzfree() to kfree_sensitive(),
> > it should be applied to coccinelle.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>
> Acked-by: Denis Efremov <efremov@linux.com>

Thanks.

>
> > ---
> >  scripts/coccinelle/api/kvmalloc.cocci | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
> > index c30dab718a49..5ddcb76b76b0 100644
> > --- a/scripts/coccinelle/api/kvmalloc.cocci
> > +++ b/scripts/coccinelle/api/kvmalloc.cocci
> > @@ -79,7 +79,7 @@ position p : script:python() { relevant(p) };
> >    } else {
> >      ... when != krealloc(E, ...)
> >          when any
> > -*   \(kfree\|kzfree\)(E)
> > +*   \(kfree\|kfree_sensitive\)(E)
> >      ...
> >    }
> >
> >
>
> Regards,
> Denis
>
