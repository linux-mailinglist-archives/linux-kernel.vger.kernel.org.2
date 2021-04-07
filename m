Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61860356CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhDGMyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352499AbhDGMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F4A61107;
        Wed,  7 Apr 2021 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617800046;
        bh=XM61FeD0aliamjW2WL6RaV2Km9YeojbSgpzjZjtJz1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5VFD7LrrbEbhh099m6R0nDs7aAucuACzt0GtsG0hYucIF7sVUnnQI89ilgQBgsY4
         If9lXzjKX6vzCNp8mLIahbiO4Q72h6XAd+Cb91a4cTVRE7MrNCq9I5a1ByDES/+hQw
         YRtSsIAKnIGnX1NKQu/zPnSG7EbH7VtEVH+YtQuYIAWYny0N4r3zltw0zdFZJ70rGf
         WYYYRkQcVBOiG3Ck8Yv/JrBu+GAsOC1T9Irfn37FSxJtUXy47dyUq7OKdeUbCwlvSi
         MEtjWf0I8d4Du3pCARhQQMEUCUz8mBZOuuw/7ZS2qbuxNMYRffxciG3jC+sI0+Ad7J
         xxRwp/dI2MlhA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A02D740647; Wed,  7 Apr 2021 09:54:03 -0300 (-03)
Date:   Wed, 7 Apr 2021 09:54:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     johnny.chenyi@huawei.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com, heying24@huawei.com
Subject: Re: [PATCH-next] perf daemon: Remove duplicate header file
Message-ID: <YG2ra7lyhvvCJ6pp@kernel.org>
References: <20210407094902.2020105-1-johnny.chenyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407094902.2020105-1-johnny.chenyi@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 07, 2021 at 05:49:02PM +0800, johnny.chenyi@huawei.com escreveu:
> From: Chen Yi <johnny.chenyi@huawei.com>
> 
> Delete one of the header files <linux/string.h> that are included twice.

Thanks, but I got a patch merged for this already.

- Arnaldo
 
> Signed-off-by: Chen Yi <johnny.chenyi@huawei.com>
> ---
>  tools/perf/builtin-daemon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 7c4a9d424a64..be1a13d06b9c 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -6,7 +6,6 @@
>  #include <linux/zalloc.h>
>  #include <linux/string.h>
>  #include <linux/limits.h>
> -#include <linux/string.h>
>  #include <string.h>
>  #include <sys/file.h>
>  #include <signal.h>
> -- 
> 2.31.0
> 

-- 

- Arnaldo
