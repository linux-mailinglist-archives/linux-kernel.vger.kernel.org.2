Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7DD34E5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhC3KnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbhC3Kmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:42:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D58C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:42:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so24098084ejs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CHOiIXpPV6fa4wnHyusSFDloFtgUeMxUQF14u4i1Dzw=;
        b=pH46HLCCdsgEccgbXRAmc9cvmIyQXePCtyHIH5iYsYXdlyRJR+QTWlFaZ5YQHn+MWw
         eWCvW24LlciNxhIt11XUyy/VlvSjZmZ0vg/Mcf+r1VLWKA6IPrAyx74nEJvuILWbzFKg
         UFq7MjbOWaU4W5brnXOV+bKubtp7j9ZF4nIaP76Z7lR3E2RRzbcFaSlpNq8A3VkBFNAZ
         ZW7U6wN6ELvq4Mz7G3VDioAR1KjuSYo711eyjfaasLQrcRBpqNyz5kN2TuR3oLzN4Mlr
         7eUoGwjzN+4IFoz/i4N/eCZzexQ1suGDY584KJIvLLXxb8IhjOHQlUniPV8Q/kCXdEMb
         qHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CHOiIXpPV6fa4wnHyusSFDloFtgUeMxUQF14u4i1Dzw=;
        b=AqbZOrn3CkTyw2gKo3nTmcublSapjg5k/SXWs0PRIjDFAmIGmlbfk4thuebVvlrHqV
         vcKp4fKlbVn5LXKzgm0+9f1wlvveGV6aQTwfiEJoWQOVtb4obqagfCeIHnFfPm35wlb0
         L0CwbNM7YV1pkx/v3cUz7M+N+DGsAQvDHOIhySPFR8jCcVXv15Nd2dLmYhQvNnGREz2R
         1L8gWlV7zIUuWpGyYOPOo9uIcL5bnqrlmAPMapq/B+2gIe9Fa9DTO/n3umeDsyuNQmz2
         /gw+fQSu15H2SWvuCozEUbX5DKxZwQxXy+Oo63ERrWxtj+adBI5LrQDNJT7pKfz7CjFg
         P54w==
X-Gm-Message-State: AOAM531Q5+4RUWBwJI0Z1uHwRdOOrfwh1nZGlps3hvFG8Wa1SzdvAhRS
        qDAVNroCDmIG1treBc2IUS/Uqg==
X-Google-Smtp-Source: ABdhPJwRZY8Srszi3zd6ovvIaGyeDnwHnLhz9+x57nx66AF6coUK3Z/BLM+myI8ctcnpsyst3TM5+w==
X-Received: by 2002:a17:906:5646:: with SMTP id v6mr33702607ejr.126.1617100957861;
        Tue, 30 Mar 2021 03:42:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s18sm11057844edc.21.2021.03.30.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 03:42:37 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:42:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
Message-ID: <20210330104235.afoljxizvfcijxqx@maple.lan>
References: <20210329193235.30364-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329193235.30364-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:32:35PM -0400, Waiman Long wrote:
> The handling of sysrq keys should normally be done in an user context
> except when MAGIC_SYSRQ_SERIAL is set and the magic sequence is typed
> in a serial console.

This seems to be a poor summary of the typical calling context for
handle_sysrq() except in the trivial case of using
/proc/sysrq-trigger.

For example on my system then the backtrace when I do sysrq-h on a USB
keyboard shows us running from a softirq handler and with interrupts
locked. Note also that the interrupt lock is present even on systems that
handle keyboard input from a kthread due to the interrupt lock in
report_input_key().


> Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is taken
> with interrupt disabled for the whole duration of the calls to print_*_stats()
> and print_rq() which could last for the quite some time if the information dump
> happens on the serial console.
> 
> If the system has many cpus and the sched_debug_lock is somehow busy
> (e.g. parallel sysrq-t), the system may hit a hard lockup panic, like

<snip>

> The purpose of sched_debug_lock is to serialize the use of the global
> cgroup_path[] buffer in print_cpu(). The rests of the printk() calls
> don't need serialization from sched_debug_lock.
> 
> Calling printk() with interrupt disabled can still be
> problematic. Allocating a stack buffer of PATH_MAX bytes is not
> feasible. So a compromised solution is used where a small stack buffer
> is allocated for pathname. If the actual pathname is short enough, it
> is copied to the stack buffer with sched_debug_lock release afterward
> before printk().  Otherwise, the global group_path[] buffer will be
> used with sched_debug_lock held until after printk().

Does this actually fix the problem in any circumstance except when the
sysrq is triggered using /proc/sysrq-trigger?


Daniel.
> 
