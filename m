Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1427A3E0AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhHDXDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 19:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhHDXDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 19:03:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CEC061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 16:03:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so3994969wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slEABgZvz4AmqmTrYi2H9AqFNL+srpStMf/O8w80j64=;
        b=QNHu5NoBJ3bvhQlVWED0yKcAOCoSx8HkOoW4YhWEoBPZUttOPslcvz/bBqTh9BjZWo
         Y7nwR38tiS4WJPi92Dqy06qX0Fv+w5HFi/TBiwqwyPHIfvI8j3C/jQTVldog3ORavHoA
         1dKsBX4psZw8rwAeVDadqqaYqwMGDRy8twyOj7DnujNL3z7lwwCM7EbIbKeZQ10TRm48
         WtTLz5loAZSMcdSTyI1kPJQfF6ltI78uTsNGMt3Ipkdu93ROMnYuh/aFRV7tL7WQv8Ih
         25iqPKxroO6BEIIoT3wuvt8II5/3WI3KyeI6mNiUpR3N9qLHupNQzlfSvRCwID44m28D
         i5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slEABgZvz4AmqmTrYi2H9AqFNL+srpStMf/O8w80j64=;
        b=VRlX/cXURn0r00mp6tS8sLhRoitBqr2wBrWQPciQjRH2P4u64icBre8RpU/m6JmPxC
         1P61kAZ+RfkoAesT4WVw1c0WJLiGnnqEWUlG3pdMkN/BaDppuadBRAfIIZv57N+bqJDF
         oY+EH9Gl29lwXEnOT9HxDxp2amGQ9NvLWgd2Z/2jWBer6HedSRY+TbeSvb7OQsqYT20c
         3CKSOvyw7ytK+jDc1/WI6k5YG8Jy0CvQLi3FvBKuX+Iws6EATBfJLiI/y2GuFtPP1Tqk
         9LgmMgYQ+DE2GMapWSE7gMQ0axYs0kBB8A7Lq7mTCJub2+qSvS+9OC3i6sfrp+0BcIpq
         lrNg==
X-Gm-Message-State: AOAM533jRs1ckTzfXAVXs6YZhbOsCGTHBHu0cSP30VVAyZxP6BihrqLo
        1Z7XGCi1EtnpzqSlKTgg+FK+pwIzDD8=
X-Google-Smtp-Source: ABdhPJz/tr4uHV5Y4NHzzjW+gCul04wmU5pJwod2v87uV6A2/3KkXE1a+/ifa9+I3HPbxcsIHQ+uvg==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr1629788wrw.166.1628118208711;
        Wed, 04 Aug 2021 16:03:28 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id l5sm4553393wrc.90.2021.08.04.16.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:03:28 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 2/2] Revert "media: device property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
Date:   Thu,  5 Aug 2021 00:03:13 +0100
Message-Id: <20210804230313.78238-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804230313.78238-1-djrscally@gmail.com>
References: <20210804230313.78238-1-djrscally@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/base/property.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index fb0e852dad5f..c6bb3d453c57 100644
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

