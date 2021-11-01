Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704D9441B10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhKAMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:22:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhKAMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:22:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C9B49212C4;
        Mon,  1 Nov 2021 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635769173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Xgmz/OgO6c8ics6SJcbT/afylp9rcFKTn3l3I0PGVY=;
        b=0NsO6w52UeWVjC/JsGUUtsTS3I3D5YjQIPVXtKBo8WyGYsyUJsL7EWj09S9/PGRJeoFUrs
        rMp97SLVkRvK87s4k3lfBHQ4BTugO4NK28akNtBM7yTaV8WUo/kuJdTYSY0/P83zWsACq5
        rccrw0HtOJyt1FvEuSroBWf2+PTWvrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635769173;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Xgmz/OgO6c8ics6SJcbT/afylp9rcFKTn3l3I0PGVY=;
        b=ddjYDT6jMq0N9LnGw2tMy9RGZFYuKGv4M0UvlMPu+RRAx+Q/8jd6iuufyhWz1gjMagee4C
        rWRdkBAsN5FrDKCw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id BBDAFA3B81;
        Mon,  1 Nov 2021 12:19:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F36D1E0922; Mon,  1 Nov 2021 13:19:30 +0100 (CET)
Date:   Mon, 1 Nov 2021 13:19:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     cgel.zte@gmail.com
Cc:     jack@suse.cz, zhang.mingyu@zte.com.cn, krisman@collabora.com,
        amir73il@gmail.com, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] signal: remove duplicate include in signal.c
Message-ID: <20211101121930.GE21679@quack2.suse.cz>
References: <20211101074338.35680-1-zhang.mingyu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101074338.35680-1-zhang.mingyu@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-11-21 07:43:38, cgel.zte@gmail.com wrote:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> 'asm/fpu/xstate.h' included in 'arch/x86/kernel/signal.c'
> is duplicated.It is also included on the 45 line.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>

I guess you've sent this cleanup to a wrong set of people... You need to
send it to x86 maintainters. Thanks.

									Honza

> ---
>  arch/x86/kernel/signal.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ec71e06ae364..fad9c4adcda6 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -42,7 +42,6 @@
>  #include <linux/compat.h>
>  #include <asm/proto.h>
>  #include <asm/ia32_unistd.h>
> -#include <asm/fpu/xstate.h>
>  #endif /* CONFIG_X86_64 */
>  
>  #include <asm/syscall.h>
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
