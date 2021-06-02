Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186B43992F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFBS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhFBS7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622660255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y6MOJkXDqthwxgoOtIfGa8m4Pzox6wAw262/GSt7ITY=;
        b=N9l+5WpKcsGt2SunNAd8IeX6ZmZ9PXERKcCNS74BRzaA0SsHvr4GXHRFENNE5VbCTcYwBm
        lGkKeNYFpt0ILoUFSLcK1W+4ytOqoLAznKUObiUasThWcrOE7Fzn0gJi2Oy0/wLx3uc3DP
        LdK6hxUd+Y474/8XLNgNCBqL+yQoVko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-anCrELXmM4icLUzhQDGNjg-1; Wed, 02 Jun 2021 14:57:33 -0400
X-MC-Unique: anCrELXmM4icLUzhQDGNjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A579107ACC7;
        Wed,  2 Jun 2021 18:57:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-159.ams2.redhat.com [10.36.114.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7BC0100238C;
        Wed,  2 Jun 2021 18:57:21 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 0/7] virtio-mem: prioritize unplug from ZONE_MOVABLE
Date:   Wed,  2 Jun 2021 20:57:13 +0200
Message-Id: <20210602185720.31821-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, memory provided by a single virtio-mem device was usually
either onlined completely to ZONE_MOVABLE (online_movable) or to
ZONE_NORMAL (online_kernel), so we didn't actually care about "what"
we are unplugging; however, that will change in the future when we will
have memory blocks in different zones within a single virtio-mem device.

There are two reasons why we want to track to which zone a memory block
belongs to and prioritize ZONE_MOVABLE blocks:

1) Memory managed by ZONE_MOVABLE can more likely get unplugged, therefore,
   resulting in a faster memory hotunplug process. Further, we can more
   reliably unplug and remove complete memory blocks, removing metadata
   allocated for the whole memory block.

2) We want to avoid corner cases where unplugging with the current scheme
   (highest to lowest address) could result in accidential zone imbalances,
   whereby we remove too much ZONE_NORMAL memory for ZONE_MOVABLE memory
   of the same device.

This series unplugs ZONE_MOVABLE memory blocks first, before falling back
to ZONE_NORMAL ones.

Patch #1 is an unrelated fix, previously sent in other context that didn't
get picked up yet. Patch #2-#4 and #6 are cleanups. Patch #5 and #7
implement ZONE_MOVABLE aware handling in Sub Block Mode and Big Block Mode
respectively.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (7):
  virtio-mem: don't read big block size in Sub Block Mode
  virtio-mem: use page_zonenum() in virtio_mem_fake_offline()
  virtio-mem: simplify high-level plug handling in Sub Block Mode
  virtio-mem: simplify high-level unplug handling in Sub Block Mode
  virtio-mem: prioritize unplug from ZONE_MOVABLE in Sub Block Mode
  virtio-mem: simplify high-level unplug handling in Big Block Mode
  virtio-mem: prioritize unplug from ZONE_MOVABLE in Big Block Mode

 drivers/virtio/virtio_mem.c | 338 +++++++++++++++++++-----------------
 1 file changed, 174 insertions(+), 164 deletions(-)


base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
-- 
2.31.1

