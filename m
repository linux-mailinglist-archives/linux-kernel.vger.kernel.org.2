Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F337C44B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhELPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhELPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:14:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E94C06134E
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1vEISHpwvt+RQ4tzOvKZm1VTcmBGnAD2VyAzWmlNtus=; b=gRar0GHPw+BAvZ8FiQbnBhdnb3
        zJNazN5KemzosFIQPDkHXKSZ1DPCA2oyQugwOgp6It1gFLjFhvHoWYYTHNL45YSn4LiU2nPsn0CiM
        o+WIZSyHgyaQrXZTCoWQqgKVk6SJpyzTRWZZCsmdmrVpIkqCT+CGtY1QZ2bW5QqkVvrk/O6sTzMX9
        aC2F4tiL7xvGG7avnaTxkO/x6lQP2fteKtEeFKNf9mGXAfab6uXvgLBYtCyQR5BA1Cw94dOi+CUy/
        YQomz2ncvQkggtDxfPLRF6REpngGwlmIEyaoywrrmd6Yqp9nzxmRXletIZ6CW0XrVXYUKltgV1Uuc
        eWzoshfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgqKj-008ORk-IQ; Wed, 12 May 2021 15:00:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84B343001E1;
        Wed, 12 May 2021 16:59:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 758E328B39B02; Wed, 12 May 2021 16:59:32 +0200 (CEST)
Date:   Wed, 12 May 2021 16:59:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 2/8] hrtimer: Force clock_was_set() handling for the
 HIGHRES=n, NOHZ=y case
Message-ID: <YJvtVD/SotLoZU/U@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de>
 <20210427083724.180273544@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427083724.180273544@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:25:39AM +0200, Thomas Gleixner wrote:
>  void clock_was_set(void)
>  {
> +	if (!hrtimer_hres_active() && !tick_nohz_active)
> +		goto out_timerfd;
> +
>  	/* Retrigger the CPU local events everywhere */
>  	on_each_cpu(retrigger_next_event, NULL, 1);
> +
> +out_timerfd:
>  	timerfd_clock_was_set();
>  }

Isn't that simpler when written like:

	if (hrtimer_hres_active() || tick_nohz_active())
		on_each_cpu(retrigger_next_event, NULL, 1);

	timerfd_clock_was_set();

?
