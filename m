Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1863E82FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhHJS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhHJS2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:28:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48F406056C;
        Tue, 10 Aug 2021 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628620096;
        bh=gZhKtZc4N5ZSExa+Yftg7NP93sEBPqgUCnRxRbFN4js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pX2rUdeKE7uNEFg4n+DPhUZnSeSvSIlhlgupmnWbYuG/XmZj86npf7liNyt3IaTZu
         7kSCqs/r4kFUo9IR5HvxpK1atlwLwTCH8gzO55YYzgxYf0HYPyEMGA8txHOGr+lykg
         F473S8Y2OXeB6bjWFXgFtD2Lw6dDYFfW7HPvgBwMUg4Pn2LBOvJuXPAiWkrkPl3dxX
         CdP7T7w1Y0oWVW9o9lAAFpvTu34GGiWEt1OQOa67whK1QcL7CZdCS4wPS7Bk5dxcbp
         rPNi//MQ+VfYcUcR3nC1gR4VQ2VAy98TEJQZnyncLgB63DAT4XfEnoewySAkRgqHt/
         2+0UmfgMrAhpg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BAD1403F2; Tue, 10 Aug 2021 15:28:13 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:28:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] perf script: Fix --list-dlfilters documentation
Message-ID: <YRLFPXUL4cUUq1Lv@kernel.org>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810114813.12951-3-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 10, 2021 at 02:48:10PM +0300, Adrian Hunter escreveu:
> The option --list-dlfilters does use a string value.

Added:

Fixes: 638e2b9984ee1b8d ("perf script: Add option to list dlfilters")

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index aa3a0b2c29a2..c80515243560 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -106,7 +106,7 @@ OPTIONS
>  	Pass 'arg' as an argument to the dlfilter. --dlarg may be repeated
>  	to add more arguments.
>  
> ---list-dlfilters=::
> +--list-dlfilters::
>          Display a list of available dlfilters. Use with option -v (must come
>          before option --list-dlfilters) to show long descriptions.
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
