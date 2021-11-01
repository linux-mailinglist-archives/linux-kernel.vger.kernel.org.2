Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01E2441ED8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhKAQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhKAQ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:56:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ED9611C9;
        Mon,  1 Nov 2021 16:53:54 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mhaZE-002tcG-Mj; Mon, 01 Nov 2021 16:53:52 +0000
MIME-Version: 1.0
Date:   Mon, 01 Nov 2021 16:53:52 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc:     masahiroy@kernel.org, ripxorip@gmail.com,
        gregkh@linuxfoundation.org, matthieu.baerts@tessares.net,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tags: add a space regex to DECLARE_BITMAP
In-Reply-To: <20211101155948.GA10424@pc>
References: <20211101155948.GA10424@pc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <17bd93d6d81cf267e7d0c63b533cc23f@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zackary.liu.pro@gmail.com, masahiroy@kernel.org, ripxorip@gmail.com, gregkh@linuxfoundation.org, matthieu.baerts@tessares.net, mpe@ellerman.id.au, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-01 15:59, Zhaoyu Liu wrote:
> When "make tags", it prompts a warning:
> 
>     ctags: Warning: drivers/pci/controller/pcie-apple.c:150:
>     null expansion of name pattern "\1"
> 
> The reason is that there is an indentation beside arguments of
> DECLARE_BITMAP, but it can parsed normally by gtags. It's also
> allowed in C.
> 
> So fix this regex temporarily, and wait for better solutions
> applied to other regexs.
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>

No, please! I never reviewed this patch. I *suggested*i it [1]
as a potential avenue for improvement.

You cannot put this tag on a patch unless someone explicitly
grants it.

> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index b24bfaec6290..7e5f19391f20 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -186,7 +186,7 @@ regex_c=(
>  
> 	'/\<DEFINE_\(RT_MUTEX\|MUTEX\|SEMAPHORE\|SPINLOCK\)(\([[:alnum:]_]*\)/\2/v/'
>  	'/\<DEFINE_\(RAW_SPINLOCK\|RWLOCK\|SEQLOCK\)(\([[:alnum:]_]*\)/\2/v/'
>  	'/\<DECLARE_\(RWSEM\|COMPLETION\)(\([[:alnum:]_]\+\)/\2/v/'
> -	'/\<DECLARE_BITMAP(\([[:alnum:]_]*\)/\1/v/'
> +	'/\<DECLARE_BITMAP([[:space:]]*\([[:alnum:]_]*\)/\1/v/'
>  	'/\(^\|\s\)\(\|L\|H\)LIST_HEAD(\([[:alnum:]_]*\)/\3/v/'
>  	'/\(^\|\s\)RADIX_TREE(\([[:alnum:]_]*\)/\2/v/'
>  	'/\<DEFINE_PER_CPU([^,]*, *\([[:alnum:]_]*\)/\1/v/'

More importantly, and assuming this is the correct approach,
why should we limit this to DECLARE_BITMAP()?

Thanks,

         M.

[1] https://lore.kernel.org/r/878ry89nfp.wl-maz@kernel.org
-- 
Jazz is not dead. It just smells funny...
