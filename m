Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036A643E5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJ1QVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1QVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:21:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF136C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZbvuE381tfp0nu58dWZHbUD1o553pAFWU+iK3MgRVUs=; b=Qw9Yj7O1TQDXeRvMItXxifl91j
        62G+G5pK8GlSd1ENuswZ2A7nD6Tq7CLwjc4C2m6UB83O9blXSfnXZ64bZ5S+hWltEyK+wnZXtfDU0
        ktFqZRPY3vQoh2Ua4npP+KA4OasmSiRJyL0nhXmt1i1O03nuaukNbZjIyWCE7s6BaO8Luv3BOOzWA
        EMYrz5p+y3Ghc7VMled1rsXimU4k/6ZZt2a2naKhu+wpXu1O4UXvB38fVhGi8bf+3P7NpXu+sIux1
        az/awqhg1+FbitccQG7scg8eW9AhqOrF03qL32nv3+C3k+tpLKL9ICr7sLshKY0EEbxl5D+C7871a
        AlQqB7QA==;
Received: from 188-206-68-194.mobile.kpn.net ([188.206.68.194] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg87I-00Cq47-Id; Thu, 28 Oct 2021 16:19:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D03798629C; Thu, 28 Oct 2021 18:18:55 +0200 (CEST)
Date:   Thu, 28 Oct 2021 18:18:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <20211028161855.GN174703@worktop.programming.kicks-ass.net>
References: <20211028115005.873539-1-qais.yousef@arm.com>
 <YXrJOKb17cH6vkTc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrJOKb17cH6vkTc@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:00:56AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 28, 2021 at 12:50:05PM +0100, Qais Yousef wrote:
> > We can't use this tracepoint in modules without having the symbol
> > exported first, fix that.
> 
> Which modules is using this?  In linux-next there does not seems to be
> any user outside of kernel/sched/pelt.c.
> 
> > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> 
> ... and while we're at it, all these exports are unused and should
> be deleted as well.

This is my concession wrt tracepoints. Actual tracepoints are ABI,
exports are in-kernel interfaces and are explicitly not ABI.

This way people can use an external module to get at the tracepoint data
without having in-tree tracepoints.

