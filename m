Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCCD31B93C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhBOM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230389AbhBOMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613391718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y+tCfh7p5rS93AyYcRTEfar0U9kSrmpYDnZc3YNOM60=;
        b=adUrT3kfc/I+0OJyJj8sD3gHHHfHegmBKfMTPmd79pMGhOG9ZhUkGn6EY5sYfi6VfBRUnq
        1oOcKww97UScqWng5crfCDL5HgQHhFg8HdtE/XM1a9lVr/Z8T1T7x/3aZNkupYQ9KRncDe
        UrKVRf/BlK7cJo9WrKNfsLkqaBfFkas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-zZCEY8pSOaaGROwdy9wW1Q-1; Mon, 15 Feb 2021 07:21:54 -0500
X-MC-Unique: zZCEY8pSOaaGROwdy9wW1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A32192CC45;
        Mon, 15 Feb 2021 12:21:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-89.ams2.redhat.com [10.36.114.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0362BFEC;
        Mon, 15 Feb 2021 12:21:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        "Boeuf, Sebastien" <sebastien.boeuf@intel.com>,
        Hui Zhu <teawater@gmail.com>, Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 0/2] virito-mem: one fix and VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
Date:   Mon, 15 Feb 2021 13:21:41 +0100
Message-Id: <20210215122143.27608-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One minor fix and introduction of / support for
VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE.

Looking into supporting file-based memory backends (shmem, hugetlbfs, ...)
for virtio-mem in QEMU cleanly, I realized that we have to indicate that
unplugged memory is completely inaccessible. Otherwise, Linux might in
corner cases read unplugged memory, which is harder to support (and harder
to protect from) in a hypervisor than with anonymous memory where we have
a shared zeropage.

To support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE cleanly, we cannot (un)plug
memory in SBM (Sub Block Mode) and instead, can only support adding/
removing individual Linux memory blocks (e.g., 128MB on x86-64).

While we might still be able to allow for reading unplugged memory with
file-based memory backends in the future (and I have plans/prototypes for
it), at least in the near future we cannot support it.

David Hildenbrand (2):
  virtio-mem: don't read big block size in SBM
  virtio-mem: support VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE

 drivers/virtio/virtio_mem.c     | 27 ++++++++++++++++++++-------
 include/uapi/linux/virtio_mem.h | 10 +++++++---
 2 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.29.2

