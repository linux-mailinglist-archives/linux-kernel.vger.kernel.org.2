Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40BF370389
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhD3Wfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230226AbhD3Wfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619822089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpm0s98PPk+LRziQ39f8+GcKnbjyOFaJ1uQAUz/hEno=;
        b=ZGeaLFfTazn/8jdnnPUfIoTV5VB7qWxwtU5yBelTqPCJlWtifrJZvDMlrX4jNnN1NpG1ox
        vO8AnJHG1omPTu4avWd/5p/rz/+KxdHsV/s0w8CMDZEQlMJYSmlWR16g/THjBDApKJNcp8
        2cGLN2xuQddF/kmEtEXaCFfHYp3kLcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-qEtSHmXMMH6ql5ukG17RhA-1; Fri, 30 Apr 2021 18:34:47 -0400
X-MC-Unique: qEtSHmXMMH6ql5ukG17RhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3352107ACCA;
        Fri, 30 Apr 2021 22:34:45 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-112-36.rdu2.redhat.com [10.10.112.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1E85D719;
        Fri, 30 Apr 2021 22:34:44 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/dp: Drop open-coded drm_dp_is_branch() in drm_dp_read_downstream_info()
Date:   Fri, 30 Apr 2021 18:34:28 -0400
Message-Id: <20210430223428.10514-2-lyude@redhat.com>
In-Reply-To: <20210430223428.10514-1-lyude@redhat.com>
References: <20210430223428.10514-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while fixing another issue in drm_dp_read_downstream_info(),
the open coded DP_DOWNSTREAMPORT_PRESENT check here just duplicates what we
already do in drm_dp_is_branch(), so just get rid of it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 27c8c5bdf7d9..0f84df8798ab 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -677,9 +677,7 @@ int drm_dp_read_downstream_info(struct drm_dp_aux *aux,
 	memset(downstream_ports, 0, DP_MAX_DOWNSTREAM_PORTS);
 
 	/* No downstream info to read */
-	if (!drm_dp_is_branch(dpcd) ||
-	    dpcd[DP_DPCD_REV] < DP_DPCD_REV_10 ||
-	    !(dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DWN_STRM_PORT_PRESENT))
+	if (!drm_dp_is_branch(dpcd) || dpcd[DP_DPCD_REV] < DP_DPCD_REV_10)
 		return 0;
 
 	/* Some branches advertise having 0 downstream ports, despite also advertising they have a
-- 
2.30.2

