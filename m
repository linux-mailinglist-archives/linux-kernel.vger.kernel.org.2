Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DC332C01A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386474AbhCCSPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhCCPyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:54:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 982FB64ED0;
        Wed,  3 Mar 2021 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614786787;
        bh=sp5F53XXR6ZjDDTE2TQYtz2sTveQ5+B4XtUn3Cal450=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPZYA75HfvpyZLt2ZST63edNe7dF4Q72/8ZnQ3KyK3lSACAGORXJoXSO0pqQMnzgm
         obHzy+m9zpRCIFev9kNst3M5tAWW7VGTyKsrULjlnH0lPj93WtUAQDUilmTjo32VRA
         j6VDNT1J2h5Px5lwXhdILJ5pNTRUn0uM0F3miNRv/5Du7UiwoJexbUM8zcnthrBAXv
         kq8BZ1tpR68oe/IQIRga7igLBOxkWegeL9nhP4SuQab+yMt9mmR7eZBPZhpS1ZDd55
         vWLqpcS50EKzNtNGFjcWtXoYZX8CvcLBLNh69f8KGYSmv/AmJCpoQFLbFvdKGawZ57
         4Q9+85Ptkpq4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8361140CD9; Wed,  3 Mar 2021 12:53:05 -0300 (-03)
Date:   Wed, 3 Mar 2021 12:53:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf metric: remove unneeded semicolon
Message-ID: <YD+w4TFsQDFRM0oK@kernel.org>
References: <1614233220-67326-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614233220-67326-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 25, 2021 at 02:07:00PM +0800, Jiapeng Chong escreveu:
> Fix the following coccicheck warnings:
> 
> ./tools/perf/tests/parse-metric.c:101:2-3: Unneeded semicolon.

Thanks, applied.

- Arnaldo

 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/perf/tests/parse-metric.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 6dc1db1..55bf52e 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -98,7 +98,7 @@ static u64 find_value(const char *name, struct value *values)
>  		if (!strcmp(name, v->event))
>  			return v->val;
>  		v++;
> -	};
> +	}
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
