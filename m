Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5C23E0AB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhHDXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhHDXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:03:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18CC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 16:03:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so3984266wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1ONAmhd14TFujmTi+34K5PPMAz4oZfQKZNiu8BRzHk=;
        b=rly1S/cr5egegsMC2i1DUeI8hbU8RBaJ52S6+UymKlhoKRW8ehAP6GvUhF8aaIhwch
         dpJrQmVGIbRMSVOrSfa2/EmqGRjkKv2MXs8g7BndZ1XqrOc9s6fqSeFBiw4KjjL62jvQ
         2NC4YYWjPTeOeTqu6BT5aFQpDGuco4PzikqLjq8D8GyacZXWwiLX/RIFWfZl+C7vrFZ7
         aWbQlW88OLRbtfL8VBaXUOXRDvyQorXf+mrExn08vB5eu4h9oKsgqjb7pWLz2n9sLyax
         B8xhdsaRTvuqRuomlOQi+nepbYKlvZYK9pgodKsoExkiSiWzaEDI8wP9tAjcdIN0MmVM
         queA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1ONAmhd14TFujmTi+34K5PPMAz4oZfQKZNiu8BRzHk=;
        b=IHVXg2n31rcy+OpGTKpnJx5iwLzqGFVfFfoyCI+rcb434fCybxpxUHiHnHCG9Bka8w
         UJPeoGNm3VFSLp8eEDAYC/3AzsE8vF/YXfY4k1ahS/LDjDMSZEJ28aZKiZPj6Uy9CMnd
         JJDPhMLMS0SuV96uH3Ki5PbemOsKWzE4Uq/6M3/xjHr//Tnk+H+/2cOo4sBB8YaQQu9n
         oRPlsp642upQ/kUACUS860lKvfrM+tV2Dl7peFJQXm/1OpvBb4H4C4eqF8kM+YQpWdMn
         K804NavP3j6TkY708TZ/SRxx1mPMgMaITbdIe5FXuSQAl2kRMBKE1dz5huvMrvFeULFY
         JAuA==
X-Gm-Message-State: AOAM533XkL8ekU/ZtS6xHFaaKiOveUEBzF1MbfqtH85VgHR5TCckuviS
        0cP0SmLHiQGtm6cv3XPYYG+FlJC8+kE=
X-Google-Smtp-Source: ABdhPJwkJpcE7ruPkDcvuFWJjY7jM5J/pB3M+n6d2NU8/dyNoyez3CLXwZskoDVyrWkLZWe1yyU/lA==
X-Received: by 2002:adf:db07:: with SMTP id s7mr1684123wri.106.1628118207727;
        Wed, 04 Aug 2021 16:03:27 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id l5sm4553393wrc.90.2021.08.04.16.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:03:27 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 1/2] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date:   Thu,  5 Aug 2021 00:03:12 +0100
Message-Id: <20210804230313.78238-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804230313.78238-1-djrscally@gmail.com>
References: <20210804230313.78238-1-djrscally@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- Re-ordered the IF_ERR_OR_NULL() checks to make the logical flow a bit
	more apparent (Andy)

 drivers/base/property.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1421e9548857..fb0e852dad5f 100644
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
+	if (IS_ERR_OR_NULL(ep) &&
+	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
+		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
+
+	return ep;
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
-- 
2.25.1

