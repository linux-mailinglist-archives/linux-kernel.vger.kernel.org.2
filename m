Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D18E3B408F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhFYJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFYJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:33:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9504C061574;
        Fri, 25 Jun 2021 02:31:38 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:31:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624613496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2flqiuymxWiwpIOqOg21ZgP2AxJsVestVkKEHZV6LM=;
        b=IEenbfBOlJBeg2zMZTGiIVb3g6jSnomHNzNdLkPsc/wxRaZtEKsjiQPZYNfimDvFtvQwWN
        IBOwHk72w4AM7lVPtOoQnU7lv1oo/WCMd3RgTnLt6hwluENB8ssjuM+hJDx9sD4xKRNx1A
        Q3wo8/hp3d/IN6TfYLWa0NjyWK5kLaNP7wII8ShNnEmTGB5ZtBLmK3MIvXvay3dHyCv/+g
        egHkWZxeS+lOCASDspxUkm7QRS8tssoIAirvL5pEI74ZSuDIr9OVBUTDm+4llcmtsaAzvN
        5mQ35Ou07pZDXIROBeRXJvTG6nkdUCGoXhvjCzTv2q4qUGL7QXtCp7x3lbLMTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624613496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l2flqiuymxWiwpIOqOg21ZgP2AxJsVestVkKEHZV6LM=;
        b=+mqaq4E6nR1JpXsEopVy0pCTYM16/w98V2Wta0DkFEeKa6X3NkOeGeibH59fX1CYQn9fjr
        BsuDdyofxPvlBBBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Phil Auld <pauld@redhat.com>, Kate Carcia <kcarcia@redhat.com>,
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
Message-ID: <20210625093134.gfveikkmboywhihn@linutronix.de>
References: <cover.1624372313.git.bristot@redhat.com>
 <38d2ef13b33c42fcf424a6213a27c8b5246548e0.1624372313.git.bristot@redhat.com>
 <YNWhg2lpYaqGC0RD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNWhg2lpYaqGC0RD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-25 11:27:31 [+0200], Peter Zijlstra wrote:
> I'm aware this patch will go the way of the Dodo; but for future
> reference, these should be spelled: cpus_read_{,un}lock(). The old names
> are still around, but I suppose we should do a cleanup of that some day.

I had a queue locally which I need to split further but did not get
around to post it.

Sebastian
