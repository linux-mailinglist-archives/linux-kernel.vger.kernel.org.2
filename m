Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F750399AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFCGu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhFCGu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:50:56 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB6C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 23:48:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so2365344pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iWLIuP7OKecPhyH76mPQ1jEgA38aQDAwKIavoDRN/s=;
        b=TPnfIOFBGcYjEh9ERq0OZHQTTwvZySY2cbP7/BCaYp3NBkdEhMBLgtjHZmym0ixxEc
         k9KujWM95g8vZviWJPy4bvNxQCbJMVTm4XHv0d4kMA0OqnkEgVujJql2s+ta+uUtZ83M
         cW9PF8nNZFCOXsNpQzO9tTcSekujyFG/CzokE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iWLIuP7OKecPhyH76mPQ1jEgA38aQDAwKIavoDRN/s=;
        b=uVjr5llmBpiab9gmUO7cyWbmFm490d5SdAXj0IxlDazDwHELiqR+ZjsERJOsFx0v1x
         iQkL9qY2bNwuySFQ2W+10VIB52Tm0t6nQlYUFeD39zN6x14PwPyU0xGaNIhb1esu63XB
         FHRQwu4W0RtlLfy1vXokItrqX5+InT4k/Fqv28Sk3UvsTdbrlGwC0DmdZztT0AiItgIJ
         8nLB2xxjy5VUOFlO0h+9SuXM0R/EW90Zuvbf4ba40DbyuxRmvY6005FziAWRHak6B7MT
         cUIRNQBWi5zaPvPtWprjQy+Qi0kXYm39YMz4rxjRwsVxBAO23Q1FyNImFu4wEBpItdt9
         +jQg==
X-Gm-Message-State: AOAM532aJ7jgVPBAxlVCEEOC7wysRfcd5g7XgrFjjenM1bVWX+GyxqJ5
        yfUTFU3GaLcOtuLXTp+tqHQbSg==
X-Google-Smtp-Source: ABdhPJycEpDd6sKWgHuHytP9Tud9xOmBTuh5STdm6mFkgd8rBSlGBtF2QFS1LvU7r5ON55kE147iNA==
X-Received: by 2002:a17:902:7e4e:b029:f0:d949:8ab3 with SMTP id a14-20020a1709027e4eb02900f0d9498ab3mr34281272pln.40.1622702930740;
        Wed, 02 Jun 2021 23:48:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7d6f:aade:22b5:5a63])
        by smtp.gmail.com with ESMTPSA id p36sm1632743pgm.74.2021.06.02.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 23:48:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] driver core: Make dev_info() messages dev_dbg()
Date:   Wed,  2 Jun 2021 23:48:49 -0700
Message-Id: <20210603064849.1376107-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These seem to mostly print debug information about device link stuff at
boot. They don't seem very useful outside of debugging so move them to
dev_dbg().

Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 628e33939aca..066880a843bc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -865,7 +865,7 @@ static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link = container_of(kref, struct device_link, kref);
 
-	dev_info(link->consumer, "Dropping the link to %s\n",
+	dev_dbg(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
 	pm_runtime_drop_link(link);
@@ -1732,7 +1732,7 @@ static int fw_devlink_create_devlink(struct device *con,
 		 */
 		if (!device_link_add(con, sup_dev, flags) &&
 		    !(flags & DL_FLAG_SYNC_STATE_ONLY)) {
-			dev_info(con, "Fixing up cyclic dependency with %s\n",
+			dev_dbg(con, "Fixing up cyclic dependency with %s\n",
 				 dev_name(sup_dev));
 			device_links_write_lock();
 			fw_devlink_relax_cycle(con, sup_dev);

base-commit: 5fcd0bc17e451e8f140067131fd12be0f5f1204c
-- 
https://chromeos.dev

