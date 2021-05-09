Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F553776A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 14:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhEIMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 08:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhEIMwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 08:52:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 840B4613F0;
        Sun,  9 May 2021 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620564659;
        bh=FlVhNCuDmzhxgvRi82dbTNTpXbsHzdOIEKfDi+sKIzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSGDtYhgpgodzEVygkuPAzLTI2S8NpktZTw5vk1O9kwbOif3QX2uc/9n6PfMbeONF
         XOHLeH+rKizKvUNSI9SgisX070eFhhc78bYFJLYpM7TPijFLc+BxkzvrgcKrfkO7vy
         kbpdzsBBnBD126sbQjV9sqcyOYfPTaMjMcddZ5ad5WO2Oqa4uHI+UrGALcG1+rBhJ6
         K7pS/FVI7HJR3DQaumPkUO7zgm6Ziy8u9u8GlC0/uVzx2B8XA+hwiff16MDBaXTBH9
         4S5jiKqgCj6DcV700IktlpcaBWsPnougD4shkNVmGgrBxDmQ5YS0dV3s/NjAxRh53Y
         pdzlT3oNJPLGg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CF574034C; Sun,  9 May 2021 09:50:57 -0300 (-03)
Date:   Sun, 9 May 2021 09:50:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf: Fix a build error on arm64 with clang
Message-ID: <YJfase9GYiy8d3ah@kernel.org>
References: <162037766527.94840.4323848545957010011.stgit@devnote2>
 <162037767540.94840.15758657049033010518.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162037767540.94840.15758657049033010518.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 07, 2021 at 05:54:35PM +0900, Masami Hiramatsu escreveu:
> Since Clang's -Wmissing-field-initializers warns if a data
> structure is initialized with a signle NULL as below,
> 
>  ----
>  tools/perf $ make CC=clang LLVM=1
>  ...
>  arch/arm64/util/kvm-stat.c:74:9: error: missing field 'ops' initializer [-Werror,-Wmissing-field-initializers]
>          { NULL },
>                 ^
>  1 error generated.
>  ----

Thanks, applied.

- Arnaldo

 
> add another field initializer expressly as same as other
> arch's kvm-stat.c code.
> 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/arch/arm64/util/kvm-stat.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> index 2303256b7d05..73d18e0ed6f6 100644
> --- a/tools/perf/arch/arm64/util/kvm-stat.c
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -71,7 +71,7 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
>  		.name	= "vmexit",
>  		.ops	= &exit_events,
>  	},
> -	{ NULL },
> +	{ NULL, NULL },
>  };
>  
>  const char * const kvm_skip_events[] = {
> 

-- 

- Arnaldo
