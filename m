Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9865B4246CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhJFTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbhJFTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:40:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3DC061764
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 12:38:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u7so3247131pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSt66/qxaj+Yl6pIb1r8ArjDZRzSqERxTSL7e01cwWQ=;
        b=BmiI3LSyKjcVMkJ2gZd3LhPTHWfcmkydptEVQ9oiWWAFWzIe1MohWjx9bbawlzcH7q
         qetmyBf+RlGrk5ISWZRggAq3lthN3K/k4DISR3I5gMMLDXMXT8AzbWlWkmrgXro8h50I
         0A+4VMPnY2FjF4u4slYiTPHpdBdGgrCNY66dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSt66/qxaj+Yl6pIb1r8ArjDZRzSqERxTSL7e01cwWQ=;
        b=xbXkIzugwc64uOaaQ5t0EJkzD7zepVV8o7hJsN+N3wCxG+yJ1T2aQZqmgQerZ7DLgz
         lLFfHg+BWpf8XcXpvX+EwWVKDYSI0f14trLn1H72pD1ePuCkZbDSVkH9E50sW7BH0DYc
         K/FPkXroajy02qsSg7pl94QBqttORsW42BC6DbZVagwfqd2BpmKF6Zkbi0WLuk7uAwri
         Awiz/FMhtL3K4aDFUgdwXt6CEPPduWDIAR5z1vaHyIKb78DhzAwZDdS+SiJJ6u8g6IMW
         lZ4GlsuBwJPrhgobbeO2NCZK5IFFEq3wy1jR8jleWc4tF9tB6Rt8vikFL8VCyqF1K7OT
         g50Q==
X-Gm-Message-State: AOAM530RFtjabJjggKrwnR64VbtV66jzc8VgLcgA96MLB9IHMcYv/cUi
        UMGSB22xp0+GuMEA28grIQ/guA==
X-Google-Smtp-Source: ABdhPJxNGoDafhlEh+0TsExPrHB7fqmUepOv8+MJYv9j+yZKMoyNAQ1lN9Vxlb31AxOrCCSdOAdpeg==
X-Received: by 2002:a63:5717:: with SMTP id l23mr443433pgb.87.1633549108801;
        Wed, 06 Oct 2021 12:38:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:d412:c5eb:4aca:4738])
        by smtp.gmail.com with ESMTPSA id o14sm22011296pfh.84.2021.10.06.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:38:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 05/34] component: Add {bind,unbind}_component() ops that take aggregate device
Date:   Wed,  6 Oct 2021 12:37:50 -0700
Message-Id: <20211006193819.2654854-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006193819.2654854-1-swboyd@chromium.org>
References: <20211006193819.2654854-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to get more device model features in the component framework
so let's pass the struct aggregate_device pointer instead of the parent
device pointer to the component binding functions. This will allow
drivers to inspect and control things related to the aggregate device in
case they need it, and they'll always be able to get back to the device
they were using before by using the 'parent' member of the aggregate
device struct.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c  | 14 +++++++++++---
 include/linux/component.h | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index f49b48695c8f..a6dd33d0ddeb 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -707,8 +707,13 @@ static void component_unbind(struct component *component,
 {
 	WARN_ON(!component->bound);
 
-	if (component->ops && component->ops->unbind)
-		component->ops->unbind(component->dev, adev->parent, data);
+	if (component->ops) {
+		if (component->ops->unbind)
+			component->ops->unbind(component->dev, adev->parent, data);
+		else if (component->ops->unbind_component)
+			component->ops->unbind_component(component->dev, adev, data);
+	}
+
 	component->bound = false;
 
 	/* Release all resources claimed in the binding of this component */
@@ -773,7 +778,10 @@ static int component_bind(struct component *component, struct aggregate_device *
 	dev_dbg(adev->parent, "binding %s (ops %ps)\n",
 		dev_name(component->dev), component->ops);
 
-	ret = component->ops->bind(component->dev, adev->parent, data);
+	if (component->ops->bind_component)
+		ret = component->ops->bind_component(component->dev, adev, data);
+	else
+		ret = component->ops->bind(component->dev, adev->parent, data);
 	if (!ret) {
 		component->bound = true;
 
diff --git a/include/linux/component.h b/include/linux/component.h
index e99cf8e910f0..d8dcbf9733da 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 
 struct component_match;
+struct aggregate_device;
 
 /**
  * struct component_ops - callbacks for component drivers
@@ -19,18 +20,39 @@ struct component_ops {
 	 *
 	 * Called through component_bind_all() when the aggregate driver is
 	 * ready to bind the overall driver.
+	 *
+	 * Deprecated: Use bind_component() instead.
 	 */
 	int (*bind)(struct device *comp, struct device *master,
 		    void *master_data);
+	/**
+	 * @bind_component:
+	 *
+	 * Called through component_bind_all() when the aggregate driver is
+	 * ready to bind the overall driver.
+	 */
+	int (*bind_component)(struct device *comp, struct aggregate_device *adev,
+			      void *aggregate_data);
 	/**
 	 * @unbind:
 	 *
 	 * Called through component_unbind_all() when the aggregate driver is
 	 * ready to bind the overall driver, or when component_bind_all() fails
 	 * part-ways through and needs to unbind some already bound components.
+	 *
+	 * Deprecated: Use unbind_component() instead.
 	 */
 	void (*unbind)(struct device *comp, struct device *master,
 		       void *master_data);
+	/**
+	 * @unbind_component:
+	 *
+	 * Called through component_unbind_all() when the aggregate driver is
+	 * ready to unbind the overall driver, or when component_bind_all() fails
+	 * part-ways through and needs to unbind some already bound components.
+	 */
+	int (*unbind_component)(struct device *comp, struct aggregate_device *adev,
+				void *aggregate_data);
 };
 
 int component_add(struct device *, const struct component_ops *);
-- 
https://chromeos.dev

