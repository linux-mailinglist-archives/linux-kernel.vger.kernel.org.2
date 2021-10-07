Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E20425385
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbhJGM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhJGM6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:58:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C458C061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2gI7q5/NIhb/glXH3O3Crq4bZm/0b4Cyew47K+4HGs=; b=RyiNaVJETD+rRsxfT5begYrjSD
        /gjFqOCHepSY+F5xnOqZl5/KIBgLcOazz8PE7EpUfA+DOFAdgZufKUiyde7wfdkH9cBDQJu40Ldjj
        1rDfM2wlsnESA8/PCvS7xHWuyj0qvBx8rui6MQVZrmwmmo9ewT8bp4nHqhXBnaoMK7n8ALzlZsSFY
        82fc3lZ084uULAmX4KoEhYQSywAxRh1KsZSfd4Q9WixRxc+oSs/dfybJNTLhwQRQH9to3TP/n1dWh
        L68TgBVJa6tHiqW8EZHSCJ0Xnu5MdiE1tDfMt2BB2wAo9R7HYS/Ci4VRbFmLm7o3MJBe2Yy3VwynT
        hy0AW16Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYSuX-001qzE-G4; Thu, 07 Oct 2021 12:54:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75880300079;
        Thu,  7 Oct 2021 14:54:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19607214490DF; Thu,  7 Oct 2021 14:54:07 +0200 (CEST)
Date:   Thu, 7 Oct 2021 14:54:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, valentin.schneider@arm.com,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched.h: extend task comm from 16 to 24 for
 CONFIG_BASE_FULL
Message-ID: <YV7t748s8vJQS9Bi@hirez.programming.kicks-ass.net>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
 <20211007120752.5195-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007120752.5195-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:07:51PM +0000, Yafang Shao wrote:
> Besides the in-tree kthreads listed above, the out-of-tree kthreads may
> also be truncated:
> 
>     rtase_work_queu
>     nvidia-modeset/
>     UVM global queu
>     UVM deferred re
>     ...
> 

Fundamentally we don't give a crap about out of tree stuff. And their
behaviour or not should be of absolutely no concern what so ever for any
patch ever.
