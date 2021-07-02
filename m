Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DB73BA01A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhGBLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231956AbhGBLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625226785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsNCmqi47T5EmfXWh0RFFNKuI1PQ/5bxhYJlMwJqYAA=;
        b=GDervmKGo17XhzxtFw2FwaJX9nEnhCc8LjziI1VQAm97BnCrQwV2rLfBK9uyVfTALfu8h5
        l29QYAdyZ/GYz9iLkkyIoGCd5+kJGPQ+eXSBPEAxeYMKklx2PosDKwYbk94YbN4208yLVP
        iagwtlgFIxn6IzUo1HZd+F2i/5/FJqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-DDZZ-8SOP3O28sNt0R-oXw-1; Fri, 02 Jul 2021 07:53:03 -0400
X-MC-Unique: DDZZ-8SOP3O28sNt0R-oXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73099362FA;
        Fri,  2 Jul 2021 11:53:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2D735DD68;
        Fri,  2 Jul 2021 11:52:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 72E964179B8D; Fri,  2 Jul 2021 08:52:35 -0300 (-03)
Date:   Fri, 2 Jul 2021 08:52:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210702115235.GA238161@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2107020958430.201080@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Jul 02, 2021 at 10:00:11AM +0200, Christoph Lameter wrote:
> On Thu, 1 Jul 2021, Marcelo Tosatti wrote:
> 
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
> 
> Can we enter nohz_full after the app runs mlock?
> 
> > To fix this, optionally sync the vmstat counters when returning
> > from userspace, controllable by a new "vmstat_sync" isolcpus
> > flags (default off).
> >
> > See individual patches for details.
> 
> Wow... This is going into some performance sensitive VM counters here and
> adds code to their primitives.

Yes, but it should all be under static key (therefore the performance
impact, when isolcpus=vmstat_sync,CPULIST is not enabled, should be
zero) (if the patchset is correct! ...).

For the case where isolcpus=vmstat_sync is enabled, the most important
performance aspect is the latency spike which this patch is dealing
with.

> Isnt there a simpler solution that does not require this amount of
> changes?

The one other change (I can think of) which could solve this problem 
would be allowing remote access to per-CPU vmstat counters 
(requiring a local_lock to be added), which seems to be more complex
than this.

