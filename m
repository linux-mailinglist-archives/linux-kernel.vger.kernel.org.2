Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE24334B0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCZUkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:40:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230514AbhCZUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616791214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HZw8++24B7zDhpssFCjAM4DVt+/nSr9Onctlnz9S1EI=;
        b=HiJVdT3TJjEUAbtrLnicIm4KYKdNIdlTuin1ju/et9vWB/uuzVWt7Q8J53WCzrarJWH5aQ
        IuSQ8O507L+779Q5LJhDnzv7I5s4VM6DG0ibNHUMF4vqfXAbzI/Qpw3lnADdoUH30WSFx4
        u/nKykVOY5a32bA8Y2A0z0VkOMLZGnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-NfKr5OOVPV6H7ThAZngMZg-1; Fri, 26 Mar 2021 16:40:11 -0400
X-MC-Unique: NfKr5OOVPV6H7ThAZngMZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A5A801FD8;
        Fri, 26 Mar 2021 20:40:10 +0000 (UTC)
Received: from Whitewolf.lyude.net (ovpn-114-133.rdu2.redhat.com [10.10.114.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2795F5DAA5;
        Fri, 26 Mar 2021 20:40:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 19/20] drm/dp_mst: Drop DRM_ERROR() on kzalloc() fail in drm_dp_mst_handle_up_req()
Date:   Fri, 26 Mar 2021 16:38:06 -0400
Message-Id: <20210326203807.105754-20-lyude@redhat.com>
In-Reply-To: <20210326203807.105754-1-lyude@redhat.com>
References: <20210326203807.105754-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch was complaining about this - there's no need for us to print
errors when kzalloc() fails, as kzalloc() will already WARN for us. So,
let's fix that before converting things to make checkpatch happy.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ec2285595c33..74c420f5f204 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4113,10 +4113,9 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
 		return 0;
 
 	up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
-	if (!up_req) {
-		DRM_ERROR("Not enough memory to process MST up req\n");
+	if (!up_req)
 		return -ENOMEM;
-	}
+
 	INIT_LIST_HEAD(&up_req->next);
 
 	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
-- 
2.30.2

