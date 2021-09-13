Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC9408426
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbhIMFzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhIMFza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AqQeD+f+oItxNYfqqoj5btjWDgTgn+kqnSoqgYIP1to=;
        b=Mi4UijeapYXfwmjlBVAl4Qo7ygKWwpjNyzJ7+x2ApSQKglZWWrqVxAX43/9uidMr4v3wSI
        UQ3+wkDicFxlmAjJq3tM72sCiDWBBn87UyBx1Ap9yn7CJO/+YQgko2orxHGuwelJSAnlxz
        Giju0juquV/mjLpRvPMJnsRRcRlzNyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-8XlGAqqHPTq6Fk8PecF34A-1; Mon, 13 Sep 2021 01:54:12 -0400
X-MC-Unique: 8XlGAqqHPTq6Fk8PecF34A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC23C81431D;
        Mon, 13 Sep 2021 05:54:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD7615C25A;
        Mon, 13 Sep 2021 05:53:58 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH 0/9] More virtio hardening
Date:   Mon, 13 Sep 2021 13:53:44 +0800
Message-Id: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Smoking test on blk/net with packed=on/off and iommu_platform=on/off.

Please review.

Thanks

Jason Wang (9):
  virtio-blk: validate num_queues during probe
  virtio: add doc for validate() method
  virtio-console: switch to use .validate()
  virtio_console: validate max_nr_ports before trying to use it
  virtio_config: introduce a new ready method
  virtio_pci: harden MSI-X interrupts
  virtio-pci: harden INTX interrupts
  virtio_ring: fix typos in vring_desc_extra
  virtio_ring: validate used buffer length

 drivers/block/virtio_blk.c         |  3 +-
 drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
 drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  7 ++--
 drivers/virtio/virtio_pci_legacy.c |  5 +--
 drivers/virtio/virtio_pci_modern.c |  6 ++--
 drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
 include/linux/virtio.h             |  1 +
 include/linux/virtio_config.h      |  6 ++++
 9 files changed, 118 insertions(+), 31 deletions(-)

-- 
2.25.1

