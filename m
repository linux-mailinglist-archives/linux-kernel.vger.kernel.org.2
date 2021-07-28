Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0363D8EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhG1NVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235324AbhG1NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627478507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Qll4aU4ay39Nu3DuLdbZ97Ai6peAuRkVSv78NV49Zk=;
        b=Mvr6UlW3I8iLSf0rSwcVsDK5lGxv/JiA5tzB6fJf05vANl/F8r8m28EbaTlKVDVfZCU8R4
        02xioAEhWjEE4xzv3BtieXRyvGPIi1NmjJO+121/DacXUSdn9qsAWGwiiKDeSe3xBkVbf9
        qg1phVIUWI/fTa02mH6Ee0fKvW1I7b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-b6nadfueOLuM-hC-zJRplw-1; Wed, 28 Jul 2021 09:21:46 -0400
X-MC-Unique: b6nadfueOLuM-hC-zJRplw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373D5801AE3;
        Wed, 28 Jul 2021 13:21:45 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E2221007606;
        Wed, 28 Jul 2021 13:21:37 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BCE7B416F5D2; Wed, 28 Jul 2021 10:16:10 -0300 (-03)
Date:   Wed, 28 Jul 2021 10:16:10 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     nsaenzju@redhat.com
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210728131610.GA11900@fuller.cnet>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
 <20210727234539.GH283787@lothringen>
 <20210728093707.GA3242@fuller.cnet>
 <e0135b88dad323d0abd1ce05081e0b554421af7c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0135b88dad323d0abd1ce05081e0b554421af7c.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:55:33PM +0200, nsaenzju@redhat.com wrote:
> Hi Marcelo,
> 
> On Wed, 2021-07-28 at 06:37 -0300, Marcelo Tosatti wrote:
> > On Wed, Jul 28, 2021 at 01:45:39AM +0200, Frederic Weisbecker wrote:
> > > On Tue, Jul 27, 2021 at 11:52:09AM -0300, Marcelo Tosatti wrote:
> > > > The meaning of isolated is specified as follows:
> > > > 
> > > > Isolation features
> > > > ==================
> > > > 
> > > > - prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
> > > > features as a return value.
> > > > 
> > > > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > > > the bitmask.
> > > > 
> > > > - prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
> > > > enabled features.
> > > 
> > > So what are the ISOL_FEATURES here? A mode that we enter such as flush
> > > vmstat _everytime_ we resume to userpace after (and including) this prctl() ?
> > 
> > ISOL_FEATURES is just the "command" type (which you can get and set).
> > 
> > The bitmask would include ISOL_F_QUIESCE_ON_URET, so:
> > 
> > - bitmask = ISOL_F_QUIESCE_ON_URET;
> > - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> > the bitmask.
> > 
> > - quiesce_bitmap = prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0)
> >   (1)
> > 
> >   (returns the supported actions to be quiesced).
> > 
> > - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) _sets_
> > the actions to be quiesced (2)
> > 
> > If an application does not modify "quiesce_bitmask" between 
> > points (1) and (2) above, it will enable quiescing of all
> > "features" the kernel supports.
> 
> I think this pattern of enabling all by default might be prone to subtly
> breaking things.

The reasoning behind this pattern is that many latency sensitive applications
(as far as i am aware) prefer "as few interruptions as possible, no
interruptions is preferred".

In that case, the pattern makes sense.

> For example, let's say we introduce ISOL_F_QUIESCE_DEFER_TLB_FLUSH, this will
> defer relatively short IPIs on isolated CPUs in exchange for a longer flush
> whenever we enter the kernel (syscall, IRQs, NMI, etc...). 

Why the flush has to be longer when you enter the kernel?

ISOL_F_QUIESCE_DEFER_TLB_FLUSH might collapse multiple IPIs 
into a single IPI, so the behaviour might be beneficial 
for "standard" types of application as well.

> A latency sensitive
> application might be OK with the former but not with the latter.

Two alternatives:

1) The pattern above, where particular subsystems that might interrupt 
the kernel are enabled automatically if the kernel supports it.

Pros: 
Applications which implement this only need to be changed once,
and can benefit from new kernel features.

Applications can disable particular features if they turn
out to be problematic.

Cons: 
New features might break applications.

2) Force applications to enable each new feature individually.

Pros: Won't cause regressions, kernel behaviour is explicitly 
controlled by userspace.

Cons: Apps won't benefit from new features automatically.

---

It seems to me 1) is preferred. Can also add a sysfs control to
have a "default_isolation_feature" flag, which can be changed
by a sysadmin in case a new feature is undesired.

Thoughts?

