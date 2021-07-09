Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6B3C25D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhGIOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhGIOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625840517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R80jkwSRBMdXMIX0M3ux6M8QaLP+0xDfTy88OLoP8qM=;
        b=h2OBH8KDRHbrCG5SsHpkU3eV5vRInHIHJTd646l3pt11E1+9IHRNoE9V0Kj6+Ex26msm1L
        KtKQLlVIIlnEIpLtYu4sCCj/nLCIP1IfVZdb1dpYVyYyVx8fAG1iFTW5mMjWui7Pwa1OOR
        rnWksp+7w+AXYxxYu7qbjhr6l/w9z5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-Mi1YBWmwOS2HtCIMAe8qEg-1; Fri, 09 Jul 2021 10:21:54 -0400
X-MC-Unique: Mi1YBWmwOS2HtCIMAe8qEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C834B343CD;
        Fri,  9 Jul 2021 14:21:52 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE32F60BD8;
        Fri,  9 Jul 2021 14:21:44 +0000 (UTC)
Date:   Fri, 9 Jul 2021 22:21:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YOhbc5C47IzC893B@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <20210709101614.GZ22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709101614.GZ22278@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 11:16:14AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 09, 2021 at 04:38:09PM +0800, Ming Lei wrote:
> > I observed that NVMe performance is very bad when running fio on one
> > CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Have you checked the effect of running a memory-heavy process using
> memory from node 1 while being executed by CPUs in node 0?

1) aarch64
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

      11.511752 GB/sec
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.084333 GB/sec


2) x86_64[1]
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       4.193927 GB/sec
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.553392 GB/sec


[1] on this x86_64 machine, IOPS can reach 680K in same fio nvme test 



Thanks,
Ming

