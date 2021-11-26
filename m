Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914BF45F276
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhKZQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239797AbhKZQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637945287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Grbamj1Ui2RVl3b5MpDYwaWCz8FlCD80yhTd0RjsQF4=;
        b=XsxaeGhZr6sIrQc6wTPI8LeYrxyKpAOeAJ0YTA4Aydb0rLrr6RDUz9B7lMbir4f8F4wHNQ
        kFNJ7RK1ROlhJJTdx2FL17imWn9eLOjZiQgCONNKNCn23Bm+GgxFtSN7tLJZ55sNsGB1ZF
        mn9cq7k8wLqOQWoyFja4bBOiov5utsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-CQIPzT1JN5O5Ca3KNBBfGA-1; Fri, 26 Nov 2021 11:48:02 -0500
X-MC-Unique: CQIPzT1JN5O5Ca3KNBBfGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 521EE819015;
        Fri, 26 Nov 2021 16:48:01 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.193.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0866604CC;
        Fri, 26 Nov 2021 16:47:54 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2 0/2] vdpa: add driver_override support and sysfs ABI documentation
Date:   Fri, 26 Nov 2021 17:47:51 +0100
Message-Id: <20211126164753.181829-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds missing documentation of sysfs ABI for vDPA bus
and the second adds driver_override support (the code is the same of v1,
so I left Jason A-b tag).

v2:
- added preliminary commit to document pre-existing sysfs ABI for vDPA bus
- added `driver_override` documentation in Documentation/ABI/testing/sysfs-bus-vdpa

v1: https://lore.kernel.org/virtualization/20211104161729.258294-1-sgarzare@redhat.com/

Thanks,
Stefano

Stefano Garzarella (2):
  docs: document sysfs ABI for vDPA bus
  vdpa: add driver_override support

 include/linux/vdpa.h                     |  2 +
 drivers/vdpa/vdpa.c                      | 74 ++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-vdpa | 57 ++++++++++++++++++
 MAINTAINERS                              |  1 +
 4 files changed, 134 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa

-- 
2.31.1

