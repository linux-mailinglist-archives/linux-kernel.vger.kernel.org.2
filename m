Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540B543BF99
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhJ0CYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237935AbhJ0CX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uja7m66OQ8RhYU+vAO++rPLkxu0xATaaUuXmeqidL70=;
        b=fH/MUy3otad/Iu0Ii4L7/D8XeR1iFY3Iq6qKEYyE9s+yfI301Nj1U3GU4kECAOl7EI0zQ4
        qXP8z05OQsxB4kq6u4Wx9TKQBmnGAGjYDsHvwY1afhwbVo76e9OpAqHSarmORsl3ki3AYp
        05SbbQoFQXvjsDQkWcAE5GUCzm8IenM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-mJaZiSy6M7G3vgcruUJAiA-1; Tue, 26 Oct 2021 22:21:31 -0400
X-MC-Unique: mJaZiSy6M7G3vgcruUJAiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5109E802B61;
        Wed, 27 Oct 2021 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-228.pek2.redhat.com [10.72.13.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7FD61972E;
        Wed, 27 Oct 2021 02:21:27 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 2/4] virtio-net: don't let virtio core to validate used length
Date:   Wed, 27 Oct 2021 10:21:05 +0800
Message-Id: <20211027022107.14357-3-jasowang@redhat.com>
In-Reply-To: <20211027022107.14357-1-jasowang@redhat.com>
References: <20211027022107.14357-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RX virtuqueue, the used length is validated in all the three paths
(big, small and mergeable). For control vq, we never tries to use used
length. So this patch forbids the core to validate the used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6d8c8745bf24..7c43bfc1ce44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3385,6 +3385,7 @@ static struct virtio_driver virtio_net_driver = {
 	.feature_table_size = ARRAY_SIZE(features),
 	.feature_table_legacy = features_legacy,
 	.feature_table_size_legacy = ARRAY_SIZE(features_legacy),
+	.suppress_used_validation = true,
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
-- 
2.25.1

