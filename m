Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08893ED8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhHPOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhHPOZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629123922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+xHuOgld2yV1Ehb4bmgL8GwSOGfxwi16qCP0g5oXrXY=;
        b=GT2VXOV+4gmwdbnFdjxsldEaHiOzLG0DZ5bJSthiWLia1zBf5OYwAPHudSxfv/VV0wIK+V
        3YLykpDaOBrz9mQB0MfTgRGu0sSlR12KeuIAXp/KFLgoxm2Jkx6UeXdPBXSKhAjp5SplJR
        2QsB1Pjh+dnMW83yKeKv5WYrgx+XFhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-2F8IBltuPrGtTbM92SS1vw-1; Mon, 16 Aug 2021 10:25:21 -0400
X-MC-Unique: 2F8IBltuPrGtTbM92SS1vw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E19190A7AD;
        Mon, 16 Aug 2021 14:25:19 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BB83E728;
        Mon, 16 Aug 2021 14:25:05 +0000 (UTC)
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
Subject: [PATCH v2 0/3] virtio-mem: disallow mapping virtio-mem memory via /dev/mem
Date:   Mon, 16 Aug 2021 16:25:02 +0200
Message-Id: <20210816142505.28359-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add the basic infrastructure to exclude some physical memory
regions completely from /dev/mem access, on any architecture and under
any system configuration (independent of CONFIG_STRICT_DEVMEM and
independent of "iomem=").

Use it for virtio-mem, to disallow mapping any virtio-mem memory via
/dev/mem to user space after the virtio-mem driver was loaded: there is
no sane use case to access the device-managed memory region via /dev/mem
once the driver is actively (un)plugging memory within that region and
we want to make sure that nobody will accidentially access unplugged
memory in a sane environment.

Details can be found in patch #1.

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
  /dev/mem: disallow access to explicitly excluded system RAM regions
  virtio-mem: disallow mapping virtio-mem memory via /dev/mem
  kernel/resource: cleanup and optimize iomem_is_exclusive()

 drivers/char/mem.c          | 22 ++++++--------
 drivers/virtio/virtio_mem.c |  4 ++-
 include/linux/ioport.h      |  1 +
 kernel/resource.c           | 60 +++++++++++++++++++++++++++++++++----
 lib/Kconfig.debug           |  4 ++-
 5 files changed, 71 insertions(+), 20 deletions(-)


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.31.1

