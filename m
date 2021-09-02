Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382A63FEBF8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbhIBKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:18:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241969AbhIBKSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:18:04 -0400
Received: from zn.tnic (p200300ec2f0ed100d115725f57e7001c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d115:725f:57e7:1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A90691EC0493;
        Thu,  2 Sep 2021 12:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630577820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BPSY5xM/hvA/ZvCV4qV68+I6GXupc3hyHNe5KJkXhYk=;
        b=jPPSwb8jWeYGS7RkIlRwkdzj19NXq4ufBOzmnI4xMEpXSyPrb5FOlqfMzUovlIATbfiFjz
        j8TIKoU3PFCi3VVWdYjPshEXnPoQEITxtaP+iZRcjHB5d9ycHMXdgopiZLXHZ5n5cFA5yc
        FybTxkF4hHf6/SF9iNfEp89u2eMxmL8=
Date:   Thu, 2 Sep 2021 12:17:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiang Jiasheng <jiasheng@iscas.ac.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] bpf: Add env_type_is_resolved() in front of
 env_stack_push() in btf_resolve()
Message-ID: <YTCkwJnIqzAqaJ5R@zn.tnic>
References: <1630577097-644528-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1630577097-644528-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:04:57AM +0000, Jiang Jiasheng wrote:
> From: jiasheng <jiasheng@iscas.ac.cn>
> 
> We have found that in the complied files env_stack_push()
> appear more than 10 times, and under at least 90% circumstances
> that env_type_is_resolved() and env_stack_push() appear in pairs.
> For example, they appear together in the btf_modifier_resolve()
> of the file complie from 'kernel/bpf/btf.c'.
> But we have found that in the btf_resolve(), there is only
> env_stack_push() instead of the pair.
> Therefore, we consider that the env_type_is_resolved()
> might be forgotten.
> 
> Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
> ---
>  kernel/bpf/btf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f982a9f0..454c249 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4002,7 +4002,8 @@ static int btf_resolve(struct btf_verifier_env *env,
>  	int err = 0;
>  
>  	env->resolve_mode = RESOLVE_TBD;
> -	env_stack_push(env, t, type_id);
> +	if (env_type_is_resolved(env, type_id))
> +		env_stack_push(env, t, type_id);
>  	while (!err && (v = env_stack_peak(env))) {
>  		env->log_type_id = v->type_id;
>  		err = btf_type_ops(v->t)->resolve(env, v);
> -- 

You still didn't read what I suggested, did you?

Because there it also explains who to CC on patches. Like, for example,
for this wrong patch you've CCed the wrong people.

Oh well, until you do, I'm deleting your mail.

Good luck.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
