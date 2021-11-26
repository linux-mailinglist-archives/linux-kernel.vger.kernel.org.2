Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1245EF57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbhKZNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352433AbhKZNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637934160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qv4Kw9RIW39ZiswcLW6UjMfgb9X0DOPxTe7NmLh2c2M=;
        b=WuUqGngwRrnqS7TrtTNvirIN0NRi4Q9Ke47Dqmvhr3erxdPAUhgJXJtdWowPZZ4vt5tJo8
        zaJTHue/NrCUxCZy4CA8+cB8lJMGAWiVg/DnlCUH0Ol9+LEO5zyZhyvMYSIo/Fmb9tzT5M
        VZlWrvwiFCwC1IytS1dvOF1re7VU/kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-E_29GzgtP2-OYAERnJ26nA-1; Fri, 26 Nov 2021 08:42:37 -0500
X-MC-Unique: E_29GzgtP2-OYAERnJ26nA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898228015BA;
        Fri, 26 Nov 2021 13:42:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0C8D72FA6;
        Fri, 26 Nov 2021 13:42:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Gavin Shan <gshan@redhat.com>, Hui Zhu <teawater@gmail.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than MAX_ORDER - 1
Date:   Fri, 26 Nov 2021 14:42:07 +0100
Message-Id: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio-mem driver currently supports logical hot(un)plug in
MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
flexible, and to improve hotunplug when using ZONE_NORMAL.

With pageblock granularity, we then have a granularity comparable to
hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
we really want to decouple it from MAX_ORDER.

While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
needs work to be able to properly handle pageblock granularity on
ZONE_NORMAL. This support is in the works [1], so let's prepare
virtio-mem for supporting smaller granularity than MAX_ORDER - 1.

Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
limitation in virtio-mem, and using different device block sizes (2MiB,
4MiB, 8MiB).

[1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Eric Ren <renzhengeek@gmail.com>
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (2):
  virtio-mem: prepare page onlining code for granularity smaller than
    MAX_ORDER - 1
  virtio-mem: prepare fake page onlining code for granularity smaller
    than MAX_ORDER - 1

 drivers/virtio/virtio_mem.c | 110 ++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 36 deletions(-)

-- 
2.31.1

