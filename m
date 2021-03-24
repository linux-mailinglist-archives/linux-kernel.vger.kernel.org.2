Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0C3482BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhCXUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:16:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:6518 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238153AbhCXUQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:16:32 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Agtl5mq0h1werp35a+9f/ogqjBFMkLtp033Aq?=
 =?us-ascii?q?2lEZdDV+dMuEm8ey2MkKzBOcskd0ZFgMkc2NUZPqfVry7phwiLN6AZ6DW03ctH?=
 =?us-ascii?q?KsPMVe6+LZogHIPw3b2qpj2bx7c654YeeAaGRSqcrh+gG3H5IB7bC8kJyAvuvV?=
 =?us-ascii?q?w3dzQQwCUcgJ0y5DBgmWCUFwTgVdbKBJd6a03NZNpDarZB0sAPiTO39tZYT+ju?=
 =?us-ascii?q?HQmImjSRALAANP0njtsRqYrI+/KRSe0xsEOgkj/Z4p+wH+/DDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,275,1610406000"; 
   d="scan'208";a="376775116"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 21:16:30 +0100
Date:   Wed, 24 Mar 2021 21:16:30 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: restrict patch mode in
 flexible_array.cocci
In-Reply-To: <20210308191215.1362498-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103242116040.7838@hadrien>
References: <20210308191215.1362498-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Mar 2021, Denis Efremov wrote:

> Skip patches generation for structs/unions with a single field.
> Changing a zero-length array to a flexible array member in a struct
> with no named members breaks the compilation. However, reporting
> such cases is still valuable, e.g. commit 637464c59e0b
> ("ACPI: NFIT: Fix flexible_array.cocci warnings").
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied.  I changed the log message to remove "/unions", since the change
doesn't mention unions.

julia

> ---
>  scripts/coccinelle/misc/flexible_array.cocci | 23 ++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
> index 947fbaff82a9..f427fd68ed2d 100644
> --- a/scripts/coccinelle/misc/flexible_array.cocci
> +++ b/scripts/coccinelle/misc/flexible_array.cocci
> @@ -51,21 +51,40 @@ position p : script:python() { relevant(p) };
>    };
>  )
>
> +@only_field depends on patch@
> +identifier name, array;
> +type T;
> +position q;
> +@@
> +
> +(
> +  struct name {@q
> +    T array[0];
> +  };
> +|
> +  struct {@q
> +    T array[0];
> +  };
> +)
> +
>  @depends on patch@
>  identifier name, array;
>  type T;
>  position p : script:python() { relevant(p) };
> +// position @q with rule "only_field" simplifies
> +// handling of bitfields, arrays, etc.
> +position q != only_field.q;
>  @@
>
>  (
> -  struct name {
> +  struct name {@q
>      ...
>      T array@p[
>  -       0
>      ];
>    };
>  |
> -  struct {
> +  struct {@q
>      ...
>      T array@p[
>  -       0
> --
> 2.26.2
>
>
