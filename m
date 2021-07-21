Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D93D0C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhGUJaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33637 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236720AbhGUJTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626861584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3NEHt8cctnmAx7xk3wK9xWSkrUlp4CC4dKGzkyQQ8Yw=;
        b=hljZqMZPzyhI1zYvOWJNISBpTKfYW3k65i6zG5gwRGugAqL/VsxuWr3IAPoeQtaIkJU+t0
        cpmt0//Mt5U8Ryx8rneaCnQXRs76ElhvexWOOHY4dCN1T9H7iNtnFoP4N0s1PIFt9Wt0b6
        HuO5spQUUWNOhoEn7NeTluVUkLC8/EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-SJTRjZVnNn6qQpwZLzi5uw-1; Wed, 21 Jul 2021 05:59:42 -0400
X-MC-Unique: SJTRjZVnNn6qQpwZLzi5uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97276423C7;
        Wed, 21 Jul 2021 09:59:41 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB3319D7C;
        Wed, 21 Jul 2021 09:59:32 +0000 (UTC)
Date:   Wed, 21 Jul 2021 17:59:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPfwAN1onpSKoeBj@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
 <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:23:38AM +0100, John Garry wrote:
> On 21/07/2021 02:40, Ming Lei wrote:
> > > I think that you should see a significant performance boost.
> > There is build issue, please check your tree:
> > 
> >    MODPOST vmlinux.symvers
> >    MODINFO modules.builtin.modinfo
> >    GEN     modules.builtin
> >    LD      .tmp_vmlinux.btf
> > ld: Unexpected GOT/PLT entries detected!
> > ld: Unexpected run-time procedure linkages detected!
> > ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o: in function `smmu_test_store':
> > /root/git/linux/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3892: undefined reference to `smmu_test_core'
> >    BTF     .btf.vmlinux.bin.o
> > pahole: .tmp_vmlinux.btf: No such file or directory
> >    LD      .tmp_vmlinux.kallsyms1
> > .btf.vmlinux.bin.o: file not recognized: file format not recognized
> > make: *** [Makefile:1177: vmlinux] Error 1
> 
> Ah, sorry. I had some test code which was not properly guarded with
> necessary build switches.
> 
> I have now removed that from the tree, so please re-pull.

Now the kernel can be built successfully, but not see obvious improvement
on the reported issue:

[root@ampere-mtjade-04 ~]# uname -a
Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux

[root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
  read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)

[root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=138MiB/s][r=35.4k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3063: Wed Jul 21 05:55:31 2021
  read: IOPS=35.4k, BW=138MiB/s (145MB/s)(1383MiB/10001msec)


Thanks, 
Ming

