Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08B33225D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBWGWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbhBWGUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614061158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iD5VZEbLGdRDyqWEmS8M17jSN2GBbzyhJ7LgE67oj7Y=;
        b=JphvFBO7uPSG9Pi6ggYgB+rVXbtW5I2BQ1z9VuS5WV09HcgoAWZHvRWOf/ZqpGfhyZdLhI
        GEdMK6icA8MKUnv49encSl+N3oYr8RC6RXXhG4aPzZGSI2xTb9c99heouX66RCzq9UR/F2
        M+qtvYiiQwpmkoZsqw0jz+Uw38BsnTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-MyeH8IcNOTaHgI71nW5BqA-1; Tue, 23 Feb 2021 01:19:15 -0500
X-MC-Unique: MyeH8IcNOTaHgI71nW5BqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0DD81020C20;
        Tue, 23 Feb 2021 06:19:13 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-6.pek2.redhat.com [10.72.13.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3B955D9D0;
        Tue, 23 Feb 2021 06:19:07 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        sgarzare@redhat.com, rdunlap@infradead.org
Subject: [PATCH V4 0/3] virtio-pci: introduce modern device module
Date:   Tue, 23 Feb 2021 14:19:02 +0800
Message-Id: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to implement a vDPA driver for virtio-pci device
which will bridge between vDPA bus and virtio-pci device.

This could be used for future feature prototyping and testing.

Please review

Changes since V4:
- include the patch to let VIRTIO_PCI_LIB to be auto selected
- style fixes in the Kconfig for vp-vdpa driver
- fix the err value returned during vp-vdpa driver probing

Changes since V3:
- rebase to vhost.git

Changes since V2:

- tweak config prompt
- switch from 'cb' to 'config_cb' for vp_vdpa config interrupt
- use a macro for vp_vdpa msix name length

Changes since V1:

- don't try to use devres for virtio-pci core
- tweak the commit log
- split the patches furtherly to ease the reviewing

Changes since RFC:

- Split common codes from virito-pci and share it with vDPA driver
- Use dynamic id in order to be less confusing with virtio-pci driver
- No feature whitelist, supporting any features (mq, config etc)

Jason Wang (3):
  virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
  vdpa: set the virtqueue num during register
  vdpa: introduce virtio pci driver

 drivers/vdpa/Kconfig                 |   7 +
 drivers/vdpa/Makefile                |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c      |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   4 +-
 drivers/vdpa/vdpa.c                  |  18 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +-
 drivers/vdpa/virtio_pci/Makefile     |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 458 +++++++++++++++++++++++++++
 drivers/virtio/Kconfig               |  11 +-
 drivers/virtio/Makefile              |   2 +-
 include/linux/vdpa.h                 |  10 +-
 12 files changed, 496 insertions(+), 26 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

-- 
2.25.1

