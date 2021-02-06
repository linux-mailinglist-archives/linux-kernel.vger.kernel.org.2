Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95C1311BA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBFFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBFFez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 00:34:55 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D1C061756
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 21:34:14 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d3so13517490lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 21:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDWgXFMkN9SJ13tK/quWc9ya9uCuscGv0JtfRkXDqkg=;
        b=kGz+OZdKKTuD7RfPJrqf1WbIk+Zk/d8xX/d7I/bD1qEvTjxXD1/8Z05KGsKGZfGzsY
         RLtOuwLNN2uDBqGVczNc10UZ3vdcenH/3OXseukU6qZOQq9o/OiFbEMPTkfjpHHhKrRS
         tK7q6LbFqU5sWQYrdARJpZ1K+s2P92o5LtL8XwCjZ4mGeqIy1KV/lQoW6o0ss1qAqpj5
         ahrfZTrStBaxXJ/CY/FfiCbZvBhW0D2q495puHi4vXqJDdjclDY9diJA21hO2Jm9yx9Q
         mgVVgbqxHT3E8PKrLV9vMkGAUpQzyHUCIFNXoRUNfuDJb2JKrias/RyDoAg4/HCGt7AT
         niBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EDWgXFMkN9SJ13tK/quWc9ya9uCuscGv0JtfRkXDqkg=;
        b=F5osIXCU/wJJuMf5I5n6tGA21ewMm7eIV3WKk0OjFj1pAKYo7T1TRpwdiJese75Esx
         F0o/oqOhbyz1NY19oqWTPhWe4+c6bdpJmTWPSTV1WLyv6R9qBlByHOb9wKzeD2+VEvLL
         pamQPsbUT/aRQrEYnD9avFyem30wAFY32jOyIcpfZVgdQRMsqR487ynj1kS/pf0lyrul
         3zbx4sY3PTO5Tp5CJQDFbzb4w2r4aZ+vnelPlhlS22WbjEr5BEqRuB10zP0XnM5JDRWE
         xkmxPAR6AJFk17p++rqJfzl3KikFhXEs7Mmc61i37NuQT4K2RxZ9hM3SKAYzK+k/zk4I
         NO5g==
X-Gm-Message-State: AOAM5337b0jLMCf4gOGjHKbX/ZsHIwNEXVXbAS6fmljnfzPiyQvXMPSg
        4M8f86NHnpndvqX0BpTxrzPzvMmUXleVibc3ItQ=
X-Google-Smtp-Source: ABdhPJzL8m2jAziUjI/5JdDslpkxK3xfUP4MHNtUNd00OEBUV7YB3lJW78hsaIgbmfW+3a85S74a5w==
X-Received: by 2002:a05:6512:b15:: with SMTP id w21mr4356970lfu.645.1612589653307;
        Fri, 05 Feb 2021 21:34:13 -0800 (PST)
Received: from localhost.localdomain ([147.30.65.60])
        by smtp.googlemail.com with ESMTPSA id e7sm1236722ljo.74.2021.02.05.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 21:34:12 -0800 (PST)
From:   Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     alex.dewar90@gmail.com, linux-kernel@vger.kernel.org,
        syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Subject: [PATCH] drivers/misc/vmw_vmci: restrict too big queue size in qp_host_alloc_queue
Date:   Sat,  6 Feb 2021 11:34:09 +0600
Message-Id: <20210206053409.1972270-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found WARNING in qp_broker_alloc[1] in qp_host_alloc_queue()
when num_pages is 0x100001, giving queue_size + queue_page_size
bigger than KMALLOC_MAX_SIZE for kzalloc(), resulting order >= MAX_ORDER
condition.

queue_size + queue_page_size=0x8000d8, where KMALLOC_MAX_SIZE=0x400000.


FYI, I've also noticed in vmci_queue_pair.c other SLAB allocations with no
length check that might exceed KMALLOC_MAX_SIZE as well,
but syzbot doesn't have reproduces for them.

in qp_alloc_ppn_set():
	produce_ppns =
	    kmalloc_array(num_produce_pages, sizeof(*produce_ppns),
			  GFP_KERNEL);
[..]
	consume_ppns =
	    kmalloc_array(num_consume_pages, sizeof(*consume_ppns),
			  GFP_KERNEL);
[..]
in qp_alloc_hypercall():
	msg_size = sizeof(*alloc_msg) +
	    (size_t) entry->num_ppns * ppn_size;
	alloc_msg = kmalloc(msg_size, GFP_KERNEL);
[..]
in qp_broker_create():
	entry->local_mem = kcalloc(QPE_NUM_PAGES(entry->qp),
					   PAGE_SIZE, GFP_KERNEL);

[1]
Call Trace:
 alloc_pages include/linux/gfp.h:547 [inline]
 kmalloc_order+0x40/0x130 mm/slab_common.c:837
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:853
 kmalloc_large include/linux/slab.h:481 [inline]
 __kmalloc+0x257/0x330 mm/slub.c:3959
 kmalloc include/linux/slab.h:557 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 qp_host_alloc_queue drivers/misc/vmw_vmci/vmci_queue_pair.c:540 [inline]
 qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1351 [inline]
 qp_broker_alloc+0x936/0x2740 drivers/misc/vmw_vmci/vmci_queue_pair.c:1739

Reported-by: syzbot+15ec7391f3d6a1a7cc7d@syzkaller.appspotmail.com
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index c49065887e8f..f6af406fda80 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -537,6 +537,11 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
 
 	queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
 
+	if (queue_size + queue_page_size > KMALLOC_MAX_SIZE) {
+		pr_warn("too big queue to allocate\n");
+		return NULL;
+	}
+
 	queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
 	if (queue) {
 		queue->q_header = NULL;
-- 
2.25.1

