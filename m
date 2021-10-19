Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D5432EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhJSHGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234449AbhJSHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634627067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAoed0TlymdDK6yxLlqdU8RCkJqMYSQ3RIZ5RobLy1I=;
        b=DKKLOKCJZZXeASz/2Rgw1b+gtuIeahKtKw5sgUu4vu/A+1UwYZfxhM4pNSRG2ZOaPr0PeV
        1F7+CNEL4x2rVs5MuKvC+n/2+8D/3r6mI/Z8jkEnY9xMhaa/gHjf43rbD0pkx444gfA2mf
        +fQh7T6f0MITXBU5V3bhIzGOCEpXMRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-wmVQgNjUNDuYd4mb_aUJgg-1; Tue, 19 Oct 2021 03:04:23 -0400
X-MC-Unique: wmVQgNjUNDuYd4mb_aUJgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B8861023F4E;
        Tue, 19 Oct 2021 07:04:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85F18707B6;
        Tue, 19 Oct 2021 07:04:10 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V3 08/10] virtio-net: don't let virtio core to validate used length
Date:   Tue, 19 Oct 2021 15:01:50 +0800
Message-Id: <20211019070152.8236-9-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 79bd2585ec6b..6a8b52aed05f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3384,6 +3384,7 @@ static struct virtio_driver virtio_net_driver = {
 	.feature_table_size = ARRAY_SIZE(features),
 	.feature_table_legacy = features_legacy,
 	.feature_table_size_legacy = ARRAY_SIZE(features_legacy),
+	.suppress_used_validation = true,
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
-- 
2.25.1

