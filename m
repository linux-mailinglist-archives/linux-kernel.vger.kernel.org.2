Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11032BE84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383006AbhCCRbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbhCCNtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:49:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220BC061D7E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:12 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so23748254wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9r1GQwee06HjD/ZuKzpJIH+jsbPeQe25QbvmJPlwsC8=;
        b=VeTo2b9j29UjrFvzdkFremTLs30Tgspf+4bLewOxS6oxCoibyoixpRWImY4tDNfArA
         mXFJYt5mb1NbqG4WWSiTZlJeNQpLg13sA/LboTN7FlfiP2c3CSh2Di+mLEjuF75LfgQc
         Igq8JaCD3A+j6emMVuTYJnRlsrE3gKaWU5orKL0Bpms/5BOWs+x7+/pGrR5s1N9DomxL
         tSw0RrAKY8y6agcfGqRqwDnNDn50hjb0HwymvixPEZmaY8u1WE8tuuhpLlRIGaebK7HX
         M5Ig1I5QsPlSTMQFlaqGB16FS2QX46ORiLdi6DgyH0Fv/CG5FVCkNen9faffd4DD4Pwk
         /JgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9r1GQwee06HjD/ZuKzpJIH+jsbPeQe25QbvmJPlwsC8=;
        b=oDvFAQIXralhRRr1idJTw3cZ08O6IwXANB9Ofygt/C97oaCDnBFiDjocCBViQMOux2
         c/PnGbGOe33so0Kq8jkyxrHNKbx/vhPEtkpYgN5YuIiY9tiAz+ESt4a76j/+IHOcH5XY
         xGzJVizce74PlUq63u9maRD647ZvMVFbUa7meJ/1pctfOR4GCsAQs9B81bv0lLMrjgE0
         9Zx91me+vJFJkKlYh+XGEYoymdFjyLDdS+nWy5zNNQoJ4a8rudEkycf2AkNN+1ziQw+D
         RPU5C3Yq66f6pJxB9cjgtoG1mYB2zznfxrpjl3LoDAh4SDYfsvnr7pLZvg69qGxknc+f
         zf2A==
X-Gm-Message-State: AOAM531MgqZKYFJm1S2uuyEil+fB6NMLy9QxDdmRQkZ8aOr3QKp4m6j+
        n5rQ7j/v9rPZOCJ1+bw2Rf0s5zlX7NjyXQ==
X-Google-Smtp-Source: ABdhPJwYpxI750hNt2KrGWilNdo3e5J7cGOuMzdHBB2+G/Fw3234QX8Bqx5eq6K9fw1ZNRbdR1gfIw==
X-Received: by 2002:a5d:6042:: with SMTP id j2mr28095491wrt.336.1614779051401;
        Wed, 03 Mar 2021 05:44:11 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 36/53] drm/vmwgfx/vmwgfx_context: Demote kernel-doc abuses
Date:   Wed,  3 Mar 2021 13:43:02 +0000
Message-Id: <20210303134319.3160762-37-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:121: warning: Function parameter or member 'dev_priv' not described in 'vmw_context_cotables_unref'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:121: warning: Function parameter or member 'uctx' not described in 'vmw_context_cotables_unref'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:681: warning: Function parameter or member 'base' not described in 'vmw_user_context_base_to_res'
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c:707: warning: Function parameter or member 'p_base' not described in 'vmw_user_context_base_release'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-29-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
index 6f4d0da11ad87..4a5a3e246216d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_context.c
@@ -112,7 +112,7 @@ static const struct vmw_res_func vmw_dx_context_func = {
 	.unbind = vmw_dx_context_unbind
 };
 
-/**
+/*
  * Context management:
  */
 
@@ -672,7 +672,7 @@ static int vmw_dx_context_destroy(struct vmw_resource *res)
 	return 0;
 }
 
-/**
+/*
  * User-space context management:
  */
 
@@ -698,7 +698,7 @@ static void vmw_user_context_free(struct vmw_resource *res)
 			    vmw_user_context_size);
 }
 
-/**
+/*
  * This function is called when user space has no more references on the
  * base object. It releases the base-object's reference on the resource object.
  */
-- 
2.27.0

