Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74823820DF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 22:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhEPUW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 16:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhEPUWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 16:22:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBBC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v8so760293lft.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTbrZqzeTIdq/svG2NlB3CMiMALncw0fFJVSdnt0oRk=;
        b=o78MraK05iBBjWGZuYur/m357uPW50CXSMMUNWrLVGMUFk41oVmfQF5n/osjtwvO25
         zIXXjySahdIiA/tYHAuRc7f5BLterfBZ7bf6xVBYSgz3RtZlHjnhEpaV1aWUEEX0oTls
         3zrSsOpkeefcocOsYsUWOoOKxbOaAVQkqBSgo4pfIDVoaPkBpvOqNNJimGCFQgrisMFS
         2G/jPbk74xoWIure0fmhiMnJdmGWO+pVVr1gyDaUyesuucPIHrwZ3yWbhlrizjAhYJjO
         o6jaL2V2Ai0EGIYZxx04vXqfEjtnu2tgaW0fPH/oE9MXH328htKhxHybvEePYHK0YCVE
         uzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTbrZqzeTIdq/svG2NlB3CMiMALncw0fFJVSdnt0oRk=;
        b=qN2xA6O6y89Sn3m/XV9iPJaNcdmJfdQz0JhJILsqVF1WsiPedj6AQEhd6n5y5H1XAO
         JEwfx6zKtg2zuHpwpN4Qt4sFNHArwjTW25yKQ2phduL8quPbZaogJnbhTYysPxRZ/HFz
         0imrBmjHBJREVc/x2QrzJ402tQjS+912pX/+2/97E7CVGyTYHol8ik1QSD+PTXuo6e4V
         QzuysLdI0BVOjaWJ1weB4c3jPidaBN3V2np/VlHUxuJE7fSRSb04HmCqRW+aTcTAIFM+
         W5iAru7veNI4thNpGzSu2SYa+yXM5RMpEIxZTpsehb7U3BdioM/aqackgLeknmKmPFJU
         U46w==
X-Gm-Message-State: AOAM531Tp7Vfjng61i3XRInkvWsQdbSzRKdfNvbUh6yHOpnBD254Lo2D
        7RXMa/Ckxtussl7ZKYDuRcE=
X-Google-Smtp-Source: ABdhPJyM14gAplAXXpF4AUnSFzgvUSDfbI7eGPa+pyRMtiLmeknUt9gQORE5k1NmjlDrGtmPd4DbrA==
X-Received: by 2002:a05:6512:214d:: with SMTP id s13mr39980367lfr.344.1621196467749;
        Sun, 16 May 2021 13:21:07 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y28sm378195lfg.210.2021.05.16.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 13:21:07 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/3] mm/page_alloc: Add an alloc_pages_bulk_array_node() helper
Date:   Sun, 16 May 2021 22:20:54 +0200
Message-Id: <20210516202056.2120-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210516202056.2120-1-urezki@gmail.com>
References: <20210516202056.2120-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a "node" variant of the alloc_pages_bulk_array() function.
The helper guarantees that a __alloc_pages_bulk() is invoked
with a valid NUMA node ID.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Mel Gorman <mgorman@suse.de>
---
 include/linux/gfp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 11da8af06704..94f0b8b1cb55 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -536,6 +536,15 @@ alloc_pages_bulk_array(gfp_t gfp, unsigned long nr_pages, struct page **page_arr
 	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, NULL, page_array);
 }
 
+static inline unsigned long
+alloc_pages_bulk_array_node(gfp_t gfp, int nid, unsigned long nr_pages, struct page **page_array)
+{
+	if (nid == NUMA_NO_NODE)
+		nid = numa_mem_id();
+
+	return __alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. The node must be valid and
  * online. For more general interface, see alloc_pages_node().
-- 
2.20.1

