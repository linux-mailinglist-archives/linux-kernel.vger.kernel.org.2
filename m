Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51F35FB53
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbhDNTIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346306AbhDNTIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:08:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBDA061042;
        Wed, 14 Apr 2021 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618427296;
        bh=ohAveY990mPVfnTuwvXnRKcliRUJGJF/de+vWAGj+Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZw7fLbQBIkfaD+GT0tgeJw7FxenvBnd1eSel4Bmc1mdUs7zQce8fgV3xtgc1a/eO
         Nxpc5moASr0d3EdB9bzIkskro5a7UzTwo5WBQ2ZvoMu0Xc1pKDKCD2HTxPh0j2AuPy
         Ym6puR2oCjF23+IwBHoIHv/WN7oZ+U+ca1iK/yE+fCrqylG7dwtABrlcEjzwU8PM/C
         hQSX92gbnBzPqU9ZiXY1uBH3gArliB7Q9o+hv0/Q2R2+d1npF6TeJQd6KqxPuMe/jl
         Mo8LhiKd4DL7M1IHpTcqij+pyoQsiBWq1eXWBug7L3pvmqxYQnUrELAgK0YUVbeQgj
         96Jl2grZXgJHg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D147940647; Wed, 14 Apr 2021 16:08:12 -0300 (-03)
Date:   Wed, 14 Apr 2021 16:08:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2] perf beauty: Fix fsconfig generator
Message-ID: <YHc9nC6EYf/eP3GH@kernel.org>
References: <20210414182723.1670663-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414182723.1670663-1-vt@altlinux.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 09:27:23PM +0300, Vitaly Chikunov escreveu:
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
>  tools/perf/trace/beauty/fsconfig.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
> index 83fb24df05c9f..bc6ef7bb7a5f9 100755
> --- a/tools/perf/trace/beauty/fsconfig.sh
> +++ b/tools/perf/trace/beauty/fsconfig.sh
> @@ -10,8 +10,7 @@ fi
>  linux_mount=${linux_header_dir}/mount.h
>  
>  printf "static const char *fsconfig_cmds[] = {\n"
> -regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
> -egrep $regex ${linux_mount} | \
> -	sed -r "s/$regex/\2 \1/g"	| \
> -	xargs printf "\t[%s] = \"%s\",\n"
> +ms='[[:space:]]*'
> +sed -nr "s/^${ms}FSCONFIG_([[:alnum:]_]+)${ms}=${ms}([[:digit:]]+)${ms},.*/\t[\2] = \"\1\",/p" \
> +	${linux_mount}
>  printf "};\n"

It continues working:

[acme@five perf]$ tools/perf/trace/beauty/fsconfig.sh
static const char *fsconfig_cmds[] = {
	[0] = "SET_FLAG",
	[1] = "SET_STRING",
	[2] = "SET_BINARY",
	[3] = "SET_PATH",
	[4] = "SET_PATH_EMPTY",
	[5] = "SET_FD",
	[6] = "CMD_CREATE",
	[7] = "CMD_RECONFIGURE",
};
[acme@five perf]$

Cool, this is on f33, lemme see on some other distro:

perfbuilder@fd2d918f35e1:/git/perf$ sed --version | head -1
sed (GNU sed) 4.2.2
perfbuilder@fd2d918f35e1:/git/perf$ cat tools/perf/trace/beauty/fsconfig.sh 
#!/bin/sh
# SPDX-License-Identifier: LGPL-2.1

if [ $# -ne 1 ] ; then
	linux_header_dir=tools/include/uapi/linux
else
	linux_header_dir=$1
fi

linux_mount=${linux_header_dir}/mount.h

printf "static const char *fsconfig_cmds[] = {\n"
ms='[[:space:]]*'
sed -nr "s/^${ms}FSCONFIG_([[:alnum:]_]+)${ms}=${ms}([[:digit:]]+)${ms},.*/\t[\2] = \"\1\",/p" \
	${linux_mount}
printf "};\n"
perfbuilder@fd2d918f35e1:/git/perf$ tools/perf/trace/beauty/fsconfig.sh 
static const char *fsconfig_cmds[] = {
	[0] = "SET_FLAG",
	[1] = "SET_STRING",
	[2] = "SET_BINARY",
	[3] = "SET_PATH",
	[4] = "SET_PATH_EMPTY",
	[5] = "SET_FD",
	[6] = "CMD_CREATE",
	[7] = "CMD_RECONFIGURE",
};
perfbuilder@fd2d918f35e1:/git/perf$


[perfbuilder@five sisyphus]$ dsh alt:sisyphus
sh-4.4# bash
[root@6db6d5ad9661 /]# cat /etc/redhat-release
ALT Sisyphus Sisyphus (unstable) (sisyphus)
[root@6db6d5ad9661 /]# cd /git
[root@6db6d5ad9661 git]# cd perf
[root@6db6d5ad9661 perf]# cat tools/perf/trace/beauty/fsconfig.sh
#!/bin/sh
# SPDX-License-Identifier: LGPL-2.1

if [ $# -ne 1 ] ; then
	linux_header_dir=tools/include/uapi/linux
else
	linux_header_dir=$1
fi

linux_mount=${linux_header_dir}/mount.h

printf "static const char *fsconfig_cmds[] = {\n"
ms='[[:space:]]*'
sed -nr "s/^${ms}FSCONFIG_([[:alnum:]_]+)${ms}=${ms}([[:digit:]]+)${ms},.*/\t[\2] = \"\1\",/p" \
	${linux_mount}
printf "};\n"
[root@6db6d5ad9661 perf]# tools/perf/trace/beauty/fsconfig.sh
static const char *fsconfig_cmds[] = {
	[0] = "SET_FLAG",
	[1] = "SET_STRING",
	[2] = "SET_BINARY",
	[3] = "SET_PATH",
	[4] = "SET_PATH_EMPTY",
	[5] = "SET_FD",
	[6] = "CMD_CREATE",
	[7] = "CMD_RECONFIGURE",
};
[root@6db6d5ad9661 perf]#

So I guess we can sweep thru tools/perf/trace/beauty/*.sh and simplify
things in other table generators?

Please consider this.

Thanks, applied.

- Arnaldo
