Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC8134CEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhC2LWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhC2LVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:21:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD49C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rtyz5hktwyQm5GdRX1cmqiUToMOy31fqUOx4emPDbTA=; b=HU7UJYrf+JnrazLZO+MCNanPjC
        BupyrV9OwMSCYJ2NiqPIzZdp3cQFYOmIccn+aa2A0ur3NIXXFIg1vBWZX8GSo+Jp/yLFQnCCU2df4
        hV6v/qZ+YxZli8EsFvXy4sOJFWqFGzDkjQ6s1WhHkCDXD90AiE/JwJPSR7EOlhm4S2CeIdwkULQCK
        YmHfHreQULkrbp5w8FHXauehgehRmV2AQVPRjRNG9pDZ2trA816rPBzVcslqVrfVLHGfEGFcPXS2z
        QSMkqSEBiWXEEYoZBD+jx+NAtQlv8BCFv9vjbVOr4PhyWvT+N03BD88X1Ijkw29qiVClgD7S0HShp
        rNdGMJsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQpvK-001Seu-PA; Mon, 29 Mar 2021 11:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2235304B90;
        Mon, 29 Mar 2021 13:19:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DE19207539C2; Mon, 29 Mar 2021 13:19:07 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:19:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/debug: Don't disable IRQ when acquiring
 sched_debug_lock
Message-ID: <YGG3q1LxtaF1/wc1@hirez.programming.kicks-ass.net>
References: <20210327232529.2349-1-longman@redhat.com>
 <20210329102345.6awrhtlrueqwhrpi@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329102345.6awrhtlrueqwhrpi@maple.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:23:45AM +0100, Daniel Thompson wrote:
> On Sat, Mar 27, 2021 at 07:25:28PM -0400, Waiman Long wrote:
> > The sched_debug_lock was used only in print_cpu().  The
> > print_cpu() function has two callers - sched_debug_show() and
> > sysrq_sched_debug_show(). Both of them are invoked by user action
> > (sched_debug file and sysrq-t). As print_cpu() won't be called from
> > interrupt context at all, there is no point in disabling IRQ when
> > acquiring sched_debug_lock.
> 
> This looks like it introduces a deadlock risk if sysrq-t triggers from an
> interrupt context. Has the behaviour of sysrq changed recently or will
> tools like MAGIC_SYSRQ_SERIAL still trigger from interrupt context?

Yeah, sysrq-t is very often interrupt context. The patch is clearly
bogus.
