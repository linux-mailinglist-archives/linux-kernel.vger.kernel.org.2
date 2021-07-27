Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14143D73EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhG0LBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhG0LB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627383689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4/lnTJs6dz3Y9nh98raYZ6STj8vsCBM/gJq9qsQFws=;
        b=XMQwNScdkdV06ByQPIOZE/3y6aiEguXx68zWXEuCGUY2YNwhYEPHsRfvhw/h1Eh/LYW9QU
        /cjeAFJ7nf34SleJ979VxzCWhWe0KGmPraGLHBL2cdCP/XLazENVxP4B7y2kbZioxGJzCo
        ppOe4uWznznO7YoDt9wRSiIF9qyxuoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-vTTJvRCCOWmGEXm7iBnIGw-1; Tue, 27 Jul 2021 07:01:06 -0400
X-MC-Unique: vTTJvRCCOWmGEXm7iBnIGw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797031853026;
        Tue, 27 Jul 2021 11:01:04 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E86660862;
        Tue, 27 Jul 2021 11:00:54 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5B8474172EDB; Tue, 27 Jul 2021 08:00:50 -0300 (-03)
Date:   Tue, 27 Jul 2021 08:00:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210727110050.GA502360@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:48:33PM +0200, nsaenzju@redhat.com wrote:
> On Tue, 2021-07-27 at 07:38 -0300, Marcelo Tosatti wrote:
> > +Isolation mode (PR_ISOL_MODE):
> > +------------------------------
> > +
> > +- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
> > +  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.
> > +
> > +- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
> > +  and in case of interruption events, the notifications can be collected
> > +  by BPF programs.
> > +  In this mode, if system calls are performed, deferred actions initiated
> > +  by the system call will be executed before return to userspace.
> > +
> > +Other modes, which for example send signals upon interruptions events,
> > +can be implemented.
> 
> Shouldn't this be a set of flags that enable specific isolation features?
> Something the likes of 'PR_ISOL_QUIESCE_ON_EXIT'. Modes seem more restrictive
> and too much of a commitment. If we merge MODE_NORMAL as is, we won't be able
> to tweak/extend its behaviour in the future.

Hi Nicolas,

Well, its assuming PR_ISOL_MODE_NORMAL means "enable all isolation
features on return to userspace". 

Later on, if desired, can add extend interface as follows (using 
Christoph's idea to not perform automatic quiesce on return to 
userspace, but expose which parts need quiescing
so userspace can do it on its own, as an example):

#define PR_ISOL_QUIESCE_ON_EXIT (1<<0)
#define PR_ISOL_VSYSCALL_PAGE   (1<<1)
...

unsigned long bitmap = PR_ISOL_VSYSCALL_PAGE;

/* allow system calls */
prctl(PR_ISOL_SET, PR_ISOL_MODE, PR_ISOL_MODE_NORMAL, 0, 0, 0);

/* 
 * disable quiescing on exit, enable reporting through
 * vsyscall page
 */
prctl(PR_ISOL_SET, PR_ISOL_FEATURES, &bitmap, 0, 0);
/*
 * configure vsyscall page
 */
prctl(PR_ISOL_VSYSCALLS, params, ...);

So unless i am missing something, it is possible to tweak/extend the
interface. No?

