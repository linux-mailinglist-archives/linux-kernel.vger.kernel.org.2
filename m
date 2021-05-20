Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE6389A80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhETA0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhETA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:26:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D0C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:25:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v12so7993638plo.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRquPtKESR1fixPzXGluszKZZ1e3a9BRsbbdMoeuLvY=;
        b=Ds0tK1t4lVQ8KE/sGvf2nUVymAK21Pt8pKPu3fln6VW9CNikaOaUrGjV4DPHFPbQ+s
         CrE9qPxuFx80GzKOsWy/tx7t0AC57nz/Ictcrbg4xp864prwxIt69Hb9v/dSkuTPZD61
         7pIUUGfmzYO93Wp+YVhARCpxNoVBGUjPBTDng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRquPtKESR1fixPzXGluszKZZ1e3a9BRsbbdMoeuLvY=;
        b=Uf+4cfmH4+PEw9MpOs1rP9Wvn7jxHaqrdgHd/YtyWfTf9uYL1xKsMJAygC35FcpBg/
         JM67zF2UcseIJu0UxeSqYNpsrcfnPdEEcS4pg0thyd+6RSGP0Ly0r213tGr4vlbNUhOI
         ddAyfG3Gz36mR88a7+nnroXJoiidN4nVKfXln4C2DkuPuKD0d+9DYOvEdoN17f9mFA3+
         4S6mcAKPkv7nSjERPrNPLIC9pSjDODt/WdDBbGWWo66DPxZOujNwq55QqvnDU+VKelSn
         L1SY9TWLmQMe68XRCTP2ixAhT65RvEtHku2UeZD+Bb9noFM01EDqeCswaxbYDhrf/hm/
         OO8Q==
X-Gm-Message-State: AOAM531qgWLEIChiKuw5YthyU9u9ApUgYJtWSjgHvdBbfohPcf+uX4b/
        fLhJwMtkCsc1UgOm7ex7+jFDAA==
X-Google-Smtp-Source: ABdhPJzQ4U2lTNUnLgnTbBfp6T56SKS85QwT+rKLMXH6K8ql9c3cbNItvfoNOn06y8J7swXPzEuKMg==
X-Received: by 2002:a17:90a:7e03:: with SMTP id i3mr155918pjl.197.1621470322127;
        Wed, 19 May 2021 17:25:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:200b:db75:4e6c:8b96])
        by smtp.gmail.com with ESMTPSA id i14sm398904pfk.130.2021.05.19.17.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 17:25:21 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 1/7] component: Drop 'dev' argument to component_match_realloc()
Date:   Wed, 19 May 2021 17:25:13 -0700
Message-Id: <20210520002519.3538432-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210520002519.3538432-1-swboyd@chromium.org>
References: <20210520002519.3538432-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument isn't used. Drop it.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 272ba42392f0..bbe1757dfa89 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -307,8 +307,7 @@ static void devm_component_match_release(struct device *dev, void *res)
 	component_match_release(dev, res);
 }
 
-static int component_match_realloc(struct device *dev,
-	struct component_match *match, size_t num)
+static int component_match_realloc(struct component_match *match, size_t num)
 {
 	struct component_match_array *new;
 
@@ -359,7 +358,7 @@ static void __component_match_add(struct device *master,
 		size_t new_size = match->alloc + 16;
 		int ret;
 
-		ret = component_match_realloc(master, match, new_size);
+		ret = component_match_realloc(match, new_size);
 		if (ret) {
 			*matchptr = ERR_PTR(ret);
 			return;
@@ -469,7 +468,7 @@ int component_master_add_with_match(struct device *dev,
 	int ret;
 
 	/* Reallocate the match array for its true size */
-	ret = component_match_realloc(dev, match, match->num);
+	ret = component_match_realloc(match, match->num);
 	if (ret)
 		return ret;
 
-- 
https://chromeos.dev

