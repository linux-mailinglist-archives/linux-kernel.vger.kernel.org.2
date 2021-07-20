Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D03CFBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbhGTNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbhGTNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:34:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA90C061766;
        Tue, 20 Jul 2021 07:05:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626789801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrKdGdGFL96rboK3hrrPx5wz3OkwGSBKWtPkHZE4HLA=;
        b=xQWVov9//EW4b+Deckp1IMnWxF0LJZ9uWUgp4XXj98GeIrtsAUZdf3FOeTRTHfLBJNDTcP
        hYygdumASLwQ02gB1OFREPD0VcY7Jrem79ZfQBb1beEc+1PygvOHXukvrHKeDlP6egxaWG
        3aim8h0X4EryYQh0YaZ5h1ftJoIzB37/Z5nquxx9U48MBqxcWpqupfjCmUI84E4u+PqldF
        wZCEFrQvex3X2KZguVHgDYS197dv0k0toEcEn1NdhSvkh4IH2FamK9NcaMMQPkfmPyOfta
        gwN1eFV01DLd+9FFdzONRjD5iRnndAbZcSBLfmFwXsVElRSwscK7H53VmrbmfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626789801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrKdGdGFL96rboK3hrrPx5wz3OkwGSBKWtPkHZE4HLA=;
        b=vMTAREEl3Y4gIFPSJejBGgPJaYQnA1BgN/eGvrbXPA/S16dz33QJz11k6bPjNJz0jnIko8
        yhLJuqWlfGcPg3Cw==
To:     Joe Perches <joe@perches.com>, chao.qin@intel.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org
Cc:     mgross@linux.intel.com, paul.mei@intel.com, lili.li@intel.com
Subject: Re: [PREEMPT_RT][PATCH] printk: Enhance the condition check of msleep in pr_flush()
In-Reply-To: <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
References: <20210719022649.3444072-1-chao.qin@intel.com> <ea6c6a2b5482d62038d7d0a1d46b87665051222f.camel@perches.com>
Date:   Tue, 20 Jul 2021 16:09:21 +0206
Message-ID: <87o8axm6ae.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-20, Joe Perches <joe@perches.com> wrote:
> Logic continuations are typically at the end of the previous line.
> And there are few too many parentheses for my taste.
>
> Maybe exceed 80 columns in a single line
>
> 	may_sleep = preemptible() && !in_softirq() && system_state >= SYSTEM_RUNNING;
>
> or align the continuation
>
> 	may_sleep = (preemptible() && !in_softirq() &&
> 		     system_state >= SYSTEM_RUNNING);
>
> or use individual lines
>
> 	may_sleep = (preemptible() &&
> 		     !in_softirq() &&
> 		     system_state >= SYSTEM_RUNNING);

The kernel now has a 100-column policy, but I decided to go with this
third variant for easy reading.

Chao Qin, your patch will be part of the next PREEMPT_RT release. Thank
you.

John Ogness
