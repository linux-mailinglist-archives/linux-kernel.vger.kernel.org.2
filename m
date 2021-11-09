Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201344AB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbhKIKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbhKIKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:24:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971EC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4zYG/ehiRohGrEztDG71eIEx4dsggU7oOpBe2is+6CY=; b=PZzpbbflnVta3J/VDGfZFz3qVE
        5kEPm/rKE/RvCLUlBK6Q1t4+SricZMbfgbcWPuF7fM5EY+bF0wIUeHYoq5tYwefGG/G7/JEajN7Kf
        BXAscFFFBaSitmgAoruwvLp+oBOuJV+qRT4TKNQDrWjorHaCOarNHjAydLyJMATQsqy5aD8nH2g3c
        tJfH5X7i34D95nmxEcLpZFGBDeNGNs0j4MJN/qAXo5DOgJKyu+9sk5pVeqnU86HQSPQ+px1wENJnv
        RNBol2lt53E4selzbKsXJ49YgjVucsOetDu94sda5cBqwIjKNq648HTXsMYHAmVmCQbWwg64vm1es
        r01L/FPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkOFP-00F2gB-Ar; Tue, 09 Nov 2021 10:20:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 877B13000A3;
        Tue,  9 Nov 2021 11:20:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EF2B205B8B63; Tue,  9 Nov 2021 11:20:57 +0100 (CET)
Date:   Tue, 9 Nov 2021 11:20:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: forced idle accounting
Message-ID: <YYpLiWCDBIOj4nvz@hirez.programming.kicks-ass.net>
References: <20211018203428.2025792-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018203428.2025792-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> @@ -280,6 +288,8 @@ static void __sched_core_flip(bool enabled)
>  		for_each_cpu(t, smt_mask)
>  			cpu_rq(t)->core_enabled = enabled;
>  
> +		cpu_rq(cpu)->core->core_forceidle_start = 0;
> +
>  		sched_core_unlock(cpu, &flags);
>  
>  		cpumask_andnot(&sched_core_mask, &sched_core_mask, smt_mask);

Not specific to this patch, but perhaps we should do better here and
explicitly initialize more state...
