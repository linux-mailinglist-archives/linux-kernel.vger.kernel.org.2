Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD233E859F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 23:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhHJVrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 17:47:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46170 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHJVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 17:47:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628632019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFQAuv/zjgDxJjY7yj4WJ9eE1IDO0qkHFcavLsZ9e9s=;
        b=EXMuLwK+4OznvW1qwmBSVG5DAIVouGDZM7/Xr5kagTgh8t7bsZMIZfiUGJZIYbVMTIs4O5
        yCqG72bTUaYcNU6wXLonvNW7Czdm99TLtQ2HwAKf2kpPrJAGYkPp2fjy/osKOJXL9iOaDt
        /W0FWcItdyOuTDFGEuRSOisxJ7gqT61O6I+QTTiibw2OKTjTHAPa0juBs80iDK5e5jqEfx
        l1n+JulxS4Qr5Z4JW8unOCl7ifktJxXjL5LOPm+YOjBwQw9SaBaawj596esMelAYWHY7LW
        Ap5s5zWP0EmwAAB6GtbYCXOwdle793VWInrry7zLmMasqRpuwK0BlRvic4iVcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628632019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFQAuv/zjgDxJjY7yj4WJ9eE1IDO0qkHFcavLsZ9e9s=;
        b=hPmwHXXHsN/7wSjC4Ox1I7BgYpHydVtygtgtgiCx81i8OFP0+bS9I2cRTXZsLzC3ZLBkKn
        C+jkoUaBIz8zwrDA==
To:     Joe Perches <joe@perches.com>
Cc:     Craig Gallek <kraig@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq/irqdesc: Use sysfs_emit in the <foo>_show functions
In-Reply-To: <5a7cf87075177ab374c55e15f677eac167ac767a.camel@perches.com>
References: <5a7cf87075177ab374c55e15f677eac167ac767a.camel@perches.com>
Date:   Tue, 10 Aug 2021 23:46:59 +0200
Message-ID: <87im0dotv0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe!

On Tue, Aug 10 2021 at 10:55, Joe Perches wrote:
> Convert the nominally unbounded sprintf output to use sysfs_emit and the
> scnprintf uses to sysfs_emit_at.

Please use function_name() not function_name as that makes it clear what
this is about.

> Miscellanea:

The point is?

> o sysfs_emit: Use the more common int len not ssize_t ret

You're not changing sysfs_emit(). You change the variables in the irq
functions.

> o hwirq_show: Add a minimum newline output when irq_data.domain is not set
>   and remove an unnecessary cast of an unsigned long to int ("%d" ->
>   "%lu)

That's a separate change and has nothing to do with $subject

> o name_show: Add a minimum newline output when desc->name is not set

Ditto.

> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index fadb937660202..8d47b8667c989 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -147,19 +147,20 @@ static ssize_t per_cpu_count_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr, char *buf)
>  {
>  	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> -	ssize_t ret = 0;
> -	char *p = "";
> +	int len = 0;
> +	const char *p = "";
>  	int cpu;

Please keep reverse fir tree ordering and stick the two int variables
into one line, i.e. 

  	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
	const char *p = "";
	int cpu, len = 0;

Please rework against

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip irq/core

Thanks,

        tglx
