Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0739B3C20E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhGIIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhGIIlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625819902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=z6Hk4bJ8S8lcwyhof3193pL12mlYl2MQc8nr7rUonLc=;
        b=I4oKiRbBfwQ5/0j7WJZ48Wc4jyciMQIR50WnjUoqyYoT+F6TMR6vS076yv+oYTO+f/ZvkI
        pKFQjVKE5nOyITagK49QcakAS+BZM44oKlmREiLwHaw4uz+Yo7p5NORMVJlXse0KuUKJLj
        3mNyQbWA3taBXd2dKl7eAtnYGffqAts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-kW-M2W2pOPeYf3W8V_w2gA-1; Fri, 09 Jul 2021 04:38:21 -0400
X-MC-Unique: kW-M2W2pOPeYf3W8V_w2gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA461018720;
        Fri,  9 Jul 2021 08:38:20 +0000 (UTC)
Received: from T590 (ovpn-13-13.pek2.redhat.com [10.72.13.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C27E5C1A3;
        Fri,  9 Jul 2021 08:38:13 +0000 (UTC)
Date:   Fri, 9 Jul 2021 16:38:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-nvme@lists.infradead.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [bug report] iommu_dma_unmap_sg() is very slow then running IO from
 remote numa node
Message-ID: <YOgK8fdv7dOQtkET@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I observed that NVMe performance is very bad when running fio on one
CPU(aarch64) in remote numa node compared with the nvme pci numa node.

Please see the test result[1] 327K vs. 34.9K.

Latency trace shows that one big difference is in iommu_dma_unmap_sg(),
1111 nsecs vs 25437 nsecs.


[1] fio test & results

1) fio test result:

- run fio on local CPU
taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting

IOPS: 327K
avg latency of iommu_dma_unmap_sg(): 1111 nsecs


- run fio on remote CPU
taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting

IOPS: 34.9K
avg latency of iommu_dma_unmap_sg(): 25437 nsecs

2) system info
[root@ampere-mtjade-04 ~]# lscpu | grep NUMA
NUMA node(s):                    2
NUMA node0 CPU(s):               0-79
NUMA node1 CPU(s):               80-159

lspci | grep NVMe
0003:01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983

[root@ampere-mtjade-04 ~]# cat /sys/block/nvme1n1/device/device/numa_node
0



Thanks, 
Ming

