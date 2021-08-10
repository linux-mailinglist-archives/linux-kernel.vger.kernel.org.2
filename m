Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87F3E5BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbhHJNeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:34:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbhHJNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:34:01 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628602417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+u829X+Wo1bOH/YRJygsG3fMs0UxVJxwO/YTG1QnW4=;
        b=vViuJ//4x4EsEoWwnRsuAytjUH2VVp2uUAXihlHR6vJnyn7DP4B70PLUAZZ8G2gsvzsBla
        bcbRjjv0CHhhdjE4V54741T7iad/P0jRPxWSTrO1kB+DPnvt0GhhI0u5aXHxMTmlMrY+3c
        kg8XWA43Ez0TFmR2809+2ej4/cih5dQ+hLBJdLS808Ul1w5EXv0SkC0NYCpj2x+rHT+fiL
        gr5uU/y9WCmK1wV+ySuu/Low44j6wS0fxaQMIIMHqeKeVFDmm9xf3TZ7n16gKEzloTXeaZ
        tvvqI6u6ZPFhjDjBOGszvJPL6HmL9/HJGErydZcTemoTc1VVIJl6u1v0W5xUbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628602417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+u829X+Wo1bOH/YRJygsG3fMs0UxVJxwO/YTG1QnW4=;
        b=u2Mz7dR7W7PMJnRpSOpi+KtbHLjTsU72FlMwosoiax+CPQisoPnKdq+ch5KIQOW+RPURY7
        W9/qkFeCWJgpN8CQ==
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] genirq/timings: Fix error return code in
 irq_timings_test_irqs()
In-Reply-To: <20210508062043.2524-1-thunder.leizhen@huawei.com>
References: <20210508062043.2524-1-thunder.leizhen@huawei.com>
Date:   Tue, 10 Aug 2021 15:33:36 +0200
Message-ID: <87a6lps9u7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08 2021 at 14:20, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.

Returning an error code is fine, but

>  
>  		__irq_timings_store(irq, irqs, ti->intervals[i]);
>  		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
> +			ret = -EFAULT;

EFAULT is really not appropriate here. EFAULT is used for mapping
faults. ENOSPC or EBADSLT perhaps?

>  			pr_err("Failed to store in the circular buffer\n");
>  			goto out;
>  		}
>  	}
>  
>  	if (irqs->count != ti->count) {
> +		ret = -EFAULT;

ERANGE?

Thanks,

        tglx
