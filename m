Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9810843BF90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhJ0CX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhJ0CXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XpwYAisWYsf21qlcW1bsvTshKwDSaTc83jJhCK0mOdE=;
        b=SFskRLsaOZTWKnO7TlxDrZIxV1Jrip6/bg1B9CK8wdnOWcM42iOZrfEv/t4hqbhurHd+cZ
        2uLkkk2JQuEgCa2E3PI+137wsfHze/pZz+E/x8IeRY8MebaWFQi7C4L7OImx+NkiJWaU6Y
        POS7BnLlFd+EIbf/DWS+GGLJBLK+aZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-fEDNFWLENaOqSG6HSfv9fw-1; Tue, 26 Oct 2021 22:21:25 -0400
X-MC-Unique: fEDNFWLENaOqSG6HSfv9fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10FB68026AD;
        Wed, 27 Oct 2021 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-228.pek2.redhat.com [10.72.13.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044CC19729;
        Wed, 27 Oct 2021 02:21:14 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 0/4] Validate used buffer length
Date:   Wed, 27 Oct 2021 10:21:03 +0800
Message-Id: <20211027022107.14357-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This patch tries to validate the used buffer length in the virtio
core. This help to eliminate the unexpected result caused by buggy or
mailicous devices. For the drivers that can do the validation itself,
they can ask the virtio core to suppress the check.

Changes since V4:

- Fix the out of date description in the commit log

Changes since V3:

- Initialize the buflen to zero when the validation is done by the
  driver.

Jason Wang (4):
  virtio_ring: validate used buffer length
  virtio-net: don't let virtio core to validate used length
  virtio-blk: don't let virtio core to validate used length
  virtio-scsi: don't let virtio core to validate used buffer length

 drivers/block/virtio_blk.c   |  1 +
 drivers/net/virtio_net.c     |  1 +
 drivers/scsi/virtio_scsi.c   |  1 +
 drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 5 files changed, 65 insertions(+)

-- 
2.25.1

