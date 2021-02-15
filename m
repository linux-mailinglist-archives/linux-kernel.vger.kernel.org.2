Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6A31BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBOOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230263AbhBOOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613399792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yT/G8N9CXyvljd+tvh5I4wNlZRRzAx+Hntb2QSeKQ2s=;
        b=H9w9jkluBoC2Ee/VQPxIOf005qfqY2wnwFxJEclwP2CG5bi6NMP9aZZ+Dqck7wImJtgFYi
        EhqbuD5e7DS10TRZX5ewXxNF8l6MXvbwBY3+YsdOYHkBCx6bWVC0+oz1ZOCW9haipH926F
        YCuAn6g4zWTfB9xmDLuWm01i1ch6Xng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-wm6eVPO8NSW_VnDGdlSHXQ-1; Mon, 15 Feb 2021 09:36:29 -0500
X-MC-Unique: wm6eVPO8NSW_VnDGdlSHXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 493561005501;
        Mon, 15 Feb 2021 14:36:26 +0000 (UTC)
Received: from krava (unknown [10.40.195.239])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC72862A0E;
        Mon, 15 Feb 2021 14:36:22 +0000 (UTC)
Date:   Mon, 15 Feb 2021 15:36:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH 2/4] perf report: Load PE files from debug cache only
Message-ID: <YCqG5Z4CbMtsWZ5e@krava>
References: <e58e1237-94ab-e1c9-a7b9-473531906954@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58e1237-94ab-e1c9-a7b9-473531906954@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:17:38PM -0500, Nicholas Fraser wrote:
> dso__load_bfd_symbols() attempts to load a DSO at its original path,
> then closes it and loads the file in the debug cache. This is incorrect.
> It should ignore the original file and work with only the debug cache.
> The original file may have changed or may not even exist, for example if
> the debug cache has been transferred to another machine via "perf
> archive".
> 
> This fix makes it only load the file in the debug cache.
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> ---
>  tools/perf/util/symbol.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 64a039cbba1b..aa9ae875b995 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1569,7 +1569,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	u_int i;
>  	u64 start, len;
>  
> -	abfd = bfd_openr(dso->long_name, NULL);
> +	abfd = bfd_openr(debugfile, NULL);
>  	if (!abfd)
>  		return -1;
>  
> @@ -1586,12 +1586,6 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
>  	if (section)
>  		dso->text_offset = section->vma - section->filepos;
>  
> -	bfd_close(abfd);
> -
> -	abfd = bfd_openr(debugfile, NULL);
> -	if (!abfd)
> -		return -1;
> -

hum, should you also remove the following code?

        if (!bfd_check_format(abfd, bfd_object)) {
                pr_debug2("%s: cannot read %s bfd file.\n", __func__,
                          debugfile);
                goto out_close;
        }

        if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
                goto out_close;

it seems to be called already above

thanks,
jirka

>  	if (!bfd_check_format(abfd, bfd_object)) {
>  		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
>  			  debugfile);
> -- 
> 2.30.0
> 

