Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F61379825
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEJUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEJUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:12:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B568BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:11:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s8so17898349wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SFFScdXUnXeNxX6UTE2vTs1Rks2gDQO6jMYbHASQ1Ik=;
        b=rhYLI4KFFwD2Ogb3MlXxVEx6ufbOI9xx+fuK7wo4XETmb3/L41/RKvw/wlTw0U7YID
         ovwqMOaUSbp1dfm4CXUHzhNZI0eBkZMmc12xuE3XXRLKon6pZzO16mgr+x3Ib5WYVZaw
         dVUBlRRlmBKhR0GSYIiaSBliYBo8d5wmkxQPksQ/xP6wqYtfhr/lyxVdBBPMjElygcYh
         7fNcW68rwIfiXu1gBYasMT8WTxYUqQy4YwTwLWkNK6ZHKtQ7qyFRGLufBtIT/n3rKO2c
         dkBRmXjGL5oluiDlKBp8ADwpQe2KDu3N2sbDeBoeB96S9e2aaWEF2bTzDfOS7eOzEYW0
         WR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SFFScdXUnXeNxX6UTE2vTs1Rks2gDQO6jMYbHASQ1Ik=;
        b=UXBSOeUorkhgoDI9GOjdmWgROC4XcOzvKMICarijFXHmEzW19AQ2DuuLyFLW9FV8RE
         TzNoHGsCzUdfG4JFTF6NynKqjraT2j51bQwUokJffuBB24S9mqBbu9aIPXeWGxLhCNPD
         kxGp+oTm1+fbhqf9UjotEsisF7g7PjHBJ1XTpR06iDU5Zc0gXTvBC6lwi0FRKN2KUIZO
         Zq1Y7pvdTVOCALRVxCRihyrfk0tFfA1+X7W/GQQRio4IPJM3wevTjd+lBfnXJw9LxRb2
         T1JfP/8MP/XDMayAyR1qO0pe3EczJ/Q3VWMlUaw1WhBg3lvwfokw9UnHv0jDMAstsBIR
         a81Q==
X-Gm-Message-State: AOAM532Nv4A8BQdVivYYW20BB0U9ATZ95RONS9Kz9i55dT5EzcOxqsq5
        3CnBP6J+AMqNNaC7X+o/mKs=
X-Google-Smtp-Source: ABdhPJzM4FnCqxeT+cWMGzc6fz3O3o+SlhSFA5eyj6XaMDtyML6p2megkHiiuS4dumIfKdPVWrg4Ig==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr34181628wrw.361.1620677509457;
        Mon, 10 May 2021 13:11:49 -0700 (PDT)
Received: from [10.0.0.2] ([37.170.167.43])
        by smtp.gmail.com with ESMTPSA id t7sm23943858wrw.60.2021.05.10.13.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 13:11:48 -0700 (PDT)
Subject: Re: [PATCH] sh: remove unused variable
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <20210414170517.1205430-1-eric.dumazet@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c4ec09f0-8742-06ba-a213-063c40d2f98a@gmail.com>
Date:   Mon, 10 May 2021 22:11:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210414170517.1205430-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/21 7:05 PM, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> Removes this annoying warning:
> 
> arch/sh/kernel/traps.c: In function ‘nmi_trap_handler’:
> arch/sh/kernel/traps.c:183:15: warning: unused variable ‘cpu’ [-Wunused-variable]
>   183 |  unsigned int cpu = smp_processor_id();
> 
> Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> ---
>  arch/sh/kernel/traps.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
> index f5beecdac69382f2d719fa33d50b9d58e22f6ff8..e76b221570999776e3bc9276d6b2fd60b9132e94 100644
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
> @@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
>  
>  BUILD_TRAP_HANDLER(nmi)
>  {
> -	unsigned int cpu = smp_processor_id();
>  	TRAP_HANDLER_DECL;
>  
>  	arch_ftrace_nmi_enter();
> 

Is there anything wrong with this patch ?

Thanks !
