Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBC32047F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 03:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhBTIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 03:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613810800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zORzgLNQwO5lxbztLsKp7s13i+nOx6UmKJ+iNn0Boxc=;
        b=Cw9+DCL/fOEsOCkERx8mb0q5GQgmTdipba4DvsvCb9if9ql11gvha7xy0jyn27Z0gPyZ8Q
        NS3VpUYyBJ9h+qMCAF4+MAjS+/XXAjDDbBgHkAdO8gHCK2g7oIkWbawoB0u9yKZexoRyZt
        QVsaO0ECvcHBPEke4/U4gpHMNp2Hu7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-kqJb9T8HOgCKf66ficOnWw-1; Sat, 20 Feb 2021 03:46:38 -0500
X-MC-Unique: kqJb9T8HOgCKf66ficOnWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 893AB803F4B;
        Sat, 20 Feb 2021 08:46:37 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8F4E60C04;
        Sat, 20 Feb 2021 08:46:31 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: [PATCH V4 0/2] virtio-pci: introduce modern device module
Date:   Sat, 20 Feb 2021 16:46:27 +0800
Message-Id: <20210220084629.282432-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This series tries to implement a vDPA driver for virtio-pci device
which will bridge between vDPA bus and virtio-pci device.

This could be used for future feature prototyping and testing.

Please review

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

Jason Wang (2):
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
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 456 +++++++++++++++++++++++++++
 include/linux/vdpa.h                 |  10 +-
 10 files changed, 487 insertions(+), 20 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

-- 
2.25.1

