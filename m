Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE441C030
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbhI2H7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244268AbhI2H72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632902267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=80pWgN3KKsrMm8H11ftmkOTPTDACzxOkzP/ByHdpMSI=;
        b=UgxkV29EIqGQwAVn9hF8g82oEF32gL0UCasjnCRkuonmK2c2+4gDn6jD4hzo1QMPXty+44
        mOpvA24z5t7GB/ULT5jPuCLmeeYzbrG25U3Nibkcf4F3XZUq0L5eup0QrXhel6EGGlFRCg
        nFJunFA8TsM4OYopPRmz8kgV8yQENOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-UCm1cZDQPwK7iKF0Lnxicw-1; Wed, 29 Sep 2021 03:57:43 -0400
X-MC-Unique: UCm1cZDQPwK7iKF0Lnxicw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B94684A5E0;
        Wed, 29 Sep 2021 07:57:42 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-131.pek2.redhat.com [10.72.13.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E2F060583;
        Wed, 29 Sep 2021 07:57:25 +0000 (UTC)
From:   Cindy Lu <lulu@redhat.com>
To:     lulu@redhat.com, mst@redhat.com, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vhost-vdpa:fix the worng input in config_cb
Date:   Wed, 29 Sep 2021 15:54:37 +0800
Message-Id: <20210929075437.12985-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the worng input in for config_cb,
in function vhost_vdpa_config_cb, the input
cb.private was used as struct vhost_vdpa,
So the inuput was worng here, fix this issue

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 942666425a45..e532cbe3d2f7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -322,7 +322,7 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 	struct eventfd_ctx *ctx;
 
 	cb.callback = vhost_vdpa_config_cb;
-	cb.private = v->vdpa;
+	cb.private = v;
 	if (copy_from_user(&fd, argp, sizeof(fd)))
 		return  -EFAULT;
 
-- 
2.21.3

