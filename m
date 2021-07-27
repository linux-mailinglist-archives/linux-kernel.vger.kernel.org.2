Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9C3D759A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhG0NIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232123AbhG0NIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627391323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2oQ5Q8rJseViqRDSIPWll9c/hpUVWxSXj+4+osHv2nY=;
        b=FDJuG0A8jC3GN2LdqE7DNsP3tX7mDM30PqqTI4uJAAzRKgB4ZPp7SBYDRNL0DtzYB2q/Kb
        bV7vlq1quSrxGLTwnd8bCaEINsuTGRLySK8c6CeRHk9+rAn3dlWOly9d7QrLA79MIvwMAX
        T3ouWfnfjxhH/GsFNny03mrA2wluEqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-SyR271NxN3mzUnsXJC5PNQ-1; Tue, 27 Jul 2021 09:08:40 -0400
X-MC-Unique: SyR271NxN3mzUnsXJC5PNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F36F100E420;
        Tue, 27 Jul 2021 13:08:38 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D6671B46C;
        Tue, 27 Jul 2021 13:08:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 905F34172EDB; Tue, 27 Jul 2021 10:08:27 -0300 (-03)
Date:   Tue, 27 Jul 2021 10:08:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210727130827.GB508962@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130641.GA508962@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210727130641.GA508962@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:06:41AM -0300, Marcelo Tosatti wrote:
> On Tue, Jul 27, 2021 at 02:38:15PM +0200, nsaenzju@redhat.com wrote:
> > Hi Marcelo,
> > 
> > On Tue, 2021-07-27 at 08:00 -0300, Marcelo Tosatti wrote:
> > > On Tue, Jul 27, 2021 at 12:48:33PM +0200, nsaenzju@redhat.com wrote:
> > > > On Tue, 2021-07-27 at 07:38 -0300, Marcelo Tosatti wrote:
> > > > > +Isolation mode (PR_ISOL_MODE):
> > > > > +------------------------------
> > > > > +
> > > > > +- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
> > > > > +  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.
> > > > > +
> > > > > +- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
> > > > > +  and in case of interruption events, the notifications can be collected
> > > > > +  by BPF programs.
> > > > > +  In this mode, if system calls are performed, deferred actions initiated
> > > > > +  by the system call will be executed before return to userspace.
> > > > > +
> > > > > +Other modes, which for example send signals upon interruptions events,
> > > > > +can be implemented.
> > > >
> > > > Shouldn't this be a set of flags that enable specific isolation features?
> > > > Something the likes of 'PR_ISOL_QUIESCE_ON_EXIT'. Modes seem more restrictive
> > > > and too much of a commitment. If we merge MODE_NORMAL as is, we won't be able
> > > > to tweak/extend its behaviour in the future.
> > >
> > > Hi Nicolas,
> > >
> > > Well, its assuming PR_ISOL_MODE_NORMAL means "enable all isolation
> > > features on return to userspace".
> > >
> > > Later on, if desired, can add extend interface as follows (using
> > > Christoph's idea to not perform automatic quiesce on return to
> > > userspace, but expose which parts need quiescing
> > > so userspace can do it on its own, as an example):
> > >
> > > #define PR_ISOL_QUIESCE_ON_EXIT (1<<0)
> > > #define PR_ISOL_VSYSCALL_PAGE   (1<<1)
> > > ...
> > >
> > > unsigned long bitmap = PR_ISOL_VSYSCALL_PAGE;
> > >
> > > /* allow system calls */
> > > prctl(PR_ISOL_SET, PR_ISOL_MODE, PR_ISOL_MODE_NORMAL, 0, 0, 0);
> > >
> > > /*
> > >  * disable quiescing on exit, enable reporting through
> > >  * vsyscall page
> > >  */
> > > prctl(PR_ISOL_SET, PR_ISOL_FEATURES, &bitmap, 0, 0);
> > > /*
> > >  * configure vsyscall page
> > >  */
> > > prctl(PR_ISOL_VSYSCALLS, params, ...);
> > >
> > > So unless i am missing something, it is possible to tweak/extend the
> > > interface. No?
> > 
> > OK, sorry if I'm being thick, but what is the benefit of having a distincnt
> > PR_ISOL_MODE instead expressing everything as PR_ISOL_FEATURES.
> > 
> >   PR_ISOL_MODE_NONE == Empty PR_ISOL_FEATURES bitmap
> > 
> >   PR_ISOL_MODE_NORMAL == Bitmap of commonly used PR_ISOL_FEATURES
> >   			      (we could introduce a define)
> > 
> >   PR_ISOL_MODE_NORMAL+PR_ISOL_VSYSCALLS == Custom bitmap
> > 
> > Other than that, my rationale is that if you extend PR_ISOL_MODE_NORMAL's
> > behaviour as new features are merged, wouldn't you be potentially breaking
> > userspace (i.e. older applications might not like the new default)?
> > 
> > --
> > Nicolás Sáenz
> 
> The main reason is that PR_ISOL_MODE would allow for distinct
> modes to be implemented (matching each use case). For example:
> 
> https://lwn.net/Articles/816298/
> 
> "When a task has finished its initialization, it can activate isolation
> by using the PR_TASK_ISOLATION operation provided by the prctl()
> system call. This operation may fail for either permanent or temporary
> reasons. An example of a permanent error is when the task is set up
> on a CPU without isolation; in this case, entering isolation mode
> is not possible. Temporary errors are indicated by the EAGAIN error
> code; examples include a time when the delayed workqueues could not be
> stopped. In such cases, the task may retry the operation if it wants to
> enter isolation, as it may succeed the next time.
> 
> In the prctl() call, the developer may also configure the signal to be
> sent to the task when it loses isolation. The additional macro to use is
> PR_TASK_ISOLATION_SET_SIG(), passing it the signal to send. The command
> then becomes similar to the one in the example code:"

But have no strong preference: fine with PR_ISOL_FEATURES as you
describe above, and if that is the consensus, can resubmit.

