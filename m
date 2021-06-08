Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C863B39F70D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhFHMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232786AbhFHMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:47:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9626860FF0;
        Tue,  8 Jun 2021 12:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623156316;
        bh=lpXjs35ijhxfI9tobNyQoPR7rS+pnNx3itV//vsGf7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSowGWz0ETjd4pY9hwO/ojzV/pgpzoEjqktf6M/A9SBpXgu5/qQ5FbA+fUdSpGgaf
         reVgKwMPj1o60b9lO/ZPJJispGtjDWAFZvd6RDCDpykpAT2o2ZleCS7skouavJWdSe
         T6DnWkNBQmdJUvPZhYWNSNh07E/KNi+o+iRki5DfxMliTBe1EwHZ+fdBI9TTasTjYS
         0x0awVTsAVuj6Jw9ric0VxQ035DxbM7wnwV7IrpGqCNuaqZqkiAMZtmBLIsGap40JY
         n+rCWIEVfwTDcD2rF2vUGrw2raGE3e965Xl0i/4i6aBIzQ8UB+CR3LHIFat0Wl2pY0
         XjxzUw8AtDWLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D648540B1A; Tue,  8 Jun 2021 09:45:13 -0300 (-03)
Date:   Tue, 8 Jun 2021 09:45:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf tools: Use list_move instead of
 list_del/list_add
Message-ID: <YL9mWZfQoc8AP49D@kernel.org>
References: <1623113566-49455-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623113566-49455-1-git-send-email-zou_wei@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 08, 2021 at 08:52:46AM +0800, Zou Wei escreveu:
> Using list_move() instead of list_del() + list_add().

Thanks, applied.

- Arnaldo

 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  tools/perf/util/srccode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
> index c29edaa..476e998 100644
> --- a/tools/perf/util/srccode.c
> +++ b/tools/perf/util/srccode.c
> @@ -97,8 +97,7 @@ static struct srcfile *find_srcfile(char *fn)
>  	hlist_for_each_entry (h, &srcfile_htab[hval], hash_nd) {
>  		if (!strcmp(fn, h->fn)) {
>  			/* Move to front */
> -			list_del(&h->nd);
> -			list_add(&h->nd, &srcfile_list);
> +			list_move(&h->nd, &srcfile_list);
>  			return h;
>  		}
>  	}
> -- 
> 2.6.2
> 

-- 

- Arnaldo
