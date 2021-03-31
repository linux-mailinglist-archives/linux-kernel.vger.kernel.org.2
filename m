Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ECA3479C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhCXNk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234574AbhCXNk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D063619C2;
        Wed, 24 Mar 2021 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616593229;
        bh=beOunuxfDJzqWksRB4IRD2kltbiBvBBdZAhj2ozRTg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYA2DJcJW/Qq61vt9pQx42/1HT7q00cp1DfKPWAY1KrlVqtRp45QpBKzPxnL0r0AK
         YF6nnOkB77gKGOmuXTvHHnorvEIe53H8hwTBYlBkvlxYx3P2PPKbA1CrKH2Mix3YcJ
         k2j2vQaLPdRDT+k0FycFEluV8Jg5mTssTUldD+WDcJ+uIhsLsZ3e/sb6Guz985PG3W
         1ggZ0S0AuMZyaeqo02Frn1EO5yrm8vJ20ncmkx9hhWw+qaJFfYUyd1WIEBZImXJJx6
         CBl1ExiZWxxxpONsIat7D1fKoYBg2QOQIsdCV7cV7K4rHdo/odv/6oSz+FCEQxl5PB
         BEYYpUzhHuDYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0DE3040647; Wed, 24 Mar 2021 10:40:27 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:40:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Mailing list and Web-page for
 PERFORMANCE EVENTS SUBSYSTEM
Message-ID: <YFtBSpwP/WSesl/w@kernel.org>
References: <1615780592-21838-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615780592-21838-1-git-send-email-yangtiezhu@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 15, 2021 at 11:56:32AM +0800, Tiezhu Yang escreveu:
> Add entry "L: linux-perf-users@vger.kernel.org" to archive the
> related mail on https://lore.kernel.org/linux-perf-users/, add
> entry "W: https://perf.wiki.kernel.org/" so that newbies could
> get some useful materials.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121..e1626db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14021,8 +14021,10 @@ R:	Mark Rutland <mark.rutland@arm.com>
>  R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  R:	Jiri Olsa <jolsa@redhat.com>
>  R:	Namhyung Kim <namhyung@kernel.org>
> +L:	linux-perf-users@vger.kernel.org
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
> +W:	https://perf.wiki.kernel.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>  F:	arch/*/events/*
>  F:	arch/*/events/*/*
> -- 
> 2.1.0
> 

-- 

- Arnaldo
