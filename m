Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3243B455C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFYOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:16:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhFYOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:16:31 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624630449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdELpvQ+dV2ttqeDQbqazgj6DNfJ3A1ASeuZS1jGteI=;
        b=T5/qrNxe0LLm1pZu+Dn/t6MrC82mK1LY/4SbMXEd4bwZmAIqdgQfuEIHCYkR7fUQC0EtoH
        NFVot6tenTHgNRzLCXgKKnkRmRnJ0alJ7z/4UNuvh/kQpLfuntyObj/a95+KoBUt1Syf3R
        Z8xHD3MZikUoHJRHD8bnM/16rOaBvsxLowPtWgjUf8VjZ8pw2xRyYMw1hL3NeTlm5/2xJU
        AXwi1y7xLBTi36sMvvU+0eFnzDfO600ZQgKW+Y1XfCfyM68aplPS/p80rHjVXWKW3KMgNd
        Ikv85N+rQJcDstLaqY2iOOwxl2pzSFCDkxBEfFeRyCjDSHhLRQWpaeU4W2dAbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624630449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdELpvQ+dV2ttqeDQbqazgj6DNfJ3A1ASeuZS1jGteI=;
        b=UY/0hhMLajrTwabiGRDPb9NpmI2SjOg3ELhIhDIBhMym+nNcQDrgm4pQsUlmwQvBvPLhFE
        eSs3JZEP/XDwapBA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: syslog: close window between wait and read
In-Reply-To: <20210625093354.12384711@oasis.local.home>
References: <20210624111148.5190-1-john.ogness@linutronix.de> <20210624111148.5190-7-john.ogness@linutronix.de> <20210625093354.12384711@oasis.local.home>
Date:   Fri, 25 Jun 2021 16:20:09 +0206
Message-ID: <87o8but4jy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-25, Steven Rostedt <rostedt@goodmis.org> wrote:
>> +	 * @syslog_lock is held when entering the read loop to prevent
>> +	 * another reader from modifying @syslog_seq.
>
> You should add to the above comment:
>
> 	 * And the @syslog_lock is released before exiting the loop.
>
> Because it's not normal to enter a loop locked, and have it unlocked
> when exiting the loop. And I can envision in the future, someone might
> add a break (for error) while still holding the lock.

Agreed. Thanks.

John
