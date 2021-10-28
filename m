Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9C43E69B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJ1QxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhJ1QxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:53:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tMGaK2sUVMsCiLlAMK/jc7wo8BAZ+rnikau/I3t/GU=; b=oWjZxuKcMWE5A0iD3QNPvuEsgD
        +OIg6fK+PcpGLkD1D1HAatr0NJpVptr4ka5d3JntFZFLxWbdowDpl/2ZRksu+jGEEduY0roUKbl+0
        d2M8ALN+eQhvJ0jP53aLyrBnVCcNpsZOuL7I6z56y4atofVSgJJJJ7kcLGTll4NJOoOGzfRMzRHVK
        oj7WtmUqPlC8/RglTybwqHZaqDCSvBhPFCuOx4fdCD5RzZFXyif3ndfnbM3ueF6LqS1GEhEXziINK
        5lJvfmf/poqLol+W9HFH3rTh/Ljn3rhV3vzEtCw20f4BDc0OOtkNG1K5NDBnXjHTqEy2okFxps7N2
        p42wFs4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg8c3-00CqOk-On; Thu, 28 Oct 2021 16:50:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2314030031A;
        Thu, 28 Oct 2021 18:50:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D53EF2064564E; Thu, 28 Oct 2021 18:50:46 +0200 (CEST)
Date:   Thu, 28 Oct 2021 18:50:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <YXrU5hQfEJFTP93d@hirez.programming.kicks-ass.net>
References: <20211028115005.873539-1-qais.yousef@arm.com>
 <YXrJOKb17cH6vkTc@infradead.org>
 <20211028161855.GN174703@worktop.programming.kicks-ass.net>
 <YXrOLay3BbaDObM2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrOLay3BbaDObM2@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:22:05AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 28, 2021 at 06:18:55PM +0200, Peter Zijlstra wrote:
> > > > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> > > > +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> > > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> > > 
> > > ... and while we're at it, all these exports are unused and should
> > > be deleted as well.
> > 
> > This is my concession wrt tracepoints. Actual tracepoints are ABI,
> > exports are in-kernel interfaces and are explicitly not ABI.
> > 
> > This way people can use an external module to get at the tracepoint data
> > without having in-tree tracepoints.
> 
> All of this makes no sense at all.  These are entirely dead exports.
> If you remove them nothing else changes.  Note taht the tracepoints
> do have in-kernel callers, so if people thing of them as an ABI you've
> got your ABI already with or without the exports.

These are not normal traceevents, these are tracepoints, the distinction
is that these things do not show up in tracefs and there is no userspace
visible representation of them. No userspace gives no ABI.

All they provide is the in-code hook and in-kernel registration
interface. These EXPORTS export that registration interface, such that
an out-of-tree module can make use of them.

And yes, unused exports are iffy, out-of-tree modules are iffy, but in
this case I made an exception since ABI contraints are worse. We very
clearly state there is no such thing is kabi, so breaking any user of
these exports if fair game.

Breaking users of userspace trace-events gets kernel patches reverted
(been there, done that, never want to ever be there again).

People want to trace this stuff, but I *REALLY* do not want to commit to
ABI, this is the middle-ground that sucks least :/
