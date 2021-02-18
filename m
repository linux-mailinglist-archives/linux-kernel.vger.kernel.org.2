Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7244831F099
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBRT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhBRTkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:40:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A4C464E2F;
        Thu, 18 Feb 2021 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613677181;
        bh=tBD1P8c4rgp4gpHNuXKB5YTNOT6ZZZi8PeaBJ/uIre4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKUjImZYWKoxUO3W375W+FVN5TiewBliAora8HsCmorQnlhIYk9Pg0Tob/NOOIh9W
         PKEQGqB2Mieg9DhOjFv/T3oMxdtc6G8yu4FZPG0G4pe3RbOS4X2VcMz0xMNz35sQqy
         fQ0h0AizuhA92/GVQxjNUsJWE5CNGlvyvd6auPzqgP81H98ianQqbDH+pwhFqOdyP0
         q59cVB8pjFHp2noKlU6EFxst/f5ku5EAciEc4k2LnfrQRfprQ7FqfGp1Nh+Q2lAqZd
         EiJWMXVL33fi+enI3DgSU2CikaKiTwpgcuC/AsycUuWkdPMT4yNMtg/EE148psVt9j
         4v77F1+D9VrqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 43E7D40CD9; Thu, 18 Feb 2021 16:39:38 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:39:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>,
        Huw Davies <huw@codeweavers.com>
Subject: Re: [PATCH 1/2] perf report: Remove redundant libbfd checks
Message-ID: <YC7CetsRKrZXf8WE@kernel.org>
References: <d1c87379-8837-a5e7-eb44-f063ca0f4766@codeweavers.com>
 <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94758ca1-0031-d7c6-6c6a-900fd77ef695@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 16, 2021 at 03:37:20PM -0500, Nicholas Fraser escreveu:
> This removes the redundant checks bfd_check_format() and
> bfd_target_elf_flavour. They were previously checking different files.

you forgot the:

Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>

I'm adding it, ok?

I'm also addressing Jiri's remark about spaces surrounding |

- Arnaldo
> ---
>  tools/perf/util/symbol.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 492c873713cc..08f6f57c84fd 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1586,15 +1586,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	if (section)
>  		dso->text_offset = section->vma - section->filepos;
>  
> -	if (!bfd_check_format(abfd, bfd_object)) {
> -		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
> -			  debugfile);
> -		goto out_close;
> -	}
> -
> -	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
> -		goto out_close;
> -
>  	symbols_size = bfd_get_symtab_upper_bound(abfd);
>  	if (symbols_size == 0) {
>  		bfd_close(abfd);
> -- 
> 2.30.1

-- 

- Arnaldo
