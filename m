Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498D43BD84D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhGFOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231569AbhGFOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YoXkhBMvrhpzdBeMeudXyap/G4h+/3QJ3JCELWVi84c=;
        b=jCciEw9aui9fs/pPNe71D+diMP9vsL3wbH2s4jMqd+Y841KtcBN7nxJuU9NFsBsb2Lz/Su
        kwwzKpe9SW3a0V5nP98C4tDStnlhN+Wi6abx0cxoe1yUprtYwgocpKuTOLIeOPoc6OJlWf
        sTh1hldHOm4rspIZSd2yqHAJNWHTc1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-HaG8VabsOHGs3_PDf83gSA-1; Tue, 06 Jul 2021 10:17:46 -0400
X-MC-Unique: HaG8VabsOHGs3_PDf83gSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DB9581840A;
        Tue,  6 Jul 2021 14:17:45 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 658F760CC6;
        Tue,  6 Jul 2021 14:17:41 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 5A9AA416F5D2; Tue,  6 Jul 2021 11:17:23 -0300 (-03)
Date:   Tue, 6 Jul 2021 11:17:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/5] optionally sync per-CPU vmstats counter on return to
 userspace
Message-ID: <20210706141723.GA68914@fuller.cnet>
References: <20210701210336.358118649@fuller.cnet>
 <20210702123032.GA72061@lothringen>
 <20210702152816.GA4122@fuller.cnet>
 <20210706130925.GC107277@lothringen>
 <20210706140550.GA64308@fuller.cnet>
 <20210706140920.GA68399@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706140920.GA68399@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 11:09:20AM -0300, Marcelo Tosatti wrote:
> > > And I suspect some other people won't like much a new extension
> > > to isolcpus.
> > 
> > Why is that so? 
> 
> Ah, yes, that would be PeterZ.
> 
> IIRC his main point was that its not runtime changeable.
> We can (partially fix that), if that is the case.
> 
> Peter, was that the only problem you saw with isolcpus interface?

Oh, and BTW, isolcpus=managed_irq flag was recently added due to another
isolation bug.

This problem is the same category, so i don't see why it should be
treated especially (yes, i agree isolcpus= interface should be 
improved, but thats what is available today).

