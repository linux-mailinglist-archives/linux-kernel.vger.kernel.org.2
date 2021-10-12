Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2169429E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJLGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhJLGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VYPjrfHoFryxA7atPdwxlCJUZlPks/b+YiU605lqPNo=;
        b=h+69iyc3brp5IZuogQXFp5OYRLvwDjKRE0mZVC4nvMCYFGMYxJLo7khs57klirVuQNn1VO
        CMa8UqSEearD2rX1/vWtNtIXZNJJIsHLmGj2JNo9bryvX+yDL6TgEaScG3iMv5NeiBPoCE
        tvop6McHk27qG1WGy9KkpCHDg8paYvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_gTnJdj7PqC_VRpApI3qhQ-1; Tue, 12 Oct 2021 02:52:56 -0400
X-MC-Unique: _gTnJdj7PqC_VRpApI3qhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A38100C67E;
        Tue, 12 Oct 2021 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1048D5F4E0;
        Tue, 12 Oct 2021 06:52:29 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V2 00/12] More virtio hardening
Date:   Tue, 12 Oct 2021 14:52:15 +0800
Message-Id: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series treis to do more hardening for virito.

patch 1 validates the num_queues for virio-blk device.
patch 2-4 validates max_nr_ports for virito-console device.
patch 5-7 harden virtio-pci interrupts to make sure no exepcted
interrupt handler is tiggered. If this makes sense we can do similar
things in other transport drivers.
patch 8-9 validate used ring length.
patch 9-11 let the driver to validate the used length instead of the
virtio core

Smoking test on blk/net with packed=on/off and iommu_platform=on/off.

Please review.

Changes since V1:
- fix and document the memory ordering around the intx_soft_enabled
  when enabling and disabling INTX interrupt
- for the driver that can validate the used length, virtio core won't
  even try to allocate auxilary arrays and validate the used length
- tweak the commit log
- fix typos

Jason Wang (12):
  virtio-blk: validate num_queues during probe
  virtio: add doc for validate() method
  virtio-console: switch to use .validate()
  virtio_console: validate max_nr_ports before trying to use it
  virtio_config: introduce a new ready method
  virtio_pci: harden MSI-X interrupts
  virtio-pci: harden INTX interrupts
  virtio_ring: fix typos in vring_desc_extra
  virtio_ring: validate used buffer length
  virtio-net: don't let virtio core to validate used length
  virtio-blk: don't let virtio core to validate used length
  virtio-scsi: don't let virtio core to validate used buffer length

 drivers/block/virtio_blk.c         |  4 +-
 drivers/char/virtio_console.c      | 51 +++++++++++++++++--------
 drivers/net/virtio_net.c           |  1 +
 drivers/scsi/virtio_scsi.c         |  1 +
 drivers/virtio/virtio_pci_common.c | 49 ++++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  7 +++-
 drivers/virtio/virtio_pci_legacy.c |  5 ++-
 drivers/virtio/virtio_pci_modern.c |  6 ++-
 drivers/virtio/virtio_ring.c       | 60 +++++++++++++++++++++++++++++-
 include/linux/virtio.h             |  3 ++
 include/linux/virtio_config.h      |  6 +++
 11 files changed, 162 insertions(+), 31 deletions(-)

-- 
2.25.1

