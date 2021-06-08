Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05E39F834
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhFHN5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhFHN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:57:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D74C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=apmLwlJ9ogAts22oUWOIOb1nko2tN7etIfj6kyALqpE=; b=d1UYeQIsGbRUhFidHlmOu6LWOZ
        5hCaR7KLOY7iu+A3MlWTGoIGvIGJL6s763Y9022zOrG/qPZ3Mim5S6niqHIsCMTjV4HdLzPwoDMnw
        zs3E/T6TGdOykVuf98MT5UTMbkaBrVlJExLy6L4rlY5DXZMnyvldPO4MjVaL5RsND2xF0bplG4Wym
        sGcng7YEGBjiB1oUkllniJPcQrjo5oWgZat7jBVUAxRy7etPVmbUIguuZp9Ui9mq2wxJRAfGNuPm2
        xzNRDroMWa/I0Xna1N5roUS5Osmmjh1rPaGxdrW79wES7LMHBDQOjfETyT+AtxzJHH6/xeDZ6CLfJ
        ss/IP45w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqcCv-004lgK-4U; Tue, 08 Jun 2021 13:56:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91CC530018A;
        Tue,  8 Jun 2021 15:55:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82F12201E7ED1; Tue,  8 Jun 2021 15:55:59 +0200 (CEST)
Date:   Tue, 8 Jun 2021 15:55:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched: Add default dynamic preempt mode Kconfig
Message-ID: <YL9271QMQfyn174k@hirez.programming.kicks-ass.net>
References: <20210608120442.93587-1-frederic@kernel.org>
 <20210608120442.93587-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608120442.93587-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:04:41PM +0200, Frederic Weisbecker wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e9a5be35cde..df47a8275c37 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6238,6 +6238,14 @@ enum {
>  
>  int preempt_dynamic_mode = preempt_dynamic_full;
>  
> +#if defined(CONFIG_PREEMPT_DYNAMIC_FULL)
> +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_full;
> +#elif defined(CONFIG_PREEMPT_DYNAMIC_VOLUNTARY)
> +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_voluntary;
> +#elif defined(CONFIG_PREEMPT_DYNAMIC_NONE)
> +static __initdata int preempt_dynamic_mode_init = preempt_dynamic_none;
> +#endif

Why does preempt_dynamic_mode_init exist? Why can't we simply set
preempt_dynamic_mode?

