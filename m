Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B18432EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhJSHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234469AbhJSHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634627074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jDUxMJIQblVWX+exZQfHW/3h1Wf0cvLtDt87iczI3gQ=;
        b=KH7P4YrMAszvrzijypZfsKJ+Hxt1NVzh8WrAxuzHYDgRBSLbbMNXSVZ7bcrZgdmUHUvq9e
        o8e33DeswtE0+BWU8eoM2MUHJzINkVlK5OWhFDj/V0l5W5wwMa761VTJmlHAiFzYsZwyup
        3RBs3jhceowkjNowTV71Yb10EVpF9MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-bjnOU663OTypF7ZNG_xhyg-1; Tue, 19 Oct 2021 03:04:31 -0400
X-MC-Unique: bjnOU663OTypF7ZNG_xhyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BC7780A5C4;
        Tue, 19 Oct 2021 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B02670956;
        Tue, 19 Oct 2021 07:04:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V3 09/10] virtio-blk: don't let virtio core to validate used length
Date:   Tue, 19 Oct 2021 15:01:51 +0800
Message-Id: <20211019070152.8236-10-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never tries to use used length, so the patch prevents the virtio
core from validating used length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 10bc0879e618..6f19dcb7c3aa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1010,6 +1010,7 @@ static struct virtio_driver virtio_blk = {
 	.feature_table_size		= ARRAY_SIZE(features),
 	.feature_table_legacy		= features_legacy,
 	.feature_table_size_legacy	= ARRAY_SIZE(features_legacy),
+	.suppress_used_validation	= true,
 	.driver.name			= KBUILD_MODNAME,
 	.driver.owner			= THIS_MODULE,
 	.id_table			= id_table,
-- 
2.25.1

