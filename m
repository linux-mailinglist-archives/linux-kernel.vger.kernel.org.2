Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79C38AEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhETMoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbhETMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B25C05648D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r12so17402618wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHanPGk1uQOVUKO22D7xcyQQ9/A6KPvFy4YVhuM9AVY=;
        b=iFfSsAYG2vZJGqO4833luoS6Wmg6j9sAa9WWKN01RUL6INuZ6N0hv/fdVckHCONa6U
         5r4Y+RdUh5Nix3ij/hx3o7v8SOUDNMvYKsxYJdQ2QqH3Y7ZYLhiyUdbJj1Ruo1dHrp+9
         oS9rGv7YEvWeXai75sMeeaQMsRS6CmmcYjvWnBFAQcasupyx94TpIp/7VUZ3OoKKhu08
         0leE5pQx4HrbA6U1pZtM16KWWKe6tJIyo15196qnrVzSpH0Lp2TFKDBnTvxSWB+ACSC+
         W9LTkMQu2Xg3P+oDb4HHLp0lRI4poht30R7A+1+T9CqoZJs/cQ3Hv4qPHJeSMST4e7vH
         jCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHanPGk1uQOVUKO22D7xcyQQ9/A6KPvFy4YVhuM9AVY=;
        b=uEBkgjMpknNwya6MsRmH03LMAjAdIrGY6qhUJQwRaXJ7IEljLcCAnSsmHREzqBGpUR
         RxmO2QRPt15A5cAtv5J0lFTZBuFqBhkbSZ9+6hXZqHDrZrWAd3AP3ZWgmZQH0oMJs4YW
         ODGv9FkMBk4cvEv5MufYpw9EwFNW4Aa1sJrwDoA+IlWmWvH691SRQ0ETknZbZkUlvm0i
         o8Ywo+yJk7fzEI7lbpSY2SBh7OAeEJfDjlUpap8W1wLUNAz4yKZBktMbjrKi6SP3FL34
         ry7oNzmb+cpg/k6sLwF8EAczpx7djlJggt6j7OZ9dgTQ19NPEvV9YZtgN8+FR8JSiLlx
         VQVw==
X-Gm-Message-State: AOAM530HA9k6G6n6IkkHmErOy9HWfRjYQ+ankm0KXV3kXF5pfaN2AfAc
        88SavKAx6kZ8EVWC/NK2Ec6+3Q==
X-Google-Smtp-Source: ABdhPJxda1MrjZvoUJVBz6GDOHlK4UYlGNKUlKIKXSUkmLUKlH3DlLWPNY/UMvP2hYZ6zWITjCWk+w==
X-Received: by 2002:a5d:4536:: with SMTP id j22mr3886009wra.329.1621512181098;
        Thu, 20 May 2021 05:03:01 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/38] drm/sti/sti_hqvdp: Fix incorrectly named function 'sti_hqvdp_vtg_cb()'
Date:   Thu, 20 May 2021 13:02:19 +0100
Message-Id: <20210520120248.3464013-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hqvdp.c:796: warning: expecting prototype for sti_vdp_vtg_cb(). Prototype was for sti_hqvdp_vtg_cb() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hqvdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index edbb99f53de19..d09b08995b12a 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -782,7 +782,7 @@ static void sti_hqvdp_disable(struct sti_hqvdp *hqvdp)
 }
 
 /**
- * sti_vdp_vtg_cb
+ * sti_hqvdp_vtg_cb
  * @nb: notifier block
  * @evt: event message
  * @data: private data
-- 
2.31.1

