Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64533E99BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhHKUgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhHKUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628714187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F6mT/4MmPGt0OpBTI+vB4Ipr2jKicz7mUc5W2HAhCYc=;
        b=Utm3l/2x4EkZpApWpLiTVd86OIYEhXBg439EpVgCVHiud2gzugIe/Sau7z+mBufnbtV32W
        Z8BPKweQPNv9jPZ19ylSX66zlrKyVj3asXyKAJob74rIYKQikqI7X8Y4ihwbyud25deu/9
        OKf6xjhNRzrNvyXUE8g5/j1AOk3tDak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-YTGvH1lAPJyBloRRyBVg5Q-1; Wed, 11 Aug 2021 16:36:26 -0400
X-MC-Unique: YTGvH1lAPJyBloRRyBVg5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B38988799E0;
        Wed, 11 Aug 2021 20:36:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB8541B46B;
        Wed, 11 Aug 2021 20:36:13 +0000 (UTC)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 0/3] virtio-mem: disallow mapping virtio-mem memory via /dev/mem
Date:   Wed, 11 Aug 2021 22:36:09 +0200
Message-Id: <20210811203612.138506-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (3):
  /dev/mem: disallow access to explicitly excluded system RAM regions
  virtio-mem: disallow mapping virtio-mem memory via /dev/mem
  kernel/resource: cleanup and optimize iomem_is_exclusive()

 drivers/char/mem.c          | 22 ++++++-------
 drivers/virtio/virtio_mem.c |  4 ++-
 include/linux/ioport.h      |  1 +
 kernel/resource.c           | 61 ++++++++++++++++++++++++++++++++-----
 lib/Kconfig.debug           |  4 ++-
 5 files changed, 69 insertions(+), 23 deletions(-)

-- 
2.31.1

