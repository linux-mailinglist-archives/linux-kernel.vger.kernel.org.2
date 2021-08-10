Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7637A3E5871
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbhHJKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239853AbhHJKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628591761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MKdVxhmWHkSF7Qc4zBZXEqJWUbfI37hUIq+4sHXK5w=;
        b=e8zqrthseXpaRUVLS4s2wHOlkI0YdLsuDLzzZdnTeumgjvt1wYkrfaROcfsW4KCtC6v56Y
        XvSZhMT2rjG6ncxWTY2/oBcWAqTb3SBPBh/eeb8gU49qrJ8Wh6Ip/SN1HtUA+mJtq+MfMH
        JRUT6qhIT6kpJ2LUMh6AiF3g3F/B+ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-SLez8Vj3PA270oq6Eepj1A-1; Tue, 10 Aug 2021 06:35:58 -0400
X-MC-Unique: SLez8Vj3PA270oq6Eepj1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B591008060;
        Tue, 10 Aug 2021 10:35:56 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8415C232;
        Tue, 10 Aug 2021 10:35:50 +0000 (UTC)
Date:   Tue, 10 Aug 2021 18:35:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YRJWgU5VhzBe1JP4@T590>
References: <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
 <YQF1AKS6Y14dLU/A@T590>
 <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdd16e8-278f-3bc9-da97-a91264aec909@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:36:47AM +0100, John Garry wrote:
> On 28/07/2021 16:17, Ming Lei wrote:
> > > > > Have you tried turning off the IOMMU to ensure that this is really just
> > > > > an IOMMU problem?
> > > > > 
> > > > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > > > disabling for kernel drivers).
> > > > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > > > on this issue.
> > > A ~90% throughput drop still seems to me to be too high to be a software
> > > issue. More so since I don't see similar on my system. And that throughput
> > > drop does not lead to a total CPU usage drop, from the fio log.
> > > 
> > > Do you know if anyone has run memory benchmark tests on this board to find
> > > out NUMA effect? I think lmbench or stream could be used for this.
> > https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/
> 
> Hi Ming,
> 
> Out of curiosity, did you investigate this topic any further?

IMO, the issue is probably in device/system side, since completion latency is
increased a lot, meantime submission latency isn't changed.

Either the submission isn't committed to hardware in time, or the
completion status isn't updated to HW in time from viewpoint of CPU.

We have tried to update to new FW, but not see difference made.

> 
> And you also asked about my results earlier:
> 
> On 22/07/2021 16:54, Ming Lei wrote:
> >> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
> >> [   52.047732] nvme nvme0: pci function 0000:81:00.0
> >> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
> >> [   52.087318]  nvme0n1: p1
> >>
> >> So I get these results:
> >> cpu0 335K
> >> cpu32 346K
> >> cpu64 300K
> >> cpu96 300K
> >>
> >> So still not massive changes.
> > In your last email, the results are the following with irq mode io_uring:
> >
> >   cpu0  497K
> >   cpu4  307K
> >   cpu32 566K
> >   cpu64 488K
> >   cpu96 508K
> >
> > So looks you get much worse result with real io_polling?
> >
> 
> Would the expectation be that at least I get the same performance with
> io_polling here?

io_polling is supposed to improve IO latency a lot compared with irq
mode, and the perf data shows that clearly on x86_64.

> Anything else to try which you can suggest to investigate
> this lower performance?

You may try to compare irq mode and polling and narrow down the possible
reasons, no exact suggestion on how to investigate it, :-(


Thanks,
Ming

