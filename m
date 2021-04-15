Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE35360364
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhDOHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhDOHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8h+eVsApPwBeDOfwNE+ao4JuJ0Rk8cCsn+lmickkPFg=;
        b=GQaPKPSpmiRhAOmY/1SUrucI1zX3aDD9bimvk3eRxD6qv0W1BuZAv3ZZtBFa6fyslmIepU
        Rrjl/qs9oAGT++HeMyEQ51BlOYZItFlQJWhIPs0lCibuDbyNYbAq+/VISTx+8UTFPU0F/U
        UxmliEh76ETJosu13fOycmsZj3Pric0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-wR6ZR7f9M8eeLo2f16wgWw-1; Thu, 15 Apr 2021 03:31:57 -0400
X-MC-Unique: wR6ZR7f9M8eeLo2f16wgWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB01817477;
        Thu, 15 Apr 2021 07:31:56 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC626064B;
        Thu, 15 Apr 2021 07:31:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com
Subject: [PATCH 0/7] Doorbell mapping support for virito-pci vDPA
Date:   Thu, 15 Apr 2021 03:31:40 -0400
Message-Id: <20210415073147.19331-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series implements the doorbell mapping support for virtio-pci
vDPA driver. Tested with page-per-vq=on in a nested guest.

Please review

Thanks

Jason Wang (7):
  virtio_pci_modern: introduce helper to map vq notify area
  virtio-pci library: switch to use vp_modern_map_vq_notify()
  vp_vdpa: switch to use vp_modern_map_vq_notify()
  virtio_pci_modern: hide vp_modern_get_queue_notify_off()
  virito_pci libray: hide vp_modern_map_capability()
  virtio-pci library: report resource address
  vp_vdpa: report doorbell address

 drivers/vdpa/virtio_pci/vp_vdpa.c      | 26 ++++++++--
 drivers/virtio/virtio_pci_modern.c     | 27 +---------
 drivers/virtio/virtio_pci_modern_dev.c | 68 +++++++++++++++++++++-----
 include/linux/virtio_pci_modern.h      | 11 ++---
 4 files changed, 83 insertions(+), 49 deletions(-)

-- 
2.18.1

