Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12835C3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhDLK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhDLK1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:27:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qiadfzOkn3tanB+NQUaDa6bVg6XWuY1aPhWoDbB0gPg=; b=oqGZJAZ1AgQYSJdsycsM/lLHMU
        2nTPWbyTv2fTd+14+RQ3SUjZ37CTasoqIDU1wUc1QG+3lDpVUO10PEavZkFPuKMHS8tEJwqjyTjGB
        +ocWWwqORAFi+qeLW+cT/n9H2Sl+B/PtlXUL6rjuvJ0tBfLWsxxKE9EKCELsrvrn52PkVGR2y9SGG
        8W3QTXpO09++pUngGxzj5RK1HTjBqdU2/TQXACGcpdXceMusKzzeWiKmYt6Q/1CE4z+lNgroFIsCm
        lyf4RZwlZKdau5C1zbVX2W3cFjgzGjlbELhdCXgC2CbQ+9fZJbLP6spGaU0KeycI/RtP+GEuH7PhL
        N5aeu0bA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtlu-004BjW-QB; Mon, 12 Apr 2021 10:26:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73753300033;
        Mon, 12 Apr 2021 12:26:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F8D620224205; Mon, 12 Apr 2021 12:26:22 +0200 (CEST)
Date:   Mon, 12 Apr 2021 12:26:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 9/9] sched,fair: Alternative sched_slice()
Message-ID: <YHQgTtaXnMjzBUXB@hirez.programming.kicks-ass.net>
References: <20210412101421.609526370@infradead.org>
 <20210412102001.611897312@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412102001.611897312@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:14:30PM +0200, Peter Zijlstra wrote:
> @@ -697,6 +703,10 @@ static u64 sched_slice(struct cfs_rq *cf
>  		}
>  		slice = __calc_delta(slice, se->load.weight, load);
>  	}
> +
> +	if (sched_feat(BASE_SLICE))
> +		slice = min(slice, (u64)sysctl_sched_min_granularity);

*Groan*... clearly that should be max().


