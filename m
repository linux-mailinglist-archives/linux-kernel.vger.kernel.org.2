Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A33B407B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFYJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhFYJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:30:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B36C061574;
        Fri, 25 Jun 2021 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SjGReaSfzObkIWIE+f3KhQydIkcR4mgV8ncU1I+OXTA=; b=lzUYzwAIFt/4HG1YZ4dIeB4K6f
        bWX04mCHTlBWwpaRSo9a2Nnqh5y/qkumSHRObxoczpC1ed73q9SASR1ThuyVochZ5MsTuijoHVVvi
        LYak5+l4irUfbxbaOX1vaJkc4ds5eGOhlqWpU9E6GjKDgNYediiXfCYyt1xyJIIVJndOaBErHnIaH
        S2BdR6xNvEuf8lzapqysvw6gYRt86p9EZlNJSX2jyOZ53fIBEchfwCjFTpb584I/vqog7VwKefiET
        z95aKo/tOshe+cp0HVj5FHwSLeXcKtVgPi7+TOPi9sj1qV/EwydrZrJVdDW9AqUqSfIIGxOlwlZtk
        8Mwy7W6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwi7R-00BWrn-Cj; Fri, 25 Jun 2021 09:27:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F8BA300233;
        Fri, 25 Jun 2021 11:27:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FFA6200B392D; Fri, 25 Jun 2021 11:27:31 +0200 (CEST)
Date:   Fri, 25 Jun 2021 11:27:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 12/14] trace: Protect tr->tracing_cpumask with
 get/put_online_cpus
Message-ID: <YNWhg2lpYaqGC0RD@hirez.programming.kicks-ass.net>
References: <cover.1624372313.git.bristot@redhat.com>
 <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 04:42:30PM +0200, Daniel Bristot de Oliveira wrote:
> +	get_online_cpus();
>  	cpumask_copy(tr->tracing_cpumask, tracing_cpumask_new);
> +	put_online_cpus();

I'm aware this patch will go the way of the Dodo; but for future
reference, these should be spelled: cpus_read_{,un}lock(). The old names
are still around, but I suppose we should do a cleanup of that some day.
