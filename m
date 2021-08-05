Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC23E1E74
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhHEWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhHEWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:10:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3AC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:10:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b13so8476692wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+w3lXB2hzuJmWQKE0Bh8lOKq0x+eCrRICMF6HvQuy4=;
        b=SiW9CKIWquDJQs9u4/LmMQI6k+SbXyVvc+e8miwc6fN9aJZGc+d3t+Ix+d6ugsfRky
         YNpKM9nXuga7fb0Aw9lHEGI5gykXJ00kiok0/riPBL68R9UKNh40IHhLmZLWR4UmVA4p
         QrsChppWDQ2Uep0RedLe9zjr8uahYd9ijwuxDSFvHCgnrpqmnaSMdDfzTHkbOzU+W/T6
         MLr82fnS/+iPvnXo+pfAxZhIR/YbH9GU8etyH8mOFKPbM/1ByQeBGygNxcoUzPyDIdQ2
         qnJFB61jYeX1Mscx4YoJzm7zXElj4CxOKxEUP+X7KJr5Sv48e15SYGEUkziKfSxa7/OU
         NJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+w3lXB2hzuJmWQKE0Bh8lOKq0x+eCrRICMF6HvQuy4=;
        b=Efd4fIkw2U8gx3canlQ3AZ3EK0P5WzxtC5m4PccjHOLoJDZKdPQ33u/2pFD0ziWgSY
         PKCheTxznUc0z3nLAp7fWe+BBFPtLJlg4LoiHNYpoqWpIG7AdkViLiMITAnAwzESyMki
         9h5fZsIRhIooP1i9XhE+VvjFO6JCh1ftqpoV31HtG52tXpJPfyxM4IDrAg1NRTTgqlfA
         JnjhXGsglScX0C7QRWBHwhpJr0L9Zi7ziBSK9L9ZRMj/1tVgBFPrzoWoqWZPJIF/j0Bw
         9xIvfceasrkSppET8JZO/CEtjvqZU+wOhgWxZ8o5GqcxP0C7rT2wcY4paRhgcx31BJs3
         6Ysw==
X-Gm-Message-State: AOAM532YTBX2S1BxP+OjRCe+aqcaScPGhZhyhk5jSgURt7IeBw5ysk5I
        zuLqlYcbuduu10eAKHtFdg50kLTBsts=
X-Google-Smtp-Source: ABdhPJyDzNRq9Zu0ZfkQBBAr8LnefgKCOCV4NqwEOCodD9H4WLsTQZq/nKclNOUbjzURamuqCr9WZQ==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr7491241wrv.392.1628201406471;
        Thu, 05 Aug 2021 15:10:06 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q64sm6573055wma.8.2021.08.05.15.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:10:06 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 1/2] device property: Check fwnode->secondary in fwnode_graph_get_next_endpoint()
Date:   Thu,  5 Aug 2021 23:08:49 +0100
Message-Id: <20210805220850.131545-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805220850.131545-1-djrscally@gmail.com>
References: <20210805220850.131545-1-djrscally@gmail.com>
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

