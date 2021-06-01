Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE93D396BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 04:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhFAC5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 22:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFAC5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 22:57:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C83C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:55:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c13so1169327plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3pohhDIzpTNGTaLw5FGOawbaRYby4i5Jggmf7n1XFo=;
        b=cDKZ7nrGg3SitOakQBGpVL1BFbEU6GaUR6pfRuOVyDbFDHTNgzjlEv9pGLJ6tQebx1
         TvR4V7ARWr0D2ue6Vo1GzPXNBXAzRwVuTpyqLCLDFnqx+5pRQ6h8JR1Opa7ywKjmezTt
         230z8WSKDLkL9v0juswaumkv0c+9iriSK8Mw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3pohhDIzpTNGTaLw5FGOawbaRYby4i5Jggmf7n1XFo=;
        b=Yq7qisqUMY9YBvv7shJb9E5kc0UDfSSAVn+CSDNgyONtvW1x/h55C2gyBnkdHcY6eZ
         u9YsIgm2ocPxuxW0O7gbFJNZn2IszNy9frvddiQJJ+IEo0AGvAv1p5js9RhrPl8ySweC
         Mkc86/lVa77P9UugA1/9TseWYOJc0FxD/fSqwX7eOu6LdX+9fyL4XVKZq5j6IIKrvu/n
         870mEnRlaagW2zLMR0Nier0cp6sEdEKBV3s4U1YHYT4uhw3/L8R4u9mFxkTtjk0vdUuV
         rG/PFPmrQtp+QhgFc6SVVTIGi0j7C0gQ6lSlahMhoXwjGcoEZxiFaJ67z0gMKOnMgkMi
         iv2Q==
X-Gm-Message-State: AOAM530dzRfsbbYowFN6AYoqyaz98P6wW1l6C1GOWXAuzfwxrn1dMre4
        PDEverPRszUeDu8BMYC0Cpg2oQ==
X-Google-Smtp-Source: ABdhPJyHKfUsqE0m1JFGzAh6859rIZJIGXcyAHz3mDfWY6H7A9aRMVriVM16UsBMMvAhPOcRZnl2Fw==
X-Received: by 2002:a17:90b:603:: with SMTP id gb3mr2237595pjb.118.1622516124107;
        Mon, 31 May 2021 19:55:24 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:3d42:f77e:d3ba:9a24])
        by smtp.gmail.com with ESMTPSA id y20sm11868451pfn.164.2021.05.31.19.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:55:23 -0700 (PDT)
Date:   Tue, 1 Jun 2021 11:55:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YLWhlZy8jQR3zpun@google.com>
References: <20210531162051.2325-1-john.ogness@linutronix.de>
 <20210531162051.2325-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531162051.2325-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/31 18:20), John Ogness wrote:
> +void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
> +{
> +	unsigned int cpu;
> +
> +	for (;;) {
> +		cpu = get_cpu();
> +
> +		*cpu_store = atomic_read(&printk_cpulock_owner);
> +
> +		if (*cpu_store == -1) {
> +			local_irq_save(*flags);

Is there any particular reason this does

	preempt_disable();
	cpu = smp_processor_id();
	local_irq_safe();

instead of

	local_irq_safe();
	cpu = raw_smp_processor_id();

?
