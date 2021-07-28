Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9EE3D91A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhG1PRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235559AbhG1PRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627485451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G74hAD1INJz4al2p5kUqrIQ36rIkhCEJh1SOa5TxS9s=;
        b=U8bGFJR+tZUb14klmRFoK9YTokaS9eFpDhiYG+BH3mIGp/+QZyYCMJx9fOfgzL7g7xQCbA
        Yq8snewYS1ToMvEU15clIqTUlCj0cmYYwied6I8nVObSh2gUidrrfCmrwnfaqVwayBIDTo
        YWWRmH14g3zeSNcwoqmGYDjJg0WCoEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-UDtteHy1NGmvPeuayJGZwg-1; Wed, 28 Jul 2021 11:17:29 -0400
X-MC-Unique: UDtteHy1NGmvPeuayJGZwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B449801AC0;
        Wed, 28 Jul 2021 15:17:28 +0000 (UTC)
Received: from T590 (ovpn-12-35.pek2.redhat.com [10.72.12.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C7A1971B;
        Wed, 28 Jul 2021 15:17:19 +0000 (UTC)
Date:   Wed, 28 Jul 2021 23:17:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YQF1AKS6Y14dLU/A@T590>
References: <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590>
 <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590>
 <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
 <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
 <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead87bf2-ddfa-eb67-db44-9619c6cdb714@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:38:18AM +0100, John Garry wrote:
> On 28/07/2021 02:32, Ming Lei wrote:
> > On Mon, Jul 26, 2021 at 3:51 PM John Garry<john.garry@huawei.com>  wrote:
> > > On 23/07/2021 11:21, Ming Lei wrote:
> > > > > Thanks, I was also going to suggest the latter, since it's what
> > > > > arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
> > > > > indicative of where the slowness most likely stems from.
> > > > The improvement from 'iommu.strict=0' is very small:
> > > > 
> > > Have you tried turning off the IOMMU to ensure that this is really just
> > > an IOMMU problem?
> > > 
> > > You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> > > cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> > > disabling for kernel drivers).
> > Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
> > on this issue.
> 
> A ~90% throughput drop still seems to me to be too high to be a software
> issue. More so since I don't see similar on my system. And that throughput
> drop does not lead to a total CPU usage drop, from the fio log.
> 
> Do you know if anyone has run memory benchmark tests on this board to find
> out NUMA effect? I think lmbench or stream could be used for this.

https://lore.kernel.org/lkml/YOhbc5C47IzC893B@T590/

-- 
Ming

