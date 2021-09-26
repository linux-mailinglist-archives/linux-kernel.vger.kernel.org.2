Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D12418B49
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 23:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhIZVnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 17:43:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53182 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhIZVm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 17:42:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632692480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McPaBmx0MlHP0vrqs5ivo0lVfd3a5w6d950MyZytiPI=;
        b=xDc+/QBGaVeUhXi+I0llsdxnSGLrKcdRYkutef68E1XjgoSibk5Hx/JYcJc/6s5vRzNDQY
        L+OQyOx50jEnT7LKQlDtn4uofYo/PgJHT+85m8uf/0VKD7qi7C3m/lcxbYzP1O6o/Hd5tn
        gYwp/Cz4zzicS6sI0a9swmM22Q5CFtLZoowl0e+C+pxg/Cy6xzsOQkSTpZSgljU9+2h5Si
        7099nccYpVojjuxUNa96+RgrA192pPHIbdlPwFyBcwOfwOZqmJ6WxgKw0NRUjJGnaoUdUe
        MoGEGZ6/A7TCX8N4XRE1IP4RBmvR9Pvu0hokPGl41R6X4+y2EVB3WaGYXuFyBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632692480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=McPaBmx0MlHP0vrqs5ivo0lVfd3a5w6d950MyZytiPI=;
        b=24HCp5V6NALHAxeQGbOYfIhtmgxwwE/FFtNkKeDWwPyDH0jb7bz7DdayfOW23bPh/opZ3D
        E29+lWlY1DhvThBw==
To:     shruthi.sanil@intel.com, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: Re: [PATCH v6 2/2] clocksource: Add Intel Keem Bay timer support
In-Reply-To: <20210906183621.21075-3-shruthi.sanil@intel.com>
References: <20210906183621.21075-1-shruthi.sanil@intel.com>
 <20210906183621.21075-3-shruthi.sanil@intel.com>
Date:   Sun, 26 Sep 2021 23:41:20 +0200
Message-ID: <87lf3jaubj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2021 at 00:06, shruthi sanil wrote:
> +
> +/* Provides a unique ID for each timer */
> +static DEFINE_IDA(keembay_timer_ida);

> +
> +	timer_id = ida_alloc(&keembay_timer_ida, GFP_KERNEL);
> +	if (timer_id < 0) {
> +		ret = timer_id;
> +		goto err_keembay_ce_to_free;
> +	}

May I ask what the purpose of the IDA, which is backed by a full blown
xarray, is here?

AFAICT all you want is a unique number for the timer name for up to 8
timers.

> +	timer_name = kasprintf(GFP_KERNEL, "keembay_timer%d", timer_id);

So what's wrong about:

static unsigned int keembay_timer_id;

	timer_name = kasprintf(GFP_KERNEL, "keembay_timer%d", keembay_timer_id++);

Hmm?

> +
> +	clockevents_config_and_register(&keembay_ce_to->clkevt,
> +					timer_of_rate(keembay_ce_to),
> +					1,
> +					U32_MAX);

Aside of that what's the point of registering more than one of those
timers as clock event? The core will only use one and the rest is just
going to use memory for no value.

Thanks,

        tglx
