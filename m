Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6243E602
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhJ1QYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhJ1QYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7A9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8OIg0NSW0Sgb49bZ3aqFYzjaigYZAy698PanjorKZw4=; b=px2camd/geKtOVcvnFOy4WaRwj
        6T4dS1bLToxgXERXK16gnmOK26hKZFlJAAOU9YUBAdXU5m3FQYdqfs9VM19Xm0nQUXlNILWXzLHQt
        X3+oSbYbBiFHLl4U79o0hkeGxaOWBhbnZ9dUC4nA1X7OfahxdxHLOFEF30lHt1SfbVcmRzpLtogoJ
        q7ZcjInVGXFmw0Xdt95b62+pIBbM3xkKPCGRQFRaxD/V6IJDbG0s5WGYVe0n0ppm395MsEAZRqZoq
        Lk5uyWWvrA7tXdscFJakx8G+lOD+13wYfz9ygzxLjWnLRw+q9Ld0bXhHzpzHHwJAt/CxnXBtetbxD
        Ks9aDK2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg8AH-008ZJo-ME; Thu, 28 Oct 2021 16:22:05 +0000
Date:   Thu, 28 Oct 2021 09:22:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <YXrOLay3BbaDObM2@infradead.org>
References: <20211028115005.873539-1-qais.yousef@arm.com>
 <YXrJOKb17cH6vkTc@infradead.org>
 <20211028161855.GN174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028161855.GN174703@worktop.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 06:18:55PM +0200, Peter Zijlstra wrote:
> > > @@ -36,6 +36,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_rt_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_dl_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_irq_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_se_tp);
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(pelt_thermal_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_cpu_capacity_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> > >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> > 
> > ... and while we're at it, all these exports are unused and should
> > be deleted as well.
> 
> This is my concession wrt tracepoints. Actual tracepoints are ABI,
> exports are in-kernel interfaces and are explicitly not ABI.
> 
> This way people can use an external module to get at the tracepoint data
> without having in-tree tracepoints.

All of this makes no sense at all.  These are entirely dead exports.
If you remove them nothing else changes.  Note taht the tracepoints
do have in-kernel callers, so if people thing of them as an ABI you've
got your ABI already with or without the exports.
