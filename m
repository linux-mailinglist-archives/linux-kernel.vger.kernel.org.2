Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6587B3C67F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhGMBSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231425AbhGMBSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626138944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GD2bHnyacZBo2p/m7OGUFQhkS0A2VfEb94hGDBoMSPw=;
        b=QR7MHwhpfE6YzyyYpHXthc2NcekJ53kzRCR+dnv+IfI3f/PXpBNzM3fn3Hpq9vU9uf/OPy
        BAD/U8+zHJvQSYSjzgXa6pJTkJiApP8XG/mZVUHw3M+NVu4S51u8lE+Va3MMcDFpq+2ZLi
        PtU80SJTRNArW+e5HmO9/a0bfTmpAn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275--EaH6dp2OxOQp-XygpAanw-1; Mon, 12 Jul 2021 21:15:43 -0400
X-MC-Unique: -EaH6dp2OxOQp-XygpAanw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F8938015C6;
        Tue, 13 Jul 2021 01:15:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A268A5D9CA;
        Tue, 13 Jul 2021 01:15:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BFECD4179BA1; Mon, 12 Jul 2021 07:30:23 -0300 (-03)
Date:   Mon, 12 Jul 2021 07:30:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>
Subject: Re: [patch 3/5] mm: vmstat: optionally flush per-CPU vmstat counters
 on return to userspace
Message-ID: <20210712103023.GA20945@fuller.cnet>
References: <20210709173726.457181806@fuller.cnet>
 <20210709174428.241607867@fuller.cnet>
 <alpine.DEB.2.22.394.2107121056560.409981@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2107121056560.409981@gentwo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 11:05:58AM +0200, Christoph Lameter wrote:
> On Fri, 9 Jul 2021, Marcelo Tosatti wrote:
> 
> > +
> > +	if (!static_branch_unlikely(&vmstat_sync_enabled))
> > +		return;
> > +
> > +	cpu = smp_processor_id();
> > +
> > +	if (housekeeping_cpu(cpu, HK_FLAG_QUIESCE_URET))
> > +		return;
> > +
> > +	per_cpu(vmstat_dirty, smp_processor_id()) = true;
> > +}
> 
> And you are going to insert this into all the performance critical VM
> statistics handling. Inline?

Yes, this is what the patch below is supposed to do (maybe it missed
some statistics?).

The alternative would be some equivalent of need_update on return to
userspace (for all system call returns) (when the HK_FLAG_QUIESCE_URET 
flag is enabled).

> And why do you need to do such things as to determine the processor? At
> mininum do this using this cpu operations like the vmstat functions
> currently do.

OK, will do that and resend.

> And, lucky us, now we also have
> more issues why we should disable preemption etc etc while handling vm
> counters.

