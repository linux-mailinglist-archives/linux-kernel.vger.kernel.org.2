Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B962A3AB1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhFQLHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhFQLHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:07:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so3423849wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z51VYo/dwgbgXrPC5AvHEopoxeO2cRhnhIjL09//Lpc=;
        b=JZfaYlmDmNwIb9d9INbklY6CzlygTueVMT3j9Oj5Uay4WmGVHkmpBR89lFjc5Opgx/
         OVkSQ2WbPuepx9ofcsmq8XcpJJZEHoZPQzzlxO08zZZP5kVbcWiKUor5bvxV6AkMGC0k
         Id1k2QZ/FQyjZ7Xb+wJNlmJsPuyqjV9tc0V5hjt664vD1rsjzLZuuHY2xgX/zTTyiqUu
         QcEtlXz791Ascv0B8KIUv6dwQ1mbsauAMTFMjkcT/EYGKt4X7Ypo04fnZbIPHAk2JN2e
         8DxirEAt4ln+B/RBUyP8uXwQBvk3zryn6BX9SctLb7R2QdguY9CfE2e5LE/P8SEdjRli
         /G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z51VYo/dwgbgXrPC5AvHEopoxeO2cRhnhIjL09//Lpc=;
        b=RNVGf+D7ShUz/GuJgMkHgKnS9F2qOSUQsKQlFMWu3RwbzEB6YP3dNwKHnVX7d9wSn6
         xvG0+v+3gpbWWRl5GxVtK4eOHezdgNW9LgdHKBl4IXxBreuDuQR4Z99uYhiFg8muWmWO
         PZg/YAWTbKpc9NZ5txuHkFZqQMndILt/wGlI7uv+jjuD4L43rM387CqtXryt0I6ZQnUP
         dTHJWEAqPsvQaJVlBURp16R2wnoVvNO/8fmwWPQsLKWF2Z1cBf2zK3KZHUrGn2c9G/if
         hiS/YjyO990vTv3WUuJQk85D/gT43wZnS8fWQAsqa8If8BIGmRRIXImslmFrQpSvLSVa
         Alog==
X-Gm-Message-State: AOAM5330U/DCeDnW+dseQsRufbB+hpMtNBln/1cQ32khenk+L1uZKpVX
        ABeRjVw2NhaKPEO+DiV7X0Dbxg==
X-Google-Smtp-Source: ABdhPJwS49hytGMvF6UmEG3DoDMrCgisa7Dnu75J6wDRXTJC6COt0OGzRHJVxca9+kAQ7gdpEVHKCA==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr4440049wmj.68.1623927921828;
        Thu, 17 Jun 2021 04:05:21 -0700 (PDT)
Received: from dell.default ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id v18sm5249487wrb.10.2021.06.17.04.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:05:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 4/8] bus: fsl-mc: dprc: Fix a couple of misspelling and formatting issues
Date:   Thu, 17 Jun 2021 12:04:56 +0100
Message-Id: <20210617110500.15907-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617110500.15907-1-lee.jones@linaro.org>
References: <20210617110500.15907-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/dprc.c:345: warning: Function parameter or member 'attr' not described in 'dprc_get_attributes'
 drivers/bus/fsl-mc/dprc.c:521: warning: Function parameter or member 'obj_type' not described in 'dprc_get_obj_region'

Cc: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 27b0a01bad9b0..d129338b8bc08 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -334,7 +334,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @attributes	Returned container attributes
+ * @attr:	Returned container attributes
  *
  * Return:     '0' on Success; Error code otherwise.
  */
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(dprc_set_obj_irq);
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPRC object
- * @obj_type;	Object type as returned in dprc_get_obj()
+ * @obj_type:	Object type as returned in dprc_get_obj()
  * @obj_id:	Unique object instance as returned in dprc_get_obj()
  * @region_index: The specific region to query
  * @region_desc:  Returns the requested region descriptor
-- 
2.32.0

