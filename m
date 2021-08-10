Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED5A3E82F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhHJS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231608AbhHJS0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:26:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9367F60C3F;
        Tue, 10 Aug 2021 18:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628619953;
        bh=Z22DfkZFg/MxROBAFmJPS4lYBFpHZnPkUifYytjlHVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMWCsJdwtqLr38NT+knQ65NS42TuUZaxUiT4geMjYzbxZPudH3pV+L7ZW7lhZaHg0
         ggEi0hlKoCsUCK5LxqR6WDTzPz9zuTFU/CQmZG4brWxEHS0pf9CXwBYSJ4hxUIXZdV
         JOxSF/qGHFsYMYWDZCLAHImjaRnjn4Zm3S16p5l3SFk+38tzSerb/OPceBbRitUPW1
         niAHmhGrXyLULmELP1xuzWw6gy5+yV/4w6+ZJifGG9qs3TXDzLtS+9jJXoqC/1EiAr
         GTrfW+nEXs3N3+S9qNrNz+1ycVX/yytn7BQaiJE/bfEEoVdqL5ElJgu3ImC5dYBbz1
         fR07Q9wHATiSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACC8C403F2; Tue, 10 Aug 2021 15:25:49 -0300 (-03)
Date:   Tue, 10 Aug 2021 15:25:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] perf script: Fix unnecessary machine_resolve()
Message-ID: <YRLErQjNd77Y1jKy@kernel.org>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810114813.12951-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 10, 2021 at 02:48:09PM +0300, Adrian Hunter escreveu:
> machine_resolve() may have already been called. Test for that to avoid
> calling it again unnecessarily.

By some dlfilter function, right...

Perhaps it would be better for machine__resolve() itself to check that?

Probably we'll need a 'force' arg, or have __machine__resolve() that
does exactly what machine__resolve() does today and then tools wanting
to force it to avoid using whatever is 'cached'?

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e2e165b53499..f469354155f1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2212,7 +2212,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (filter_cpu(sample))
>  		goto out_put;
>  
> -	if (machine__resolve(machine, &al, sample) < 0) {
> +	if (!al.thread && machine__resolve(machine, &al, sample) < 0) {
>  		pr_err("problem processing %d event, skipping it.\n",
>  		       event->header.type);
>  		ret = -1;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
