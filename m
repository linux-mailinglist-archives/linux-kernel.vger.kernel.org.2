Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB583BA2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhGBPii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhGBPih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625240165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk2jPQ5Vw/u391NMhsgP61SlSEPHkRKjWcDHCQkZ4og=;
        b=VJGc4CRCfSkFgaYYBN2HWGeOiuzdmfva4dBWWVZaAXPaSn10/TjAxaByJ7lw5RAPxZlkzp
        4b0DipJgdWvkfhcdiWnhk2fAD0kaxN1Vw5qzu8D6U27b1z7Uqwr6sB3iFVfRfPkrvU0CGX
        lh1fIHMKx7CYnIDX1qEQ6Si8POswjNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-55U4bpt8P6WKtm_H237p1A-1; Fri, 02 Jul 2021 11:36:03 -0400
X-MC-Unique: 55U4bpt8P6WKtm_H237p1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CFB984E260;
        Fri,  2 Jul 2021 15:36:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A15B6931E;
        Fri,  2 Jul 2021 15:36:01 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A734E4179DC0; Fri,  2 Jul 2021 12:28:16 -0300 (-03)
Date:   Fri, 2 Jul 2021 12:28:16 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210702152816.GA4122@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702123032.GA72061@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frederic,

On Fri, Jul 02, 2021 at 02:30:32PM +0200, Frederic Weisbecker wrote:
> On Thu, Jul 01, 2021 at 06:03:36PM -0300, Marcelo Tosatti wrote:
> > The logic to disable vmstat worker thread, when entering
> > nohz full, does not cover all scenarios. For example, it is possible
> > for the following to happen:
> > 
> > 1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
> > 2) app runs mlock, which increases counters for mlock'ed pages.
> > 3) start -RT loop
> > 
> > Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
> > the mlock, vmstat shepherd can restart vmstat worker thread on
> > the CPU in question.
> >  
> > To fix this, optionally sync the vmstat counters when returning
> > from userspace, controllable by a new "vmstat_sync" isolcpus
> > flags (default off).
> 
> Wasn't the plan for such finegrained isolation features to do it at
> the per task level using prctl()?

Yes, but its orthogonal: when we integrate the finegrained isolation
interface, will be able to use this code (to sync vmstat counters
on return to userspace) only when userspace informs that it has entered
isolated mode, so you don't incur the performance penalty of frequent
vmstat counter writes when not using isolated apps.

This is what the full task isolation task patchset mode is doing
as well (CC'ing Alex BTW).

This will require modifying applications (and the new kernel with the
exposed interface).

But there is demand for fixing this now, for currently existing
binary only applications.

