Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6043E699
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhJ1Qv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 12:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhJ1QvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635439737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCItrNKZX+ugRebW30ECM6Yoplo+IdMbapYttnlvVF4=;
        b=csZ7/OGjtkhcnnOtNsl0IWQZweM1bo3lbU2XhpvJ6xGSljJBJYWxK2ID9vNyoO2GtckDpu
        m58VpnY830z1D+4TimBh5w8Vauiri0vMTOuRebL/cH8nC7Vzkli5PKWnTdeUlfaghMV6ls
        HZG3lWU+RUJZ6NmnudgyYxaUticWNAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-rL0sYMYgMyCDVsPagYbrsA-1; Thu, 28 Oct 2021 12:48:53 -0400
X-MC-Unique: rL0sYMYgMyCDVsPagYbrsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4832218D6A25;
        Thu, 28 Oct 2021 16:48:52 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 137DE5F4EA;
        Thu, 28 Oct 2021 16:48:50 +0000 (UTC)
Date:   Thu, 28 Oct 2021 12:48:49 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Export pelt_thermal_tp
Message-ID: <YXrUcVlKj1BSIj7k@lorien.usersys.redhat.com>
References: <20211028115005.873539-1-qais.yousef@arm.com>
 <YXrJOKb17cH6vkTc@infradead.org>
 <20211028161855.GN174703@worktop.programming.kicks-ass.net>
 <YXrOLay3BbaDObM2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXrOLay3BbaDObM2@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:22:05AM -0700 Christoph Hellwig wrote:
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
> 

Full blown trace _events_ create an ABI. These trace points are not ABI.
But by exporting them they are accesible to little helper modules which
can turn them into trace events which can then by used by trace-cmd and
ftrace etc.  That way we can have the tracepoints at the interesting spots
in the code but still have control over them with respect to changes. 

See https://github.com/auldp/tracepoints-helpers for an example. 

Cheers,
Phil

-- 

