Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8176C3A6DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhFNSBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbhFNSBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1CC061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y15so11123387pfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tiW1MiNSxVy/hCeNInIQyfBMYNNxInq9UWdM3u/5QaI=;
        b=BTx5vB111fZfaNJviKToWKnd3s085SfxYJXTUooAQV0xHMl9TbfFaXG4VR8AfuSzgj
         BWPxer2RaEEJ+iwNC9XrU7RJw/5KSoPmi99RIhsA3GPt1dmnhUYtKi9BS4RTqFQghI9x
         8usC2nzVZF2a0LT9Q8OAg6wlladjM9iuBfLMpQlF8S+BKQ3TENgrpra6LFPAt10CAppz
         k7iP4hviN/s3Mh8Q/OGLsuSixDbulo5J58BbAzkD9GhqsMtkwq72HlkD1rFLdGzlt+zS
         SsjJuF8RNlZCLsG/8lEieAQeF2dI02L5tu84YT//cPi+JKtFjPAvJDtAVgz3ecrHGYF+
         Xudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tiW1MiNSxVy/hCeNInIQyfBMYNNxInq9UWdM3u/5QaI=;
        b=q0orkvDEr4zRsNZ9fc9u931/WR984UsXpm5Pcw92K6N22ZerkESYVNBSM3TzE5zffb
         PmY/F8Q/pYEIftigTvPny1M0ZxHIwMBFs4E8Q1gq/0Q9py1eMXuuFogWcPdEveRG4HQX
         gz6sxhJzIN/Pqhx2zUVLmFOTwg6k/iwMtKI5D8kbsoYSkGN2HCU5ISoxyFZbjGCgqQj3
         p1SNUtQMVPX6PD28UrZ2otMRLABetTXCZLQIGDbF3M+s3bUcCtb+SU/spLgdoIB8gHhh
         j4w1Rsptaj42BEhFqLS5EzsLeYRH+m4eNszKyY7ZVFQhfhjbUxlK2tNeUIz7SGOn9PI3
         pONQ==
X-Gm-Message-State: AOAM531y1eSorwfl9MN29/UP6hj8lzXPm/u6OcMzqVDAcQwS/LzCQVaQ
        J+N0rFYG0TBCQgRdfTvyQehuoQ==
X-Google-Smtp-Source: ABdhPJxuMaCVSzChO1l5VDImulKblryLr0k3o+St1URwrnMhrEzuovCgBTMWXV99yMds5RoaHvKttg==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr18329392pgk.433.1623693545242;
        Mon, 14 Jun 2021 10:59:05 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] coresight: core: Switch to krealloc_array()
Date:   Mon, 14 Jun 2021 11:58:56 -0600
Message-Id: <20210614175901.532683-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Let the krealloc_array() check for multiplication overflow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20210520135041.56163-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 6c68d34d956e..a7971c68b0be 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1730,9 +1730,9 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	if (idx < 0) {
 		/* Make space for the new entry */
 		idx = dict->nr_idx;
-		list = krealloc(dict->fwnode_list,
-				(idx + 1) * sizeof(*dict->fwnode_list),
-				GFP_KERNEL);
+		list = krealloc_array(dict->fwnode_list,
+				      idx + 1, sizeof(*dict->fwnode_list),
+				      GFP_KERNEL);
 		if (ZERO_OR_NULL_PTR(list)) {
 			idx = -ENOMEM;
 			goto done;
-- 
2.25.1

