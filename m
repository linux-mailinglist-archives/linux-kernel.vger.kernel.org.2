Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44233ED68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhCQJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCQJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:49:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064FFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:49:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g20so1079626wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PptS2USJ3KIo3oHfMc7dHqvKJ5VWOW9nQOYoPBKbDPE=;
        b=DEsF9R9+mpou8SynoAmqMhwlLq/d1V/aYsb8ie+0GOzKzIhBeqfXU71YeBEdheefBi
         tRYQw3+PyvXrvbAsHtWbi/TJiYwRl0qSJ8x9QFmDPIZD3uOQcKNQKUtOHf/oIhPTC/cn
         srhJrAeDxCm7tCbMZJ3Fu/G/wBO/3v3yQ42u/FjK9VYnY4jh/0w/Vd83suTM5TkqaqQN
         R10yldUual8441bUJVg3YG63Tdyw8ahmiuY3ljnlbe6B2p4JjvDw+aD3YX7HLp64zLXV
         FypUceI7d0oMv4BELzwgZ4XyXfLHB5+JXYyjI5z2EMYNXdNAcpg3B8nJg06LpkXSm2df
         zxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PptS2USJ3KIo3oHfMc7dHqvKJ5VWOW9nQOYoPBKbDPE=;
        b=LIUhN+zM1RpJqAoxQJzyIJR2PJkHP8XRWd3VmivLU4mB1LwdmzhToB54W5sSnKgkOp
         pMsYdZwJXSF4y2GBomKYm4b/e45NQcfKxfREbaD1VjbVJvSapZCm6XUbilBQzxyKx/MY
         hH+/+ofVnbbGc2x74upi3/vpTEOnv6SESSLfxS5NqZ/9FKc9fx6j9y8zl1Ip8TSL4J0F
         GqqvxDONmCDKuefM4Z6Nfuzytwwme3pqODtudfZXTvhlMWWjkdFk+zBj4Iu4qETdonIl
         0bnmZPPp1ncXoj8Or5P+hpawHiJwN3WG6F+x2H1TTmbcMyKspIwkUJ6BN6vy9sq08mhI
         pgNg==
X-Gm-Message-State: AOAM530t+rNxYb/zjA7Xi40vdqpEEJNHmaSqIqlZ+tcLlf+lXFuA4WG/
        7zEyQvqhSqp6cEnomg9DkA4=
X-Google-Smtp-Source: ABdhPJwXp3Lqsk3pHZ/ZOUbHgEphH0dySvHvavMZFnsZbuBVeIMraywztX8MJM4fdqiDm4k+Tt/ANQ==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr2867170wmg.171.1615974550852;
        Wed, 17 Mar 2021 02:49:10 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h6sm1928732wmi.6.2021.03.17.02.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:49:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 10:49:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     He Ying <heying24@huawei.com>
Cc:     peterz@infradead.org, frederic@kernel.org, paulmck@kernel.org,
        christophe.leroy@csgroup.eu, clg@kaod.org, qais.yousef@arm.com,
        johnny.chenyi@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] smp: kernel/panic.c - silence warnings
Message-ID: <20210317094908.GB1724119@gmail.com>
References: <20210316084150.75201-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316084150.75201-1-heying24@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* He Ying <heying24@huawei.com> wrote:

> We found these warnings in kernel/panic.c by using sparse tool:
> warning: symbol 'panic_smp_self_stop' was not declared.
> warning: symbol 'nmi_panic_self_stop' was not declared.
> warning: symbol 'crash_smp_send_stop' was not declared.
> 
> To avoid them, add declarations for these three functions in
> include/linux/smp.h.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
> V1->V2:
> - fix some misspellings
> 
>  include/linux/smp.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 70c6f6284dcf..27008a1c8111 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -50,6 +50,14 @@ extern unsigned int total_cpus;
>  int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
>  			     int wait);
>  
> +/*
> + * Cpus stopping functions in panic. All have default weak definitions.
> + * Architecture-dependent code may override them.
> + */
> +void panic_smp_self_stop(void);
> +void nmi_panic_self_stop(struct pt_regs *regs);
> +void crash_smp_send_stop(void);

Please follow the 'extern' convention used for prototype declarations 
in that header file.

Thanks,

	Ingo
