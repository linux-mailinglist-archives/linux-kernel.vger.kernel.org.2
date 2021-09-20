Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56679411700
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhITObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240599AbhITOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632148166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eKxXCIY3RXYoZJT+3h0svXLPmqhFXlaxuuqqZnTjWlM=;
        b=diejBqqarsv6//nGHWfGmkqIYX+/Jg5tkGlGZ+rGSqRZVcu/l8TsT0Nwnw/Tlx6d5GK5Mh
        D+NFJJeZlADn0o/UQSlMJP8ZCrXDREDNyvLE5mu++u3uWdoi4RnOJnaqDb1AJIS+bfSOmD
        27kg+PVt3pUZSIQxuYbpMjars0VvoZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Qsnarz32N5KVyUroFOyqHA-1; Mon, 20 Sep 2021 10:29:23 -0400
X-MC-Unique: Qsnarz32N5KVyUroFOyqHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63E348CEA20;
        Mon, 20 Sep 2021 14:29:21 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E117B60C17;
        Mon, 20 Sep 2021 14:28:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v5 0/3] virtio-mem: disallow mapping virtio-mem memory via /dev/mem
Date:   Mon, 20 Sep 2021 16:28:53 +0200
Message-Id: <20210920142856.17758-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew, can you take this via the -mm tree?

--

Let's add the basic infrastructure to exclude some physical memory
regions marked as "IORESOURCE_SYSTEM_RAM" completely from /dev/mem access,
even though they are not marked IORESOURCE_BUSY and even though
"iomem=relaxed" is set. Resource IORESOURCE_EXCLUSIVE for that purpose
instead of adding new flags to express something similar to
"soft-busy" or "not busy yet, but already prepared by a driver and not
to be mapped by user space".

Use it for virtio-mem, to disallow mapping any virtio-mem memory via
/dev/mem to user space after the virtio-mem driver was loaded.

Details can be found in patch #2 and #3.

v4 -> v5:
- "kernel/resource: disallow access to exclusive system RAM regions"
-- Add CONFIG_EXCLUSIVE_SYSTEM_RAM
- "virtio-mem: disallow mapping virtio-mem memory via /dev/mem"
-- Use CONFIG_EXCLUSIVE_SYSTEM_RAM
-- Add ACK from MST

v3 -> v4:
- Added Dans RBs (thanks!)
- Actually send the patches to the CC list ...

v2 -> v3:
- "kernel/resource: clean up and optimize iomem_is_exclusive()"
-- Reshuffled and moved for_each_resource() etc. into this patch
- "kernel/resource: disallow access to exclusive system RAM regions"
-- Leave CONFIG_STRICT_DEVMEM=n alone. Hoog into iomem_is_exclusive()
   instead.
-- Improve comments
- "virtio-mem: disallow mapping virtio-mem memory via /dev/mem"
-- Don't allow building virtio_mem without CONFIG_STRICT_DEVMEM when we
   have CONFIG_DEVMEM, where we don't have any guarantees.
- Rework all patch descriptions

v1 -> v2:
- "/dev/mem: disallow access to explicitly excluded system RAM regions"
-- Introduce and use for_each_resource() and next_resource_skip_children()
-- s/iomem_range_contains_excluded/iomem_range_contains_excluded_devmem/
- "kernel/resource: cleanup and optimize iomem_is_exclusive()"
-- Use for_each_resource()

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  kernel/resource: clean up and optimize iomem_is_exclusive()
  kernel/resource: disallow access to exclusive system RAM regions
  virtio-mem: disallow mapping virtio-mem memory via /dev/mem

 drivers/virtio/Kconfig      |  1 +
 drivers/virtio/virtio_mem.c |  4 ++-
 kernel/resource.c           | 54 ++++++++++++++++++++++++++-----------
 mm/Kconfig                  |  7 +++++
 4 files changed, 50 insertions(+), 16 deletions(-)


base-commit: e4e737bb5c170df6135a127739a9e6148ee3da82
-- 
2.31.1

