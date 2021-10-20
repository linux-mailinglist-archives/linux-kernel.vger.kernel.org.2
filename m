Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEB434E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJTOk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJTOk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:40:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C107861373;
        Wed, 20 Oct 2021 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634740722;
        bh=5oWI2erh0ZAmBp0IzLZD9p3MuwG9Ia9cKsMvUhdtp1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2HTK4jvNq5ojSBNp2Cvv9Oz1uGR8sMUXicsROBsx4JwVFuVmMGD4YJsUKrQl3tDN
         JZroNVuuuCE2e5VWbDoc36FY5yinkc4ZIgu+R1WBcCerPXklMUNT8MybvImrSKeLll
         GaVkv8MmfEKod+ZoiX08ocNpHDqIUWaZaEiEiqZKGH4B8AQaJES79Dge/uBBEisbbW
         nnTmIoj38cOERMgkXhjtyFdyr92xJJprNBN3Dq4nEbLqUPrZJgE/IGnrX+OaB1XIuz
         LTfN1NYvsC3OpCoLw5Iu2zU9pr1RH5wY816s18rhhPdVU1658PydjJ0eF2z6PG0idd
         r/xA9YRmi+sUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 325D3410A1; Wed, 20 Oct 2021 11:38:39 -0300 (-03)
Date:   Wed, 20 Oct 2021 11:38:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf tools: Suppress 'rm dlfilter' build message
Message-ID: <YXAp7yR41FVrN9f7@kernel.org>
References: <20210930062849.110416-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930062849.110416-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 30, 2021 at 09:28:49AM +0300, Adrian Hunter escreveu:
> The following build message:
> 
> 	rm dlfilters/dlfilter-test-api-v0.o
> 
> is unwanted.
> 
> The object fle is being treated as an intermediate file and being
> automatically removed. Mark the object file as .SECONDARY to prevent
> removal and hence the message.

Thanks, applied. Sorry for the delay, fell thru the cracks :-\ Also I
adjusted the fle typo reported by Kajol.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Makefile.perf | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e04313c4d840..ab8cb17d9ec5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -787,6 +787,8 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
>  	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
>  	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
>  
> +.SECONDARY: $(DLFILTERS:.so=.o)
> +
>  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
>  	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
>  
> -- 
> 2.25.1

-- 

- Arnaldo
