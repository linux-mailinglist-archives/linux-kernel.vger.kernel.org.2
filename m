Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64C3D0680
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 03:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhGUBAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhGUBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626831663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyII5sjQfVW2iEOXEHyiVYmuKihq8QrTV1vY6sLK7cs=;
        b=B2p/Y9IzzPA8P9nX2KCELbOEBhWLPNfFhYqIm/Pz6t8985Xm5IeBt5mSVq5pgAmTaL4H8Y
        MpFtCMhmV4kgCOZshz2r2SMMTXWSG/A0B/rmzA64L1qfY8c+47DxZUMVm40tV2id/iqbZd
        lXnrx7yoWPKfFCTUWGGWBwpT1FZmT7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-3TZXnutvN6Wd7PFM0fVGXA-1; Tue, 20 Jul 2021 21:41:01 -0400
X-MC-Unique: 3TZXnutvN6Wd7PFM0fVGXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BD9802C80;
        Wed, 21 Jul 2021 01:41:00 +0000 (UTC)
Received: from T590 (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F035D9DC;
        Wed, 21 Jul 2021 01:40:53 +0000 (UTC)
Date:   Wed, 21 Jul 2021 09:40:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPd7IGFZrsTRfUxE@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 05:14:28PM +0100, John Garry wrote:
> On 09/07/2021 15:24, Ming Lei wrote:
> > > associated compromises.
> > Follows the log of 'perf report'
> > 
> > 1) good(run fio from cpus in the nvme's numa node)
> 
> Hi Ming,
> 
> If you're still interested in this issue, as an experiment only you can try
> my rebased patches here:
> 
> https://github.com/hisilicon/kernel-dev/commits/private-topic-smmu-5.14-cmdq-4
> 
> I think that you should see a significant performance boost.

There is build issue, please check your tree:

  MODPOST vmlinux.symvers
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
  LD      .tmp_vmlinux.btf
ld: Unexpected GOT/PLT entries detected!
ld: Unexpected run-time procedure linkages detected!
ld: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.o: in function `smmu_test_store':
/root/git/linux/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3892: undefined reference to `smmu_test_core'
  BTF     .btf.vmlinux.bin.o
pahole: .tmp_vmlinux.btf: No such file or directory
  LD      .tmp_vmlinux.kallsyms1
.btf.vmlinux.bin.o: file not recognized: file format not recognized
make: *** [Makefile:1177: vmlinux] Error 1


Thanks, 
Ming

