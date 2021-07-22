Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7F3D2D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhGVTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhGVTjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:39:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3844C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r11so7191995wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1Oc4eqdMA0i0PSrQmAFvS6fJ2in8QkjY6AkplqD11c=;
        b=ur+2eT7JUKtBf3J5hmspJeDBIA7KJdJyLjpzeC2bAhyMDPY4bOoeBDtMFUaDLxLEvH
         maPs1L8XbxpzCUz2n3d+JpBpApH7HMHEy0m7oBZu51Bz9diceFTGTIVze+Q43M1IZ/AW
         I4WW5dgma4r35PmgZARgv5uRod8/XGnNwuf9UW/FaF9Fl/TB99svXdrGu+7Kp3rniDV7
         HWvm19XdsXeZaUw0ys7zAkb5NA8Si40imM8IPbKHsfYaserXv9lxu9+EnBSUP969mD27
         VDufLp9jWuoBaaBZslLA5pFbR5YJzmi75dtfIOJ9rTGFTfUv5mUkbWTVtbe6KOLeLXtQ
         TZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1Oc4eqdMA0i0PSrQmAFvS6fJ2in8QkjY6AkplqD11c=;
        b=HBYSkr8ZfzSKJGbLiQ4I27kQxTnkGQYfiPVVPt5OyMF/Ho6Ucpd/lJglrPTZ6G6Lpc
         TMLPSXDi1T7W+r1d/VWgiuudAV3cDrp3JsCUJy/nk3vHmSTRvuL4DdbD7vxuX3psZ+cN
         6gGJuRRTS0vCYk1ZbalBBQt/LtpmP+snpAMOGoAenzmUBmeO2Vglzj0I7axUTfQ6fyY3
         2KKU+m8J9AfHcRWVk1IP2hXc/3d366HTDmmMf6bZS7XcVDbeqiCf8M/7tMFh1SLhMoEO
         Gpix8qDUBymzP33UNEbcsU/vtJ/5/bVHnwNa2lsNwKS7XDwSrsWz6NfJjfycij9NIUvo
         DnMQ==
X-Gm-Message-State: AOAM533rCCfFpMG0mVXyW3htAFDtCAMUkQSd9uxS1zgPlOIzqAywIKLU
        +Sk8pOrYJnpXOl+9+qkPB6+j8uiv8x0=
X-Google-Smtp-Source: ABdhPJzaUeCzkT1ezLMfSSIs1bQDm0zsRvxNTsFRqx1s7rKRaoJj3i1+s29QwwP+DZmTk/fj8DDkLA==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr1767181wrn.248.1626985180589;
        Thu, 22 Jul 2021 13:19:40 -0700 (PDT)
Received: from valhalla.home ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id o28sm32742054wra.71.2021.07.22.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 13:19:40 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 2/2] Revert "media: device property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
Date:   Thu, 22 Jul 2021 21:19:29 +0100
Message-Id: <20210722201929.3585671-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722201929.3585671-1-djrscally@gmail.com>
References: <20210722201929.3585671-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit acd418bfcfc415cf5e6414b6d1c6acfec850f290. Checking for
endpoints against fwnode->secondary in fwnode_graph_get_next_endpoint() is
a better way to do this since that function is also used in a bunch of
other places, for instance sensor drivers checking that they do have an
endpoint connected during probe.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/base/property.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e3aceb3a9a0d..689276fb0e45 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1234,14 +1234,7 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 		best_ep_id = fwnode_ep.id;
 	}
 
-	if (best_ep)
-		return best_ep;
-
-	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
-		return fwnode_graph_get_endpoint_by_id(fwnode->secondary, port,
-						       endpoint, flags);
-
-	return NULL;
+	return best_ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
 
-- 
2.25.1

