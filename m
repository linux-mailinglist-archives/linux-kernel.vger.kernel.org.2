Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FB35FA37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbhDNSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhDNSEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:04:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E8961168;
        Wed, 14 Apr 2021 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618423459;
        bh=da5oT651eb/OA+CG8BtsWgd/Hqwu7V9RxxqBlB2OEdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lnuSB3Cb5tSKDAXDkV4+JZhuUg+NHch25ugvyzLwx4FZdZIM+cRKawykeFuhHLPHg
         QtPURQ8GxoFR3axiE8w1q+MqT0jwwjmI/VZ26KhjdeLWHpqp+WKAsoqfY8Pe4ira/L
         +xaQ/w/ragT5KLXyRUFUsRKFz++g5L9D0OYyM0qg/b+Im1yeNdiz1GpLlGMYorE1+u
         f4mfzMqF+epicb8nQdnflMQJCitI3cesy/g6l7liNVoYy0re8fDID1Ub/J2q1Dy5mr
         //wUgl4XamCnQRKE/M6Uckh+YYS4nA1qU7pje9hC/lyEeP95ptREJbFPXCVa38d+kG
         fLMNQ4ajyjwJQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C316440647; Wed, 14 Apr 2021 15:04:16 -0300 (-03)
Date:   Wed, 14 Apr 2021 15:04:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] perf beauty: Fix fsconfig generator
Message-ID: <YHcuoEz8KzGjoZO1@kernel.org>
References: <20210414162942.1660600-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414162942.1660600-1-vt@altlinux.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 07:29:42PM +0300, Vitaly Chikunov escreveu:
> After gnulib update sed stopped matching `[[:space:]]*+' as before,
> causing the following compilation error:
> 
>   In file included from builtin-trace.c:719:
>   trace/beauty/generated/fsconfig_arrays.c:2:3: error: expected expression before ']' token
>       2 |  [] = "",
> 	|   ^
>   trace/beauty/generated/fsconfig_arrays.c:2:3: error: array index in initializer not of integer type
>   trace/beauty/generated/fsconfig_arrays.c:2:3: note: (near initialization for 'fsconfig_cmds')
> 
> Fix this by correcting the regular expression used in the generator.
> Also, clean up the script by removing redundant egrep, xargs, and printf
> invocations.
> 
> Fixes: d35293004a5e4 ("perf beauty: Add generator for fsconfig's 'cmd' arg values")
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  tools/perf/trace/beauty/fsconfig.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
> index 83fb24df05c9f..cc76b2aa7a5af 100755
> --- a/tools/perf/trace/beauty/fsconfig.sh
> +++ b/tools/perf/trace/beauty/fsconfig.sh
> @@ -10,8 +10,6 @@ fi
>  linux_mount=${linux_header_dir}/mount.h
>  
>  printf "static const char *fsconfig_cmds[] = {\n"
> -regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
> -egrep $regex ${linux_mount} | \
> -	sed -r "s/$regex/\2 \1/g"	| \
> -	xargs printf "\t[%s] = \"%s\",\n"
> +regex='^[[:space:]]*FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,.*'
> +sed -nr "s/$regex/\t[\2] = \"\1\",/p" ${linux_mount}
>  printf "};\n"

Testing this, all working, I'll step back and ask you to remove that now
useless regex variable and do it directly in the now only line using it,
the sed one.

- Arnaldo
