Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E133D546F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhGZG5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:57:01 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:64579 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232215AbhGZG5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627285049; x=1658821049;
  h=from:to:cc:subject:date:message-id;
  bh=Lh2f00DCc0ETiBTHPeQX7NKdVsdgCnvj5dVGpBGcjVU=;
  b=XiL5aUr7t7Z4zd+r2TRAoNPvQyI1fo+zxoXRjafcjF+LlsY6D7UFYDQ0
   MqwRYPPL7TKgUbTW6A2t2whGVPanQBM0E8FKLiA25QcJTWHdh5JNgd4OG
   lNni82ZzBhJlSAfznS/q4w1I3+oCHyUcs0IAytv0UFDMxI0OskbWq5i9B
   K7zc/OiY0fqXu/EODxAfslH/yV8ByC0ocdncoZSK+7YBl6S1NM/bxiJMg
   DTJvJdgO98AITKIed2aPOs8cJLm8ZMxupGAK6wuFfnwyWYl4xmrGRcipw
   rag56GxDIzPVltipzoMGXscGEihHNDm0GQHjNYBhn5W6SrZ88YXgEKUQP
   w==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18631660"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jul 2021 09:37:28 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 26 Jul 2021 09:37:28 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 26 Jul 2021 09:37:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627285048; x=1658821048;
  h=from:to:cc:subject:date:message-id;
  bh=Lh2f00DCc0ETiBTHPeQX7NKdVsdgCnvj5dVGpBGcjVU=;
  b=KSEDPBK1x5qZlk4SBr4Re9qZsohG9L9ksXoXFp2N/ERqMSPOLyza5P05
   7NjGfUAxK+10PEFdOhrD9DSi1hHf/oXRVSyAefGK+F4zmrcS2dzhVZMnL
   mHrEVp4yEDTZ35d1A7dK+HUgpAsjskMvRh4SIuSphU927jOLEfhQw3nKl
   FYUC6UTbWLEDVVtBl7YDrOMHseDDiELOyTUGQEEVECJ81kijh3tpo6VTW
   t459InA0t3ayDqIWgoytCEPZ5wbAxtHUbyPuhMTvAJj7AlW8gSFhKrsAf
   qfCW2GXV0skBrHmPfOvWCPSYHJXN4La0XIurIR9sQndtqV9tDLIQ5CLvo
   g==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18631659"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jul 2021 09:37:28 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 0BDE1280070;
        Mon, 26 Jul 2021 09:37:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] regmap: do not call regmap_debugfs_init() from regmap_attach_dev()
Date:   Mon, 26 Jul 2021 09:36:27 +0200
Message-Id: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_debugfs_init() should never be called twice for the same regmap,
as it initializes various fields of the regmap struct, including list
heads and mutices. A visible symptom are messages like:

    debugfs: Directory 'dummy-iomuxc-gpr@20e4000' with parent 'regmap'
    already present!

This happened whenever regmap_attach_dev() was called for an existing
regmap. Remove the call from regmap_attach_dev() and change
__regmap_init() so that regmap_debugfs_init() is called exactly once.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Fixes: 9b947a13e7f6 ("regmap: use debugfs even when no device")
---
 drivers/base/regmap/regmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)


As mentioned in my previous mail [1], I believe that the duplicate call to
regmap_debugfs_init() is not the only issue with regmap_attach_dev().

Every single user of regmap_attach_dev() outside of __regmap_init() is
using it to attach a device to a syscon regmap obtained using one of the
syscon_*() functions. AIUI, syscon regmaps do not belong to a single
device, so calling regmap_attach_dev() seems wrong to me. My (possibly
lacking) understanding of the semantics aside, the fact that
regmap_attach_dev() is setting fields on the shared regmap without any
kind of locking is at least suspicious.

Maybe regmap_attach_dev() shouldn't be exported from the regmap code at
all, removing all calls to the functions from drivers?


[1] https://lkml.org/lkml/2021/7/19/500


diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fe3e38dd5324..27625a1330ac 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -630,8 +630,6 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 	if (ret)
 		return ret;
 
-	regmap_debugfs_init(map);
-
 	/* Add a devres resource for dev_get_regmap() */
 	m = devres_alloc(dev_get_regmap_release, sizeof(*m), GFP_KERNEL);
 	if (!m) {
@@ -1192,10 +1190,10 @@ struct regmap *__regmap_init(struct device *dev,
 		ret = regmap_attach_dev(dev, map, config);
 		if (ret != 0)
 			goto err_regcache;
-	} else {
-		regmap_debugfs_init(map);
 	}
 
+	regmap_debugfs_init(map);
+
 	return map;
 
 err_regcache:
-- 
2.17.1

