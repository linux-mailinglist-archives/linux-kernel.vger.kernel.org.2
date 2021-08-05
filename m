Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D849F3E1E73
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhHEWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhHEWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:10:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553DC061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 15:10:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k4so8505211wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbdHuUgm9R0O8iD622sN5nUz4CxbxanIEic5v8NNLJE=;
        b=fkaig+y6pnDujfjZBctq8a/YWJ+US4Le5WXsozsWfiWPeqQdNpXKWcrprTLCnxZVmH
         +Y+ApVcqp3O6R6/aziK2F/366tTB9W4PtFlIQAX6aGD/eUvlWJjfyqQlz1s6nfvGM0Yb
         DJcFizw9mNjrxTdE59VUWe0EEipU7xREnGTZwesvzrUcTO8mRvJV10b1DmpP9YBO7xok
         QV/jtu34akZtN70AnZaDN79/FJDnzhz+7fXxEaEJ78syUkiXGPlj0HffIUKffLb1/GWc
         8QQZYG+iPkaO92S/ZkYom4ma41+H5FyF9dTNByml2F73yYC5v3NK6mqEWbgIggw54Qic
         2hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbdHuUgm9R0O8iD622sN5nUz4CxbxanIEic5v8NNLJE=;
        b=uoL+Or9Zzwpxlm2CtXABlwUIswe7xvQhZFXTHrTenRRHlZxZ9FZ1kGdhnO+zUFhWkc
         gUB9S7XC/JnpmbBUpBQ7RFP2hk5BlP7l9dvfJb8QU858qygq3ZgGmtZMRd+7fjqdjPPj
         7YplId8cxVWcpDaKaU0/rfTNhkdLgmiopNj3kLCLB97NeUHWlM5vwE6DKMW8KW21T1Tp
         sjwxMZvnwb+sDpKtpp7ymg4WCUrr2bJa8pZIGwTcOmDg1Lx0+50nUaWfN6uuzcRnnYo1
         HbnY+XLNpFuBDDY1lHBp+5vUQ41QW1TSGMW/2pv9I0cmVVaZvS+HCF93EQjlK2s0wAsx
         XlSg==
X-Gm-Message-State: AOAM533tHwU7zCK23w6wPcG2W0rw7nuUOC0DhOa7jWHeMnIg5+1gPxQl
        IvQcYXZfpqXV5viSct47yd5M+ZP9ZMc=
X-Google-Smtp-Source: ABdhPJxEv9mOE053XOkUsFaoh7MYwYsHl8ZwXV238bmG12AY0UVLh710pI3Jw4qbve2RGqjTIEZ2/w==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr7552881wru.421.1628201407221;
        Thu, 05 Aug 2021 15:10:07 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q64sm6573055wma.8.2021.08.05.15.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:10:06 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v3 2/2] Revert "media: device property: Call fwnode_graph_get_endpoint_by_id() for fwnode->secondary"
Date:   Thu,  5 Aug 2021 23:08:50 +0100
Message-Id: <20210805220850.131545-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805220850.131545-1-djrscally@gmail.com>
References: <20210805220850.131545-1-djrscally@gmail.com>
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

This reversion depends on the previous patch in this series, "device property:
Check fwnode->secondary in fwnode_graph_get_next_endpoint()".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---

Changes in v3:

	- specified that this patch depends on 1/2 (Greg)

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

