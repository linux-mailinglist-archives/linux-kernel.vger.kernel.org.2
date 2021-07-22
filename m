Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374543D2254
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhGVKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGVKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:16:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DEC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:56:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gv20-20020a17090b11d4b0290173b9578f1cso3300311pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keprLEvQ6kzmfss+PY9Ymf8ZxzzEljbUGjNECEDOpCE=;
        b=EMpD0Y5kmc1b4rRLX/oPEJJcSx372ijyD0LH7hIhnogSpvCmIqtbi0rFWAD1ukEmDw
         R6jitOHCrRxwYuWOAHnlefXehjSHG8+8fu/z9JtaRW8qzuLCRUDoiTRkfwv+9n29sZ9J
         3LFYEssjsHnP8YLaiGF4s3nUm4jyQBcfqN7rcrKRfTuwM3JjtRRR2I98sdQh1dVaDM06
         cRf1HjUo9X5pcKMnzzLC1XyX3U15R4+buGhf+hsN/RUzrBsB1GK1oOYEVBzvf8xXvkD1
         62QGzb9LIlv5WtObCiH/IFuKSllQydmO+zgEsI8aN6WCQaIxw51PC9WXS+i/kS28ovz/
         tciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keprLEvQ6kzmfss+PY9Ymf8ZxzzEljbUGjNECEDOpCE=;
        b=gFcEB3lQbokDAtQ1usyGfyORtOcBK/VRFCie/Y1glNlG+neIyyfrHvG+LLYIpGzzso
         hKRfsQjYY5QFXeS+MIzbULw+22NiuEnbDvVM60yThudG5e53PumGdQKMQxIIBbDKVQUy
         ViT0qlecUIMhFFQ8iQ/vrGyDh5oMb0yue2m86f1CMve27PK22jDOnlejeRFr2IUPzSo3
         RMiATahLm0ucPhvCy7Wfi/Ge+at+3HYJgfwl8mkUybuNOdP7n+wZ9NrOHsC9+x/LyC9n
         uKm8Zt3hLBuENnXs0k5MfLMgdd9vO5HTdLumy2DC2PCNrTqGHnREa7gGFfRdN2/M0Kbp
         bnCw==
X-Gm-Message-State: AOAM53008ur9ADdVXsgF7HONd2/UZFTX8ZorZ9xv0K3omd5fJq0871Md
        dtQOVVmQ6Lqh6fRRzBSnFgc=
X-Google-Smtp-Source: ABdhPJzgg/V/keoqHBCfWG++5HUaKDkKHRKaDhk6R9KAYsZunDfLFfd3ecs4BeatdH5xvAQudqpU0w==
X-Received: by 2002:a17:902:dacd:b029:12b:acab:b878 with SMTP id q13-20020a170902dacdb029012bacabb878mr3683960plx.4.1626951402411;
        Thu, 22 Jul 2021 03:56:42 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.166])
        by smtp.gmail.com with ESMTPSA id c5sm30535481pfn.144.2021.07.22.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 03:56:41 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     dan.carpenter@oracle.com, Dongliang Mu <mudongliangabcd@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: stream: add s_rt into slave_rt_list before sdw_config_stream
Date:   Thu, 22 Jul 2021 18:56:11 +0800
Message-Id: <20210722105611.1582803-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 48f17f96a817 ("soundwire: stream: fix memory leak in stream
config error path") fixes the memory leak by implicitly freeing the s_rt
object. However, this fixing style is not very good.

The better fix is to move list_add_tail before sdw_config_stream and
revert the previous commit.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/soundwire/stream.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1a18308f4ef4..66a4ce4f923f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1373,19 +1373,11 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto stream_error;
 	}
 
+	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
+
 	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
-	if (ret) {
-		/*
-		 * sdw_release_master_stream will release s_rt in slave_rt_list in
-		 * stream_error case, but s_rt is only added to slave_rt_list
-		 * when sdw_config_stream is successful, so free s_rt explicitly
-		 * when sdw_config_stream is failed.
-		 */
-		kfree(s_rt);
+	if (ret)
 		goto stream_error;
-	}
-
-	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
 	ret = sdw_slave_port_config(slave, s_rt, port_config, num_ports);
 	if (ret)
-- 
2.25.1

