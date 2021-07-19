Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042A53CED25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhGSRqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380520AbhGSR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626718202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WvxmU6C3e5BEm26OJjFVoh44JOCamNiazeqRDjQ7ySA=;
        b=fqRdWs/J58eYrnW4lLYS3udjO0J7C1/mIRIVhhBgTma6qYAV91q5nbzfF/cmZ0/sZB7PSh
        htSLvLqZysj4ZnJUEXf0/IHocNj7sQ4eCu1YZkmU0M9+7/YVxN5PU4HFU0aU/EsGMNQPL2
        cMyBpQdw4e0HuQv1zNDjWR0Gnn5MZso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-x1HkTEs-One2jo_3Q7kvsA-1; Mon, 19 Jul 2021 14:10:01 -0400
X-MC-Unique: x1HkTEs-One2jo_3Q7kvsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E779A192D785;
        Mon, 19 Jul 2021 18:09:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E78B5D6A1;
        Mon, 19 Jul 2021 18:09:54 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 503A54172EDE; Mon, 19 Jul 2021 12:41:28 -0300 (-03)
Date:   Mon, 19 Jul 2021 12:41:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
Message-ID: <20210719154128.GB27911@fuller.cnet>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <20210714163157.GA140679@fuller.cnet>
 <20210719132649.GB116346@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719132649.GB116346@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 03:26:49PM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 14, 2021 at 01:31:57PM -0300, Marcelo Tosatti wrote:
> > On Wed, Jul 14, 2021 at 03:54:20PM +0200, Frederic Weisbecker wrote:
> > > Add a new cpuset.isolation_mask file in order to be able to modify the
> > > housekeeping cpumask for each individual isolation feature on runtime.
> > > In the future this will include nohz_full, unbound timers,
> > > unbound workqueues, unbound kthreads, managed irqs, etc...
> > > 
> > > Start with supporting domain exclusion and CPUs passed through
> > > "isolcpus=".
> > 
> > It is possible to just add return -ENOTSUPPORTED for the features 
> > whose support is not present?
> 
> Maybe, although that looks like a specialized error for corner cases.

Well, are you going to implement runtime enablement for all features,
including nohz_full, in the first patch set?

From my POV returning -ENOTSUPPORTED would allow for a gradual 
implementation of the features.

> > > CHECKME: Should we have individual cpuset.isolation.$feature files for
> > >          each isolation feature instead of a single mask file?
> > 
> > Yes, guess that is useful, for example due to the -ENOTSUPPORTED
> > comment above.
> > 
> > 
> > Guarantees on updates
> > =====================
> > 
> > Perhaps start with a document with:
> > 
> > On return to the write to the cpumask file, what are the guarantees?
> > 
> > For example, for kthread it is that any kernel threads from that point
> > on should start with the new mask. Therefore userspace should 
> > respect the order:
> > 
> > 1) Change kthread mask.
> > 2) Move threads.
> > 
> 
> Yep.
> 
> > Updates to interface
> > ====================
> > 
> > Also, thinking about updates to the interface (which today are one
> > cpumask per isolation feature) might be useful. What can happen:
> > 
> > 1) New isolation feature is added, feature name added to the interface.
> > 
> > Userspace must support new filename. If not there, then thats an 
> > old kernel without support for it.
> > 
> > 2) If an isolation feature is removed, a file will be gone. What should
> > be the behaviour there? Remove the file? (userspace should probably 
> > ignore the failure in that case?) (then features names should not be
> > reused, as that can confuse #1 above).
> 
> Heh, yeah that's complicated. I guess we should use one flag per file as that
> fits well within the current cpuset design. But we must carefully choose the new
> files to make sure they have the least chances to be useless in the long term.
> 
> > Or maybe have a versioned scheme?
> 
> I suspect we should avoid that at all costs :-)
> 
> Thanks!

Makes sense.

