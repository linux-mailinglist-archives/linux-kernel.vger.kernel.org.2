Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6CC43AD10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhJZHWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233077AbhJZHWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635232810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3b0+Kh5GhdCTKf3DqTlQfiS/ku1LnxpLvlQPIU6Uwf8=;
        b=XgySHiCFeQxPbpu4kLJPCKnY1T9sMWGiHEpXXVW3TrwkLMZOF3AZga/W0wZCQ0kY7j14py
        u+EmTwHiJ6gI0Q9sGoMirHNFGtJN1EBn9w4aEmPCIht8r4fph9joRdNoBkHkwHS95zEM12
        iTxJGelae7OicDHBF2/rr5+Cuh8+dPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-M5wM4iRfOneqbJxZiDHdLw-1; Tue, 26 Oct 2021 03:20:09 -0400
X-MC-Unique: M5wM4iRfOneqbJxZiDHdLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34645074B;
        Tue, 26 Oct 2021 07:20:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F70519C79;
        Tue, 26 Oct 2021 07:20:04 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 0/4] Validate used buffer length
Date:   Tue, 26 Oct 2021 15:19:56 +0800
Message-Id: <20211026072000.8699-1-jasowang@redhat.com>
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

Changes since V3:

- Initialize the buflen to zero when the validation is done by the driver.

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

