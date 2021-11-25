Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69345DA70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbhKYMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354829AbhKYMvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:51:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63B37610FE;
        Thu, 25 Nov 2021 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637844439;
        bh=e4zpZXAd23UxW/JZf9MLxAZgNbdzMowK4BwGvtzc4Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYtfQyyVHFMsXZqzfFGHRwZaJPpEy5yAblGV6oOYrCB/0g5CoF7nNaifzFvvem48J
         U6e0y8LjTglXLusmIywshsAloXxScJnsmpGz8XVpD4ieVgRPExZv+hjCJI7X9yf14B
         RXRcAk5FgXnbOXW6ynYaZd7cVKwLWCrVsbtYxqqjphp5K96ICArfff57ZMNAWq+EJ9
         kmTkNTAFBsVwv3pCIShADm5TX9YFFl8DdqGOwVbgy+fBzGBLQg0VjUTucuV2g4rgH5
         FZMQK0U+gJa0kU1BdcgrR7pIiBsjIAlXn1yYX73dcl8cfz/VnXgNDfT6XYXW1o+qEX
         dO8dzX8HSCerg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9AE940002; Thu, 25 Nov 2021 09:47:16 -0300 (-03)
Date:   Thu, 25 Nov 2021 09:47:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Fix itrace output_data_offset
Message-ID: <YZ+F1Ioh+7lAzhz6@kernel.org>
References: <20211125071457.2066863-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125071457.2066863-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 25, 2021 at 09:14:57AM +0200, Adrian Hunter escreveu:
> The space allowed for new attributes can be too small if existing header
> information is large. That can happen, for example, if there are very
> many CPUs, due to having an event ID per CPU per event being stored in the
> header information.
> 
> Fix by adding the existing header.data_offset. Also increase the extra
> space allowed to 8KiB and align to a 4KiB boundary for neatness.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index bc5259db5fd9..b9d6306cc14e 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -820,7 +820,7 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.ordered_events = true;
>  		inject->tool.ordering_requires_timestamps = true;
>  		/* Allow space in the header for new attributes */
> -		output_data_offset = 4096;
> +		output_data_offset = roundup(8192 + session->header.data_offset, 4096);
>  		if (inject->strip)
>  			strip_init(inject);
>  	}
> -- 
> 2.25.1

-- 

- Arnaldo
