Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF53E1362
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhHELB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:01:59 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20796 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234312AbhHELBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AtWmZeq0NfKYHtKPQ0ZLnVwqjBHskLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL3nqynKpp9w6faaslossQ4b6Km90cW7LE80tqQFmrX5RI3SJjUO4V?=
 =?us-ascii?q?HYUb2KjrGSvAEIZReRygc1784JT0EZMrzN5DNB4voSjjPIb+rJMLO8gcaVbRW1?=
 =?us-ascii?q?9QYPcek2AJsQjTuQ62ygcnGePDM2fabR46DsgfauRVCbCBEqhiTQPAhgY9T+?=
X-IronPort-AV: E=Sophos;i="5.84,296,1620684000"; 
   d="scan'208";a="522854975"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 13:01:41 +0200
Date:   Thu, 5 Aug 2021 13:01:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Weizhao Ouyang <o451686892@gmail.com>
cc:     Gilles Muller <Gilles.Muller@inria.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, efremov@linux.com, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] coccinelle: api: rename kzfree to kfree_sensitive
In-Reply-To: <20210805095822.1732125-1-o451686892@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2108051301300.8365@hadrien>
References: <20210805095822.1732125-1-o451686892@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2021, Weizhao Ouyang wrote:

> Commit 453431a54934 ("mm, treewide: rename kzfree() to
> kfree_sensitive()") renamed kzfree() to kfree_sensitive(),
> it should be applied to coccinelle.
>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/api/kvmalloc.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
> index c30dab718a49..5ddcb76b76b0 100644
> --- a/scripts/coccinelle/api/kvmalloc.cocci
> +++ b/scripts/coccinelle/api/kvmalloc.cocci
> @@ -79,7 +79,7 @@ position p : script:python() { relevant(p) };
>    } else {
>      ... when != krealloc(E, ...)
>          when any
> -*   \(kfree\|kzfree\)(E)
> +*   \(kfree\|kfree_sensitive\)(E)
>      ...
>    }
>
> --
> 2.30.2
>
>
