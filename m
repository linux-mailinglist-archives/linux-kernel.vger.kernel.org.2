Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8306433220A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCIJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCIJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:33:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 01:33:00 -0800 (PST)
Date:   Tue, 9 Mar 2021 10:32:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615282379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6XMOV7uNuFgq99E4slk5TQL665i5i0mrtm22KJeNIk=;
        b=GqTz/CT7MREhCgUdFTGzYJDmkQVOgstxoW2u8XdVauOsAEc94Onzw930Pxt/1rZdWUSpdr
        /e1/eiyGv1Z3Er1ggmDKERg3n0STkb7uiuVgpAf+VRTsAQmNzphTs4DR8QLl+fmfD4vBKh
        M1dLNY/OpPfLaQtnC64LLCswP+5+MGFsDHDv4i72/OQ1ZOsniCBDvlN5QgNKGsjDcVHmXE
        rUl6sW5lNJV/rao999LviNqJZnndZymxEKV/HlIMozLhoI6L19C5RdOGESKbo/u2SCiD++
        8QiBc5iUGg5SBj+pEL7gdZvMUgwF+iEavlhX/GreQKcP/oNfswW2YN/kLx9jrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615282379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6XMOV7uNuFgq99E4slk5TQL665i5i0mrtm22KJeNIk=;
        b=vZlY9i2zKHqbaDmHJMfZyDhW4tLQBbiPnU/2Q0ZKmE2tDQt9u1wAm/5WiM2663iy+j2lbG
        Vu6IqrsolkU89DBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kernel: profile: fix error return code of
 create_proc_profile()
Message-ID: <20210309093257.gxfrevqcia4cmcx5@linutronix.de>
References: <20210309090215.25669-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309090215.25669-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-09 01:02:15 [-0800], Jia-Ju Bai wrote:
> When proc_create() returns NULL to entry, no error return code of
> create_proc_profile() is assigned.
> To fix this bug, err is assigned with -ENOMEM in this case.

I preserved what was in commit
    c270a817196a9 ("profile: Fix CPU hotplug callback registration")

which was already in commit
    c33fff0afbef4 ("kernel: use non-racy method for proc entries creation")

and goes back to its original introduction in history tree's commit
    423284ee6eb52 ("[PATCH] consolidate prof_cpu_mask")

which is ignoring a failure here.
If we decide otherwise and not ignore the error then it would be good to
use an earlier commit so the change also makes into v4.4+ stable.

> Fixes: e722d8daafb9 ("profile: Convert to hotplug state machine")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  kernel/profile.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/profile.c b/kernel/profile.c
> index 6f69a4195d56..65bf03bb8a5e 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -549,8 +549,10 @@ int __ref create_proc_profile(void)
>  #endif
>  	entry = proc_create("profile", S_IWUSR | S_IRUGO,
>  			    NULL, &profile_proc_ops);
> -	if (!entry)
> +	if (!entry) {
> +		err = -ENOMEM;
>  		goto err_state_onl;
> +	}
>  	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
>  
>  	return err;

Sebastian
