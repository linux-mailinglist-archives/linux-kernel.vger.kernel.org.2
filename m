Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84143AD12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhJZHWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 03:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233693AbhJZHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 03:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635232817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uja7m66OQ8RhYU+vAO++rPLkxu0xATaaUuXmeqidL70=;
        b=OoKDys23QMLIoErAv9k3io+R61PkRCQj59luh7L2nrhahJoUqBvUH1d4Y9lVwdT6gEoRVl
        dEtm1zfN/KQomXaZOvHivsddBrNGB1ShwevnfKbcQmB9qTQ2zjhh8/v9OV4XVsr3VbPenV
        s41rV5wfD0OwWUwL4/wRR7i96XNHXII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-1K8_92oDPu2t3BuISeN73A-1; Tue, 26 Oct 2021 03:20:15 -0400
X-MC-Unique: 1K8_92oDPu2t3BuISeN73A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB4610A8E01;
        Tue, 26 Oct 2021 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3EE919C79;
        Tue, 26 Oct 2021 07:20:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 2/4] virtio-net: don't let virtio core to validate used length
Date:   Tue, 26 Oct 2021 15:19:58 +0800
Message-Id: <20211026072000.8699-3-jasowang@redhat.com>
In-Reply-To: <20211026072000.8699-1-jasowang@redhat.com>
References: <20211026072000.8699-1-jasowang@redhat.com>
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

