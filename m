Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24D3D20F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGVItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhGVItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:49:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FCDC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:17 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso4657678pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bWqoW1zaypI6FiOc+rFvxYhfwSyGe+LXhfGXUAMjokM=;
        b=q3mxk07wkguCFJ+lpuERPHN7UiaEpdxTgOavixSsHfPNPXKFiLSITtuEeLIwPZRjU7
         s42Q87ZjcaNTrLRJw+tOZoIdFlCwLflimzejiOKT9gyMkMLpthTiHeFKzQnJDsELOScM
         PtdXIj1ZZXVu3ZM9M3OBzrwO6lugRjWibip1gEsqKagfac6tObLaddc0jIOPyn0rQ/2Q
         SqIn/SBaRCLr760Fo23EQiVBqg1WabAQZKzLW5+nyHPy0emWxNaaJxxmEC5IAWoOYBMb
         2w3ZGx0JEfCUFSrEa95ldc/WJZLAJYcicWU1cZ6niVobKKGPIESb53bReRPgOoJoRBug
         if1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWqoW1zaypI6FiOc+rFvxYhfwSyGe+LXhfGXUAMjokM=;
        b=VO95yx0IyH2Sm6Va1GicJVA8bjKz/5GoFFi9Xpq4nUAXFR37ZBRGOCGKqgPNK3YwyL
         4LKVlHydXZ5/CvRQiB7pv5+ekrv3ANPPSLaQXjpto/N7aN2zLud1mNU/GD63n7MjWl6b
         6IWWq1rIiY8bIq5uOoOtYoPSevomMXltBm7gysuVMBInCE/e4+2X77HmXeVOsElNuACS
         xuDLvvtTFigRX3rfbCUswRYuLoA6/DL1z88YN2nOgj/zSklS1YZSA7OZExSRnYS2XeUm
         1Y+ZAOr9sagAFJS+JdmYnRme3jA1GANucXABOR9CAY7dieEhmgzPCKDocYkBaIJV4Rt+
         slnQ==
X-Gm-Message-State: AOAM533s/Tm8u/tMrsdOM6Dhuo+OaEAK6ILVCAXP5LESkMigIGbmYOpC
        qwXlrSTgomU6nwv2vf63ZAk=
X-Google-Smtp-Source: ABdhPJzLwTR8vmDcr35rGyIbAv/nAj71D9TVKb48nTd5YFXyi6D7zffA6NSixOLxJopmOo9LLz5PwA==
X-Received: by 2002:a63:cd4b:: with SMTP id a11mr21260014pgj.273.1626946216859;
        Thu, 22 Jul 2021 02:30:16 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q5sm1069592pjo.7.2021.07.22.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 02:30:16 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     linux-graphics-maintainer@vmware.com, zackr@vmware.com,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/3] drm: clarify lifetime/locking for drm_master's lease fields
Date:   Thu, 22 Jul 2021 17:29:28 +0800
Message-Id: <20210722092929.244629-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722092929.244629-1-desmondcheongzx@gmail.com>
References: <20210722092929.244629-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In particular, we make it clear that &drm_device.mode_config.idr_mutex
protects the lease idr and list structures for drm_master. The lessor
field itself doesn't need to be protected as it doesn't change after
it's set in drm_lease_create.

Additionally, we add descriptions for the lifetime of lessors and
leases to make it easier to reason about them.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 include/drm/drm_auth.h | 62 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
index f99d3417f304..c978c85464fa 100644
--- a/include/drm/drm_auth.h
+++ b/include/drm/drm_auth.h
@@ -58,12 +58,6 @@ struct drm_lock_data {
  * @refcount: Refcount for this master object.
  * @dev: Link back to the DRM device
  * @driver_priv: Pointer to driver-private information.
- * @lessor: Lease holder
- * @lessee_id: id for lessees. Owners always have id 0
- * @lessee_list: other lessees of the same master
- * @lessees: drm_masters leasing from this one
- * @leases: Objects leased to this drm_master.
- * @lessee_idr: All lessees under this owner (only used where lessor == NULL)
  *
  * Note that master structures are only relevant for the legacy/primary device
  * nodes, hence there can only be one per device, not one per drm_minor.
@@ -88,17 +82,63 @@ struct drm_master {
 	struct idr magic_map;
 	void *driver_priv;
 
-	/* Tree of display resource leases, each of which is a drm_master struct
-	 * All of these get activated simultaneously, so drm_device master points
-	 * at the top of the tree (for which lessor is NULL). Protected by
-	 * &drm_device.mode_config.idr_mutex.
+	/**
+	 * @lessor:
+	 *
+	 * Lease holder. The lessor does not change once it's set in
+	 * drm_lease_create(). Each lessee holds a reference to its lessor that
+	 * it releases upon being destroyed in drm_lease_destroy().
+	 *
+	 * Display resource leases form a tree of &struct drm_master. All of
+	 * these get activated simultaneously, so &drm_device.master
+	 * points at the top of the tree (for which lessor is NULL).
 	 */
-
 	struct drm_master *lessor;
+
+	/**
+	 * @lessee_id:
+	 *
+	 * ID for lessees. Owners always have ID 0. Protected by
+	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 */
 	int	lessee_id;
+
+	/**
+	 * @lessee_list:
+	 *
+	 * List of lessees of the same master. Protected by
+	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 */
 	struct list_head lessee_list;
+
+	/**
+	 * @lessees:
+	 *
+	 * List of drm_masters leasing from this one. Protected by
+	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 *
+	 * This master cannot be destroyed unless this list is empty as lessors
+	 * are referenced by all their lessees.
+	 */
 	struct list_head lessees;
+
+	/**
+	 * @leases:
+	 *
+	 * Objects leased to this drm_master. Protected by
+	 * &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 *
+	 * Objects are leased all together in drm_lease_create(), and are
+	 * removed all together when the lease is revoked.
+	 */
 	struct idr leases;
+
+	/**
+	 * @lessee_idr:
+	 *
+	 * All lessees under this owner (only used where lessor is NULL).
+	 * Protected by &drm_device.mode_config's &drm_mode_config.idr_mutex.
+	 */
 	struct idr lessee_idr;
 	/* private: */
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
-- 
2.25.1

