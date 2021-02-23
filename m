Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B13234A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhBXAb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhBWXuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:50:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB202C061A28
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c19so39271pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9dNXLfIEwaBmyxdvGPLcXIZoYDoiye95/dFOxo0lMe4=;
        b=FacrPQa+2h15QlpIr28yddn6IuvoguAmRAZYlTCp41sRk7VfSbFMMi2D9zF2VeoMVT
         lvlrXDCraOoq8hw/Hd6ybksPaLxpOFGajiMU2ieGncuh6NybqdpyvHRRkwXU/UjOBGM+
         TUQgRGVRW4k05wOMkgzVXIYlWss60zHMqwZvLSiwQsmkXhgVszeak0UuXk5E6Iw8z7Hd
         wu1QmI7wa2PfmOxwH1qiYm/V8xlSYqdvXwvMgazNhLtLuLOwSiPZN3DdNyRAgga/VkdD
         END38q1jtAVeC7pWOVX2IAEp9taTPnTKdHNiWUZ89mdX6PgHv+/nG5g/As1233+t08MD
         YRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9dNXLfIEwaBmyxdvGPLcXIZoYDoiye95/dFOxo0lMe4=;
        b=l4taYYQHHlhbkaZEFeTfmDoUOzQzpq5DBXcpOiEL0QZiAQo7uKjqCc1ezRMT90nIbb
         kpSfYMnb5q0tX+cXJcbz74byjg3bmkm0NA7KKVgFMDDg8csopdZxLv8GCS19dJtpaB3u
         +xWXTRoKbmc/lpLK9dhm4CI1b9ZS3ISnN4hYDrRXMuAtGfI03kgyrSHhnXcPLrvsQ9J/
         evxfxSeHNAg+VI8kYq69zlpqAcRrBpLV47SauEdufhyD3O+cYbDL+S+pQ0rte7wluBNM
         MrJP02Q1YWoI43JD0YTzj17YWwm1+MkL61sO3IVVEsxAqOh/ENx1O60HJZ0r8XWSYJCL
         ScPQ==
X-Gm-Message-State: AOAM530gwdMFfYQut3gHDyMawzE5Wu+kL2RKrPFu2Nsap4JTKuEZ58xI
        w3mezbH3JyDijhkE/cQRhG5uUg==
X-Google-Smtp-Source: ABdhPJzDAGh6wh3Npt8Bm/YQ7HhxIWxiSdzM/fQpCszCDx97I+KOxtsQXnMjbwrn7gO/M6IugUvOzA==
X-Received: by 2002:a17:90a:4a0a:: with SMTP id e10mr1161914pjh.112.1614123333381;
        Tue, 23 Feb 2021 15:35:33 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 16/16] remoteproc: Refactor rproc delete and cdev release path
Date:   Tue, 23 Feb 2021 16:35:15 -0700
Message-Id: <20210223233515.3468677-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor function rproc_del() and rproc_cdev_release() to take
into account the current state of the remote processor when choosing
the state to transition to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
New for V6:
- The RPROC_RUNNING -> RPROC_DETACHED transition is no longer permitted.
  to avoid dealing with complex resource table management problems.
- Transition to the next state is no longer dictated by a DT binding for
  the same reason as above.
- Removed Peng and Arnaud's RB tags because of the above.
---

 drivers/remoteproc/remoteproc_cdev.c | 10 ++++++++--
 drivers/remoteproc/remoteproc_core.c |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 2db494816d5f..0b8a84c04f76 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -86,11 +86,17 @@ static long rproc_device_ioctl(struct file *filp, unsigned int ioctl, unsigned l
 static int rproc_cdev_release(struct inode *inode, struct file *filp)
 {
 	struct rproc *rproc = container_of(inode->i_cdev, struct rproc, cdev);
+	int ret = 0;
+
+	if (!rproc->cdev_put_on_release)
+		return 0;
 
-	if (rproc->cdev_put_on_release && rproc->state == RPROC_RUNNING)
+	if (rproc->state == RPROC_RUNNING)
 		rproc_shutdown(rproc);
+	else if (rproc->state == RPROC_ATTACHED)
+		ret = rproc_detach(rproc);
 
-	return 0;
+	return ret;
 }
 
 static const struct file_operations rproc_fops = {
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 00452da25fba..a05d5fec43b1 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2542,11 +2542,16 @@ EXPORT_SYMBOL(rproc_put);
  */
 int rproc_del(struct rproc *rproc)
 {
+	int ret = 0;
+
 	if (!rproc)
 		return -EINVAL;
 
 	/* TODO: make sure this works with rproc->power > 1 */
-	rproc_shutdown(rproc);
+	if (rproc->state == RPROC_RUNNING)
+		rproc_shutdown(rproc);
+	else if (rproc->state == RPROC_ATTACHED)
+		ret = rproc_detach(rproc);
 
 	mutex_lock(&rproc->lock);
 	rproc->state = RPROC_DELETED;
@@ -2565,7 +2570,7 @@ int rproc_del(struct rproc *rproc)
 
 	device_del(&rproc->dev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(rproc_del);
 
-- 
2.25.1

