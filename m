Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923EF42FA71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhJORpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhJORpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:45:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA9C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zf41s+OcZyvXIxcvTCF827eQekiYV5z04ykEHoP82BI=; b=TNetFcbZ+kEADAskGIsVEJ+LZl
        S3kVZBt2FvAgF+W6ZPWU0+NTNy9Q747st8iigPAa3CppLIBxxJ9+W3n5C4f9ba6EEzGmbz4vkTmOD
        c4PdT+1vXkyrY+vuHyUtVojf1PLp39KnhS/aAFV/UAsjRDqzxR3ZmuFXAVTTbMhdwm998ZP/VZHTt
        9LehBWArEiA+xE8adR82OiNlk5dO3vOtJtIVy9mFP+gaB4r79FSUxBJVsczbHKXxm5Jg0PIMM/+wq
        ezpx0RDR1DmHXqfbOKOP6dANYhz9BFz34gtoD5jsj23zBzbeAy4Qur58Q1z6hGagKYxH4tmn4Znyl
        uoEQXqIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbREA-00A2TF-8q; Fri, 15 Oct 2021 17:42:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33C329857C7; Fri, 15 Oct 2021 19:42:41 +0200 (CEST)
Date:   Fri, 15 Oct 2021 19:42:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 4/4] sched/fair: Remove sysctl_sched_migration_cost
 condition
Message-ID: <20211015174241.GJ174703@worktop.programming.kicks-ass.net>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
 <20211015124654.18093-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015124654.18093-5-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:46:54PM +0200, Vincent Guittot wrote:
> With a default value of 500us, sysctl_sched_migration_cost is
> significanlty higher than the cost of load_balance. Remove the
> condition and rely on the sd->max_newidle_lb_cost to abort
> newidle_balance.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

This is separate and not folded in for ease of bisection?
