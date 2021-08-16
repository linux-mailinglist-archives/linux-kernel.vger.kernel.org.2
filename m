Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA03ED8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhHPO0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhHPO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629123935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hywntJFvc8rY3h4zVE0FB14e7oRCBStJ9/imcpDrqo=;
        b=UTfwVNrC52ceko9QgtxemiuM+A3XFJ9M2gTWIg1q2Edc0fQQFwagAIiDQCcJ+j+LZ/IskK
        qly59K9ptXlit9dTGVVIsqaWgZiFxowOhdkorxups7OzVZW+2m2XsDJMK9AlJORGrRXD68
        udFI5rGX48IFRzn2l7Sh9gnaHlHOnqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-_Qc_Bh6wPZS4B14o-y1l_g-1; Mon, 16 Aug 2021 10:25:32 -0400
X-MC-Unique: _Qc_Bh6wPZS4B14o-y1l_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F3469737;
        Mon, 16 Aug 2021 14:25:30 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E96FE723;
        Mon, 16 Aug 2021 14:25:23 +0000 (UTC)
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
Subject: [PATCH v2 2/3] virtio-mem: disallow mapping virtio-mem memory via /dev/mem
Date:   Mon, 16 Aug 2021 16:25:04 +0200
Message-Id: <20210816142505.28359-3-david@redhat.com>
In-Reply-To: <20210816142505.28359-1-david@redhat.com>
References: <20210816142505.28359-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By creating our parent IORESOURCE_SYSTEM_RAM resource with
IORESOURCE_EXCLUSIVE, we will disallow any /dev/mem access to our
device-managed region.

Note that access to the region would still be possible if someone simply
doesn't load the virtio-mem driver; however, there is no way of
protecting against someone that just wants to do nasty things.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 09ed55de07d7..c8f914700a42 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2516,8 +2516,10 @@ static int virtio_mem_create_resource(struct virtio_mem *vm)
 	if (!name)
 		return -ENOMEM;
 
+	/* Disallow mapping device memory via /dev/mem completely. */
 	vm->parent_resource = __request_mem_region(vm->addr, vm->region_size,
-						   name, IORESOURCE_SYSTEM_RAM);
+						   name, IORESOURCE_SYSTEM_RAM |
+						   IORESOURCE_EXCLUSIVE);
 	if (!vm->parent_resource) {
 		kfree(name);
 		dev_warn(&vm->vdev->dev, "could not reserve device region\n");
-- 
2.31.1

