Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE33482EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhCXUbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:31:34 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:53678
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237892AbhCXUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:31:25 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApUwnRqgmawWInLhM+gfn6+LDFnBQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,275,1610406000"; 
   d="scan'208";a="376775754"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 21:31:24 +0100
Date:   Wed, 24 Mar 2021 21:31:23 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: update uninitialized_var.cocci
 documentation
In-Reply-To: <20210308073018.108487-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103242131140.7838@hadrien>
References: <20210308073018.108487-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Mar 2021, Denis Efremov wrote:

> Remove the documentation link from the warning message because commit
> 3942ea7a10c9 ("deprecated.rst: Remove now removed uninitialized_var")
> removed the section from documentation. Update the rule documentation
> accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/misc/uninitialized_var.cocci | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> index 8fa845cefe11..69bbaae47e73 100644
> --- a/scripts/coccinelle/misc/uninitialized_var.cocci
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// Please, don't reintroduce uninitialized_var().
> -/// From Documentation/process/deprecated.rst:
> +///
> +/// From Documentation/process/deprecated.rst,
> +/// commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()"):
>  ///  For any compiler warnings about uninitialized variables, just add
>  ///  an initializer. Using warning-silencing tricks is dangerous as it
>  ///  papers over real bugs (or can in the future), and suppresses unrelated
> @@ -11,6 +13,11 @@
>  ///  obviously redundant, the compiler's dead-store elimination pass will make
>  ///  sure there are no needless variable writes.
>  ///
> +/// Later, commit 3942ea7a10c9 ("deprecated.rst: Remove now removed
> +/// uninitialized_var") removed this section because all initializations of
> +/// this kind were cleaned-up from the kernel. This cocci rule checks that
> +/// the macro is not explicitly or implicitly reintroduced.
> +///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
> @@ -40,12 +47,10 @@ position p;
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.report.print_report(p[0], "WARNING this kind of initialization is deprecated")
>
>  @script:python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.org.print_todo(p[0], "WARNING this kind of initialization is deprecated")
> --
> 2.26.2
>
>
