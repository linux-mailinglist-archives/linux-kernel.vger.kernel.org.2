Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C312136129F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhDOS77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:59:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbhDOS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:59:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618513171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaHUz5YBQVzDxhSpe5SmDHYNElZ36bK0TsH43+mt8mU=;
        b=zwC5Ees+QHBfRjYdjSfSvARafBw8Tsi1jFUrfWiFZnrglYh4yQjnroonqGQJfzBC5VWcRl
        KX2CO08ZYG+yy8JAYFxJhCXEks//D12+DsmIhFEgdmD2+kEToArI97Hwf8YgS4FmHxDZM6
        +MO3X/RmAXik7QJFxABkIVVWoPA7gwLtKHm9GrUa6FfkGfQfSmJhophPOYnAkB0GswUf4O
        kC3JYjpYNqYzz5Wwv3Hwaqit38c9c7OQJi2BnghJs7qr7bSzcx5WTqpIclDmIY+al7rfB4
        b7HGwsq3YI38PG9a1Q7FTpdlt8jzxgbG+IiKgYt+ajCZmeLHPoeXBxNGgIbVhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618513171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IaHUz5YBQVzDxhSpe5SmDHYNElZ36bK0TsH43+mt8mU=;
        b=tWhztTI3Bzle1KeVkJzNfau5hg81/tWORamF2/V7gEsETleybI34u40FtPWOAv5T9TJj1M
        hH3Tc2WeXCAVYkBg==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v3] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210415153935.GA69750@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet> <87lf9q4lue.ffs@nanos.tec.linutronix.de> <20210413170431.GA16190@fuller.cnet> <20210415153935.GA69750@fuller.cnet>
Date:   Thu, 15 Apr 2021 20:59:30 +0200
Message-ID: <87im4nv0fh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15 2021 at 12:39, Marcelo Tosatti wrote:
> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
> +{
> +	unsigned int active = 0;
> +
> +	if (cpu_base->softirq_activated)
> +		return true;
> +
> +	active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
> +	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);

It's not entirely clear to me what that 'active' variable business above
is doing and why it's needed at all. But I might be missing something.

> +	return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;
> +}
