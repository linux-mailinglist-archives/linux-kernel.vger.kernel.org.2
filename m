Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A387C43A690
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhJYWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 18:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232481AbhJYWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 18:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635201047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5v1Na7JVt3wuBUYr9NpLnaa0AfB+WKs9SYn9cUM/6Y=;
        b=FpaFpKd+ePPONccPqT8W6aYVdyHhE0DbBo0bFYkXSoe48ShOFnc0AMo7EVxN6Wm7TedV+3
        cXCAlY1bv9bTGz2tRxb80522LbdFYAkMPAXZB6/tz1ntGMnMhOM5z4kS8FFXruESB8eBr2
        EO+/JAbmURvf6U5LtlyNvdxfmlfLYPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-kH7UdcD2PI-u5YNilT0_Vw-1; Mon, 25 Oct 2021 18:30:41 -0400
X-MC-Unique: kH7UdcD2PI-u5YNilT0_Vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B9C818D6A25;
        Mon, 25 Oct 2021 22:30:40 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.9.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73BF55DD68;
        Mon, 25 Oct 2021 22:30:38 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amdgfx@lists.freedesktop.org
Cc:     Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/4] drm: Remove slot checks in dp mst topology during commit
Date:   Mon, 25 Oct 2021 18:30:25 -0400
Message-Id: <20211025223029.300891-2-lyude@redhat.com>
In-Reply-To: <20211025223029.300891-1-lyude@redhat.com>
References: <20211025223029.300891-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

This code path is used during commit, and we dont expect things to fail
during the commit stage, so remove this.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 86d13d6bc463..04ed34a7f71c 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4334,10 +4334,6 @@ static int drm_dp_init_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 {
 	int ret;
 
-	/* max. time slots - one slot for MTP header */
-	if (slots > 63)
-		return -ENOSPC;
-
 	vcpi->pbn = pbn;
 	vcpi->aligned_pbn = slots * mgr->pbn_div;
 	vcpi->num_slots = slots;
@@ -4540,7 +4536,7 @@ bool drm_dp_mst_allocate_vcpi(struct drm_dp_mst_topology_mgr *mgr,
 
 	ret = drm_dp_init_vcpi(mgr, &port->vcpi, pbn, slots);
 	if (ret) {
-		drm_dbg_kms(mgr->dev, "failed to init vcpi slots=%d max=63 ret=%d\n",
+		drm_dbg_kms(mgr->dev, "failed to init vcpi slots=%d ret=%d\n",
 			    DIV_ROUND_UP(pbn, mgr->pbn_div), ret);
 		drm_dp_mst_topology_put_port(port);
 		goto out;
-- 
2.31.1

