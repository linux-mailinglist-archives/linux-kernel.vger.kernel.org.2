Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69793805A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhENI5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231982AbhENI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620982559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SRl+mtOr1MBJ1v0HNyfzl2qKEhHpIhbfEOzZEj6rYg=;
        b=dfZ3DXlVTT9DauDaghK90TtXvFNUgZJcx+79/Ixa1DwaQekhbPLlRoFob9VaqhZyHOAfjD
        9+eQ0p2UQVj00EjB+Lc625GMkBd2lgibgLwg6urMfzp39aZW4b3H7wq0hLnrePumvlmkbD
        EyN0/ZhZEIeLF284qNeF9YZAE1tlVfc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-rsIgKN8WPmaO86Ou5I4EzA-1; Fri, 14 May 2021 04:55:57 -0400
X-MC-Unique: rsIgKN8WPmaO86Ou5I4EzA-1
Received: by mail-wm1-f71.google.com with SMTP id u203-20020a1cddd40000b029016dbb86d796so872680wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 01:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7SRl+mtOr1MBJ1v0HNyfzl2qKEhHpIhbfEOzZEj6rYg=;
        b=lb2Q3attpfj2ew+dJA80/CePeW+S3bgbQpYhjN82lUbp7lbp1G751h3hjD7Was9lhb
         i3mMQEr3XbUE9xSI+NjoSATDs+NkoTgvK9GhNH35paVtP/58KSXyG2tbdHPxZnr3+sUk
         mLBmODhSBEhbcvenrSiVovpnhNI/OJjAa7yAbO/ckdOLGr8LNt5RJ22LBjMSe7CO3u0z
         P30E4pJkDHARPQh7mPGOy9h9Y2VlVE//RhwevKqr6ZFN6r3N7evJPFeowunJ+270zBO5
         rHPAdrGefQ29ibwwJJySNpL8A/lFy7KGI/hfchmQwc+C6ojZkRcUhDieg0+8YD1Zr6UO
         txtg==
X-Gm-Message-State: AOAM530HHscreTL80cQysR4L3LqDVVROjNpL8lWzlV59EAfQ4aqjFils
        s8GuRlMYMP+u8OednMyTFEN1+eDQubfl6i/nDGWrdzqaBirRr/B2QzMDt9uSDN29+wBMRhbA3uw
        pKbVlPlEIRXKe3eml6iLMDuBY
X-Received: by 2002:a5d:490d:: with SMTP id x13mr7358549wrq.49.1620982556186;
        Fri, 14 May 2021 01:55:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxKBj4lQTNdPmXIPyr2HKo7tkkQszMUgyBGoGSGvvQj0Rs2TyHrXbICVB6fiCDDztyHQqsow==
X-Received: by 2002:a5d:490d:: with SMTP id x13mr7358525wrq.49.1620982555978;
        Fri, 14 May 2021 01:55:55 -0700 (PDT)
Received: from localhost.localdomain ([151.29.91.215])
        by smtp.gmail.com with ESMTPSA id o13sm4800369wmh.34.2021.05.14.01.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:55:55 -0700 (PDT)
Date:   Fri, 14 May 2021 10:55:53 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH V2 9/9] tracing: Add timerlat tracer
Message-ID: <YJ47Gc6ej9jeAsoK@localhost.localdomain>
References: <cover.1619210818.git.bristot@redhat.com>
 <1f3b97ca52e6a4eec58f18bf190218bdbfe30f20.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3b97ca52e6a4eec58f18bf190218bdbfe30f20.1619210818.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Just a couple of things I noticed while playing with this nice additon.

On 23/04/21 23:05, Daniel Bristot de Oliveira wrote:

...

> +/**
> + * tlat_var_reset - Reset the values of the given timerlat_variables
> + */
> +static inline void tlat_var_reset(void)
> +{
> +	struct timerlat_variables *tlat_var;
> +	int cpu;
>  	/*
>  	 * So far, all the values are initialized as 0, so
>  	 * zeroing the structure is perfect.
>  	 */
> -	memset(osn_var, 0, sizeof(struct osnoise_variables));
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		memset(tlat_var, 0, sizeof(struct timerlat_variables));
> +		tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);

Think these two above want to be the other way around?

> +	}
>  }

...

> +#ifdef CONFIG_TIMERLAT_TRACER
> +static void timerlat_tracer_start(struct trace_array *tr)
> +{
> +	int retval;
> +
> +	if (osnoise_busy)
> +		return;
> +
> +	retval = __osnoise_tracer_start(tr);
> +	if (retval)
> +		goto out_err;
> +
> +	osnoise_data.timerlat_tracer = 1;

It seems this needs to be set before calling __osnoise_tracer_start()?

Thanks!

Juri

