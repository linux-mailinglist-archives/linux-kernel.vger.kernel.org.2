Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41783D2D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhGVTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhGVTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 15:39:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o1so30721wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9S3/fq5FudK1hWn2GrhWfOxhUCUjqhwUNxwWp693Aw=;
        b=cWwKSC7zvAilvx3DAyI3OuA8yt5fPmOG5fCrxknssheJ/yozYSdHyLW1Cz1+oKlaRU
         3Btr9khCyhgjYbmijpXf2CzajeiHNom7T/Y+cjYwY2Z+Aot2pavNv6RCy2i61uy2+SED
         3lVAP5mrQKz7ktZpw/KXFAi3bW9WL0dGJEcwiCb29dPXQnbmrn4WAO7m5PXlLtaZ1waE
         DMiY8Bm3tUxsmAU2xT5OByXMCbaAUD96hlW2os7a2+vQ+Dmplb0tt48KO6/ovcxCvxeT
         Sh34ZH1knLO5r+42/HOQfN0qaPNRB+s/VgIiO/UeuCrWbLiLDSITGomOAmo8TLsIDx45
         AesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9S3/fq5FudK1hWn2GrhWfOxhUCUjqhwUNxwWp693Aw=;
        b=aJGUalcc3fqOpjXTIsDAXwfRg5fjikWiWygFS+Zaoosyfm28KC4IZc59GJJn4Qve84
         ojBXTMipmHvRQGdMyHuEYOC+dXZyoETRFuzj457tanhOfg+mU/DEoElBpQnCmS0tidxu
         tnug1kWBdvomaXetK0a6/fwYufaAzrL8gDitfY1aLyDtxKA/6VGO/vKkJQSFd4stEaQ6
         Q+1HWgCJDAwf4ZUzwb5Y7cWsX3dqCwY8oXczc54MkFN7EhqZarkor0GbNHkiSYKnxp2C
         HqMreGShkA/m4AKEhQ0UcZBgXvlRwkyfhHpzL+zgyHgxXmCxR3cTkUWYP1yVhnbyibYV
         liJg==
X-Gm-Message-State: AOAM533vT8NBugqMsCexwf+7AhVahiF6XAJQf1esZ7ohstVjdjRbfqYo
        p4p8BCaikTj73T99G6b5fNTyoR1AgQI=
X-Google-Smtp-Source: ABdhPJxSsoA3iflMipG/VzA+v/ZbODsHY7bXbg7CysVMhF2uqeg0S7O/lUqzQ0r/+q2Awvct7xuKfg==
X-Received: by 2002:adf:f592:: with SMTP id f18mr1641105wro.179.1626985179851;
        Thu, 22 Jul 2021 13:19:39 -0700 (PDT)
Received: from valhalla.home ([2.29.20.106])
        by smtp.gmail.com with ESMTPSA id o28sm32742054wra.71.2021.07.22.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 13:19:39 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/2] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date:   Thu, 22 Jul 2021 21:19:28 +0100
Message-Id: <20210722201929.3585671-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722201929.3585671-1-djrscally@gmail.com>
References: <20210722201929.3585671-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sensor drivers often check for an endpoint to make sure that they're
connected to a consuming device like a CIO2 during .probe(). Some of
those endpoints might be in the form of software_nodes assigned as
a secondary to the device's fwnode_handle. Account for this possibility
in fwnode_graph_get_next_endpoint() to avoid having to do it in the
sensor drivers themselves.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/base/property.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1421e9548857..e3aceb3a9a0d 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1036,7 +1036,26 @@ struct fwnode_handle *
 fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			       struct fwnode_handle *prev)
 {
-	return fwnode_call_ptr_op(fwnode, graph_get_next_endpoint, prev);
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *ep;
+
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an endpoint from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (prev)
+		parent = fwnode_graph_get_port_parent(prev);
+	else
+		parent = fwnode;
+
+	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
+
+	if (IS_ERR_OR_NULL(ep) && !IS_ERR_OR_NULL(parent) &&
+	    !IS_ERR_OR_NULL(parent->secondary))
+		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.25.1

