Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54C13A6DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhFNSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhFNSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22428C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k7so10168656pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEhJJ0I3n+465SJ2OQg4qV6RTAF3hyu2gH1k9jBoTOg=;
        b=ORyklIpGZd7xWxuqsxdXJPwiACup5toMdSnvCu5RVrIvVygDCbJV3Oa4UQ4Eekc48E
         07DgbCWWq38os9FG8K0I4rvXPe0LV1N9Ub5bhq1q0SIKOm3SiKD14MLaMOtgUaAK5vTm
         Ca+nHGih5Sq2iJPw0S20YHYcX/Uqr5bI7xh6pLoBvVRNUumcwqb05iqfW2EiTRrtDZB2
         vmLyotVaNg22/Knqw2YqifBcfuGQXwUV7PZf5CnUeSS2e87++UwkZucXA+2U+V99bBsE
         M7OrG+FHlLdpaXFtvxZtsqrDAgjr7UcXLhM6uOjUSFpAu10xaw28YF0F6sjvf1wOy5NM
         ILNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEhJJ0I3n+465SJ2OQg4qV6RTAF3hyu2gH1k9jBoTOg=;
        b=Iv7hC2UWCYwwKmmDKO+iKstVOmkEDJzuda7myQqn7sSmIJxJ84axrVtnl2gTa3PmeT
         bJuw6HH1qq8/KqgDcMqrmwFkmh2ULPmc7aUkmsVECxxaxLrAgeWx/Zcc/44MYOngC1t4
         vqXsbjKyiawK/TYqYIx3NpOAquD6pyMWNrR3cnhzhxhi+dOu2126tIy1jFJQIBCg0kHJ
         s1iNiXuRszdblFDo8dhLAa1We1C5uj853wIVspB4Eg+c3NxxZ5wXPwiXkwtl/4/liUY0
         38i5W/81xQQ2NyaLA1XKMQICNMts1MhiJ4rosq5UASv4+GwI90dIKRwUQjvv1Bk3s3Sg
         J7gw==
X-Gm-Message-State: AOAM532R7r2IjHUw+n4xYh7kNI7xCmPGvcwBvbgfE9+/FD3EsX1/Nf+f
        Y8ZaoEwJmPdugvG+N6QAAC2bIQ==
X-Google-Smtp-Source: ABdhPJzROmNgV42dhmtSHXpS9dDJtftzasUha1TC2gZkpg5Ah8QIZsUbUjqKMNMnW2S4ZsplIjq6kg==
X-Received: by 2002:a17:90b:1808:: with SMTP id lw8mr19960036pjb.30.1623693549668;
        Mon, 14 Jun 2021 10:59:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:09 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] coresight: etm4x: core: Remove redundant check of attr
Date:   Mon, 14 Jun 2021 11:58:59 -0600
Message-Id: <20210614175901.532683-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

"attr" is checked by perf framework, so remove the redundant check in
etm4_parse_event_config().

Link: https://lore.kernel.org/r/1620912469-52222-4-git-send-email-liuqi115@huawei.com
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index db881993c211..da27cd4a3c38 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -568,11 +568,6 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
 	struct etmv4_config *config = &drvdata->config;
 	struct perf_event_attr *attr = &event->attr;
 
-	if (!attr) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	/* Clear configuration from previous run */
 	memset(config, 0, sizeof(struct etmv4_config));
 
-- 
2.25.1

