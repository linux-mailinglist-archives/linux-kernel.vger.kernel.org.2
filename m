Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0157432ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhJSHEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234304AbhJSHE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634626936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sXWkpo3FdYBYbtFH/ABAUaAY4xibdiaBDtN9P+YJybM=;
        b=SxLn0HXrF7Jo6W1Rn7XfzLhoGwRpAK5OUBtgboRtojckzSZLzyrn1GOmcnAIzDxosDGhaj
        AziLeyVCUTJw/4oZZwXdrEBbEridDU9XPAeMsq1c8UTRB8vXaqaYJO577erg2T2Lr8r2bo
        2Lp0NHC1kCQjm4jVdIP91ggVGrKlqRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-agg0bTQ3Pf-sN9zA7OsrEQ-1; Tue, 19 Oct 2021 03:02:13 -0400
X-MC-Unique: agg0bTQ3Pf-sN9zA7OsrEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C55EB80A5C9;
        Tue, 19 Oct 2021 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D84970956;
        Tue, 19 Oct 2021 07:01:54 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V3 00/10] More virtio hardening
Date:   Tue, 19 Oct 2021 15:01:42 +0800
Message-Id: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series treis to do more hardening for virito.

patch 1 validates the num_queues for virio-blk device.
patch 2 validates max_nr_ports for virito-console device.
patch 3-5 harden virtio-pci interrupts to make sure no exepcted
interrupt handler is tiggered. If this makes sense we can do similar
things in other transport drivers.
patch 6-7 validate used ring length.
patch 8-10 let the driver to validate the used length instead of the
virtio core when possible.

Smoking test on blk/net with packed=on/off and iommu_platform=on/off.

Please review.

Changes since V2:
- don't validate max_nr_ports in .validate()
- fail the probe instead of trying to work when blk/console returns
  invalid number of queues/ports
- use READ_ONCE() instead of smp_load_acquire() for checking
  intx_soft_enabled
- use "suppress_used_validation" instead of "validate_used"

Changes since V1:
- fix and document the memory ordering around the intx_soft_enabled
  when enabling and disabling INTX interrupt
- for the driver that can validate the used length, virtio core
  won't even try to allocate auxilary arrays and validate the used length
- tweak the commit log
- fix typos

Jason Wang (10):
  virtio-blk: validate num_queues during probe
  virtio_console: validate max_nr_ports before trying to use it
  virtio_config: introduce a new .enable_cbs method
  virtio_pci: harden MSI-X interrupts
  virtio-pci: harden INTX interrupts
  virtio_ring: fix typos in vring_desc_extra
  virtio_ring: validate used buffer length
  virtio-net: don't let virtio core to validate used length
  virtio-blk: don't let virtio core to validate used length
  virtio-scsi: don't let virtio core to validate used buffer length

 drivers/block/virtio_blk.c         |  5 +++
 drivers/char/virtio_console.c      |  9 +++++
 drivers/net/virtio_net.c           |  1 +
 drivers/scsi/virtio_scsi.c         |  1 +
 drivers/virtio/virtio_pci_common.c | 48 ++++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  7 +++-
 drivers/virtio/virtio_pci_legacy.c |  5 ++-
 drivers/virtio/virtio_pci_modern.c |  6 ++-
 drivers/virtio/virtio_ring.c       | 60 +++++++++++++++++++++++++++++-
 include/linux/virtio.h             |  2 +
 include/linux/virtio_config.h      |  6 +++
 11 files changed, 135 insertions(+), 15 deletions(-)

-- 
2.25.1

